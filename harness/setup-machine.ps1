<#
.SYNOPSIS
  Sets up a machine for the QA agent. Run in a normal PowerShell window from
  the hub folder; accept the admin prompts.

  1. Installs the core tools: Git and Node.js LTS.
  2. Installs the Playwright browser server, pinned, outside the hub folder.
  3. Activates a tenant (the only one, or -Tenant) and runs its
     harness\setup.ps1 if it has one.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\harness\setup-machine.ps1
  powershell -ExecutionPolicy Bypass -File .\harness\setup-machine.ps1 -Tenant acme
#>
param([string] $Tenant)

$ErrorActionPreference = 'Continue'
$hub = Split-Path $PSScriptRoot -Parent
$PlaywrightMcpVersion = '0.0.83'

foreach ($p in 'Git.Git', 'OpenJS.NodeJS.LTS') {
    "--- $p"
    winget install --id $p -e --silent --disable-interactivity --accept-package-agreements --accept-source-agreements
}
$env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('Path', 'User')

# Playwright MCP lives outside the hub so node_modules is never synced or committed.
# .mcp.json runs it with node.exe directly, so it does not depend on PATH.
$pw = Join-Path $env:LOCALAPPDATA 'qa-agent\playwright-mcp'
New-Item -ItemType Directory -Force $pw | Out-Null
"--- @playwright/mcp@$PlaywrightMcpVersion -> $pw"
Push-Location $pw
& 'C:\Program Files\nodejs\npm.cmd' install --no-fund --no-audit --save-exact "@playwright/mcp@$PlaywrightMcpVersion"
Pop-Location

# Tenant
. (Join-Path $PSScriptRoot 'tenant.ps1')
if ($Tenant) { $env:QA_TENANT = $Tenant }
$t = Get-QaTenant
if ($t) {
    & (Join-Path $PSScriptRoot 'use-tenant.ps1') $t.Name
    $tenantSetup = Join-Path $t.Root 'harness\setup.ps1'
    if (Test-Path $tenantSetup) { "--- tenant setup: $($t.Name)"; & $tenantSetup }
} else {
    "--- no tenant active. Clone one into tenants\<name> or create one with harness\new-tenant.ps1 <name>, then run harness\use-tenant.ps1 <name>"
}

"--- versions"
git --version; node --version
