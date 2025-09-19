-- Intensity costs 1s eq (crown) and gives an estimate of stacks.
-- no cmsg.
-- Eliadon has no flames around him.
-- The flames around Eliadon are at an intensity level of 2.
-- Apparently it gives exact stacks.
-- Cinderkin/Impressment missing CALL CINDERKIN/CALL IMPRESSMENT
-- Firefist lasts for 30s, cooldown of 80s - You cannot ignite your fists again so soon.
-- Set noShield to true for defense skills all around, whoops.
-- Quicken is 3 fire stacks
-- Pendulum does a whole lot of limb fuckery, make that a thing.
-- Several ABs have ablaze as a req, maybe add that to aGA - heatpsear, quicken. Infernal_seal requires damaged_torso.
-- Need infernal 3p line
-- Zenith starts a timer, eventually gain zenith.
-- This eventually lets certain abilities be used offbal - which makes me think I need a way to signal just that as a prereq. They're disjoint enough that you probably don't want to use them unless you at most flowed within the last 1s.
-- Immolation has a niche req - 12 stacks of ablaze.
-- Your spirit swells with power as you dwell upon departed Arion, invoking an ancient prayer of valor.
-- You have gained the resurgence defence.
-- Equilibrium Used: 5.58 seconds
-- You are already protected from death.

-- You are already rejecting weapons directed at you.
-- Your body is already tempered.
-- You are already cloaked in a dim light.
-- You already possess your focalmark.

-- say Esondae breaks Dwindle
-- say Vontovo breaks Bedlam

-- Pyromania end - You feel the heat in the ground dissipate.
-- Need 3p enemy lines for Pyromania.
-- Maybe? add purgatory idk

local aGA = AB.addGenericAbility;
local function dmgConv(eh, em, sh, sm) return {eH = eh, eM = em, sH = sh, sM = sm}; end

aGA("Purification", "Focalmark", {defs = {"focalmark"}, noshield = false, bal = {["cost"] = 0.93, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact focalmark", ["ravager"] = "invoke vinculum"}});
aGA("Purification", "Ignition", {wp = -20, ep = -4, psiCost = 0, noshield = false, bal = {["cost"] = 2.79, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact ignition <item>", ["ravager"] = "invoke wither <item>"}});
aGA("Purification", "Purify", {wp = -20, ep = -3, noshield = false, bal = {["cost"] = 1.86, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact purification <liquid>", ["ravager"] = "invoke distill <liquid>"}});
aGA("Purification", "Turning", {wp = -6, ep = 4, noshield = false, bal = {["cost"] = 2.79, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact turning $target", ["ravager"] = "invoke terrify $target"}});
aGA("Purification", "Hearth", {wp = -16, noshield = false, bal = {["cost"] = 2.79, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact hearth", ["ravager"] = "invoke smoulder"}});
aGA("Purification", "Cinderkin", {wp = -10, ep = 1, noshield = false, bal = {["cost"] = 3.72, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact cinderkin", ["ravager"] = "invoke impressment"}});
aGA("Purification", "Suncloak", {wp = -10, defs = {"suncloak"}, noshield = false, bal = {["cost"] = 2.79, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact suncloak", ["ravager"] = "enact suncloak"}});
aGA("Purification", "Cascade", {wp = -20, noshield = false, bal = {["cost"] = 2.79, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact cascade $target", ["ravager"] = "invoke begrudge $target"}});
aGA("Purification", "Tempering", {wp = -30, ep = -1, defs = {"tempered_body"}, noshield = false, bal = {["cost"] = 1.86, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact tempering", ["ravager"] = "invoke ruthlessness"}});
aGA("Purification", "Firefist", {wp = -2, defs = {"firefist"}, cooldown = 80, noshield = false, arms = 2, syntax = {["zealot"] = "enact firefist", ["ravager"] = "invoke ravage"}});
aGA("Purification", "Rejection", {wp = -10, defs = {"rebounding"}, noshield = false, bal = {["cost"] = 3.26, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact rejection", ["ravager"] = "invoke denial"}});
aGA("Purification", "Deflection", {wp = -10, ep = 1, defs = {"deflection"}, noshield = false, bal = {["cost"] = 2.79, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact deflection", ["ravager"] = "invoke impenetrable"}});
aGA("Purification", "Discharge", {wp = -40, ep = 1, defs = {"discharge"}, noshield = false, bal = {["cost"] = 2.79, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact discharge", ["ravager"] = "invoke criticality"}});
aGA("Purification", "Infernal", {dmgConv(0.10603461718385, 0, 0, 0), wp = -20, dmgType = "fire", affs = {"infernal_seal"}, noshield = false, bal = {["cost"] = 1.86, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact infernal $target", ["ravager"] = "invoke branding $target"}});
aGA("Purification", "Dwindle", {wp = -60, noshield = false, bal = {["cost"] = 3.72, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact dwindle", ["ravager"] = "invoke bedlam"}});

-- Pendulum
local cwShiftOrder = {
    left_leg = "left_arm",
    left_arm = "right_arm",
    right_arm = "right_leg",
    right_leg = "left_leg"
}
local ccwShiftOrder = {
    left_leg = "right_leg",
    right_leg = "right_arm",
    right_arm = "left_arm",
    left_arm = "left_leg"
}
local affTestList = {"_crippled", "_broken", "_mangled"};

local function handlePendulum(target, shiftOrder, oppositeShiftOrder)
    --display(shiftOrder);
    local affsToAdd = {};
    for limb, targetLimb in pairs(shiftOrder) do
        for _,test in ipairs(affTestList) do
            if (target.affs[limb .. test]) then
                TRACK.remove(target, limb .. test)
                table.insert(affsToAdd, targetLimb .. test);
            end
        end
    end

    if (target.affs.sore_wrist and not target.affs.sore_ankle) then
        TRACK.remove(target, "sore_wrist")
        table.insert(affsToAdd, "sore_ankle");
    elseif (target.affs.sore_ankle and not target.affs.sore_wrist) then
        TRACK.remove(target, "sore_ankle")
        table.insert(affsToAdd, "sore_wrist");
    end

    target.wounds = {
        head = target.wounds.head,
        torso = target.wounds.torso,
        ["left arm"] = target.wounds[oppositeShiftOrder["left_arm"]:gsub("_", " ")],
        ["right arm"] = target.wounds[oppositeShiftOrder["right_arm"]:gsub("_", " ")],
        ["left leg"] = target.wounds[oppositeShiftOrder["left_leg"]:gsub("_", " ")],
        ["right leg"] = target.wounds[oppositeShiftOrder["right_leg"]:gsub("_", " ")],
    }

    TRACK.affs(target, affsToAdd)
end

aGA("Purification", "Pendulum", {wp = -30, cooldown = 20, noshield = false, bal = {["cost"] = 2.79, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "enact pendulum $target $empowerment", ["ravager"] = "invoke bedevil $target $empowerment"},
    onUseEffects = function(attacker, target, data)
        if (data.empowerments[1] == "clockwise") then
            --display("Clockwise");
            handlePendulum(target, cwShiftOrder, ccwShiftOrder);
        else
            --display("Other");
            handlePendulum(target, ccwShiftOrder, cwShiftOrder);
        end
    end
});

-- Zenith - TODO: This isn't actually how it works exactly, but this is a workaround to get it working quicker. After 15s activates, 12 after that deactivates.
aGA("Purification", "Zenith", {rebounding = false, cooldown = 30, onUse = function(atable, ttable, data) NU.setFlag(atable.name .. "_zenith_in", NU.time() + 15, 15); end, noShield = false, bal = {["cost"] = 1, ["bal"] = "equilibrium"}, arms = 0, syntax = {["zealot"] = "enact zenith", ["ravager"] = "invoke delirium"}});

-- Zenithable
aGA("Purification", "Cauterize", {wp = -6, noshield = false, bal = {["cost"] = 2.79, ["bal"] = "equilibrium"}, arms = 1, syntax = {["zealot"] = "enact cauterize", ["ravager"] = "invoke prolong $target"}});
aGA("Purification", "Scorch", {dmgConv(0.14127553407142, 0, 0, 0), wp = -10, dmgType = "fire", affs = {"ablaze"}, noshield = true, bal = {["cost"] = 1.86, ["bal"] = "equilibrium"}, arms = 1, syntax = {["zealot"] = "enact scorch $target", ["ravager"] = "invoke torment $target"}, ep = -6});
aGA("Purification", "Heatspear", {dmgConv(0.086363636363636, 0, 0, 0), wp = -15, dmgType = "spirit", affs = {"heatspear"}, noshield = false, bal = {["cost"] = 2.98, ["bal"] = "equilibrium"}, arms = 1, syntax = {["zealot"] = "enact heatspear $target", ["ravager"] = "invoke lance $target"}});
aGA("Purification", "Quicken", {
    wp = -10,
    noshield = false,
    bal = {["cost"] = 2.79, ["bal"] = "equilibrium"},
    arms = 1,
    syntax = {["zealot"] = "enact quicken $target", ["ravager"] = "invoke intensify $target"},
    onUseEffects = function(attacker, target, data) TRACK.stack(target, "ablaze", 3); end
});
aGA("Purification", "Pyromania", {wp = -30, bal = {["cost"] = 2.79, ["bal"] = "equilibrium"},
    onUse = function(stable, ttable, data)
        NU.setFlag("pyromania", true, 22)
    end,
    reqs = function(attacker, target, data) return not FLAGS.pyromania and AB.genericRequirements(attacker, target, 1, false, false, false, true, false, 0); end,
    syntax = {["zealot"] = "enact pyromania", ["ravager"] = "invoke hellfire"}
});

-- Ablaze prereq
aGA("Purification", "Immolation", {
    wp = -300,
    bal = {["cost"] = 5.58, ["bal"] = "equilibrium"},
    reqs = function(attacker, target, data) return target.affs.ablaze and target.stacks.ablaze >= 12 and AB.genericRequirements(attacker, target, 1, false, false, false, false, false, 0); end,
    syntax = {["zealot"] = "enact immolation $target", ["ravager"] = "invoke extinguish $target"}
});
