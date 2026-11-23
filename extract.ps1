$content = [System.IO.File]::ReadAllText("$PSScriptRoot\claude_design.html.html")
$idx1 = $content.IndexOf('<script type="__bundler/template">')
if ($idx1 -ge 0) {
    $idx1 += '<script type="__bundler/template">'.Length
    $idx2 = $content.IndexOf('</script>', $idx1)
    $json = $content.Substring($idx1, $idx2 - $idx1)
    $decoded = ConvertFrom-Json $json
    [System.IO.File]::WriteAllText("$PSScriptRoot\extracted_design.html", $decoded)
    Write-Host "Success! Extracted design length: $($decoded.Length)"
} else {
    Write-Host "Could not find template tag"
}
