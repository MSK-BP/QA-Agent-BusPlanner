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
New-Item -ItemType Directory -Force (Join-Path $runDir 'browser'), (Join-Path $runDir 'auth') | Out-Null

# Playwright config: core defaults, plus the tenant's blocked origins and its
# run folder for screenshots. Written to .local/, which is not committed.
#
# Every Claude session gets its own isolated, in-memory browser, so sessions
# never lock each other out of a shared profile and can run in parallel.
# Sign-ins are saved per environment and role by harness\save-signin.ps1 into
# <run folder>\auth\<env>-<role>.json (outside the hub when a run folder is
# set), and a session loads one with the browser_set_storage_state tool (the
# "storage" capability). The run folder is the browser's output folder, so the
# tools can read those files and write evidence straight into runs\<run-id>\.
$cfg = [ordered]@{
    browser   = [ordered]@{
        isolated       = $true
        launchOptions  = @{ channel = 'chrome' }
        contextOptions = @{ viewport = @{ width = 1440; height = 900 } }
    }
    console   = @{ level = 'warning' }
    capabilities = @('storage')
    outputDir = $runDir
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
"Browser:           isolated per session; saved sign-ins in $(Join-Path $runDir 'auth')"
"Run folder:        $runDir"
"Restart the Claude session to load it."
