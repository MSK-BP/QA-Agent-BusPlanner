<#
.SYNOPSIS
  Read-only SQL Server helper for the Unified dev and staging servers (CA VPN).
  Server comes from this script. The SQL login comes from the user environment
  variable BP_QA_SQL_LOGIN (each person uses their own), and the password from the user
  environment variable BP_QA_SQL_PASSWORD_DEV or BP_QA_SQL_PASSWORD_STAGING,
  falling back to BP_QA_SQL_PASSWORD (set by the user with
  harness\set-sql-password.ps1). The password is never printed.

  Only SELECT / WITH queries are accepted, and each runs inside a transaction
  that is always rolled back. Production is not a choice here.

.EXAMPLE
  .\harness\sql.ps1 -Env dev -Action ping
  .\harness\sql.ps1 -Env staging -Action databases
  .\harness\sql.ps1 -Env staging -Database Client_Registry -Query "SELECT TOP 5 name FROM sys.tables"
#>
param(
    [Parameter(Mandatory)] [ValidateSet('dev', 'staging')] [string] $Env,
    [ValidateSet('ping', 'databases', 'query')] [string] $Action = 'query',
    [string] $Database = 'master',
    [string] $Query,
    [string] $Login = [Environment]::GetEnvironmentVariable('BP_QA_SQL_LOGIN', 'User'),
    [int] $MaxRows = 200
)

$servers = @{ dev = '10.50.0.4'; staging = '10.50.0.5' }
$server = $servers[$Env]

# Per-server password first (BP_QA_SQL_PASSWORD_DEV / _STAGING), then the shared one.
$pw = $null
foreach ($n in @("BP_QA_SQL_PASSWORD_$($Env.ToUpper())", 'BP_QA_SQL_PASSWORD')) {
    $pw = [Environment]::GetEnvironmentVariable($n, 'Process')
    if (-not $pw) { $pw = [Environment]::GetEnvironmentVariable($n, 'User') }
    if ($pw) { break }
}
if (-not $pw) { Write-Error "No SQL password for $Env. Run harness\set-sql-password.ps1 -Env $Env yourself."; exit 1 }

switch ($Action) {
    'ping'      { $Query = "SELECT @@SERVERNAME AS server_name, SERVERPROPERTY('ProductVersion') AS version, SERVERPROPERTY('Edition') AS edition, SUSER_SNAME() AS login_name, DB_NAME() AS current_db" }
    'databases' { $Query = "SELECT name, state_desc, create_date FROM sys.databases ORDER BY name" }
    'query'     { if (-not $Query) { Write-Error '-Query is required.'; exit 1 } }
}

# Read-only gate.
$q = $Query.Trim()
if ($q -notmatch '(?is)^(select|with)\b') { Write-Error 'Refusing: only SELECT or WITH queries.'; exit 1 }
if ($q -match '(?i)\b(insert|update|delete|merge|drop|alter|create|truncate|exec|execute|grant|revoke|deny|backup|restore|dbcc|shutdown|kill|openrowset|opendatasource|openquery|xp_\w+|sp_\w+)\b' -or $q -match '(?i)\binto\s+[#\[\w]') {
    Write-Error 'Refusing: query contains a write or server-level keyword.'; exit 1
}

$b = New-Object System.Data.SqlClient.SqlConnectionStringBuilder
$b['Data Source'] = "$server,1433"
$b['Initial Catalog'] = $Database
if (-not $Login) { Write-Error 'No SQL login. Run harness\set-sql-password.ps1 first: it stores your own login in BP_QA_SQL_LOGIN.'; exit 1 }
$b['User ID'] = $Login
$b['Password'] = $pw
$b['TrustServerCertificate'] = $true
$b['Encrypt'] = $true
$b['ApplicationIntent'] = 'ReadOnly'
$b['Application Name'] = 'QA-AUTO-agent-readonly'
$b['Connect Timeout'] = 10

$conn = New-Object System.Data.SqlClient.SqlConnection $b.ConnectionString
$pw = $null; $b = $null
try {
    $conn.Open()
    $tx = $conn.BeginTransaction()
    try {
        $cmd = $conn.CreateCommand(); $cmd.Transaction = $tx; $cmd.CommandText = $q; $cmd.CommandTimeout = 60
        $r = $cmd.ExecuteReader()
        $rows = New-Object System.Collections.Generic.List[object]
        while ($r.Read() -and $rows.Count -lt $MaxRows) {
            $o = [ordered]@{}
            for ($i = 0; $i -lt $r.FieldCount; $i++) { $o[$r.GetName($i)] = if ($r.IsDBNull($i)) { $null } else { $r.GetValue($i) } }
            $rows.Add([pscustomobject]$o)
        }
        $more = $r.Read(); $r.Close()
        $rows
        if ($more) { "(truncated at $MaxRows rows)" }
    } finally { $tx.Rollback() }
} catch {
    Write-Error "SQL on $Env ($server) failed: $($_.Exception.Message)"; exit 1
} finally { $conn.Dispose() }
