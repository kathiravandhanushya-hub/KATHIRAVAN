# enhance_catalog_diversity_round3.ps1
$ErrorActionPreference = "Stop"

$catalogPath = "c:\Users\ELCOT\Desktop\kathiravan\build_truly_diverse_catalog.ps1"
$content = Get-Content $catalogPath -Raw -Encoding UTF8

$imgMap = @{
    # Mobile Phones & Tech (IDs 26-50)
    26 = "https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500"
    27 = "https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=500"
    28 = "https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=500"
    29 = "https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=500"
    30 = "https://images.unsplash.com/photo-1580910051074-3eb694886505?w=500"
    31 = "https://images.unsplash.com/photo-1565849904461-04a58ad377e0?w=500"
    32 = "https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=500"
    33 = "https://images.unsplash.com/photo-1567581935884-3349723552ca?w=500"
    34 = "https://images.unsplash.com/photo-1574944985070-8f3ebc6b79d2?w=500"
    35 = "https://images.unsplash.com/photo-1512054502232-10a0a035d672?w=500"
    36 = "https://images.unsplash.com/photo-1591337676887-a217a6970a8a?w=500"
    37 = "https://images.unsplash.com/photo-1585060544812-6b45742d762f?w=500"
    38 = "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500"
    39 = "https://images.unsplash.com/photo-1533228876829-65c94e7b5025?w=500"
    40 = "https://images.unsplash.com/photo-1575695342320-d2d2d2f9b73f?w=500"
    41 = "https://images.unsplash.com/photo-1569770218135-bea267ed7e84?w=500"
    42 = "https://images.unsplash.com/photo-1556656793-08538906a9f8?w=500"
    43 = "https://images.unsplash.com/photo-1546054454-aa26e2b734c7?w=500"
    44 = "https://images.unsplash.com/photo-1589492477829-5e65395b66cc?w=500"
    45 = "https://images.unsplash.com/photo-1525598912003-663126343e1f?w=500"
    46 = "https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?w=500"
    47 = "https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=500"
    48 = "https://images.unsplash.com/photo-1565630916779-e303be97b6f5?w=500"
    49 = "https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500"
    50 = "https://images.unsplash.com/photo-1561154464-82e9adf32764?w=500"

    # Furniture & Decor (IDs 221-240)
    222 = "https://images.unsplash.com/photo-1505797149-43b0069ec26b?w=500"
    225 = "https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=500"
    227 = "https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500"
    228 = "https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc?w=500"
    231 = "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=500"
    232 = "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=500"
    233 = "https://images.unsplash.com/photo-1594980596870-8aa52a78d8cd?w=500"
    234 = "https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=500"
    236 = "https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=500"
    237 = "https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500"
    238 = "https://images.unsplash.com/photo-1600121848594-d8644e57abab?w=500"
    239 = "https://images.unsplash.com/photo-1513694203232-719a280e022f?w=500"
    240 = "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=500"

    # Baby & Kids Toys (IDs 391-410)
    394 = "https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=500"
    395 = "https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500"
    396 = "https://images.unsplash.com/photo-1608248597359-281b67fcf4b8?w=500"
    397 = "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500"
    398 = "https://images.unsplash.com/photo-1584100936595-c0654b55a2e2?w=500"
    400 = "https://images.unsplash.com/photo-1585366119957-e9730b6d0f60?w=500"
    401 = "https://images.unsplash.com/photo-1594787318286-3d835c1d207f?w=500"
    402 = "https://images.unsplash.com/photo-1558060370-d644479cb6f7?w=500"
    405 = "https://images.unsplash.com/photo-1563245372-f21724e3856d?w=500"
    406 = "https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=500"
    407 = "https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=500"
    408 = "https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?w=500"
    409 = "https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?w=500"
    410 = "https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?w=500"

    # Cameras, Drones & Optics (IDs 76-95)
    77 = "https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=500"
    78 = "https://images.unsplash.com/photo-1512790182412-b19e6d62bc39?w=500"
    81 = "https://images.unsplash.com/photo-1563861826100-9cb868fdbe1c?w=500"
    82 = "https://images.unsplash.com/photo-1517524008697-84bbe3c3fd98?w=500"
    83 = "https://images.unsplash.com/photo-1524253482453-3fed8d2fe12b?w=500"
    84 = "https://images.unsplash.com/photo-1510127031490-453be7831d6f?w=500"
    88 = "https://images.unsplash.com/photo-1617043786394-f977fa12eddf?w=500"
    89 = "https://images.unsplash.com/photo-1590602847861-f357a9332bbc?w=500"
    90 = "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500"
    92 = "https://images.unsplash.com/photo-1508739773434-c26b3d09e071?w=500"
    93 = "https://images.unsplash.com/photo-1516724562728-afc824a36e84?w=500"
    94 = "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=500"
    95 = "https://images.unsplash.com/photo-1582139329536-e7284fece509?w=500"
}

Write-Host "Applying $($imgMap.Count) round 3 image updates..."
foreach ($id in $imgMap.Keys) {
    $targetImg = $imgMap[$id]
    $pattern = '(?m)^(Add-P\s+' + $id + '\s+.*?")https://images\.unsplash\.com/[^"\r\n]+"$'
    if ($content -match $pattern) {
        $content = [regex]::Replace($content, $pattern, ('${1}' + $targetImg + '"'))
    }
}

[System.IO.File]::WriteAllText($catalogPath, $content, [System.Text.Encoding]::UTF8)
Write-Host "build_truly_diverse_catalog.ps1 updated with round 3 diversity."
