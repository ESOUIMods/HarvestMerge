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
        793,
        800,
        812,
        4448,
        4464,
        4478,
        6020,
        23095,
        23097,
        23129,
        23130,
        23131,
        23142,
        23143,
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
        883,
        1187,
        4570,
        23265,
        23266,
        23267,
        23268,
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
-- These additional elements in the array are here for consistency in how
-- the arrays are already handled.  It is also appended in this way for
-- compatibility with the data already collected by users.  Chests are already
-- handled separately.
--
-- 6 = Chest, 7 = Solvent, 8 = Fish
-- 45036, -- This is a Chest you unlock
    [6] = {
    },
    [7] = {
    },
    [8] = {
    },
}
-- Books is the exception such that there may be a way to record lore books
-- that are always in the same location and usable only once like Skyshards.
--
-- Esohead uses the same ItemID for multiple items.  Therefore maintaining
-- a list based on the item number would become useless bloat in a file.
-- All items looted in ESO are containers.  Such that Jute is a container
-- it just gives you Jute.  a Crate is a container that gives you food items.
-- Therefore the name of the item collected will dictate it's category
-- rather than the Item's ID number.
--
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
        "Violet Copninus",
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
        "Speitäubling",
        "Koboldschemel",
        "Wiesenschaumkraut",
        "Leuchttäubling",
        "Bergblume",
        "Namira's Fäulnis",
        "Nirnwurz",
        "Stinkmorchel",
        "Violetter Coprinus",
        "Wasserhyazinthe",
        "Weiße Kappe",
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
        "Buchenholz",
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

-- 7 = Solvent: These need verification to see
-- if all of them have Solvents in then
-- 1187 Clear Water, Pure Water, Deshaan
-- 23265 Cleansed Water, Pure Water, TheRift
-- Bottles Give Beverages, but can give a Solvent like Clear Water
-- Wine Racks can give Solvent like Clear Water, needs more research
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
        "Backpack",
        "Barrel",
        "Barrel (Burnt)",
        "Barrels",
        "Barrels (Burnt)",
        "Basket",
        "Cabinet",
        "Crate",
        "Crate (Burnt)",
        "Crates",
        "Crates (Burnt)",
        "Cupboard",
        "Desk",
        "Dresser",
        "Heavy Sack",
        "Nightstand",
        "Pot",
        "Sack",
        "Tomb Urn",
        "Trunk",
        "Urn",
        "Vase",
        "Wardrobe",
    },
    ["de"] = {
        "Rucksack",
        "Fass",
        "Fass (versengt)",
        "Fässer",
        "Fässer (versengt)",
        "Korb",
        "Schrank",
        "Kiste",
        "Kiste (versengt)",
        "Kisten",
        "Kisten (versengt)",
        "Schrank",
        "Schreibtisch",
        "Kommode",
        "Schwerer Sack",
        "Nachttisch",
        "Topf",
        "Sack",
        "Urnengrab",
        "Truhe",
        "Urne",
        "Vase",
        "Kleiderschrank",
    },
    ["fr"] = {
        "Sac ŕ dos",
        "Tonneau",
        "Tonneau (brûlé)",
        "Tonneaux",
        "Tonneaux (brûlés)",
        "Panier",
        "Cabinet",
        "Caisse",
        "Caisse (brûlée)",
        "Caisses",
        "Caisses (brûlées)",
        "Commode",
        "Bureau",
        "Table de chevet",
        "Sac Lourd",
        "Table de chevet",
        "Pot",
        "Sac",
        "Urne tombale",
        "Coffre",
        "Urne",
        "Vase",
        "Garde-robe",
    },
}

-- : Books
HarvestMerge.books = {
    ["en"] = {
        "Book",
        "Book Stack",
        "Books",
        "Bookshelf",
    },
    ["de"] = {
        "Buch",
        "Buchstapel",
        "Bücher",
        "Bücherregal",
    },
    ["fr"] = {
        "Livre",
        "Pile de livres",
        "Livres",
        "Étagère",
    },
}

function HarvestMerge.IsValidMining(id, name)
    local nameMatch = false
    local itemIDMatch = false

    for key1, value in pairs(HarvestMerge.professions[1]) do
        if value == id then
            itemIDMatch = true
        end
    end

    for k, v in pairs(HarvestMerge.mining["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.mining["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.mining["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    if nameMatch and itemIDMatch then
        return true
    end

    return false
end

function HarvestMerge.IsValidClothing(id, name)
    local nameMatch = false
    local itemIDMatch = false

    for key1, value in pairs(HarvestMerge.professions[2]) do
        if value == id then
            itemIDMatch = true
        end
    end

    for k, v in pairs(HarvestMerge.clothing["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.clothing["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.clothing["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    if nameMatch and itemIDMatch then
        return true
    end

    return false
end

function HarvestMerge.IsValidEnchanting(id, name)
    local nameMatch = false
    local itemIDMatch = false

    for key1, value in pairs(HarvestMerge.professions[3]) do
        if value == id then
            itemIDMatch = true
        end
    end

    for k, v in pairs(HarvestMerge.enchanting["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.enchanting["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.enchanting["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    if nameMatch and itemIDMatch then
        return true
    end

    return false
end

function HarvestMerge.IsValidAlchemy(id, name)
    local nameMatch = false
    local itemIDMatch = false

    for key1, value in pairs(HarvestMerge.professions[4]) do
        if value == id then
            itemIDMatch = true
        end
    end

    for k, v in pairs(HarvestMerge.alchemy["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.alchemy["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.alchemy["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    if nameMatch and itemIDMatch then
        return true
    end

    return false
end

function HarvestMerge.IsValidWoodworking(id, name)
    local nameMatch = false
    local itemIDMatch = false

    for key1, value in pairs(HarvestMerge.professions[5]) do
        if value == id then
            itemIDMatch = true
        end
    end

    for k, v in pairs(HarvestMerge.woodworking["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.woodworking["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.woodworking["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    if nameMatch and itemIDMatch then
        return true
    end

    return false
end

function HarvestMerge.IsValidSolventOnImport(name)
    local nameMatch = false

    for k, v in pairs(HarvestMerge.solvent["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.solvent["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.solvent["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    return nameMatch
end

function HarvestMerge.IsValidContainerOnImport(name)
    local nameMatch = false

    for k, v in pairs(HarvestMerge.container["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.container["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.container["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    return nameMatch
end

-- (1)Mining
function HarvestMerge.IsValidMiningOnUpdate(name)
    local nameMatch = false

    for k, v in pairs(HarvestMerge.mining["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.mining["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.mining["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    return nameMatch
end

-- (2)Clothing
function HarvestMerge.IsValidClothingOnUpdate(name)
    local nameMatch = false

    for k, v in pairs(HarvestMerge.clothing["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.clothing["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.clothing["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    return nameMatch
end

-- (3)Enchanting
function HarvestMerge.IsValidEnchantingOnUpdate(name)
    local nameMatch = false

    for k, v in pairs(HarvestMerge.enchanting["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.enchanting["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.enchanting["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    return nameMatch
end

-- (4)Alchemy
function HarvestMerge.IsValidAlchemyOnUpdate(name)
    local nameMatch = false

    for k, v in pairs(HarvestMerge.alchemy["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.alchemy["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.alchemy["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    return nameMatch
end

-- (5)Woodworking
function HarvestMerge.IsValidWoodworkingOnUpdate(name)
    local nameMatch = false

    for k, v in pairs(HarvestMerge.woodworking["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.woodworking["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.woodworking["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    return nameMatch
end

-- (6)Container - Put Containers in 4 Alchemy just as if it were 2.2
function HarvestMerge.IsValidContainerOnUpdate(name)
    local nameMatch = false

    for k, v in pairs(HarvestMerge.container["en"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.container["de"]) do
        if v == name then
            nameMatch = true
        end
    end
    for k, v in pairs(HarvestMerge.container["fr"]) do
        if v == name then
            nameMatch = true
        end
    end

    return nameMatch
end

function HarvestMerge.IsValidSolvent(name)
    for k, v in pairs(HarvestMerge.solvent[HarvestMerge.language]) do
        if v == name then
            return true
        end
    end

    return false
end

function HarvestMerge.IsValidContainer(name)
    for k, v in pairs(HarvestMerge.container[HarvestMerge.language]) do
        if v == name then
            return true
        end
    end

    return false
end

-- Arguments Required ItemID, NodeName
-- Returns -1 when Object interacted with is invalid
-- Valid types: (1)Mining, (2)Clothing, (3)Enchanting
-- (4)Alchemy, (5)Wood, (6)Chests, (7)Solvents
-- (8)Fish
function HarvestMerge.CheckProfessionTypeOnImport(id, name)
    local isOk = false
    id = tonumber(id)

    -- Set (1)Mining
    if HarvestMerge.IsValidMining(id, name) then
        isOk = true
    end
    -- Set (2)Clothing
     if HarvestMerge.IsValidClothing(id, name) then
        isOk = true
    end
    -- Set (3)Enchanting
     if HarvestMerge.IsValidEnchanting(id, name) then
        isOk = true
    end
    -- Set (4)Alchemy
     if HarvestMerge.IsValidAlchemy(id, name) then
        isOk = true
    end
    -- Set (5)Woodworking
     if HarvestMerge.IsValidWoodworking(id, name) then
        isOk = true
    end
    -- Set (7)Solvent
    if HarvestMerge.IsValidSolventOnImport(name) then
        isOk = true
    end

    return isOk
end

-- Arguments Required: NodeName
-- Returns -1 when Object interacted with is invalid
-- Valid types: (1)Mining, (2)Clothing, (3)Enchanting
-- (4)Alchemy, (5)Wood, (7)Solvents
-- Containers are assigned 4 Alchemy the same as 2.2
function HarvestMerge.GetProfessionTypeOnUpdate(name)
    local tsId

    if HarvestMerge.IsValidSolvent(name) then
        tsId = 7
        return tsId
    end

    if HarvestMerge.IsValidMiningOnUpdate(name) then
        tsId = 1
        return tsId
    end

    if HarvestMerge.IsValidClothingOnUpdate(name) then
        tsId = 2
        return tsId
    end

    if HarvestMerge.IsValidEnchantingOnUpdate(name) then
        tsId = 3
        return tsId
    end

    if HarvestMerge.IsValidAlchemyOnUpdate(name) then
        tsId = 4
        return tsId
    end

    if HarvestMerge.IsValidWoodworkingOnUpdate(name) then
        tsId = 5
        return tsId
    end

    if HarvestMerge.IsValidContainerOnUpdate(name) then
        tsId = 4
        return tsId
    end

    return -1
end

-- Arguments Required ItemID, NodeName
-- Returns -1 when Object interacted with is invalid
-- Valid types: (1)Mining, (2)Clothing, (3)Enchanting
-- (4)Alchemy, (5)Wood, (6)Chests, (7)Solvents
-- (8)Fish
function HarvestMerge.GetProfessionType(id, name)
    local tsId
    id = tonumber(id)

    if HarvestMerge.savedVars["internal"].debug == 1 then
        d("Attempting GetProfessionType with id : " .. id)
        d("Node Name : " .. name)
    end

    if HarvestMerge.IsValidSolvent(name) then
        tsId = 7
        if HarvestMerge.savedVars["internal"].debug == 1 then
            d("Solvent id assigned : " .. tsId)
        end
        return tsId
    end

    -- For this HarvestMap version there are no containers
    -- Set any container found to 0 so that it is not recorded.
    if HarvestMerge.IsValidContainer(name) then
        tsId = 0
        if HarvestMerge.savedVars["internal"].debug == 1 then
            d("Container is not used in this version id assigned : " .. tsId)
        end
        return tsId
    end

    -- if no valid Node Name by Name is found use ItemID
    for key1, tsData in pairs(HarvestMerge.professions) do
        for key2, value in pairs(tsData) do
            if value == id then
                tsId = key1
                if HarvestMerge.savedVars["internal"].debug == 1 then
                    d("Esohead id assigned : " .. tsId)
                end
                return tsId
            end
        end
    end

    if HarvestMerge.savedVars["internal"].debug == 1 then
        d("No Profession Type found with id : " .. id)
        d("In GetProfessionType with name : " .. name)
    end

    return -1
end

-- local alliance = GetUnitAlliance("player")
-- valid alliance values are:
--  ALLIANCE_ALDMERI_DOMINION = 1
--  ALLIANCE_EBONHEART_PACT = 2
--  ALLIANCE_DAGGRTFALL_COVENANT = 3