local Keep = {
    "haste",
    "disunion",
    "focalmark",
    "tempered_body",
    "mindspark",
};

local DefUp = {
    "deflection",
    "discharge",
    "mindspark",
    "mindset_star"
};

-- remove = {zealot = "", ravager = ""}
local actions = {
    haste = {ab = AB.Zeal.Haste, empowerment = ""}, -- TODO: haste is currently trying to reup while offbal, when we need bal even though it's free. Same with safeguard.
    wrath = {ab = AB.Zeal.Wrath, empowerment = ""},
    litheness = {ab = AB.Zeal.Litheness, empowerment = ""},
    disunion = {ab = AB.Zeal.Disunion, remove = {zealot = "reunite", ravager = "sober"}},
    focalmark = {ab = AB.Purification.Focalmark},
    suncloak = {ab = AB.Purification.Suncloak},
    tempered_body = {ab = AB.Purification.Tempering},
    firefist = {ab = AB.Purification.Firefist},
    deflection = {ab = AB.Purification.Deflection},
    discharge = {ab = AB.Purification.Discharge},
    mindspark = {ab = AB.Psionics.Mindspark},

    -- Actions with no defenses.
    mindset_star = {ab = AB.Zeal.Mindset, empowerment = "star"},
    mindset_sun = {ab = AB.Zeal.Mindset, empowerment = "sun"},
    mindset_moon = {ab = AB.Zeal.Mindset, empowerment = "moon"},
};

for k,v in pairs(actions) do
    -- Add if it's not in the config and actions list
    -- TODO: Better way for adding these kind of defs to Config. Might have some shared ones that would get overridden.
    DEFS.config[k] = {action = "zealot", keep = table.contains(Keep, k), defup = table.contains(DefUp, k), classList = {"zealot", "ravager"}};

    if (not DEFS.actions[k]) then
        DEFS.actions[k] = {};
    end

    DEFS.actions[k].zealot = v;
end