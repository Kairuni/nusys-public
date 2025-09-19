function GMCP.roomInfo()
    AUTOBASH.roomEntry();
end

GMCP.register("gmcp_room_info", "gmcp.Room.Info", GMCP.roomInfo);

NU.players = {};


local function removePlayerOnMiss()
    if (matches[2] == "loyals") then return; end
    if (FLAGS.illusion) then return; end
    local ttable = TRACK.get(matches[2]);
    if (ttable.affs.sore_ankle) then
        NU.ECHO("Removed " .. ttable.name);
        TRACK.damageLimb(ttable, "left leg", 5, not ttable.affs.stiffness);
        TRACK.damageLimb(ttable, "right leg", 5, not ttable.affs.stiffness);
        NU.players[NU.target:lower()] = false;
    end
end

TRIG.register("general_remove_player", "start", [[You can find no such target as \'(\w+)\'\.]], removePlayerOnMiss, "GENERAL_TRACKING", "Triggered an enemy isn't present and you're trying to punch them.");

local function gmcpPlayerRemove()
    local ttable = TRACK.get(gmcp.Room.RemovePlayer);
    if (ttable.affs.sore_ankle) then
        NU.ECHO("Removed " .. gmcp.Room.AddPlayer.name);
        TRACK.damageLimb(ttable, "left leg", 5, not ttable.affs.stiffness);
        TRACK.damageLimb(ttable, "right leg", 5, not ttable.affs.stiffness);
    end
    NU.players[ttable.name:lower()] = nil;
end

local function gmcpPlayerAdd()
    local ttable = TRACK.get(gmcp.Room.AddPlayer.name);
    if (ttable.affs.sore_ankle) then
        NU.ECHO("Added " .. gmcp.Room.AddPlayer.name);
        TRACK.damageLimb(ttable, "left leg", 5, not ttable.affs.stiffness);
        TRACK.damageLimb(ttable, "right leg", 5, not ttable.affs.stiffness);
    end
    NU.players[ttable.name:lower()] = true;
end

local function gmcpPlayerList()
    NU.players = {};
    for _,v in ipairs(gmcp.Room.Players) do
        NU.players[v.name:lower()] = true;
    end
end

GMCP.register("gmcp_player_exit", "gmcp.Room.RemovePlayer", gmcpPlayerRemove);
GMCP.register("gmcp_player_entry", "gmcp.Room.AddPlayer", gmcpPlayerAdd);
GMCP.register("gmcp_player_list", "gmcp.Room.Players", gmcpPlayerList);