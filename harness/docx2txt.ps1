<#
.SYNOPSIS
  Extracts plain text from every .docx under a folder, with no dependencies.
  A .docx is a zip; the body is word/document.xml. Paragraphs become lines,
  table cells are separated by " | ".

.EXAMPLE
  .\harness\docx2txt.ps1 -Source tenants\acme\repos\product\docs -Dest tenants\acme\repos\product\_docx_text
#>
param(
    [Parameter(Mandatory)] [string] $Source,
    [Parameter(Mandatory)] [string] $Dest
)

Add-Type -AssemblyName System.IO.Compression.FileSystem
$src = (Resolve-Path $Source).Path
New-Item -ItemType Directory -Force $Dest | Out-Null
$dst = (Resolve-Path $Dest).Path

foreach ($f in Get-ChildItem $src -Recurse -Filter *.docx -File) {
    $rel = $f.FullName.Substring($src.Length).TrimStart('\')
    $out = Join-Path $dst ($rel -replace '\.docx$', '.txt')
    New-Item -ItemType Directory -Force (Split-Path $out -Parent) | Out-Null
    try {
        $zip = [System.IO.Compression.ZipFile]::OpenRead($f.FullName)
        $entry = $zip.GetEntry('word/document.xml')
        $reader = New-Object System.IO.StreamReader($entry.Open(), [Text.Encoding]::UTF8)
        $xml = $reader.ReadToEnd()
        $reader.Close(); $zip.Dispose()

        $xml = $xml -replace '</w:tc>', ' | '
        $xml = $xml -replace '</w:tr>', "`n"
        $xml = $xml -replace '</w:p>', "`n"
        $xml = $xml -replace '<w:tab/>', "`t"
        $xml = $xml -replace '<w:br[^>]*/>', "`n"
        $text = [System.Net.WebUtility]::HtmlDecode(($xml -replace '<[^>]+>', ''))
        $text = ($text -split "`n" | ForEach-Object { $_.TrimEnd() }) -join "`n"
        $text = [regex]::Replace($text, "`n{3,}", "`n`n")
        Set-Content -Path $out -Value $text -Encoding utf8
        '{0,7} lines  {1}' -f ($text -split "`n").Count, $rel
    } catch {
        "FAILED  $rel  ($($_.Exception.Message))"
    }
}
