# PreToolUse hook. Blocks any shell command or browser action whose input
# matches a protected pattern. Exit code 2 blocks the tool call and returns the
# stderr text to the agent.
#
# Patterns come from the core list (.claude/hooks/blocked-patterns.txt) plus the
# blocked-patterns.txt of EVERY tenant under tenants/, not just the active one,
# so switching tenant can never lift another tenant's production block.
# If the core list is missing, everything is blocked (fail closed).

$raw = [Console]::In.ReadToEnd()
$text = $raw
try {
    $evt = $raw | ConvertFrom-Json
    if ($null -ne $evt.tool_input) {
        $text = $evt.tool_input | ConvertTo-Json -Depth 10 -Compress
    }
} catch { }

$hub = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$core = Join-Path $PSScriptRoot 'blocked-patterns.txt'
if (-not (Test-Path $core)) {
    [Console]::Error.WriteLine("BLOCKED by QA guard: the core pattern list .claude/hooks/blocked-patterns.txt is missing, so the guard cannot check this call. Restore it before continuing.")
    exit 2
}

$lists = @($core)
$tenantsDir = Join-Path $hub 'tenants'
if (Test-Path $tenantsDir) {
    $lists += @(Get-ChildItem $tenantsDir -Directory | ForEach-Object { Join-Path $_.FullName 'blocked-patterns.txt' } | Where-Object { Test-Path $_ })
}

foreach ($list in $lists) {
    $patterns = Get-Content $list | ForEach-Object { $_.Trim() } |
        Where-Object { $_ -and -not $_.StartsWith('#') }
    foreach ($p in $patterns) {
        if ($text -match $p) {
            $where = $list.Substring($hub.Length + 1)
            [Console]::Error.WriteLine("BLOCKED by QA guard: the tool input matches the protected pattern '$p' ($where). Production and destructive targets are off limits. Use an allowed environment from the tenant's knowledge/environments.md, or ask the user.")
            exit 2
        }
    }
}
exit 0
