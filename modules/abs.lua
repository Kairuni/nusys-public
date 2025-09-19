AB = AB or {};

MIRRORS = {};

-- TODO: Clean up via args as a table.
function AB.genericRequirements(attacker, target, armReqs, _, _, canFallen, ignoreShield, cooldown, legReqs)
    local aaffs = attacker.affs;
    local taffs = target and target.affs or {};
    local tdefs = target and target.defs or {};

    local armFlag = not armReqs or (armReqs == 0) or
            (armReqs == 1 and (not aaffs.left_arm_crippled or not aaffs.right_arm_crippled)) or
            (armReqs == 2 and not aaffs.left_arm_crippled and not aaffs.right_arm_crippled);
    local legFlag = not legReqs or (legReqs == 0) or
            (legReqs == 1 and (not aaffs.left_leg_crippled or not aaffs.right_leg_crippled)) or
            (legReqs == 2 and not aaffs.left_leg_crippled and not aaffs.right_leg_crippled);

    local shieldBarrierOrAegisFlag = (ignoreShield or not tdefs.shielded or PFLAGS.will_raze_shield) and not tdefs.barrier and not tdefs.manipulation_aegis;
    local fallenFlag = not aaffs.FALLEN or canFallen or
    (aaffs.FALLEN and not aaffs.left_leg_crippled and not aaffs.right_leg_crippled and TRACK.countType(attacker, "writheAffs") == 0 and not aaffs.frozen);
    local asleepFlag = not aaffs.asleep;

    -- TODO: Replace this, I'm guessing it's actually broken everywhere.
    local cooldownFlag = true;
    if (cooldown) then
        cooldownFlag = NU.offCD(cooldown);
    end

    -- NU.promptAppend("last reqs test", "Reqs: " .. tostring(armFlag) .. " " .. tostring(legFlag) .. " " ..
    --     tostring(shieldBarrierOrAegisFlag) ..
    --     " " .. tostring(fallenFlag) .. " " .. tostring(asleepFlag) .. " " .. tostring(cooldownFlag));
    return armFlag and legFlag and shieldBarrierOrAegisFlag and fallenFlag and asleepFlag and cooldownFlag;
end
-- As a sample
AB.defaultAB = {
    -- Returns a list of target affs to apply.
    getTargetAffs = function(attacker, target, data)
        return {};
    end,

    -- Returns a list of target affs to cure.
    getTargetCures = function(attacker, target, data)
        return {};
    end,

    -- Returns a list of self affs to apply.
    getSelfAffs = function(attacker, target, data)
        return {};
    end,

    -- Returns a list of self affs to cure.
    getSelfCures = function(attacker, target, data)
        return {};
    end,

    -- Returns a list of self defs to add.
    getSelfDefs = function(attacker, target, data)
        return {};
    end,

    -- Returns a list of self defs to remove.
    getRemovedSelfDefs = function(attacker, target, data)
        return {};
    end,

    -- Returns damage, mana damage, self damage, self mana damage.
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 0;
    end,

    -- Returns end, wp cost.
    getCost = function()
        return 0, 0
    end,

    getLimbEffects = function(attacker, target, data)
        return {};
    end,

    balance = function(attacker, target, data)
        return {self = {bal = nil, cost = 0}, target = {bal = nil, cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return (not attacker.affs.left_arm_crippled and not attacker.affs.right_arm_crippled) and not attacker.affs.FALLEN and not attacker.affs.asleep and (not target or (target and not target.defs.shielded
                            and not target.defs.barrier and not target.defs.manipulation_aegis));
    end,

    postEffects = function(attacker, target, data)

    end,

    convertData = function(cmsgOther, cmsgLimb)
        return {empowerments = {cmsgOther}, limb = cmsgLimb};
    end,

    syntax = {},
};

local freezeAffOrder = {
    "shivering",
    "frigid",
    "frozen",
};

function AB.freezeStack(target, count)
    local retList = {};
    for _,v in ipairs(freezeAffOrder) do
        if (count > 0 and not target.affs[v]) then
            table.insert(retList, v);
            count = count - 1;
        end
    end

    return retList;
end

function AB.linearStack(target, stack, count)
    count = count or 1;
    local affs = {};
    local i = 0;
    for _,v in ipairs(stack) do
        local paresisCheck = (v == "paresis" and target.affs.paralysis);
        if (not target.affs[v] and not paresisCheck) then
            table.insert(affs, v);
            i = i + 1;
            if (i >= count) then
                return affs;
            end
        end
    end
    return affs;
end

NU.loadAll("abs");

local skMirrors = NU.skillMirrors or {};
local ABMetaTable = {
    __index = function(t, k)
        if (skMirrors[k] and rawget(t, skMirrors[k])) then
            return t[skMirrors[k]];
        end
    end
}

setmetatable(AB, ABMetaTable);

local skillMetaTable = {
    __index = function(t, k)
        if (MIRRORS[t] and MIRRORS[t][k]) then
            return rawget(t, MIRRORS[t][k]);
        end
    end
}

local abilityMetaTable = {
    __index = function(t, k)
        return AB.defaultAB[k];
    end
}

function AB.loadByClassAndCategories(class, categories)
    for _,v in ipairs(categories) do
        NU.load("abs", class .. "/" .. v)();
    end
end

for mirror, original in pairs(NU.skillMirrors) do
    if (AB[original]) then
        MIRRORS[AB[original]] = NU.abMirrors[mirror];
    end
end

for tree, abs in pairs(AB) do
    if (type(abs) == "table" and tree ~= "defaultAB") then
        setmetatable(abs, skillMetaTable);
    end
end

for tree, abs in pairs(AB) do
    if (type(abs) == "table" and tree ~= "defaultAB") then
        for k,v in pairs(abs) do
            if (k ~= "mirrorMap" and type(v) == "table") then
                setmetatable(v, abilityMetaTable);
            end
        end
    end
end

local toAdd = {};
for skill, mirror in pairs(NU.skillMirrors) do
    if (not NU.skillMirrors[mirror]) then
        toAdd[mirror] = skill;
    end
end

for mirror, skill in pairs(toAdd) do
    NU.skillMirrors[mirror] = skill;
end