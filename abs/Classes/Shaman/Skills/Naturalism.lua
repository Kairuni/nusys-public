local aGA = AB.addGenericAbility;

aGA("Naturalism", "Elevate", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 20,
    bal = {bal = "equilibrium", cost = 3},
    -- Change elevation to trees
    postEffects = nil, -- replace with a function that fires on ab success
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    syntax = {shaman = "nature elevate", alchemist = "botany lift"}
})

aGA("Naturalism", "Emergence", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 20,
    bal = {bal = "equilibrium", cost = 3},
    -- wipe out local domains, possibly delayed
    postEffects = nil, -- replace with a function that fires on ab success
    cooldown = nil, attackType = nil,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    syntax = {shaman = "nature emergence", alchemist = "botany diffuse"}
})

aGA("Naturalism", "Blending", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 0},
    selfAffs = {}, limbs = nil, defs = {"hiding"},
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    defensive = true,
    notarget = true,
    syntax = {shaman = "nature blending", alchemist = "botany camouflage"}
})

aGA("Naturalism", "Thorncoat", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3},
    selfAffs = {}, limbs = nil, defs = {"thorncoat"},
    cooldown = 20, attackType = nil,
    defensive = true,
    syntax = {shaman = "nature thorncoat $target", alchemist = "botany quills $target"}
})

-- add no paresis/paralysis to preReqs after pulling CD out.
aGA("Naturalism", "Panacea", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 50},
    ep = 0, wp = 20,
    bal = {bal = "equilibrium", cost = 3.0},
    cooldown = 20, reqs = nil,
    defensive = true,
    notarget = true,

    syntax = {shaman = "nature panacea", alchemist = "botany subversion"}
})

aGA("Naturalism", "Malevolence", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3.6},

    onUseEffects = function(stable, ttable, data)
        NU.setFlag(stable.name .. "_malevolence_target", ttable.name, 600);
    end,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {shaman = "nature malevolence $target", alchemist = "botany pheromones $target"}
})






aGA("Naturalism", "Overgrowth", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 4.5},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    cooldown = nil, attackType = nil,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    syntax = {shaman = "nature overgrowth", alchemist = "botany blight"}
})

aGA("Naturalism", "Release", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2.3},
    -- Domain functions
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    syntax = {shaman = "nature release", alchemist = "botany recede"}
})

aGA("Naturalism", "ReleaseHere", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2.3},
    -- Domain functions
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    syntax = {shaman = "nature release here", alchemist = "botany recede here"}
})

aGA("Naturalism", "Trespassers", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 0},
    cooldown = nil, attackType = nil,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    syntax = {shaman = "nature trespassers", alchemist = "botany "}
})

aGA("Naturalism", "Canopy", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3.6},
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    syntax = {shaman = "nature canopy", alchemist = "botany containment"}
})

aGA("Naturalism", "Roots", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3.2},
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    defs = {"overgrowth_roots"},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    defensive = true,
    notarget = true,
    syntax = {shaman = "nature roots", alchemist = "botany clutching"}
})

aGA("Naturalism", "Screen", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3.6},
    -- TODO: Domain effects.
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    syntax = {shaman = "nature screen", alchemist = "botany frequencies"}
})

aGA("Naturalism", "Thornwall", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3.5},
    -- TODO: Domain effects
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    syntax = {shaman = "nature thornwall", alchemist = "botany bloodsap"}
})

aGA("Naturalism", "Whispers", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2.4}, defs = {"whispers"},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    syntax = {shaman = "nature whispers on", alchemist = "botany distractions on"}
})

aGA("Naturalism", "Flow", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3},
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {shaman = "nature flow", alchemist = "botany wander"}
})

aGA("Naturalism", "Pulling", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3},
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {shaman = "nature pull $target", alchemist = "botany allure $target"}
})

aGA("Naturalism", "Hinder", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2.8},
    -- TODO: Domain effects
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    syntax = {shaman = "nature hinder", alchemist = "botany curtail"}
})

aGA("Naturalism", "Animation", {
    dmg = {eH = 6, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    dmgType = "cutting",
    bal = {bal = "balance", cost = 3.2},
    -- TODO: Only use in domain
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {shaman = "nature animation", alchemist = "botany fronds"}
})

aGA("Naturalism", "Surge", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "balance", cost = 3.6},
    -- TODO: Domain expansion
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {shaman = "nature surge $target", alchemist = "botany propagate $target"}
})

aGA("Naturalism", "Renewal", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3.6},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    defensive = true,
    syntax = {shaman = "nature renewal", alchemist = "botany medicinal"}
})

aGA("Naturalism", "Displacement", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3.4},
    -- TODO: Domain effects
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {shaman = "nature displacement $target", alchemist = "botany perspective $target"}
})

aGA("Naturalism", "Consumption", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 0},
    -- TODO: Domain effects
    onUseEffects = function(stable, ttable, data)
        NU.clearFlag("overgrowth_active");
    end, -- any effect when ab is used, even if unsuccessful
    cooldown = 30,

    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {shaman = "nature consumption", alchemist = "botany decompose"}
})

aGA("Naturalism", "Barrier", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 4},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful

    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {shaman = "nature barrier $target", alchemist = "botany envelop $target"}
})

aGA("Naturalism", "Greenfoot", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3},
    defs = {"greenfoot"},
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {shaman = "nature greenfoot on", alchemist = "botany blightbringer on"}
})


-- GROVE ABS IGNORE THESE FOR NOW
aGA("Naturalism", "Imprint", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    dmgType = "unblockable",
    bal = {bal = "balance", cost = 0},
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    selfAffs = {}, limbs = nil, defs = {},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful

    cooldown = nil, attackType = nil,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {shaman = "grove imprint", alchemist = "botany claim"}
})

aGA("Naturalism", "Sever", {
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
    syntax = {shaman = "nature sever", alchemist = "botany dismantle"}
})

aGA("Naturalism", "Look", {
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
    syntax = {shaman = "nature look", alchemist = "botany surveil"}
})

aGA("Naturalism", "Cage", {
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
    syntax = {shaman = "nature cage", alchemist = "botany barricade"}
})

aGA("Naturalism", "Whisper", {
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
    syntax = {shaman = "nature whisper", alchemist = "botany dictation"}
})

aGA("Naturalism", "Eyes", {
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
    syntax = {shaman = "nature eyes", alchemist = "botany reconnaissance"}
})

aGA("Naturalism", "Fertility", {
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
    syntax = {shaman = "nature fertility", alchemist = "botany specimen"}
})

aGA("Naturalism", "Return", {
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
    syntax = {shaman = "nature return", alchemist = "botany withdraw"}
})

aGA("Naturalism", "Everbloom", {
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
    syntax = {shaman = "nature everbloom", alchemist = "botany fecundity"}
})

aGA("Naturalism", "GroveFlow", {
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
    syntax = {shaman = "nature groveflow", alchemist = "botany consultation"}
})

aGA("Naturalism", "Linking", {
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
    syntax = {shaman = "nature linking", alchemist = "botany collaboration"}
})

aGA("Naturalism", "Annihilation", {
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
    syntax = {shaman = "nature annihilation", alchemist = "botany selfdestruct"}
})
