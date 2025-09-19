
    -- "ardour_constitution",
    -- "ardour_strength",
    -- "ardour_dexterity",
    -- "ardour_intelligence",
    -- "ardour_wisdom",

    -- "relentless",
    -- "resolved",
    -- "celerity",
    -- "acuity", -- lasts for a short duration
    -- "stalking", -- From muffle
    -- "suppressed", -- spirit suppress
    -- "retaliation",
    -- "ascetic", -- spirit ascetic


    

local Keep = {
    "ascetic",
    "acuity",
    "celerity",
    "holylight",
};

local Defup = {
    "ardour_constitution",
    "relentless",
    "resolved",
    "celerity",
    "suppressed",
    "retaliation",
    "arrow_catching",
    "impersonate",
    -- Make sure this respects path.
    "transcend",
    -- Add some recruit/doctrine mechanism.
};

local dict = AB.Dictum;
local disc = AB.Discipline;
local asc = AB.Ascendance;

local Actions = {
    ardour_constitution = {ab = asc.Ardour, data = {stat = "constitution"}},
    ardour_strength = {ab = asc.Ardour, data = {stat = "constitution"}},
    ardour_dexterity = {ab = asc.Ardour, data = {stat = "constitution"}},
    ardour_intelligence = {ab = asc.Ardour, data = {stat = "constitution"}},
    ardour_wisdom = {ab = asc.Ardour, data = {stat = "constitution"}},

    relentless = {ab = asc.Relentless},
    resolved = {ab = asc.Resolve},
    celerity = {ab = asc.Celerity},
    acuity = {ab = asc.Acuity},
    -- muffled = {ab = asc.Muffle},
    suppressed = {ab = disc.Suppress},
    retaliation = {ab = disc.Retaliation},
    ascetic = {ab = disc.Ascetic},
    arrow_catching = {ab = asc.Catching},
    impersonate = {ab = asc.Impersonate},
    transcendence = {ab = disc.Transcend},

    holylight = {ab = disc.Light},
};

for k,v in pairs(Actions) do
    if (not v.ab) then
        display("WARNING: No AB for " .. k);
    end
    -- Add if it's not in the config and actions list
    DEFS.config[k] = {action = "akkari", keep = table.contains(Keep, k), defup = table.contains(Defup, k), classList = {"akkari", "praenomen"}};

    if (not DEFS.actions[k]) then
        DEFS.actions[k] = {};
    end

    DEFS.actions[k].akkari = v;
end