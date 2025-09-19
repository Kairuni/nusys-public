local aGA = AB.addGenericAbility;

aGA("Bladefire", "Empower", {
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
    syntax = {templar = "blade release empower", revenant = "blade scribe actuate"}
})

aGA("Bladefire", "Cleanse", {
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
    syntax = {templar = "blade release cleanse", revenant = "blade scribe annul"}
})

aGA("Bladefire", "Charging", {
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
    syntax = {templar = "blade release charging", revenant = "blade scribe reaping"}
})

aGA("Bladefire", "Crescent", {
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
    syntax = {templar = "blade release crescent", revenant = "blade scribe lawid"}
})

aGA("Bladefire", "Blastwave", {
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
    syntax = {templar = "blade release blastwave", revenant = "blade scribe owinta"}
})

aGA("Bladefire", "Iceblast", {
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
    syntax = {templar = "blade release iceblast", revenant = "blade scribe telvi"}
})

aGA("Bladefire", "Waterflow", {
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
    syntax = {templar = "blade release waterflow", revenant = "blade scribe iyedlo"}
})

aGA("Bladefire", "Lightning", {
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
    syntax = {templar = "blade release lightning", revenant = "blade scribe aneda"}
})

aGA("Bladefire", "Retribution", {
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
    syntax = {templar = "blade release retribution", revenant = "blade scribe cull"}
})

aGA("Bladefire", "Vorpal", {
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
    syntax = {templar = "blade release vorpal", revenant = "blade scribe atdum"}
})

aGA("Bladefire", "Penance", {
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
    syntax = {templar = "blade release penance", revenant = "blade scribe lurk"}
})

aGA("Bladefire", "Bladefury", {
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
    syntax = {templar = "blade release bladefury", revenant = "blade scribe ingather"}
})

aGA("Bladefire", "Sacrifice", {
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
    syntax = {templar = "blade release sacrifice", revenant = "blade scribe duskosa"}
})

aGA("Bladefire", "Torch", {
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
    syntax = {templar = "blade release torch", revenant = "blade scribe nalay"}
})

aGA("Bladefire", "Conviction", {
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
    syntax = {templar = "blade release conviction", revenant = "blade scribe bimre"}
})

aGA("Bladefire", "Disrupt", {
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
    syntax = {templar = "blade release disrupt", revenant = "blade scribe dirne"}
})

aGA("Bladefire", "Cripple", {
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
    syntax = {templar = "blade release cripple", revenant = "blade scribe azu"}
})

aGA("Bladefire", "Flare", {
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
    syntax = {templar = "blade release flare", revenant = "blade scribe livfa"}
})

aGA("Bladefire", "Trauma", {
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
    syntax = {templar = "blade release trauma", revenant = "blade scribe lura"}
})

aGA("Bladefire", "Numbing", {
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
    syntax = {templar = "blade release numbing", revenant = "blade scribe baludu"}
})

aGA("Bladefire", "Combustion", {
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
    syntax = {templar = "blade release combustion", revenant = "blade scribe nipdo"}
})

aGA("Bladefire", "Resonance", {
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
    syntax = {templar = "blade release resonance", revenant = "blade scribe doyfo"}
})

aGA("Bladefire", "Burst", {
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
    syntax = {templar = "blade release burst", revenant = "blade scribe atele"}
})

aGA("Bladefire", "Stun", {
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
    syntax = {templar = "blade release stun", revenant = "blade scribe adil"}
})

aGA("Bladefire", "Blaze", {
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
    syntax = {templar = "blade release blaze", revenant = "blade scribe wasi"}
})

aGA("Bladefire", "Destruction", {
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
    syntax = {templar = "blade release destruction", revenant = "blade scribe vusbadu"}
})

aGA("Bladefire", "Hemorrhage", {
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
    syntax = {templar = "blade release hemorrhage", revenant = "blade scribe wilave"}
})