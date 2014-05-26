HarvestMerge = {}
HarvestMerge.chestID = 6
HarvestMerge.fishID = 8

local internalVersion = 1

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

function HarvestMerge.saveData( zone, x, y, profession, nodeName, itemID )

    if not profession then
        return
    end

    if HarvestMerge.alreadyFound( zone, x, y, profession, nodeName ) then
        return
    end

    -- If this check is not here the next routine will fail
    -- after the loading screen because for a brief moment
    -- the information is not available.
    if HarvestMerge.nodes == nil then
        return
    end

    if not HarvestMerge.nodes.data[zone] then
        HarvestMerge.nodes.data[zone] = {}
    end

    if not HarvestMerge.nodes.data[zone][profession] then
        HarvestMerge.nodes.data[zone][profession] = {}
    end

    if HarvestMerge.settings.debug then
        d("Save data!")
    end

    table.insert( HarvestMerge.nodes.data[zone][profession], { x, y, { nodeName }, itemID } )
    HarvestMerge.NumbersNodesAdded = HarvestMerge.NumbersNodesAdded + 1

end

function HarvestMerge.contains(table, value)
    for key, v in pairs(table) do
        if v == value then
            return key
        end
    end
    return nil
end

function HarvestMerge.alreadyFound( zone, x, y, profession, nodeName, scale )

    -- If this check is not here the next routine will fail
    -- after the loading screen because for a brief moment
    -- the information is not available.
    if HarvestMerge.nodes == nil then
        return
    end

    if not HarvestMerge.nodes.data[zone] then
        return false
    end

    if not HarvestMerge.nodes.data[zone][profession] then
        return false
    end

    local distance
    if scale == nil then
        distance = HarvestMerge.minDefault
    else
        distance = scale
    end

    local dx, dy
    for _, entry in pairs( HarvestMerge.nodes.data[zone][profession] ) do
        --if entry[3] == nodeName then
            dx = item[1] - x
            dy = item[2] - y
            -- (x - center_x)2 + (y - center_y)2 = r2, where center is the player
            dist = math.pow(dx, 2) + math.pow(dy, 2)
            if dist < distance then
                if profession > 0 then
                    if not HarvestMerge.contains(entry[3], nodeName) then
                        table.insert(entry[3], nodeName)
                    end
                    if HarvestMerge.settings.debug then
                        d("Node : " .. nodeName .. " on : " .. zone .. " x:" .. x .." , y:" .. y .. " for profession " .. profession .. " already found!")
                    end
                    return true
                else
                    if entry[3][1] == nodeName then
                        if HarvestMerge.settings.debug then
                            d("Node : " .. nodeName .. " on : " .. zone .. " x:" .. x .." , y:" .. y .. " for profession " .. profession .. " already found!")
                        end
                        return true
                    end
                end
            end
        --end
        end
    if HarvestMerge.settings.debug then
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

    if not EH then
        d("Please enable the Esohead addon to import data!")
        return
    end

    d("import data from Esohead")
    local profession
    local newMapName
    if not HarvestMerge.nodes.oldData then
        HarvestMerge.nodes.oldData = {}
    end

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
                    if not HarvestMerge.IsValidContainerOnImport(node[4]) then -- << Not a Container
                        if HarvestMerge.CheckProfessionTypeOnImport(node[5], node[4]) then -- << If Valid Profession Type
                            professionFound = HarvestMerge.GetProfessionType(node[5], node[4])
                            if professionFound >= 1 then
                                -- When import filter is false do NOT import the node
                                if not HarvestMerge.settings.importFilters[ professionFound ] then
                                    HarvestMerge.saveData( newMapName, node[1], node[2], professionFound, node[4], node[5] )
                                else
                                    -- d("skipping Node : " .. node[4] .. " : ID : " .. tostring(node[5]))
                                    HarvestMerge.NumbersNodesFiltered = HarvestMerge.NumbersNodesFiltered + 1
                                end
                            end
                        else -- << If Valid Profession Type
                            HarvestMerge.NumFalseNodes = HarvestMerge.NumFalseNodes + 1
                            -- d("Node:" .. node[4] .. " ItemID " .. tostring(node[5]) .. " skipped")
                        end -- << If Valid Profession Type
                    else -- << Not a Container
                        HarvestMerge.NumContainerSkipped = HarvestMerge.NumContainerSkipped + 1
                        -- d("Container :" .. node[4] .. " ItemID " .. tostring(node[5]) .. " skipped")
                    end -- << Not a Container
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
                -- Esohead "chest" has nodes only, add appropriate data
                -- The 6 before "chest" refers to it's Profession ID
                -- When import filter is false do NOT import the node
                if not HarvestMerge.settings.importFilters[ 6 ] then
                    HarvestMerge.saveData( newMapName, node[1], node[2], 6, "chest", nil )
                else
                    HarvestMerge.NumbersNodesFiltered = HarvestMerge.NumbersNodesFiltered + 1
                end
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
                -- Esohead "fish" has nodes only, add appropriate data
                -- The 8 before "fish" refers to it's Profession ID
                -- When import filter is false do NOT import the node
                if not HarvestMerge.settings.importFilters[ 8 ] then
                    HarvestMerge.saveData( newMapName, node[1], node[2], 8, "fish", nil )
                else
                    HarvestMerge.NumbersNodesFiltered = HarvestMerge.NumbersNodesFiltered + 1
                end
            end
        end
    end

    d("Number of nodes processed : " .. tostring(HarvestMerge.NumNodesProcessed) )
    d("Number of nodes added : " .. tostring(HarvestMerge.NumbersNodesAdded) )
    d("Number of nodes filtered : " .. tostring(HarvestMerge.NumbersNodesFiltered) )
    d("Number of Containers skipped : " .. tostring(HarvestMerge.NumContainerSkipped) )
    d("Number of False nodes skipped : " .. tostring(HarvestMerge.NumFalseNodes) )
    d("Finished.")
end

function HarvestMerge.importFromEsoheadMerge()
    HarvestMerge.NumbersNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumbersNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0

    if not EH then
        d("Please enable the Esohead addon to import data!")
        return
    end

    d("import data from Esohead")
    local profession
    local newMapName
    if not HarvestMerge.nodes.oldData then
        HarvestMerge.nodes.oldData = {}
    end

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
                    if not HarvestMerge.IsValidContainerOnImport(node[4]) then -- << Not a Container
                        if HarvestMerge.CheckProfessionTypeOnImport(node[5], node[4]) then -- << If Valid Profession Type
                            professionFound = HarvestMerge.GetProfessionType(node[5], node[4])
                            if professionFound >= 1 then
                                -- When import filter is false do NOT import the node
                                if not HarvestMerge.settings.importFilters[ professionFound ] then
                                    HarvestMerge.saveData( newMapName, node[1], node[2], professionFound, node[4], node[5] )
                                else
                                    -- d("skipping Node : " .. node[4] .. " : ID : " .. tostring(node[5]))
                                    HarvestMerge.NumbersNodesFiltered = HarvestMerge.NumbersNodesFiltered + 1
                                end
                            end
                        else -- << If Valid Profession Type
                            HarvestMerge.NumFalseNodes = HarvestMerge.NumFalseNodes + 1
                            -- d("Node:" .. node[4] .. " ItemID " .. tostring(node[5]) .. " skipped")
                        end -- << If Valid Profession Type
                    else -- << Not a Container
                        HarvestMerge.NumContainerSkipped = HarvestMerge.NumContainerSkipped + 1
                        -- d("Container :" .. node[4] .. " ItemID " .. tostring(node[5]) .. " skipped")
                    end -- << Not a Container
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
                -- Esohead "chest" has nodes only, add appropriate data
                -- The 6 before "chest" refers to it's Profession ID
                -- When import filter is false do NOT import the node
                if not HarvestMerge.settings.importFilters[ 6 ] then
                    HarvestMerge.saveData( newMapName, node[1], node[2], 6, "chest", nil )
                else
                    HarvestMerge.NumbersNodesFiltered = HarvestMerge.NumbersNodesFiltered + 1
                end
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
                -- Esohead "fish" has nodes only, add appropriate data
                -- The 8 before "fish" refers to it's Profession ID
                -- When import filter is false do NOT import the node
                if not HarvestMerge.settings.importFilters[ 8 ] then
                    HarvestMerge.saveData( newMapName, node[1], node[2], 8, "fish", nil )
                else
                    HarvestMerge.NumbersNodesFiltered = HarvestMerge.NumbersNodesFiltered + 1
                end
            end
        end
    end

    d("Number of nodes processed : " .. tostring(HarvestMerge.NumNodesProcessed) )
    d("Number of nodes added : " .. tostring(HarvestMerge.NumbersNodesAdded) )
    d("Number of nodes filtered : " .. tostring(HarvestMerge.NumbersNodesFiltered) )
    d("Number of Containers skipped : " .. tostring(HarvestMerge.NumContainerSkipped) )
    d("Number of False nodes skipped : " .. tostring(HarvestMerge.NumFalseNodes) )
    d("Finished.")
end

function HarvestMerge.importFromHarvester()
    HarvestMerge.NumbersNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumbersNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0

    if not EH then
        d("Please enable the Esohead addon to import data!")
        return
    end

    d("import data from Esohead")
    local profession
    local newMapName
    if not HarvestMerge.nodes.oldData then
        HarvestMerge.nodes.oldData = {}
    end

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
    for map, data in pairs( Harvester.savedVars["harvest"].data) do
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for index, nodes in pairs(data) do
                for _, node in pairs(nodes) do
                    HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                    if not HarvestMerge.IsValidContainerOnImport(node[4]) then -- << Not a Container
                        if HarvestMerge.CheckProfessionTypeOnImport(node[5], node[4]) then -- << If Valid Profession Type
                            professionFound = HarvestMerge.GetProfessionType(node[5], node[4])
                            if professionFound >= 1 then
                                -- When import filter is false do NOT import the node
                                if not HarvestMerge.settings.importFilters[ professionFound ] then
                                    HarvestMerge.saveData( newMapName, node[1], node[2], professionFound, node[4], node[5] )
                                else
                                    -- d("skipping Node : " .. node[4] .. " : ID : " .. tostring(node[5]))
                                    HarvestMerge.NumbersNodesFiltered = HarvestMerge.NumbersNodesFiltered + 1
                                end
                            end
                        else -- << If Valid Profession Type
                            HarvestMerge.NumFalseNodes = HarvestMerge.NumFalseNodes + 1
                            -- d("Node:" .. node[4] .. " ItemID " .. tostring(node[5]) .. " skipped")
                        end -- << If Valid Profession Type
                    else -- << Not a Container
                        HarvestMerge.NumContainerSkipped = HarvestMerge.NumContainerSkipped + 1
                        -- d("Container :" .. node[4] .. " ItemID " .. tostring(node[5]) .. " skipped")
                    end -- << Not a Container
                end
            end
        end
    end

    d("Import Chests:")
    for map, nodes in pairs( Harvester.savedVars["chest"].data) do
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for _, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- Esohead "chest" has nodes only, add appropriate data
                -- The 6 before "chest" refers to it's Profession ID
                -- When import filter is false do NOT import the node
                if not HarvestMerge.settings.importFilters[ 6 ] then
                    HarvestMerge.saveData( newMapName, node[1], node[2], 6, "chest", nil )
                else
                    HarvestMerge.NumbersNodesFiltered = HarvestMerge.NumbersNodesFiltered + 1
                end
            end
        end
    end

    d("Import Fishing Holes:")
    for map, nodes in pairs( Harvester.savedVars["fish"].data) do
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for _, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- Esohead "fish" has nodes only, add appropriate data
                -- The 8 before "fish" refers to it's Profession ID
                -- When import filter is false do NOT import the node
                if not HarvestMerge.settings.importFilters[ 8 ] then
                    HarvestMerge.saveData( newMapName, node[1], node[2], 8, "fish", nil )
                else
                    HarvestMerge.NumbersNodesFiltered = HarvestMerge.NumbersNodesFiltered + 1
                end
            end
        end
    end

    d("Number of nodes processed : " .. tostring(HarvestMerge.NumNodesProcessed) )
    d("Number of nodes added : " .. tostring(HarvestMerge.NumbersNodesAdded) )
    d("Number of nodes filtered : " .. tostring(HarvestMerge.NumbersNodesFiltered) )
    d("Number of Containers skipped : " .. tostring(HarvestMerge.NumContainerSkipped) )
    d("Number of False nodes skipped : " .. tostring(HarvestMerge.NumFalseNodes) )
    d("Finished.")
end

function HarvestMerge.importFromHarvestMap()
    HarvestMerge.NumbersNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumbersNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0

    if not EH then
        d("Please enable the Esohead addon to import data!")
        return
    end

    d("import data from Esohead")
    local profession
    local newMapName
    if not HarvestMerge.nodes.oldData then
        HarvestMerge.nodes.oldData = {}
    end

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
    for map, data in pairs(Harvest.savedVars["harvest"].data) do
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for index, nodes in pairs(data) do
                for _, node in pairs(nodes) do
                    HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                    if not HarvestMerge.IsValidContainerOnImport(node[4]) then -- << Not a Container
                        if HarvestMerge.CheckProfessionTypeOnImport(node[5], node[4]) then -- << If Valid Profession Type
                            professionFound = HarvestMerge.GetProfessionType(node[5], node[4])
                            if professionFound >= 1 then
                                -- When import filter is false do NOT import the node
                                if not HarvestMerge.settings.importFilters[ professionFound ] then
                                    HarvestMerge.saveData( newMapName, node[1], node[2], professionFound, node[4], node[5] )
                                else
                                    -- d("skipping Node : " .. node[4] .. " : ID : " .. tostring(node[5]))
                                    HarvestMerge.NumbersNodesFiltered = HarvestMerge.NumbersNodesFiltered + 1
                                end
                            end
                        else -- << If Valid Profession Type
                            HarvestMerge.NumFalseNodes = HarvestMerge.NumFalseNodes + 1
                            -- d("Node:" .. node[4] .. " ItemID " .. tostring(node[5]) .. " skipped")
                        end -- << If Valid Profession Type
                    else -- << Not a Container
                        HarvestMerge.NumContainerSkipped = HarvestMerge.NumContainerSkipped + 1
                        -- d("Container :" .. node[4] .. " ItemID " .. tostring(node[5]) .. " skipped")
                    end -- << Not a Container
                end
            end
        end
    end

    d("Import Chests:")
    for map, nodes in pairs(Harvest.savedVars["chest"].data) do
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for _, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- Esohead "chest" has nodes only, add appropriate data
                -- The 6 before "chest" refers to it's Profession ID
                -- When import filter is false do NOT import the node
                if not HarvestMerge.settings.importFilters[ 6 ] then
                    HarvestMerge.saveData( newMapName, node[1], node[2], 6, "chest", nil )
                else
                    HarvestMerge.NumbersNodesFiltered = HarvestMerge.NumbersNodesFiltered + 1
                end
            end
        end
    end

    d("Import Fishing Holes:")
    for map, nodes in pairs(Harvest.savedVars["fish"].data) do
        d("import data from "..map)
        newMapName = HarvestMerge.GetNewMapName(map)
        if newMapName then
            for _, node in pairs(nodes) do
                HarvestMerge.NumNodesProcessed = HarvestMerge.NumNodesProcessed + 1
                -- Esohead "fish" has nodes only, add appropriate data
                -- The 8 before "fish" refers to it's Profession ID
                -- When import filter is false do NOT import the node
                if not HarvestMerge.settings.importFilters[ 8 ] then
                    HarvestMerge.saveData( newMapName, node[1], node[2], 8, "fish", nil )
                else
                    HarvestMerge.NumbersNodesFiltered = HarvestMerge.NumbersNodesFiltered + 1
                end
            end
        end
    end

    d("Number of nodes processed : " .. tostring(HarvestMerge.NumNodesProcessed) )
    d("Number of nodes added : " .. tostring(HarvestMerge.NumbersNodesAdded) )
    d("Number of nodes filtered : " .. tostring(HarvestMerge.NumbersNodesFiltered) )
    d("Number of Containers skipped : " .. tostring(HarvestMerge.NumContainerSkipped) )
    d("Number of False nodes skipped : " .. tostring(HarvestMerge.NumFalseNodes) )
    d("Finished.")
end

-----------------------------------------
--           Slash Command             --
-----------------------------------------

Harvester.validCategories = {
    "chest",
    "fish",
    "harvest",
}

function Harvester.IsValidCategory(name)
    for k, v in pairs(Harvester.validCategories) do
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
        return Harvester.Debug("Please enter a valid Harvester command")
    end

    if #commands == 2 and commands[1] == "debug" then
        if commands[2] == "on" then
            HarvestMerge.Debug("HarvestMerge debugger toggled on")
            HarvestMerge.savedVars["internal"].debug = 1
        elseif commands[2] == "off" then
            HarvestMerge.Debug("HarvestMerge debugger toggled off")
            HarvestMerge.savedVars["internal"].debug = 0
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

    elseif commands[1] == "reset" then
        if #commands ~= 2 then 
            for type,sv in pairs(HarvestMerge.savedVars) do
                if type ~= "internal" then
                    HarvestMerge.savedVars[type].data = {}
                end
            end
            HarvestMerge.Debug("HarvestMerge saved data has been completely reset")
        else
            if commands[2] ~= "internal" then
                if Harvester.IsValidCategory(commands[2]) then
                    Harvester.savedVars[commands[2]].data = {}
                    Harvester.Debug("HarvestMerge saved data : " .. commands[2] .. " has been reset")
                else
                    return Harvester.Debug("Please enter a valid HarvestMerge category to reset")
                end
            end
        end

    elseif commands[1] == "datalog" then
        Harvester.Debug("---")
        Harvester.Debug("Complete list of gathered data:")
        Harvester.Debug("---")

        local counter = {
            ["harvest"] = 0,
            ["chest"] = 0,
            ["fish"] = 0,
        }

        for type,sv in pairs(Harvester.savedVars) do
            if type ~= "internal" and (type == "chest" or type == "fish") then
                for zone, t1 in pairs(Harvester.savedVars[type].data) do
                    counter[type] = counter[type] + #Harvester.savedVars[type].data[zone]
                end
            elseif type ~= "internal" then
                for zone, t1 in pairs(Harvester.savedVars[type].data) do
                    for data, t2 in pairs(Harvester.savedVars[type].data[zone]) do
                        counter[type] = counter[type] + #Harvester.savedVars[type].data[zone][data]
                    end
                end
            end
        end

        Harvester.Debug("Harvest: "          .. Harvester.NumberFormat(counter["harvest"]))
        Harvester.Debug("Treasure Chests: "  .. Harvester.NumberFormat(counter["chest"]))
        Harvester.Debug("Fishing Pools: "    .. Harvester.NumberFormat(counter["fish"]))

        Harvester.Debug("---")
    end
end

function HarvestMerge.OnLoad(eventCode, addOnName)

    HarvestMerge.savedVars = {
        ["internal"]     = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 1, "internal", { debug = HarvestMerge.debugDefault, language = "" }),
        ["harvest"]      = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 4, "harvest", HarvestMerge.dataDefault),
        ["chest"]        = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 2, "chest", HarvestMerge.dataDefault),
        ["fish"]         = ZO_SavedVars:NewAccountWide("HarvestMerge_SavedVariables", 2, "fish", HarvestMerge.dataDefault),
    }

end

function HarvestMerge.Initialize()

    HarvestMerge.savedVars = {}
    HarvestMerge.debugDefault = 0
    HarvestMerge.dataDefault = {
        data = {}
    }

    -- Set Localization
    HarvestMerge.language = (GetCVar("language.2") or "en")
    HarvestMerge.localization = HarvestMerge.allLocalizations[HarvestMerge.language]
    HarvestMerge.savedVars["internal"]["language"] = HarvestMerge.language

    HarvestMerge.minDefault = 0.000025 -- 0.005^2
    HarvestMerge.minDist = 0.000025 -- 0.005^2

    HarvestMerge.NumbersNodesAdded = 0
    HarvestMerge.NumFalseNodes = 0
    HarvestMerge.NumContainerSkipped = 0
    HarvestMerge.NumbersNodesFiltered = 0
    HarvestMerge.NumNodesProcessed = 0

end

EVENT_MANAGER:RegisterForEvent("HarvestMap", EVENT_ADD_ON_LOADED, function (eventCode, addOnName)
    if addOnName == "HarvestMap" then
        HarvestMerge.Initialize()
        HarvestMerge.OnLoad(eventCode, addOnName)
    end
end)