local Keep = {
    "countercurrent",
    "arcaneskin",
    "empowered_boar",
};

local DefUp = {
    "fulcrum_construct",
    "fulcrum_harmony",
    "fulcrum_schism",
    "fulcrum_imbalance",
    "fulcrum_degradation",
    "fulcrum_spiritrift",
    "simultaneity",
};

local eq = "equilibrium";

local ascendrilActions = {
    countercurrent = {ab = AB.Arcanism.Countercurrent, syntax = {ascendril = "cast countercurrent", Mirror = ""}, bal = eq, balCost = 2},
    arcaneskin = {ab = AB.Arcanism.Arcaneskin, syntax = {ascendril = "cast arcaneskin", Mirror = ""}, bal = eq, balCost = 3.2},
    adamance = {ab = AB.Thaumaturgy.Adamance, syntax = {ascendril = "fulcrum adamance on", Mirror = ""}, bal = eq, remove = {ascendril = "fulcrum adamance off", Mirror = ""}},
    empowered_boar = { ab = AB.Arcanism.Vivacity, syntax = AB.Arcanism.Vivacity.syntax, bal = eq, balcost = 2 },
    --shift = {syntax = {ascendril = "fulcrum shift", Mirror = ""}, bal = eq, balCost = 3}, -- Treated as a combat action rather than a defense.

    -- Actions with no defenses.
    simultaneity = {ab = AB.Elemancy.Simultaneity, syntax = {ascendril = "simultaneity", Mirror = ""}, priorOverride = 1}, -- required for the entire kit to function.
    fulcrum_construct = {ab = AB.Thaumaturgy.Construct, remove = {ascendril = "fulcrum collapse", Mirror = ""}},
    fulcrum_schism = {ab = AB.Thaumaturgy.Schism, remove = {ascendril = "fulcrum schism off", Mirror = ""}},
    fulcrum_imbalance = {ab = AB.Thaumaturgy.Imbalance, remove = {ascendril = "fulcrum imbalance off", Mirror = ""}},
    fulcrum_spiritrift = { ab = AB.Thaumaturgy.Spiritrift, remove = { ascendril = "fulcrum spiritrift off", Mirror = "" } },
    fulcrum_degradation = { ab = AB.Thaumaturgy.Degradation, remove = { ascendril = "fulcrum degradation off", Mirror = "" } },
};

for k,v in pairs(ascendrilActions) do
    -- Add if it's not in the config and actions list
    DEFS.config[k] = {action = "ascendril", keep = table.contains(Keep, k), defup = table.contains(DefUp, k), classList = {"ascendril", "bloodborn"}};

    if (not DEFS.actions[k]) then
        DEFS.actions[k] = {};
    end

    DEFS.actions[k].ascendril = v;
end