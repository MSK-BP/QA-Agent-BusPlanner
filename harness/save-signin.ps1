<#
.SYNOPSIS
  Saves a person's sign-in for one role on one environment, so that browser test
  sessions can load it. The agent never types a password: a person signs in.

.DESCRIPTION
  Opens a fresh, isolated Chrome window on -Url. Sign in there as the role's test
  account. When the app has left its sign-in screen for 5 seconds, the sign-in
  (cookies, local storage, IndexedDB) is saved and the window closes.

  The file goes to the tenant's run folder, outside git and outside synced
  folders when a run folder is set (harness\use-tenant.ps1 -RunRoot):
    <RunRoot>\auth\<Env>-<Role>.json
  It holds session tokens: never copy it into the hub, a chat or a ticket.

  A browser session loads it with the Playwright tool browser_set_storage_state,
  so one session can switch roles, and several sessions can use the same role in
  parallel (each session has its own isolated browser).

  Sign in again when the app's session expires.

.EXAMPLE
  .\harness\save-signin.ps1 -Env us-staging -Role staging-qa -Url https://app.example-staging.com/
#>
param(
    [Parameter(Mandatory)] [ValidatePattern('^[a-z0-9][a-z0-9-]*$')] [string] $Env,
    [Parameter(Mandatory)] [ValidatePattern('^[a-z0-9][a-z0-9-]*$')] [string] $Role,
    [Parameter(Mandatory)] [string] $Url,
    [int] $TimeoutSeconds = 300
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'tenant.ps1')
$tenant = Get-QaTenant
if (-not $tenant) { throw 'No active tenant. Run harness\use-tenant.ps1 <name> first.' }
$moduleDir = Join-Path $env:LOCALAPPDATA 'qa-agent\playwright-mcp\node_modules'
if (-not (Test-Path (Join-Path $moduleDir 'playwright'))) { throw "Playwright is not installed in $moduleDir. Run harness\setup-machine.ps1." }
$node = (Get-Command node.exe -ErrorAction SilentlyContinue).Source
if (-not $node) { $node = 'C:\Program Files\nodejs\node.exe' }
$out = Join-Path $tenant.RunRoot "auth\$Env-$Role.json"

"Opening a Chrome window. Sign in there as the '$Role' test account on $Env. The window closes by itself when the sign-in is saved (time limit: $TimeoutSeconds s)."
& $node (Join-Path $PSScriptRoot 'save-signin.js') $moduleDir $Url $out $TimeoutSeconds
exit $LASTEXITCODE
