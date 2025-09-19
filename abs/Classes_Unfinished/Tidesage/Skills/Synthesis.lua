local aGA = AB.addGenericAbility;

aGA("Synthesis", "Synthesise", {
    postEffects = function(st, _, _) end,
    reboundable = false, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "synth synthesise", Terradrim = "golem animate"}
});

aGA("Synthesis", "Call", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "synth call", Terradrim = "golem instruct"}
});

aGA("Synthesis", "Enhancements", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    dmgType = "unblockable",
    bal = {bal = "balance", cost = 0},
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    selfAffs = {}, limbs = nil, defs = {},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    postEffects = nil, -- replace with a function that fires on ab success
    cooldown = nil, attackType = nil,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "synth enhancements", Terradrim = "golem imprinting"}
});

aGA("Synthesis", "Escape", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    dmgType = "unblockable",
    bal = {bal = "balance", cost = 0},
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    selfAffs = {}, limbs = nil, defs = {},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    postEffects = nil, -- replace with a function that fires on ab success
    cooldown = nil, attackType = nil,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "synth escape", Terradrim = "golem escape"}
});

aGA("Synthesis", "Designate", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 1},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "synth designate $ability", Terradrim = "golem priority $ability"}
});

aGA("Synthesis", "Recuperate", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2.33},
    onUseEffects = function(stable, ttable, data) end,
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "synth recuperate", Terradrim = "golem recover"}
});

aGA("Synthesis", "Modes", {
    ep = 0, wp = 0,
    bal = {bal = "balance", cost = 0},
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "synth modes $mode", Terradrim = "golem memory $mode"}
});

aGA("Synthesis", "Lifebond", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 1.7},
    defs = {"lifebond"},
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "synth lifebond on", Terradrim = "golem twinsoul on"}
});

aGA("Synthesis", "Club", {
    dmg = {eH = 5, eM = 0, sH = 0, sM = 0},
    dmgType = "blunt",
});

aGA("Synthesis", "Trammel", {
    dmg = {eH = 5, eM = 0, sH = 0, sM = 0},
    dmgType = "blunt",
    affs = function(stable, ttable, data)
        return {"arrhythmia", "stun"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,

    onUseEffects = function(st, tt, data) NU.setFlag(tt.name .. "_stun_remove", true, 1, function() tt.affs.stun = false; end); end,

    reqs = function(_, ttable, _) return ttable.affs.torso_bruised; end,
});

aGA("Synthesis", "Squeeze", {
    dmg = {eH = 5, eM = 0, sH = 0, sM = 0},
    dmgType = "blunt",
    affs = function(_, _, data)
        local affs = {};
        if (data.empowerments and data.empowerments[1] ~= "torso") then
            table.insert(affs, data.empowerments[1]:gsub(" ", "_") .. "_crippled");
        end
        return affs, {"left_arm_crippled", "right_arm_crippled", "left_leg_crippled", "right_leg_crippled"}, 1; -- Visible, hidden possibilities, hidden count
    end,
    -- TODO: Verify how much damage this actually does.
    limbs = function(_, _, data)
        if (data.empowerments and data.empowerments[1] == "torso") then
            return {torso = 33.5};
        else
            return nil;
        end
    end,
    reqs = function(_, ttable, _) return ttable.affs.PRONE; end,
});

aGA("Synthesis", "Chime", {
    dmg = {eH = 5, eM = 0, sH = 0, sM = 0},
    dmgType = "blunt",
    affs = function(stable, ttable, data)
        return {"paresis", "arrhythmia"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reqs = function(_, ttable, _) return ttable.affs.torso_mangled; end,
});

aGA("Synthesis", "Concuss", {
    dmg = {eH = 5, eM = 0, sH = 0, sM = 0},
    dmgType = "blunt",
    affs = function(stable, ttable, data)
        return {"blurry_vision"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reqs = function(_, ttable, _) return ttable.affs.head_broken; end,
});

aGA("Synthesis", "Nullify", {
    onUseEffects = function(stable, ttable, data) ttable.defs.shielded = true; end,
});

aGA("Synthesis", "Clutch", {
    affs = function(stable, ttable, data)
        return {"writhe_grappled"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reqs = function(_, ttable, _) return ttable.affs.PRONE and ttable.affs.torso_broken; end,
});

aGA("Synthesis", "Pound", {
    dmg = {eH = 5, eM = 0, sH = 0, sM = 0},
    dmgType = "blunt",
    affs = function(stable, ttable, data)
        return {"stun"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = function(st, tt, data) NU.setFlag(tt.name .. "_stun_remove", true, 1, function() tt.affs.stun = false; end); end,
    reqs = function(_, ttable, _) return ttable.vitals.hp / ttable.vitals.maxhp <= 0.8; end,
});

-- TODO: Some mechanism to remove blackout after it's triggered.
aGA("Synthesis", "Strangulate", {
    dmg = {eH = 5, eM = 0, sH = 0, sM = 0},
    dmgType = "blunt",
    affs = function(_, _, _)
        return {"blackout"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = function(_, _, _) NU.cooldown("golem_strangulate", 30); end,
    reqs = function(_, ttable, _) return ttable.affs.PRONE and ttable.affs.head_bruised_moderate and NU.offCD("golem_strangulate"); end
});

aGA("Synthesis", "Deconstruct", {
    dmg = {eH = 5, eM = 0, sH = 0, sM = 0},
    dmgType = "blunt",
    affs = function(stable, ttable, data)
        for _, limb in ipairs(data.empowerments) do
            return limb:gsub(" ", "_") .. "_dislocated";
        end
    end,
    reqs = function(_, ttable, _)
        local llimb = FLAGS.last_limb_hit;
        if (llimb) then
            return ttable.affs[llimb .. "_bruised_moderate"];
        end
        return false;
    end
});

aGA("Synthesis", "Detain", {
    dmg = {eH = 5, eM = 0, sH = 0, sM = 0},
    dmgType = "blunt",
    onUseEffects = function(stable, ttable, data) ttable.defs.levitation = false; end,
});

aGA("Synthesis", "Enclose", {
    dmg = {eH = 5, eM = 0, sH = 0, sM = 0},
    dmgType = "blunt",
});
