<#
.SYNOPSIS
  Copies the logins from a team login document (.docx with tables) into this
  tenant's local credentials file, so nobody retypes them and no agent sees them.

.DESCRIPTION
  A person runs this script; the QA agent never reads the credentials file.
  - Reads every table in the document. A table's environment comes from the
    paragraph above it ("Dev Env" = qa1, "Stage Env" = qa2) or, for the RDP
    table, from its Notes column.
  - Writes one section per system, in the format harness\creds.ps1 reads:
        [qa1 bp-fleet]
        URL: https://...
        User: ...
        Password: ...
    RDP rows become [rdp qa1] / [rdp qa2] with Host:. A BP Unified login on
    bpu-dev-app also becomes a "CA dev" block (add its Clients: line yourself).
  - Appends only; skips a section that already exists. Refuses to write if git
    does not ignore the credentials file.
  - Prints section names and hosts only, never a user name or password.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File tenants\busplanner\harness\import-login-doc.ps1 -Path "$env:USERPROFILE\Downloads\WebsiteDetails.docx"
  (add -WhatIf to see the sections without writing)
#>
param(
    [Parameter(Mandatory)] [string] $Path,
    [switch] $WhatIf
)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem

$tenantRoot = Split-Path $PSScriptRoot -Parent
$target = Get-ChildItem -Path $tenantRoot -Filter '*Creds*.txt' -File | Select-Object -First 1
$targetPath = if ($target) { $target.FullName } else { Join-Path $tenantRoot 'Infra Creds.txt' }

# Safety: the file must be ignored by git.
Push-Location $tenantRoot
try { git check-ignore -q -- (Split-Path $targetPath -Leaf) 2>$null; $ignored = ($LASTEXITCODE -eq 0) } finally { Pop-Location }
if (-not $ignored) { Write-Error "Refusing: git does not ignore '$(Split-Path $targetPath -Leaf)'."; exit 1 }

# Read the document.
$zip = [IO.Compression.ZipFile]::OpenRead((Resolve-Path $Path))
function Read-Entry($name) { $e = $zip.GetEntry($name); if (-not $e) { return $null }; $r = New-Object IO.StreamReader($e.Open()); try { $r.ReadToEnd() } finally { $r.Close() } }
[xml]$doc = Read-Entry 'word/document.xml'
$relsText = Read-Entry 'word/_rels/document.xml.rels'
$zip.Dispose()
$links = @{}
if ($relsText) { ([xml]$relsText).Relationships.Relationship | ForEach-Object { $links[$_.Id] = $_.Target } }
$ns = New-Object Xml.XmlNamespaceManager($doc.NameTable)
$ns.AddNamespace('w', 'http://schemas.openxmlformats.org/wordprocessingml/2006/main')
$ns.AddNamespace('r', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships')

function Get-CellText($tc) { (($tc.SelectNodes('.//w:t', $ns) | ForEach-Object { $_.InnerText }) -join ' ').Trim() }
function Get-CellLink($tc) {
    $h = $tc.SelectSingleNode('.//w:hyperlink', $ns)
    if ($h) { $id = $h.GetAttribute('id', 'http://schemas.openxmlformats.org/officeDocument/2006/relationships'); if ($id -and $links[$id]) { return $links[$id] } }
    $null
}
function Get-Url([string] $text, $link) {
    if ($link -match '^https?://') { return $link }
    if ($text -match '(https?://[^\s()]+)') { return $Matches[1] }
    if ($text -match '\b([a-z0-9-]+(\.[a-z0-9-]+)+\.(com|net|org|ca)(/[^\s()]*)?)') { return 'https://' + $Matches[1] }
    $null
}
function Get-Slug([string] $s) { (($s.ToLower() -replace '\(.*?\)', '' -replace '[^a-z0-9]+', '-').Trim('-')) }

$sections = New-Object Collections.Generic.List[object]
$label = ''
foreach ($node in $doc.document.body.ChildNodes) {
    if ($node.LocalName -eq 'p') {
        $t = (($node.SelectNodes('.//w:t', $ns) | ForEach-Object { $_.InnerText }) -join '').Trim()
        if ($t) { $label = $t }
        continue
    }
    if ($node.LocalName -ne 'tbl') { continue }
    $rows = @($node.SelectNodes('w:tr', $ns))
    if ($rows.Count -lt 2) { continue }
    $head = @($rows[0].SelectNodes('w:tc', $ns) | ForEach-Object { (Get-CellText $_).ToLower() })
    $iPass = [array]::FindIndex([string[]]$head, [Predicate[string]]{ param($h) $h -like '*password*' })
    $iUser = [array]::FindIndex([string[]]$head, [Predicate[string]]{ param($h) $h -like 'user*' -or $h -like '*email*' })
    $iLink = [array]::FindIndex([string[]]$head, [Predicate[string]]{ param($h) $h -like '*link*' -or $h -like '*website*' })
    $iProd = [array]::FindIndex([string[]]$head, [Predicate[string]]{ param($h) $h -like '*product*' })
    $iNote = [array]::FindIndex([string[]]$head, [Predicate[string]]{ param($h) $h -like '*note*' })
    if ($iPass -lt 0 -or $iUser -lt 0) { continue }
    $isRdp = ($head[0] -like '*rdp*') -or ($label -match 'RDP')
    $envFromLabel = if ($label -match '(?i)dev env') { 'qa1' } elseif ($label -match '(?i)stage env') { 'qa2' } else { '' }
    foreach ($tr in $rows[1..($rows.Count - 1)]) {
        $tc = @($tr.SelectNodes('w:tc', $ns))
        $cell = { param($i) if ($i -ge 0 -and $i -lt $tc.Count) { Get-CellText $tc[$i] } else { '' } }
        $user = & $cell $iUser; $pass = & $cell $iPass
        if (-not $user -or -not $pass) { continue }
        if ($isRdp) {
            $note = & $cell $iNote
            $env = if ($note -match '(?i)dev') { 'qa1' } elseif ($note -match '(?i)stage') { 'qa2' } else { 'unknown' }
            $sections.Add([pscustomobject]@{ Name = "rdp $env"; Url = $null; Host = (& $cell 0); User = $user; Password = $pass })
        } else {
            $prod = & $cell $iProd
            $linkText = & $cell $iLink
            $url = Get-Url $linkText $(if ($iLink -ge 0 -and $iLink -lt $tc.Count) { Get-CellLink $tc[$iLink] } else { $null })
            $env = if ($envFromLabel) { $envFromLabel } else { 'unknown' }
            $sections.Add([pscustomobject]@{ Name = "$env $(Get-Slug $prod)"; Url = $url; Host = $null; User = $user; Password = $pass })
        }
    }
}

# Existing section names (headers only; values are never printed).
$existing = @{}
if (Test-Path $targetPath) {
    foreach ($line in Get-Content $targetPath) {
        $t = $line.Trim()
        if ($t -match '^\[([^\]]+)\]$') { $existing[$Matches[1].Trim().ToLower()] = 1 }
        elseif ($t -match '^(US|CA)\s+(staging|dev)$') { $existing[$t.ToLower()] = 1 }
    }
}

$out = New-Object Text.StringBuilder
$report = @()
foreach ($s in $sections) {
    if ($existing.ContainsKey($s.Name)) { $report += "skip   [$($s.Name)] (already in the file)"; continue }
    [void]$out.AppendLine(''); [void]$out.AppendLine("[$($s.Name)]")
    if ($s.Url) { [void]$out.AppendLine("URL: $($s.Url)") }
    if ($s.Host) { [void]$out.AppendLine("Host: $($s.Host)") }
    [void]$out.AppendLine("User: $($s.User)"); [void]$out.AppendLine("Password: $($s.Password)")
    $existing[$s.Name] = 1
    $where = if ($s.Url) { ([uri]$s.Url).Host } elseif ($s.Host) { $s.Host } else { '(no URL in the document)' }
    $report += "add    [$($s.Name)]  $where"
    # A BP Unified login on the CA dev app also becomes the "CA dev" block that signin.ps1 reads.
    if ($s.Url -and ([uri]$s.Url).Host -eq 'bpu-dev-app.busplannerweb.com' -and -not $existing.ContainsKey('ca dev')) {
        [void]$out.AppendLine(''); [void]$out.AppendLine('CA dev')
        [void]$out.AppendLine("URL: https://bpu-dev-app.busplannerweb.com/")
        [void]$out.AppendLine("Email: $($s.User)"); [void]$out.AppendLine("Password: $($s.Password)")
        [void]$out.AppendLine('Clients: ')
        $existing['ca dev'] = 1
        $report += "add    CA dev  bpu-dev-app.busplannerweb.com (add the client codes on its Clients: line)"
    }
}
$sections = $null

if ($WhatIf) { $report; "(WhatIf: nothing written)"; exit 0 }
if ($out.Length) { [IO.File]::AppendAllText($targetPath, $out.ToString(), (New-Object Text.UTF8Encoding $false)) }
$out = $null
$report
"Written to $(Split-Path $targetPath -Leaf). Check it, then delete the source document."
