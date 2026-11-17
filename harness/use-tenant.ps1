<#
.SYNOPSIS
  Makes a tenant the active one and regenerates the local Playwright config
  from it. Restart the Claude session afterwards so the browser and the
  tenant context pick up the change.

.PARAMETER RunRoot
  Optional. A folder outside any synced folder (OneDrive) for output that is
  never committed: runs, headless output, screenshots, the audit log. Saved in
  .local\run-root for this machine; each tenant gets a subfolder. Omit it to
  keep the saved value, or the default <tenant>\reports when none is saved.

.EXAMPLE
  .\harness\use-tenant.ps1 acme
  .\harness\use-tenant.ps1 acme -RunRoot D:\qa-runs
#>
param(
    [Parameter(Mandatory)] [string] $Name,
    [string] $RunRoot
)

$ErrorActionPreference = 'Stop'
$hub = Split-Path $PSScriptRoot -Parent
$root = Join-Path $hub "tenants\$Name"
if (-not (Test-Path $root)) { throw "No tenant folder tenants\$Name. Create it with harness\new-tenant.ps1 $Name" }

Set-Content (Join-Path $hub '.qa-tenant') $Name -Encoding ascii
$local = Join-Path $hub '.local'
New-Item -ItemType Directory -Force $local | Out-Null
if ($RunRoot) {
    Set-Content (Join-Path $local 'run-root') ([IO.Path]::GetFullPath($RunRoot)) -Encoding utf8
}
. (Join-Path $PSScriptRoot 'tenant.ps1')
$env:QA_TENANT = $Name
$runDir = (Get-QaTenant).RunRoot
Remove-Item Env:QA_TENANT
New-Item -ItemType Directory -Force (Join-Path $runDir 'browser') | Out-Null

# Playwright config: core defaults, plus the tenant's blocked origins and its
# run folder for screenshots. Written to .local/, which is not committed.
#
# The browser profile persists per tenant so the user signs in once and later
# sessions reuse it. It lives under %LOCALAPPDATA%, never in the hub: the hub
# may sit in a synced folder (OneDrive), and a profile holds session cookies
# and tokens. One profile per tenant, so no tenant ever sees another's sign-in.
# Delete the folder to sign out everywhere.
$profileDir = Join-Path $env:LOCALAPPDATA "qa-agent\browser-profiles\$Name"
New-Item -ItemType Directory -Force $profileDir | Out-Null
$cfg = [ordered]@{
    browser   = [ordered]@{
        isolated       = $false
        userDataDir    = $profileDir
        launchOptions  = @{ channel = 'chrome' }
        contextOptions = @{ viewport = @{ width = 1440; height = 900 } }
    }
    console   = @{ level = 'warning' }
    outputDir = (Join-Path $runDir 'browser')
    network   = @{ blockedOrigins = @() }
}
$tenantCfg = Join-Path $root 'playwright.json'
if (Test-Path $tenantCfg) {
    $t = Get-Content $tenantCfg -Raw | ConvertFrom-Json
    if ($t.network.blockedOrigins) { $cfg.network.blockedOrigins = @($t.network.blockedOrigins) }
    if ($t.network.allowedOrigins) { $cfg.network.allowedOrigins = @($t.network.allowedOrigins) }
}
$json =$cfg | ConvertTo-Json -Depth 6
[IO.File]::WriteAllText((Join-Path $local 'playwright.json'), $json, (New-Object Text.UTF8Encoding $false))

"Active tenant: $Name"
"Playwright config: .local\playwright.json ($($cfg.network.blockedOrigins.Count) blocked origins)"
"Browser profile:   $profileDir"
"Run folder:        $runDir"
"Restart the Claude session to load it."
