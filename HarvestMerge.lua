HarvestMerge = {}
HarvestMerge.chestID = 6
HarvestMerge.fishID = 8

HarvestMerge.internalVersion = 4
HarvestMerge.dataVersion = 4


-----------------------------------------
--           Debug Logger              --
-----------------------------------------

local function EmitMessage(text)
    if(CHAT_SYSTEM)
    then
        if(text == "")
        then
            text = "[Empty String]"
        end

        CHAT_SYSTEM:AddMessage(text)
    end
end

local function EmitTable(t, indent, tableHistory)
    indent          = indent or "."
    tableHistory    = tableHistory or {}

    for k, v in pairs(t)
    do
        local vType = type(v)

        EmitMessage(indent.."("..vType.."): "..tostring(k).." = "..tostring(v))

        if(vType == "table")
        then
            if(tableHistory[v])
            then
                EmitMessage(indent.."Avoiding cycle on table...")
            else
                tableHistory[v] = true
                EmitTable(v, indent.."  ", tableHistory)
            end
        end
    end
end

function HarvestMerge.Debug(...)
    for i = 1, select("#", ...) do
        local value = select(i, ...)
        if(type(value) == "table")
        then
            EmitTable(value)
        else
            EmitMessage(tostring (value))
        end
    end
end

-----------------------------------------
--         HarvestMap Routines         --
-----------------------------------------

function HarvestMerge.saveFishChestNode(type, mapName, x, y)
    -- 1) type 2) map name 3) x 4) y 5) profession 6) nodeName 7) itemID 8) scale
    if type == "fish" then
        HarvestMerge.saveData("nodes", mapName, x, y, HarvestMerge.fishID, type, nil, HarvestMerge.minReticleover, "valid" )
    elseif type == "chest" then
        HarvestMerge.saveData("nodes", mapName, x, y, HarvestMerge.chestID, type, nil, HarvestMerge.minReticleover, "valid" )
    else
        d("HarvestMerge : " .. mapName .. " : unsupported type : " .. type)
        HarvestMerge.saveData("rejected", mapName, x, y, -1, type, nil, HarvestMerge.minReticleover, "reject" )
    end
end

function HarvestMerge.correctItemIDandNodeName(nodeName, itemID)
    local nodeUpdated = false
    if HarvestMerge.IsValidContainerName(nodeName) then
        return nodeName, itemID
    end

    HarvestMerge.setItemIndex(nodeName)

    if nodeName == nil and itemID ~= nil then
        nodeName = HarvestMerge.GetItemNameFromItemID(itemID)
        nodeUpdated = true
    elseif nodeName ~= nil and itemID == nil then
        itemID = HarvestMerge.GetItemIDFromItemName(nodeName)
    end

    if not HarvestMerge.CheckProfessionTypeOnImport(itemID, nodeName) then
        nodeName = HarvestMerge.GetItemNameFromItemID(itemID)
    else
        if not nodeUpdated then
            nodeName = HarvestMerge.translateNodeName(nodeName)
        end
    end
    return nodeName, itemID
end

function HarvestMerge.saveHarvestNode(mapName, x, y, profession, nodeName, itemID)

    if itemID ~= nil then
        if HarvestMerge.checkForValidNodeID(itemID) then
            return
        end
    end

    nodeName, itemID = HarvestMerge.correctItemIDandNodeName(nodeName, itemID)

    if nodeName == nil itemID ~= nil then
        HarvestMerge.saveData("unlocalnode", mapName, x, y, profession, "NilNodeName", itemID, nil, "reject" )
    elseif nodeName ~= nil itemID == nil then
        HarvestMerge.saveData("unlocalnode", mapName, x, y, profession, nodeName, 0, nil, "reject" )
    end

    local professionFound = 0
    professionFound = HarvestMerge.GetProfessionTypeOnUpdate(nodeName) -- Get Profession by name only
    if professionFound <= 0 then
        professionFound = HarvestMerge.GetProfessionType(itemID, nodeName)
    elseif professionFound <= 0 then
        professionFound = profession
    end
    if professionFound < 1 or professionFound > 8 then
        HarvestMerge.saveData("rejected", mapName, x, y, professionFound, nodeName, itemID, nil, "reject" )
        return
    end

    -- 1) type 2) map name 3) x 4) y 5) profession 6) nodeName 7) itemID 8) scale
    if not HarvestMerge.IsValidContainerName(nodeName) then -- returns true or false
        HarvestMerge.saveData("nodes", mapName, x, y, professionFound, nodeName, itemID, nil, "valid" )
    else
        HarvestMerge.NumContainerSkipped = HarvestMerge.NumContainerSkipped + 1
    end
end

function HarvestMerge.GetMap()
    local textureName = GetMapTileTexture()
    textureName = string.lower(textureName)
    textureName = string.gsub(textureName, "^.*maps/", "")
    textureName = string.gsub(textureName, "_%d+%.dds$", "")

    local mapType = GetMapType()
    local mapContentType = GetMapContentType()
    if (mapType == MAPTYPE_SUBZONE) or (mapContentType == MAP_CONTENT_DUNGEON) then
        HarvestMerge.minDist = 0.00005  -- Larger value for minDist since map is smaller
    elseif (mapContentType == MAP_CONTENT_AVA) then
        HarvestMerge.minDist = 0.00001 -- Smaller value for minDist since map is larger
    else
        HarvestMerge.minDist = 0.000025 -- This is the default value for minDist
    end

    return textureName
end

function HarvestMerge.changeCounters(counter)
    if counter == "false" then
        HarvestMerge.NumFalseNodes = HarvestMerge.NumFalseNodes + 1
    end
    if counter == "valid" then
        HarvestMerge.NumNodesAdded = HarvestMerge.NumNodesAdded + 1
    end
    if counter == "nonfalse" then
        HarvestMerge.NumUnlocalizedFalseNodes = HarvestMerge.NumUnlocalizedFalseNodes + 1
    end
    if counter == "nonvalid" then
        HarvestMerge.NumUnlocalizedNodesAdded = HarvestMerge.NumUnlocalizedNodesAdded + 1
    end
    if counter == "reject" then
        HarvestMerge.NumRejectedNodes = HarvestMerge.NumRejectedNodes + 1
    end
    if counter == "insert" then
        HarvestMerge.NumInsertedNodes = HarvestMerge.NumInsertedNodes + 1
    end
end

function HarvestMerge.saveData(type, zone, x, y, profession, nodeName, itemID, scale, counter )

    -- If the map is on the blacklist then don't log it
    if HarvestMerge.blacklistMap(zone) then
        return
    end

    if not profession then
        return
    end

    if HarvestMerge.savedVars[type] == nil or HarvestMerge.savedVars[type].data == nil then
        d("Attempted to log unknown type: " .. type)
        return
    end

    if HarvestMerge.alreadyFound(type, zone, x, y, profession, nodeName, scale, counter ) then
        return
    end

    -- If this check is not here the next routine will fail
    -- after the loading screen because for a brief moment
    -- the information is not available.
    if HarvestMerge.savedVars[type] == nil then
        return
    end

    if not HarvestMerge.savedVars[type].data[zone] then
        HarvestMerge.savedVars[type].data[zone] = {}
    end

    if not HarvestMerge.savedVars[type].data[zone][profession] then
        HarvestMerge.savedVars[type].data[zone][profession] = {}
    end

    if HarvestMerge.internal.debug == 1 then
        d("Save data!")
    end

    table.insert( HarvestMerge.savedVars[type].data[zone][profession], { x, y, { nodeName }, itemID } )
    HarvestMerge.changeCounters(counter)

end

function HarvestMerge.contains(table, value)
    for key, v in pairs(table) do
        if v == value then
            return key
        end
    end
    return nil
end

function HarvestMerge.returnNameFound(table, value)
    for key, name in pairs(table) do
        if name == value then
            return name
        end
    end
    return nil
end

function HarvestMerge.duplicateName(table, value)
    for key, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

function HarvestMerge.alreadyFound(type, zone, x, y, profession, nodeName, scale, counter )

    if not HarvestMerge.savedVars[type].data[zone] then
        return false
    end

    if not HarvestMerge.savedVars[type].data[zone][profession] then
        return false
    end

    local distance
    if scale == nil then
        distance = HarvestMerge.minDefault
    else
        distance = scale
    end

    local dx, dy
    for _, entry in pairs( HarvestMerge.savedVars[type].data[zone][profession] ) do
        dx = entry[1] - x
        dy = entry[2] - y
        -- (x - center_x)2 + (y - center_y)2 = r2, where center is the player
        dist = math.pow(dx, 2) + math.pow(dy, 2)
        -- dist2 = dx * dx + dy * dy
        -- HarvestMerge.Debug(dist .. " : " .. dist2)
        if dist < distance then -- near player location
            if not HarvestMerge.duplicateName(entry[3], nodeName) then
                if HarvestMerge.internal.debug == 1 then
                    HarvestMerge.Debug(nodeName .. " : insterted into existing Node")
                end
                table.insert(entry[3], nodeName)
                HarvestMerge.changeCounters("insert")
            end
            if HarvestMerge.internal.debug == 1 then
                d("Node:" .. nodeName .. " on: " .. zone .. " x:" .. x .." , y:" .. y .. " for profession " .. profession .. " already found!")
            end
            return true
        end
    end
    if HarvestMerge.internal.debug == 1 then
        d("Node:" .. nodeName .. " on: " .. zone .. " x:" .. x .." , y:" .. y .. " for profession " .. profession .. " not found!")
    end
    return false
end

-- formats a number with commas on thousands
function HarvestMerge.NumberFormat(num)
    local formatted = num
    local k

    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then
            break
        end
    end

    return formatted
end

-----------------------------------------
--           Merge Nodes               --
-----------------------------------------

function HarvestMerge.importFromEsohead()
    HarvestMerge.NumNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0
    HarvestMerge.NumUnlocalizedFalseNodes = 0
    HarvestMerge.NumUnlocalizedNodesAdded = 0
    HarvestMerge.NumRejectedNodes = 0
    HarvestMerge.NumInsertedNodes = 0

    if not EH then
        d("Please enable the Esohead addon to import data!")
        return
    end

    d("Starting import from Esohead")
    local profession
    local newMapName
    -- if not HarvestMerge.oldData then
    --     HarvestMerge.oldData = {}
    -- end

    -- Esohead "harvest" Profession designations
    -- 1 Mining
    -- 2 Clothing
    -- 3 Enchanting
    -- 4 Alchemy
    -- 5 Was Provisioning, moved to separate section in Esohead
    -- 6 Wood

    -- Additional HarvestMap Catagories
    -- 6 = Chest, 7 = Solvent, 8 = Fish

    local professionFound
    d("Import Harvest Nodes:")
    for map, data in pairs(EH.savedVars["harvest"].data) do
        HarvestMerge.Debug("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for profession, nodes in pairs(data) do
                for index, node in pairs(nodes) do
                    if HarvestMerge.checkForValidNodeID(node[5]) and node[4] ~= nil then
                        -- [1], [2] = X/Y, [3] = Stack Size, [4] = nodeName, [5] = itemID
                        node[4] = HarvestMerge.correctItemIDandNodeName(node[4], node[5])
                        -- HarvestMerge.Debug(node[1] .. " : " .. node[2] .. " : " .. profession .. " : " .. node[4] .. " : " .. node[5])
                        -- [1] map name [2], [3] = X/Y, [4] profession [5] nodeName [6] itemID
                        HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                        HarvestMerge.saveHarvestNode(newMapName, node[1], node[2], profession, node[4], node[5])
                    end
                end
            end
        else -- << New Map Name NOT found
            oldMapName = map
            HarvestMerge.Debug(oldMapName .. " could not be localized.  Saving to oldData!")
            for profession, nodes in pairs(data) do
                for index, node in pairs(nodes) do
                    if HarvestMerge.checkForValidNodeID(node[5]) and node[4] ~= nil then
                        -- [1], [2] = X/Y, [3] = Stack Size, [4] = nodeName, [5] = itemID
                        node[4] = HarvestMerge.correctItemIDandNodeName(node[4], node[5])
                        -- HarvestMerge.Debug(node[1] .. " : " .. node[2] .. " : " .. profession .. " : " .. node[4] .. " : " .. node[5])
                        -- [1] map name [2], [3] = X/Y, [4] profession [5] nodeName [6] itemID
                        HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                        HarvestMerge.saveHarvestNode(oldMapName, node[1], node[2], profession, node[4], node[5])
                    end
                end
            end
        end
    end

    d("Import Chests:")
    for map, nodes in pairs(EH.savedVars["chest"].data) do
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for _, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.saveFishChestNode("chest", newMapName, node[1], node[2])
            end
        else -- << New Map Name NOT found
            oldMapName = map
            HarvestMerge.Debug(oldMapName .. " could not be localized.  Saving to oldData!")
            for v1, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.saveFishChestNode("chest", oldMapName, node[1], node[2])
            end
        end
    end

    d("Import Fishing Holes:")
    for map, nodes in pairs(EH.savedVars["fish"].data) do
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for _, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.saveFishChestNode("fish", newMapName, node[1], node[2])
            end
        else -- << New Map Name NOT found
            oldMapName = map
            HarvestMerge.Debug(oldMapName .. " could not be localized.  Saving to oldData!")
            for v1, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.saveFishChestNode("fish", oldMapName, node[1], node[2])
            end
        end
    end

    d("Number of nodes processed : " .. tostring(HarvestMerge.NumNodesProcessed) )
    d("Number of nodes added : " .. tostring(HarvestMerge.NumNodesAdded) )
    HarvestMerge.Debug("Number of nodes inserted : " .. tostring(HarvestMerge.NumInsertedNodes) )
    d("Number of Containers skipped : " .. tostring(HarvestMerge.NumContainerSkipped) )
    d("Number of False Nodes saved : " .. tostring(HarvestMerge.NumFalseNodes) )
    d("Number of Unlocalized nodes saved : " .. tostring(HarvestMerge.NumUnlocalizedNodesAdded) )
    d("Number of Unlocalized False Nodes saved : " .. tostring(HarvestMerge.NumUnlocalizedFalseNodes) )
    -- d("Number of Rejected Nodes saved : " .. tostring(HarvestMerge.NumRejectedNodes) )
    d("Finished.")
end

function HarvestMerge.importFromEsoheadMerge()
    HarvestMerge.NumNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0
    HarvestMerge.NumUnlocalizedFalseNodes = 0
    HarvestMerge.NumUnlocalizedNodesAdded = 0
    HarvestMerge.NumRejectedNodes = 0
    HarvestMerge.NumInsertedNodes = 0

    if not EHM then
        d("Please enable the EsoheadMerge addon to import data!")
        return
    end

    d("Starting import from EsoheadMerge")
    local profession
    local newMapName
    -- if not HarvestMerge.oldData then
    --     HarvestMerge.oldData = {}
    -- end

    -- Esohead "harvest" Profession designations
    -- 1 Mining
    -- 2 Clothing
    -- 3 Enchanting
    -- 4 Alchemy
    -- 5 Was Provisioning, moved to separate section in Esohead
    -- 6 Wood

    -- Additional HarvestMap Catagories
    -- 6 = Chest, 7 = Solvent, 8 = Fish

    local professionFound
    d("Import Harvest Nodes:")
    for map, data in pairs(EHM.savedVars["harvest"].data) do
        HarvestMerge.Debug("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for profession, nodes in pairs(data) do
                for index, node in pairs(nodes) do
                    if HarvestMerge.checkForValidNodeID(node[5]) and node[4] ~= nil then
                        -- [1], [2] = X/Y, [3] = Stack Size, [4] = nodeName, [5] = itemID
                        node[4] = HarvestMerge.correctItemIDandNodeName(node[4], node[5])
                        -- HarvestMerge.Debug(node[1] .. " : " .. node[2] .. " : " .. profession .. " : " .. node[4] .. " : " .. node[5])
                        -- [1] map name [2], [3] = X/Y, [4] profession [5] nodeName [6] itemID
                        HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                        HarvestMerge.saveHarvestNode(newMapName, node[1], node[2], profession, node[4], node[5])
                    end
                end
            end
        else -- << New Map Name NOT found
            oldMapName = map
            HarvestMerge.Debug(oldMapName .. " could not be localized.  Saving to oldData!")
            for profession, nodes in pairs(data) do
                for index, node in pairs(nodes) do
                    if HarvestMerge.checkForValidNodeID(node[5]) and node[4] ~= nil then
                        -- [1], [2] = X/Y, [3] = Stack Size, [4] = nodeName, [5] = itemID
                        node[4] = HarvestMerge.correctItemIDandNodeName(node[4], node[5])
                        -- HarvestMerge.Debug(node[1] .. " : " .. node[2] .. " : " .. profession .. " : " .. node[4] .. " : " .. node[5])
                        -- [1] map name [2], [3] = X/Y, [4] profession [5] nodeName [6] itemID
                        HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                        HarvestMerge.saveHarvestNode(oldMapName, node[1], node[2], profession, node[4], node[5])
                    end
                end
            end
        end
    end

    d("Import Chests:")
    for map, nodes in pairs(EHM.savedVars["chest"].data) do
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for _, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.saveFishChestNode("chest", newMapName, node[1], node[2])
            end
        else -- << New Map Name NOT found
            oldMapName = map
            HarvestMerge.Debug(oldMapName .. " could not be localized.  Saving to oldData!")
            for v1, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.saveFishChestNode("chest", oldMapName, node[1], node[2])
            end
        end
    end

    d("Import Fishing Holes:")
    for map, nodes in pairs(EHM.savedVars["fish"].data) do
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for _, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.saveFishChestNode("fish", newMapName, node[1], node[2])
            end
        else -- << New Map Name NOT found
            oldMapName = map
            HarvestMerge.Debug(oldMapName .. " could not be localized.  Saving to oldData!")
            for v1, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.saveFishChestNode("fish", oldMapName, node[1], node[2])
            end
        end
    end

    d("Number of nodes processed : " .. tostring(HarvestMerge.NumNodesProcessed) )
    d("Number of nodes added : " .. tostring(HarvestMerge.NumNodesAdded) )
    HarvestMerge.Debug("Number of nodes inserted : " .. tostring(HarvestMerge.NumInsertedNodes) )
    d("Number of Containers skipped : " .. tostring(HarvestMerge.NumContainerSkipped) )
    d("Number of False Nodes saved : " .. tostring(HarvestMerge.NumFalseNodes) )
    d("Number of Unlocalized nodes saved : " .. tostring(HarvestMerge.NumUnlocalizedNodesAdded) )
    d("Number of Unlocalized False Nodes saved : " .. tostring(HarvestMerge.NumUnlocalizedFalseNodes) )
    -- d("Number of Rejected Nodes saved : " .. tostring(HarvestMerge.NumRejectedNodes) )
    d("Finished.")
end

function HarvestMerge.importFromHarvester()
    HarvestMerge.NumNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0
    HarvestMerge.NumUnlocalizedFalseNodes = 0
    HarvestMerge.NumUnlocalizedNodesAdded = 0
    HarvestMerge.NumRejectedNodes = 0
    HarvestMerge.NumInsertedNodes = 0

    if not Harvester then
        d("Please enable the Harvester addon to import data!")
        return
    end

    d("Starting import from Harvester")
    local profession
    local newMapName
    -- if not HarvestMerge.oldData then
    --     HarvestMerge.oldData = {}
    -- end

    -- Esohead "harvest" Profession designations
    -- 1 Mining
    -- 2 Clothing
    -- 3 Enchanting
    -- 4 Alchemy
    -- 5 Was Provisioning, moved to separate section in Esohead
    -- 6 Wood

    -- Additional HarvestMap Catagories
    -- 6 = Chest, 7 = Solvent, 8 = Fish

    local professionFound
    d("Import Harvest Nodes:")
    for map, data in pairs(Harvester.savedVars["harvest"].data) do
        HarvestMerge.Debug("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for profession, nodes in pairs(data) do
                for index, node in pairs(nodes) do
                    if HarvestMerge.checkForValidNodeID(node[5]) and node[4] ~= nil then
                        -- [1], [2] = X/Y, [3] = Stack Size, [4] = nodeName, [5] = itemID
                        node[4] = HarvestMerge.correctItemIDandNodeName(node[4], node[5])
                        -- HarvestMerge.Debug(node[1] .. " : " .. node[2] .. " : " .. profession .. " : " .. node[4] .. " : " .. node[5])
                        -- [1] map name [2], [3] = X/Y, [4] profession [5] nodeName [6] itemID
                        HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                        HarvestMerge.saveHarvestNode(newMapName, node[1], node[2], profession, node[4], node[5])
                    end
                end
            end
        else -- << New Map Name NOT found
            oldMapName = map
            HarvestMerge.Debug(oldMapName .. " could not be localized.  Saving to oldData!")
            for profession, nodes in pairs(data) do
                for index, node in pairs(nodes) do
                    if HarvestMerge.checkForValidNodeID(node[5]) and node[4] ~= nil then
                        -- [1], [2] = X/Y, [3] = Stack Size, [4] = nodeName, [5] = itemID
                        node[4] = HarvestMerge.correctItemIDandNodeName(node[4], node[5])
                        -- HarvestMerge.Debug(node[1] .. " : " .. node[2] .. " : " .. profession .. " : " .. node[4] .. " : " .. node[5])
                        -- [1] map name [2], [3] = X/Y, [4] profession [5] nodeName [6] itemID
                        HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                        HarvestMerge.saveHarvestNode(oldMapName, node[1], node[2], profession, node[4], node[5])
                    end
                end
            end
        end
    end

    d("Import Chests:")
    for map, nodes in pairs(Harvester.savedVars["chest"].data) do
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for _, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.saveFishChestNode("chest", newMapName, node[1], node[2])
            end
        else -- << New Map Name NOT found
            oldMapName = map
            HarvestMerge.Debug(oldMapName .. " could not be localized.  Saving to oldData!")
            for v1, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.saveFishChestNode("chest", oldMapName, node[1], node[2])
            end
        end
    end

    d("Import Fishing Holes:")
    for map, nodes in pairs(Harvester.savedVars["fish"].data) do
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for _, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.saveFishChestNode("fish", newMapName, node[1], node[2])
            end
        else -- << New Map Name NOT found
            oldMapName = map
            HarvestMerge.Debug(oldMapName .. " could not be localized.  Saving to oldData!")
            for v1, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.saveFishChestNode("fish", oldMapName, node[1], node[2])
            end
        end
    end

    d("Number of nodes processed : " .. tostring(HarvestMerge.NumNodesProcessed) )
    d("Number of nodes added : " .. tostring(HarvestMerge.NumNodesAdded) )
    HarvestMerge.Debug("Number of nodes inserted : " .. tostring(HarvestMerge.NumInsertedNodes) )
    d("Number of Containers skipped : " .. tostring(HarvestMerge.NumContainerSkipped) )
    d("Number of False Nodes saved : " .. tostring(HarvestMerge.NumFalseNodes) )
    d("Number of Unlocalized nodes saved : " .. tostring(HarvestMerge.NumUnlocalizedNodesAdded) )
    d("Number of Unlocalized False Nodes saved : " .. tostring(HarvestMerge.NumUnlocalizedFalseNodes) )
    -- d("Number of Rejected Nodes saved : " .. tostring(HarvestMerge.NumRejectedNodes) )
    d("Finished.")
end

function HarvestMerge.importFromHarvestMap()
    HarvestMerge.NumNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0
    HarvestMerge.NumUnlocalizedFalseNodes = 0
    HarvestMerge.NumUnlocalizedNodesAdded = 0
    HarvestMerge.NumRejectedNodes = 0
    HarvestMerge.NumInsertedNodes = 0

    if not Harvest then
        d("Please enable the HarvestMap addon to import data!")
        return
    end

    d("Starting import from HarvestMap")
    for newMapName, data in pairs(Harvest.savedVars["nodes"].data) do
        for profession, nodes in pairs(data) do
            for index, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                for contents, nodeName in ipairs(node[3]) do
                    -- [1], [2] = X/Y, [3] = Node Names, [4] = itemID
                    if (nodeName) ~= "chest" and (nodeName) ~= "fish" then
                        nodeName, node[4] = HarvestMerge.correctItemIDandNodeName(nodeName, node[4])
                    end

                    if (nodeName) == "chest" or (nodeName) == "fish" then
                        HarvestMerge.saveFishChestNode(nodeName, newMapName, node[1], node[2])
                    else
                        if HarvestMerge.checkForValidNodeID(node[4]) then
                            HarvestMerge.saveHarvestNode(newMapName, node[1], node[2], profession, nodeName, node[4])
                        end
                    end

                end
            end
        end
    end

    HarvestMerge.Debug("Number of nodes processed : " .. tostring(HarvestMerge.NumNodesProcessed) )
    HarvestMerge.Debug("Number of nodes added : " .. tostring(HarvestMerge.NumNodesAdded) )
    HarvestMerge.Debug("Number of nodes inserted : " .. tostring(HarvestMerge.NumInsertedNodes) )
    -- HarvestMerge.Debug("Number of Rejected Nodes saved : " .. tostring(HarvestMerge.NumRejectedNodes) )
    HarvestMerge.Debug("Finished.")
end

-----------------------------------------
--           Slash Command             --
-----------------------------------------

HarvestMerge.validCategories = {
    "nodes",
    "mapinvalid",
    "esonodes",
    "esoinvalid",
}

function HarvestMerge.IsValidCategory(name)
    for k, v in pairs(HarvestMerge.validCategories) do
        if string.lower(v) == string.lower(name) then
            return true
        end
    end

    return false
end

function HarvestMerge.getTotals(counter)
    local totalNodes = 0
    for counterName, counterValue in pairs(counter) do
        totalNodes = totalNodes + counterValue
    end
    return totalNodes
end

SLASH_COMMANDS["/merger"] = function (cmd)
    local commands = {}
    local index = 1
    for i in string.gmatch(cmd, "%S+") do
        if (i ~= nil and i ~= "") then
            commands[index] = i
            index = index + 1
        end
    end

    if #commands == 0 then
        return d("Please enter a valid HarvestMerge command")
    end

    if #commands == 2 and commands[1] == "debug" then
        if commands[2] == "on" then
            d("HarvestMerge debugger toggled on")
            HarvestMerge.internal.debug = 1
        elseif commands[2] == "off" then
            d("HarvestMerge debugger toggled off")
            HarvestMerge.internal.debug = 0
        end

    elseif #commands == 2 and commands[1] == "import" then

        if commands[2] == "esohead" then
            HarvestMerge.importFromEsohead()
        elseif commands[2] == "esomerge" then
            HarvestMerge.importFromEsoheadMerge()
        elseif commands[2] == "harvester" then
            HarvestMerge.importFromHarvester()
        elseif commands[2] == "harvestmap" then
            HarvestMerge.importFromHarvestMap()
        end

    elseif #commands == 2 and commands[1] == "update" then
        if  HarvestMerge.IsValidCategory(commands[2]) then
             HarvestMerge.updateHarvestNodes(commands[2])
        else
            d("Please enter a valid HarvestMerge category to update")
            d("Valid categories are mapinvalid, esonodes, esoinvalid,")
            d("and nodes (Not recomended)")
            return
        end

    elseif commands[1] == "reset" then
        if #commands ~= 2 then
            for type,sv in pairs(HarvestMerge.savedVars) do
                if type ~= "internal" then
                    HarvestMerge.savedVars[type].data = {}
                end
            end
            d("HarvestMerge saved data has been completely reset")
        else
            if commands[2] ~= "internal" then
                if HarvestMerge.IsValidCategory(commands[2]) then
                    HarvestMerge.savedVars[commands[2]].data = {}
                    d("HarvestMerge saved data : " .. commands[2] .. " has been reset")
                else
                    return d("Please enter a valid HarvestMerge category to reset")
                end
            end
        end


    elseif commands[1] == "datalog" then
        if #commands ~= 2 and not HarvestMerge.IsValidCategory(commands[2]) then
            d("please enter a valid type")
        else
            d("---")
            d("Complete list of gathered data:")
            d("---")

            local counter = {
                ["mining"] = 0,
                ["cloth"] = 0,
                ["rune"] = 0,
                ["alch"] = 0,
                ["wood"] = 0,
                ["chest"] = 0,
                ["solvent"] = 0,
                ["fish"] = 0,
            }

            for type,sv in pairs(HarvestMerge.savedVars) do
                --[[
                if type ~= "internal" and (type == "chest" or type == "fish") then
                    for zone, t1 in pairs(HarvestMerge.savedVars[type].data) do
                        counter[type] = counter[type] + #HarvestMerge.savedVars[type].data[zone]
                    end
                ]]--
                if type ~= "defaults" and type == commands[2] then
                    for zone, t1 in pairs(HarvestMerge.savedVars[commands[2]].data) do
                        for provisions, t2 in pairs(HarvestMerge.savedVars[commands[2]].data[zone]) do
                            if provisions == 1 then
                                counter["mining"] = counter["mining"] + #HarvestMerge.savedVars[commands[2]].data[zone][provisions]
                            end
                            if provisions == 2 then
                                counter["cloth"] = counter["cloth"] + #HarvestMerge.savedVars[commands[2]].data[zone][provisions]
                            end
                            if provisions == 3 then
                                counter["rune"] = counter["rune"] + #HarvestMerge.savedVars[commands[2]].data[zone][provisions]
                            end
                            if provisions == 4 then
                                counter["alch"] = counter["alch"] + #HarvestMerge.savedVars[commands[2]].data[zone][provisions]
                            end
                            if provisions == 5 then
                                counter["wood"] = counter["wood"] + #HarvestMerge.savedVars[commands[2]].data[zone][provisions]
                            end
                            if provisions == HarvestMerge.chestID then
                                counter["chest"] = counter["chest"] + #HarvestMerge.savedVars[commands[2]].data[zone][provisions]
                            end
                            if provisions == 7 then
                                counter["solvent"] = counter["solvent"] + #HarvestMerge.savedVars[commands[2]].data[zone][provisions]
                            end
                            if provisions == HarvestMerge.fishID then
                                counter["fish"] = counter["fish"] + #HarvestMerge.savedVars[commands[2]].data[zone][provisions]
                            end
                        end
                    end
                --[[
                elseif type ~= "internal" then
                    for zone, t1 in pairs(HarvestMerge.savedVars[type].data) do
                        for data, t2 in pairs(HarvestMerge.savedVars[type].data[zone]) do
                            counter[type] = counter[type] + #HarvestMerge.savedVars[type].data[zone][data]
                        end
                    end
                ]]--
                end
            end

            local totals = HarvestMerge.getTotals(counter)
            d("Mining: "          .. HarvestMerge.NumberFormat(counter["mining"]))
            d("Clothing: "          .. HarvestMerge.NumberFormat(counter["cloth"]))
            d("Enchanting: "          .. HarvestMerge.NumberFormat(counter["rune"]))
            d("Alchemy: "          .. HarvestMerge.NumberFormat(counter["alch"]))
            d("Woodworking: "          .. HarvestMerge.NumberFormat(counter["wood"]))
            d("Treasure Chests: "  .. HarvestMerge.NumberFormat(counter["chest"]))
            d("Solvent: "          .. HarvestMerge.NumberFormat(counter["solvent"]))
            d("Fishing Pools: "    .. HarvestMerge.NumberFormat(counter["fish"]))
            d("Total: "    .. HarvestMerge.NumberFormat(totals))

            d("---")
        end
    end

end

SLASH_COMMANDS["/rl"] = function()
    ReloadUI("ingame")
end

function HarvestMerge.OnLoad(eventCode, addOnName)

    HarvestMerge.internal = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 2, "internal", {
        debug = 0,
        verbose = false,
        internalVersion = 0,
        dataVersion = 0,
        language = ""
    })

    HarvestMerge.savedVars = {
        -- All Localized Nodes
        ["nodes"]           = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 2, "nodes", HarvestMerge.dataDefault),
        -- All Invalid Localized Nodes
        ["mapinvalid"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 2, "mapinvalid", HarvestMerge.dataDefault),
        -- All Unlocalized Nodes
        ["esonodes"]        = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 2, "esonodes", HarvestMerge.dataDefault),
        -- All Invalid Unlocalized Nodes
        ["esoinvalid"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 2, "esoinvalid", HarvestMerge.dataDefault),

        -- All rejected records for debugging
        ["rejected"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 2, "rejected", HarvestMerge.dataDefault),
        ["unlocalnode"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 2, "unlocalnode", HarvestMerge.dataDefault),

        -- These nodes are not used after version 2
        --Localized HarvestMap Nodes
        ["harvest"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "harvest", HarvestMerge.dataDefault),
        ["chest"]        = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "chest", HarvestMerge.dataDefault),
        ["fish"]         = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "fish", HarvestMerge.dataDefault),
        --Unlocalized HarvestMap Nodes
        ["esoharvest"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "esoharvest", HarvestMerge.dataDefault),
        ["esochest"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "esochest", HarvestMerge.dataDefault),
        ["esofish"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "esofish", HarvestMerge.dataDefault)
    }

    HarvestMerge.internal.language = HarvestMerge.language

    -- Run once to pull out esohead format and move data to new containers
    -- First release the internalVersion was "1" so only check if less then "2"
    if HarvestMerge.internal.internalVersion < 2 then
        HarvestMerge.updateHarvestNodes("harvest")
        HarvestMerge.updateHarvestNodes("chest")
        HarvestMerge.updateHarvestNodes("fish")
        HarvestMerge.updateEsoheadNodes("esoharvest")
        HarvestMerge.updateEsoheadNodes("esochest")
        HarvestMerge.updateEsoheadNodes("esofish")
        HarvestMerge.internal.internalVersion = HarvestMerge.internalVersion
    end

    if HarvestMerge.internal.dataVersion < HarvestMerge.dataVersion then
        HarvestMerge.updateHarvestNodes("nodes")
        HarvestMerge.updateHarvestNodes("mapinvalid")
        HarvestMerge.updateHarvestNodes("esonodes")
        HarvestMerge.updateHarvestNodes("esoinvalid")
        HarvestMerge.internal.dataVersion = HarvestMerge.dataVersion
    end

    if HarvestMerge.internal.internalVersion ~= HarvestMerge.internalVersion then
        HarvestMerge.internal.internalVersion = HarvestMerge.internalVersion
    end

    if HarvestMerge.internal.debug == 1 then
        d("HarvestMerge addon initialized. Debugging is enabled.")
    else
        d("HarvestMerge addon initialized. Debugging is disabled.")
    end

end

function HarvestMerge.Initialize()

    HarvestMerge.savedVars = {}
    HarvestMerge.debugDefault = 0
    HarvestMerge.dataDefault = {
        data = {}
    }

    --supported localizations
    HarvestMerge.langs = { "en", "de", "fr", }

    HarvestMerge.language = (GetCVar("language.2") or "en")

    HarvestMerge.minDefault = 0.000025 -- 0.005^2
    HarvestMerge.minDist = 0.000025 -- 0.005^2
    HarvestMerge.minReticleover = 0.000049 -- 0.007^2

    HarvestMerge.NumNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0
    HarvestMerge.NumUnlocalizedFalseNodes = 0
    HarvestMerge.NumUnlocalizedNodesAdded = 0
    HarvestMerge.NumRejectedNodes = 0
    HarvestMerge.NumInsertedNodes = 0

end

EVENT_MANAGER:RegisterForEvent("HarvestMerge", EVENT_ADD_ON_LOADED, function (eventCode, addOnName)
    if addOnName == "HarvestMerge" then
        HarvestMerge.Initialize()
        HarvestMerge.OnLoad(eventCode, addOnName)
    end
end)