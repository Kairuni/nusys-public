DEFS = DEFS or {};

NU.load("defs", "readable_defs")();

DEFS.actions = {};
DEFS.config = {};

for _,v in ipairs(DEFS.readable) do
    DEFS.config[v] = {action = "default", keep = false, defup = false};
    DEFS.actions[v] = {};
end