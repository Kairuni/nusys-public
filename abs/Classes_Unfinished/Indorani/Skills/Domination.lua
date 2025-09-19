AB["Domination"] = AB["Domination"] or {};

local aGA = AB.addGenericAbility;

aGA("Domination", "Dominate", {
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
    syntax = {indorani = "summon dominate", oneiromancer = "entreat address"}
})

aGA("Domination", "Pact", {
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
    syntax = {indorani = "summon pact", oneiromancer = "entreat contracts"}
})

aGA("Domination", "Control", {
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
    syntax = {indorani = "summon control", oneiromancer = "entreat sovereignty"}
})

aGA("Domination", "Transcendence", {
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
    syntax = {indorani = "summon transcendence", oneiromancer = "entreat corridor"}
})

aGA("Domination", "Mask", {
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
    syntax = {indorani = "summon mask", oneiromancer = "entreat tiptoe"}
})

aGA("Domination", "Link", {
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
    syntax = {indorani = "summon link", oneiromancer = "entreat cord"}
})

aGA("Domination", "Dervish", {
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
    syntax = {indorani = "summon dervish", oneiromancer = "entreat sylphid"}
})

aGA("Domination", "Sycophant", {
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
    syntax = {indorani = "summon sycophant", oneiromancer = "entreat lamia"}
})

aGA("Domination", "Gremlin", {
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
    syntax = {indorani = "summon gremlin", oneiromancer = "entreat faunapod"}
})

aGA("Domination", "ChaosOrb", {
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
    syntax = {indorani = "summon chaosorb", oneiromancer = "entreat sphere"}
})

aGA("Domination", "Bloodleech", {
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
    syntax = {indorani = "summon bloodleech", oneiromancer = "entreat helminth"}
})

aGA("Domination", "Firelord", {
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
    syntax = {indorani = "summon firelord", oneiromancer = "entreat hippalectryon"}
})

aGA("Domination", "Minion", {
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
    syntax = {indorani = "summon minion", oneiromancer = "entreat sentinel"}
})

aGA("Domination", "Worm", {
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
    syntax = {indorani = "summon worm", oneiromancer = "entreat eye"}
})

aGA("Domination", "Slime", {
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
    syntax = {indorani = "summon slime", oneiromancer = "entreat blob"}
})

aGA("Domination", "Pathfinder", {
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
    syntax = {indorani = "summon pathfinder", oneiromancer = "entreat tegalid"}
})

aGA("Domination", "Soulmaster", {
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
    syntax = {indorani = "summon soulmaster", oneiromancer = "entreat puppeteer"}
})

aGA("Domination", "Humbug", {
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
    syntax = {indorani = "summon humbug", oneiromancer = "entreat snaretongue"}
})

aGA("Domination", "Chimera", {
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
    syntax = {indorani = "summon chimera", oneiromancer = "entreat quetzal"}
})

aGA("Domination", "Bubonis", {
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
    syntax = {indorani = "summon bubonis", oneiromancer = "entreat mocker"}
})

aGA("Domination", "Doppleganger", {
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
    syntax = {indorani = "summon doppleganger", oneiromancer = "entreat mirrormask"}
})

aGA("Domination", "Storm", {
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
    syntax = {indorani = "summon storm", oneiromancer = "entreat huntress"}
})

aGA("Domination", "Gatekeeper", {
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
    syntax = {indorani = "summon gatekeeper", oneiromancer = "entreat bridge"}
})

aGA("Domination", "Hound", {
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
    syntax = {indorani = "summon hound", oneiromancer = "entreat cerberus"}
})

aGA("Domination", "Crone", {
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
    syntax = {indorani = "summon crone", oneiromancer = "entreat moth"}
})

aGA("Domination", "Pit", {
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
    syntax = {indorani = "summon pit", oneiromancer = "entreat maw"}
})