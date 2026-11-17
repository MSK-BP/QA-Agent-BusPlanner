<#
.SYNOPSIS
  Run this yourself (not the agent). Asks for your own SQL login name (stored in
  BP_QA_SQL_LOGIN), then prompts for your SQL login password with
  hidden input and stores it in a user environment variable that
  harness\sql.ps1 reads. Nothing is printed or written to the hub.

  -Env dev      -> BP_QA_SQL_PASSWORD_DEV
  -Env staging  -> BP_QA_SQL_PASSWORD_STAGING
  (no -Env)     -> BP_QA_SQL_PASSWORD, used for any server without its own

  Script execution is disabled on this machine, so run it as:
    powershell -ExecutionPolicy Bypass -File .\harness\set-sql-password.ps1 -Env dev

.EXAMPLE
  .\harness\set-sql-password.ps1 -Env dev
  .\harness\set-sql-password.ps1 -Env staging -Clear
#>
param(
    [ValidateSet('dev', 'staging')] [string] $Env,
    [switch] $Clear
)

$name = if ($Env) { "BP_QA_SQL_PASSWORD_$($Env.ToUpper())" } else { 'BP_QA_SQL_PASSWORD' }

if ($Clear) {
    [Environment]::SetEnvironmentVariable($name, $null, 'User')
    "$name removed."
    exit 0
}

$label = if ($Env) { "$Env " } else { '' }
$login = [Environment]::GetEnvironmentVariable('BP_QA_SQL_LOGIN', 'User')
if (-not $login) {
    $login = Read-Host 'Your SQL login name (from DevOps)'
    if (-not $login) { Write-Error 'No login, nothing stored.'; exit 1 }
    [Environment]::SetEnvironmentVariable('BP_QA_SQL_LOGIN', $login, 'User')
    "Stored your login in user environment variable BP_QA_SQL_LOGIN."
}
$sec = Read-Host -AsSecureString "SQL ${label}password for login $login"
$plain = [Runtime.InteropServices.Marshal]::PtrToStringBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
if (-not $plain) { Write-Error 'Empty password, nothing stored.'; exit 1 }
[Environment]::SetEnvironmentVariable($name, $plain, 'User')
$plain = $null
"Stored in user environment variable $name."
