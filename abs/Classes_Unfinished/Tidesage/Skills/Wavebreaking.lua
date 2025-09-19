AB["Wavebreaking"] = AB["Wavebreaking"] or {};

local aGA = function(ability, args)
    AB.addGenericAbility("Wavebreaking", ability, args);
end
local isMe = TRACK.isSelf;
local cA = TRACK.cureAction;
local bSyn = function(syntax)
    return {tidesage = syntax, teradrim = "UNDEFINED"};
end
local bal = function(cost, isEq)
    return {bal = isEq and "equilibrium" or "balance", cost = cost};
end

aGA("Daub", {syntax = bSyn("tide daub $empowerment1 upon $empowerment2"), postEffects = function(st, _, _) if (st == TRACK.getSelf()) then NU.setPFlag("should_def", true); end end, noShield = true, bal = bal(5, true)})
aGA("Yearn", {syntax = bSyn("tide yearn"), dmg = {sM = 50}, onUseEffects = function(attacker) cA(attacker.name, "random"); end, noShield = true, bal = bal(2.5), cooldown = 15, arms = 2});
aGA("Encrust",    {syntax = bSyn("tide encrust"), defs = {"encrusted"}, bal = bal(2.5), noShield = true});
aGA("Sealegs", {syntax = bSyn("tide sealegs"), defs = {"sealegs"}, bal = bal(3), noShield = true});
aGA("Wavebreak", {syntax = bSyn("tide wavebreak"), defs = {"wavebreak"}, noShield = true, bal = bal(0)});
aGA("Shore", {syntax = bSyn("tide shore"), defs = {"shore_leave"}, bal = bal(2.5), noShield = true});
aGA("Rime", {syntax = bSyn("tide expose rime"), defs = {"expose_rime"}, bal = bal(2.5), noShield = true});
aGA("Riptide", {syntax = bSyn("tide riptide $target"), bal = bal(2)});
aGA("Currents", {syntax = bSyn("tide currents"), defs = {"tide_currents"}, bal = bal(0)});
aGA("Spout", {syntax = bSyn("tide spout $target"), bal = bal(3)});
aGA("Bedrabble", {syntax = bSyn("tide bedrabble"), bal = bal(4)});
aGA("Brume", {syntax = bSyn("tide expose brume"), defs = {"expose_brume"}, bal = bal(2.5), noShield = true});
aGA("Flux", {syntax = bSyn("tide flux"), defs = {"tideflux"}, bal = bal(2.5), noShield = true});
aGA("Drown", {syntax = bSyn("tide drown $target"), defs = {"tideflux"}, bal = bal(2.5), noShield = true});
aGA("Harpoon", {syntax = bSyn("tide harpoon $target"), affs = function(attacker, target, data) if (not data.empowerment) then return {"writhe_impaled"}; else return {}; end end, bal = bal(2)});
aGA("Lowtide", {syntax = bSyn("tide lowtide"), bal = bal(4)});
aGA("Eviscerate", {syntax = bSyn("tide eviscerate"), bal = bal(4), postEffects = function(attacker, target, data) TRACK.cure(target, "writhe_impaled"); end});
aGA("Undulation", {syntax = bSyn("tide undulation"), bal = bal(4), dmg = {eH = 40}, reqs = function(attacker, target, data) return AB.genericRequirements(attacker, target, 1, false, false, false, false, nil, 0) and target.affs.PRONE; end});
aGA("Trench", {syntax = bSyn("tide trench"), bal = bal(4)});
aGA("Hightide", {syntax = bSyn("tide hightide"), noShield = true, bal = bal(2.5), cooldown = 60});
aGA("Engulf", {syntax = bSyn("tide engulf $empowerment"), defs = {"elemental_engulf"}, reqs = function(st, tt, data) return NU.offCD(st.name .. "_Engulf"); end}); -- Cooldown triggers on hit.
aGA("Capsize", {syntax = bSyn("tide capsize $target"), affs = {"FALLEN"}, bal = bal(3), onUseEffects = function(_, _, _) TRIG.enable(TRIGS.tidesage_capsize_limb_break); TRIG.enable(TRIGS.tidesage_capsize_prompt); end});
aGA("Permafrost", {syntax = bSyn("tide permafrost"), bal = bal(4), reqs = function(_, _, _) return not FLAGS.permafrost_deffing; end});

-- Weapon attacks - all damage base, need to figure out red ink Daub.
-- NOTE: Red major is 25% more limb damage, red minor is 8% more on Buckle specifically.
local singleLimbDamage = function(dmg, fixed)
    if (fixed) then
        return function(attacker, target, data)
            local redMajor = FLAGS.daub and FLAGS.daub.major == "red" or false;
            local redMajorMultiplier = redMajor and 1.25 or 1.0;

            return {[fixed] = dmg * redMajorMultiplier};
        end
    else
        return function(attacker, target, data)
            if (not data.limb) then
                return {};
            end

            local redMajor = FLAGS.daub and FLAGS.daub.major == "red" or false;
            local redMajorMultiplier = redMajor and 1.25 or 1.0;
            return {[data.limb] = dmg * redMajorMultiplier};
        end
    end
end

local twoLimbDamage = function(dmg)
    return function(attacker, target, data)
        if (not data.limb) then
            return {};
        end

        local redMajor = FLAGS.daub and FLAGS.daub.major == "red" or false;
        local redMajorMultiplier = redMajor and 1.25 or 1.0;
        return {[data.limb] = dmg * redMajorMultiplier};
    end
end

local bruiseAffFromData = function()
    return function(attacker, target, data)
        if (data.limb) then
            local limb_aff = data.limb:gsub(" ", "_") .. "_bruised";
            local aff = limb_aff;
            if (target.affs[limb_aff .. "_moderate"]) then
                aff = limb_aff .. "_critical";
            elseif (target.affs[limb_aff]) then
                aff = limb_aff .. "_moderate";
            end

            return {aff}
        end
    end
end

local bruiseAffOnLimb = function(limb)
    return function(attacker, target, data)
        local limb_aff = limb .. "_bruised";
        local aff = limb_aff;
        if (target.affs[limb_aff .. "_moderate"]) then
            aff = limb_aff .. "_critical";
        elseif (target.affs[limb_aff]) then
            aff = limb_aff .. "_moderate";
        end

        return {aff}
    end
end

aGA("Clobber", {syntax = bSyn("tide clobber $target $limb"), bal = bal(2.6), dmg = {eH = 8}, limbs = singleLimbDamage(13.75), encrust = true, rebounding = true});
aGA("Crack", {syntax = bSyn("tide crack $target $limb"), bal = bal(2.8), dmg = {eH = 8}, limbs = singleLimbDamage(10), encrust = true, rebounding = true});
aGA("Crest", {syntax = bSyn("tide crest $target"), bal = bal(2.9), dmg = {eH = 8}, limbs = singleLimbDamage(13, "head"), encrust = true, rebounding = true});
aGA("Ram", {syntax = bSyn("tide ram $target"), bal = bal(2.9), dmg = {eH = 7}, limbs = singleLimbDamage(12, "torso"), encrust = true, rebounding = true});
aGA("Buckle", {syntax = bSyn("tide buckle $target $limb"), bal = bal(2.8), dmg = {eH = 8},
        limbs = function(attacker, target, data)
            if (not data.limb) then
                return {};
            end

            local limb_aff = data.limb:gsub(" ", "_") .. "_bruised";
            local redMajor = FLAGS.daub and FLAGS.daub.major == "red" or false;
            local redMinor = FLAGS.daub and FLAGS.daub.minor == "red" or false;
            local redMajorMultiplier = redMajor and 1.25 or 1.0;
            local redMinorMultiplier = redMinor and 1.08 or 1.0;
            local dmg = 12; -- 12.96 red on yellow 15.0 yellow on red 16.2 red on red.

            if (target.affs[limb_aff .. "_critical"]) then
                dmg = 24;
            elseif (target.affs[limb_aff .. "_moderate"]) then
                dmg = 20;
            elseif (target.affs[limb_aff]) then
                dmg = 16;
            end
            dmg = dmg * redMajorMultiplier * redMinorMultiplier

            return {[data.limb] = dmg};
        end,
    affs = function(attacker, target, data)
        if (data.limb) then
            local limb = data.limb:gsub(" ", "_");
            local limb_req = limb .. "_bruised";
            local limb_aff =    limb .. "_crippled";
            return target.affs[limb_req] and {limb_aff} or {};
        end
    end, encrust = true, rebounding = true});
-- Note - this says 'singleLimbDamage' but that's because the cmsg is single - it's actually 2 hits to arms or legs. Note that this cannot hit head/torso.
aGA("Pitch", {syntax = bSyn("tide pitch $target $limb1 $limb2"), bal = bal(3.1), dmg = {eH = 5}, limbs = singleLimbDamage(7.8), encrust = true, rebounding = true});
aGA("Breach", {syntax = bSyn("tide breach $target"), affs = {"FALLEN"}, bal = bal(2.5),
    postEffects = function(attacker, target, data)
        target.defs.levitation = false;
        NU.clearFlag(target.name .. "_channeling");
    end, encrust = true, rebounding = true});
aGA("Wreck", {syntax = bSyn("tide wreck $target"), affs = {"collapsed_lung"}, bal = bal(4), dmg = {eH = 12}, limbs = singleLimbDamage(9.18, "torso"), reqs = function(attacker, target, data) return AB.genericRequirements(attacker, target, attacker.defs.encrusted and 1 or 2, false, true, false, false, false) and target.affs.PRONE; end});
aGA("Broadside", {syntax = bSyn("tide broadside $target"), bal = bal(3.5), encrust = true, rebounding = true});
aGA("Gybe", {syntax = bSyn("tide gybe $target"), bal = bal(3.5), dmg = {eH = 11}, limbs = singleLimbDamage(16.0, "head"),
    affs = function(attacker, target, data)
        local limb_aff = "head_bruised";
        local affs = {"amnesia"};
        if (target.affs[limb_aff .. "_critical"]) then
            table.insert(affs, "smashed_throat");
        end
        if (target.affs[limb_aff .. "_moderate"]) then
            table.insert(affs, "indifference");
        end
        if (target.affs[limb_aff]) then
            table.insert(affs, "whiplash");
        end
        return affs;
    end, encrust = true, rebounding = true});

-- TODO: Add keelhaul reqs here instead of in offense.
aGA("Keelhaul", {syntax = bSyn("tide keelhaul $target"), bal = bal(3), encrust = true, rebounding = false});
--aGA("", {syntax = bSyn(""), bal = bal(0), dmg = {eH = 0, eM = 0, sH = 0, sM = 0}, defs = {}, affs = {}, limbs = {targetable = true, damage = 12}, meetsPreReqs = nil, postEffects = nil});