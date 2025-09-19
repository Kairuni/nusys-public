-- base functions for now, move these out as this grows.

AUTOBASH = {
    active = false,

    aggroMap = {},
    aggroQueue = {},
    routes = {},
    currentRoute = nil,
    routeIndex = -1,

    batches = {},
    currentBatch = nil,
    batchIndex = -1,

    untracked = {},

    classes = {},

    target = nil,

    ignore = {
        Aloli = true,
        Emhyra = true,
    };
};

function AUTOBASH.addMobsToAggroMap(area, inputMap)
    AUTOBASH.aggroMap[area] = AUTOBASH.aggroMap[area] or {};
    local map = AUTOBASH.aggroMap[area];
    for k,v in pairs(inputMap) do
        if (map[k]) then
            NU.WARN("Aggro map already contains " .. k .. "! Previous priority was " .. map[k].priority);
        end
        if (type(v) == "table") then
            map[k] = v;
        else
            map[k] = {aggro = false, priority = v};
        end
    end
end

function AUTOBASH.updateAggroQueue(source)
    NU.DECHO("AGGRO_QUEUE", 4);
    if (not AUTOBASH.active) then
        return false;
    end

    if (#gmcp.Room.Players > 0) then
        for _,v in ipairs(gmcp.Room.Players) do
            if (not AUTOBASH.ignore[v.name]) then
                AUTOBASH.finishRoom();
                return;
            end
        end
    end

    local queue = CreatePriorityQueue();
    local aggroCount = 0;
    queue:initialize();
    AUTOBASH.aggroQueue = {};
    for _,v in ipairs(NU.items.room) do
        local areaMap = AUTOBASH.aggroMap[gmcp.Room.Info.area] or {};
        local generalMap = AUTOBASH.aggroMap.general;

        local aggroEntry = areaMap[v.name] or (generalMap[v.name] or {priority = -2});

        if (aggroEntry.flee) then
            AUTOBASH.finishRoom();
            return;
        end

        if (aggroEntry.priority > 0) then
            local entry = {id = v.id, aggro = aggroEntry.aggro or false};
            queue:put(entry, aggroEntry.priority - ((entry.aggro or v.color == "red") and 4 or 0));
            if (entry.aggro or v.color == "red") then
                aggroCount = aggroCount + 1;
            end
        elseif (aggroEntry.priority == -2 and v.attrib and string.find(v.attrib, "m") and not string.find(v.attrib, "x") and not string.find(v.attrib, "d")) then
            local area = gmcp.Room.Info.area;
            AUTOBASH.untracked[area] = AUTOBASH.untracked[area] or {};
            if (not table.contains(AUTOBASH.untracked[area], v.name)) then
                table.insert(AUTOBASH.untracked[area], v.name);
                NU.ECHO("New mob: " .. v.name .. " added to pending priority table for " .. gmcp.Room.Info.area);
                echo("\n");
                NU.ECHO("Use BP# to set the priority, or BPZ to set it to untargetable, or BPA# if commonly aggro.\n");
            end
        elseif (aggroEntry.priority == -2 and v.attrib and string.find(v.attrib, "x") and not string.find(v.attrib, "d")) then
            NU.ECHO("Found [[" .. v.name .. "]] with X attribute, adding to generic ignore list.\n");
            AUTOBASH.aggroMap.general[v.name] = {aggro = false, priority = -1};
        end
    end

    local maxAggro = NU.config.aggroMax or 2;
    if (aggroCount > maxAggro) then
        if (mmp.paused) then mmp.pause("off"); end
        NU.promptAppend("TOO_MANY_AGGRO", "Too many aggro mobs, fleeing");
        AUTOBASH.finishRoom();
        return;
    end

    while (not queue:empty()) do
        local mob = queue:pop();
        table.insert(AUTOBASH.aggroQueue, mob);
    end

    if (#AUTOBASH.aggroQueue > 0 and not mmp.paused) then
        mmp.pause("on");
    elseif (#AUTOBASH.aggroQueue == 0) then
        if (mmp.paused) then mmp.pause("off"); end
        AUTOBASH.finishRoom();
    end
end

function AUTOBASH.genericPickTarget()
    if (not AUTOBASH.target) then
        AUTOBASH.target = AUTOBASH.aggroQueue[1];
    end
end

function AUTOBASH.lockedDoor()
    table.remove(AUTOBASH.currentRoute, AUTOBASH.routeIndex);

    NU.DECHO("LOCKED_DOOR", 4);
    mmp.clearpathcache();
    mmp.stop();
    AUTOBASH.gotoNextRoom();
end

local elevationActions = {
    trees = "swing up",
    flying = "fly"
}

function AUTOBASH.gotoNextRoom()
    if (AUTOBASH.lastPathTime and AUTOBASH.lastPathTime == NU.time()) then
        NU.DECHO("NEXT_ROOM - Exit Early", 4);
        return;
    end
    if (AUTOBASH.currentRoute) then
        NU.DECHO("NEXT_ROOM", 4);
        local elevation = AUTOBASH.currentRoute.elevation;
        if (elevation and elevation ~= TRACK.getSelf().vitals.elevation) then
            NU.SEND(elevationActions[elevation]);
        end
        AUTOBASH.lastPathTime = NU.time();
        if (mmp.autowalking) then
            mmp.move();
        else
            mmp.gotoRoom(AUTOBASH.currentRoute[AUTOBASH.routeIndex]);
        end
    end
end

function AUTOBASH.goHome()
    --send("path track pylon");
end

function AUTOBASH.finishRoute()
    NU.DECHO("FINISH_ROUTE", 4);
    if (AUTOBASH.currentBatch) then
        AUTOBASH.batchIndex = AUTOBASH.batchIndex + 1;
        AUTOBASH.currentRoute = AUTOBASH.currentBatch[AUTOBASH.batchIndex];
        if (AUTOBASH.currentRoute) then
            AUTOBASH.routeIndex = 1;
            AUTOBASH.gotoNextRoom();
            return;
        end
    end
    AUTOBASH.currentRoute = nil;
    AUTOBASH.currentIndex = -1;
    AUTOBASH.goHome();
end

local leverRooms = {
    55183, 55185, 56222, 55188, 55150, 55184, 55154, 55187, 56107
}

function AUTOBASH.finishRoom()
    NU.DECHO("FINISH_ROOM", 4);
    local roomID = AUTOBASH.currentRoute and AUTOBASH.currentRoute[AUTOBASH.routeIndex];
    if (table.contains(leverRooms, gmcp.Room.Info.num)) then
        send("pull lever" .. NU.config.separator .. "pull 2.lever");
    end
    if (roomID == gmcp.Room.Info.num) then
        NU.DECHO("Room matched", 4);
        AUTOBASH.routeIndex = AUTOBASH.routeIndex + 1;
        if (AUTOBASH.routeIndex >= #AUTOBASH.currentRoute - 5) then
            NU.BIGMSG("LAST 5 ROOMS LAST 5 ROOMS", 8, "yellow");
        end

        if (AUTOBASH.routeIndex > #AUTOBASH.currentRoute) then
            NU.ECHO("Finished the current route!");
            NU.BIGMSG("NEXT ROUTE NEXT ROUTE NEXT ROUTE", 20, "red");
            showNotification("ROUTE DONE", "Go next route.");
            AUTOBASH.finishRoute();
        else
            NU.DECHO("ROUTE UNFINISHED", 4);
            AUTOBASH.gotoNextRoom();
        end
    else
        NU.DECHO("ROOM ID MISMATCH", 4);
        AUTOBASH.gotoNextRoom()
    end
end

function AUTOBASH.pathBlocked()
    if (not AUTOBASH.currentRoute) then return; end
    NU.DECHO("PATH_BLOCKED", 4);

    AUTOBASH.routeIndex = AUTOBASH.routeIndex + 1;
    if (AUTOBASH.routeIndex > #AUTOBASH.currentRoute) then
        NU.ECHO("Finished the current route!");
        AUTOBASH.finishRoute();
    else
        AUTOBASH.gotoNextRoom();
    end
end

function AUTOBASH.roomEntry()
    --NU.DECHO("ROOM_ENTRY", 4);
    --tempTimer(0.0, AUTOBASH.updateAggroQueue);
end

TRIG.register("bashing_notarget", "start", [[You can find no such target as ]], function() AUTOBASH.target = nil; send("ql"); end, "BASH_ROUTING", "Triggered when you fail to hit a target.");
TRIG.register("bashing_pathblocked", "exact", [[There is a closed door in the way.]], AUTOBASH.pathBlocked, "BASH_ROUTING", "Removes the room that you are trying to navigate to from the path.");
TRIG.register("bashing_pathblocked_2", "exact", [[There is no exit in that direction.]], AUTOBASH.pathBlocked, "BASH_ROUTING", "Removes the room that you are trying to navigate to from the path.");
TRIG.register("bashing_pathblocked_3", "exact", [[A harried Dunnite cook exclaims in accented common, rushing forward to shoo you out of their busy workspace.]], AUTOBASH.pathBlocked, "BASH_ROUTING", "Removes the room that you are trying to navigate to from the path.");

NU.loadAll("bashing");
