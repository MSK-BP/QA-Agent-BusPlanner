<#
.SYNOPSIS
  Write helper for BusPlanner Unified DEV and STAGING: one POST, PUT, PATCH or
  DELETE per call, with guards, a ledger of every write, and cleanup.
  Signs in with the QA account from the local credentials file. Prints no email,
  password or token.

.DESCRIPTION
  Guards (they refuse, they do not warn):
  - Hosts without a -dev- or -staging- label (production is impossible here).
  - BP Info write paths (api/gpsplus/route-management): hard rule 1. A person
    does these by hand, with a named go-ahead.
  - Sign-in and password paths (api/auth, api/users/{id}/password).
  - Billable chatbot calls (api/chatbot/message*, test-case runs): hard rule 4,
    unless -Billable (use only when the user asked for that run).
  - POST: the body must contain 'QA-AUTO-' (CLAUDE.md rule 7). On dev only,
    -NoMarker allows action endpoints that create no named record.
  - PUT, PATCH, DELETE: only on a record this helper created (its id is in the
    ledger). On dev only, -ExistingRecord allows other records.
  Every write goes to <RunRoot>\writes\ledger.jsonl. -Action cleanup deletes,
  newest first, every record created on that environment and not yet deleted.

.EXAMPLE
  .\harness\api-write.ps1 -Env us-staging -Method POST -Path api/ta/holidays -Body '{"name":"QA-AUTO-holiday","date":"2027-01-04"}'
  .\harness\api-write.ps1 -Env us-staging -Method PUT -Path api/ta/holidays/<id> -BodyFile .\body.json
  .\harness\api-write.ps1 -Env us-staging -Method DELETE -Path api/ta/holidays/<id>
  .\harness\api-write.ps1 -Env us-staging -Action ledger
  .\harness\api-write.ps1 -Env us-staging -Action cleanup
#>
param(
    [Parameter(Mandatory)] [string] $Env,
    [ValidateSet('write', 'ledger', 'cleanup')] [string] $Action = 'write',
    [ValidateSet('POST', 'PUT', 'PATCH', 'DELETE')] [string] $Method,
    [string] $Path,
    [string] $Body,
    [string] $BodyFile,
    [string] $Client,
    [string] $Case,
    [switch] $NoMarker,
    [switch] $ExistingRecord,
    [switch] $Billable
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'creds.ps1')
$hub = Split-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) -Parent
. (Join-Path $hub 'harness\tenant.ps1')
$tenant = Get-QaTenant
if (-not $tenant) { Write-Error 'No active tenant.'; exit 1 }

$envName = $Env.ToLower()
$ledgerFile = Join-Path $tenant.RunRoot 'writes\ledger.jsonl'
New-Item -ItemType Directory -Force (Split-Path $ledgerFile) | Out-Null

function Read-Ledger {
    if (-not (Test-Path $ledgerFile)) { return @() }
    @(Get-Content $ledgerFile | Where-Object { $_.Trim() } | ForEach-Object { $_ | ConvertFrom-Json })
}
function Add-Ledger($entry) {
    [IO.File]::AppendAllText($ledgerFile, (($entry | ConvertTo-Json -Compress) + "`n"), (New-Object Text.UTF8Encoding $false))
}
function Get-OpenRecords {
    $all = Read-Ledger | Where-Object { $_.env -eq $envName }
    $deleted = @($all | Where-Object { $_.method -eq 'DELETE' -and $_.status -lt 300 } | ForEach-Object { $_.recordPath })
    @($all | Where-Object { $_.createdPath -and $deleted -notcontains $_.createdPath })
}

if ($Action -eq 'ledger') {
    $open = Get-OpenRecords
    [ordered]@{ ledger = $ledgerFile; env = $envName; openRecords = @($open | ForEach-Object { [ordered]@{ path = $_.createdPath; time = $_.time; case = $_.case } }) } | ConvertTo-Json -Depth 4
    exit 0
}

# --- environment guard and sign-in (as unified.ps1) ---
$creds = Get-QaCreds
$e = $creds.Envs[$envName]
if (-not $e) { Write-Error "No credentials for '$Env'. Known: $($creds.Envs.Keys -join ', ')"; exit 1 }
$appHost = ([uri]$e.Url).Host
if ($appHost -notmatch '(?i)-(staging|dev)-') { Write-Error "Refusing: '$appHost' is not a staging or dev host."; exit 1 }
$isDev = $appHost -match '(?i)-dev-'
$ProgressPreference = 'SilentlyContinue'
$api = $null
try { $api = (Invoke-RestMethod -Uri "https://$appHost/config.json" -ErrorAction Stop).apiUrl } catch { }
if (-not $api) { $api = 'https://' + ($appHost -replace '-app\.', '-api.') }
$api = $api.TrimEnd('/')
if (([uri]$api).Host -notmatch '(?i)-(staging|dev)-') { Write-Error "Refusing: API host '$(([uri]$api).Host)' is not a staging or dev host."; exit 1 }
if (-not $Client) { $Client = $e.Clients | Select-Object -First 1 }
if (-not $Client) { Write-Error 'No client code given and none in the credentials file.'; exit 1 }

function Connect-Api {
    try {
        $b = @{ email = $e.Email; password = $e.Password; clientCode = $Client } | ConvertTo-Json
        $login = Invoke-RestMethod -Uri "$api/api/auth/login" -Method Post -Body $b -ContentType 'application/json' -ErrorAction Stop
    } catch {
        $code = $null; try { $code = [int]$_.Exception.Response.StatusCode } catch { }
        Write-Error "Login failed on $(([uri]$api).Host) for client '$Client' (HTTP $code)."
        exit 1
    }
    @{ Authorization = "Bearer $($login.token)" }
}

function Invoke-Write($m, $p, $json, $headers) {
    $uri = "$api/$($p.TrimStart('/'))"
    $args2 = @{ Uri = $uri; Method = $m; Headers = $headers; UseBasicParsing = $true; ErrorAction = 'Stop' }
    if ($json) { $args2.Body = [Text.Encoding]::UTF8.GetBytes($json); $args2.ContentType = 'application/json; charset=utf-8' }
    try {
        $r = Invoke-WebRequest @args2
        return @{ status = [int]$r.StatusCode; body = $r.Content }
    } catch {
        $code = 0; try { $code = [int]$_.Exception.Response.StatusCode } catch { }
        $text = $null; if ($_.ErrorDetails) { $text = $_.ErrorDetails.Message }
        return @{ status = $code; body = $text }
    }
}

$clientTag = $Client.ToUpper()

if ($Action -eq 'cleanup') {
    $open = @(Get-OpenRecords | Where-Object { $_.client -eq $clientTag })
    [array]::Reverse($open)
    $headers = Connect-Api
    $results = foreach ($rec in $open) {
        $res = Invoke-Write 'DELETE' $rec.createdPath $null $headers
        $ok = ($res.status -ge 200 -and $res.status -lt 300) -or $res.status -eq 404
        Add-Ledger ([ordered]@{ time = (Get-Date).ToString('o'); env = $envName; client = $clientTag; case = 'cleanup'; method = 'DELETE'; path = $rec.createdPath; recordPath = $(if ($ok) { $rec.createdPath } else { $null }); status = $(if ($res.status -eq 404) { 204 } else { $res.status }) })
        [ordered]@{ path = $rec.createdPath; status = $res.status; deleted = $ok }
    }
    [ordered]@{ env = $envName; client = $clientTag; attempted = @($open).Count; results = @($results) } | ConvertTo-Json -Depth 4
    exit 0
}

# --- write guards ---
if (-not $Method -or -not $Path) { Write-Error '-Method and -Path are required.'; exit 1 }
$p = $Path.Trim().TrimStart('/')
if ($p -match '^https?:') { Write-Error 'Give -Path relative to the API (for example api/ta/holidays), not a URL.'; exit 1 }
$pl = $p.ToLower().Split('?')[0]

if ($pl -like 'api/gpsplus/route-management*') { Write-Error 'Refusing: route management writes through BP Info to real systems (environments.md hard rule 1). A person does this by hand, with a named go-ahead.'; exit 1 }
if ($pl -like 'api/auth*' -or $pl -match '^api/users/[^/]+/password') { Write-Error 'Refusing: sign-in and password paths. Use signin.ps1 for sign-in.'; exit 1 }
if (($pl -like 'api/chatbot/message*' -or $pl -match '^api/admin/chatbot/test-cases/(run-all|[^/]+/run)') -and -not $Billable) { Write-Error 'Refusing: this calls a live, billable model (hard rule 4). Add -Billable only when the user asked for this run.'; exit 1 }

if ($BodyFile) { $Body = [IO.File]::ReadAllText((Resolve-Path $BodyFile)) }
if ($Body) { try { $null = $Body | ConvertFrom-Json } catch { Write-Error 'The body is not valid JSON.'; exit 1 } }

$guid = '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}'
if ($Method -eq 'POST') {
    if (($Body -notmatch 'QA-AUTO-') -and -not ($NoMarker -and $isDev)) {
        if ($NoMarker) { Write-Error 'Refusing: -NoMarker is allowed on dev only.'; exit 1 }
        Write-Error "Refusing: a POST body must contain 'QA-AUTO-' so others can recognise test data (rule 7)."; exit 1
    }
} else {
    $owned = @(Get-OpenRecords | ForEach-Object { $_.createdPath.ToLower() })
    $target = $pl
    $mine = $owned | Where-Object { $target -eq $_ -or $target.StartsWith($_ + '/') }
    if (-not $mine) {
        if ($ExistingRecord -and $isDev) { }
        elseif ($ExistingRecord) { Write-Error 'Refusing: -ExistingRecord is allowed on dev only. On staging, change only records this helper created.'; exit 1 }
        else { Write-Error "Refusing: '$p' is not a record this helper created on $envName (see -Action ledger)."; exit 1 }
    }
}

# --- the write ---
$headers = Connect-Api
$res = Invoke-Write $Method $p $Body $headers

$createdPath = $null
if ($Method -eq 'POST' -and $res.status -ge 200 -and $res.status -lt 300 -and $res.body) {
    $id = $null
    try { $o = $res.body | ConvertFrom-Json; $id = @($o.id, $o.Id, $o.data.id) | Where-Object { $_ } | Select-Object -First 1 } catch { }
    if (-not $id -and $res.body -match "^`"?($guid)`"?$") { $id = $Matches[1] }
    if ($id) { $createdPath = ($pl.TrimEnd('/') + '/' + $id).ToLower() }
}
$recordPath = $null
if ($Method -eq 'DELETE' -and $res.status -ge 200 -and $res.status -lt 300) { $recordPath = $pl }

Add-Ledger ([ordered]@{
    time = (Get-Date).ToString('o'); env = $envName; client = $clientTag; case = $Case
    method = $Method; path = $p; status = $res.status; createdPath = $createdPath; recordPath = $recordPath
})

$parsed = $null
if ($res.body) { try { $parsed = $res.body | ConvertFrom-Json } catch { $parsed = $res.body } }
[ordered]@{
    method      = $Method
    url         = "https://$(([uri]$api).Host)/$p"
    status      = $res.status
    createdPath = $createdPath
    response    = $parsed
} | ConvertTo-Json -Depth 10
if ($res.status -ge 400 -or $res.status -eq 0) { exit 2 }
