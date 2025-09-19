


-- Underbelly, Welto, Volcano, Endless Battlefield, Memoryscape?, wormhole two northeast of NoT. Mejev Nider - second best after battlefield. 

-- Underbelly Welto Albedos
-- Volcano is obvious, do I die there?
-- Memoryscape is obvious, wormhole two NE of thera
-- Mejev Whatever - second best after battlefield
-- Kkirrrr'shi Hive   
-- East Tak're
-- West Tcanna
-- SW Polyargos

-- Albedos run - 
-- the Maelstral Shoals
-- Start in Dovan, go to Clawhook, Bakal, Basilisk Lair, Maul, Dramedo Warrens, Underbelly -> Mainland. Luzith, Ildon, Tiyen Esityi, Xaanhal, 
-- skip basilisk queen room
-- Similar room in the Shastaan Warrens - north to south running map. Towards the north there'll be a central area. Skip the middle room.

-- Add check to basher for not hitting if 1k health bleed.

local function addExitIfNotExists(roomIDFrom, roomIDTo, exit)
    local exits = getSpecialExits(roomIDFrom);
    if (not table.contains(exits, exit)) then
        addSpecialExit(roomIDFrom, roomIDTo, exit);
    end
end

local exitsToAdd = {
    [36688] = {"touch seal", 36710},
    [36270] = {"enter whirlpool", 36271},
    [50271] = {"enter pit", 62819},
    [62813] = {"climb rope", 50271},
    [34053] = {"enter grate", 49471},
    [49471] = {"climb ladder", 34053},
    [49440] = {"climb ladder", 33905},
    [33905] = {"enter grate", 49440},
    [29552] = {"enter grate", 52595},
    [52595] = {"climb ladder", 29552},
    [49478] = {"climb ladder", 51287},
    [51287] = {"climb ladder", 49478},
    [51329] = {"climb ladder", 51336},
    [51336] = {"climb ladder", 51329},
    [49465] = {"climb ladder", 38271},
    [38271] = {"climb ladder", 49465},
    [49878] = {"enter pit", 35595},
    [68055] = {"say yes, let me through.", 14926},
    [57263] = {"climb rope", 61011},
    [8765] = {"pull rope", 57086},
    [57086] = {"pull rope", 8765},
}

for exit, action in pairs(exitsToAdd) do
    addExitIfNotExists(exit, action[2], action[1]);
end

-- Lock the basilisk queen room so we never walk into it.
lockRoom(68721, true);


-- wormhole bit stolen from Rijetta.
local ferryCommands = {
    ["worm warp"] = {"aetolia"},
  }
  local c = 0
  local weight = 30
  for area in pairs(mmp.areatabler) do
    local rooms = getAreaRooms(area) or {}
    for i = 0, #rooms do
      local exits = getSpecialExits(rooms[i] or 0)
      if exits and next(exits) then
        for exit, cmd in pairs(exits) do
          if type(cmd) == "table" then
            cmd = next(cmd)
          end
          local lowerCommand = cmd:lower()
          local found = false
          for ferryCommand, games in pairs(ferryCommands) do
            if table.contains(games, mmp.game) and lowerCommand:find(ferryCommand, 1, true) then
              found = true
              break
            end
          end
          if found then
            setExitWeight(rooms[i], cmd, weight)
            mmp.echo(
              "Weighted " .. cmd .. " going to " .. rooms[i] .. " (" .. getRoomName(rooms[i]) .. ")."
            )
            c = c + 1
          end
        end
      end
    end
  end
  mmp.echo(
    string.format(
      "%s wormhole exits weighted to %s (so we don't take them over too short distances).", c, weight
    )
  )
