local function trackTarget()
    local trackTable = {
        affs = NU.buildAffTable(),
        audits = {cutting = 0.4, blunt = 0.4, magic = 0.4, fire = 0.4, cold = 0.4, electric = 0.4, poison = 0.4, psychic = 0.4, asphyxiation = 0.4, shadow = 0.8, spirit = 0.8, unblockable = 1.0},
        defs = {rebounding = true, arcane = true, levitation = true, fangbarrier = true, blindness = true, deafness = true, speed = true},
        hidden = {},
        hidden_todo = {},
        wounds = {head = 0.0, torso = 0.0, ["left arm"] = 0.0, ["right arm"] = 0.0, ["left leg"] = 0.0, ["right leg"] = 0.0},
        stacks = { ablaze = 0, sapped_strength = 0, gleam = 0, allergies = 0 }, -- TODO: Other stacking mechanics?
        vitals = VITALS.buildVitals(),
        bals = TRACK.buildBalanceTable(),
        misc = {}, -- Misc table for flags/etc.
        actions = {
            -- other misc actions that we want to TRACK.
            exRebound = -1,
            exSpeed = -1,
            exResto = {-1, "nowhere"},
        }
    }

    return trackTable;
end

function TRACK.get(target)
    if (not target) then return nil; end

    local targLower = string.lower(target);

    if (targLower == "you" or targLower == "your" or targLower == "yourself") then
        targLower = string.lower(gmcp.Char.Status.name);
    end

    if (not TRACKED[targLower]) then
        TRACKED[targLower] = trackTarget();
        TRACKED[targLower].name = targLower;
    end
    TRACKED[targLower].lastUpdate = NU.time();

    return TRACKED[targLower];
end

function TRACK.setTHP(targetName, current, max)
    TRACK.setHP(TRACK.get(targetName), current, max);
end

function TRACK.setTMP(targetName, current, max)
    TRACK.setMP(TRACK.get(targetName), current, max);
end

function TRACK.setHP(ttable, current, max)
    if (current) then
        ttable.vitals.hp = current;
    end
    if (max) then
        ttable.vitals.maxhp = max;
    end
end

function TRACK.setMP(ttable, current, max)
    if (current) then
        ttable.vitals.mp = current;
    end
    if (max) then
        ttable.vitals.maxmp = max;
    end
end