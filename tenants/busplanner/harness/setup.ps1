<#
.SYNOPSIS
  BusPlanner-specific machine setup. Called by the core harness\setup-machine.ps1
  when this tenant is present; can also be run on its own.

  1. Installs the tools the BusPlanner repos and environments need.
  2. Restores Claude's memory and the build-out session from backup\claude.
#>

$ErrorActionPreference = 'Continue'
$tenant = Split-Path $PSScriptRoot -Parent
$hub = Split-Path (Split-Path $tenant -Parent) -Parent

$packages = @(
    'Microsoft.DotNet.SDK.8',                 # backend: net8.0
    'OpenJS.NodeJS.22',                       # front end: pipelines pin Node 22
    'Microsoft.SQLServerManagementStudio.22', # SQL Server access
    'OpenVPN.OpenVPNConnect'                  # CA VPN for the SQL servers
)
foreach ($p in $packages) {
    "--- $p"
    winget install --id $p -e --silent --disable-interactivity --accept-package-agreements --accept-source-agreements
}

# Claude memory and session. Claude keys its project folder by the hub path,
# so this assumes the hub is back at the same path.
$backup = Join-Path $tenant 'backup\claude'
if (Test-Path $backup) {
    $key = ($hub -replace '[:\\ ]', '-')
    $claudeDir = Join-Path $env:USERPROFILE ".claude\projects\$key"
    New-Item -ItemType Directory -Force (Join-Path $claudeDir 'memory') | Out-Null
    Copy-Item (Join-Path $backup 'memory\*') (Join-Path $claudeDir 'memory') -Force
    $session = Join-Path $backup 'session-b7bbfe32.jsonl'
    if (Test-Path $session) { Copy-Item $session (Join-Path $claudeDir 'b7bbfe32-62f6-462c-969b-d6a7a3f90a44.jsonl') -Force }
    "--- Claude memory and session restored to $claudeDir"
} else {
    "--- no backup\claude in this tenant; skipped memory restore"
}
