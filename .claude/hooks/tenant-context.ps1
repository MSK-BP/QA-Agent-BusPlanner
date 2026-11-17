# SessionStart hook. Tells the agent which tenant is active and loads that
# tenant's TENANT.md into context. Prints plain text; never blocks.

$hub = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
. (Join-Path $hub 'harness\tenant.ps1')
$tenant = Get-QaTenant

if (-not $tenant) {
    $names = @()
    $dir = Join-Path $hub 'tenants'
    if (Test-Path $dir) { $names = @(Get-ChildItem $dir -Directory | ForEach-Object { $_.Name }) }
    "QA hub: no active tenant."
    if ($names.Count) { "Tenants present: $($names -join ', '). Ask the user which one, then run: harness\use-tenant.ps1 <name>" }
    else { "No tenants yet. Ask the user for the project name, then run: harness\new-tenant.ps1 <name>" }
    exit 0
}

"QA hub: active tenant is '$($tenant.Name)'. Tenant root: $($tenant.Relative)/"
"Wherever CLAUDE.md, a skill or an agent writes <tenant>/, it means $($tenant.Relative)/. Paths written inside the tenant's own files are relative to the tenant root."
$card = Join-Path $tenant.Root 'TENANT.md'
if (Test-Path $card) {
    ""
    Get-Content $card -Raw
}
exit 0
