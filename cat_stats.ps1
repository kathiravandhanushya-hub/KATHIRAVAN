$p = Get-Content preview.html -Raw
$matches = [regex]::Matches($p, 'name:\s*"([^"]+)",\s*category:\s*"([^"]+)",[\s\S]*?image:\s*"([^"]+)"')
$items = @()
foreach ($m in $matches) {
    $items += [PSCustomObject]@{
        Name = $m.Groups[1].Value
        Category = $m.Groups[2].Value
        Image = $m.Groups[3].Value
    }
}
Write-Host "Total items parsed: $($items.Count)"
$groups = $items | Group-Object Category
foreach ($g in $groups) {
    $u = ($g.Group.Image | Select-Object -Unique).Count
    Write-Host "$($g.Name) : $($g.Count) items, $u unique images"
}
