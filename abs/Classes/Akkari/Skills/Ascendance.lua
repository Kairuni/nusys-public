-- *** Rijetta: ASCENDANCE - REKINDLE (right leg) *** UNTRACKED
-- Cures leg by 15%

local aGA = AB.addGenericAbility;

AB["Ascendance"] = AB["Ascendance"] or {};

aGA("Ascendance", "Deliver", {
    dmg = {eH = .15, eM = 0, sH = 0, sM = 0},
    ep = 50, wp = 0,
    dmgType = "cutting",
    bal = {bal = "balance", cost = 3.0},
    -- TODO: Target blood tracking? 11%ish
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reqs = function(at, tt, data) return AB.genericRequirements(at, tt, 2, false, nil, false, false, nil, 0) and (tt.affs.PRONE or tt.affs.paresis or tt.affs.paralysis) and not tt.defs.fangbarrier; end,
    syntax = {akkari = "deliver $target", praenomen = "feed $target"}
})

aGA("Ascendance", "Denounce", {
    dmg = function(st, tt, data)
        return tt.defs.shielded and 0 or 0.2, 0, 0, 0;
    end,
    ep = 30, wp = 0,
    dmgType = "blunt",
    bal = {bal = "balance", cost = 2.7}, arms = 2, legs = 0,
    onUseEffects = function(stable, ttable, data)
        TRACK.stripDef(ttable, "shielded");
    end, -- any effect when ab is used, even if unsuccessful
    syntax = {akkari = "denounce $target $empowerment", praenomen = "frenzy $target $empowerment"}
})

aGA("Ascendance", "Ague", {
    ep = 5, wp = 0,
    bal = {bal = "balance", cost = 2.0},
    affs = function(stable, ttable, data)
        return {AB.freezeStack(ttable, 1)}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {akkari = "ague", praenomen = "chill"}
})

aGA("Ascendance", "Transience", {
    ep = 0, wp = 0,
    bal = {bal = "balance", cost = 3.0}, defs = {"transience"},
    noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {akkari = "transience", praenomen = "elusion"}
})

aGA("Ascendance", "Impersonate", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2.0}, defs = {"impersonate"},
    noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {akkari = "impersonate", praenomen = "masquerade"}
})

-- aGA("Ascendance", "Symayda", {
--     dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
--     ep = 0, wp = 0,
--     dmgType = "unblockable",
--     bal = {bal = "balance", cost = 0},
--     affs = function(stable, ttable, data)
--         return {}, {}, 0; -- Visible, hidden possibilities, hidden count
--     end,
--     selfAffs = {}, limbs = nil, defs = {},
--     onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
--     postEffects = nil, -- replace with a function that fires on ab success
--     cooldown = nil, attackType = nil,
--     reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
--     syntax = {akkari = "symayda", praenomen = "wolfform"}
-- })

-- aGA("Ascendance", "Muffle", {
--     dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
--     ep = 0, wp = 0,
--     dmgType = "unblockable",
--     bal = {bal = "balance", cost = 0},
--     affs = function(stable, ttable, data)
--         return {}, {}, 0; -- Visible, hidden possibilities, hidden count
--     end,
--     selfAffs = {}, limbs = nil, defs = {},
--     onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
--     postEffects = nil, -- replace with a function that fires on ab success
--     cooldown = nil, attackType = nil,
--     reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
--     syntax = {akkari = "muffle", praenomen = "stalking"}
-- })

aGA("Ascendance", "Penitence", {
    ep = 50, wp = 100,
    bal = {bal = "balance", cost = 2.5},
    affs = function(stable, ttable, data)
        return {"slickness"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    arms = 2, legs = 0,
    syntax = {akkari = "penitence $target", praenomen = "deadbreath $target"}
})

aGA("Ascendance", "Catching", {
    ep = 100, wp = 0,
    bal = {bal = "balance", cost = 3.0}, defs = {"arrow_catching"},
    noShield = true, arms = 2, legs = 2,
    defensive = true,
    syntax = {akkari = "catching", praenomen = "catching"}
})

aGA("Ascendance", "Bloodlet", {
    dmg = {eH = .12, eM = 0, sH = 0, sM = 0},
    ep = 10, wp = 0,
    dmgType = "cutting",
    bal = {bal = "balance", cost = 3.6},
    affs = function(stable, ttable, data)
        return {"rend"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    arms = 2, legs = 0,
    syntax = {akkari = "bloodlet $target", praenomen = "clawing $target"}
})

aGA("Ascendance", "Relentless", {
    ep = 10, wp = 0,
    bal = {bal = "balance", cost = 2.0}, defs = {"relentless"},
    noShield = true, arms = 2, legs = 2,
    defensive = true,
    syntax = {akkari = "relentless on", praenomen = "fortify on"}
})

-- aGA("Ascendance", "Hyriamah", {
--     dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
--     ep = 0, wp = 0,
--     dmgType = "unblockable",
--     bal = {bal = "balance", cost = 0},
--     affs = function(stable, ttable, data)
--         return {}, {}, 0; -- Visible, hidden possibilities, hidden count
--     end,
--     selfAffs = {}, limbs = nil, defs = {},
--     onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
--     postEffects = nil, -- replace with a function that fires on ab success
--     cooldown = nil, attackType = nil,
--     reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
--     syntax = {akkari = "hyriamah", praenomen = "batform"}
-- })

aGA("Ascendance", "Celerity", {
    ep = 0, wp = 0,
    bal = {bal = "balance", cost = 2.0}, defs = {"celerity"},
    noShield = true, arms = 2, legs = 2,
    defensive = true,
    syntax = {akkari = "celerity", praenomen = "celerity"}
})

-- aGA("Ascendance", "Block", {
--     dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
--     ep = 0, wp = 0,
--     dmgType = "unblockable",
--     bal = {bal = "balance", cost = 0},
--     affs = function(stable, ttable, data)
--         return {}, {}, 0; -- Visible, hidden possibilities, hidden count
--     end,
--     selfAffs = {}, limbs = nil, defs = {},
--     onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
--     postEffects = nil, -- replace with a function that fires on ab success
--     cooldown = nil, attackType = nil,
--     reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
--     syntax = {akkari = "block $direction", praenomen = "block $direction"}
-- })

-- aGA("Ascendance", "Quell", {
--     dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
--     ep = 0, wp = 0,
--     dmgType = "unblockable",
--     bal = {bal = "balance", cost = 0},
--     affs = function(stable, ttable, data)
--         return {}, {}, 0; -- Visible, hidden possibilities, hidden count
--     end,
--     selfAffs = {}, limbs = nil, defs = {},
--     onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
--     postEffects = nil, -- replace with a function that fires on ab success
--     cooldown = nil, attackType = nil,
--     reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
--     syntax = {akkari = "quell", praenomen = "sunder"}
-- })

-- aGA("Ascendance", "Dissipate", {
--     dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
--     ep = 0, wp = 0,
--     dmgType = "unblockable",
--     bal = {bal = "balance", cost = 0},
--     affs = function(stable, ttable, data)
--         return {}, {}, 0; -- Visible, hidden possibilities, hidden count
--     end,
--     selfAffs = {}, limbs = nil, defs = {},
--     onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
--     postEffects = nil, -- replace with a function that fires on ab success
--     cooldown = nil, attackType = nil,
--     reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
--     syntax = {akkari = "dissipate", praenomen = "mistform"}
-- })

aGA("Ascendance", "Vivify", {
    ep = 10, wp = 0,
    bal = {bal = "equilibrium", cost = 1},
    noShield = true, arms = 2, legs = 0,
    cooldown = 25,
    defensive = true,
    syntax = {akkari = "vivify", praenomen = "mending"}
})

aGA("Ascendance", "Acuity", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 1.0}, defs = {"acuity"},
    noShield = true, arms = 2, legs = 2,
    defensive = true,
    syntax = {akkari = "acuity on", praenomen = "acuity on"}
})

aGA("Ascendance", "Resolve", {
    ep = 0, wp = 10,
    bal = {bal = "equilibrium", cost = 1.0},
    defs = {"resolved"}, noShield = true, arms = 2, legs = 2,
    defensive = true,
    syntax = {akkari = "resolve on", praenomen = "warding on"}
})

-- aGA("Ascendance", "Dim", {
--     dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
--     ep = 0, wp = 0,
--     dmgType = "unblockable",
--     bal = {bal = "balance", cost = 0},
--     affs = function(stable, ttable, data)
--         return {}, {}, 0; -- Visible, hidden possibilities, hidden count
--     end,
--     selfAffs = {}, limbs = nil, defs = {},
--     onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
--     postEffects = nil, -- replace with a function that fires on ab success
--     cooldown = nil, attackType = nil,
--     reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
--     syntax = {akkari = "dim", praenomen = "veil"}
-- })

-- aGA("Ascendance", "Envenom", {
--     dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
--     ep = 0, wp = 0,
--     dmgType = "unblockable",
--     bal = {bal = "balance", cost = 0},
--     affs = function(stable, ttable, data)
--         return {}, {}, 0; -- Visible, hidden possibilities, hidden count
--     end,
--     selfAffs = {}, limbs = nil, defs = {},
--     onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
--     postEffects = nil, -- replace with a function that fires on ab success
--     cooldown = nil, attackType = nil,
--     reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
--     syntax = {akkari = "envenom", praenomen = "envenom"}
-- })

aGA("Ascendance", "Censure", {
    dmg = {eH = .2, eM = 0, sH = 0, sM = 0},
    ep = 40, wp = 0,
    dmgType = "cutting",
    bal = {bal = "balance", cost = 2.9},
    reboundable = true, noShield = nil, arms = 2, legs = 0,
    syntax = {akkari = "censure $target $venom", praenomen = "gash $target $venom"}
})

aGA("Ascendance", "Censure_Light", {
    dmg = {eH = .07, eM = 0, sH = 0, sM = 0},
    ep = 40, wp = 0,
    dmgType = "cutting",
    bal = {bal = "balance", cost = 2.35},
    reboundable = true, noShield = nil, arms = 2, legs = 0,
    syntax = {akkari = "censure $target lenient $venom", praenomen = "gash $target lightly $venom"}
})

aGA("Ascendance", "Crusade", {
    ep = 100, wp = 0,
    bal = {bal = "balance", cost = 3.5},
    reqs = function(st, tt)
        return st.vitals.mounted ~= "0" and
            AB.genericRequirements(st, tt, 1, false, nil, false, false, st.name .. "_Ascendance_Crusade", 0);
    end,
    cooldown = 30,
    syntax = {akkari = "crusade $target", praenomen = "fling $target"}
})

-- aGA("Ascendance", "Bunker", {
--     dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
--     ep = 0, wp = 0,
--     dmgType = "unblockable",
--     bal = {bal = "balance", cost = 0},
--     affs = function(stable, ttable, data)
--         return {}, {}, 0; -- Visible, hidden possibilities, hidden count
--     end,
--     selfAffs = {}, limbs = nil, defs = {},
--     onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
--     postEffects = nil, -- replace with a function that fires on ab success
--     cooldown = nil, attackType = nil,
--     reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
--     syntax = {akkari = "bunker", praenomen = "entomb"}
-- })

-- aGA("Ascendance", "Entrench", {
--     dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
--     ep = 0, wp = 0,
--     dmgType = "unblockable",
--     bal = {bal = "balance", cost = 0},
--     affs = function(stable, ttable, data)
--         return {}, {}, 0; -- Visible, hidden possibilities, hidden count
--     end,
--     selfAffs = {}, limbs = nil, defs = {},
--     onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
--     postEffects = nil, -- replace with a function that fires on ab success
--     cooldown = nil, attackType = nil,
--     reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
--     syntax = {akkari = "entrench", praenomen = "deathlink"}
-- })

aGA("Ascendance", "Ardour", {
    bal = {bal = "balance", cost = 2},
    -- TODO: def - ardour_stat, but not sure how to handle this right now.
    defs = function(st, tt, data)
        return {"ardour_" .. data.empowerments[1]}
    end,
    noShield = true, arms = 2, legs = 2,
    defensive = true,
    syntax = {akkari = "ardour $stat", praenomen = "potence $stat"}
})

-- aGA("Ascendance", "Intuition", {
--     dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
--     ep = 0, wp = 0,
--     dmgType = "unblockable",
--     bal = {bal = "balance", cost = 0},
--     affs = function(stable, ttable, data)
--         return {}, {}, 0; -- Visible, hidden possibilities, hidden count
--     end,
--     selfAffs = {}, limbs = nil, defs = {},
--     onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
--     postEffects = nil, -- replace with a function that fires on ab success
--     cooldown = nil, attackType = nil,
--     reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
--     syntax = {akkari = "intuition", praenomen = ""}
-- })

aGA("Ascendance", "Disengage", {
    ep = 0, wp = 0,
    bal = {bal = "balance", cost = 2.0},
    noShield = true, arms = 2, legs = 0, reqs = nil,
    defensive = true,
    syntax = {akkari = "disengage $direction", praenomen = "fade $direction"}
})

aGA("Ascendance", "Rekindle", {
    ep = 0, wp = 300,
    bal = {bal = "equilibrium", cost = 3},
    cooldown = 50, attackType = nil,
    reboundable = nil, noShield = true, arms = 0, legs = 0, reqs = nil,
    defensive = true,
    syntax = {akkari = "rekindle $limb", praenomen = "reconstruct $limb"}
})

aGA("Ascendance", "Succour", {
    ep = 10, wp = 20,
    bal = {bal = "equilibrium", cost = 3},
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = function(st, tt) return true; end,
    syntax = {akkari = "succour", praenomen = "purify"}
})
