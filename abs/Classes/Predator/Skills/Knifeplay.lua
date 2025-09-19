local aGA = AB.addGenericAbility;
local function dmgConv(eh, em, sh, sm) return {eH = eh, eM = em, sH = sh, sM = sm}; end

local function aGKA(ability, dmg, bal, balCost, affs, defs, limbs, cooldown, dmgType, reboundable, noshield, syntax, otherArgs)
    local args = {
        dmg = dmg and dmgConv(dmg, 0, 0, 0) or nil,
        dmgType = dmg and (dmgType or "cutting") or nil,
        ep = -50,
        affs = affs,
        defs = defs,
        bal = {
            ["cost"] = balCost,
            ["bal"] = bal,
        },
        arms = 1,
        limbs = limbs,
        cooldown = cooldown,
        noshield = noshield,
        rebounding = reboundable,
        syntax = {["Predator"] = syntax},
    }
    if (otherArgs) then
        args = table.union(args, otherArgs);
    end
    aGA("Knifeplay", ability, args);
    AB.Knifeplay[ability].name = ability;
end
-- {["damage"] = 9.5, ["targetable"] = true}

-- Pommelwhip - If hiding, blackout and bypass rebounding.
-- Fleshbane - If Haemophilia, "Gherond winces in pain, the wound reddening as it swells." - 1.86 bal. Lasts for 60s.
aGKA("Fleshbane", 0.05, "balance", 1.86, {"fleshbane"}, nil, nil, nil, nil, false, false, "fleshbane $target $venom", {postEffects = function(stable, ttable, data) NU.setFlag("fleshbane_end_time", NU.time() + 60, 60, function() ttable.affs.fleshbane = false; end) end});
-- Bloodscourge - 3.72 bal. Gives bloodscourge.
-- Your toxic blood has afflicted Gherond with digitalis.
-- A look of relief briefly flits over Gherond's face. -- cured bloodscourge.
aGKA("Bloodscourge", 0.05, "balance", 3.72, {"bloodscourge"}, nil, nil, nil, nil, false, false, "bloodscourge $target $empowerment");
aGKA("Spacing", nil, "balance", 3.72, nil, {"spacing"}, nil, nil, nil, false, true, "spacing");
aGKA("Trueparry", nil, "balance", 4.65, nil, {"trueparry"}, nil, nil, nil, false, true, "trueparry");
-- Your concentration enhances ten-fold as you fix Gherond with a cold and vengeful stare, a surge of pure adrenaline causing your entire body to quiver like a taut bowstring.
-- A slight chill runs down your spine as yourself's eyes flash to yours, locking you in an unblinking gaze. Muscles rippling and quivering, you sinks into a strange stance, knife held out towards you in a gesture of defiance.
-- Health Gain: 3538
-- Your bladesurge defence has been stripped.
-- You feel the adrenaline surging through your body fade away.
aGKA("Bladesurge", nil, "equilibrium", 4.65, nil, {"bladesurge"}, nil, nil, nil, false, true, "bladesurge");


-- Combos
-- local function aGKA(ability, dmg, bal, balCost, affs, defs, limbs, cooldown, dmgType, reboundable, noshield, syntax, otherArgs)
-- stopped by 2 arm break.

-- Lateral - 6% torso damage - 2.05.
aGKA("Lateral", 0.05, "balance", 2.05, nil, nil, {["set"] = {["torso"] = 6}, ["targetable"] = false}, nil, "cutting", true, false, "lateral");
-- Vertical - No limb, gives venom - 3.44 wrong stance, 2.51 right stance.
aGKA("Vertical", 0.05, "balance", 2.51, nil, nil, nil, nil, "cutting", true, false, "vertical");
-- Swiftkick what is this shit - 2.98s bal
aGKA("Swiftkick", 0.05, "balance", 2.98, nil, nil, nil, nil, "blunt", false, false, "swiftkick");
-- Jab - 5.5% arm, targetable, 2.05. If EITHER arm is parried, will fail. If gyanis, it has to be the specific arm.
aGKA("Jab", 0.05, "balance", 2.05, nil, nil, {["damage"] = 5.5, ["targetable"] = true}, nil, "cutting", true, false, "jab $limb");
-- Looks like Kikon parries the attack on his arms with a deft maneuver.
-- Trip - Prone
aGKA("Trip", nil, "balance", 2.98, {"FALLEN"}, nil, nil, nil, nil, false, false, "trip");
-- Feint - force parry relocate -- cd msg: Feints are best used sparingly, lest they become predictable. -- 10s cd.
aGKA("Feint", nil, "balance", 2.98, nil, nil, nil, 10, nil, true, false, "feint $limb", {onUseEffects = function(_, _, data) NU.setFlag("last_seen_parry", data.limb, 2.5); end});
-- Pinprick - 2.05 right stance, 3 wrong stance. Just gives epilepsy.
aGKA("Pinprick", 0.05, "balance", 2.05, {"epilepsy"}, nil, nil, nil, "cutting", true, false, "pinprick");
-- Raze - 2.05, does reflection, shield, rebounding, speed.
local defsToRemove = {
    failure = {"speed", "rebounding", "shielded"},
    speed = {"speed", "rebounding", "shielded"},
    rebounding = {"rebounding", "shielded"},
    shield = {"shielded"}
}
aGKA("Raze", nil, "balance", 2.05, nil, nil, nil, nil, nil, false, true, "raze", {
    onUseEffects = function(_, ttable, data)
        if (data.empowerments) then
            for _,v in ipairs(defsToRemove[data.empowerments[1]]) do
                ttable.defs[v] = false;
            end
        end
    end});
-- Bleed - 2.92 - 2 instances of damage, escalating fleshbane?
aGKA("Bleed", 0.05, "balance", 2.05, nil, nil, nil, nil, nil, true, false, "bleed");
-- Flashkick - 5% head damage, 3.91. 3.32 after vae-sant balance, random aff from Confusion, dementia, weariness, stupidity, or dizziness. If all, then blackout.
-- Your precision strike causes weariness in Gherond.
aGKA("Flashkick", 0.05, "balance", 2.05, function() return nil, {"confusion", "dementia", "weariness", "stupidity", "dizziness"}, 1; end, nil, {["set"] = {["head"] = 5.0}, ["targetable"] = false}, nil, nil, false, false, "flashkick");

-- Crescentcut - 3.91. venom, and damage. More damage with crippled leg, writhes, paresis, fallen, broken limbs, mangled torso/head.
aGKA("Crescentcut", 0.05, "balance", 2.05, nil, nil, nil, nil, nil, true, false, "crescentcut");

-- Lowhook - 5.5% leg, same idea as jab. 2.05.  If gyanis, it has to be the specific arm.
aGKA("Lowhook", 0.05, "balance", 2.05, nil, nil, {["damage"] = 5.5, ["targetable"] = true}, nil, "cutting", true, false, "lowhook $limb");
-- Veinrip - 1.5% head, small bleed, delayed weariness/dizziness. Blood squirts from the open wound upon Gherond neck, drenching their side. The flow of blood slows and thickens from Gherond's neck, pail from from all the loss.
aGKA("Veinrip", 0.05, "balance", 3.3, nil, nil, {["set"] = {["head"] = 1.5}, ["targetable"] = false}, nil, "cutting", true, false, "veinrip");
-- Gouge - 0.75% x2 head. 2 instances of damage, escalating fleshbane.
aGKA("Gouge", 0.05, "balance", 2.9, nil, nil, {["set"] = {["head"] = 6.5}, ["targetable"] = false}, nil, "cutting", true, false, "gouge");
-- Freefall - if flying, 3 instances of damage and microstun. Target also needs to be in air
-- Spinslash - 3.5 x2 random non-parried limb. Two instances of damage. Ignores rebounding.
aGKA("Spinslash", 0.05, "balance", 2.51, nil, nil, {["damage"] = 4.0, ["targetable"] = true}, nil, "cutting", true, false, "spinslash");
-- Butterfly - move from external room, apply venom.
-- Tidalslash - damage.
aGKA("Absorption", 0.05, "balance", 2.05, nil, {"absorption"}, nil, nil, nil, true, false, "absorption");
aGKA("Tidalslash", 0.05, "balance", 2.05, nil, nil, nil, nil, nil, true, false, "crescentcut");

aGA("Knifeplay", "Series", {
    bal = {["cost"] = 3, ["bal"] = "balance"},
    syntax = {Predator = "series $empowerment1 $empowerment2 $empowerment3 $empowerment4 $target $venom"},

    reqs = function(attacker, target, data)
        for _, abTable in pairs(data) do
            if (type(abTable) == "table" and abTable.meetsPreReqs and not abTable.meetsPreReqs(attacker, target, data)) then
                return false;
            end
        end
        return true;
    end

});