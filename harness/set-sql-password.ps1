<#
.SYNOPSIS
  Run this yourself (not the agent). Prompts for your SQL login password with
  hidden input and stores it in the user environment variable
  BP_QA_SQL_PASSWORD, which harness\sql.ps1 reads. Nothing is printed or
  written to the hub.

.EXAMPLE
  .\harness\set-sql-password.ps1
  .\harness\set-sql-password.ps1 -Clear
#>
param([switch] $Clear)

if ($Clear) {
    [Environment]::SetEnvironmentVariable('BP_QA_SQL_PASSWORD', $null, 'User')
    'BP_QA_SQL_PASSWORD removed.'
    exit 0
}

$sec = Read-Host -AsSecureString 'SQL password for login sharaiz'
$plain = [Runtime.InteropServices.Marshal]::PtrToStringBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
if (-not $plain) { Write-Error 'Empty password, nothing stored.'; exit 1 }
[Environment]::SetEnvironmentVariable('BP_QA_SQL_PASSWORD', $plain, 'User')
$plain = $null
'Stored in user environment variable BP_QA_SQL_PASSWORD.'
