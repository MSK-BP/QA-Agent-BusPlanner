# Dot-source this file. It parses the local credentials file and returns the
# values to the calling script. Nothing here prints a secret, and callers must
# not either.
#
# Expected file layout ("Infra Creds.txt" in the hub root):
#   <Azure DevOps personal access token on the first line>
#
#   US staging
#   URL: https://...
#   Email: ...
#   Password: ...
#   Clients: CODE1, CODE2
#
#   CA staging
#   ...
#
#   [qa1 bp-fleet]           any other system: a name in brackets, then
#   URL: https://...         URL, Host, User, Email and Password lines.
#   User: ...                harness\import-login-doc.ps1 writes these
#   Password: ...            sections from a team login document.

function Get-QaCreds {
    $root = Split-Path $PSScriptRoot -Parent
    $file = Get-ChildItem -Path $root -Filter '*Creds*.txt' -File | Select-Object -First 1
    $result = @{ Pat = $env:AZURE_DEVOPS_PAT; Envs = @{}; Systems = @{} }
    if (-not $file) { return $result }

    $current = $null
    foreach ($line in Get-Content $file.FullName) {
        $t = $line.Trim()
        if (-not $t) { continue }
        if ($t -match '^\[([^\]]+)\]$') {
            $current = @{ Url = $null; Host = $null; User = $null; Email = $null; Password = $null; Clients = @() }
            $result.Systems[$Matches[1].Trim().ToLower()] = $current
            continue
        }
        if ($t -match '^(URL|Host|User|Email|Password|Clients)\s*[:=]\s*(.*)$') {
            if ($null -eq $current) { continue }
            $key = $Matches[1]; $val = $Matches[2].Trim()
            if ($key -eq 'Clients') {
                $current.Clients = @($val -split '[,;\s]+' | Where-Object { $_ })
            } else {
                $current[$key] = $val
            }
        } elseif ($t -match '^(US|CA)\s+(staging|dev)$') {
            $name = ('{0}-{1}' -f $Matches[1], $Matches[2]).ToLower()
            $current = @{ Url = $null; Email = $null; Password = $null; Clients = @() }
            $result.Envs[$name] = $current
        } elseif ($null -eq $current -and -not $result.Pat) {
            $result.Pat = $t
        }
    }
    return $result
}
