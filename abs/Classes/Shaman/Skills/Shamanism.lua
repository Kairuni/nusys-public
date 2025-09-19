local aGA = AB.addGenericAbility;

local function shamanismRequirements(noShield, cooldown, extraChecks)
    return function(attacker, target, data)
        return (extraChecks and extraChecks(attacker, target, data) or true) and AB.genericRequirements(attacker, target, 1, false, false, false, noShield, cooldown and (attacker.name .. "_" .. cooldown) or nil, 0);
    end
end

aGA("Shamanism", "Bonecasting", {
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
    syntax = {shaman = "shaman bonecasting", alchemist = "experiment extispicy"}
})

aGA("Shamanism", "Harrowing", {
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
    syntax = {shaman = "shaman harrowing", alchemist = "experiment ignition"}
})

aGA("Shamanism", "Protection", {
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
    syntax = {shaman = "shaman protection", alchemist = "experiment obfuscation"}
})

aGA("Shamanism", "Exorcise", {
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
    syntax = {shaman = "shaman exorcise", alchemist = "experiment dissolution"}
})

aGA("Shamanism", "Spiritmask", {
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
    syntax = {shaman = "shaman spiritmask", alchemist = "experiment gasmask"}
})

aGA("Shamanism", "Warding", {
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
    syntax = {shaman = "shaman warding", alchemist = "experiment crutch"}
})

aGA("Shamanism", "Divination", {
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
    syntax = {shaman = "shaman divination", alchemist = "experiment cognisance"}
})

aGA("Shamanism", "Spiritsight", {
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
    syntax = {shaman = "shaman spiritsight on", alchemist = "experiment prognosis on"}
})

aGA("Shamanism", "Oaths", {
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
    syntax = {shaman = "oath $oath activate", alchemist = "discipline $oath activate"}
})

aGA("Shamanism", "Premonition", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 50},
    ep = 0, wp = 35,
    bal = {bal = "equilibrium", cost = 2},
    affs = function(stable, ttable, data)
        return {"dread"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reqs = shamanismRequirements(),
    syntax = {shaman = "shaman premonition $target", alchemist = "experiment hallucinogen $target"}
})

aGA("Shamanism", "Songlines", {
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
    syntax = {shaman = "shaman songlines", alchemist = "experiment expeditions"}
})

aGA("Shamanism", "Lifevision", {
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
    syntax = {shaman = "shaman lifevision", alchemist = "experiment lifevision"}
})

aGA("Shamanism", "Voyage", {
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
    syntax = {shaman = "shaman voyage", alchemist = "experiment delegation"}
})

aGA("Shamanism", "Divulgence", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 76},
    ep = 0, wp = 15,
    -- 2.3 -> 2.2 -> 2.1
    -- TODO: function to handle this getting faster.
    bal = {bal = "equilibrium", cost = 2.3},
    reqs = shamanismRequirements(nil, nil, function(st, tt, data) return TRACK.countAffsByList(tt, AFFS.mentals) >= 3; end),
    syntax = {shaman = "shaman divulgence $target $phobia", alchemist = "experiment "}
})

local omenAffs = {
    "paranoia",
    "infestation",
    "blight",
    "stormtouched"
}

aGA("Shamanism", "Omen", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3},
    reqs = shamanismRequirements(false, nil, function(st, tt, data) return TRACK.countAffsByList(tt, omenAffs) >= 1; end),
    postEffects = function(st, tt, data)
        local count = TRACK.countAffsByList(tt, omenAffs);
        NU.setFlag(tt.name .. "_omen_count", count, 14,
            function() local omenCount = FLAGS[tt.name .. "_omen_count"];
                if (omenCount) then
                    TRACK.abilityDamage(tt, 0, 13 * omenCount, 1.0, 1.0, "unblockable", "Shamanism", "Omen");
                end
            end);
        if (count == 4) then
            echo("\n");
            NU.ECHO("GLORIOUS 6 SECOND OMEN");
        elseif (count == 3) then
            echo("\n");
            NU.ECHO("PREDICTING 4.5 SECOND OMEN");
        elseif (count == 2) then
            echo("\n");
            NU.ECHO("PREDICTING 3 SECOND OMEN");
        else
            echo("\n");
            NU.ECHO("PREDICTING 1.5 SECOND OMEN");
        end
    end,
    syntax = {shaman = "shaman omen $target in $time", alchemist = "experiment causality $target in $time"}
});

aGA("Shamanism", "Cougar", {
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
    syntax = {shaman = "shaman cougar", alchemist = "experiment lacerating"}
})

aGA("Shamanism", "Familiar", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    dmgType = "unblockable",
    bal = {bal = "balance", cost = 0},
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    selfAffs = {}, limbs = nil, defs = {},
    onUseEffects = function(stable, ttable, data) if (data.empowerment) then display(data.empowerment); NU.setFlag(stable.name .. "_familiar_morph", matches[2]); end end, -- any effect when ab is used, even if unsuccessful
    postEffects = nil, -- replace with a function that fires on ab success
    cooldown = nil, attackType = nil,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {shaman = "shaman familiar", alchemist = "experiment requesting"}
})

aGA("Shamanism", "Invigorate", {
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
    syntax = {shaman = "shaman invigorate", alchemist = "experiment transfusion"}
})

aGA("Shamanism", "Raven", {
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
    syntax = {shaman = "shaman raven", alchemist = "experiment wailing"}
})

aGA("Shamanism", "Serpent", {
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
    syntax = {shaman = "shaman serpent", alchemist = "experiment toxic"}
})

aGA("Shamanism", "Tethering", {
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
    syntax = {shaman = "shaman tethering", alchemist = "experiment preservation"}
})

aGA("Shamanism", "Glance", {
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
    syntax = {shaman = "shaman glance", alchemist = "experiment witness"}
})

aGA("Shamanism", "Voice", {
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
    syntax = {shaman = "shaman voice", alchemist = "experiment articulation"}
})

aGA("Shamanism", "Spider", {
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
    syntax = {shaman = "shaman spider", alchemist = "experiment arachnidal"}
})

aGA("Shamanism", "Spiritbond", {
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
    syntax = {shaman = "familiar spiritbond on", alchemist = "experiment interposition"}
})

aGA("Shamanism", "Bear", {
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
    syntax = {shaman = "shaman bear", alchemist = "experiment tumefactive"}
})

aGA("Shamanism", "Wyvern", {
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
    syntax = {shaman = "shaman wyvern", alchemist = "experiment immolative"}
})

aGA("Shamanism", "Morph", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    dmgType = "unblockable",
    bal = {bal = "balance", cost = 0},
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    selfAffs = {}, limbs = nil, defs = {},
    onUseEffects = function(stable, ttable, data)
        NU.setFlag(stable.name .. "_familiar_morph", ttable.name);
    end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    cooldown = 300,
    syntax = {shaman = "shaman morph $familiar", alchemist = "experiment reconfiguration $familiar"}
})

aGA("Shamanism", "Fetishes", {
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
    syntax = {shaman = "shaman fetishes", alchemist = "experiment compounds"}
})

aGA("Shamanism", "Horn", {
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
    syntax = {shaman = "shaman horn", alchemist = "experiment exhilarant"}
})

aGA("Shamanism", "Attunement", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    dmgType = "unblockable",
    bal = {bal = "equilibrium", cost = 0},
    onUseEffects = function(stable, ttable, data)
        if (TRACK.isSelf(stable) and ttable) then
            NU.setFlag(ttable.name .. "_fetish_attuned", true, 60)
        elseif (TRACK.isSelf(stable) and data.empowerment and data.empowerment == "off") then
            NU.clearFlag(NU.target .. "_fetish_attuned");
        end
    end, -- any effect when ab is used, even if unsuccessful
    arms = 1, legs = 0, reqs = nil,
    syntax = {shaman = "fetish attune $target", alchemist = "experiment exposure"}
})

aGA("Shamanism", "Stringing", {
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
    syntax = {shaman = "shaman stringing", alchemist = "experiment augmentation"}
})

aGA("Shamanism", "Ice", {
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
    syntax = {shaman = "shaman ice", alchemist = "experiment toxoid"}
})

aGA("Shamanism", "Tooth", {
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
    syntax = {shaman = "shaman tooth", alchemist = "experiment invigorant"}
})

aGA("Shamanism", "Bone", {
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
    syntax = {shaman = "shaman bone", alchemist = "experiment caustic"}
})

aGA("Shamanism", "Claw", {
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
    syntax = {shaman = "shaman claw", alchemist = "experiment anticoagulant"}
})

aGA("Shamanism", "Eye", {
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
    syntax = {shaman = "shaman eye", alchemist = "experiment diagnostic"}
})

aGA("Shamanism", "Bark", {
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
    syntax = {shaman = "shaman bark", alchemist = "experiment anesthetic"}
})

aGA("Shamanism", "Stone", {
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
    syntax = {shaman = "shaman stone", alchemist = "experiment inhibiting"}
})

aGA("Shamanism", "Shell", {
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
    syntax = {shaman = "shaman shell", alchemist = "experiment intoxicant"}
})

aGA("Shamanism", "Feather", {
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
    syntax = {shaman = "shaman feather", alchemist = "experiment galvanic"}
})
