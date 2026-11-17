# PostToolUse hook. Appends every shell command the agent ran to audit.log in
# the active tenant's run folder (see harness/tenant.ps1; default
# <tenant>/reports), or .local/audit.log when no tenant is active, so a run can
# be reviewed afterwards. Never blocks.

try {
    $evt = [Console]::In.ReadToEnd() | ConvertFrom-Json
    $cmd = [string]$evt.tool_input.command
    if (-not $cmd) { exit 0 }
    $cmd = ($cmd -replace '\s+', ' ')
    if ($cmd.Length -gt 500) { $cmd = $cmd.Substring(0, 500) + ' ...' }

    $hub = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
    . (Join-Path $hub 'harness\tenant.ps1')
    $tenant = Get-QaTenant
    $dir = if ($tenant) { $tenant.RunRoot } else { Join-Path $hub '.local' }
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }

    $line = '{0}  {1}  {2}' -f (Get-Date -Format 's'), $evt.tool_name, $cmd
    Add-Content -Path (Join-Path $dir 'audit.log') -Value $line -Encoding utf8
} catch { }
exit 0
