HarvestMerge.SolventNodes = { ["en"] = { [1] = "Pure Water", [2] = "Water Skin", }, ["de"] = { [1] = "Reines Wasser", [2] = "Wasserhaut", }, ["fr"] = { [1] = "Eau Pure", [2] = "Outre d'Eau", }, }
HarvestMerge.PotencyRunes = { ["en"] = {"Potency Rune"}, ["de"] = {"Machtrune"}, ["fr"] = {"Rune de Puissance"}, }
HarvestMerge.EssenceRunes = { ["en"] = {"Essence Rune"}, ["de"] = {"Essenzrune"}, ["fr"] = {"Rune D'essence"}, }
HarvestMerge.AspectRunes = { ["en"] = {"Aspect Rune"}, ["de"] = {"Aspektrune"}, ["fr"] = {"Rune d'Aspect"}, }

HarvestMerge.NodeArray = {
    -- : Mining
    [1] = {
        { itemID = 808, nodeName = { ["en"] = {"Iron Ore"}, ["de"] = {"Eisenerz"}, ["fr"] = {"Minerai de Fer"} }, itemName = {"Iron Ore"} },--V
        { itemID = 4482, nodeName = { ["en"] = {"Calcinium Ore"}, ["de"] = {"Kalciniumerz"}, ["fr"] = {"Minerai de Calcinium"} }, itemName = {"Calcinium Ore"} },
        { itemID = 5820, nodeName = { ["en"] = {"High Iron Ore"}, ["de"] = {"Feineisenerz"}, ["fr"] = {"Minerai de Fer Noble"} }, itemName = {"High Iron Ore"} },--V
        { itemID = 23103, nodeName = { ["en"] = {"Orichalcum Ore"}, ["de"] = {"Oreichalkoserz"}, ["fr"] = {"Minerai D'orichalque"} }, itemName = {"Orichalcum Ore"} },--V
        { itemID = 23104, nodeName = { ["en"] = {"Dwarven Ore"}, ["de"] = {"Dwemererz"}, ["fr"] = {"Minerai Dwemer"} }, itemName = {"Dwarven Ore"} },--V
        { itemID = 23105, nodeName = { ["en"] = {"Ebony Ore"}, ["de"] = {"Ebenerz"}, ["fr"] = {"Minerai d'Ebonite"} }, itemName = {"Ebony Ore"} },
        { itemID = 23133, nodeName = { ["en"] = {"Galatite Ore"}, ["de"] = {"Galatiterz"}, ["fr"] = {"Minerai de Galatite"} }, itemName = {"Galatite Ore"} },
        { itemID = 23134, nodeName = { ["en"] = {"Quicksilver Ore"}, ["de"] = {"Quicksilver Ore"}, ["fr"] = {"Quicksilver Ore"} }, itemName = {"Quicksilver Ore"} },
        { itemID = 23135, nodeName = { ["en"] = {"Voidstone Ore"}, ["de"] = {"Leerensteinerz"}, ["fr"] = {"Minerai de Pierre de Vide"} }, itemName = {"Voidstone Ore"} },
    },
    -- : Clothing
    [2] = {
        { itemID = 812, nodeName = { ["en"] = {"Jute"}, ["de"] = {"Jute"}, ["fr"] = {"Jute"} }, itemName = {"Raw jute"} },--V
        { itemID = 4464, nodeName = { ["en"] = {"Flax"}, ["de"] = {"Flachs"}, ["fr"] = {"Lin"} }, itemName = {"Raw Flax"} },--V
        { itemID = 23129, nodeName = { ["en"] = {"Cotton"}, ["de"] = {"Baumwolle"}, ["fr"] = {"Coton"} }, itemName = {"Raw Cotton"} },--V
        { itemID = 23130, nodeName = { ["en"] = {"Spidersilk"}, ["de"] = {"Spinnenseide"}, ["fr"] = {"Toile D'araignée"} }, itemName = {"Raw Spidersilk"} },
        { itemID = 23131, nodeName = { ["en"] = {"Ebonthread"}, ["de"] = {"Ebenseide"}, ["fr"] = {"Fil d'Ebonite"} }, itemName = {"Raw Ebonthread"} },
        { itemID = 33217, nodeName = { ["en"] = {"Kreshweed"}, ["de"] = {"Kreshweed"}, ["fr"] = {"Kreshweed"} }, itemName = {"Raw Kreshweed"} },
        { itemID = 33218, nodeName = { ["en"] = {"Ironweed"}, ["de"] = {"Eisenkraut"}, ["fr"] = {"Herbe de fer"} }, itemName = {"Raw ironweed"} },
        { itemID = 33219, nodeName = { ["en"] = {"Silverweed"}, ["de"] = {"Silverweed"}, ["fr"] = {"Silverweed"} }, itemName = {"Raw Silverweed"} },
        { itemID = 33220, nodeName = { ["en"] = {"Void Bloom"}, ["de"] = {"Leere Blüte"}, ["fr"] = {"Tissu de Vide"} }, itemName = {"Raw Void Bloom"} },
    },
    -- : Enchanting
    [3] = {
        { itemID = 45806, nodeName = HarvestMerge.PotencyRunes, itemName = {"Jejora"} },
        { itemID = 45807, nodeName = HarvestMerge.PotencyRunes, itemName = {"Odra"} },
        { itemID = 45808, nodeName = HarvestMerge.PotencyRunes, itemName = {"Pojora"} },
        { itemID = 45809, nodeName = HarvestMerge.PotencyRunes, itemName = {"Edora"} },
        { itemID = 45810, nodeName = HarvestMerge.PotencyRunes, itemName = {"Jaera"} },
        { itemID = 45811, nodeName = HarvestMerge.PotencyRunes, itemName = {"Pora"} },
        { itemID = 45812, nodeName = HarvestMerge.PotencyRunes, itemName = {"Denara"} },
        { itemID = 45813, nodeName = HarvestMerge.PotencyRunes, itemName = {"Rera"} },
        { itemID = 45814, nodeName = HarvestMerge.PotencyRunes, itemName = {"Derado"} },
        { itemID = 45815, nodeName = HarvestMerge.PotencyRunes, itemName = {"Recura"} },
        { itemID = 45816, nodeName = HarvestMerge.PotencyRunes, itemName = {"Cura"} },
        { itemID = 45817, nodeName = HarvestMerge.PotencyRunes, itemName = {"Jode"} },
        { itemID = 45818, nodeName = HarvestMerge.PotencyRunes, itemName = {"Notade"} },
        { itemID = 45819, nodeName = HarvestMerge.PotencyRunes, itemName = {"Ode"} },
        { itemID = 45820, nodeName = HarvestMerge.PotencyRunes, itemName = {"Tade"} },
        { itemID = 45821, nodeName = HarvestMerge.PotencyRunes, itemName = {"Jayde"} },
        { itemID = 45822, nodeName = HarvestMerge.PotencyRunes, itemName = {"Edode"} },
        { itemID = 45823, nodeName = HarvestMerge.PotencyRunes, itemName = {"Pojode"} },
        { itemID = 45824, nodeName = HarvestMerge.PotencyRunes, itemName = {"Rekude"} },
        { itemID = 45825, nodeName = HarvestMerge.PotencyRunes, itemName = {"Hade"} },
        { itemID = 45826, nodeName = HarvestMerge.PotencyRunes, itemName = {"Idode"} },
        { itemID = 45827, nodeName = HarvestMerge.PotencyRunes, itemName = {"Pode"} },
        { itemID = 45828, nodeName = HarvestMerge.PotencyRunes, itemName = {"Kedeko"} },
        { itemID = 45829, nodeName = HarvestMerge.PotencyRunes, itemName = {"Rede"} },
        { itemID = 45830, nodeName = HarvestMerge.PotencyRunes, itemName = {"Kude"} },
        { itemID = 45831, nodeName = HarvestMerge.EssenceRunes, itemName = {"Oko"} },
        { itemID = 45832, nodeName = HarvestMerge.EssenceRunes, itemName = {"Makko"} },
        { itemID = 45833, nodeName = HarvestMerge.EssenceRunes, itemName = {"Deni"} },
        { itemID = 45834, nodeName = HarvestMerge.EssenceRunes, itemName = {"Okoma"} },
        { itemID = 45835, nodeName = HarvestMerge.EssenceRunes, itemName = {"Makkoma"} },
        { itemID = 45836, nodeName = HarvestMerge.EssenceRunes, itemName = {"Denima"} },
        { itemID = 45837, nodeName = HarvestMerge.EssenceRunes, itemName = {"Kuoko"} },
        { itemID = 45838, nodeName = HarvestMerge.EssenceRunes, itemName = {"Rakeipa"} },
        { itemID = 45839, nodeName = HarvestMerge.EssenceRunes, itemName = {"Dekeipa"} },
        { itemID = 45840, nodeName = HarvestMerge.EssenceRunes, itemName = {"Meip"} },
        { itemID = 45841, nodeName = HarvestMerge.EssenceRunes, itemName = {"Haoko"} },
        { itemID = 45842, nodeName = HarvestMerge.EssenceRunes, itemName = {"Deteri"} },
        { itemID = 45843, nodeName = HarvestMerge.EssenceRunes, itemName = {"Okori"} },
        { itemID = 45844, nodeName = HarvestMerge.EssenceRunes, itemName = {"Jaedi"} },
        { itemID = 45845, nodeName = HarvestMerge.EssenceRunes, itemName = {"Lire"} },
        { itemID = 45846, nodeName = HarvestMerge.EssenceRunes, itemName = {"Oru"} },
        { itemID = 45847, nodeName = HarvestMerge.EssenceRunes, itemName = {"Taderi"} },
        { itemID = 45848, nodeName = HarvestMerge.EssenceRunes, itemName = {"Makderi"} },
        { itemID = 45849, nodeName = HarvestMerge.EssenceRunes, itemName = {"Kaderi"} },
        { itemID = 45850, nodeName = HarvestMerge.AspectRunes, itemName = {"Ta"} },
        { itemID = 45851, nodeName = HarvestMerge.AspectRunes, itemName = {"Jejota"} },
        { itemID = 45852, nodeName = HarvestMerge.AspectRunes, itemName = {"Denata"} },
        { itemID = 45853, nodeName = HarvestMerge.AspectRunes, itemName = {"Rekuta"} },
        { itemID = 45854, nodeName = HarvestMerge.AspectRunes, itemName = {"Kuta"} },
        { itemID = 45855, nodeName = HarvestMerge.PotencyRunes, itemName = {"Jora"} },
        { itemID = 45856, nodeName = HarvestMerge.PotencyRunes, itemName = {"Porade"} },
        { itemID = 45857, nodeName = HarvestMerge.PotencyRunes, itemName = {"Jera"} },
    },
    -- : Alchemy
    [4] = {
        { itemID = 30148, nodeName = { ["en"] = {"Entoloma"}, ["de"] = {"Glöckling"}, ["fr"] = {"Entoloma"} }, itemName = {"Blue Entoloma"} },
        { itemID = 30149, nodeName = { ["en"] = {"Stinkhorn"}, ["de"] = {"Stinkmorchel"}, ["fr"] = {"Mutinus Elégans"} }, itemName = {"Stinkhorn"} },
        { itemID = 30151, nodeName = { ["en"] = {"Emetic Russula"}, ["de"] = {"Brechtäubling"}, ["fr"] = {"Russule Emetique"} }, itemName = {"Emetic Russula"} },
        { itemID = 30152, nodeName = { ["en"] = {[1] = "Violet Coprinus", [2] = "Violet Copninus"}, ["de"] = {"Violetter Tintling"}, ["fr"] = {[1] = "Violet Coprinus", [2] = "Violet Copninus"} }, itemName = {"Violet Coprinus"} },
        { itemID = 30153, nodeName = { ["en"] = {"Namira's Rot"}, ["de"] = {"Namiras Fäulnis"}, ["fr"] = {"Truffe de Namira"} }, itemName = {"Namira's Rot"} },
        { itemID = 30154, nodeName = { ["en"] = {"White Cap"}, ["de"] = {"Weißkappe"}, ["fr"] = {"Chapeau Blanc"} }, itemName = {"White Cap"} },
        { itemID = 30155, nodeName = { ["en"] = {"Luminous Russula"}, ["de"] = {"Leuchttäubling"}, ["fr"] = {"Russule Phosphorescente"} }, itemName = {"Luminous Russula"} },
        { itemID = 30156, nodeName = { ["en"] = {"Imp Stool"}, ["de"] = {"Koboldschemel"}, ["fr"] = {"Pied-de-Lutin"} }, itemName = {"Imp Stool"} },
        { itemID = 30157, nodeName = { ["en"] = {"Blessed Thistle"}, ["de"] = {"Benediktenkraut"}, ["fr"] = {"Chardon Béni"} }, itemName = {"Blessed Thistle"} },
        { itemID = 30158, nodeName = { ["en"] = {"Lady's Smock"}, ["de"] = {"Wiesenschaumkraut"}, ["fr"] = {"Cardamine des Prés"} }, itemName = {"Lady's Smock"} },
        { itemID = 30159, nodeName = { ["en"] = {"Wormwood"}, ["de"] = {"Wermut"}, ["fr"] = {"Absinthe"} }, itemName = {"Wormwood"} },
        { itemID = 30160, nodeName = { ["en"] = {"Bugloss"}, ["de"] = {"Wolfsauge"}, ["fr"] = {"Noctuelle"} }, itemName = {"Bugloss"} },
        { itemID = 30161, nodeName = { ["en"] = {"Corn Flower"}, ["de"] = {"Kornblume"}, ["fr"] = {"Bleuet"} }, itemName = {"Corn Flower"} },
        { itemID = 30162, nodeName = { ["en"] = {"Dragonthorn"}, ["de"] = {"Drachendorn"}, ["fr"] = {"Épine-de-Dragon"} }, itemName = {"Dragonthorn"} },
        { itemID = 30163, nodeName = { ["en"] = {"Mountain Flower"}, ["de"] = {"Bergblume"}, ["fr"] = {"Lys des Cimes"} }, itemName = {"Mountain Flower"} },
        { itemID = 30164, nodeName = { ["en"] = {"Columbine"}, ["de"] = {"Akelei"}, ["fr"] = {"Ancolie"} }, itemName = {"Columbine"} },
        { itemID = 30165, nodeName = { ["en"] = {"Nirnroot"}, ["de"] = {"Nirnwurz"}, ["fr"] = {"Nirnrave"} }, itemName = {"Nirnroot"} },
        { itemID = 30166, nodeName = { ["en"] = {"Water Hyacinth"}, ["de"] = {"Wasserhyazinthe"}, ["fr"] = {"Jacinthe D'eau"} }, itemName = {"Water Hyacinth"} },
    },
    -- : Wood ; In Esohead Wood is (6)
    [5] = {
        { itemID = 521, nodeName = { ["en"] = {"Oak"}, ["de"] = {"Eiche"}, ["fr"] = {"Chêne"} }, itemName = {"Rough Oak"} },
        { itemID = 802, nodeName = { ["en"] = {"Maple"}, ["de"] = {"Ahornholz"}, ["fr"] = {"Érable"} }, itemName = {"Rough Maple"} },
        { itemID = 818, nodeName = { ["en"] = {"Birch"}, ["de"] = {"Birkenholz"}, ["fr"] = {"Bouleau"} }, itemName = {"Rough Birch"} },
        { itemID = 4439, nodeName = { ["en"] = {"Ashtree"}, ["de"] = {"Eschenholz"}, ["fr"] = {"Frêne"} }, itemName = {"Rough Ash"} },
        { itemID = 23117, nodeName = { ["en"] = {"Beech"}, ["de"] = {"Buche"}, ["fr"] = {"Hêtre"} }, itemName = {"Rough Beech"} },
        { itemID = 23118, nodeName = { ["en"] = {"Hickory"}, ["de"] = {"Hickoryholz"}, ["fr"] = {"Hickory"} }, itemName = {"Rough Hickory"} },
        { itemID = 23119, nodeName = { ["en"] = {"Yew"}, ["de"] = {"Eibenholz"}, ["fr"] = {"If"} }, itemName = {"Rough Yew"} },
        { itemID = 23137, nodeName = { ["en"] = {"Mahogany"}, ["de"] = {"Mahagoniholz"}, ["fr"] = {"Acajou"} }, itemName = {"Rough Mahogany"} },
        { itemID = 23138, nodeName = { ["en"] = {"Nightwood"}, ["de"] = {"Nachtholz"}, ["fr"] = {"Bois de nuit"} }, itemName = {"Rough Nightwood"} },
    },
    [6] = {
    },
    -- : Solvent
    [7] = {
        { itemID = 883, nodeName = HarvestMerge.SolventNodes, itemName = {"Natural Water"} }, --V
        { itemID = 1187, nodeName = HarvestMerge.SolventNodes, itemName = {"Clear Water"} }, --V
        { itemID = 4570, nodeName = HarvestMerge.SolventNodes, itemName = {"Pristine Water"} }, --V
        { itemID = 23265, nodeName = HarvestMerge.SolventNodes, itemName = {"Cleansed Water"} }, --V
        { itemID = 23266, nodeName = HarvestMerge.SolventNodes, itemName = {"Filtered Water"} }, --V
        { itemID = 23267, nodeName = HarvestMerge.SolventNodes, itemName = {"Purified Water"} }, --V
        { itemID = 23268, nodeName = HarvestMerge.SolventNodes, itemName = {"Cloud Mist"} }, --V
    },
    [8] = {
    },
}

HarvestMerge.professions = {
    -- : Mining
    [1] = {
        808,
        4482,
        4995,
        5820,
        23103,
        23104,
        23105,
        23133,
        23134,
        23135,
    },
    -- : Clothing
    [2] = {
        812,
        4464,
        23129,
        23130,
        23131,
        33217,
        33218,
        33219,
        33220,
    },
    -- : Enchanting
    [3] = {
        45806,
        45807,
        45808,
        45809,
        45810,
        45811,
        45812,
        45813,
        45814,
        45815,
        45816,
        45817,
        45818,
        45819,
        45820,
        45821,
        45822,
        45823,
        45824,
        45825,
        45826,
        45827,
        45828,
        45829,
        45830,
        45831,
        45832,
        45833,
        45834,
        45835,
        45836,
        45837,
        45838,
        45839,
        45840,
        45841,
        45842,
        45843,
        45844,
        45845,
        45846,
        45847,
        45848,
        45849,
        45850,
        45851,
        45852,
        45853,
        45854,
        45855,
        45856,
        45857,
        54248,
        54253,
        54289,
        54294,
        54297,
        54299,
        54306,
        54330,
        54331,
        54342,
        54373,
        54374,
        54375,
        54481,
        54482,
    },
    -- : Alchemy
    [4] = {
        30148,
        30149,
        30151,
        30152,
        30153,
        30154,
        30155,
        30156,
        30157,
        30158,
        30159,
        30160,
        30161,
        30162,
        30163,
        30164,
        30165,
        30166,
    },
    -- : Wood ; In Esohead Wood is (6)
    [5] = {
        521,
        802,
        818,
        4439,
        23117,
        23118,
        23119,
        23137,
        23138,
    },
-- 6 = Chest, 7 = Solvent, 8 = Fish
    [6] = {
    },
    [7] = {
        883,
        1187,
        4570,
        23265,
        23266,
        23267,
        23268,
    },
    [8] = {
    },
}
-- Node Names
-- (1) Mining
HarvestMerge.mining = {
    ["en"] = {
        "Iron Ore",
        "High Iron Ore",
        "Orichalc Ore",
        "Orichalcum Ore",
        "Dwarven Ore",
        "Ebony Ore",
        "Calcinium Ore",
        "Galatite Ore",
        "Quicksilver Ore",
        "Voidstone Ore",
    },
    ["de"] = {
        "Eisenerz",
        "Feineisenerz",
        "Orichalc Ore",
        "Oreichalkoserz",
        "Dwemererz",
        "Ebenerz",
        "Kalciniumerz",
        "Galatiterz",
        "Quicksilver Ore",
        "Leerensteinerz",
    },
    ["fr"] = {
        "Minerai de Fer",
        "Minerai de Fer Noble",
        "Orichalc Ore",
        "Minerai D'orichalque",
        "Minerai Dwemer",
        "Minerai d'Ebonite",
        "Minerai de Calcinium",
        "Minerai de Galatite",
        "Quicksilver Ore",
        "Minerai de Pierre de Vide",
    },
}
-- (2) Clothing
HarvestMerge.clothing = {
    ["en"] = {
        "Cotton",
        "Ebonthread",
        "Flax",
        "Ironweed",
        "Jute",
        "Kreshweed",
        "Silverweed",
        "Spidersilk",
        "Void Bloom",
        "Silver Weed",
        "Kresh Weed",
    },
    ["de"] = {
        "Baumwolle",
        "Ebenseide",
        "Flachs",
        "Eisenkraut",
        "Jute",
        "Kreshweed",
        "Silverweed",
        "Spinnenseide",
        "Leere Blüte",
        "Silver Weed",
        "Kresh Weed",
    },
    ["fr"] = {
        "Coton",
        "Fil d'Ebonite",
        "Lin",
        "Herbe de fer",
        "Jute",
        "Kreshweed",
        "Silverweed",
        "Toile D'araignée",
        "Tissu de Vide",
        "Silver Weed",
        "Kresh Weed",
    },
}
-- (3) Enchanting
HarvestMerge.enchanting = {
    ["en"] = {
        "Aspect Rune",
        "Essence Rune",
        "Potency Rune",
    },
    ["de"] = {
        "Aspektrune",
        "Essenzrune",
        "Machtrune",
    },
    ["fr"] = {
        "Rune d'Aspect",
        "Rune D'essence",
        "Rune de Puissance",
    },
}
-- (4) Alchemy
HarvestMerge.alchemy = {
    ["en"] = {
        "Blessed Thistle",
        "Entoloma",
        "Bugloss",
        "Columbine",
        "Corn Flower",
        "Dragonthorn",
        "Emetic Russula",
        "Imp Stool",
        "Lady's Smock",
        "Luminous Russula",
        "Mountain Flower",
        "Namira's Rot",
        "Nirnroot",
        "Stinkhorn",
        "Violet Coprinus", -- this may have changed
        "Violet Copninus", -- this may have changed
        "Water Hyacinth",
        "White Cap",
        "Wormwood",
    },
    ["de"] = {
        "Benediktenkraut",
        "Glöckling",
        "Wolfsauge",
        "Akelei",
        "Kornblume",
        "Drachendorn",
        "Brechtäubling",
        "Koboldschemel",
        "Wiesenschaumkraut",
        "Leuchttäubling",
        "Bergblume",
        "Namiras Fäulnis",
        "Nirnwurz",
        "Stinkmorchel",
        "Violetter Tintling",
        "Wasserhyazinthe",
        "Weißkappe",
        "Wermut",
    },
    ["fr"] = {
        "Chardon Béni",
        "Entoloma",
        "Noctuelle",
        "Ancolie",
        "Bleuet",
        "Épine-de-Dragon",
        "Russule Emetique",
        "Pied-de-Lutin",
        "Cardamine des Prés",
        "Russule Phosphorescente",
        "Lys des Cimes",
        "Truffe de Namira",
        "Nirnrave",
        "Mutinus Elégans",
        "Coprin Violet",
        "Jacinthe D'eau",
        "Chapeau Blanc",
        "Absinthe",
    },
}
-- (5) Woodworking ; In Esohead Woodworking is (6)
HarvestMerge.woodworking = {
    ["en"] = {
        "Ashtree",
        "Beech",
        "Birch",
        "Hickory",
        "Mahogany",
        "Maple",
        "Nightwood",
        "Oak",
        "Yew",
    },
    ["de"] = {
        "Eschenholz",
        "Buche", -- "Buchenholz"
        "Birkenholz",
        "Hickoryholz",
        "Mahagoniholz",
        "Ahornholz",
        "Nachtholz",
        "Eiche",
        "Eibenholz",
    },
    ["fr"] = {
        "Frêne",
        "Hêtre",
        "Bouleau",
        "Hickory",
        "Acajou",
        "Érable",
        "Bois de nuit",
        "Chêne",
        "If",
    },
}
-- 7 = Solvent
HarvestMerge.solvent = {
    ["en"] = {
        -- "Bottle",
        -- "Bottles",
        -- "Cup",
        -- "Cups",
        -- "Drink",
        -- "Goblet",
        -- "Jar",
        -- "Jug",
        -- "Mug",
        "Pure Water",
        "Water Skin",
        -- "Wine Rack",
    },
    ["de"] = {
        -- "Flasche",
        -- "Flaschen",
        -- "Tasse",
        -- "Tassen",
        -- "Getränk",
        -- "Becher",
        -- "Gefäß",
        -- "Krug",
        -- "Becher",
        "Reines Wasser",
        "Wasserhaut",
        -- "Weinregal",
    },
    ["fr"] = {
        -- "Bouteille",
        -- "Bouteilles",
        -- "Tasse",
        -- "Tasses",
        -- "Boisson",
        -- "Chope",
        -- "Jar",
        -- "Pichet",
        -- "Choppe",
        "Eau Pure",
        "Outre d'Eau",
        -- "Casier ŕ bouteilles",
    },
}
-- 8 = Container
HarvestMerge.container = {
    ["en"] = {
        -- "Ashtree",
        -- "Aspect Rune",
        "Backpack",
        "Barrel",
        "Barrel (Burnt)",
        "Barrels",
        "Barrels (Burnt)",
        "Basket",
        -- "Beech",
        -- "Birch",
        -- "Blessed Thistle",
        "Book",
        "Book Stack",
        "Books",
        "Bookshelf",
        "Bottle",
        "Bottles",
        "Bread",
        -- "Bugloss",
        "Cabinet",
        -- "Calcinium Ore", -- Verified
        "Carrots",
        "Cheese",
        -- "Columbine",
        -- "Corn Flower",
        -- "Cotton",
        "Crate",
        "Crate (Burnt)",
        "Crates",
        "Crates (Burnt)",
        "Cup",
        "Cupboard",
        "Cups",
        "Desk",
        -- "Dragonthorn",
        "Dresser",
        "Drink",
        -- "Dwarven Ore",
        -- "Ebonthread",
        -- "Ebony Ore",
        -- "Emetic Russula",
        -- "Entoloma",
        -- "Essence Rune",
        -- "Famin Flower",
        "Fish",
        -- "Flax",
        "Food",
        -- "Galatite Ore",
        "Goblet",
        "Grain",
        "Grapes",
        "Heavy Sack",
        -- "Hickory",
        -- "High Iron Ore",
        -- "Imp Stool",
        -- "Iron Ore",
        -- "Iron Weed",
        "Jar",
        "Jug",
        -- "Jute",
        -- "Kreshweed",
        -- "Lady's Smock",
        -- "Luminous Russula",
        -- "Mahogany",
        -- "Maple",
        -- "Moonstone Ore",
        -- "Mountain Flower",
        "Mug",
        -- "Namira's Rot",
        "Nightstand",
        -- "Nightwood",
        -- "Nirnroot",
        -- "Oak",
        -- "Orichalc Ore", -- Needs Verification
        -- "Orichalcum Ore",
        "Pot",
        -- "Potency Rune",
        "Produce",
        -- "Pure Water",
        -- "QA Clickable",
        -- "QA Clickable Apples",
        -- "QA lowlevel provision test",
        -- "Quicksilver Ore",
        "Radish",
        "Sack",
        -- "Saint's Hair",
        -- "Silverweed",
        -- "Spidersilk",
        -- "Stinkhorn",
        "Tomb Urn",
        "Trunk",
        "Urn",
        "Vase",
        -- "Violet Copninus",
        -- "Void Bloom",
        -- "Voidstone Ore",
        "Wardrobe",
        -- "Water Hyacinth",
        -- "Water Skin",
        -- "White Cap",
        "Wine Rack",
        -- "Wormwood",
        -- "Yew",
    },
    ["de"] = {
        -- "Eschenholz",
        -- "Aspektrune",
        "Rucksack",
        "Fass",
        "Fass (versengt)",
        "Fässer",
        "Fässer (versengt)",
        "Korb",
        -- "Buche",
        -- "Birke",
        -- "Benediktenkraut",
        "Buch",
        "Buchstapel",
        "Bücher",
        "Bücherregal",
        "Flasche",
        "Flaschen",
        "Brot",
        -- "Wolfsauge",
        "Schrank",
        -- "Kalciniumerz",
        "Möhren",
        "Käse",
        -- "Akelei",
        -- "Kornblume",
        -- "Baumwolle",
        "Kiste",
        "Kiste (versengt)",
        "Kisten",
        "Kisten (versengt)",
        "Tasse",
        "Schrank",
        "Tassen",
        "Schreibtisch",
        -- "Drachendorn",
        "Kommode",
        "Getränk",
        -- "Dwemererz",
        -- "Ebenseide",
        -- "Ebenerz",
        -- "Speitäubling",
        -- "Glöckling",
        -- "Essenzrune",
        -- "Hungersnotblume",
        "Fischen",
        -- "Flachs",
        "Essen",
        -- "Galatiterz",
        "Becher",
        "Getreide",
        "Weintrauben",
        "Schwerer Sack",
        -- "Hickoryholz",
        -- "Feineisenerz",
        -- "Koboldschemel",
        -- "Eisenerz",
        -- "Eisenkraut",
        "Gefäß",
        "Krug",
        -- "Jute", -- Verified, it's just Jute
        -- "Kreshweed",
        -- "Wiesenschaumkraut",
        -- "Leuchttäubling",
        -- "Mahagoniholz",
        -- "Ahornholz",
        -- "Mondsteinerz",
        -- "Bergblume",
        "Becher",
        -- "Namira's Fäulnis",
        "Nachttisch",
        -- "Nachtholz",
        -- "Nirnwurz",
        -- "Eiche",
        -- "Orichalc Ore", -- Needs Verification
        -- "Oreichalkoserz", -- Orichalcum Ore
        "Topf",
        -- "Machtrune",
        "Produkt",
        -- "Reines Wasser",
        -- "QA Clickable",
        -- "QA Clickable Apples",
        -- "QA lowlevel provision test",
        -- "Quicksilver Ore",
        "Radieschen",
        "Sack",
        -- "Heiliges Haar",
        -- "Silverweed",
        -- "Spinnenseide",
        -- "Stinkmorchel",
        "Urnengrab",
        "Stamm", -- Needs Verification
        "Urne",
        "Vase",
        -- "Violetter Coprinus",
        -- "Leere Blüte",
        -- "Leerensteinerz",
        "Kleiderschrank",
        -- "Wasserhyazinthe",
        -- "Wasserhaut",
        -- "Weiße Kappe",
        "Weinregal",
        -- "Wermut",
        -- "Eibenholz",
    },
    -- Pot, Jute, Jar, Hickory, Grain, Cabinet and Entoloma are the same names in French
    ["fr"] = {
        -- "Frêne",
        -- "Rune d'Aspect",
        "Sac à dos",
        "Tonneau",
        "Tonneau (brûlé)",
        "Tonneaux",
        "Tonneaux (brûlés)",
        "Panier",
        -- "Hêtre",
        -- "Bouleau",
        -- "Chardon Béni",
        "Livre",
        "Pile de livres",
        "Livres",
        "Étagère",
        "Bouteille",
        "Bouteilles",
        "Pain",
        -- "Noctuelle",
        "Cabinet",
        -- "Minerai de Calcinium",
        "Carrottes",
        "Fromage",
        -- "Ancolie",
        -- "Bleuet",
        -- "Coton",
        "Caisse",
        "Caisse (brûlée)",
        "Caisses",
        "Caisses (brûlées)",
        "Tasse",
        "Commode",
        "Tasses",
        "Bureau",
        -- "Épine-de-Dragon",
        "Buffet",
        "Boisson",
        -- "Minerai Dwemer",
        -- "Fil d'Ebonite",
        -- "Minerai d'Ebonite",
        -- "Russule Emetique",
        -- "Entoloma",
        -- "Rune D'essence",
        -- "Famin Flower",
        "Poisson",
        -- "Lin",
        "Nourriture",
        -- "Minerai de Galatite",
        "Chope",
        "Grain",
        "Raisin",
        "Sac Lourd",
        -- "Hickory",
        -- "Minerai de Fer Noble",
        -- "Pied-de-Lutin",
        -- "Minerai de Fer",
        -- "Herbe de fer",
        "Jar",
        "Pichet",
        -- "Jute",
        -- "Fibre de Kresh",
        -- "Cardamine des Prés",
        -- "Russule Phosphorescente",
        -- "Acajou",
        -- "Érable",
        -- "Pierre de lune",
        -- "Lys des Cimes",
        "Choppe",
        -- "Truffe de Namira",
        "Table de chevet",
        -- "Bois de nuit",
        -- "Nirnrave",
        -- "Chêne",
        -- "Orichalc Ore", -- Needs Verification
        -- "Minerai D'orichalque",  -- Orichalcum Ore
        "Pot",
        -- "Rune de Puissance",
        "Céréales",
        -- "Eau Pure",
        -- "QA Clickable",
        -- "QA Clickable Apples",
        -- "QA lowlevel provision test",
        -- "Quicksilver Ore",
        "Radis",
        "Sac",
        -- "Saint's Hair",
        -- "Herbe d'argent",
        -- "Toile D'araignée",
        -- "Mutinus Elégans",
        "Urne tombale",
        "Coffre",
        "Urne",
        "Vase",
        -- "Coprin Violet",
        -- "Tissu de Vide",
        -- "Minerai de Pierre de Vide",
        "Garde-robe",
        -- "Jacinthe D'eau",
        -- "Outre d'Eau",
        -- "Chapeau Blanc",
        "Casier ŕ bouteilles",
        -- "Absinthe",
        -- "If",
    }
}

function HarvestMerge.IsValidMiningIDName(id, name)
    local nameMatch = HarvestMerge.IsValidMiningName(name)
    local itemIDMatch = false

    for key1, value in pairs(HarvestMerge.professions[1]) do
        if value == id then
            itemIDMatch = true
        end
    end

    if nameMatch and itemIDMatch then
        return true
    end

    return false
end

function HarvestMerge.IsValidClothingIDName(id, name)
    local nameMatch = HarvestMerge.IsValidClothingName(name)
    local itemIDMatch = false

    for key1, value in pairs(HarvestMerge.professions[2]) do
        if value == id then
            itemIDMatch = true
        end
    end

    if nameMatch and itemIDMatch then
        return true
    end

    return false
end

function HarvestMerge.IsValidEnchantingIDName(id, name)
    local nameMatch = HarvestMerge.IsValidEnchantingName(name)
    local itemIDMatch = false

    for key1, value in pairs(HarvestMerge.professions[3]) do
        if value == id then
            itemIDMatch = true
        end
    end

    if nameMatch and itemIDMatch then
        return true
    end

    return false
end

function HarvestMerge.IsValidAlchemyIDName(id, name)
    local nameMatch = HarvestMerge.IsValidAlchemyName(name)
    local itemIDMatch = false

    for key1, value in pairs(HarvestMerge.professions[4]) do
        if value == id then
            itemIDMatch = true
        end
    end

    if nameMatch and itemIDMatch then
        return true
    end

    return false
end

function HarvestMerge.IsValidWoodworkingIDName(id, name)
    local nameMatch = HarvestMerge.IsValidWoodworkingName(name)
    local itemIDMatch = false

    for key1, value in pairs(HarvestMerge.professions[5]) do
        if value == id then
            itemIDMatch = true
        end
    end

    if nameMatch and itemIDMatch then
        return true
    end

    return false
end

-- (1)Mining
function HarvestMerge.IsValidMiningName(name)
    for lang, langs in pairs(HarvestMerge.langs) do
        for k, v in pairs(HarvestMerge.mining[langs]) do
            if v == name then
                return true
            end
        end
    end

    return false
end

-- (2)Clothing
function HarvestMerge.IsValidClothingName(name)
    for lang, langs in pairs(HarvestMerge.langs) do
        for k, v in pairs(HarvestMerge.clothing[langs]) do
            if v == name then
                return true
            end
        end
    end

    return false
end

-- (3)Enchanting
function HarvestMerge.IsValidEnchantingName(name)
    for lang, langs in pairs(HarvestMerge.langs) do
        for k, v in pairs(HarvestMerge.enchanting[langs]) do
            if v == name then
                return true
            end
        end
    end

    return false
end

-- (4)Alchemy
function HarvestMerge.IsValidAlchemyName(name)
    for lang, langs in pairs(HarvestMerge.langs) do
        for k, v in pairs(HarvestMerge.alchemy[langs]) do
            if v == name then
                return true
            end
        end
    end

    return false
end

-- (5)Woodworking
function HarvestMerge.IsValidWoodworkingName(name)
    for lang, langs in pairs(HarvestMerge.langs) do
        for k, v in pairs(HarvestMerge.woodworking[langs]) do
            if v == name then
                return true
            end
        end
    end

    return false
end

-- (7)Woodworking
function HarvestMerge.IsValidSolventName(name)
    for lang, langs in pairs(HarvestMerge.langs) do
        for k, v in pairs(HarvestMerge.solvent[langs]) do
            if v == name then
                return true
            end
        end
    end

    return false
end

function HarvestMerge.IsValidContainerName(name)
    for lang, langs in pairs(HarvestMerge.langs) do
        for k, v in pairs(HarvestMerge.container[langs]) do
            if v == name then
                return true
            end
        end
    end

    return false
end

-- Arguments Required itemID, nodeName
-- Returns -1 when Object interacted with is invalid
-- Valid types: (1)Mining, (2)Clothing, (3)Enchanting
-- (4)Alchemy, (5)Wood, (6)Chests, (7)Solvents
-- (8)Fish
function HarvestMerge.CheckProfessionTypeOnImport(id, name)
    local isOk = false
    id = tonumber(id)

    -- Set (1)Mining
    if HarvestMerge.IsValidMiningIDName(id, name) then
        isOk = true
    end
    -- Set (2)Clothing
     if HarvestMerge.IsValidClothingIDName(id, name) then
        isOk = true
    end
    -- Set (3)Enchanting
     if HarvestMerge.IsValidEnchantingIDName(id, name) then
        isOk = true
    end
    -- Set (4)Alchemy
     if HarvestMerge.IsValidAlchemyIDName(id, name) then
        isOk = true
    end
    -- Set (5)Woodworking
     if HarvestMerge.IsValidWoodworkingIDName(id, name) then
        isOk = true
    end
    -- Set (7)Solvent
    if HarvestMerge.IsValidSolventName(name) then
        isOk = true
    end

    return isOk
end

-- Arguments Required: nodeName
-- Returns -1 when Object interacted with is invalid
-- Valid types: (1)Mining, (2)Clothing, (3)Enchanting
-- (4)Alchemy, (5)Wood, (7)Solvents
-- Containers are assigned 4 Alchemy the same as 2.2
function HarvestMerge.GetProfessionTypeOnUpdate(name)
    local tsId

    if HarvestMerge.IsValidSolventName(name) then
        tsId = 7
        return tsId
    end

    if HarvestMerge.IsValidMiningName(name) then
        tsId = 1
        return tsId
    end

    if HarvestMerge.IsValidClothingName(name) then
        tsId = 2
        return tsId
    end

    if HarvestMerge.IsValidEnchantingName(name) then
        tsId = 3
        return tsId
    end

    if HarvestMerge.IsValidAlchemyName(name) then
        tsId = 4
        return tsId
    end

    if HarvestMerge.IsValidWoodworkingName(name) then
        tsId = 5
        return tsId
    end

    if HarvestMerge.IsValidContainerName(name) then
        tsId = 4
        return tsId
    end

    return -1
end

-- Arguments Required itemID, nodeName
-- Returns -1 when Object interacted with is invalid
-- Valid types: (1)Mining, (2)Clothing, (3)Enchanting
-- (4)Alchemy, (5)Wood, (6)Chests, (7)Solvents
-- (8)Fish
function HarvestMerge.GetProfessionType(id, name)
    local tsId
    id = tonumber(id)

    if HarvestMerge.internal.verbose then
        d("Attempting GetProfessionType with id : " .. id)
        d("Node Name : " .. name)
    end

    --if HarvestMerge.IsValidSolvent(name) then
    --    tsId = 7
    --    if HarvestMerge.settings.verbose then
    --        d("Solvent id assigned : " .. tsId)
    --    end
    --    return tsId
    --end

    -- For this HarvestMap version there are no containers
    -- Set any container found to 0 so that it is not recorded.
    if HarvestMerge.IsValidContainerName(name) then
        tsId = 0
        if HarvestMerge.internal.verbose then
            d("Container is not used in this version id assigned : " .. tsId)
        end
        return tsId
    end

    -- if no valid Node Name by Name is found use itemID
    for key1, tsData in pairs(HarvestMerge.professions) do
        for key2, value in pairs(tsData) do
            if value == id then
                tsId = key1
                if HarvestMerge.internal.verbose then
                    d("Esohead id assigned : " .. tsId)
                end
                return tsId
            end
        end
    end

    if HarvestMerge.internal.verbose then
        d("No Profession Type found with id : " .. id)
        d("In GetProfessionType with name : " .. name)
    end

    return -1
end

-- Always set HarvestMerge.getItemIDFromItemNameIndex when determining the node name
function HarvestMerge.translateNodeName(name)
    for tsId, tsData in pairs(HarvestMerge.NodeArray) do
        for profession, tsNode in pairs(tsData) do
            for lang, langs in pairs(HarvestMerge.langs) do
                if tsNode.nodeName[langs] ~= nil then
                    -- HarvestMerge.Debug(tsNode.nodeName[langs])
                    for index, nodeName in pairs(tsNode.nodeName[langs]) do
                        -- HarvestMerge.Debug(nodeName)
                        -- HarvestMerge.Debug(index)
                        if nodeName == name then
                            if profession == 4 and tsNode.itemID == 30152 then
                                HarvestMerge.getItemIDFromItemNameIndex = 1
                                name = tsNode.nodeName[HarvestMerge.language][HarvestMerge.getItemIDFromItemNameIndex]
                            else
                                HarvestMerge.getItemIDFromItemNameIndex = index
                                name = tsNode.nodeName[HarvestMerge.language][HarvestMerge.getItemIDFromItemNameIndex]
                            end
                            return name
                        end
                    end
                end
            end
        end
    end
    return nil
end

-- Always set HarvestMerge.getItemIDFromItemNameIndex when determining the node name
function HarvestMerge.GetItemIDFromItemName(name)
    local itemID
    if name == nil then
        HarvestMerge.Debug("Returned Nil because name was Nil!")
        return nil
    end

    for tsId, tsData in pairs(HarvestMerge.NodeArray) do
        for profession, tsNode in pairs(tsData) do
            for lang, langs in pairs(HarvestMerge.langs) do
                if tsNode.nodeName[langs] ~= nil then
                    -- HarvestMerge.Debug(tsNode.nodeName[langs])
                    for index, nodeName in pairs(tsNode.nodeName[langs]) do
                        -- HarvestMerge.Debug(nodeName)
                        -- HarvestMerge.Debug(index)
                        if nodeName == name then
                            HarvestMerge.getItemIDFromItemNameIndex = index
                            itemID = tsNode.itemID
                            return itemID
                        end
                    end
                end
            end
        end
    end
    return nil
end

-- HarvestMerge.getItemIDFromItemNameIndex when determining the node name
function HarvestMerge.GetItemNameFromItemID(id)
    local name
    if id == nil then
        HarvestMerge.Debug("Returned Nil because id was Nil!")
        return nil
    end

    for tsId, tsData in pairs(HarvestMerge.NodeArray) do
        for profession, tsNode in pairs(tsData) do
            for lang, langs in pairs(HarvestMerge.langs) do
                if tsNode.nodeName[langs] ~= nil then
                    -- HarvestMerge.Debug(tsNode.nodeName[langs])
                    -- HarvestMerge.Debug("Saved Count: " .. HarvestMerge.getItemIDFromItemNameIndex)
                    for index, nodeName in pairs(tsNode.nodeName[langs]) do
                        -- HarvestMerge.Debug(nodeName)
                        -- HarvestMerge.Debug(index)
                        if tsNode.itemID == id then
                            if profession == 4 and id == 30152 then
                                HarvestMerge.getItemIDFromItemNameIndex = 1
                                name = tsNode.nodeName[HarvestMerge.language][HarvestMerge.getItemIDFromItemNameIndex]
                            else
                                name = tsNode.nodeName[HarvestMerge.language][HarvestMerge.getItemIDFromItemNameIndex]
                            end
                            return name
                        end
                    end
                end
            end
        end
    end
    return nil
end

function HarvestMerge.checkForValidNodeID(id)
    id = tonumber(id)
    for tsId, tsData in pairs(HarvestMerge.NodeArray) do
        for profession, tsNode in pairs(tsData) do
            if tsNode.itemID ~= nil then
                if tsNode.itemID == id then
                    return true
                end
            end
        end
    end
    return false
end

-- local alliance = GetUnitAlliance("player")
-- valid alliance values are:
--  ALLIANCE_ALDMERI_DOMINION = 1
--  ALLIANCE_EBONHEART_PACT = 2
--  ALLIANCE_DAGGRTFALL_COVENANT = 3
