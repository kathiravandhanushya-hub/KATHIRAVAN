# enhance_catalog_diversity.ps1 - Round 2 Full Coverage
$ErrorActionPreference = "Stop"

$catalogPath = "c:\Users\ELCOT\Desktop\kathiravan\build_truly_diverse_catalog.ps1"
$content = Get-Content $catalogPath -Raw -Encoding UTF8

$imgMap = @{
    # Sports & Fitness (IDs 346-370)
    346 = "https://images.unsplash.com/photo-1546519638-68e109498ffc?w=500"
    347 = "https://images.unsplash.com/photo-1511886929837-354d827aae26?w=500"
    348 = "https://images.unsplash.com/photo-1531415074868-036b107e775a?w=500"
    349 = "https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?w=500"
    350 = "https://images.unsplash.com/photo-1595435934249-5df7ed86e1c0?w=500"
    351 = "https://images.unsplash.com/photo-1612872087720-bb876e2e67d1?w=500"
    352 = "https://images.unsplash.com/photo-1534158914592-062992fbe900?w=500"
    353 = "https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=500"
    354 = "https://images.unsplash.com/photo-1613918431703-aa6253457582?w=500"
    355 = "https://images.unsplash.com/photo-1584824486509-112e4181ff6b?w=500"
    356 = "https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=500"
    357 = "https://images.unsplash.com/photo-1518611012118-696072aa579a?w=500"
    358 = "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=500"
    359 = "https://images.unsplash.com/photo-1622560480605-d83c853bc5c3?w=500"
    360 = "https://images.unsplash.com/photo-1598971861713-54ad16a7e72e?w=500"
    361 = "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=500"
    362 = "https://images.unsplash.com/photo-1518611012118-696072aa579a?w=500"
    363 = "https://images.unsplash.com/photo-1574680096145-d05b474e2155?w=500"
    364 = "https://images.unsplash.com/photo-1584824486509-112e4181ff6b?w=500"
    365 = "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=500"
    366 = "https://images.unsplash.com/photo-1549476464-37392f717541?w=500"
    367 = "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=500"
    368 = "https://images.unsplash.com/photo-1530549387789-4c1017266635?w=500"
    369 = "https://images.unsplash.com/photo-1530549387789-4c1017266635?w=500"
    370 = "https://images.unsplash.com/photo-1587280501635-68a0e82cd5ff?w=500"

    # Cycles & Adventure (IDs 371-390)
    372 = "https://images.unsplash.com/photo-1507035895480-2b3156c31fc8?w=500"
    373 = "https://images.unsplash.com/photo-1532298229144-0ec0c57515c7?w=500"
    375 = "https://images.unsplash.com/photo-1510312305653-8ed496efae75?w=500"
    376 = "https://images.unsplash.com/photo-1517824806704-9040b037703b?w=500"
    378 = "https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?w=500"
    379 = "https://images.unsplash.com/photo-1508873696983-2df5703bc20d?w=500"
    380 = "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=500"
    382 = "https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500"
    383 = "https://images.unsplash.com/photo-1555680202-c86f0e12f086?w=500"
    384 = "https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500"
    385 = "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500"
    386 = "https://images.unsplash.com/photo-1508873696983-2df5703bc20d?w=500"
    387 = "https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?w=500"
    388 = "https://images.unsplash.com/photo-1507499739999-097706ad8914?w=500"
    389 = "https://images.unsplash.com/photo-1584100936595-c0654b55a2e2?w=500"
    390 = "https://images.unsplash.com/photo-1548839140-29a749e1bc4e?w=500"

    # Groceries & Gourmet (IDs 241-270)
    242 = "https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500"
    243 = "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500"
    244 = "https://images.unsplash.com/photo-1518110925495-5fe2fda0442c?w=500"
    245 = "https://images.unsplash.com/photo-1515543237350-b3eea1ec8082?w=500"
    246 = "https://images.unsplash.com/photo-1540420773420-3366772f4999?w=500"
    247 = "https://images.unsplash.com/photo-1515543237350-b3eea1ec8082?w=500"
    248 = "https://images.unsplash.com/photo-1540420773420-3366772f4999?w=500"
    249 = "https://images.unsplash.com/photo-1515543237350-b3eea1ec8082?w=500"
    250 = "https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=500"
    251 = "https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500"
    252 = "https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500"
    253 = "https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500"
    254 = "https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500"
    255 = "https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500"
    256 = "https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500"
    257 = "https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500"
    258 = "https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500"
    259 = "https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=500"
    260 = "https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=500"
    262 = "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500"
    263 = "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500"
    269 = "https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500"
    270 = "https://images.unsplash.com/photo-1508061252224-203a2300478a?w=500"

    # Musical Instruments (IDs 96-115)
    97 = "https://images.unsplash.com/photo-1550291652-6ea9114a47b1?w=500"
    99 = "https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=500"
    100 = "https://images.unsplash.com/photo-1507838153414-b4b713384a76?w=500"
    104 = "https://images.unsplash.com/photo-1543791187-df796fa11835?w=500"
    105 = "https://images.unsplash.com/photo-1563245372-f21724e3856d?w=500"
    107 = "https://images.unsplash.com/photo-1590602847861-f357a9332bbc?w=500"
    108 = "https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?w=500"
    110 = "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=500"
    111 = "https://images.unsplash.com/photo-1525201548942-d8732f6617a0?w=500"
    112 = "https://images.unsplash.com/photo-1516924962500-2b4b3b99ea02?w=500"
    113 = "https://images.unsplash.com/photo-1507676184212-d03ab07a01bf?w=500"
    114 = "https://images.unsplash.com/photo-1558655146-d09347e92766?w=500"
    115 = "https://images.unsplash.com/photo-1465847899084-d164df4dedc6?w=500"

    # Books & Stationery (IDs 471-490)
    473 = "https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=500"
    474 = "https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=500"
    475 = "https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=500"
    476 = "https://images.unsplash.com/photo-1457369804613-52c61a468e7d?w=500"
    477 = "https://images.unsplash.com/photo-1532012164546-f432f2e3777f?w=500"
    478 = "https://images.unsplash.com/photo-1516979187457-637abb4f9353?w=500"
    479 = "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=500"
    480 = "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=500"
    485 = "https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=500"
    486 = "https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=500"

    # Safety & Security (IDs 451-470)
    452 = "https://images.unsplash.com/photo-1504148455328-c376907d081c?w=500"
    454 = "https://images.unsplash.com/photo-1557597774-9d273605dfa9?w=500"
    456 = "https://images.unsplash.com/photo-1584438784894-089d6a62b8fa?w=500"
    458 = "https://images.unsplash.com/photo-1581092580497-e0d23cbdf1dc?w=500"
    461 = "https://images.unsplash.com/photo-1557597774-9d273605dfa9?w=500"
    462 = "https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=500"
    464 = "https://images.unsplash.com/photo-1544816155-12df9643f363?w=500"
    467 = "https://images.unsplash.com/photo-1587202372634-32705e3bf49c?w=500"
    470 = "https://images.unsplash.com/photo-1584634731339-252c581abfc5?w=500"

    # Perfumes & Beauty (IDs 321-345)
    322 = "https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?w=500"
    323 = "https://images.unsplash.com/photo-1547887537-6158d64c35b3?w=500"
    324 = "https://images.unsplash.com/photo-1588405748480-1c45af0027f3?w=500"
    325 = "https://images.unsplash.com/photo-1594035910387-fea47794261f?w=500"
    328 = "https://images.unsplash.com/photo-1588405748480-1c45af0027f3?w=500"
    337 = "https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=500"
    340 = "https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=500"
}

Write-Host "Applying $($imgMap.Count) additional image updates..."
foreach ($id in $imgMap.Keys) {
    $targetImg = $imgMap[$id]
    $pattern = '(?m)^(Add-P\s+' + $id + '\s+.*?")https://images\.unsplash\.com/[^"\r\n]+"$'
    if ($content -match $pattern) {
        $content = [regex]::Replace($content, $pattern, ('${1}' + $targetImg + '"'))
    }
}

[System.IO.File]::WriteAllText($catalogPath, $content, [System.Text.Encoding]::UTF8)
Write-Host "build_truly_diverse_catalog.ps1 updated with round 2 diversity."
