HarvestMerge = {}
HarvestMerge.chestID = 6
HarvestMerge.fishID = 8

local internalVersion = 2

-----------------------------------------
--         HarvestMap Routines         --
-----------------------------------------

function HarvestMerge.newMapNameFishChest(type, newMapName, x, y)
    -- 1) type 2) map name 3) x 4) y 5) profession 6) nodeName 7) itemID 8) scale
        if type == "fish" then
            HarvestMerge.saveData("nodes", newMapName, x, y, HarvestMerge.fishID, type, nil, HarvestMerge.minReticleover, "valid" )
        elseif type == "chest" then
            HarvestMerge.saveData("nodes", newMapName, x, y, HarvestMerge.chestID, type, nil, HarvestMerge.minReticleover, "valid" )
        else
            d("unsupported type : " .. type)
        end
end
function HarvestMerge.oldMapNameFishChest(type, oldMapName, x, y)
    -- 1) type 2) map name 3) x 4) y 5) profession 6) nodeName 7) itemID 8) scale
    if type == HarvestMerge.chestID then
        HarvestMerge.saveData("esonodes", oldMapName, x, y, HarvestMerge.chestID, "chest", nil, HarvestMerge.minReticleover, "nonvalid" )
    elseif type == HarvestMerge.fishID then
        HarvestMerge.saveData("esonodes", oldMapName, x, y, HarvestMerge.fishID, "fish", nil, HarvestMerge.minReticleover, "nonvalid" )
    else
        d("unsupported type : " .. type)
    end
end

function HarvestMerge.newMapNilItemIDHarvest(newMapName, x, y, profession, nodeName)
    local professionFound
    professionFound = HarvestMerge.GetProfessionTypeOnUpdate(nodeName) -- Get Profession by name only
    if professionFound <= 0 then
        professionFound = profession
    end

    -- 1) type 2) map name 3) x 4) y 5) profession 6) nodeName 7) itemID 8) scale
    if not HarvestMerge.IsValidContainerName(nodeName) then
        HarvestMerge.saveData("nodes", newMapName, x, y, professionFound, nodeName, nil, nil, "valid" )
    else
        HarvestMerge.NumContainerSkipped = HarvestMerge.NumContainerSkipped +1
    end
end

function HarvestMerge.oldMapNilItemIDHarvest(oldMapName, x, y, profession, nodeName)
    local professionFound
    professionFound = HarvestMerge.GetProfessionTypeOnUpdate(nodeName) -- Get Profession by name only
    if professionFound <= 0 then
        professionFound = profession
    end

    -- 1) type 2) map name 3) x 4) y 5) profession 6) nodeName 7) itemID 8) scale
    if not HarvestMerge.IsValidContainerName(nodeName) then
        HarvestMerge.saveData("esonodes", oldMapName, x, y, professionFound, nodeName, nil, nil, "nonvalid" )
    else
        HarvestMerge.NumContainerSkipped = HarvestMerge.NumContainerSkipped +1
    end
end

function HarvestMerge.newMapItemIDHarvest(newMapName, x, y, profession, nodeName, itemID)
    local professionFound = 0
    professionFound = HarvestMerge.GetProfessionTypeOnUpdate(nodeName) -- Get Profession by name only
    if professionFound <= 0 then
        professionFound = HarvestMerge.GetProfessionType(itemID, nodeName)
    elseif professionFound <= 0 then
        professionFound = profession
    end

    -- 1) type 2) map name 3) x 4) y 5) profession 6) nodeName 7) itemID 8) scale
    if not HarvestMerge.IsValidContainerName(nodeName) then -- returns true or false
        if HarvestMerge.CheckProfessionTypeOnImport(itemID, nodeName) then -- returns true or false no item Id number
            HarvestMerge.saveData("nodes", newMapName, x, y, professionFound, nodeName, itemID, nil, "valid" )
        else
            HarvestMerge.saveData("mapinvalid", newMapName, x, y, professionFound, nodeName, itemID, nil, "false" )
        end
    else
        HarvestMerge.NumContainerSkipped = HarvestMerge.NumContainerSkipped + 1
    end
end

function HarvestMerge.oldMapItemIDHarvest(oldMapName, x, y, profession, nodeName, itemID)
    local professionFound = 0
    professionFound = HarvestMerge.GetProfessionTypeOnUpdate(nodeName) -- Get Profession by name only
    if professionFound <= 0 then
        professionFound = HarvestMerge.GetProfessionType(itemID, nodeName)
    elseif professionFound <= 0 then
        professionFound = profession
    end

    -- 1) type 2) map name 3) x 4) y 5) profession 6) nodeName 7) itemID 8) scale
    if not HarvestMerge.IsValidContainerName(nodeName) then -- returns true or false
        if HarvestMerge.CheckProfessionTypeOnImport(itemID, nodeName) then -- returns true or false no item Id number
            HarvestMerge.saveData("esonodes", oldMapName, x, y, professionFound, nodeName, itemID, nil, "nonvalid" )
        else
            HarvestMerge.saveData("esoinvalid", oldMapName, x, y, professionFound, nodeName, itemID, nil, "nonfalse" )
        end
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

function changeCounters(counter)
    if counter == "false" then
        HarvestMerge.NumFalseNodes = HarvestMerge.NumFalseNodes + 1
    end
    if counter == "valid" then
        HarvestMerge.NumbersNodesAdded = HarvestMerge.NumbersNodesAdded + 1
    end
    if counter == "nonvalid" then
        HarvestMerge.NumbersUnlocalizedNodesAdded = HarvestMerge.NumbersUnlocalizedNodesAdded + 1
    end
    if counter == "nonfalse" then
        HarvestMerge.NumUnlocalizedFalseNodes = HarvestMerge.NumUnlocalizedFalseNodes + 1
    end
end

function HarvestMerge.saveData(type, zone, x, y, profession, nodeName, itemID, scale, counter )

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
    changeCounters(counter)

end

function HarvestMerge.contains(table, value)
    for key, v in pairs(table) do
        if v == value then
            return key
        end
    end
    return nil
end

function HarvestMerge.alreadyFound(type, zone, x, y, profession, nodeName, scale, counter )

    -- If this check is not here the next routine will fail
    -- after the loading screen because for a brief moment
    -- the information is not available.
    if HarvestMerge.savedVars[type] == nil then
        return
    end

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

    for _, entry in pairs( HarvestMerge.savedVars[type].data[zone][profession] ) do
        --if entry[3] == nodeName then
            dx = entry[1] - x
            dy = entry[2] - y
            -- (x - center_x)2 + (y - center_y)2 = r2, where center is the player
            dist = math.pow(dx, 2) + math.pow(dy, 2)
            if dist < distance then
                if profession > 0 then
                    if not HarvestMerge.contains(entry[3], nodeName) then
                        table.insert(entry[3], nodeName)
                        changeCounters(counter)
                    end
                    if HarvestMerge.internal.debug == 1 then
                        d("Node : " .. nodeName .. " on : " .. zone .. " x:" .. x .." , y:" .. y .. " for profession " .. profession .. " already found!")
                    end
                    return true
                else
                    if entry[3][1] == nodeName then
                        if HarvestMerge.internal.debug == 1 then
                            d("Node : " .. nodeName .. " on : " .. zone .. " x:" .. x .." , y:" .. y .. " for profession " .. profession .. " already found!")
                        end
                        return true
                    end
                end
            end
        --end
        end
    if HarvestMerge.internal.debug == 1 then
        d("Node : " .. nodeName .. " on : " .. zone .. " x:" .. x .." , y:" .. y .. " for profession " .. profession .. " not found!")
    end
    return false
end

-----------------------------------------
--           Merge Nodes               --
-----------------------------------------

function HarvestMerge.importFromEsohead()
    HarvestMerge.NumbersNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumbersNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0
    HarvestMerge.NumUnlocalizedFalseNodes = 0
    HarvestMerge.NumbersUnlocalizedNodesAdded = 0

    if not EH then
        d("Please enable the Esohead addon to import data!")
        return
    end

    d("import data from Esohead")
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
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for index, nodes in pairs(data) do
                for _, node in pairs(nodes) do
                    HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                    -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                    HarvestMerge.newMapItemIDHarvest(newMapName, node[1], node[2], profession, node[4], node[5])
                end
            end
        else -- << New Map Name NOT found
            d(map .. " could not be localized.  Saving to oldData!")
            for index, nodes in pairs(data) do
                for v1, node in pairs(nodes) do
                    HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                    -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                    HarvestMerge.oldMapItemIDHarvest(map, node[1], node[2], profession, node[4], node[5])
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
                HarvestMerge.newMapNameFishChest("chest", newMapName, node[1], node[2])
            end
        else -- << New Map Name NOT found
            d(map .. " could not be localized.  Saving to oldData!")
            for v1, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.oldMapNameFishChest("chest", map, node[1], node[2])
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
                HarvestMerge.newMapNameFishChest("fish", newMapName, node[1], node[2])
            end
        else -- << New Map Name NOT found
            d(map .. " could not be localized.  Saving to oldData!")
            for v1, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.oldMapNameFishChest("fish", map, node[1], node[2])
            end
        end
    end

    d("Number of nodes processed : " .. tostring(HarvestMerge.NumNodesProcessed) )
    d("Number of nodes added : " .. tostring(HarvestMerge.NumbersNodesAdded) )
    d("Number of Containers skipped : " .. tostring(HarvestMerge.NumContainerSkipped) )
    d("Number of False Nodes skipped : " .. tostring(HarvestMerge.NumFalseNodes) )
    d("Number of Unlocalized nodes saved : " .. tostring(HarvestMerge.NumbersUnlocalizedNodesAdded) )
    d("Number of Unlocalized False Nodes skipped : " .. tostring(HarvestMerge.NumUnlocalizedFalseNodes) )
    d("Finished.")
end

function HarvestMerge.importFromEsoheadMerge()
    HarvestMerge.NumbersNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumbersNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0
    HarvestMerge.NumUnlocalizedFalseNodes = 0
    HarvestMerge.NumbersUnlocalizedNodesAdded = 0

    if not EHM then
        d("Please enable the EsoheadMerge addon to import data!")
        return
    end

    d("import data from EsoheadMerge")
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
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for index, nodes in pairs(data) do
                for _, node in pairs(nodes) do
                    HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                    -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                    HarvestMerge.newMapItemIDHarvest(newMapName, node[1], node[2], profession, node[4], node[5])
                end
            end
        else -- << New Map Name NOT found
            d(map .. " could not be localized.  Saving to oldData!")
            for index, nodes in pairs(data) do
                for v1, node in pairs(nodes) do
                    HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                    -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                    HarvestMerge.oldMapItemIDHarvest(map, node[1], node[2], profession, node[4], node[5])
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
                HarvestMerge.newMapNameFishChest("chest", newMapName, node[1], node[2])
            end
        else -- << New Map Name NOT found
            d(map .. " could not be localized.  Saving to oldData!")
            for v1, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.oldMapNameFishChest("chest", map, node[1], node[2])
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
                HarvestMerge.newMapNameFishChest("fish", newMapName, node[1], node[2])
            end
        else -- << New Map Name NOT found
            d(map .. " could not be localized.  Saving to oldData!")
            for v1, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.oldMapNameFishChest("fish", map, node[1], node[2])
            end
        end
    end

    d("Number of nodes processed : " .. tostring(HarvestMerge.NumNodesProcessed) )
    d("Number of nodes added : " .. tostring(HarvestMerge.NumbersNodesAdded) )
    d("Number of Containers skipped : " .. tostring(HarvestMerge.NumContainerSkipped) )
    d("Number of False Nodes skipped : " .. tostring(HarvestMerge.NumFalseNodes) )
    d("Number of Unlocalized nodes saved : " .. tostring(HarvestMerge.NumbersUnlocalizedNodesAdded) )
    d("Number of Unlocalized False Nodes skipped : " .. tostring(HarvestMerge.NumUnlocalizedFalseNodes) )
    d("Finished.")
end

function HarvestMerge.importFromHarvester()
    HarvestMerge.NumbersNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumbersNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0
    HarvestMerge.NumUnlocalizedFalseNodes = 0
    HarvestMerge.NumbersUnlocalizedNodesAdded = 0

    if not Harvester then
        d("Please enable the Harvester addon to import data!")
        return
    end

    d("import data from Harvester")
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
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for index, nodes in pairs(data) do
                for _, node in pairs(nodes) do
                    HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                    -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                    HarvestMerge.newMapItemIDHarvest(newMapName, node[1], node[2], profession, node[4], node[5])
                end
            end
        else -- << New Map Name NOT found
            d(map .. " could not be localized.  Saving to oldData!")
            for index, nodes in pairs(data) do
                for v1, node in pairs(nodes) do
                    HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                    -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                    HarvestMerge.oldMapItemIDHarvest(map, node[1], node[2], profession, node[4], node[5])
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
                HarvestMerge.newMapNameFishChest("chest", newMapName, node[1], node[2])
            end
        else -- << New Map Name NOT found
            d(map .. " could not be localized.  Saving to oldData!")
            for v1, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.oldMapNameFishChest("chest", map, node[1], node[2])
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
                HarvestMerge.newMapNameFishChest("fish", newMapName, node[1], node[2])
            end
        else -- << New Map Name NOT found
            d(map .. " could not be localized.  Saving to oldData!")
            for v1, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- 1) map name 2) x 3) y 4) profession 5) nodeName 6) itemID
                HarvestMerge.oldMapNameFishChest("fish", map, node[1], node[2])
            end
        end
    end

    d("Number of nodes processed : " .. tostring(HarvestMerge.NumNodesProcessed) )
    d("Number of nodes added : " .. tostring(HarvestMerge.NumbersNodesAdded) )
    d("Number of Containers skipped : " .. tostring(HarvestMerge.NumContainerSkipped) )
    d("Number of False Nodes skipped : " .. tostring(HarvestMerge.NumFalseNodes) )
    d("Number of Unlocalized nodes saved : " .. tostring(HarvestMerge.NumbersUnlocalizedNodesAdded) )
    d("Number of Unlocalized False Nodes skipped : " .. tostring(HarvestMerge.NumUnlocalizedFalseNodes) )
    d("Finished.")
end

function HarvestMerge.importFromHarvestMap()
    HarvestMerge.NumbersNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumbersNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0
    HarvestMerge.NumUnlocalizedFalseNodes = 0
    HarvestMerge.NumbersUnlocalizedNodesAdded = 0

    if not Harvest then
        d("Please enable the HarvestMap addon to import data!")
        return
    end

    d("import data from HarvestMap")
    for newMapName, data in pairs(Harvest.savedVars["nodes"].data) do
        for profession, nodes in pairs(data) do
            for index, node in pairs(nodes) do
                for contents, nodeName in ipairs(node[3]) do
                    HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1

                        if (nodeName) == "chest" or (nodeName) == "fish" then
                            HarvestMerge.newMapNameFishChest(nodeName, newMapName, node[1], node[2])
                        else
                            if node[4] == nil then
                                HarvestMerge.newMapNilItemIDHarvest(newMapName, node[1], node[2], profession, nodeName)
                            else -- node[4] which is the ItemID should not be nil at this point
                                HarvestMerge.newMapItemIDHarvest(newMapName, node[1], node[2], profession, nodeName, node[4])
                            end
                        end

                end
            end
        end
    end

    d("Number of nodes processed : " .. tostring(HarvestMerge.NumNodesProcessed) )
    d("Number of nodes added : " .. tostring(HarvestMerge.NumbersNodesAdded) )
    d("Number of Containers skipped : " .. tostring(HarvestMerge.NumContainerSkipped) )
    d("Number of False Nodes skipped : " .. tostring(HarvestMerge.NumFalseNodes) )
    d("Number of Unlocalized nodes saved : " .. tostring(HarvestMerge.NumbersUnlocalizedNodesAdded) )
    d("Number of Unlocalized False Nodes skipped : " .. tostring(HarvestMerge.NumUnlocalizedFalseNodes) )
    d("Finished.")
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
        return d("Please enter a valid Harvester command")
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
             HarvestMerge.updateNodes(commands[2])
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

    --[[
    elseif commands[1] == "datalog" then
        d("---")
        d("Complete list of gathered data:")
        d("---")

        local counter = {
            ["harvest"] = 0,
            ["chest"] = 0,
            ["fish"] = 0,
        }

        for type,sv in pairs(HarvestMerge.savedVars) do
            if type ~= "internal" and (type == "chest" or type == "fish") then
                for zone, t1 in pairs(HarvestMerge.savedVars[type].data) do
                    counter[type] = counter[type] + #HarvestMerge.savedVars[type].data[zone]
                end
            elseif type ~= "internal" then
                for zone, t1 in pairs(HarvestMerge.savedVars[type].data) do
                    for data, t2 in pairs(HarvestMerge.savedVars[type].data[zone]) do
                        counter[type] = counter[type] + #HarvestMerge.savedVars[type].data[zone][data]
                    end
                end
            end
        end

        d("Harvest: "          .. HarvestMerge.NumberFormat(counter["harvest"]))
        d("Treasure Chests: "  .. HarvestMerge.NumberFormat(counter["chest"]))
        d("Fishing Pools: "    .. HarvestMerge.NumberFormat(counter["fish"]))

        d("---")
    ]]--
    end
end

SLASH_COMMANDS["/rl"] = function()
    ReloadUI("ingame")
end

function HarvestMerge.OnLoad(eventCode, addOnName)

    HarvestMerge.defaults = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 2, "internal", { 
        debug = false,
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
        -- Map name collection for future versions

        -- These nodes are not used after version 2
        --Localized HarvestMap Nodes
        ["harvest"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "harvest", HarvestMerge.dataDefault),
        ["chest"]        = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "chest", HarvestMerge.dataDefault),
        ["fish"]         = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "fish", HarvestMerge.dataDefault),
        --Unlocalized HarvestMap Nodes
        ["esoharvest"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "esoharvest", HarvestMerge.dataDefault),
        ["esochest"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "esochest", HarvestMerge.dataDefault),
        ["esofish"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "esofish", HarvestMerge.dataDefault),
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
        HarvestMerge.internal.internalVersion = internalVersion
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

    -- Set Localization
    HarvestMerge.language = (GetCVar("language.2") or "en")

    HarvestMerge.minDefault = 0.000025 -- 0.005^2
    HarvestMerge.minDist = 0.000025 -- 0.005^2
    HarvestMerge.minReticleover = 0.000049 -- 0.007^2

    HarvestMerge.NumbersNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumbersNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0
    HarvestMerge.NumUnlocalizedFalseNodes = 0
    HarvestMerge.NumbersUnlocalizedNodesAdded = 0

end

EVENT_MANAGER:RegisterForEvent("HarvestMerge", EVENT_ADD_ON_LOADED, function (eventCode, addOnName)
    if addOnName == "HarvestMerge" then
        HarvestMerge.Initialize()
        HarvestMerge.OnLoad(eventCode, addOnName)
    end
end)