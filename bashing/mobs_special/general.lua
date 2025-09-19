local mobPrios = {

};

local ignoreMobs = {

};

for _,v in ipairs(ignoreMobs) do
    mobPrios[v] = -1;
end


AUTOBASH.addMobsToAggroMap("general", mobPrios);
