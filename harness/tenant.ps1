# Dot-source this file. Resolves the QA hub root and the active tenant.
#
# The active tenant is the folder name under tenants/ given by, in order:
#   1. the QA_TENANT environment variable (useful for headless and CI runs)
#   2. the first line of .qa-tenant in the hub root (local, not committed)
#   3. the only folder under tenants/, if there is exactly one
#
# The tenant's run folder (RunRoot) holds output that is never committed:
# run results, headless output, browser screenshots and the audit log. By
# default it is <tenant>/reports. When the hub sits in a synced folder
# (OneDrive), point it elsewhere, in order of precedence:
#   1. the QA_RUN_ROOT environment variable
#   2. the first line of .local/run-root in the hub root (local, not committed)
# The run folder is then <that path>/<tenant name>.
# Nothing here prints anything.

function Get-QaHub {
    Split-Path $PSScriptRoot -Parent
}

function Get-QaRunBase {
    if ($env:QA_RUN_ROOT) { return $env:QA_RUN_ROOT }
    $file = Join-Path (Get-QaHub) '.local\run-root'
    if (Test-Path $file) {
        $value = [string](Get-Content $file -TotalCount 1)
        if ($value.Trim()) { return $value.Trim() }
    }
    $null
}

function Get-QaTenant {
    $hub = Get-QaHub
    $tenantsDir = Join-Path $hub 'tenants'
    $name = $env:QA_TENANT
    if (-not $name) {
        $marker = Join-Path $hub '.qa-tenant'
        if (Test-Path $marker) { $name = (Get-Content $marker -TotalCount 1).Trim() }
    }
    if (-not $name -and (Test-Path $tenantsDir)) {
        $all = @(Get-ChildItem $tenantsDir -Directory)
        if ($all.Count -eq 1) { $name = $all[0].Name }
    }
    if (-not $name) { return $null }
    $root = Join-Path $tenantsDir $name
    if (-not (Test-Path $root)) { return $null }
    $base = Get-QaRunBase
    $runRoot = if ($base) { Join-Path $base $name } else { Join-Path $root 'reports' }
    [pscustomobject]@{ Name = $name; Root = $root; Relative = "tenants/$name"; RunRoot = $runRoot }
}
