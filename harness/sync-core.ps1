<#
.SYNOPSIS
  Keeps the core in step between a combined repository (core + one tenant)
  and the core-only repository. Copies changes as patches, never history.

.DESCRIPTION
  A combined repository holds the whole hub plus one tenant under
  tenants/<name>/. Generic changes made there also belong in the core-only
  repository, and core changes made there belong here. This script moves them
  as patches, so the two repositories share files but not commits or authors.

  -Direction Status    Shows what is waiting on each side (default).
  -Direction ToCore    Applies core changes made here to the core clone and commits there.
  -Direction FromCore  Applies changes made in the core clone here and commits here.
  -Init                Records both current heads as in step. Use once, when the
                       core files are known to be identical on both sides.

  Never copied: tenant folders (tenants/<name>/**) and .gitignore, which differs
  between the two layouts. Before ToCore, every added line and the commit message
  are checked against each tenant's blocked-patterns.txt, its folder name and its
  optional core-sync-words.txt. A match stops the sync: tenant data never reaches
  the core.

  The script commits but never pushes. Sync points are kept per machine in
  .local\core-sync.json.

.EXAMPLE
  .\harness\sync-core.ps1 -CoreRepo C:\Repos\QA-Agent -Init
  .\harness\sync-core.ps1 -CoreRepo C:\Repos\QA-Agent -Direction ToCore
#>
param(
    [Parameter(Mandatory)] [string] $CoreRepo,
    [ValidateSet('Status', 'ToCore', 'FromCore')] [string] $Direction = 'Status',
    [switch] $Init
)

$ErrorActionPreference = 'Stop'
$hub = Split-Path $PSScriptRoot -Parent
$CoreRepo = (Resolve-Path $CoreRepo).Path
$stateFile = Join-Path $hub '.local\core-sync.json'
$corePaths = @('--', '.', ':(exclude,glob)tenants/*/**', ':(exclude).gitignore')

function Invoke-Git([string] $repo) {
    $out = & git.exe -C $repo @args
    if ($LASTEXITCODE -ne 0) { throw "git -C $repo $args failed." }
    $out
}
function Head([string] $repo) { (Invoke-Git $repo rev-parse HEAD) | Select-Object -First 1 }
function Assert-Clean([string] $repo, [string] $label) {
    $dirty = Invoke-Git $repo status --porcelain @corePaths
    if ($dirty) { throw "$label has uncommitted core changes. Commit or discard them first:`n$($dirty -join "`n")" }
}

if ((Invoke-Git $CoreRepo ls-files -- 'tenants/*/*' | Where-Object { $_ })) {
    throw "$CoreRepo tracks tenant files. It must be the core-only repository."
}

if ($Init) {
    New-Item -ItemType Directory -Force (Split-Path $stateFile) | Out-Null
    @{ combined = (Head $hub); core = (Head $CoreRepo) } | ConvertTo-Json | Set-Content $stateFile -Encoding utf8
    "Recorded: combined $(Head $hub), core $(Head $CoreRepo)."
    return
}
if (-not (Test-Path $stateFile)) { throw "No sync point on this machine. Run with -Init once, when both sides have the same core files." }
$state = Get-Content $stateFile -Raw | ConvertFrom-Json

$waitingHere = @(Invoke-Git $hub log --format='%h %s' "$($state.combined)..HEAD" @corePaths | Where-Object { $_ })
$waitingCore = @(Invoke-Git $CoreRepo log --format='%h %s' "$($state.core)..HEAD" -- . ':(exclude).gitignore' | Where-Object { $_ })

if ($Direction -eq 'Status') {
    "Core changes here, not yet in the core repository: $($waitingHere.Count)"
    $waitingHere | ForEach-Object { "  $_" }
    "Changes in the core repository, not yet here: $($waitingCore.Count)"
    $waitingCore | ForEach-Object { "  $_" }
    return
}

$patchFile = Join-Path ([IO.Path]::GetTempPath()) "core-sync-$PID.patch"
$msgFile = "$patchFile.msg"
$utf8 = New-Object Text.UTF8Encoding $false
try {
    if ($Direction -eq 'ToCore') {
        if (-not $waitingHere) { 'Nothing to copy to the core repository.'; return }
        Assert-Clean $hub 'This repository'
        Assert-Clean $CoreRepo 'The core repository'
        Invoke-Git $hub diff --binary "--output=$patchFile" $state.combined HEAD @corePaths | Out-Null
        $message = "Sync core changes`n`n" + (($waitingHere | ForEach-Object { '- ' + ($_ -replace '^\S+ ', '') }) -join "`n")

        # Leak guard: added lines and the message must not carry tenant data.
        $rules = @()
        foreach ($t in Get-ChildItem (Join-Path $hub 'tenants') -Directory) {
            $rules += [regex]::Escape($t.Name)
            foreach ($f in 'blocked-patterns.txt', 'core-sync-words.txt') {
                $p = Join-Path $t.FullName $f
                if (Test-Path $p) {
                    $lines = Get-Content $p | Where-Object { $_.Trim() -and -not $_.TrimStart().StartsWith('#') }
                    if ($f -eq 'core-sync-words.txt') { $lines = $lines | ForEach-Object { [regex]::Escape($_.Trim()) } }
                    $rules += $lines
                }
            }
        }
        $added = (Get-Content $patchFile | Where-Object { $_ -match '^\+' -and $_ -notmatch '^\+\+\+ ' }) + $message
        $hits = foreach ($r in $rules) { $added | Where-Object { $_ -match "(?i)$r" } | ForEach-Object { "  [$r] $_" } }
        if ($hits) { throw "Stopped: tenant data found in the change for the core repository.`n$(($hits | Select-Object -Unique) -join "`n")" }

        Invoke-Git $CoreRepo apply --3way --whitespace=nowarn $patchFile | Out-Null
        Invoke-Git $CoreRepo add -A | Out-Null
        [IO.File]::WriteAllText($msgFile, $message, $utf8)
        Invoke-Git $CoreRepo commit -q -F $msgFile | Out-Null
        $state.combined = Head $hub
        $state.core = Head $CoreRepo
        "Committed in the core repository: $(Invoke-Git $CoreRepo log --oneline -1). Not pushed."
    }
    else {
        if (-not $waitingCore) { 'Nothing to copy from the core repository.'; return }
        Assert-Clean $hub 'This repository'
        Invoke-Git $CoreRepo diff --binary "--output=$patchFile" $state.core HEAD -- . ':(exclude).gitignore' | Out-Null
        Invoke-Git $hub apply --3way --whitespace=nowarn $patchFile | Out-Null
        Invoke-Git $hub add -A @corePaths | Out-Null
        $message = "Sync core changes`n`n" + (($waitingCore | ForEach-Object { '- ' + ($_ -replace '^\S+ ', '') }) -join "`n")
        [IO.File]::WriteAllText($msgFile, $message, $utf8)
        Invoke-Git $hub commit -q -F $msgFile | Out-Null
        $state.combined = Head $hub
        $state.core = Head $CoreRepo
        "Committed here: $(Invoke-Git $hub log --oneline -1). Not pushed."
    }
    $state | ConvertTo-Json | Set-Content $stateFile -Encoding utf8
}
finally {
    Remove-Item $patchFile, $msgFile -ErrorAction SilentlyContinue
}
