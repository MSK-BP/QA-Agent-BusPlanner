<#
.SYNOPSIS
  Read-only Azure DevOps REST helper for the QA agent. The token is taken from
  the AZURE_DEVOPS_PAT environment variable, or from the local token file, and
  is never printed.

.EXAMPLE
  .\harness\ado.ps1 git/repositories
  .\harness\ado.ps1 "build/builds?`$top=5&statusFilter=completed"
  .\harness\ado.ps1 "git/repositories/BusPlannerUnified/pullrequests?searchCriteria.status=active"
  .\harness\ado.ps1 "git/repositories/BusPlannerUnified/items?path=/README.md" -Raw
#>
param(
    [Parameter(Mandatory)] [string] $Path,
    [switch] $Raw,
    [string] $OutFile,
    [string] $Org = 'busplanner',
    [string] $Project = 'BusPlanner Unified'
)

. (Join-Path $PSScriptRoot 'creds.ps1')
$pat = (Get-QaCreds).Pat
if (-not $pat) { Write-Error 'No token. Set AZURE_DEVOPS_PAT or put it on the first line of the credentials file.'; exit 1 }

$headers = @{ Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$pat")) }
$sep = if ($Path.Contains('?')) { '&' } else { '?' }
$uri = "https://dev.azure.com/$Org/$([uri]::EscapeDataString($Project))/_apis/$Path${sep}api-version=7.1"

# GET only: this helper cannot create, change or delete anything.
try {
    if ($OutFile) {
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $uri -Headers $headers -Method Get -UseBasicParsing -OutFile $OutFile -ErrorAction Stop
        "saved $OutFile"
    } elseif ($Raw) {
        (Invoke-WebRequest -Uri $uri -Headers $headers -Method Get -UseBasicParsing -ErrorAction Stop).Content
    } else {
        Invoke-RestMethod -Uri $uri -Headers $headers -Method Get -ErrorAction Stop | ConvertTo-Json -Depth 8
    }
} catch {
    Write-Error "Azure DevOps request failed: $($_.Exception.Message)"
    exit 1
}
