local defaultKeep = {
    "blindness",
    "deafness",
    "insomnia",
    "instawake",
    "nightsight",
    "deathsight",
    "fangbarrier",
    "arcane",
    "mindseye",
    "thirdeye",
    "levitation",
    "speed",
    "cloak",
    "safeguard",
    "lifevision",
    "overwatch",
    "insight",
    "density",
    "lipreading",
    "irongrip",
};

local defaultDefup = {
    "clarity"
};

for _,v in ipairs(defaultKeep) do
    DEFS.config[v].keep = true;
end

for _,v in ipairs(defaultDefup) do
    DEFS.config[v].defup = true;
end

local pillActions = {
    blindness = {ab = AB.Pill.blindness, usePrio = true},
    deafness = {ab = AB.Pill.deafness, usePrio = true},
    waterbreathing = {ab = AB.Pill.waterbreathing, usePrio = true},
    insomnia = {ab = AB.Pill.insomnia, usePrio = true},
    instawake = {ab = AB.Pill.instawake, usePrio = true},
    deathsight = {ab = AB.Pill.deathsight, usePrio = true},
    thirdeye = {ab = AB.Pill.thirdeye, usePrio = true},
};

local poulticeActions = {
    fangbarrier = {ab = AB.Poultice.fangbarrier},
    density = {ab = AB.Poultice.density, usePrio = true},
};

local sipActions = {
    arcane = {ab = AB.Sip.arcane, usePrio = true},
    levitation = {ab = AB.Sip.levitation, usePrio = true},
    harmony = {ab = AB.Sip.harmony, usePrio = true},
    speed = {ab = AB.Sip.speed, usePrio = true},
    vigor = {ab = AB.Sip.vigor, usePrio = true}
};

local pipeActions = {
    rebounding = {ab = AB.Pipe.rebounding, usePrio = true},
};

local generalActions = {
    insomnia = {ab = AB.General.insomnia},
    nightsight = {ab = AB.General.nightsight},
    deathsight = {ab = AB.General.deathsight},
    thirdeye = {ab = AB.General.thirdeye},
    safeguard = {ab = AB.General.safeguard, alternatives = {"miasma", "warmth"}},
    irongrip = {ab = AB.General.irongrip},
    clarity = {ab = AB.General.clarity},
    selfishness = {ab = AB.General.selfishness, remove = {Default = "generosity"}},
};

local tattooActions = {
    flame = {ab = AB.Tattoos.flame},
    cloak = {ab = AB.Tattoos.cloak},
    mindseye = {ab = AB.Tattoos.mindseye},
};

local artifactActions = {
    nightsight = {ab = AB.Artifact.nightsight},
    thirdeye = {ab = AB.Artifact.thirdeye},
    mindseye = {ab = AB.Artifact.mindseye},
    lifevision = {ab = AB.Artifact.lifevision},
    insight = {ab = AB.Artifact.insight},
    lipreading = {ab = AB.Artifact.lipreading},
    overwatch = {ab = AB.Artifact.overwatch},
    density = {ab = AB.Artifact.density},
};

-- TODO: Test this. We've just removed all actions that take balances from these types. Let the priority list handle the cures.
for k,v in pairs(pillActions) do
    DEFS.actions[k].pill = v;
    DEFS.config[k].action = "pill";
end

for k,v in pairs(poulticeActions) do
    DEFS.actions[k].poultice = v;
    DEFS.config[k].action = "poultice";
end

for k,v in pairs(sipActions) do
    DEFS.actions[k].sip = v;
    DEFS.config[k].action = "sip";
end

for k,v in pairs(pipeActions) do
    DEFS.actions[k].pipe = v;
    DEFS.config[k].action = "pipe";
end

for k,v in pairs(generalActions) do
    DEFS.actions[k].general = v;
    DEFS.config[k].action = "general";
end

for k,v in pairs(tattooActions) do
    DEFS.actions[k].tattoo = v;
    DEFS.config[k].action = "tattoo";
end

DEFS.actions.lifevision.artifact_mask = {ab = AB.Artifact.lifevision_mask};

for k,v in pairs(artifactActions) do
    DEFS.actions[k].artifact = v;
    if (NU.config.goggles) then
        DEFS.config[k].action = "artifact";
    end
end
