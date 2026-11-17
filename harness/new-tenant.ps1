<#
.SYNOPSIS
  Creates a new tenant from templates\tenant, makes it its own git repository
  (if git is installed), and makes it the active tenant.

  Then, in a Claude session: fill TENANT.md, knowledge/environments.md and
  blocked-patterns.txt first; run /onboard-repo on each product repo, then
  /learn-domain.

.EXAMPLE
  .\harness\new-tenant.ps1 acme
#>
param([Parameter(Mandatory)] [ValidatePattern('^[a-z0-9][a-z0-9-]*$')] [string] $Name)

$ErrorActionPreference = 'Stop'
$hub = Split-Path $PSScriptRoot -Parent
$dest = Join-Path $hub "tenants\$Name"
if (Test-Path $dest) { throw "tenants\$Name already exists." }

Copy-Item (Join-Path $hub 'templates\tenant') $dest -Recurse
Get-ChildItem $dest -Recurse -File -Include *.md | ForEach-Object {
    $t = [IO.File]::ReadAllText($_.FullName).Replace('{{TENANT}}', $Name)
    [IO.File]::WriteAllText($_.FullName, $t, (New-Object Text.UTF8Encoding $false))
}

if (Get-Command git -ErrorAction SilentlyContinue) {
    git -C $dest init -b main | Out-Null
    "Initialised a git repository in tenants\$Name (no remote yet)."
}

& (Join-Path $PSScriptRoot 'use-tenant.ps1') $Name
