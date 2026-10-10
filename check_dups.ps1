$p = Get-Content preview.html -Raw
$prodBlock = [regex]::Match($p, '(?s)const products = \[(.*?)\n\];').Groups[1].Value
$nameMatches = [regex]::Matches($prodBlock, 'name:\s*"([^"]+)"')
$names = $nameMatches | ForEach-Object { $_.Groups[1].Value }

Write-Host "Total products in preview.html: $($names.Count)"
$dupNames = $names | Group-Object | Where-Object { $_.Count -gt 1 }
Write-Host "Duplicate names count: $($dupNames.Count)"
if ($dupNames) {
    $dupNames | Select-Object Name, Count | Format-Table -AutoSize
}

$imgMatches = [regex]::Matches($prodBlock, 'image:\s*"([^"]+)"')
$imgs = $imgMatches | ForEach-Object { $_.Groups[1].Value }
$uniqueImgs = $imgs | Select-Object -Unique
Write-Host "Unique image count: $($uniqueImgs.Count) out of $($imgs.Count)"
$dupImgs = $imgs | Group-Object | Where-Object { $_.Count -gt 1 }
Write-Host "Top repeated images:"
$dupImgs | Sort-Object Count -Descending | Select-Object -First 10 Count, Name | Format-Table -AutoSize

