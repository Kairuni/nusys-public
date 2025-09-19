local aGA = AB.addGenericAbility;

AB["Discipline"] = AB["Discipline"] or {};

aGA("Discipline", "Expel", {
    bal = {bal = "balance", cost = 3},
    -- TODO: Blood tracking for non-self?
    onUseEffects = function(stable, ttable, data) end,
    noShield = true, arms = 2, legs = 0,
    syntax = {akkari = "spirit expel", praenomen = "blood expel"}
})

aGA("Discipline", "Charnel", {
    syntax = {akkari = "spirit charnel", praenomen = "blood pervade"}
})

-- aGA("Discipline", "Recruit", {
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
--     syntax = {akkari = "spirit recruit", praenomen = "blood raise"}
-- })

-- aGA("Discipline", "Faith", {
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
--     syntax = {akkari = "spirit faith", praenomen = "blood wisp"}
-- })

aGA("Discipline", "Perceive", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 200},
    bal = {bal = "equilibrium", cost = 2},
    defs = {"perceive"},
    noShield = true, arms = 2, legs = 0, defensive = true,
    syntax = {akkari = "spirit perceive", praenomen = "blood track"}
})

aGA("Discipline", "Passion", {
    ep = 0, wp = 10,
    bal = {bal = "equilibrium", cost = 2},
    noShield = true, arms = 2, legs = 0,
    onUseEffects = function(st, tt) NU.setFlag(st.name .. "_passion", true, 600); end,
    defensive = true,
    syntax = {akkari = "spirit passion $weapon", praenomen = "blood thirst $weapon"}
})

-- aGA("Discipline", "Transpose", {
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
--     syntax = {akkari = "spirit transpose", praenomen = "blood regurgitate"}
-- })

aGA("Discipline", "Prism", {
    ep = 0, wp = 40,
    bal = {bal = "equilibrium", cost = 4},
    reboundable = nil, noShield = true, arms = 2, legs = 0,
    defensive = true,
    syntax = {akkari = "spirit prism", praenomen = "blood haze"}
})

aGA("Discipline", "Exsanguinate", {
    ep = 0, wp = 20,
    bal = {bal = "balance", cost = 2.0},
    affs = function(stable, ttable, data)
        return {"effused_blood"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reboundable = nil, noShield = nil, arms = 2, legs = 0,
    syntax = {akkari = "spirit exsanguinate $target", praenomen = "blood effusion $target"}
})

aGA("Discipline", "Assay", {
    ep = 0, wp = 20,
    bal = {bal = "balance", cost = 0},
    syntax = {akkari = "spirit assay $target", praenomen = "blood level $target"}
})

-- aGA("Discipline", "Revival", {
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
--     syntax = {akkari = "spirit revival", praenomen = "blood gift"}
-- })

aGA("Discipline", "Mask", {
    ep = 0, wp = 10,
    bal = {bal = "equilibrium", cost = 4},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    noShield = true, arms = 2, legs = 0,
    defensive = true,
    syntax = {akkari = "spirit mask", praenomen = "blood mask"}
})

aGA("Discipline", "Doctrine", {
    bal = {bal = "balance", cost = 0},
    noShield = true, arms = 2, legs = 0,
    defensive = true,
    syntax = {akkari = "spirit doctrine $empowerment", praenomen = "blood mutation $empowerment"}
})

-- aGA("Discipline", "Repent", {
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
--     syntax = {akkari = "spirit repent", praenomen = "blood pulse"}
-- })

aGA("Discipline", "Suppress", {
    ep = 0, wp = 50,
    bal = {bal = "equilibrium", cost = 2.0}, defs = {"suppressed"},
    noShield = true, arms = 2, legs = 2,
    defensive = true,
    syntax = {akkari = "spirit suppress", praenomen = "blood blur"}
})

aGA("Discipline", "Provoke", {
    ep = 0, wp = 10,
    bal = {bal = "equilibrium", cost = 2.7}, noShield = nil, arms = 2, legs = 0,
    syntax = {akkari = "spirit provoke $target", praenomen = "blood seethe $target"}
})

aGA("Discipline", "Light", {
    bal = {bal = "equilibrium", cost = 2},
    selfAffs = {}, limbs = nil, defs = {"holylight"},
    noShield = true, arms = 2, legs = 0, reqs = nil,
    defensive = true,
    syntax = {akkari = "spirit light on", praenomen = "blood trepidation on"}
})

aGA("Discipline", "Ascetic", {
    ep = 0, wp = 50,
    bal = {bal = "equilibrium", cost = 0}, defs = {"ascetic"},
    noShield = true, arms = 2, legs = 2,
    defensive = true,
    syntax = {akkari = "spirit ascetic", praenomen = "blood concentration"}
})

aGA("Discipline", "Retaliation", {
    ep = 0, wp = 50,
    bal = {bal = "equilibrium", cost = 2.0}, defs = {"retaliation"},
    noShield = true, arms = 2, legs = 2,
    defensive = true,
    syntax = {akkari = "spirit retaliation", praenomen = "blood shadow"}
})

-- aGA("Discipline", "Host", {
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
--     syntax = {akkari = "spirit host", praenomen = "blood path"}
-- })

-- aGA("Discipline", "Camaraderie", {
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
--     syntax = {akkari = "spirit camaraderie", praenomen = "blood affinity"}
-- })

aGA("Discipline", "Unbroken", {
    bal = {bal = "balance", cost = 0},
    defs = {"unbroken"},
    cooldown = 20, noShield = true, arms = 2, legs = 0,
    defensive = true,
    syntax = {akkari = "spirit unbroken", praenomen = "blood deluge"}
})


-- Can do this offbal
aGA("Discipline", "Attend", {
    ep = 0, wp = 12,
    bal = {bal = "balance", cost = 4},
    onUseEffects = function(st, tt, data)
        TRACK.stripDef(tt, "blindness");
        TRACK.stripDef(tt, "deafness");
    end, -- any effect when ab is used, even if unsuccessful
    -- 15s, but buffer.
    cooldown = 18,
    reboundable = nil, noShield = nil, arms = 2, legs = 0,
    syntax = {akkari = "spirit attend $target", praenomen = "blood spew $target"}
})

aGA("Discipline", "Transcend", {
    ep = 50, wp = 50,
    bal = {bal = "equilibrium", cost = 2},
    noShield = true, arms = 2, legs = 0,
    defensive = true,
    syntax = {akkari = "spirit transcend on", praenomen = "blood enrage on"}
})

aGA("Discipline", "Exorcism", {
    ep = 100, wp = 0,
    bal = {bal = "balance", cost = 4},
    onUseEffects = function(st, tt, data)
        NU.setFlag(tt.name .. "_exorcised", true, 30);
    end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {akkari = "spirit exorcise $target", praenomen = "blood dissolution $target"}
})

aGA("Discipline", "Pariah", {
    dmg = { eH = 0, eM = 0, sH = 0, sM = 300 },
    ep = 0,
    wp = 30,
    bal = { bal = "balance", cost = 3.00 },
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    selfAffs = {},
    limbs = nil,
    defs = {},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    postEffects = nil,                                 -- replace with a function that fires on ab success
    cooldown = nil,
    attackType = nil,
    reboundable = nil,
    noShield = nil,
    arms = 2,
    legs = 0,
    reqs = nil,
    syntax = { akkari = "spirit camaraderie", praenomen = "blood affinity" }
})

aGA("Discipline", "Anathema", {
    dmg = { eH = 0, eM = 0, sH = 0, sM = 0 },
    ep = 0,
    wp = 0,
    dmgType = "unblockable",
    bal = { bal = "balance", cost = 0 },
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    selfAffs = {},
    limbs = nil,
    defs = {},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    postEffects = nil,                                 -- replace with a function that fires on ab success
    cooldown = nil,
    attackType = nil,
    reboundable = nil,
    noShield = nil,
    arms = 2,
    legs = 0,
    reqs = nil,
    syntax = { akkari = "spirit camaraderie", praenomen = "blood affinity" }
})

aGA("Discipline", "Inquisition", {
    dmg = { eH = 0, eM = 0, sH = 0, sM = 0 },
    ep = 0,
    wp = 0,
    dmgType = "unblockable",
    bal = { bal = "balance", cost = 0 },
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    selfAffs = {},
    limbs = nil,
    defs = {},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    postEffects = nil,                                 -- replace with a function that fires on ab success
    cooldown = nil,
    attackType = nil,
    reboundable = nil,
    noShield = nil,
    arms = 2,
    legs = 0,
    reqs = nil,
    syntax = { akkari = "spirit camaraderie", praenomen = "blood affinity" }
})

-- aGA("Discipline", "", {
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
--     syntax = {akkari = "spirit camaraderie", praenomen = "blood affinity"}
-- })
-- aGA("Discipline", "", {
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
--     syntax = {akkari = "spirit camaraderie", praenomen = "blood affinity"}
-- })
-- aGA("Discipline", "", {
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
--     syntax = {akkari = "spirit camaraderie", praenomen = "blood affinity"}
-- })
-- aGA("Discipline", "", {
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
--     syntax = {akkari = "spirit camaraderie", praenomen = "blood affinity"}
-- })
-- aGA("Discipline", "", {
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
--     syntax = {akkari = "spirit camaraderie", praenomen = "blood affinity"}
-- })
-- aGA("Discipline", "", {
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
--     syntax = {akkari = "spirit camaraderie", praenomen = "blood affinity"}
-- })
-- aGA("Discipline", "", {
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
--     syntax = {akkari = "spirit camaraderie", praenomen = "blood affinity"}
-- })
-- aGA("Discipline", "", {
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
--     syntax = {akkari = "spirit camaraderie", praenomen = "blood affinity"}
-- })
-- aGA("Discipline", "", {
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
--     syntax = {akkari = "spirit camaraderie", praenomen = "blood affinity"}
-- })








-- aGA("Discipline", "Symbiosis", {
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
--     syntax = {akkari = "spirit symbiosis", praenomen = "blood "}
-- })

-- aGA("Discipline", "Enlist", {
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
--     syntax = {akkari = "spirit enlist", praenomen = "blood sire"}
-- })

-- aGA("Discipline", "Inspect", {
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
--     syntax = {akkari = "spirit inspect", praenomen = "blood glance"}
-- })

-- aGA("Discipline", "Convey", {
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
--     syntax = {akkari = "spirit convey", praenomen = "blood vision"}
-- })

-- aGA("Discipline", "Muster", {
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
--     syntax = {akkari = "spirit muster", praenomen = "blood beckon"}
-- })

-- aGA("Discipline", "Decree", {
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
--     syntax = {akkari = "spirit decree", praenomen = "blood will"}
-- })

-- aGA("Discipline", "Oneness", {
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
--     syntax = {akkari = "spirit oneness", praenomen = "blood tune"}
-- })

-- aGA("Discipline", "Oversight", {
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
--     syntax = {akkari = "spirit oversight", praenomen = "blood monitor"}
-- })

-- aGA("Discipline", "Rampart", {
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
--     syntax = {akkari = "spirit rampart", praenomen = "blood embrace"}
-- })

-- aGA("Discipline", "Enlighten", {
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
--     syntax = {akkari = "spirit enlighten", praenomen = "blood aegis"}
-- })

-- aGA("Discipline", "Deploy", {
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
--     syntax = {akkari = "spirit deploy", praenomen = "blood rile"}
-- })

-- aGA("Discipline", "Evangelism", {
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
--     syntax = {akkari = "spirit evangelism", praenomen = "blood invigorate"}
-- })
