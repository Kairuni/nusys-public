local Keep = {
    "greenfoot",
    "lifebloom",
    "protection",
    "shaman_spiritsight"

};

local Defup = {
    "oath_shaman",
    "oath_blade",
    "oath_tranquility",
    "spiritbond",
    "spiritsight",
    "shaman_warding",
    "protection",
    "lifebloom",
    "greenfoot",
    "spider_familiar",
};

local eq = "equilibrium";

local shamanActions = {
    greenfoot = {ab = AB.Naturalism.Greenfoot},
    lifebloom = {ab = AB.Primality.Lifebloom},
    protection = {ab = AB.Shamanism.Protection},
    shaman_warding = {ab = AB.Shamanism.Warding},
    spiritbond = {ab = AB.Shamanism.Spiritbond},
    shaman_spiritsight = {ab = AB.Shamanism.Spiritsight},
    oath_shaman = {ab = AB.Shamanism.Oaths, data = {oath = "elder shaman"}},
    oath_blade = {ab = AB.Shamanism.Oaths, data = {oath = "nature's blade"}},
    oath_tranquility = {ab = AB.Shamanism.Oaths, data = {oath = "tranquility"}},
    oath_durdalis = {ab = AB.Shamanism.Oaths, data = {oath = "durdalis"}},

    --spider_familiar = {ab = AB.Shamanism.Summon, data = {familiar = "spider"}},
};

for k,v in pairs(shamanActions) do
    -- Add if it's not in the config and actions list
    -- TODO: Better way for adding these kind of defs to Config. Might have some shared ones that would get overridden.
    DEFS.config[k] = {action = "shaman", keep = table.contains(Keep, k), defup = table.contains(Defup, k), classList = {"shaman", "alchemist"}};

    if (not DEFS.actions[k]) then
        DEFS.actions[k] = {};
    end

    DEFS.actions[k].shaman = v;
end