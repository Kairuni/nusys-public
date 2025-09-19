local Keep = {
    "discordance",
    "charisma",
    "equipoise",
    "stretching",
    "aurora",
    "halfbeat",
};

local Defup = {
    "discordance",
    "charisma",
    "equipoise",
    "stretching",
    "aurora",
    "halfbeat",
    "tolerance"
};

local eq = "equilibrium";

local weave = AB.Weaving;
local perf = AB.Performance;
local sc = AB.Songcalling;

local bardActions = {
    discordance = {ab = sc.Discordance},
    charisma = {ab = perf.Charisma},
    equipoise = {ab = perf.Equipoise},
    stretching = {ab = perf.Stretching},
    euphonia = {ab = sc.Euphonia},
    tolerance = {ab = perf.Tolerance},
    sheath = {ab = weave.Sheath},
    halfbeat = {ab = sc.Halfbeat, remove = {bard = "halfbeat off"}},
    aurora = {ab = weave.Aurora},
};

for k,v in pairs(bardActions) do
    DEFS.config[k] = {action = "bard",  keep = table.contains(Keep, k), defup = table.contains(DefUp, k), classList = {"bard"}};

    if (not DEFS.actions[k]) then
        DEFS.actions[k] = {};
    end

    DEFS.actions[k].bard = v;
    display(DEFS.actions[k]);
end

DEFS.config.tolerance.keep = false;
DEFS.config.euphonia.keep = false;
DEFS.config.euphonia.defup = false;