<#
.SYNOPSIS
  Signs a test account in to a BusPlanner Unified DEV or STAGING environment
  through the API and saves the result as a browser sign-in (storage state), so
  browser test sessions start signed in. No window, no typing.

.DESCRIPTION
  Reads the account for -Env from the local credentials file (harness\creds.ps1),
  calls POST /api/auth/login, and writes the session the way the web app keeps it
  (localStorage bp_* keys, client/src/auth/AuthContext.tsx) into
    <run folder>\auth\<Env>-<Role>.json
  A browser session loads it with the Playwright tool browser_set_storage_state.

  Refuses any host without a -dev- or -staging- label: production is impossible
  here, as in unified.ps1. Prints no email, password or token.

  Run it again when the session expires (expiresAt in the output).

.EXAMPLE
  .\harness\signin.ps1 -Env us-staging
  .\harness\signin.ps1 -Env ca-staging -Role staging-qa -Client ABC
#>
param(
    [Parameter(Mandatory)] [string] $Env,
    [ValidatePattern('^[a-z0-9][a-z0-9-]*$')] [string] $Role = 'staging-qa',
    [string] $Client
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'creds.ps1')
$hub = Split-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) -Parent
. (Join-Path $hub 'harness\tenant.ps1')
$tenant = Get-QaTenant
if (-not $tenant) { Write-Error 'No active tenant.'; exit 1 }

$creds = Get-QaCreds
$e = $creds.Envs[$Env.ToLower()]
if (-not $e) { Write-Error "No credentials for '$Env' in the credentials file. Known: $($creds.Envs.Keys -join ', ')"; exit 1 }

$appUri = [uri]$e.Url
if ($appUri.Host -notmatch '(?i)-(staging|dev)-') { Write-Error "Refusing: '$($appUri.Host)' is not a staging or dev host."; exit 1 }
$ProgressPreference = 'SilentlyContinue'
$api = $null
try { $api = (Invoke-RestMethod -Uri "https://$($appUri.Host)/config.json" -ErrorAction Stop).apiUrl } catch { }
if (-not $api) { $api = 'https://' + ($appUri.Host -replace '-app\.', '-api.') }
$api = $api.TrimEnd('/')
if (([uri]$api).Host -notmatch '(?i)-(staging|dev)-') { Write-Error "Refusing: API host '$(([uri]$api).Host)' is not a staging or dev host."; exit 1 }

if (-not $Client) { $Client = $e.Clients | Select-Object -First 1 }
if (-not $Client) { Write-Error 'No client code given and none in the credentials file.'; exit 1 }

try {
    $body = @{ email = $e.Email; password = $e.Password; clientCode = $Client } | ConvertTo-Json
    $r = Invoke-RestMethod -Uri "$api/api/auth/login" -Method Post -Body $body -ContentType 'application/json' -ErrorAction Stop
} catch {
    $code = $null; try { $code = [int]$_.Exception.Response.StatusCode } catch { }
    Write-Error "Login failed on $(([uri]$api).Host) for client '$Client' (HTTP $code)."
    exit 1
}
$body = $null

function J($v) { ConvertTo-Json -InputObject @($v) -Compress }
$items = @(
    @{ name = 'bp_token'; value = [string]$r.token }
    @{ name = 'bp_expiresAt'; value = [string]$r.expiresAt }
    @{ name = 'bp_email'; value = [string]$r.email }
    @{ name = 'bp_fullName'; value = [string]$r.fullName }
    @{ name = 'bp_clientCode'; value = [string]$r.clientCode }
    @{ name = 'bp_permissions'; value = (J $r.permissions) }
    @{ name = 'bp_customerAccess'; value = (J $r.customerAccess) }
    @{ name = 'bp_departmentAccess'; value = (J $r.departmentAccess) }
    @{ name = 'bp_schoolAccess'; value = (J $r.schoolAccess) }
    @{ name = 'bp_districtAccess'; value = (J $r.districtAccess) }
    @{ name = 'bp_operatorAccess'; value = (J $r.operatorAccess) }
    @{ name = 'bp_depotAccess'; value = (J $r.depotAccess) }
)
$state = [ordered]@{
    cookies = @()
    origins = @([ordered]@{ origin = "https://$($appUri.Host)"; localStorage = $items })
}
$out = Join-Path $tenant.RunRoot "auth\$($Env.ToLower())-$Role.json"
New-Item -ItemType Directory -Force (Split-Path $out) | Out-Null
[IO.File]::WriteAllText($out, ($state | ConvertTo-Json -Depth 6), (New-Object Text.UTF8Encoding $false))
$r = $null; $state = $null; $items = $null

[ordered]@{
    saved     = $out
    app       = "https://$($appUri.Host)"
    client    = $Client
    role      = $Role
    expiresAt = (Get-Content $out -Raw | ConvertFrom-Json).origins[0].localStorage | Where-Object { $_.name -eq 'bp_expiresAt' } | ForEach-Object { $_.value }
} | ConvertTo-Json
