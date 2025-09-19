local shortToLong = {
    nw = "northwest", n = "north", ne = "northeast", e = "east", se = "southeast", s = "south", sw = "southwest", w = "west", u = "up", d = "down",
}
local longToShort = {};
local addList = {};
for k,v in pairs(shortToLong) do
    table.insert(addList, v);
    longToShort[v] = k;
    longToShort[k] = k;
end
for _,v in ipairs(addList) do
    shortToLong[v] = v;
end

function AUTOBASH.buildRouteFromHere()
    local startingRoom = gmcp.Room.Info.num;
    local areaID = getRoomArea(startingRoom);
    -- local areaRooms = getAreaRooms(areaID);

    local toExpand = {startingRoom};
    local routeList = {};
    local visited = {[startingRoom] = true};

    local room = table.remove(toExpand, 1);
    local i = 0;
    while (room) do
        local exits = getRoomExits(room);
        local specialExits = getSpecialExits(room);
        local doors = getDoors(room);

        for exitRoom, exitsList in pairs(specialExits) do
            for syntax, _ in pairs(exitsList) do
                exits[syntax] = exitRoom;
            end
        end

        for k,v in pairs(exits) do
            local shEx = longToShort[k];
            if (getRoomArea(v) == areaID and not visited[v]) then
                -- Going to need to dynamically adjust this, probably - doors list isn't actually indicative of anything.
                if (doors[shEx] and doors[shEx] == 2) then
                    cecho("<red>Skipping " .. k .. " as there is a locked door in the mapper.");
                else
                    echo("Expanding to " .. getRoomName(v) .. "\n");
                    visited[v] = true;
                    table.insert(toExpand, v);
                end
            end
        end

        table.insert(routeList, room);

        room = table.remove(toExpand, #toExpand);
        i = i + 1;
        if (i > 4000) then
            cecho("<red>WARNING! WARNING! WARNING!");
            cecho("<red>WARNING! WARNING! WARNING!");
            cecho("<red>WARNING! WARNING! WARNING!");
            cecho("More than 4000 rooms in a bashing route! Aborting to stop infinite loop!");
            return;
        end
    end

    cecho("<green>Route complete for: " .. gmcp.Room.Info.area .. "\n\n");
    cecho("Be sure to BSAVE_DATA when done making new routes.");
    AUTOBASH.routes[gmcp.Room.Info.area] = routeList;
end
