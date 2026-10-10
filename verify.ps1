$p = Get-Content preview.html -Raw
# Extract only inside const products = [ ... ];
$prodBlock = [regex]::Match($p, '(?s)const products = \[(.*?)\n\];').Groups[1].Value
$prodMatches = [regex]::Matches($prodBlock, '\{\s*id:\s*(\d+)')
Write-Host "Real products in preview.html: $($prodMatches.Count)"
Write-Host "First ID: $($prodMatches[0].Groups[1].Value)"
Write-Host "Last ID: $($prodMatches[$prodMatches.Count - 1].Groups[1].Value)"

$s = Get-Content seed.sql -Raw
$sqlBlock = [regex]::Match($s, '(?s)INSERT INTO products .*? VALUES\s*(.*?);').Groups[1].Value
$sqlMatches = [regex]::Matches($sqlBlock, '\((\d+),\s*\d+,\s*''')
Write-Host "Real products in seed.sql: $($sqlMatches.Count)"
Write-Host "First ID: $($sqlMatches[0].Groups[1].Value)"
Write-Host "Last ID: $($sqlMatches[$sqlMatches.Count - 1].Groups[1].Value)"
