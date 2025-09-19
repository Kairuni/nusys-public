local function listUntrackedInArea()
    local area = gmcp.Room.Info.area;
    AUTOBASH.untracked[area] = AUTOBASH.untracked[area] or {};
    local areaTable = AUTOBASH.untracked[area];
    NU.ECHO("Listing untracked mobs in " .. area .. "\n");
    for i,v in ipairs(areaTable) do
        NU.ECHO(tostring(i) .. ": " .. v .. "\n");
    end
end

local function setUntrackedPriority(index, priority, aggro)
    local area = gmcp.Room.Info.area;
    AUTOBASH.untracked[area] = AUTOBASH.untracked[area] or {};
    local areaTable = AUTOBASH.untracked[area];
    AUTOBASH.aggroMap[area] = AUTOBASH.aggroMap[area] or {};
    local map = AUTOBASH.aggroMap[area];

    index = tonumber(index) or 1;
    priority = tonumber(priority) or -1;

    local entry = table.remove(areaTable, index);
    if (entry) then
        map[entry] = {aggro = aggro, priority = priority};
        NU.ECHO("Set priority " .. tostring(priority) .. " for mob " .. entry .. "\n");
    else
        NU.ECHO("No bashing entry to process.\n");
    end
end

local function toggleBashing()
    AUTOBASH.active = not AUTOBASH.active;
    NU.ECHO("Bashing " .. (AUTOBASH.active and "<green>ENABLED\n" or "<red>DISABLED\n"));
end

local function saveBashingData()
    for area,data in pairs(AUTOBASH.routes) do
        local f_area = area:gsub(" ", "_"):lower();
        local file = io.open(NU.getHomeDir().. "/../nuSys/bashing/areas/" .. f_area .. ".lua", "w");
        cecho("<green>Saving route data for " .. area .. "\n");
        file:write([[AUTOBASH.routes["]] .. area .. [["] = {]] .. "\n    ");

        local count = 0;
        for _,roomid in ipairs(data) do
            if (count > 10) then
                file:write("\n    ");
                count = 0;
            end
            file:write(tostring(roomid) .. ",");
            count = count + 1;
        end

        if (data.elevation) then
            file:write("elevation = [[" .. data.elevation .. "]]");
        end

        file:write("\n};");
        file:close();
    end

    for area,data in pairs(AUTOBASH.aggroMap) do
        local f_area = area:gsub(" ", "_"):lower();
        cecho("<green>Saving mob data for " .. area .. "\n");
        local file = io.open(NU.getHomeDir().. "/../nuSys/bashing/mobs/" .. f_area .. ".lua", "w");
        file:write([[AUTOBASH.aggroMap["]] .. area .. [["] = {]] .. "\n");

        for mobname,mobdata in pairs(data) do
            file:write("    [ [[" .. mobname .. "]] ] = {aggro = ");
            file:write(tostring(mobdata.aggro));
            file:write(", priority = ");
            file:write(tostring(mobdata.priority));
            file:write(", flee = ");
            file:write(tostring(mobdata.flee or false));
            file:write("},\n");
        end

        file:write("};");
        file:close();
    end
end

local function setBashRoute(routeName)
    cecho("<white>---- Bashing Began for <green>" .. routeName .. " <white>----\n");
    AUTOBASH.active = true;

    AUTOBASH.currentRoute = AUTOBASH.routes[routeName];
    AUTOBASH.routeIndex = 1;

    AUTOBASH.gotoNextRoom();
end

local function cancelBashRoute()
    AUTOBASH.currentRoute = nil;
end

local function selectBashRoutes()
    local area = matches[2]:lower();
    local matchList = {};
    for k,_ in pairs(AUTOBASH.routes) do
        if (k:lower():match(area)) then
            table.insert(matchList, k);
        end
    end

    if (#matchList > 1) then
        cecho("<white>---- <green>AREAS <white>----\n");
        for i,v in ipairs(matchList) do
            cechoLink(tostring(i) .. ": " .. v .. "\n", function() setBashRoute(v); end, v);
        end
    elseif (#matchList == 1) then
        setBashRoute(matchList[1]);
    else
        NU.ECHO("No route detected for that area.");
    end
end

local function BuildRoute()
    AUTOBASH.buildRouteFromHere();
end

ALIAS.register("bash_route_select", [[^br ([\w\s\-]+)$]], selectBashRoutes, "BASHING_MAIN", "Select a bashing route.");
ALIAS.register("bash_route_stop", [[^bstop$]], cancelBashRoute, "BASHING_MAIN", "Stop bashing.");
ALIAS.register("bash_list_untracked", [[^BP$]], listUntrackedInArea, "BASHING_ROUTEBUILDING", "List untracked targets");
ALIAS.register("bash_set_untracked_no_priority", [[^BPZ$]], function() setUntrackedPriority(1, -1, false); end, "BASHING_ROUTEBUILDING", "Set the top of the untracked queue as non-targetable.");
ALIAS.register("bash_set_untracked_with_prior", [[^BP(\-?\d+)$]], function() setUntrackedPriority(1, matches[2], false); end, "BASHING_ROUTEBUILDING", "Set the top of the untracked queue with a priority");
ALIAS.register("bash_set_untracked_with_prior_and_index", [[^BP(\-?\d+)\s(\d+)$]], function() setUntrackedPriority(matches[3], matches[2], false); end, "BASHING_ROUTEBUILDING", "Set a specific index in the untracked queue to a priority");
ALIAS.register("bash_set_untracked_with_prior_aggro", [[^BPA(\-?\d+)$]], function() setUntrackedPriority(1, matches[2], true); end, "BASHING_ROUTEBUILDING", "Set the top of the untracked queue with a priority and mark the target as aggro.");
ALIAS.register("bash_set_untracked_with_prior_and_index_aggro", [[^BPA(\-?\d+)\s(\d+)$]], function() setUntrackedPriority(matches[3], matches[2], true); end, "BASHING_ROUTEBUILDING", "Set a specific index with priority and aggro");
ALIAS.register("bash_save_data", [[^BSAVE_DATA$]], saveBashingData, "BASHING_ROUTEBUILDING", "Save the recently constructed and built routes");
ALIAS.register("bash_build_route", [[^BROUTE$]], BuildRoute, "BASHING_ROUTEBUILDING", "Build a new route from the room you're standing in.");
ALIAS.register("bash_toggle", [[^bsh$]], toggleBashing, "BASHING_MAIN", "Toggle bashing on or off.");
ALIAS.register("bash_target", [[^bsh (.+)$]], function() AUTOBASH.target = {id = matches[2]}; end, "BASHING_MAIN", "Bash a specific target.");