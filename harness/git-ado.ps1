<#
.SYNOPSIS
  Run git against Azure DevOps with the QA token. The token goes to git through
  GIT_CONFIG_* environment variables for this one process only: it is never
  written to a git config file, a remote URL or the command line.

.EXAMPLE
  .\harness\git-ado.ps1 clone https://dev.azure.com/BusPlanner/Managed/_git/Apps C:\Users\skhan\Repos\Apps
  .\harness\git-ado.ps1 -C C:\Users\skhan\Repos\Apps fetch --prune

.NOTES
  Clone product repos to C:\Users\skhan\Repos\<repo>, outside OneDrive (see knowledge/access.md).
  Read-only use: QA never pushes to product repos from this helper.
#>
. (Join-Path $PSScriptRoot 'creds.ps1')
$pat = (Get-QaCreds).Pat
if (-not $pat) { Write-Error 'No token. Set AZURE_DEVOPS_PAT or put it in the credentials file.'; exit 1 }
if ($args -contains 'push') { Write-Error 'git-ado.ps1 does not push. QA does not push to product repos.'; exit 1 }

$b64 = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$pat"))
$env:GIT_CONFIG_COUNT = '1'
$env:GIT_CONFIG_KEY_0 = 'http.https://dev.azure.com/.extraheader'
$env:GIT_CONFIG_VALUE_0 = "AUTHORIZATION: Basic $b64"
$env:GCM_INTERACTIVE = 'never'
$env:GIT_TERMINAL_PROMPT = '0'
try {
    & git @args
    exit $LASTEXITCODE
} finally {
    Remove-Item Env:GIT_CONFIG_COUNT, Env:GIT_CONFIG_KEY_0, Env:GIT_CONFIG_VALUE_0, Env:GCM_INTERACTIVE -ErrorAction SilentlyContinue
}
