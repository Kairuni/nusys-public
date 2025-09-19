local Keep = {
    "sagani_wall",
    "sagani_similitude",
};

local Defup = {
    "sagani_wall",
    "sagani_presence",
    "sagani_helix_stored",
    "sagani_similitude",
    "sagani_epicentre",
};

local eq = "equilibrium";

local actions = {
    sagani_wall = {ab = AB.Sagani.Wall, bal = eq, balCost = 2},
    sagani_presence = {ab = AB.Sagani.Presence, bal = eq, balCost = 2},
    sagani_helix_stored = {ab = AB.Sagani.Helix_Stored, bal = eq, balCost = 2},
    sagani_similitude = {ab = AB.Sagani.Similitude, bal = eq, balCost = 2},
    sagani_epicentre = {ab = AB.Sagani.Epicentre, bal = eq, balCost = 2},
};

for k,v in pairs(actions) do
    -- Add if it's not in the config and actions list
    DEFS.config[k] = {action = "Sagani", keep = table.contains(Keep, k), defup = table.contains(Defup, k), classList = {"sagani"}};

    if (not DEFS.actions[k]) then
        DEFS.actions[k] = {};
    end

    DEFS.actions[k].Sagani = v;
end