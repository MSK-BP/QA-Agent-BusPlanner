<#
.SYNOPSIS
  Runs one QA agent job headlessly (no chat window), for CI or a scheduled task.

.EXAMPLE
  .\harness\run-qa.ps1 -Job "/pr-qa 482" -Repo C:\src\product-api
  .\harness\run-qa.ps1 -Tenant acme -Job "/run-suite smoke qa" -Repo C:\src\product-web
  .\harness\run-qa.ps1 -Job "/triage reports/runs/latest" -ReadOnly
#>
param(
    [Parameter(Mandatory)] [string]   $Job,
    [string]   $Tenant,
    [string[]] $Repo = @(),
    [switch]   $ReadOnly,
    [int]      $MaxTurns = 80
)

$hub = Split-Path $PSScriptRoot -Parent
Set-Location $hub
. (Join-Path $PSScriptRoot 'tenant.ps1')
if ($Tenant) { $env:QA_TENANT = $Tenant }
$t = Get-QaTenant
if (-not $t) { throw 'No active tenant. Pass -Tenant <name> or run harness\use-tenant.ps1 <name>.' }

$outDir = Join-Path $t.RunRoot 'headless'
New-Item -ItemType Directory -Force $outDir | Out-Null
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$outFile = Join-Path $outDir "$stamp.json"

# Headless runs cannot answer permission prompts, so the tools are listed up front.
# ReadOnly jobs can inspect and report but cannot edit files or run commands.
$tools = if ($ReadOnly) {
    'Read,Grep,Glob,Agent,Skill'
} else {
    'Read,Grep,Glob,Agent,Skill,Edit,Write,Bash,PowerShell'
}

$cliArgs = @('-p', $Job, '--output-format', 'json', '--max-turns', $MaxTurns, '--allowedTools', $tools)
foreach ($r in $Repo) { $cliArgs += @('--add-dir', $r) }

& claude @cliArgs | Out-File -FilePath $outFile -Encoding utf8
$code = $LASTEXITCODE

try {
    $result = Get-Content $outFile -Raw | ConvertFrom-Json
    Write-Output $result.result
    if ($result.is_error) { $code = 1 }
} catch {
    Write-Output "Could not parse agent output. See $outFile"
    if ($code -eq 0) { $code = 1 }
}
exit $code
