# enhance_catalog_diversity.ps1
$ErrorActionPreference = "Stop"

$catalogPath = "c:\Users\ELCOT\Desktop\kathiravan\build_truly_diverse_catalog.ps1"
$content = Get-Content $catalogPath -Raw -Encoding UTF8

Write-Host "Updating duplicate name on ID 16..."
# Replace duplicate Peter England shirt on ID 16 with Louis Philippe luxury formal shirt
$oldLine16 = 'Add-P 16 3 "UrbanStyle" "Flipkart Bestsellers" "Peter England Men Classic Fit Pure Cotton Formal Full-Sleeve Office Shirt" "Breathable wrinkle-resistant fine cotton formal shirt with semi-spread collar and mitered button cuffs." 899.00 85 4.8 280 "https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500"'
$newLine16 = 'Add-P 16 3 "UrbanStyle" "Flipkart Bestsellers" "Louis Philippe Men Slim Fit Supima Cotton Luxury Semi-Formal Shirt" "Crafted from long-staple 100% Supima cotton with a silk-soft luster and tailored Italian collar." 1499.00 60 4.8 280 "https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=500"'

if ($content.Contains($oldLine16)) {
    $content = $content.Replace($oldLine16, $newLine16)
    Write-Host "Replaced ID 16 successfully."
} else {
    Write-Host "Old line 16 not found exactly as string, checking regex..."
    $content = [regex]::Replace($content, 'Add-P 16 3 "UrbanStyle" "Flipkart Bestsellers" "Peter England[^\r\n]+', $newLine16)
}

# Image overrides map: ID -> URL
$imgMap = @{
    # Industrial & Tools
    117 = "https://images.unsplash.com/photo-1622260614153-03223fb72052?w=500"
    118 = "https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500"
    119 = "https://images.unsplash.com/photo-1572981779307-38b8cabb2407?w=500"
    120 = "https://images.unsplash.com/photo-1586864387967-d02ef85d93e8?w=500"
    121 = "https://images.unsplash.com/photo-1580901368919-89a531630b14?w=500"
    122 = "https://images.unsplash.com/photo-1586864387789-628af9feed72?w=500"
    123 = "https://images.unsplash.com/photo-1530124566582-a618bc2615dc?w=500"
    124 = "https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=500"
    125 = "https://images.unsplash.com/photo-1581092335397-9583fe92d232?w=500"
    126 = "https://images.unsplash.com/photo-1581092580497-e0d23cbdf1dc?w=500"
    127 = "https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=500"
    128 = "https://images.unsplash.com/photo-1486006920555-c77dce18193b?w=500"
    129 = "https://images.unsplash.com/photo-1508873696983-2df5703bc20d?w=500"
    130 = "https://images.unsplash.com/photo-1589939705384-5185137a7f0f?w=500"
    131 = "https://images.unsplash.com/photo-1586864387789-628af9feed72?w=500"
    132 = "https://images.unsplash.com/photo-1580901368919-89a531630b14?w=500"
    134 = "https://images.unsplash.com/photo-1572981779307-38b8cabb2407?w=500"
    135 = "https://images.unsplash.com/photo-1586864387967-d02ef85d93e8?w=500"
    138 = "https://images.unsplash.com/photo-1584634731339-252c581abfc5?w=500"
    139 = "https://images.unsplash.com/photo-1577741314755-048d8525d31e?w=500"
    140 = "https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=500"
    141 = "https://images.unsplash.com/photo-1549298916-b41d501d3772?w=500"
    142 = "https://images.unsplash.com/photo-1530124566582-a618bc2615dc?w=500"
    143 = "https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=500"
    144 = "https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500"
    145 = "https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=500"

    # Medicines & Pharmacy
    148 = "https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=500"
    149 = "https://images.unsplash.com/photo-1550572017-ed200f545dec?w=500"
    150 = "https://images.unsplash.com/photo-1471864190281-a93a3070b6de?w=500"
    151 = "https://images.unsplash.com/photo-1584515979956-d9f6e5d09982?w=500"
    153 = "https://images.unsplash.com/photo-1584515933487-779824d29309?w=500"
    155 = "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500"
    156 = "https://images.unsplash.com/photo-1556881286-fc6915169721?w=500"
    157 = "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=500"
    159 = "https://images.unsplash.com/photo-1577401239170-897942555fb3?w=500"
    163 = "https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500"
    164 = "https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=500"
    165 = "https://images.unsplash.com/photo-1608248597359-281b67fcf4b8?w=500"
    166 = "https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=500"
    167 = "https://images.unsplash.com/photo-1583947215259-38e31be8751f?w=500"
    168 = "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=500"
    169 = "https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500"
    170 = "https://images.unsplash.com/photo-1608248597359-281b67fcf4b8?w=500"
    172 = "https://images.unsplash.com/photo-1584515933487-779824d29309?w=500"
    175 = "https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=500"

    # Smart TVs, Projectors & Audio
    177 = "https://images.unsplash.com/photo-1593784991095-a205069470b6?w=500"
    178 = "https://images.unsplash.com/photo-1509281373149-e957c6296406?w=500"
    179 = "https://images.unsplash.com/photo-1461151304267-38535e780c79?w=500"
    180 = "https://images.unsplash.com/photo-1558888401-3cc1de77652d?w=500"
    182 = "https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500"
    183 = "https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?w=500"
    184 = "https://images.unsplash.com/photo-1543512214-318c7553f230?w=500"
    187 = "https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=500"
    188 = "https://images.unsplash.com/photo-1535016120720-40c646be5580?w=500"
    192 = "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500"
    193 = "https://images.unsplash.com/photo-1484704849700-f032a568e944?w=500"

    # Kitchen Appliances & Dining
    197 = "https://images.unsplash.com/photo-1585515320310-259814833e62?w=500"
    198 = "https://images.unsplash.com/photo-1544025162-d76694265947?w=500"
    199 = "https://images.unsplash.com/photo-1584992236310-6edddc08acff?w=500"
    200 = "https://images.unsplash.com/photo-1570222094114-d054a817e56b?w=500"
    201 = "https://images.unsplash.com/photo-1585515320310-259814833e62?w=500"
    202 = "https://images.unsplash.com/photo-1574269909862-7e1d70bb8078?w=500"
    203 = "https://images.unsplash.com/photo-1585837575652-267c041d77d4?w=500"
    204 = "https://images.unsplash.com/photo-1548839140-29a749e1bc4e?w=500"
    205 = "https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=500"
    206 = "https://images.unsplash.com/photo-1590794056226-79ef3a8147e1?w=500"
    207 = "https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=500"
    208 = "https://images.unsplash.com/photo-1590794056226-79ef3a8147e1?w=500"
    209 = "https://images.unsplash.com/photo-1594998893017-36147cbcae05?w=500"
    210 = "https://images.unsplash.com/photo-1517256064527-09c73fc73e38?w=500"
    211 = "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=500"
    212 = "https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500"
    214 = "https://images.unsplash.com/photo-1584473457406-6240486418e9?w=500"
    215 = "https://images.unsplash.com/photo-1589182373726-e4f658ab50f0?w=500"
    216 = "https://images.unsplash.com/photo-1610701596007-11502861dcfa?w=500"
    217 = "https://images.unsplash.com/photo-1544025162-d76694265947?w=500"
    218 = "https://images.unsplash.com/photo-1584992236310-6edddc08acff?w=500"
    219 = "https://images.unsplash.com/photo-1586985289688-ca3cf47d3e6e?w=500"

    # Footwear & Shoes
    271 = "https://images.unsplash.com/photo-1614252235316-8c857d38b5f4?w=500"
    272 = "https://images.unsplash.com/photo-1533867617858-e7b97e060509?w=500"
    273 = "https://images.unsplash.com/photo-1520639888713-7851133b1ed0?w=500"
    275 = "https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=500"
    276 = "https://images.unsplash.com/photo-1587563871167-1ee9c731aefb?w=500"
    278 = "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=500"
    279 = "https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=500"
    280 = "https://images.unsplash.com/photo-1560769629-975ec94e6a86?w=500"
    281 = "https://images.unsplash.com/photo-1562273138-f46be4ebdf33?w=500"
    282 = "https://images.unsplash.com/photo-1603808033192-082d6919d3e1?w=500"
    283 = "https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=500"
    285 = "https://images.unsplash.com/photo-1575537302964-96cd47c06b1b?w=500"
    286 = "https://images.unsplash.com/photo-1582588678413-dbf45f4823e9?w=500"
    287 = "https://images.unsplash.com/photo-1533867617858-e7b97e060509?w=500"
    288 = "https://images.unsplash.com/photo-1614252235316-8c857d38b5f4?w=500"
    289 = "https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=500"
    290 = "https://images.unsplash.com/photo-1603808033192-082d6919d3e1?w=500"
    291 = "https://images.unsplash.com/photo-1520639888713-7851133b1ed0?w=500"
    293 = "https://images.unsplash.com/photo-1552346154-21d32810aba3?w=500"
    294 = "https://images.unsplash.com/photo-1535043934128-cf0b28d52f95?w=500"
    295 = "https://images.unsplash.com/photo-1562273138-f46be4ebdf33?w=500"

    # Clothes & Fashion
    297 = "https://images.unsplash.com/photo-1542272604-780c96856592?w=500"
    298 = "https://images.unsplash.com/photo-1555689502-c4b22d76c56f?w=500"
    299 = "https://images.unsplash.com/photo-1582552938357-32b906dfca00?w=500"
    300 = "https://images.unsplash.com/photo-1581655353564-df123a1eb820?w=500"
    301 = "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=500"
    303 = "https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=500"
    304 = "https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=500"
    306 = "https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=500"
    307 = "https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500"
    308 = "https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=500"
    309 = "https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=500"
    311 = "https://images.unsplash.com/photo-1591195853828-11db59a44f6b?w=500"
    312 = "https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=500"
    313 = "https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=500"
    314 = "https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=500"
    316 = "https://images.unsplash.com/photo-1509631179647-0177331693ae?w=500"
    317 = "https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=500"
    318 = "https://images.unsplash.com/photo-1509631179647-0177331693ae?w=500"
    319 = "https://images.unsplash.com/photo-1518611012118-696072aa579a?w=500"
    320 = "https://images.unsplash.com/photo-1584100936595-c0654b55a2e2?w=500"

    # Plants & Gardening
    431 = "https://images.unsplash.com/photo-1545241047-6083a3684587?w=500"
    432 = "https://images.unsplash.com/photo-1512428813834-c702c7702b78?w=500"
    433 = "https://images.unsplash.com/photo-1509423350716-97f9360b4e09?w=500"
    434 = "https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=500"
    435 = "https://images.unsplash.com/photo-1592150621744-aca64f48394a?w=500"
    436 = "https://images.unsplash.com/photo-1534349762230-e0cadf78f5da?w=500"
    437 = "https://images.unsplash.com/photo-1502082553048-f009c37129b9?w=500"
    438 = "https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?w=500"
    439 = "https://images.unsplash.com/photo-1596547609652-9cf5d8d76921?w=500"
    440 = "https://images.unsplash.com/photo-1463936575829-25148e1db1b8?w=500"
    442 = "https://images.unsplash.com/photo-1589051039495-eb77709c8268?w=500"
    443 = "https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?w=500"
    444 = "https://images.unsplash.com/photo-1591857177580-dc82b9ac4e17?w=500"
    445 = "https://images.unsplash.com/photo-1608248597359-281b67fcf4b8?w=500"
    446 = "https://images.unsplash.com/photo-1591857177580-dc82b9ac4e17?w=500"
    448 = "https://images.unsplash.com/photo-1512428813834-c702c7702b78?w=500"
    449 = "https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?w=500"
    450 = "https://images.unsplash.com/photo-1533090161767-e6ffed986c88?w=500"

    # Automotive & Biking
    492 = "https://images.unsplash.com/photo-1544717305-2782549b5136?w=500"
    494 = "https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500"
    495 = "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500"
    496 = "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500"
    497 = "https://images.unsplash.com/photo-1507499739999-097706ad8914?w=500"
    498 = "https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=500"
    499 = "https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=500"
    501 = "https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=500"
    502 = "https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=500"
    503 = "https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=500"
    504 = "https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?w=500"
    505 = "https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=500"
    506 = "https://images.unsplash.com/photo-1525598912003-663126343e1f?w=500"
    507 = "https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=500"
    508 = "https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=500"
    509 = "https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=500"
    510 = "https://images.unsplash.com/photo-1558317374-067fb5f30001?w=500"

    # Baby & Kids Toys
    401 = "https://images.unsplash.com/photo-1585366119957-e9730b6d0f60?w=500"
    403 = "https://images.unsplash.com/photo-1594787318286-3d835c1d207f?w=500"
    404 = "https://images.unsplash.com/photo-1519689680058-324335c77eba?w=500"
    405 = "https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=500"
    406 = "https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=500"
    407 = "https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=500"
    408 = "https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?w=500"
    409 = "https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?w=500"
    410 = "https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?w=500"

    # Pet Supplies
    412 = "https://images.unsplash.com/photo-1568640347023-a616a30bc3bd?w=500"
    413 = "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=500"
    414 = "https://images.unsplash.com/photo-1573865526739-10659fec78a5?w=500"
    415 = "https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?w=500"
    416 = "https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?w=500"
    417 = "https://images.unsplash.com/photo-1576201836106-db1758fd1c97?w=500"
    418 = "https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?w=500"
    420 = "https://images.unsplash.com/photo-1608248597359-281b67fcf4b8?w=500"
    423 = "https://images.unsplash.com/photo-1589924691995-400dc9ecc119?w=500"
    426 = "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=500"
    427 = "https://images.unsplash.com/photo-1576201836106-db1758fd1c97?w=500"
    428 = "https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?w=500"
    430 = "https://images.unsplash.com/photo-1522069169874-c58ec4b76be5?w=500"

    # Watches & Travel
    512 = "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=500"
    513 = "https://images.unsplash.com/photo-1539185441755-769473a23570?w=500"
    514 = "https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=500"
    515 = "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500"
    517 = "https://images.unsplash.com/photo-1556742049-0a67c5574f73?w=500"
    519 = "https://images.unsplash.com/photo-1508296695146-257a814070b4?w=500"
    522 = "https://images.unsplash.com/photo-1565026057447-bc90a3dceb87?w=500"
    523 = "https://images.unsplash.com/photo-1546938576-6e6a64f317cc?w=500"
    524 = "https://images.unsplash.com/photo-1584100936595-c0654b55a2e2?w=500"
    525 = "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500"
    526 = "https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=500"
    527 = "https://images.unsplash.com/photo-1508057198894-247b23fe5ade?w=500"
    528 = "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500"
}

Write-Host "Applying $($imgMap.Count) image updates..."
foreach ($id in $imgMap.Keys) {
    $targetImg = $imgMap[$id]
    # Match the Add-P line for this id and replace its last argument (image URL)
    $pattern = '(?m)^(Add-P\s+' + $id + '\s+[^"\r\n]+(?:"[^"\r\n]*"\s*){4}\d+(?:\.\d+)?\s+\d+\s+\d+(?:\.\d+)?\s+\d+\s+)"[^"\r\n]+"$'
    if ($content -match $pattern) {
        $content = [regex]::Replace($content, $pattern, ('$1"' + $targetImg + '"'))
    } else {
        # Fallback simpler regex matching id and the trailing URL
        $fallbackPattern = '(?m)^(Add-P\s+' + $id + '\s+.*?")https://images\.unsplash\.com/[^"\r\n]+"$'
        $content = [regex]::Replace($content, $fallbackPattern, ('${1}' + $targetImg + '"'))
    }
}

[System.IO.File]::WriteAllText($catalogPath, $content, [System.Text.Encoding]::UTF8)
Write-Host "build_truly_diverse_catalog.ps1 updated with enhanced diversity."
