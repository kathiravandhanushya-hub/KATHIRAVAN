# Mega Catalog Generator for Kathiravan Mart (Expands catalog from 210 to 525 products)
$ErrorActionPreference = "Stop"

$items = @(
    # --- MEDICINES & PHARMACY (IDs 211-245) ---
    @{ id=211; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=35.00; stock=220; r=4.9; rev=380;
       name="Dolo 650 Paracetamol Fast Fever & Pain Relief Tablets (Strip of 15)";
       desc="Doctor trusted paracetamol 650mg tablets for fever, mild to moderate body pain, headache, and fatigue.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=212; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=32.00; stock=200; r=4.8; rev=290;
       name="Crocin 650 Advance Fast Action Paracetamol Tablets (Strip of 15)";
       desc="Fast release formula providing quick relief from fever and severe headaches.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=213; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=45.00; stock=180; r=4.9; rev=240;
       name="Saridon Headache Relief Triple Action Tablets (Strip of 10)";
       desc="Clinically proven combination of paracetamol, propyphenazone, and caffeine for instant headache relief.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=214; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=42.00; stock=190; r=4.8; rev=210;
       name="Combiflam Ibuprofen & Paracetamol Pain Relief Tablets (Strip of 20)";
       desc="Dual-action anti-inflammatory pain relief for joint stiffness, dental pain, and muscular strain.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=215; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=58.00; stock=160; r=4.8; rev=185;
       name="Cheston Cold Multi-Symptom Cold & Congestion Tablets (Strip of 10)";
       desc="Effective formula treating runny nose, sneezing, throat irritation, and sinus pressure.";
       img="https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=500" },
    @{ id=216; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=118.00; stock=140; r=4.8; rev=165;
       name="Alex Sugar-Free Cough Formula Syrup for Dry & Allergic Cough (100ml)";
       desc="Rapid relief antitussive syrup suppressing dry throat tickles and chronic chest discomfort.";
       img="https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=500" },
    @{ id=217; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=135.00; stock=150; r=4.9; rev=220;
       name="Benadryl Dry Cough Active Relief Soothing Syrup (150ml Bottle)";
       desc="Deep soothing throat syrup relieving tickling sensation and nighttime persistent cough.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=218; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=125.00; stock=130; r=4.8; rev=140;
       name="Ascoril D Plus Sugar-Free Pediatric & Adult Cough Expectorant (100ml)";
       desc="Mentholated expectorant clearing chest phlegm and easing heavy bronchial breathing.";
       img="https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=500" },
    @{ id=219; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=145.00; stock=170; r=4.8; rev=190;
       name="Gelusil Antacid & Gas Relief Liquid Suspension (Mint Flavour, 200ml)";
       desc="Fast-acting dual antacid neutralizing excess gastric acid without causing constipation.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=220; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=99.00; stock=210; r=4.9; rev=230;
       name="Digene Ultra Fizz Instant Acidity Relief Sachets (Pack of 10)";
       desc="Effervescent antacid fizz powder neutralizing burning heartburn sensation in seconds.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=221; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=110.00; stock=240; r=4.9; rev=310;
       name="Eno Regular & Lemon Dual Action Fruit Salt Antacid (100g Bottle)";
       desc="World-renowned fast acidity relief sparkling fruit salt restoring digestive balance.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=222; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=65.00; stock=250; r=4.9; rev=270;
       name="Dabur Pudin Hara Active Herbal Digestive Pearls (Pack of 30 Softgels)";
       desc="Natural mint oil cooling capsules soothing stomach ache, gas bloating, and indigestion.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=223; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=195.00; stock=150; r=4.9; rev=320;
       name="Himalaya Liv.52 DS Double Strength Liver Care Herbal Tablets (60 Tablets)";
       desc="Herbal hepatoprotective formula enhancing digestion, appetite, and natural metabolic health.";
       img="https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=500" },
    @{ id=224; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=60.00; stock=200; r=4.8; rev=280;
       name="Supradyn Daily Multivitamin Tablets with Minerals & Trace Elements (Strip of 15)";
       desc="Essential daily micronutrient boost replenishing stamina, immunity, and cellular vitality.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=225; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=48.00; stock=220; r=4.9; rev=250;
       name="Neurobion Forte Vitamin B12, B6 & B1 Nerve Nourishment Tablets (Strip of 30)";
       desc="High-potency B-complex vitamins supporting nervous system function and relieving numbness.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=226; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=42.00; stock=230; r=4.9; rev=340;
       name="Celin 500mg Chewable Pure Vitamin C Immunity Tablets (Strip of 25)";
       desc="Antioxidant rich vitamin C chewable tablets strengthening viral resistance and wound recovery.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=227; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=165.00; stock=120; r=4.8; rev=150;
       name="Zincovit Daily Multivitamin & Zinc Immunity Nutrition Syrup (200ml)";
       desc="Pediatric & adult multivitamin tonic with zinc, iodine, and lysine for growth and energy.";
       img="https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=500" },
    @{ id=228; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=145.00; stock=180; r=4.9; rev=290;
       name="Volini Maxx Instant Pain Relief Gel with Micro-Particles (75g Tube)";
       desc="Deep penetrating analgesic gel formulated with diclofenac, methyl salicylate, and menthol.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=229; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=199.00; stock=160; r=4.8; rev=210;
       name="Moov Strong Diclofenac Instant Muscle & Joint Pain Relief Spray (150ml)";
       desc="Targeted cooling spray providing quick respite from back spasm, stiff neck, and knee aches.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=230; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=135.00; stock=150; r=4.8; rev=170;
       name="Iodex Ultra Gel Diclofenac Body Pain Specialist (50g Tube)";
       desc="Fast-absorbing non-sticky transdermal gel penetrating 7 layers deep to relieve muscle pain.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=231; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=110.00; stock=190; r=4.9; rev=260;
       name="Tiger Balm Red Extra Strength Herbal Pain Relieving Ointment (21ml Glass Jar)";
       desc="Traditional herbal blend of camphor and clove oil providing warming relief for tension and joints.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=232; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=125.00; stock=140; r=4.9; rev=230;
       name="Betadine 10% First Aid Antiseptic Microbicidal Solution (100ml Bottle)";
       desc="Broad-spectrum povidone iodine surgical antiseptic solution for sterile wound disinfection.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=233; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=75.00; stock=180; r=4.8; rev=160;
       name="Burnol Antiseptic & Antimicrobial First Aid Burn Relief Cream (20g)";
       desc="Trusted burn care cream soothing irritation, preventing blister infection, and speeding tissue repair.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=234; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=65.00; stock=200; r=4.9; rev=280;
       name="Soframycin Framycetin Skin Antibacterial Healing Cream (30g)";
       desc="Topical antibiotic cream curing minor cuts, skin abrasions, infected wounds, and boils.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=235; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=85.00; stock=170; r=4.8; rev=140;
       name="Neosporin Antibiotic Triple Action First Aid Ointment (20g)";
       desc="Triple antibiotic formula reducing scarring risk while defending open scratches against bacteria.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=236; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=95.00; stock=220; r=4.9; rev=210;
       name="Hansaplast Medicated Adhesive Band-Aids Value Pack (Pack of 50 Strips)";
       desc="Durable waterproof wound tape with antiseptic silver technology for fast blister and cut healing.";
       img="https://images.unsplash.com/photo-1607613009820-a29f7bb81c04?w=500" },
    @{ id=237; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=149.00; stock=130; r=4.8; rev=120;
       name="Flamingo Elastic Hospital Grade Crepe Bandage with Clips (10cm x 4m)";
       desc="Breathable high stretch cotton compression bandage for sprained ankles, wrists, and muscle support.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=238; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=98.00; stock=175; r=4.8; rev=190;
       name="Otrivin Oxy Fast Acting 25-Second Nasal Decongestant Spray (10ml)";
       desc="Unblocks nasal passages within 25 seconds for up to 12 hours of smooth, clear nighttime breathing.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=239; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=135.00; stock=210; r=4.9; rev=260;
       name="Vicks Inhaler Pocket Nasal Clearing Sticks with Keyring (Pack of 3)";
       desc="Menthol and camphor inhalers providing refreshing airflow and easing stuffy head colds on the go.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=240; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=160.00; stock=180; r=4.9; rev=320;
       name="Vicks VapoRub Family Size Ayurvedic Vaporizing Chest Rub Balm (100g)";
       desc="Soothing vapor balm relieving cold symptoms, chest congestion, muscle stiffness, and headache.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=241; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=79.00; stock=160; r=4.7; rev=130;
       name="Strepsils Honey & Lemon Soothing Sore Throat Lozenges (Pack of 16)";
       desc="Dual antibacterial lozenges fighting throat infection and delivering continuous soothing comfort.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=242; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=149.00; stock=150; r=4.8; rev=175;
       name="Cipla Cofsils DX Cough Syrup for Chest Mucus Relief (100ml)";
       desc="Non-drowsy bronchial formula clearing stubborn mucus and soothing inflamed vocal cords.";
       img="https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=500" },
    @{ id=243; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=185.00; stock=140; r=4.9; rev=210;
       name="Dabur Chyawanprash 2X Immunity 40+ Ayurvedic Herbs Paste (500g Jar)";
       desc="Time-tested amla and herbal formulation boosting respiratory stamina, vitality, and infection immunity.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },
    @{ id=244; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=110.00; stock=190; r=4.8; rev=165;
       name="Zandu Balm Fast Action Ayurvedic Pain & Headache Ointment (50g)";
       desc="Ayurvedic balm formulated with gaultheria oil and menthol for fast relief from stress headaches.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=245; sId=1; sName="KathiravanMart"; cat="Medicines & Pharmacy"; price=249.00; stock=120; r=4.8; rev=145;
       name="Revital H Daily Health Supplement Capsules with Ginseng & Minerals (30 Caps)";
       desc="Energy booster capsule infused with natural ginseng, 10 vitamins, and 9 minerals for active vitality.";
       img="https://images.unsplash.com/photo-1584017911766-d451b3d0e843?w=500" },

    # --- MOBILE PHONES, TABLETS & TECH (IDs 246-280) ---
    @{ id=246; sId=2; sName="TechNova"; cat="Mobile Phones"; price=134999.00; stock=15; r=4.9; rev=450;
       name="Apple iPhone 15 Pro Max (256GB Natural Titanium, A17 Pro Chip)";
       desc="Aerospace titanium design, 5x optical telephoto camera, Action button, USB-C 3.0, and super retina XDR.";
       img="https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=500" },
    @{ id=247; sId=2; sName="TechNova"; cat="Mobile Phones"; price=71999.00; stock=25; r=4.9; rev=390;
       name="Apple iPhone 15 (128GB Blue, Dynamic Island, 48MP Main Camera)";
       desc="Color-infused back glass, Dynamic Island notifications, A16 Bionic chip, and all-day battery life.";
       img="https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=500" },
    @{ id=248; sId=2; sName="TechNova"; cat="Mobile Phones"; price=58999.00; stock=30; r=4.8; rev=520;
       name="Apple iPhone 14 (128GB Midnight, Super Retina OLED, Crash Detection)";
       desc="Advanced dual camera system with Photonic Engine, cinematic 4K video, and ceramic shield glass.";
       img="https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=500" },
    @{ id=249; sId=2; sName="TechNova"; cat="Mobile Phones"; price=129999.00; stock=18; r=4.9; rev=410;
       name="Samsung Galaxy S24 Ultra 5G (12GB RAM, 256GB Titanium Gray with S-Pen)";
       desc="Galaxy AI features, Snapdragon 8 Gen 3 for Galaxy, 200MP quad camera, and flat Armor Aluminum frame.";
       img="https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=500" },
    @{ id=250; sId=2; sName="TechNova"; cat="Mobile Phones"; price=42999.00; stock=35; r=4.8; rev=280;
       name="Samsung Galaxy S23 FE 5G (8GB RAM, 128GB Mint Green, 50MP Pro Camera)";
       desc="Dynamic AMOLED 2X 120Hz display, flagship grade nightography, and IP68 dust/water protection.";
       img="https://images.unsplash.com/photo-1580910051074-3eb694886505?w=500" },
    @{ id=251; sId=2; sName="TechNova"; cat="Mobile Phones"; price=36999.00; stock=40; r=4.7; rev=210;
       name="Samsung Galaxy A55 5G (8GB RAM, 128GB Awesome Navy Metal Frame)";
       desc="Gorilla Glass Victus+ front/back, Exynos 1480 processor, 5000mAh battery, and Knox Vault security.";
       img="https://images.unsplash.com/photo-1580910051074-3eb694886505?w=500" },
    @{ id=252; sId=2; sName="TechNova"; cat="Mobile Phones"; price=14999.00; stock=65; r=4.8; rev=340;
       name="Samsung Galaxy M34 5G (6GB RAM, 128GB Prism Silver, 6000mAh Battery)";
       desc="Massive 6000mAh battery, 50MP No Shake OIS camera, and 120Hz Super AMOLED FHD+ screen.";
       img="https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=500" },
    @{ id=253; sId=2; sName="TechNova"; cat="Mobile Phones"; price=64999.00; stock=22; r=4.9; rev=310;
       name="OnePlus 12 5G (16GB RAM, 512GB Flowy Emerald, Snapdragon 8 Gen 3)";
       desc="4th Gen Hasselblad Camera for Mobile, 2K 120Hz ProXDR display, and 100W SuperVOOC rapid charging.";
       img="https://images.unsplash.com/photo-1567581935884-3349723552ca?w=500" },
    @{ id=254; sId=2; sName="TechNova"; cat="Mobile Phones"; price=39999.00; stock=45; r=4.8; rev=295;
       name="OnePlus 12R 5G (8GB RAM, 128GB Cool Blue, 5500mAh Battery)";
       desc="Snapdragon 8 Gen 2 gaming powerhouse, 4th Gen LTPO 120Hz display, and dual vapor chamber cooling.";
       img="https://images.unsplash.com/photo-1567581935884-3349723552ca?w=500" },
    @{ id=255; sId=2; sName="TechNova"; cat="Mobile Phones"; price=24999.00; stock=55; r=4.8; rev=260;
       name="OnePlus Nord CE4 5G (8GB RAM, 128GB Celadon Marble, 100W Charging)";
       desc="Snapdragon 7 Gen 3 performance, Aqua Touch display, expandable 1TB storage, and 50MP Sony LYT-600.";
       img="https://images.unsplash.com/photo-1567581935884-3349723552ca?w=500" },
    @{ id=256; sId=2; sName="TechNova"; cat="Mobile Phones"; price=89999.00; stock=16; r=4.9; rev=270;
       name="Google Pixel 8 Pro 5G (12GB RAM, 128GB Obsidian, Google Tensor G3)";
       desc="Pro camera controls with Best Take, Magic Editor, thermometer sensor, and 7 years of OS updates.";
       img="https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=500" },
    @{ id=257; sId=2; sName="TechNova"; cat="Mobile Phones"; price=35999.00; stock=35; r=4.8; rev=230;
       name="Google Pixel 7a 5G (8GB RAM, 128GB Sea Blue, Titan M2 Security)";
       desc="Google Tensor G2 powerhouse with 64MP dual rear cameras, wireless charging, and clean Pixel UI.";
       img="https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=500" },
    @{ id=258; sId=2; sName="TechNova"; cat="Mobile Phones"; price=29999.00; stock=50; r=4.8; rev=320;
       name="Xiaomi Redmi Note 13 Pro+ 5G (8GB RAM, 256GB Fusion Purple, 200MP OIS)";
       desc="Curved 1.5K 120Hz AMOLED, MediaTek Dimensity 7200-Ultra, IP68 water resistance, and 120W HyperCharge.";
       img="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500" },
    @{ id=259; sId=2; sName="TechNova"; cat="Mobile Phones"; price=10999.00; stock=75; r=4.7; rev=290;
       name="Xiaomi Redmi 13C 5G (4GB RAM, 128GB Starlight Black, 90Hz Display)";
       desc="Budget 5G champion with 50MP AI dual camera, MediaTek Dimensity 6100+, and fast side fingerprint.";
       img="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500" },
    @{ id=260; sId=2; sName="TechNova"; cat="Mobile Phones"; price=29999.00; stock=40; r=4.8; rev=240;
       name="Realme 12 Pro+ 5G (8GB RAM, 256GB Submarine Blue, Periscope Lens)";
       desc="Luxury watch design by Ollivier Saveo, 64MP periscope portrait camera, and 120Hz curved vision OLED.";
       img="https://images.unsplash.com/photo-1580910051074-3eb694886505?w=500" },
    @{ id=261; sId=2; sName="TechNova"; cat="Mobile Phones"; price=12499.00; stock=65; r=4.7; rev=210;
       name="Realme Narzo 60x 5G (6GB RAM, 128GB Stellar Green, 33W Fast Charge)";
       desc="Ultra slim 7.89mm design with 50MP AI primary camera, dynamic RAM expansion, and 5000mAh battery.";
       img="https://images.unsplash.com/photo-1580910051074-3eb694886505?w=500" },
    @{ id=262; sId=2; sName="TechNova"; cat="Mobile Phones"; price=31999.00; stock=35; r=4.8; rev=220;
       name="Motorola Edge 50 Pro 5G (8GB RAM, 256GB Luxe Lavender, Pantone Validated)";
       desc="World-first Pantone validated camera & display, Snapdragon 7 Gen 3, and 125W TurboPower charging.";
       img="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500" },
    @{ id=263; sId=2; sName="TechNova"; cat="Mobile Phones"; price=17999.00; stock=50; r=4.8; rev=275;
       name="Moto G84 5G (12GB RAM, 256GB Viva Magenta Vegan Leather, 50MP OIS)";
       desc="Ultra-light vegan leather back, 10-bit billion color 120Hz pOLED screen, and Dolby Atmos dual speakers.";
       img="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500" },
    @{ id=264; sId=2; sName="TechNova"; cat="Mobile Phones"; price=41999.00; stock=30; r=4.8; rev=190;
       name="Vivo V30 Pro 5G (12GB RAM, 512GB Andaman Blue, ZEISS Co-Engineered)";
       desc="Triple 50MP ZEISS camera system with Studio Quality Smart Aura Light portrait flash.";
       img="https://images.unsplash.com/photo-1580910051074-3eb694886505?w=500" },
    @{ id=265; sId=2; sName="TechNova"; cat="Mobile Phones"; price=19999.00; stock=45; r=4.7; rev=230;
       name="Vivo T3 5G (8GB RAM, 128GB Crystal Flake, Sony IMX882 OIS Camera)";
       desc="Fastest processor in the segment MediaTek Dimensity 7200 with dual stereo sound and 4K recording.";
       img="https://images.unsplash.com/photo-1580910051074-3eb694886505?w=500" },
    @{ id=266; sId=2; sName="TechNova"; cat="Mobile Phones"; price=34999.00; stock=35; r=4.9; rev=260;
       name="iQOO Neo 9 Pro 5G (8GB RAM, 128GB Fiery Red Dual Tone, Snapdragon 8 Gen 2)";
       desc="Dedicated Q1 supercomputing gaming chip, 144Hz AMOLED screen, and 120W flash charge.";
       img="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500" },
    @{ id=267; sId=2; sName="TechNova"; cat="Mobile Phones"; price=17999.00; stock=50; r=4.8; rev=210;
       name="iQOO Z9 5G (8GB RAM, 128GB Brushed Green, Dimensity 7200 Processor)";
       desc="Slim 7.83mm stylish design, 50MP Sony OIS camera, 44W flash charge, and ultra game mode.";
       img="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500" },
    @{ id=268; sId=2; sName="TechNova"; cat="Mobile Phones"; price=26999.00; stock=40; r=4.8; rev=245;
       name="POCO X6 Pro 5G (8GB RAM, 256GB Racing Yellow, Dimensity 8300-Ultra)";
       desc="Flagship Dimensity 8300-Ultra chip, 1.5K Flow AMOLED with 1800 nits, and WildBoost gaming 2.0.";
       img="https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=500" },
    @{ id=269; sId=2; sName="TechNova"; cat="Mobile Phones"; price=12999.00; stock=60; r=4.7; rev=220;
       name="POCO M6 Pro 5G (6GB RAM, 128GB Forest Green, Snapdragon 4 Gen 2)";
       desc="Premium glass back design, large 6.79-inch FHD+ 90Hz adaptive display, and 5000mAh battery.";
       img="https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=500" },
    @{ id=270; sId=2; sName="TechNova"; cat="Mobile Phones"; price=23999.00; stock=45; r=4.9; rev=330;
       name="Nothing Phone (2a) 5G (8GB RAM, 128GB Black, Glyph Interface Light)";
       desc="Iconic transparent casing with custom glyph LEDs, Dimensity 7200 Pro, and clean Nothing OS 2.5.";
       img="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500" },
    @{ id=271; sId=2; sName="TechNova"; cat="Mobile Phones"; price=32999.00; stock=30; r=4.9; rev=290;
       name="Apple iPad 10th Gen 10.9-Inch (64GB Wi-Fi Silver, Liquid Retina Display)";
       desc="A14 Bionic chip, landscape 12MP Ultra Wide front camera, USB-C, and Touch ID power button.";
       img="https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500" },
    @{ id=272; sId=2; sName="TechNova"; cat="Mobile Phones"; price=59999.00; stock=20; r=4.9; rev=180;
       name="Apple iPad Air 11-Inch M2 Chip (128GB Wi-Fi Space Gray)";
       desc="Blazing fast Apple M2 processor, P3 wide color Liquid Retina display, and Apple Pencil Pro support.";
       img="https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500" },
    @{ id=273; sId=2; sName="TechNova"; cat="Mobile Phones"; price=34999.00; stock=25; r=4.8; rev=170;
       name="Samsung Galaxy Tab S9 FE (6GB RAM, 128GB Wi-Fi Gray with Included S-Pen)";
       desc="10.9-inch 90Hz display, IP68 water resistance, included precision stylus pen, and 8000mAh battery.";
       img="https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500" },
    @{ id=274; sId=2; sName="TechNova"; cat="Mobile Phones"; price=14999.00; stock=40; r=4.7; rev=150;
       name="Lenovo Tab M11 11-Inch WUXGA Tablet (4GB RAM, 128GB with Pen & Case)";
       desc="Quad speakers with Dolby Atmos, Octa-Core Helio G88, Lenovo Tab Pen included for study and sketches.";
       img="https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500" },
    @{ id=275; sId=2; sName="TechNova"; cat="Mobile Phones"; price=19999.00; stock=35; r=4.8; rev=160;
       name="OnePlus Pad Go 11.35-Inch 2.4K Eye-Care Tablet (8GB RAM, 128GB Wi-Fi)";
       desc="ReadFit 7:5 aspect ratio screen, Omnibearing quad speakers, and massive 8000mAh battery with 33W charge.";
       img="https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500" },
    @{ id=276; sId=2; sName="TechNova"; cat="Mobile Phones"; price=1699.00; stock=110; r=4.9; rev=420;
       name="Apple Original 20W USB-C Fast Power Adapter for iPhone & iPad";
       desc="Official Apple compact adapter delivering fast charging from 0% to 50% in 30 minutes.";
       img="https://images.unsplash.com/photo-1583863788434-e58a36330cf0?w=500" },
    @{ id=277; sId=2; sName="TechNova"; cat="Mobile Phones"; price=1499.00; stock=90; r=4.8; rev=210;
       name="Anker Nano 30W GaN Ultra-Compact Fast Wall Charger (Type-C)";
       desc="Gallium Nitride high efficiency power cube charging phones, tablets, and MacBooks safely.";
       img="https://images.unsplash.com/photo-1583863788434-e58a36330cf0?w=500" },
    @{ id=278; sId=2; sName="TechNova"; cat="Mobile Phones"; price=1299.00; stock=100; r=4.8; rev=230;
       name="Mi 67W SonicCharge 3.0 Ultra-Fast Wall Charger with 6A Type-C Cable";
       desc="Qualcomm Quick Charge 3.0 certified high-wattage adapter with multi-layer surge protection.";
       img="https://images.unsplash.com/photo-1583863788434-e58a36330cf0?w=500" },
    @{ id=279; sId=2; sName="TechNova"; cat="Mobile Phones"; price=1299.00; stock=75; r=4.9; rev=180;
       name="Spigen Tough Armor Heavy Duty Shockproof Case for iPhone 15";
       desc="Air Cushion technology with built-in kickstand, raised bezels, and dual-layer drop protection.";
       img="https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?w=500" },
    @{ id=280; sId=2; sName="TechNova"; cat="Mobile Phones"; price=699.00; stock=130; r=4.8; rev=240;
       name="ESR Tempered Glass Screen Protector with Auto-Alignment Frame (Pack of 2)";
       desc="9H military grade tempered glass with oleophobic anti-fingerprint coating and bubble-free installer.";
       img="https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?w=500" },

    # --- FLIPKART & AMAZON BESTSELLERS (IDs 281-320) ---
    @{ id=281; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=1299.00; stock=110; r=4.8; rev=380;
       name="boAt Stone 350 10W Wireless Bluetooth Speaker with IPX7 Water Resistance";
       desc="Rugged portable cylindrical speaker with dynamic drivers, deep punchy bass, and 12-hour battery.";
       img="https://images.unsplash.com/photo-1545454675-3531b543be5d?w=500" },
    @{ id=282; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=2999.00; stock=70; r=4.9; rev=450;
       name="JBL Go 3 Ultra-Portable Waterproof & Dustproof Bluetooth Speaker";
       desc="Signature JBL Pro Sound in an eye-catching compact fabric design with IP67 rating and grab loop.";
       img="https://images.unsplash.com/photo-1545454675-3531b543be5d?w=500" },
    @{ id=283; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=8999.00; stock=40; r=4.9; rev=310;
       name="JBL Flip 6 Powerful 30W 2-Way Speaker System with Deep Dual Radiators";
       desc="High performance woofer and separate tweeter delivering rich mids and booming outdoor bass.";
       img="https://images.unsplash.com/photo-1545454675-3531b543be5d?w=500" },
    @{ id=284; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=3490.00; stock=50; r=4.8; rev=270;
       name="Sony SRS-XB13 Extra Bass Wireless Compact Speaker with Multiway Strap";
       desc="Sound Diffusion Processor with Extra Bass expander and IP67 waterproof/dustproof rugged casing.";
       img="https://images.unsplash.com/photo-1545454675-3531b543be5d?w=500" },
    @{ id=285; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=1099.00; stock=150; r=4.8; rev=490;
       name="boAt Airdopes 141 True Wireless Earbuds with 42-Hour Total Playtime";
       desc="ENx environment noise cancelling mic, low latency Beast Mode for gaming, and Insta Wake N' Pair.";
       img="https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500" },
    @{ id=286; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=2299.00; stock=90; r=4.9; rev=380;
       name="OnePlus Nord Buds 2 TWS Earbuds with 25dB Active Noise Cancellation";
       desc="12.4mm titanium drivers, BassWave enhancement algorithm, and dual mics with AI clear calls.";
       img="https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500" },
    @{ id=287; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=4499.00; stock=60; r=4.9; rev=290;
       name="Realme Buds Air 5 Pro ANC Earbuds with 50dB Hybrid Noise Reduction";
       desc="Hi-Res LDAC audio transmission, coaxial dual drivers, and 40-hour long playback with fast charge.";
       img="https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500" },
    @{ id=288; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=899.00; stock=160; r=4.7; rev=330;
       name="Noise Buds VS104 True Wireless Earbuds with 45-Hour Battery Life";
       desc="Instacharge 10 mins = 200 mins playtime, 13mm powerful speaker drivers, and hyper-sync technology.";
       img="https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500" },
    @{ id=289; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=999.00; stock=140; r=4.8; rev=310;
       name="Boult Audio Z40 True Wireless Earbuds with 60-Hour Massive Playtime";
       desc="Zen ENC quad mic technology, 10mm BoomX drivers, ultra low-latency gaming, and touch controls.";
       img="https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500" },
    @{ id=290; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=1099.00; stock=120; r=4.7; rev=420;
       name="Fire-Boltt Ninja Call Pro Plus 1.83-Inch Bluetooth Calling Smartwatch";
       desc="Clear Bluetooth calling dialpad, 100+ sports modes, AI voice assistant, and 280mAh long battery.";
       img="https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=500" },
    @{ id=291; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=1299.00; stock=100; r=4.8; rev=340;
       name="boAt Wave Call 2 Smartwatch with 1.83-Inch HD Display & Custom Dials";
       desc="Active Bluetooth speaker calling, 700+ active sports modes, crest app health ecosystem, and IP67.";
       img="https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=500" },
    @{ id=292; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=1999.00; stock=80; r=4.8; rev=260;
       name="Fastrack Limitless FS1 Pro Smartwatch with 1.96-Inch Super AMOLED";
       desc="Always-on bright AMOLED screen, SingleSync Bluetooth calling, NitroFast charge, and 110+ sports modes.";
       img="https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=500" },
    @{ id=293; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=3499.00; stock=50; r=4.9; rev=220;
       name="Amazfit Bip 5 Smartwatch with 1.91-Inch Screen & 4 Satellite GPS";
       desc="High precision multi-satellite GPS tracking, 10-day battery life, Zepp OS 2.0 apps, and heart rate sensor.";
       img="https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=500" },
    @{ id=294; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=999.00; stock=130; r=4.9; rev=350;
       name="SanDisk Ultra Dual Drive Luxe Type-C All-Metal Flash Drive 128GB";
       desc="All-metal 2-in-1 swivel USB-C and USB-A high speed flash drive with transfer speeds up to 150MB/s.";
       img="https://images.unsplash.com/photo-1544816155-12df9643f363?w=500" },
    @{ id=295; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=429.00; stock=180; r=4.8; rev=290;
       name="Kingston DataTraveler Exodia 64GB USB 3.2 High Speed Pen Drive";
       desc="Practical colorful loop keychain design with fast file transfers for laptops, TVs, and sound systems.";
       img="https://images.unsplash.com/photo-1544816155-12df9643f363?w=500" },
    @{ id=296; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=399.00; stock=190; r=4.7; rev=250;
       name="HP v236w 64GB Metal USB 2.0 Durable Flash Drive (Silver)";
       desc="Capless metal finish drive resisting shock, dust, and water damage for dependable portable storage.";
       img="https://images.unsplash.com/photo-1544816155-12df9643f363?w=500" },
    @{ id=297; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=4499.00; stock=45; r=4.9; rev=310;
       name="Seagate Expansion 1TB External Hard Drive HDD USB 3.0 (Black)";
       desc="Plug-and-play high capacity backup drive with drag-and-drop file saving and 3-year data recovery.";
       img="https://images.unsplash.com/photo-1544816155-12df9643f363?w=500" },
    @{ id=298; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=5999.00; stock=40; r=4.9; rev=280;
       name="WD My Passport 2TB Portable External Hard Drive with Backup Software";
       desc="Hardware 256-bit AES encryption, auto-backup utility, and slim pocket-friendly form factor.";
       img="https://images.unsplash.com/photo-1544816155-12df9643f363?w=500" },
    @{ id=299; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=6499.00; stock=35; r=4.9; rev=220;
       name="Crucial X6 1TB Portable SSD up to 800MB/s USB 3.2 Gen-2 (Ultra-Light)";
       desc="Tiny drop-resistant solid state drive transferring entire video libraries 3.8x faster than traditional HDDs.";
       img="https://images.unsplash.com/photo-1544816155-12df9643f363?w=500" },
    @{ id=300; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=599.00; stock=170; r=4.9; rev=520;
       name="Logitech B170 Wireless Optical Mouse with 2.4GHz Nano Dongle (12M Battery)";
       desc="Bestselling reliable universal wireless mouse with 10-meter range and comfortable contour grip.";
       img="https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=500" },
    @{ id=301; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=1299.00; stock=85; r=4.8; rev=360;
       name="Logitech MK215 Compact Wireless Keyboard and Mouse Desk Combo";
       desc="Space-saving minimalist design with 2.4GHz wireless signal and 24-month keyboard battery lifespan.";
       img="https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500" },
    @{ id=302; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=599.00; stock=120; r=4.7; rev=270;
       name="Dell KB216 Wired Quiet-Key Multimedia USB Desktop Keyboard";
       desc="Chiclet-style low profile keys for smooth quiet typing with integrated multimedia shortcuts.";
       img="https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500" },
    @{ id=303; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=699.00; stock=90; r=4.6; rev=180;
       name="Quantum QHM495LM USB 480P Webcam with Built-in Microphone & Clip";
       desc="Rotatable clamp camera ideal for online university lectures, Zoom meetings, and video calls.";
       img="https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500" },
    @{ id=304; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=2499.00; stock=65; r=4.8; rev=310;
       name="TP-Link Archer C6 AC1200 Dual-Band Gigabit Wi-Fi Router (4 Antennas)";
       desc="MU-MIMO technology creating lag-free high speed wireless streaming across multiple household devices.";
       img="https://images.unsplash.com/photo-1544816155-12df9643f363?w=500" },
    @{ id=305; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=1099.00; stock=80; r=4.7; rev=240;
       name="D-Link DIR-615 Wireless N300 High Performance Router with Dual Antennas";
       desc="Stable 300Mbps home Wi-Fi coverage with repeater mode and WPA2 security encryption.";
       img="https://images.unsplash.com/photo-1544816155-12df9643f363?w=500" },
    @{ id=306; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=2299.00; stock=50; r=4.9; rev=210;
       name="Mi Smart LED Desk Lamp 1S with Stepless Brightness & App Control";
       desc="Eye-caring Ra90 color rendering index lamp with optical lens reducing glare and eye strain.";
       img="https://images.unsplash.com/photo-1507499739999-097706ad8914?w=500" },
    @{ id=307; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=799.00; stock=110; r=4.8; rev=280;
       name="Wipro 16A Smart Wi-Fi Plug with Real-Time Energy Consumption Monitoring";
       desc="Control ACs, geysers, and water heaters from your smartphone or with Alexa voice commands.";
       img="https://images.unsplash.com/photo-1507499739999-097706ad8914?w=500" },
    @{ id=308; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=499.00; stock=140; r=4.8; rev=260;
       name="Syska 10W B22 Smart LED Bulb with 16 Million Colors & Dimming Mode";
       desc="Wi-Fi enabled mood light adjustable to warm white, cool daylight, or festive multicolor tones.";
       img="https://images.unsplash.com/photo-1507499739999-097706ad8914?w=500" },
    @{ id=309; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=4499.00; stock=60; r=4.9; rev=480;
       name="Amazon Echo Dot (5th Gen) Smart Speaker with Alexa & Deeper Bass";
       desc="Voice control your smart home, stream Spotify tunes, and check weather alerts with rich vocals.";
       img="https://images.unsplash.com/photo-1545454675-3531b543be5d?w=500" },
    @{ id=310; sId=2; sName="TechNova"; cat="Flipkart Bestsellers"; price=3499.00; stock=75; r=4.9; rev=510;
       name="Fire TV Stick HD with Alexa Voice Remote & TV Power Buttons";
       desc="Stream thousands of movies and TV episodes on Prime Video, Netflix, and Hotstar in full 1080p.";
       img="https://images.unsplash.com/photo-1545454675-3531b543be5d?w=500" },
    @{ id=311; sId=1; sName="KathiravanMart"; cat="Flipkart Bestsellers"; price=1799.00; stock=65; r=4.8; rev=190;
       name="Philips Daily Collection 300W Hand Mixer with 5 Speeds & Dough Hooks";
       desc="Baking essential with stainless steel wire beaters and lightweight body for whipping eggs and batter.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=312; sId=1; sName="KathiravanMart"; cat="Flipkart Bestsellers"; price=1499.00; stock=85; r=4.7; rev=230;
       name="Lifelong 500W Mixer Grinder with 3 Stainless Steel Jars (White & Blue)";
       desc="Reliable motor with overload protector for wet grinding chutneys, dry spices, and idli batter.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=313; sId=1; sName="KathiravanMart"; cat="Flipkart Bestsellers"; price=1199.00; stock=90; r=4.8; rev=270;
       name="Prestige Non-Stick Grill Sandwich Toaster with Heat-Resistant Bakelite Body";
       desc="Non-toxic non-stick coating for crispy grilled sandwiches with minimal butter and oil usage.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=314; sId=1; sName="KathiravanMart"; cat="Flipkart Bestsellers"; price=799.00; stock=130; r=4.8; rev=340;
       name="KENT 16023 1500W Stainless Steel Electric Kettle 1.8-Liter with Auto Cut-Off";
       desc="Rapid boiling kettle for tea, coffee, and cup noodles with 360-degree cordless swivel base.";
       img="https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=500" },
    @{ id=315; sId=1; sName="KathiravanMart"; cat="Flipkart Bestsellers"; price=1699.00; stock=75; r=4.8; rev=280;
       name="Pigeon by Stovekraft Cruise 1800W Induction Cooktop with 7 Preset Menus";
       desc="Energy-efficient electromagnetic cooking plate with LED display and auto-shutoff safety timer.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=316; sId=3; sName="UrbanStyle"; cat="Flipkart Bestsellers"; price=649.00; stock=110; r=4.8; rev=260;
       name="Amazon Brand Solimo 100% Pure Cotton 144 TC Double Bedsheet with 2 Pillow Covers";
       desc="Breathable soft percale weave bed linen with vibrant colorfast reactive geometric printing.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=317; sId=3; sName="UrbanStyle"; cat="Flipkart Bestsellers"; price=899.00; stock=95; r=4.9; rev=310;
       name="Wakefit Hollow Fiber Sleeping Bed Pillows (Pack of 2 Hypoallergenic Pillows)";
       desc="200 GSM breathable microfiber casing packed with high-bounce hollow conjugate fibers.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=318; sId=3; sName="UrbanStyle"; cat="Flipkart Bestsellers"; price=799.00; stock=85; r=4.8; rev=210;
       name="Bombay Dyeing 100% Combed Cotton 4-Piece Plush Bath Towel Set (500 GSM)";
       desc="Extra fluffy super absorbent hotel-quality bath towels in fade-resistant pastel colors.";
       img="https://images.unsplash.com/photo-1616627547584-bf28cee262db?w=500" },
    @{ id=319; sId=3; sName="UrbanStyle"; cat="Flipkart Bestsellers"; price=849.00; stock=70; r=4.7; rev=180;
       name="Story@Home Blackout Thermal Insulated Window Curtains (Pack of 2, 7 Feet)";
       desc="Triple weave fabric blocking 95% sunlight and outside noise for peaceful restful sleep.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=320; sId=1; sName="KathiravanMart"; cat="Flipkart Bestsellers"; price=249.00; stock=150; r=4.8; rev=240;
       name="Scotch-Brite Sticky Lint Roller with 60 Sheets for Pet Hair & Suits";
       desc="Super adhesive roller picking up lint, dust particles, and animal fur from blazers and sofas.";
       img="https://images.unsplash.com/photo-1616627547584-bf28cee262db?w=500" },

    # --- INDUSTRIAL TOOLS, HARDWARE & MECHANICAL GEAR (IDs 321-360) ---
    @{ id=321; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=2499.00; stock=60; r=4.9; rev=320;
       name="Bosch GSB 500 RE 500W Impact Drill Machine Kit with 100 Accessories";
       desc="Heavy duty forward/reverse variable speed drill with chuck key, masonry bits, and carry case.";
       img="https://images.unsplash.com/photo-1504148455328-c376907d081c?w=500" },
    @{ id=322; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=1799.00; stock=50; r=4.8; rev=210;
       name="Black+Decker 10mm 550W Variable Speed Reversible Hammer Drill";
       desc="Ergonomic pistol grip tool designed for drilling into brick, concrete, steel, and timber.";
       img="https://images.unsplash.com/photo-1504148455328-c376907d081c?w=500" },
    @{ id=323; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=899.00; stock=80; r=4.9; rev=250;
       name="Stanley 10-Piece Metric Chrome Vanadium Combination Spanner Set (8mm to 19mm)";
       desc="Corrosion-resistant satin chrome finish wrenches engineered to meet ANSI industrial torque standards.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=324; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=499.00; stock=90; r=4.8; rev=220;
       name="Taparia 1012 Universal Adjustable Wrench 12-Inch Chrome Finish";
       desc="Drop-forged carbon steel wrench with laser-etched jaw scale for heavy piping and nut tightening.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=325; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=299.00; stock=120; r=4.9; rev=270;
       name="Taparia 842 Heavy Duty Linesman Combination Plier (8-Inch Insulated)";
       desc="High leverage cutting edges hardened to 60 HRC for shearing tough copper and steel wires.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=326; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=249.00; stock=110; r=4.8; rev=180;
       name="Taparia Long Nose Needle Plier with Ergonomic Insulation Grip (6-Inch)";
       desc="Slim serrated jaws accessing cramped electronics enclosures and twisting fine mechanical links.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=327; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=239.00; stock=115; r=4.8; rev=190;
       name="Taparia Diagonal Side Cutting Plier for Electricians & Mechanics (6-Inch)";
       desc="Precision induction-hardened cutting bevels cutting cable ties, wires, and brass pins cleanly.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=328; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=320.00; stock=130; r=4.9; rev=290;
       name="Taparia 812 High Grade Steel Screwdriver Set (5 Reversible Blades + Neon Tester)";
       desc="Magnetized tips with transparent unbreakable cellulose acetate shockproof handle.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=329; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=699.00; stock=95; r=4.8; rev=210;
       name="Bosch Professional 33-Piece X-Line Screwdriver and Drill Bit Set";
       desc="Comprehensive set of HSS metal bits, masonry bits, wood spade bits, and magnetic bit holder.";
       img="https://images.unsplash.com/photo-1504148455328-c376907d081c?w=500" },
    @{ id=330; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=7999.00; stock=25; r=4.9; rev=160;
       name="DeWalt 20V Max Cordless Drill Driver Kit with 2 Lithium Batteries & Charger";
       desc="High performance 2-speed transmission (0-450 / 0-1500 RPM) delivering 300 unit watts out of power.";
       img="https://images.unsplash.com/photo-1504148455328-c376907d081c?w=500" },
    @{ id=331; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=2699.00; stock=40; r=4.8; rev=180;
       name="Makita 9554NB 4-Inch 710W Heavy Duty Metal & Stone Angle Grinder";
       desc="Labyrinth dust construction sealing motor bearings from abrasive cutting debris and sparks.";
       img="https://images.unsplash.com/photo-1504148455328-c376907d081c?w=500" },
    @{ id=332; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=2999.00; stock=35; r=4.8; rev=140;
       name="Bosch GDC 120 1200W Professional Marble & Granite Tile Cutter";
       desc="High speed 12,000 RPM motor with optimized dust insulation for wet and dry masonry slicing.";
       img="https://images.unsplash.com/photo-1504148455328-c376907d081c?w=500" },
    @{ id=333; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=449.00; stock=85; r=4.8; rev=190;
       name="Stanley 30-Meter Fiberglass Long Land & Workshop Measuring Tape";
       desc="Non-conductive PVC coated fiberglass blade with 3:1 gear ratio rapid hand rewinding crank.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=334; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=199.00; stock=150; r=4.9; rev=310;
       name="Freemans 5-Meter Steel Auto-Lock Workshop Measuring Tape with Belt Clip";
       desc="Fractional read blade with shock-absorbing rubber jacket and durable magnetic end hook.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=335; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=399.00; stock=90; r=4.8; rev=160;
       name="Stanley 12-Inch Heavy Duty Cast Iron Hacksaw with Carbon Steel Blade";
       desc="Rigid tensioning frame allowing 90-degree and 45-degree angle cutting of conduits and bolts.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=336; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=499.00; stock=80; r=4.7; rev=130;
       name="Bosch 10-Piece Bi-Metal Jigsaw Blades Set for Hardwood, Metal & PVC";
       desc="T-shank assorted blades engineered for curved profile cuts, clean slicing, and rip sawing.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=337; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=280.00; stock=110; r=4.8; rev=210;
       name="Taparia 1171 Machinist Ball Pein Hammer 500g with Seasoned Wooden Handle";
       desc="Drop forged carbon steel dual head for metal shaping, riveting, and automotive assembly.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=338; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=549.00; stock=70; r=4.8; rev=140;
       name="Taparia 2-Pound Heavy Demolition Sledge Hammer with Rubberized Grip";
       desc="Induction hardened face minimizing mushrooming during masonry breaking and chisel driving.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=339; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=420.00; stock=90; r=4.9; rev=220;
       name="Stanley 16-Ounce Fiberglass Curved Claw Hammer with Anti-Vibration Collar";
       desc="Rim-tempered face prevents chipping while curved claws provide optimal leverage to pull nails.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=340; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=299.00; stock=95; r=4.8; rev=150;
       name="Taparia Heavy Duty Forged Steel C-Clamp 4-Inch for Welding & Woodwork";
       desc="Swiveling pad and acme threaded screw distributing steady clamping pressure on workpieces.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=341; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=149.00; stock=160; r=4.9; rev=340;
       name="Multitec 06 Automatic Wire Stripper and Cutter (0.5mm to 6mm Cables)";
       desc="Self-adjusting jaw mechanism stripping electrical cable insulation cleanly without nicking conductors.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=342; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=449.00; stock=120; r=4.7; rev=230;
       name="Mastech MAS830L Digital Multimeter with Backlight & Continuity Buzzer";
       desc="Measures AC/DC voltage, DC current, resistance, diode check, and audio continuity check.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=343; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=3299.00; stock=45; r=4.9; rev=190;
       name="Fluke 101 Pocket Digital Multimeter with CAT III 600V Safety Rating";
       desc="Compact rugged industrial meter engineered by Fluke for precise everyday electrical testing.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=344; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=249.00; stock=140; r=4.8; rev=280;
       name="Soldron 25W High Quality Soldering Iron with Pointed Chisel Bit";
       desc="Continuous duty heating element suited for university electronics labs and PCB repairs.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=345; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=2499.00; stock=35; r=4.9; rev=160;
       name="Soldron 50W Temperature Controlled Variable Soldering Station with Stand";
       desc="Closed loop sensor controlling tip temperature from 200 to 480 degrees C for delicate components.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=346; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=3899.00; stock=25; r=4.8; rev=130;
       name="Quick 850A Hot Air SMD Rework Station for Mobile & Chip Level Repair";
       desc="Adjustable air volume and temperature control with anti-static design for circuit boards.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=347; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=699.00; stock=80; r=4.9; rev=190;
       name="Kester 60/40 Rosin Core Lead Solder Wire (500g Spool, 20 SWG)";
       desc="Clean melting formula yielding bright shiny solder joints without sputtering or pitting.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=348; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=1899.00; stock=40; r=4.8; rev=120;
       name="Taparia Heavy Duty 3-Ton Hydraulic Bottle Jack for SUVs & Trucks";
       desc="Solid cast base with bypass valve preventing over-extension during vehicle tyre changes.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=349; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=2499.00; stock=50; r=4.9; rev=210;
       name="Michelin 12V High-Power Digital Tyre Inflator Air Compressor Pump";
       desc="Pre-set auto cutoff with bright LED work light and accurate digital pressure readout.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=350; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=199.00; stock=180; r=4.8; rev=260;
       name="3M 1110 Corded Soft Foam Hearing Protection Earplugs (Pack of 10 Pairs)";
       desc="NRR 29dB noise reduction foam contouring snugly inside ears against factory machinery.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=351; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=249.00; stock=160; r=4.8; rev=230;
       name="3M 9004V Particulate Respirator Dust Mask with Exhalation Valve (Box of 10)";
       desc="Filters airborne dust, wood pollen, and grinding particles with cool flow valve for easy breathing.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=352; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=149.00; stock=170; r=4.8; rev=220;
       name="Karam Safety Goggles with Anti-Scratch & Anti-Fog Polycarbonate Shield";
       desc="Full eye protection wrap-around glasses defending against flying metal chips and chemical splash.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=353; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=349.00; stock=120; r=4.9; rev=250;
       name="Karam CE Certified Heavy Duty Industrial Construction Safety Helmet (Yellow)";
       desc="UV-resistant high density polymer helmet with 4-point adjustable textile suspension.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=354; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=1499.00; stock=60; r=4.8; rev=170;
       name="Safari Leather Steel-Toe Heavy Duty Industrial Safety Work Shoes (Size 8)";
       desc="200 Joules impact resistant steel toe cap with antistatic oil and acid resistant PU sole.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=355; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=1499.00; stock=55; r=4.8; rev=160;
       name="Safari Leather Steel-Toe Heavy Duty Industrial Safety Work Shoes (Size 9)";
       desc="Cushioned insole with high traction cleated tread for industrial workshops and construction zones.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=356; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=799.00; stock=90; r=4.8; rev=210;
       name="Taparia High Impact Heavy Duty Storage Toolbox with Metal Latches (16-Inch)";
       desc="Molded structural polypropylene box with removable top tool organizer and padlock eye.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=357; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=2199.00; stock=35; r=4.9; rev=140;
       name="Stanley Cantilever 3-Tier Multi-Compartment Metal Toolbox (19-Inch)";
       desc="All-steel construction opening automatically to display all hand tools across tiered trays.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=358; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=420.00; stock=110; r=4.9; rev=260;
       name="WD-40 Specialist High Performance White Lithium Heavy Duty Grease (400ml)";
       desc="Water and heat resistant non-drip lubricant for metal hinges, pulleys, gears, and chains.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=359; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=380.00; stock=85; r=4.8; rev=130;
       name="Loctite 242 Threadlocker Medium Strength Removable Nut & Bolt Adhesive (50ml)";
       desc="Prevents vibration loosening of machine screws, motor mounts, and transmission bolts.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },
    @{ id=360; sId=2; sName="TechNova"; cat="Industrial & Tools"; price=199.00; stock=190; r=4.9; rev=310;
       name="3M Scotch 88 Heavy Duty Vinyl Electrical Insulation Tape (Pack of 5 Rolls)";
       desc="All-weather PVC tape rated up to 600V with elastic backing hugging irregular cable splices.";
       img="https://images.unsplash.com/photo-1581244277943-fe4a9c777189?w=500" },

    # --- GROCERIES, PANTRY & SUPERMART (IDs 361-400) ---
    @{ id=361; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=520.00; stock=120; r=4.9; rev=380;
       name="India Gate Super Basmati Rice Premium Aged Long Grain (5kg Pouch)";
       desc="Aged for 2 years to deliver sweet aroma and non-sticky elongated grains for biryani.";
       img="https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500" },
    @{ id=362; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=420.00; stock=110; r=4.8; rev=290;
       name="Fortune Everyday Full Grain Basmati Rice for Daily Family Dining (5kg)";
       desc="Fluffy, aromatic slender grains ideal for pulav, fried rice, and daily steamed rice.";
       img="https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500" },
    @{ id=363; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=460.00; stock=95; r=4.8; rev=230;
       name="Kohinoor Charminar Select Basmati Rice Fragrant Value Pack (5kg)";
       desc="Sourced from foothills of Himalayas for authentic culinary texture and pleasant aroma.";
       img="https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500" },
    @{ id=364; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=275.00; stock=140; r=4.8; rev=310;
       name="Pillsbury Chakki Fresh Whole Wheat Atta with 100% Whole Grain (5kg)";
       desc="Rotis stay soft for over 6 hours; stone ground with natural wheat germ and dietary bran.";
       img="https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500" },
    @{ id=365; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=320.00; stock=80; r=4.9; rev=190;
       name="24 Mantra Organic Whole Wheat Atta Chemical-Free (5kg Bag)";
       desc="Organically certified farm wheat preserving essential fiber and wholesome natural taste.";
       img="https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500" },
    @{ id=366; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=175.00; stock=160; r=4.9; rev=270;
       name="Tata Sampann Unpolished Toor Dal Arhar Dal Rich in Protein (1kg Pouch)";
       desc="Unpolished dal without artificial water/oil polish preserving dietary natural minerals.";
       img="https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500" },
    @{ id=367; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=165.00; stock=150; r=4.8; rev=220;
       name="Tata Sampann Unpolished Moong Dal Split Yellow Lentils (1kg Pouch)";
       desc="Easy to digest healthy lentils with wholesome dietary protein for khichdi and soups.";
       img="https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500" },
    @{ id=368; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=130.00; stock=140; r=4.8; rev=180;
       name="Tata Sampann Unpolished Chana Dal Bengal Gram Lentils (1kg Pouch)";
       desc="Nutritious whole pulse grains cooked into flavorful dal tadka and south Indian vadas.";
       img="https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500" },
    @{ id=369; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=185.00; stock=110; r=4.9; rev=195;
       name="24 Mantra Organic Urad Dal Whole Black Gram (1kg Pouch)";
       desc="Ideal for traditional idli/dosa fermentation with rich organic taste and high protein.";
       img="https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500" },
    @{ id=370; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=128.00; stock=170; r=4.7; rev=260;
       name="Fortune Soya Health Refined Soyabean Oil with Omega-3 (1L Pouch)";
       desc="Light golden cooking oil enriched with vitamins A & D for daily stir-frying and curries.";
       img="https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500" },
    @{ id=371; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=155.00; stock=130; r=4.8; rev=240;
       name="Dhara Kachi Ghani 100% Pure Mustard Oil Cold Pressed (1L Bottle)";
       desc="Authentic pungent aroma and natural antioxidants perfect for pickles and traditional cooking.";
       img="https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500" },
    @{ id=372; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=999.00; stock=75; r=4.9; rev=280;
       name="Borges Extra Virgin Cold-Pressed Mediterranean Olive Oil (1L Tin)";
       desc="Premium first cold press olive oil with rich fruity flavor for salads, pasta, and dips.";
       img="https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500" },
    @{ id=373; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=599.00; stock=90; r=4.8; rev=210;
       name="Figaro Pure Spanish Olive Oil for Cooking & Nourishment (500ml Tin)";
       desc="Time-tested mild olive oil suitable for culinary sautéing as well as infant skin massage.";
       img="https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500" },
    @{ id=374; sId=1; sName="KathiravanMart"; cat="Groceries & Essentials"; price=650.00; stock=130; r=4.9; rev=450;
       name="Amul Pure Cow Ghee Traditional Aroma & Granular Texture (1L Tin)";
       desc="Rich golden clarified cow butter lending rich authentic taste to sweets, rotis, and dal.";
       img="https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=500" },
    @{ id=375; sId=1; sName="KathiravanMart"; cat="Groceries & Essentials"; price=620.00; stock=110; r=4.9; rev=320;
       name="Mother Dairy Pure Cow Desi Ghee in Sealed Pouch (1L)";
       desc="Crafted from pure cow milk with rich wholesome buttery flavor and essential fat-soluble vitamins.";
       img="https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=500" },
    @{ id=376; sId=1; sName="KathiravanMart"; cat="Groceries & Essentials"; price=590.00; stock=100; r=4.8; rev=290;
       name="Patanjali Cow Ghee Ayurvedic Purity Clarified Butter (1L Carton)";
       desc="Natural cow ghee enhancing memory, digestion, and physical vitality according to Ayurveda.";
       img="https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=500" },
    @{ id=377; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=42.00; stock=220; r=4.8; rev=310;
       name="Tata Salt Lite Low Sodium Iodized Salt with 15% Less Sodium (1kg)";
       desc="Formulated for blood pressure health while maintaining delicious natural salt flavor.";
       img="https://images.unsplash.com/photo-1518110925495-5fe2fda0442c?w=500" },
    @{ id=378; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=99.00; stock=180; r=4.9; rev=260;
       name="Catch Pure Pink Himalayan Rock Salt Fine Powder (1kg Jar)";
       desc="Unrefined mineral rock salt packed with 84 trace elements and electrolytes for wellness.";
       img="https://images.unsplash.com/photo-1518110925495-5fe2fda0442c?w=500" },
    @{ id=379; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=78.00; stock=190; r=4.9; rev=280;
       name="Everest Pav Bhaji Masala Aromatic Spice Blend (100g Carton)";
       desc="Perfect ratio of dry mango, coriander, cumin, and chillies for street-style pav bhaji.";
       img="https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500" },
    @{ id=380; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=85.00; stock=185; r=4.9; rev=295;
       name="Everest Garam Masala Royal Blend of 13 Selected Spices (100g Carton)";
       desc="Pungent whole spices roasted and ground to deliver enticing warmth to vegetarian and meat curries.";
       img="https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500" },
    @{ id=381; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=82.00; stock=170; r=4.8; rev=240;
       name="MDH Chana Masala Authentic Punjabi Style Chickpea Spice Mix (100g)";
       desc="Tangy pomegranate and spice seasoning making chhole curries irresistible and fragrant.";
       img="https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500" },
    @{ id=382; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=199.00; stock=150; r=4.8; rev=270;
       name="Catch Red Chilli Powder Stemless Clean Grinded Spices (500g Pouch)";
       desc="Bright vibrant red color and controlled fiery spice level ground from select Guntur chillies.";
       img="https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500" },
    @{ id=383; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=95.00; stock=160; r=4.9; rev=290;
       name="Catch Kashmiri Mirch Powder for Rich Natural Red Color (100g Box)";
       desc="Mild heat with deep crimson red hue giving gravies and tandoori marinades a restaurant finish.";
       img="https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500" },
    @{ id=384; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=145.00; stock=140; r=4.9; rev=250;
       name="Everest Turmeric Powder Golden Agmark Grade Haldi (500g Pouch)";
       desc="Rich in natural curcumin with deep yellow color and therapeutic antimicrobial properties.";
       img="https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=500" },
    @{ id=385; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=189.00; stock=150; r=4.8; rev=330;
       name="Saffola Oats 100% Natural Whole Grain High Dietary Fiber (1kg Pouch)";
       desc="Creamy quick cooking oats lowering cholesterol and providing lasting morning fullness.";
       img="https://images.unsplash.com/photo-1517673132405-a56a62b18caf?w=500" },
    @{ id=386; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=199.00; stock=140; r=4.8; rev=310;
       name="Quaker Oats Rolled Whole Grain Nutritious Breakfast Porridge (1kg Pouch)";
       desc="Power-packed whole rolled oats loaded with beta-glucan soluble fiber for sustained heart energy.";
       img="https://images.unsplash.com/photo-1517673132405-a56a62b18caf?w=500" },
    @{ id=387; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=420.00; stock=90; r=4.9; rev=220;
       name="Bagrry's Crunchy Fruit & Nut Cranberry Multi-Grain Muesli (1kg Mega Pack)";
       desc="Loaded with 40% almonds, raisins, dried cranberries, and multigrain flakes with zero artificial flavors.";
       img="https://images.unsplash.com/photo-1517673132405-a56a62b18caf?w=500" },
    @{ id=388; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=585.00; stock=110; r=4.9; rev=470;
       name="Nutella Hazelnut Cocoa Spread with Skimmed Milk (750g Glass Jar)";
       desc="Creamy delicious breakfast spread crafted with select hazelnuts and rich premium cocoa.";
       img="https://images.unsplash.com/photo-1549007994-cb92caebd54b?w=500" },
    @{ id=389; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=245.00; stock=130; r=4.8; rev=290;
       name="Kissan Mixed Fruit Jam with Real Juicy Fruit Pulp (1kg Tub)";
       desc="Sweet blend of 8 real fruits spreading joy on fresh toasted bread, rotis, and pancakes.";
       img="https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=500" },
    @{ id=390; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=299.00; stock=140; r=4.8; rev=340;
       name="Dr. Oetker FunFoods Creamy Peanut Butter High Protein (1kg Jar)";
       desc="Rich roasted peanut spread offering 26g protein per 100g without trans fats or cholesterol.";
       img="https://images.unsplash.com/photo-1508061252445-5350f3ab0a56?w=500" },
    @{ id=391; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=320.00; stock=120; r=4.9; rev=280;
       name="Sundrop 100% Natural Crunchy Peanut Butter Unsweetened (924g Jar)";
       desc="Pure roasted peanuts with crunchy chunks, zero added sugar, salt, or hydrogenated oils.";
       img="https://images.unsplash.com/photo-1508061252445-5350f3ab0a56?w=500" },
    @{ id=392; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=168.00; stock=220; r=4.9; rev=580;
       name="Maggi 2-Minute Masala Instant Noodles (Mega Family Pack of 12 x 70g)";
       desc="India's favorite noodle with the iconic blend of 10 roasted spices and fortification of iron.";
       img="https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500" },
    @{ id=393; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=155.00; stock=180; r=4.8; rev=360;
       name="Sunfeast YiPPee! Magic Masala Non-Sticky Long Noodle Strands (12-Pack)";
       desc="Round block noodles with natural vegetable dehydrated bits and rich non-lumping masala broth.";
       img="https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500" },
    @{ id=394; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=199.00; stock=160; r=4.7; rev=210;
       name="Knorr Classic Thick Tomato Soup Mix with Real Veggies (Pack of 4 x 53g)";
       desc="Homestyle hot creamy soup with croutons ready in 3 minutes without added preservatives.";
       img="https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500" },
    @{ id=395; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=135.00; stock=190; r=4.9; rev=420;
       name="Sunfeast Dark Fantasy Choco Fills Molten Lava Premium Cookies (300g)";
       desc="Crispy dark chocolate cookie crust filled with rich molten liquid chocolate center.";
       img="https://images.unsplash.com/photo-1549007994-cb92caebd54b?w=500" },
    @{ id=396; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=140.00; stock=210; r=4.8; rev=380;
       name="Britannia Good Day Butter & Cashew Cookies Mega Saver Value Pack (600g)";
       desc="Rich melt-in-mouth buttery delight baked with real golden cashews and smiling curves.";
       img="https://images.unsplash.com/photo-1549007994-cb92caebd54b?w=500" },
    @{ id=397; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=99.00; stock=250; r=4.9; rev=610;
       name="Parle-G Gold Original Glucose Energy Biscuits Mega Pack (1kg)";
       desc="The quintessential accompaniment to morning hot chai, delivering wheat and milk nutrition.";
       img="https://images.unsplash.com/photo-1549007994-cb92caebd54b?w=500" },
    @{ id=398; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=245.00; stock=160; r=4.9; rev=340;
       name="Haldiram's Nagpur Bhujia Sev Crispy Mung Bean Savory Snack (1kg Pouch)";
       desc="Iconic spiced crispy sev seasoned with black pepper, cardamom, and moth dal flour.";
       img="https://images.unsplash.com/photo-1508061252445-5350f3ab0a56?w=500" },
    @{ id=399; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=235.00; stock=150; r=4.8; rev=290;
       name="Haldiram's All in One Crunchy Mixed Namkeen (1kg Resealable Pouch)";
       desc="Festive mix of cornflakes, cashew nuts, raisins, and spicy sev for evening tea snacks.";
       img="https://images.unsplash.com/photo-1508061252445-5350f3ab0a56?w=500" },
    @{ id=400; sId=3; sName="UrbanStyle"; cat="Groceries & Essentials"; price=180.00; stock=110; r=4.8; rev=210;
       name="Epigamia Natural High Protein Greek Yogurt Cups (Pack of 4 x 90g)";
       desc="Strained authentic Greek yogurt packed with 6g protein per cup and live probiotic cultures.";
       img="https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=500" },

    # --- HOME, KITCHEN & DINING (IDs 401-435) ---
    @{ id=401; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=1499.00; stock=65; r=4.9; rev=390;
       name="Hawkins Classic 3-Liter Aluminium Pressure Cooker Inner Lid";
       desc="Pressure-locked safety lid cooker with shielded safety valve and mirror finish polish.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=402; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=2399.00; stock=45; r=4.9; rev=320;
       name="Hawkins Contura 5-Liter Hard Anodized Pressure Cooker (Black)";
       desc="Curved body for easy stirring with non-reactive hard anodized surface heating 20% faster.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=403; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=2199.00; stock=50; r=4.8; rev=280;
       name="Prestige Deluxe Alpha Stainless Steel Outer Lid Cooker (3-Liter)";
       desc="Alpha induction base with precision weight valve and durable food-grade 304 steel body.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=404; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=1399.00; stock=70; r=4.8; rev=310;
       name="Pigeon by Stovekraft Favourite 3-Piece Cookware Set (Kadai, Tawa, Fry Pan)";
       desc="5-layer non-stick coating with spiral base and heat-resistant Bakelite handles.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=405; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=2799.00; stock=40; r=4.9; rev=240;
       name="Wonderchef Granite Non-Stick 3-Piece Induction Cookware Set with Glass Lids";
       desc="Virgin aluminium with marble granite coating free from PFOA and heavy metals.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=406; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=1499.00; stock=60; r=4.8; rev=190;
       name="Vinod Stainless Steel 2-Tier Multi-Steamer Kadai with Glass Lid (20cm)";
       desc="Encapsulated sandwich bottom for steaming momos, idlis, and vegetables evenly.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=407; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=899.00; stock=85; r=4.8; rev=260;
       name="Prestige Hard Anodized Induction Compatible Omni Roti Tawa (250mm)";
       desc="Thick 4mm base distributing heat uniformly across roti, chapati, and paratha breads.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=408; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=2999.00; stock=45; r=4.9; rev=340;
       name="Butterfly Jet Elite 750W Mixer Grinder with 4 Multi-Utility Stainless Jars";
       desc="Heavy duty 750-watt copper motor with juicer blender jar and anti-slip rubber feet.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=409; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=1999.00; stock=65; r=4.7; rev=270;
       name="Bajaj Rex 500W Mixer Grinder with 3 Stainless Steel Precision Jars";
       desc="Durable rust-proof blades with multi-functional speed control for Indian spice grinding.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=410; sId=2; sName="TechNova"; cat="Home & Kitchen"; price=7499.00; stock=25; r=4.9; rev=180;
       name="Philips 25-Liter Digital Oven Toaster Grill (OTG) with Opti-Temp Technology";
       desc="Bake cakes, grill tikkas, and toast breads with motorized rotisserie and digital presets.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=411; sId=2; sName="TechNova"; cat="Home & Kitchen"; price=5999.00; stock=30; r=4.8; rev=160;
       name="Morphy Richards 20L Solo Microwave Oven 800W with 5 Power Levels";
       desc="Defrost and reheat curries, rice, and snacks with mirror glass door and auto-timer.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=412; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=7999.00; stock=20; r=4.9; rev=210;
       name="KENT Ultra Storage 7L UV + UF Water Purifier with Stainless Steel Tank";
       desc="Multi-stage purification killing bacteria and cysts while preserving essential natural minerals.";
       img="https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=500" },
    @{ id=413; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=8999.00; stock=25; r=4.8; rev=230;
       name="Aquaguard Sure Delight NXT RO+UV+UF 6-Stage Water Purifier (6L Storage)";
       desc="Taste adjuster technology sweetening borewell and municipal water with zero water wastage.";
       img="https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=500" },
    @{ id=414; sId=2; sName="TechNova"; cat="Home & Kitchen"; price=3299.00; stock=40; r=4.8; rev=260;
       name="Eureka Forbes Quick Clean DX Portable Canister Vacuum Cleaner (1200W)";
       desc="Powerful suction with dust bag full indicator and 6 versatile floor accessories.";
       img="https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=500" },
    @{ id=415; sId=2; sName="TechNova"; cat="Home & Kitchen"; price=1799.00; stock=55; r=4.7; rev=210;
       name="AGARO Regal 800W Handheld 2-in-1 Stick Vacuum Cleaner with HEPA Filter";
       desc="Ultra lightweight bagless vacuum for sofa crevices, curtain dust, and tiled floors.";
       img="https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=500" },
    @{ id=416; sId=2; sName="TechNova"; cat="Home Appliances"; price=9499.00; stock=18; r=4.9; rev=190;
       name="Crompton Ozone 75-Liter Desert Air Cooler with Everlast Pump & Honeycomb Pads";
       desc="High air delivery 4200 m3/hr cooling large halls and rooms with inverter compatibility.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=417; sId=2; sName="TechNova"; cat="Home Appliances"; price=4999.00; stock=25; r=4.8; rev=170;
       name="Bajaj PMH 25 DLX 24-Liter Personal Room Air Cooler with DuraMarine Pump";
       desc="Anti-bacterial hexacool technology with turbo fan throw for compact bedroom cooling.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=418; sId=2; sName="TechNova"; cat="Home Appliances"; price=1499.00; stock=65; r=4.8; rev=310;
       name="Orient Electric Apex-FX 1200mm High Speed Ceiling Fan (Glossy Brown)";
       desc="Double ball bearing copper motor delivering 370 RPM and wide aerodynamically balanced airflow.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=419; sId=2; sName="TechNova"; cat="Home Appliances"; price=2299.00; stock=45; r=4.9; rev=220;
       name="Havells Ambrose 1200mm Decorative Metallic Finish Ceiling Fan (Gold Pearl)";
       desc="Dust-resistant lacquer coating with metallic ring trim and silent low-voltage operation.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=420; sId=2; sName="TechNova"; cat="Home Appliances"; price=1899.00; stock=50; r=4.8; rev=180;
       name="Usha Armor 1200mm Anti-Dust 5-Star Energy Saver Ceiling Fan";
       desc="Polyurethane coated blades repelling dust accumulation and saving 50% power.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=421; sId=1; sName="KathiravanMart"; cat="Home Appliances"; price=1199.00; stock=80; r=4.9; rev=360;
       name="Philips GC181 Heavy Weight 1000W Classic Dry Iron with Non-Stick Black Soleplate";
       desc="Traditional 1.6kg heavy pressing iron flattening tough cotton and linen wrinkles with ease.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=422; sId=1; sName="KathiravanMart"; cat="Home Appliances"; price=649.00; stock=95; r=4.8; rev=290;
       name="Bajaj DX-7 1000W Lightweight Dry Iron with Golden American Heritage Soleplate";
       desc="Super smooth gliding with thermal fuse cut-off and 360-degree swivel swivel cord.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=423; sId=2; sName="TechNova"; cat="Home Appliances"; price=1699.00; stock=60; r=4.8; rev=230;
       name="Morphy Richards Super Glide 2000W Steam Iron with Multi-Directional Ceramic Plate";
       desc="Continuous 40g steam boost with vertical steaming mode for suits, curtains, and silks.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=424; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=499.00; stock=110; r=4.8; rev=280;
       name="Milton Executive Insulated Lunch Box with 3 Stainless Steel Leak-Proof Containers";
       desc="Thermosteel insulated carry pouch keeping chapati, sabzi, and dal piping hot until lunchtime.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=425; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=699.00; stock=90; r=4.9; rev=330;
       name="Tupperware Aquasafe 1-Liter Ergonomic Water Bottles (Set of 4 Multicolor)";
       desc="BPA-free food safe fridge bottles with flip-top spouts and tabbed caps for easy opening.";
       img="https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=500" },
    @{ id=426; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=599.00; stock=85; r=4.8; rev=210;
       name="Signoraware Besto Microwave Safe Air-Tight Food Storage Containers (Set of 6)";
       desc="Stackable modular modular boxes keeping snacks, pulses, and dry foods fresh and pest-free.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=427; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=499.00; stock=95; r=4.8; rev=260;
       name="Amazon Brand Solimo Stainless Steel Cutlery Set 24-Piece with Revolving Stand";
       desc="Includes 6 dinner spoons, 6 forks, 6 dessert spoons, and 6 teaspoons in mirror chrome finish.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=428; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=149.00; stock=160; r=4.7; rev=180;
       name="Pigeon Stainless Steel Kitchen Scissors & Ultra-Sharp Serrated Peeler Combo";
       desc="Multipurpose shears cracking nuts and cutting poultry bones alongside ergonomic vegetable peeler.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=429; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=199.00; stock=130; r=4.8; rev=170;
       name="Anjali Diamond Stainless Steel Vegetable & Fruit Cutter with Push Lock";
       desc="Sharp laser-edged blades cutting chillies, lady's finger, and beans in one swift press.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=430; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=349.00; stock=90; r=4.8; rev=150;
       name="Royalford Non-Stick Carbon Steel 12-Cup Muffin & Cupcake Baking Tray";
       desc="Even heat distribution pan releasing baked treats cleanly without sticking or burning.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=431; sId=3; sName="UrbanStyle"; cat="Home & Kitchen"; price=249.00; stock=120; r=4.7; rev=190;
       name="Kuber Industries Water & Stain Resistant PVC Dining Table Cover (6-Seater)";
       desc="Embossed lace border wipe-clean transparent sheet protecting wooden tables from heat and spills.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=432; sId=3; sName="UrbanStyle"; cat="Home & Kitchen"; price=1299.00; stock=60; r=4.9; rev=240;
       name="SPACES 100% Cotton 300 TC Luxury King Size Bedsheet with 2 Pillow Covers";
       desc="Sateen weave silky breathable bedspread woven from long-staple Indian combed cotton.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=433; sId=3; sName="UrbanStyle"; cat="Home & Kitchen"; price=1699.00; stock=50; r=4.9; rev=220;
       name="Raymond Home Microfiber All-Season Reversible AC Quilt Blanket (Double Bed)";
       desc="Soft 200 GSM hypoallergenic microfiber filling with neat diamond stitching and contrast piping.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=434; sId=3; sName="UrbanStyle"; cat="Home & Kitchen"; price=599.00; stock=80; r=4.8; rev=180;
       name="Cortina Floral Jacquard Eyelet Door Curtains 7 Feet Long (Pack of 2)";
       desc="Drapes with rust-proof metal eyelets sliding smoothly along curtain rods and filtering sunlight.";
       img="https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?w=500" },
    @{ id=435; sId=1; sName="KathiravanMart"; cat="Home & Kitchen"; price=499.00; stock=85; r=4.8; rev=210;
       name="Home Centre Stoneware Ceramic Tea & Coffee Mugs Set of 6 (300ml Multicolor)";
       desc="Microwave and dishwasher safe artisan glazed cups featuring comfortable curved handles.";
       img="https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500" },

    # --- FASHION, FOOTWEAR & WEARABLES (IDs 436-470) ---
    @{ id=436; sId=3; sName="UrbanStyle"; cat="Footwear"; price=1499.00; stock=65; r=4.9; rev=290;
       name="Bata Men's Formal Oxford Leather Lace-Up Office Shoes (Classic Black)";
       desc="Polished synthetic leather upper with cushioned footbed and slip-resistant TPR sole.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=437; sId=3; sName="UrbanStyle"; cat="Footwear"; price=1799.00; stock=50; r=4.8; rev=210;
       name="Bata Men's Hush Puppies Casual Slip-On Driving Loafers (Mocha Brown)";
       desc="Genuine leather comfort shoe with flexible grooved outsole for long commutes and walking.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=438; sId=3; sName="UrbanStyle"; cat="Footwear"; price=3499.00; stock=40; r=4.9; rev=320;
       name="Woodland Men's Khaki Leather Heavy Duty Outdoor Trekking Shoes";
       desc="Rugged nubuck leather with deep-lugged rubber tread conquering mountain trails and rocky paths.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=439; sId=3; sName="UrbanStyle"; cat="Footwear"; price=2499.00; stock=45; r=4.8; rev=230;
       name="Red Chief Men's Casual Rust Brown Genuine Leather Derby Shoes";
       desc="Handcrafted leather footwear with shock-absorbing polyurethane sole and breathable lining.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=440; sId=3; sName="UrbanStyle"; cat="Footwear"; price=2299.00; stock=75; r=4.9; rev=410;
       name="Puma Men's Softride Rift Lightweight Running & Walking Shoes";
       desc="Softride foam midsole cushioning every stride with breathable mesh upper and rubber traction.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=441; sId=3; sName="UrbanStyle"; cat="Footwear"; price=2499.00; stock=70; r=4.8; rev=360;
       name="Adidas Men's Dropline Lightweight Mesh Daily Running Shoes (Core Black)";
       desc="Ortholite sockliner with Cloudfoam cushioning and signature 3-stripe heritage branding.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=442; sId=3; sName="UrbanStyle"; cat="Footwear"; price=2999.00; stock=60; r=4.9; rev=380;
       name="Nike Men's Revolution 6 Next Nature Road Running Shoes";
       desc="Constructed with at least 20% recycled material, plush collar, and intuitive touch points.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=443; sId=3; sName="UrbanStyle"; cat="Footwear"; price=899.00; stock=110; r=4.8; rev=320;
       name="Campus Men's First Running Shoes with Memory Foam Midsole (Navy & Orange)";
       desc="Supportive arch design with breathable mesh and responsive pillowed footbed for morning jogs.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=444; sId=3; sName="UrbanStyle"; cat="Footwear"; price=649.00; stock=130; r=4.7; rev=290;
       name="Asian Men's Super King-01 Casual Sports Sneakers (White & Blue)";
       desc="Ultra lightweight trendy sneakers with air cushion heel and anti-skid rubber grip sole.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=445; sId=3; sName="UrbanStyle"; cat="Footwear"; price=2199.00; stock=80; r=4.9; rev=450;
       name="Crocs Unisex Classic Clog Lightweight Water Sandals (Navy Blue)";
       desc="Original Croslite foam cushioning with pivoting heel strap and ventilation ports that shed water.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=446; sId=3; sName="UrbanStyle"; cat="Footwear"; price=699.00; stock=120; r=4.8; rev=280;
       name="Sparx Men's Non-Slip Outdoor Sports Sandals with Velcro Straps";
       desc="Quick-drying synthetic straps with shock-absorbent EVA midsole for hiking and monsoon walks.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=447; sId=3; sName="UrbanStyle"; cat="Footwear"; price=249.00; stock=170; r=4.8; rev=390;
       name="Paragon Men's Daily Wear Soft Sole Flip Flops & Slippers (Black & Red)";
       desc="Durable waterproof rubber slippers engineered for everyday indoor and outdoor household comfort.";
       img="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" },
    @{ id=448; sId=3; sName="UrbanStyle"; cat="Clothes"; price=1799.00; stock=55; r=4.9; rev=340;
       name="Levi's Men's 511 Slim Fit Dark Blue Washed Denim Jeans";
       desc="Iconic red tab jeans with Comfort Stretch denim, sits below waist with slim leg from hip to ankle.";
       img="https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=500" },
    @{ id=449; sId=3; sName="UrbanStyle"; cat="Clothes"; price=1599.00; stock=60; r=4.8; rev=270;
       name="Pepe Jeans Men's Regular Fit Mid-Rise Blue Denim Jeans";
       desc="Durable premium cotton weave with whiskering wash effects and sturdy metal zipper fly.";
       img="https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=500" },
    @{ id=450; sId=3; sName="UrbanStyle"; cat="Clothes"; price=1499.00; stock=50; r=4.8; rev=210;
       name="Wrangler Men's Regular Fit Solid Rugged Tough Denim Jeans";
       desc="Deep indigo denim engineered with 7 belt loops, flat copper rivets, and reinforced back pockets.";
       img="https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=500" },
    @{ id=451; sId=3; sName="UrbanStyle"; cat="Clothes"; price=899.00; stock=90; r=4.9; rev=380;
       name="Allen Solly Men's Slim Fit Polo Collar T-Shirt (Navy Blue Cotton)";
       desc="100% combed cotton pique fabric with ribbed collar, 2-button placket, and embroidered stag emblem.";
       img="https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500" },
    @{ id=452; sId=3; sName="UrbanStyle"; cat="Clothes"; price=999.00; stock=85; r=4.8; rev=330;
       name="U.S. Polo Assn. Men's Solid Pure Cotton Casual Polo T-Shirt (White)";
       desc="Breathable tailored fit polo shirt with contrast collar tipping and signature horse logo.";
       img="https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500" },
    @{ id=453; sId=3; sName="UrbanStyle"; cat="Clothes"; price=1299.00; stock=60; r=4.9; rev=260;
       name="Van Heusen Men's Formal Regular Fit Button-Down Shirt (Sky Blue)";
       desc="Wrinkle-resistant easy care fabric with sharp pointed collar and barrel cuffs for business wear.";
       img="https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500" },
    @{ id=454; sId=3; sName="UrbanStyle"; cat="Clothes"; price=1499.00; stock=50; r=4.9; rev=240;
       name="Arrow Men's Formal Wrinkle-Resistant Cotton Shirt (Classic Pearl White)";
       desc="Autopress finish keeping you sharp from morning boardroom meetings to evening events.";
       img="https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500" },
    @{ id=455; sId=3; sName="UrbanStyle"; cat="Clothes"; price=1899.00; stock=40; r=4.9; rev=190;
       name="Raymond Men's 100% Pure Natural Linen Full Sleeve Shirt (Light Pink)";
       desc="Airy lightweight pure flax linen providing unmatched breathability during hot tropical summers.";
       img="https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500" },
    @{ id=456; sId=3; sName="UrbanStyle"; cat="Clothes"; price=1699.00; stock=45; r=4.8; rev=170;
       name="Monte Carlo Men's Pure Wool High Neck Warm Winter Pullover Sweater";
       desc="Fine gauge Australian wool blend knitting retaining warmth during chilly winters.";
       img="https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500" },
    @{ id=457; sId=3; sName="UrbanStyle"; cat="Clothes"; price=449.00; stock=140; r=4.9; rev=480;
       name="Jockey Men's 100% Super Combed Cotton Round Neck Undershirts (Pack of 3)";
       desc="Tagless comfort with rib trim neckline and contoured armholes for all-day sweat absorption.";
       img="https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500" },
    @{ id=458; sId=3; sName="UrbanStyle"; cat="Clothes"; price=599.00; stock=120; r=4.9; rev=390;
       name="Jockey Men's Super Combed Cotton Woven Boxer Shorts with Pockets (Pack of 2)";
       desc="Soft elastic waistband with functional fly and deep side pockets for lounge relaxation.";
       img="https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=500" },
    @{ id=459; sId=2; sName="TechNova"; cat="Watches"; price=1199.00; stock=85; r=4.8; rev=290;
       name="Fastrack Men's Casual Analog Black Dial Silicone Strap Watch";
       desc="Youthful rugged case with 50m water resistance, mineral glass dial, and quartz movement.";
       img="https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=500" },
    @{ id=460; sId=2; sName="TechNova"; cat="Watches"; price=2495.00; stock=65; r=4.9; rev=340;
       name="Titan Neo Analog Dial Men's Stainless Steel Silver Watch";
       desc="Sleek sunray dial with silver indices, date window, and polished stainless steel link bracelet.";
       img="https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=500" },
    @{ id=461; sId=2; sName="TechNova"; cat="Watches"; price=3295.00; stock=40; r=4.8; rev=190;
       name="Timex Expedition Scout Analog Watch with Indiglo Night-Light Dial";
       desc="Military field watch with rugged brass case, quick-date window, and genuine leather strap.";
       img="https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=500" },
    @{ id=462; sId=2; sName="TechNova"; cat="Watches"; price=6995.00; stock=30; r=4.9; rev=230;
       name="Fossil Men's Grant Chronograph Stainless Steel Quartz Watch";
       desc="Roman numeral markers with triple chronograph sub-dials and vintage aviation aesthetic.";
       img="https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=500" },
    @{ id=463; sId=2; sName="TechNova"; cat="Watches"; price=3495.00; stock=50; r=4.9; rev=410;
       name="Casio Vintage Digital Gold-Plated Steel Watch (A168WG-9WDF)";
       desc="Retro electro-luminescence backlight with 1/100-second stopwatch, daily alarm, and auto-calendar.";
       img="https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=500" },
    @{ id=464; sId=3; sName="UrbanStyle"; cat="Accessories"; price=1499.00; stock=60; r=4.9; rev=260;
       name="Tommy Hilfiger Genuine Leather Bifold Wallet with Coin Pocket";
       desc="Handcrafted top-grain leather wallet with 6 card slots, double currency billfold, and gift box.";
       img="https://images.unsplash.com/photo-1627123424574-724758594e93?w=500" },
    @{ id=465; sId=3; sName="UrbanStyle"; cat="Accessories"; price=599.00; stock=110; r=4.8; rev=290;
       name="Wildcraft Genuine Leather RFID Blocking Men's Slim Wallet";
       desc="Shields debit and credit cards against digital pickpocketing with scratch-resistant leather.";
       img="https://images.unsplash.com/photo-1627123424574-724758594e93?w=500" },
    @{ id=466; sId=3; sName="UrbanStyle"; cat="Accessories"; price=5990.00; stock=25; r=4.9; rev=310;
       name="Ray-Ban Aviator Classic UV Protection Polarized Sunglasses (Gold Frame)";
       desc="Timeless teardrop pilot shape with G-15 crystal green lenses blocking 100% harmful UV rays.";
       img="https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=500" },
    @{ id=467; sId=3; sName="UrbanStyle"; cat="Accessories"; price=899.00; stock=85; r=4.8; rev=220;
       name="Fastrack UV-Protected Square Sunglasses for Men & Women (Matte Black)";
       desc="Lightweight polycarbonate frame with impact resistant tinted lenses for sunny rides.";
       img="https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=500" },
    @{ id=468; sId=3; sName="UrbanStyle"; cat="Accessories"; price=1499.00; stock=75; r=4.9; rev=330;
       name="American Tourister 32L Casual Laptop Backpack (Black & Teal Teal)";
       desc="Treated water resistant polyester with dedicated 15.6-inch laptop pocket and rain cover.";
       img="https://images.unsplash.com/photo-1622560480605-d83c853bc5c3?w=500" },
    @{ id=469; sId=3; sName="UrbanStyle"; cat="Accessories"; price=2499.00; stock=45; r=4.8; rev=210;
       name="Safari Thorium Neo 55cm Polycarbonate Cabin Luggage Trolley Bag";
       desc="Ultra tough scratch-resistant hard shell with 360-degree silent spinner wheels and TSA lock.";
       img="https://images.unsplash.com/photo-1581553680321-4fffae59fccd?w=500" },
    @{ id=470; sId=3; sName="UrbanStyle"; cat="Accessories"; price=2999.00; stock=35; r=4.8; rev=180;
       name="Aristocrat 65cm Medium Check-in Hard Trolley Luggage (Silver Grey)";
       desc="Spacious expandable packing volume with corner protectors and combination lock for flights.";
       img="https://images.unsplash.com/photo-1581553680321-4fffae59fccd?w=500" },

    # --- PERSONAL CARE, BEAUTY & GROOMING (IDs 471-495) ---
    @{ id=471; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=499.00; stock=110; r=4.8; rev=350;
       name="L'Oreal Paris Total Repair 5 Restoring Hair Shampoo with Keratin-XS (650ml)";
       desc="Fights 5 visible signs of damaged hair: hair fall, dryness, roughness, dullness, and split ends.";
       img="https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?w=500" },
    @{ id=472; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=460.00; stock=95; r=4.8; rev=280;
       name="Tresemme Keratin Smooth Infused Argan Oil Hair Shampoo (580ml)";
       desc="Controls frizz for up to 3 days giving salon smooth hair with micro-moisture technology.";
       img="https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?w=500" },
    @{ id=473; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=485.00; stock=120; r=4.9; rev=390;
       name="Dove Intense Repair Damage Therapy Hair Shampoo with Nutri-Keratin (650ml)";
       desc="Deeply nourishes fragile cuticles to rebuild hair strength from inside out with 1/4 moisturizing milk.";
       img="https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?w=500" },
    @{ id=474; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=440.00; stock=100; r=4.7; rev=260;
       name="Pantene Advanced Hairfall Control Pro-Vitamin Shampoo (650ml)";
       desc="Enriched with fermented rice water and Pro-V formula reducing hair breakage significantly.";
       img="https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?w=500" },
    @{ id=475; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=260.00; stock=130; r=4.8; rev=210;
       name="Himalaya Herbals Anti-Hair Fall Bhringaraja & Butea Frondosa Shampoo (400ml)";
       desc="Ayurvedic herbal extract formula strengthening hair roots and stimulating scalp microcirculation.";
       img="https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?w=500" },
    @{ id=476; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=320.00; stock=140; r=4.9; rev=420;
       name="Nivea Soft Light Moisturizing Cream with Vitamin E & Jojoba Oil (300ml)";
       desc="Fast absorbing refreshing formula providing instant hydration to face, hands, and body.";
       img="https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500" },
    @{ id=477; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=280.00; stock=150; r=4.8; rev=360;
       name="Pond's Super Light Gel Oil-Free Face Moisturizer with Hyaluronic Acid (147g)";
       desc="Water-fresh 24-hour hydration gel locking in plump moisture with non-greasy natural glow.";
       img="https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500" },
    @{ id=478; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=499.00; stock=85; r=4.9; rev=310;
       name="Cetaphil Gentle Skin Cleanser for Sensitive & Dry Skin (250ml Bottle)";
       desc="Dermatologist recommended soap-free non-comedogenic cleanser soothing sensitive face skin.";
       img="https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500" },
    @{ id=479; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=420.00; stock=90; r=4.8; rev=240;
       name="Cetaphil Moisturizing Cream for Chronic Dry Skin with Sweet Almond Oil (100g)";
       desc="Intense 48-hour moisture nourishment restoring the skin's natural protective lipid barrier.";
       img="https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500" },
    @{ id=480; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=230.00; stock=110; r=4.7; rev=180;
       name="Biotique Bio Kelp Fresh Growth Protein Shampoo for Falling Hair (340ml)";
       desc="Blended with pure kelp seaweed, peppermint oil, and mint leaf extract for invigorated scalp.";
       img="https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?w=500" },
    @{ id=481; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=349.00; stock=130; r=4.8; rev=330;
       name="Mamaearth Onion Hair Oil with Red Onion Seed Oil & Bhringraj (250ml)";
       desc="Non-sticky formula rich in sulfur, potassium, and plant antioxidants to control hair thinning.";
       img="https://images.unsplash.com/photo-1608248597359-59754b2d3550?w=500" },
    @{ id=482; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=349.00; stock=120; r=4.8; rev=290;
       name="WOW Skin Science Organic Apple Cider Vinegar Foaming Face Wash (150ml)";
       desc="Built-in gentle silicone face brush removing dead cells, clearing acne, and balancing skin pH.";
       img="https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500" },
    @{ id=483; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=320.00; stock=105; r=4.9; rev=370;
       name="Garnier Skin Naturals All-in-1 Micellar Cleansing Water (400ml Bottle)";
       desc="Lifts dirt, makeup, and pollution particles like a magnet without harsh rubbing or stinging.";
       img="https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500" },
    @{ id=484; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=799.00; stock=70; r=4.8; rev=210;
       name="Lakme Absolute Skin Natural Mousse Foundation SPF 8 (25g Ivory Fair)";
       desc="Feather-light whipped texture smoothing pores with matte velvet finish lasting up to 16 hours.";
       img="https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500" },
    @{ id=485; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=249.00; stock=160; r=4.8; rev=340;
       name="Maybelline New York Colossal Bold Water-Resistant Black Eyeliner (3ml)";
       desc="Precision flexi-tip applicator drawing deep jet black lines drying in just seconds without smudging.";
       img="https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500" },
    @{ id=486; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=649.00; stock=90; r=4.9; rev=310;
       name="Maybelline New York Lash Sensational Sky High Waterproof Volumizing Mascara";
       desc="Bamboo extract enriched fiber formula extending each lash from root to tip for limitless volume.";
       img="https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500" },
    @{ id=487; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=299.00; stock=110; r=4.8; rev=220;
       name="Colorbar Velvet Matte Creamy Lipstick (4.2g Bare Kiss Nude)";
       desc="Enriched with vitamin E and jojoba oil delivering rich pigment and creamy matte comfort.";
       img="https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500" },
    @{ id=488; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=280.00; stock=100; r=4.9; rev=290;
       name="Old Spice Original Masculine After Shave Atomizer Lotion (150ml)";
       desc="The classic unmistakable scent of spices and coolness invigorating freshly shaved skin.";
       img="https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?w=500" },
    @{ id=489; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=899.00; stock=75; r=4.8; rev=230;
       name="Bombay Shaving Company 6-in-1 Precision Beard Grooming & Shaving Kit";
       desc="Includes pre-shave scrub, precision safety razor, foaming cream, post-shave balm, and towel.";
       img="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500" },
    @{ id=490; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=849.00; stock=80; r=4.9; rev=380;
       name="Gillette Fusion5 Men's Razor Handle with 4 Anti-Friction Blade Cartridges";
       desc="5 closely spaced power blades with precision rear trimmer for edge shaping around the mustache.";
       img="https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=500" },
    @{ id=491; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=299.00; stock=120; r=4.8; rev=270;
       name="Beardo Godfather Nourishing Beard Oil with Almond & Argan (30ml)";
       desc="Conditions coarse facial whiskers, stops beard itchiness, and promotes thicker fuller beard growth.";
       img="https://images.unsplash.com/photo-1608248597359-59754b2d3550?w=500" },
    @{ id=492; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=499.00; stock=85; r=4.7; rev=190;
       name="Ustraa Hair Growth Vitalizer Serum with Redensyl & Jojoba (100ml)";
       desc="Stimulates dormant hair follicles, reduces scalp oiliness, and increases hair shaft thickness.";
       img="https://images.unsplash.com/photo-1608248597359-59754b2d3550?w=500" },
    @{ id=493; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=175.00; stock=160; r=4.9; rev=360;
       name="Sensodyne Rapid Relief Fast Action Toothpaste for Sensitive Teeth (80g)";
       desc="Clinically proven formula creating a protective seal over sensitive dentin in 60 seconds.";
       img="https://images.unsplash.com/photo-1559591937-e62fb3d69481?w=500" },
    @{ id=494; sId=3; sName="UrbanStyle"; cat="Personal Care"; price=249.00; stock=140; r=4.8; rev=310;
       name="Listerine Cool Mint Antiseptic Germ-Kill Refreshing Mouthwash (500ml)";
       desc="Kills 99.9% of bad breath germs that brushing misses and prevents gum plaque buildup.";
       img="https://images.unsplash.com/photo-1559591937-e62fb3d69481?w=500" },
    @{ id=495; sId=2; sName="TechNova"; cat="Personal Care"; price=1499.00; stock=65; r=4.9; rev=280;
       name="Oral-B Vitality CrossAction Electric Rechargeable Toothbrush with Timer";
       desc="Oscillating round brush head removing 100% more plaque than a standard manual toothbrush.";
       img="https://images.unsplash.com/photo-1559591937-e62fb3d69481?w=500" },

    # --- SPORTS, FITNESS, AUTO & STATIONERY (IDs 496-525) ---
    @{ id=496; sId=3; sName="UrbanStyle"; cat="Sports & Fitness"; price=699.00; stock=75; r=4.8; rev=210;
       name="Cosco Light Weight Synthetic Rubber Basketball (Size 7 Official)";
       desc="Nylon-wound carcass with pebbled surface providing superior grip on asphalt and hardwood courts.";
       img="https://images.unsplash.com/photo-1546519638-68e109498ffc?w=500" },
    @{ id=497; sId=3; sName="UrbanStyle"; cat="Sports & Fitness"; price=499.00; stock=90; r=4.8; rev=270;
       name="Nivia Storm Moulded Rubber Football Size 5 for Grass & Hard Turf";
       desc="Multi-layer construction with 32-panel aerodynamic design and airtight butyl bladder.";
       img="https://images.unsplash.com/photo-1511886929837-354d827aae26?w=500" },
    @{ id=498; sId=3; sName="UrbanStyle"; cat="Sports & Fitness"; price=2999.00; stock=35; r=4.9; rev=230;
       name="SG Savage Xtreme English Willow Cricket Bat Full Size (Short Handle)";
       desc="Thick edges and contoured toe delivering massive sweet spot power for stroke play and boundaries.";
       img="https://images.unsplash.com/photo-1531415074868-036b107e775a?w=500" },
    @{ id=499; sId=3; sName="UrbanStyle"; cat="Sports & Fitness"; price=1799.00; stock=45; r=4.8; rev=190;
       name="MRF Grand Edition Kashmir Willow Cricket Bat with Padded Full Cover";
       desc="Selected grain willow with curved blade profile balanced for club cricket and tennis ball matches.";
       img="https://images.unsplash.com/photo-1531415074868-036b107e775a?w=500" },
    @{ id=500; sId=3; sName="UrbanStyle"; cat="Sports & Fitness"; price=399.00; stock=130; r=4.8; rev=310;
       name="Cosco Cricket Heavy Weight Tennis Ball Pack of 6 (Vibrant Red)";
       desc="High bounce wool felt tennis balls engineered for gully cricket tournaments and practice nets.";
       img="https://images.unsplash.com/photo-1531415074868-036b107e775a?w=500" },
    @{ id=501; sId=3; sName="UrbanStyle"; cat="Sports & Fitness"; price=599.00; stock=65; r=4.7; rev=160;
       name="Cosco Super Volley Volleyball Official Size & Weight (18 Panels)";
       desc="Supple synthetic leather cover offering soft hand touch and true flight trajectory.";
       img="https://images.unsplash.com/photo-1546519638-68e109498ffc?w=500" },
    @{ id=502; sId=3; sName="UrbanStyle"; cat="Sports & Fitness"; price=799.00; stock=60; r=4.8; rev=175;
       name="Stag 1000 Table Tennis Racket Bat with Rubber Grip & Zippered Cover";
       desc="5-ply Nordic wood blade with ITTF approved inverted rubber for spin and fast rallies.";
       img="https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=500" },
    @{ id=503; sId=1; sName="KathiravanMart"; cat="Sports & Fitness"; price=249.00; stock=150; r=4.9; rev=360;
       name="Boldfit Adjustable Hand Gripper for Wrist & Forearm Strength (10kg to 60kg)";
       desc="Stainless steel spring resistance with non-slip ergonomic handles for wrist and finger rehab.";
       img="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=500" },
    @{ id=504; sId=1; sName="KathiravanMart"; cat="Sports & Fitness"; price=1499.00; stock=50; r=4.8; rev=210;
       name="Protoner 20kg PVC Home Gym Dumbbell Set with Rods & Weight Locks";
       desc="Complete kit with dumbbell rods, curl rod, star locks, and weights for full home body workouts.";
       img="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=500" },
    @{ id=505; sId=1; sName="KathiravanMart"; cat="Sports & Fitness"; price=649.00; stock=80; r=4.8; rev=180;
       name="Strauss Anti-Burst Balance Stability Exercise Swiss Gym Ball (65cm with Pump)";
       desc="Heavy duty PVC ball supporting up to 300kg for core strengthening, pilates, and back therapy.";
       img="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=500" },
    @{ id=506; sId=1; sName="KathiravanMart"; cat="Sports & Fitness"; price=599.00; stock=90; r=4.8; rev=240;
       name="Kore 10-in-1 Color-Coded Multi-Angle Push-Up Board with Silicone Grips";
       desc="Targets chest, shoulders, back, and triceps with guided color-coded slot positions.";
       img="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=500" },
    @{ id=507; sId=3; sName="UrbanStyle"; cat="Sports & Fitness"; price=599.00; stock=100; r=4.8; rev=260;
       name="Nivia Sports Gym Duffle Bag with Dedicated Ventilated Shoe Compartment";
       desc="Water-resistant ripstop polyester fabric with padded shoulder strap and dual water bottle mesh.";
       img="https://images.unsplash.com/photo-1622560480605-d83c853bc5c3?w=500" },
    @{ id=508; sId=3; sName="UrbanStyle"; cat="Accessories"; price=149.00; stock=220; r=4.9; rev=390;
       name="Cello FineGrip 0.7mm Smooth Ballpoint Pens (Pack of 25 Blue Pens)";
       desc="Laser tip writing technology with comfortable soft rubber grip for effortless long exam papers.";
       img="https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500" },
    @{ id=509; sId=3; sName="UrbanStyle"; cat="Accessories"; price=160.00; stock=200; r=4.8; rev=310;
       name="Reynolds 045 Fine Carbure Tip Blue Ballpoint Pens (Box of 20 Pens)";
       desc="The classic lightweight pen with laser glide tip ensuring smudge-proof skip-free notes.";
       img="https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500" },
    @{ id=510; sId=3; sName="UrbanStyle"; cat="Accessories"; price=249.00; stock=140; r=4.9; rev=270;
       name="Classmate 6-Subject Spiral Bound Long Notebook 300 Pages (Pack of 2)";
       desc="Chlorine-free bright ozone-treated white paper with durable poly cover and color dividers.";
       img="https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500" },
    @{ id=511; sId=2; sName="TechNova"; cat="Accessories"; price=495.00; stock=90; r=4.9; rev=310;
       name="Casio MJ-120D 150 Steps Check & Correct 12-Digit Desktop Calculator";
       desc="Dual solar & battery power with large display, tax calculation, and auto-review playback.";
       img="https://images.unsplash.com/photo-1587145820266-a5951ee6f620?w=500" },
    @{ id=512; sId=3; sName="UrbanStyle"; cat="Accessories"; price=120.00; stock=180; r=4.8; rev=230;
       name="Kangaro All-Metal Body Paper Desk Stapler with Box of 1000 Staples";
       desc="Heavy duty steel mechanism binding up to 30 sheets with built-in staple remover claw.";
       img="https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500" },
    @{ id=513; sId=3; sName="UrbanStyle"; cat="Accessories"; price=199.00; stock=160; r=4.8; rev=190;
       name="Scotch Transparent High-Tack Adhesive Packaging Tape (1-Inch, Pack of 6)";
       desc="Crystal clear moisture-resistant tape bonding envelopes, parcels, and study projects firmly.";
       img="https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500" },
    @{ id=514; sId=3; sName="UrbanStyle"; cat="Accessories"; price=85.00; stock=210; r=4.9; rev=320;
       name="Fevicol MR General Purpose White Synthetic Craft Adhesive (200g Squeeze Bottle)";
       desc="Non-toxic non-staining adhesive bonding paper, cardboard, thermocol, and craft fabric cleanly.";
       img="https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500" },
    @{ id=515; sId=3; sName="UrbanStyle"; cat="Accessories"; price=240.00; stock=140; r=4.9; rev=350;
       name="Pilot V7 Hi-Tecpoint Pure Liquid Ink Rollerball Pens (Pack of 3 Blue)";
       desc="0.7mm tungsten carbide ball with unique ink flow controller for intensely vibrant handwriting.";
       img="https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500" },
    @{ id=516; sId=3; sName="UrbanStyle"; cat="Accessories"; price=125.00; stock=170; r=4.8; rev=220;
       name="Luxor 5-Color Chisel Tip Fluorescent Highlighter Marker Pens Set";
       desc="Non-toxic water-based ink that doesn't bleed through paper; ideal for textbooks and notes.";
       img="https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500" },
    @{ id=517; sId=2; sName="TechNova"; cat="Automotive & Biking"; price=849.00; stock=75; r=4.9; rev=240;
       name="Bosch Aerotwin Universal Aerodynamic Wiper Blades for Cars (Set of 2)";
       desc="Evodium steel strip with patented rubber coating ensuring streak-free quiet rain wiping.";
       img="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500" },
    @{ id=518; sId=1; sName="KathiravanMart"; cat="Automotive & Biking"; price=320.00; stock=110; r=4.8; rev=270;
       name="3M Concentrated High Foaming Snow Car Wash Shampoo (1-Liter Bottle)";
       desc="pH balanced formula lifting stubborn road grime and bug stains without removing protective car wax.";
       img="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500" },
    @{ id=519; sId=1; sName="KathiravanMart"; cat="Automotive & Biking"; price=499.00; stock=80; r=4.8; rev=190;
       name="Turtle Wax Scratch & Swirl Remover Precision Polishing Compound (473ml)";
       desc="Micro-fine polishing agents restoring cloudy paint, removing fingernail marks, and reviving shine.";
       img="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500" },
    @{ id=520; sId=1; sName="KathiravanMart"; cat="Automotive & Biking"; price=420.00; stock=90; r=4.9; rev=230;
       name="Formula 1 High-Gloss Carnauba Paste Wax for Cars & Bikes (230g Tin)";
       desc="Pure #1 yellow carnauba wax offering water-beading barrier and deep show-car mirror shine.";
       img="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500" },
    @{ id=521; sId=1; sName="KathiravanMart"; cat="Automotive & Biking"; price=249.00; stock=150; r=4.8; rev=280;
       name="Ambi Pur Car Vent Clip Fragrance Air Freshener Lavender (Pack of 2 Clips)";
       desc="Eliminates stubborn cigarette, food, and AC odors with adjustable freshness dial for 60 days.";
       img="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500" },
    @{ id=522; sId=1; sName="KathiravanMart"; cat="Automotive & Biking"; price=399.00; stock=100; r=4.8; rev=210;
       name="WaveX Multi-Surface Car Interior Dashboard Polish & Vinyl Cleaner (350ml)";
       desc="Non-greasy UV protectant preventing dashboard fading, cracking, and dust attraction.";
       img="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500" },
    @{ id=523; sId=2; sName="TechNova"; cat="Automotive & Biking"; price=499.00; stock=120; r=4.8; rev=310;
       name="Portronics Clamp M2 360-Degree Rotation Car Dashboard Mobile Mount Holder";
       desc="Ultra-strong suction cup with telescopic arm and quick release button for GPS navigation.";
       img="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500" },
    @{ id=524; sId=2; sName="TechNova"; cat="Automotive & Biking"; price=2899.00; stock=40; r=4.9; rev=260;
       name="Xiaomi Mi Portable Electric Air Compressor 2 Tyre Pump (150 PSI with Screen)";
       desc="Rechargeable cordless pump inflating car, motorcycle, and cycle tyres with digital preset stop.";
       img="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=500" },
    @{ id=525; sId=3; sName="UrbanStyle"; cat="Automotive & Biking"; price=1499.00; stock=50; r=4.9; rev=290;
       name="Steelbird SB-50 Adonis Classic Full Face ISI Certified Motorcycle Helmet (Matte Black)";
       desc="High impact ABS shell with quick-release chinstrap, dynamic ventilation, and anti-fog visor.";
       img="https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=500" }
)

Write-Host "Total new products defined: $($items.Count)"
if ($items.Count -ne 315) {
    Write-Error "Expected 315 items, found $($items.Count)"
}

# 1. Format JS product lines
$jsLines = [System.Collections.Generic.List[string]]::new()
$jsLines.Add("    // 18. MEGA CATALOG EXPANSION (IDs 211-525 - Flipkart, Medicines, Mobiles, Hardware, Pantry & Gear)")

foreach ($item in $items) {
    $priceStr = ("{0:0.00}" -f $item.price)
    $nameEsc = $item.name.Replace('"', '\"')
    $line = "    { id: $($item.id), sellerId: $($item.sId), sellerName: `"$($item.sName)`", name: `"$nameEsc`", category: `"$($item.cat)`", price: $priceStr, stock: $($item.stock), rating: $($item.r), reviews: $($item.rev), image: `"$($item.img)`", active: true },"
    $jsLines.Add($line)
}

# Remove trailing comma on last item
$lastIdx = $jsLines.Count - 1
$jsLines[$lastIdx] = $jsLines[$lastIdx].TrimEnd(',')

$jsBlock = $jsLines -join "`r`n"

# 2. Format SQL rows
$sqlLines = [System.Collections.Generic.List[string]]::new()
$sqlLines.Add("-- Mega Catalog Expansion (IDs 211-525)")

foreach ($item in $items) {
    $priceStr = ("{0:0.00}" -f $item.price)
    $nameSql = $item.name.Replace("'", "''")
    $descSql = $item.desc.Replace("'", "''")
    $line = "($($item.id), $($item.sId), '$nameSql', '$descSql', $priceStr, $($item.stock), '$($item.cat)', '$($item.img)', TRUE, CURRENT_TIMESTAMP),"
    $sqlLines.Add($line)
}

$lastSqlIdx = $sqlLines.Count - 1
$sqlLines[$lastSqlIdx] = $sqlLines[$lastSqlIdx].TrimEnd(',') + ";"

$sqlBlock = $sqlLines -join "`r`n"

Write-Host "Formatting completed successfully."

# 3. Update preview.html
Write-Host "Updating preview.html..."
$previewRaw = [System.IO.File]::ReadAllText("c:\Users\ELCOT\Desktop\kathiravan\preview.html", [System.Text.Encoding]::UTF8)

# Product 210 replacement marker
$targetProd210 = '    { id: 210, sellerId: 3, sellerName: "UrbanStyle", name: "Parker Vector Stainless Steel Chrome Trim Rollerball Pen in Gift Box", category: "Accessories", price: 349.00, stock: 130, rating: 4.9, reviews: 155, image: "https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500", active: true }'
$replacementProd210 = $targetProd210 + ",`r`n" + $jsBlock

if (-not $previewRaw.Contains($targetProd210)) {
    Write-Error "Could not find targetProd210 in preview.html!"
}

$previewUpdated = $previewRaw.Replace($targetProd210, $replacementProd210)

# Update textual counts
$previewUpdated = $previewUpdated.Replace("Shop 210+", "Shop 525+")
$previewUpdated = $previewUpdated.Replace("Browse 210+", "Browse 525+")
$previewUpdated = $previewUpdated.Replace("210+ Products", "525+ Products")
$previewUpdated = $previewUpdated.Replace("All Categories (210+)", "All Categories (525+)")
$previewUpdated = $previewUpdated.Replace("All Products (210)", "All Products (525)")
$previewUpdated = $previewUpdated.Replace("140+ Deals", "300+ Deals")
$previewUpdated = $previewUpdated.Replace("90+ Deals", "180+ Deals")
$previewUpdated = $previewUpdated.Replace("(140+)", "(300+)")
$previewUpdated = $previewUpdated.Replace("(90+)", "(180+)")
$previewUpdated = $previewUpdated.Replace("View All 210 Products", "View All 525 Products")

# Add missing category options to #catFilter
$targetCatOption = '<option value="Watches">⌚ Watches & Bands</option>'
$replacementCatOption = "<option value=""Watches"">⌚ Watches & Bands</option>`r`n                    <option value=""Sports & Fitness"">🏋️ Sports & Fitness</option>`r`n                    <option value=""Automotive & Biking"">🚗 Automotive & Biking</option>"
$previewUpdated = $previewUpdated.Replace($targetCatOption, $replacementCatOption)

# Add missing quick filter pills
$targetPill = 'onclick="setQuickFilter(''Watches'')"'
$replacementPill = "onclick=""setQuickFilter('Sports & Fitness')"" style=""background: #059669; color: white; border: none; font-weight: bold; border-radius: 20px; padding: 0.35rem 0.85rem; font-size: 0.85rem; box-shadow: 0 2px 4px rgba(0,0,0,0.2);"">🏋️ Sports</button>`r`n                <button type=""button"" class=""btn btn-sm"" onclick=""setQuickFilter('Automotive & Biking')"" style=""background: #4338ca; color: white; border: none; font-weight: bold; border-radius: 20px; padding: 0.35rem 0.85rem; font-size: 0.85rem; box-shadow: 0 2px 4px rgba(0,0,0,0.2);"">🚗 Auto</button>`r`n                <button type=""button"" class=""btn btn-sm"" onclick=""setQuickFilter('Watches')"""
$previewUpdated = $previewUpdated.Replace($targetPill, $replacementPill)

[System.IO.File]::WriteAllText("c:\Users\ELCOT\Desktop\kathiravan\preview.html", $previewUpdated, [System.Text.Encoding]::UTF8)
Write-Host "preview.html updated."

# 4. Update seed.sql
Write-Host "Updating seed.sql..."
$seedRaw = [System.IO.File]::ReadAllText("c:\Users\ELCOT\Desktop\kathiravan\seed.sql", [System.Text.Encoding]::UTF8)

$targetSeed210 = "(210, 3, 'Parker Vector Stainless Steel Chrome Trim Rollerball Pen in Gift Box', 'Iconic arrow clip with smooth free-flowing rollerball refill for signatures and examinations.', 349.00, 130, 'Accessories', 'https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500', TRUE, CURRENT_TIMESTAMP);"
$replacementSeed210 = "(210, 3, 'Parker Vector Stainless Steel Chrome Trim Rollerball Pen in Gift Box', 'Iconic arrow clip with smooth free-flowing rollerball refill for signatures and examinations.', 349.00, 130, 'Accessories', 'https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=500', TRUE, CURRENT_TIMESTAMP),`r`n" + $sqlBlock

if (-not $seedRaw.Contains($targetSeed210)) {
    Write-Error "Could not find targetSeed210 in seed.sql!"
}

$seedUpdated = $seedRaw.Replace($targetSeed210, $replacementSeed210)
[System.IO.File]::WriteAllText("c:\Users\ELCOT\Desktop\kathiravan\seed.sql", $seedUpdated, [System.Text.Encoding]::UTF8)
Write-Host "seed.sql updated."

# 5. Synchronize all mirror files
Write-Host "Mirroring files across project directories..."
Copy-Item "c:\Users\ELCOT\Desktop\kathiravan\preview.html" "c:\Users\ELCOT\Desktop\kathiravan\index.html" -Force
Copy-Item "c:\Users\ELCOT\Desktop\kathiravan\preview.html" "c:\Users\ELCOT\Desktop\kathiravan\src\main\webapp\preview.html" -Force
Copy-Item "c:\Users\ELCOT\Desktop\kathiravan\preview.html" "c:\Users\ELCOT\Desktop\kathiravan\src\main\webapp\index.html" -Force
Copy-Item "c:\Users\ELCOT\Desktop\kathiravan\seed.sql" "c:\Users\ELCOT\Desktop\kathiravan\db\seed.sql" -Force

Write-Host "All project files successfully synchronized to 525 products!"

