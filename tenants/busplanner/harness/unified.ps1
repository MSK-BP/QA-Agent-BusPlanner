<#
.SYNOPSIS
  Signs in to a BusPlanner Unified TEST environment with the QA account from the
  local credentials file and runs one read-only request. The email, password
  and token are never printed.

.EXAMPLE
  .\harness\unified.ps1 -Env us-staging -Action envs
  .\harness\unified.ps1 -Env us-staging -Action login
  .\harness\unified.ps1 -Env ca-staging -Client ABC -Action get -Path "api/ta/pay-periods"
  .\harness\unified.ps1 -Env us-staging -Action graphql -Query "{ __typename }"
#>
param(
    [Parameter(Mandatory)] [string] $Env,
    [ValidateSet('envs', 'login', 'get', 'graphql')] [string] $Action = 'login',
    [string] $Client,
    [string] $Path,
    [string] $Query
)

. (Join-Path $PSScriptRoot 'creds.ps1')
$creds = Get-QaCreds

if ($Action -eq 'envs') {
    foreach ($k in ($creds.Envs.Keys | Sort-Object)) {
        $e = $creds.Envs[$k]
        '{0}: app={1} clients={2}' -f $k, ([uri]$e.Url).Host, ($e.Clients -join ', ')
    }
    exit 0
}

$e = $creds.Envs[$Env.ToLower()]
if (-not $e) { Write-Error "No credentials for '$Env'. Known: $($creds.Envs.Keys -join ', ')"; exit 1 }

# Test environments only. Production hosts carry neither label.
$appHost = ([uri]$e.Url).Host
if ($appHost -notmatch '(?i)-(staging|dev)-') { Write-Error "Refusing: '$appHost' is not a staging or dev host."; exit 1 }

$ProgressPreference = 'SilentlyContinue'
$api = $null
try { $api = (Invoke-RestMethod -Uri "https://$appHost/config.json" -ErrorAction Stop).apiUrl } catch { }
if (-not $api) { $api = 'https://' + ($appHost -replace '-app\.', '-api.') }
$api = $api.TrimEnd('/')
if (([uri]$api).Host -notmatch '(?i)-(staging|dev)-') { Write-Error "Refusing: API host '$(([uri]$api).Host)' is not a staging or dev host."; exit 1 }

if (-not $Client) { $Client = $e.Clients | Select-Object -First 1 }
if (-not $Client) { Write-Error 'No client code given and none in the credentials file.'; exit 1 }

try {
    $body = @{ email = $e.Email; password = $e.Password; clientCode = $Client } | ConvertTo-Json
    $login = Invoke-RestMethod -Uri "$api/api/auth/login" -Method Post -Body $body -ContentType 'application/json' -ErrorAction Stop
} catch {
    $code = $null; try { $code = [int]$_.Exception.Response.StatusCode } catch { }
    Write-Error "Login failed on $(([uri]$api).Host) for client '$Client' (HTTP $code)."
    exit 1
}
$headers = @{ Authorization = "Bearer $($login.token)" }

switch ($Action) {
    'login' {
        $wild = { param($a) if ($a -contains '*') { 'all' } else { "$(@($a).Count) listed" } }
        [ordered]@{
            api             = ([uri]$api).Host
            client          = $login.clientCode
            expiresAt       = $login.expiresAt
            permissionCount = @($login.permissions).Count
            permissions     = @($login.permissions | Sort-Object)
            customerAccess  = & $wild $login.customerAccess
            departmentAccess = & $wild $login.departmentAccess
            schoolAccess    = & $wild $login.schoolAccess
            districtAccess  = & $wild $login.districtAccess
            operatorAccess  = & $wild $login.operatorAccess
            depotAccess     = & $wild $login.depotAccess
        } | ConvertTo-Json -Depth 4
    }
    'get' {
        if (-not $Path) { Write-Error '-Path is required for get.'; exit 1 }
        try { Invoke-RestMethod -Uri "$api/$($Path.TrimStart('/'))" -Headers $headers -Method Get -ErrorAction Stop | ConvertTo-Json -Depth 8 }
        catch { $c = $null; try { $c = [int]$_.Exception.Response.StatusCode } catch { }; Write-Error "GET $Path failed (HTTP $c)."; exit 1 }
    }
    'graphql' {
        if (-not $Query) { Write-Error '-Query is required for graphql.'; exit 1 }
        if ($Query -match '(?i)^\s*mutation\b') { Write-Error 'Refusing: this helper is read-only.'; exit 1 }
        try {
            $gq = @{ query = $Query } | ConvertTo-Json
            Invoke-RestMethod -Uri "$api/graphql" -Headers $headers -Method Post -Body $gq -ContentType 'application/json' -ErrorAction Stop | ConvertTo-Json -Depth 10
        } catch { $c = $null; try { $c = [int]$_.Exception.Response.StatusCode } catch { }; Write-Error "GraphQL failed (HTTP $c)."; exit 1 }
    }
}
