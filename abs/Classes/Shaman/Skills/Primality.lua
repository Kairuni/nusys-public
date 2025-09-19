local aGA = AB.addGenericAbility;

local function energyCheck(st, threshold)
    return (st.vitals.energy and st.vitals.energy >= threshold) or (st.vitals.volatility and st.vitals.volatility >= threshold)
end

local function primalityEqFuncBuilder(threshold, aboveCost, belowCost)
    return function(st, _, _)
        local cost = energyCheck(st, threshold) and aboveCost or belowCost;
        return {self = {bal = "equilibrium", cost = cost}, target = {cost = 0}};
    end
end

local function consumeOrGainEnergy(amount)
    return function(st, _, _)
        if (TRACK.isSelf(st)) then
            return;
        end

        if (st.vitals.energy) then
            st.vitals.energy = st.vitals.energy + amount;
            if (st.vitals.energy > 5) then
                st.vitals.energy = 5;
            elseif (st.vitals.energy < 0) then
                st.vitals.energy = 0;
            end
        elseif (st.vitals.volatility) then
            st.vitals.energy = st.vitals.volatility + amount;
        end
    end
end

local function primalityRequirements(noShield, energy, cooldown, extraChecks)
    return function(attacker, target, data)
        local arms = (FLAGS.shaman_fetishes and FLAGS.shaman_fetishes["tooth"]) and 0 or 2;
        energy = energy or -1;
        local proceed = true;
        if (extraChecks) then
            proceed = extraChecks(attacker, target, data)
        end
        return proceed and (attacker.vitals.energy >= energy or attacker.vitals.volatility >= energy) and AB.genericRequirements(attacker, target, arms, false, false, false, noShield, cooldown and (attacker.name .. "_" .. cooldown) or nil, 0);
    end
end

local function generateEnergy(st, tt, data)
    if (not TRACK.isSelf(st)) then
        st.vitals.energy = st.vitals.energy + 1 >= 5 and 5 or st.vitals.energy + 1;
    end
end

local function consumeEnergy(st, tt, data)
    if (not TRACK.isSelf(st)) then
        st.vitals.energy = st.vitals.energy - 1 <= 0 and 0 or st.vitals.energy - 1;
    end
end

aGA("Primality", "Quarterstaff", {
    ep = 0, wp = 100,
    bal = {bal = "equilibrium", cost = 3},

    postEffects = nil, -- replace with a function that fires on ab success
    reqs = function() end, -- Must be standing in a forest
    syntax = {shaman = "commune quarterstaff", alchemist = "alchemy conduit"}
})

aGA("Primality", "Recall", {
    ep = 0, wp = 100,
    bal = {bal = "equilibrium", cost = 3},
    postEffects = nil,
    syntax = {shaman = "commune recall", alchemist = "alchemy recall"}
})

aGA("Primality", "Lightning", {
    dmg = {eH = 0.326, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 60,
    dmgType = "electric",
    bal = {bal = "equilibrium", cost = 3.76},
    reqs =  primalityRequirements(true),
    onUseEffects = generateEnergy,
    syntax = {shaman = "commune lightning $target", alchemist = "alchemy static $target"}
})

aGA("Primality", "Lightning Boosted", {
    dmg = {eH = 0.36, eM = 0, sH = 0, sM = 76},
    ep = 0, wp = 60,
    dmgType = "electric",
    bal = {bal = "equilibrium", cost = 3.26},
})

aGA("Primality", "Squall", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3},
    -- TODO: Disperse mist?
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    notarget = true,
    syntax = {shaman = "commune squall", alchemist = "alchemy clarify"}
})

aGA("Primality", "Boosting", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 151},
    ep = 0, wp = 25, defs = {"boosting"},
    bal = {bal = "equilibrium", cost = 0},
    reqs = primalityRequirements(true, 1);
    syntax = {shaman = "commune boost", alchemist = "alchemy catalyse"}
})

-- Strips shield -> random def.
-- Doesn't show in cmsg
aGA("Primality", "Leafstorm", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 15,
    bal = primalityEqFuncBuilder(1, 2, 2.3),
    reqs =  primalityRequirements(true),
    syntax = {shaman = "commune leafstorm $target", alchemist = "alchemy corrosive $target"}
})

aGA("Primality", "Leafstorm Boosted", {
    dmg = {eH = 0.13, eM = 0, sH = 0, sM = 76},
    dmgType = "cutting",
    ep = 0, wp = 15,
    onUseEffects = consumeOrGainEnergy(-1),
    bal = primalityEqFuncBuilder(1, 2, 2.3),
    syntax = {shaman = "commune leafstorm $target", alchemist = "alchemy corrosive $target"}
})

aGA("Primality", "Vinelash", {
    dmg = {eH = .25, eM = 0, sH = 0, sM = 52},
    ep = 0, wp = 20,
    dmgType = "cutting",
    bal = {bal = "equilibrium", cost = 3},
    onUseEffects = generateEnergy,
    reqs = primalityRequirements(),
    syntax = {shaman = "commune vinelash $target $venom", alchemist = "alchemy virulent $target $venom"}
})

aGA("Primality", "Vinelash Boosted", {
    dmg = {eH = .25, eM = 0, sH = 0, sM = 52},
    ep = 0, wp = 20,
    dmgType = "cutting",
    bal = {bal = "equilibrium", cost = 2.5},
    onUseEffects = consumeEnergy,
    reqs = primalityRequirements(),
    syntax = {shaman = "commune vinelash $target", alchemist = "alchemy virulent $target"}
})

aGA("Primality", "Slam", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 152},
    ep = 0, wp = 50,
    bal = primalityEqFuncBuilder(3, 4.15, 3.26),
    affs = function(_, _, _)
        return {"FALLEN"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = consumeEnergy,
    reqs = primalityRequirements(),
    syntax = {shaman = "commune slam $target $time", alchemist = "alchemy upset $target $time"}
})

aGA("Primality", "Slam Boosted", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 152},
    ep = 0, wp = 50,
    bal = primalityEqFuncBuilder(3, 4.15, 3.26),
    onUseEffects = consumeEnergy,
    reqs = primalityRequirements(),
})

aGA("Primality", "Vitiate", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 10,
    bal = primalityEqFuncBuilder(2, 3.3, 3),
    affs = function(_, _, _)
        return {"lifebane"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = generateEnergy,
    reqs = primalityRequirements(),
    syntax = {shaman = "commune vitiate $target", alchemist = "alchemy intrusive $target"}
})


aGA("Primality", "Vitiate Boosted", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 10,
    bal = primalityEqFuncBuilder(2, 3.3, 3),
    affs = function(_, _, _)
        return {"lifebane", "plodding"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = generateEnergy,
    reqs = primalityRequirements(),
    syntax = {shaman = "commune vitiate $target", alchemist = "alchemy intrusive $target"}
})

aGA("Primality", "Overload", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 10,
    bal = primalityEqFuncBuilder(3, 2.9, 2.6),
    affs = function(_, _, _)
        return {"paresis", "stupidity"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = consumeEnergy,
    reqs = primalityRequirements(),
    syntax = {shaman = "commune overload $target", alchemist = "alchemy electroshock $target"}
})

aGA("Primality", "Overload Boosted", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 10,
    bal = primalityEqFuncBuilder(3, 2.9, 2.6),
    affs = function(_, _, _)
        return {"paresis", "stupidity", "blackout"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = consumeEnergy,
    reqs = primalityRequirements(),
})

aGA("Primality", "Discharge", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 250},
    ep = 0, wp = 80,
    dmgType = "fire",
    bal = {bal = "equilibrium", cost = 4},
    reqs = primalityRequirements(),
    syntax = {shaman = "commune discharge $target", alchemist = "alchemy incendiary $target"}
})


aGA("Primality", "Discharge Boosted", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 250},
    ep = 0, wp = 80,
    dmgType = "fire",
    bal = {bal = "equilibrium", cost = 4},
    affs = function(_, _, _)
        return {"ablaze", "FALLEN"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reqs = primalityRequirements(),
    syntax = {shaman = "commune discharge $target", alchemist = "alchemy incendiary $target"}
})

aGA("Primality", "Scourge", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 50},
    ep = 0, wp = 10,
    bal = primalityEqFuncBuilder(2, 3.5, 3.25),
    affs = function(_, _, _)
        return {"vitalbane"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = generateEnergy,
    reqs = primalityRequirements(),
    syntax = {shaman = "commune scourge $target", alchemist = "alchemy malignant $target"}
})

aGA("Primality", "Scourge Boosted", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 50},
    ep = 0, wp = 10,
    bal = primalityEqFuncBuilder(2, 3.78, 3.488),
    affs = function(_, _, _)
        return {"vitalbane", "idiocy"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = consumeEnergy,
})

local reclaimAffs = {
    "fear",
    "agoraphobia",
    "claustrophobia",
    "vertigo",
    "loneliness",
    "shyness",
    "paranoia",
    "superstition"
}

local function reclaimCount(tt)
    local count = 0;
    for _, v in ipairs(reclaimAffs) do
        if (tt.affs[v]) then
            count = count + 1;
        end
    end
    return count;
end

local function checkReclaimConditions(st, tt, data)
    local count = reclaimCount(tt);
    return count >= 5 and tt.affs.dread;
end

-- primalityRequirements
aGA("Primality", "Reclamation", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 302},
    ep = 0, wp = 100,
    bal = {bal = "equilibrium", cost = 6},
    affs = function(_, _, data)
        if (data and data.empowerments) then
            return {}, {}, 0;
        end
        return {"disabled"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reqs = primalityRequirements(false, 0, nil, checkReclaimConditions),
    postEffects = function(st, _, data)
        if (data and data.empowerments and #data.empowerments > 0 and TRACK.isSelf(st)) then
            NU.setFlag("reclamation_failed", true, 20);
        end
    end,
    syntax = {shaman = "commune reclamation $target", alchemist = "alchemy discorporate $target"}
})

aGA("Primality", "Stormbolt", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 100},
    ep = 0, wp = 35,
    bal = primalityEqFuncBuilder(3, 4.9, 4),
    onUseEffects = consumeOrGainEnergy(-2),
    reqs = primalityRequirements(),
    syntax = {shaman = "commune stormbolt $target", alchemist = "alchemy fulmination $target"}
})


aGA("Primality", "Stormbolt Boosted", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 100},
    ep = 0, wp = 35,
    bal = primalityEqFuncBuilder(3, 3.9, 3.6),
    onUseEffects = consumeOrGainEnergy(-2),
    postEffects = function(st, tt, data) NU.setFlag(tt.name .. "_stormbolt", true, 11); end,
    reqs = primalityRequirements(),
})


aGA("Primality", "Sporulation", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 120},
    ep = 0, wp = 14,
    bal = primalityEqFuncBuilder(3, 3.3, 2.4),
    affs = function(_, _, _)
        return {"confusion", "impatience"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reqs = primalityRequirements(),
    syntax = {shaman = "commune sporulation $target", alchemist = "alchemy neurotic $target"}
})

aGA("Primality", "Sporulation Boosted", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 120},
    ep = 0, wp = 14,
    bal = primalityEqFuncBuilder(3, 2.7, 2.4),
    affs = function(_, _, _)
        return {"confusion", "impatience", "hallucinations"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reqs = primalityRequirements(),
})


aGA("Primality", "Chainlightning", {
    dmg = {eH = 0.32, eM = 0, sH = 0, sM = 300},
    dmgType = "electric",
    ep = 0, wp = 56,
    bal = primalityEqFuncBuilder(3, 5.4, 4.5),
    onUseEffects = consumeOrGainEnergy(-2),
    reqs = primalityRequirements(),
    syntax = {shaman = "commune chainlightning $target", alchemist = "alchemy overcharge $target"}
})

aGA("Primality", "Cloudcall", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    bal = {bal = "balance", cost = 0},
    syntax = {shaman = "commune cloudcall", alchemist = "alchemy condensate"}
})

aGA("Primality", "Staticburst", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 150},
    ep = 0, wp = 65,
    bal = primalityEqFuncBuilder(3, 4, 3.1),
    reqs = primalityRequirements(),
    onUseEffects = consumeEnergy,
    postEffects = function(st, tt, data) NU.setFlag(tt.name .. "_staticburst", 2, 10) end,
    syntax = {shaman = "commune staticburst $target", alchemist = "alchemy currents $target"}
});

aGA("Primality", "Staticburst Boosted", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 150},
    ep = 0, wp = 65,
    bal = primalityEqFuncBuilder(3, 4, 3.1),
    reqs = primalityRequirements(),
    onUseEffects = consumeOrGainEnergy(-2),
    postEffects = function(st, tt, data) NU.setFlag(tt.name .. "_staticburst", 4, 10) end,
});

aGA("Primality", "Lifebloom", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 120},
    ep = 0, wp = 40,
    bal = {bal = "equilibrium", cost = 2.5},
    defensive = true,
    cooldown = 360,
    syntax = {shaman = "commune lifebloom", alchemist = "alchemy resuscitation"}
})

aGA("Primality", "Equivalence", {
    -- TODO: Damage function is based on my own missing HP and their max HP.
    dmg = {eH = 0, eM = 0, sH = 0, sM = 120},
    ep = 0, wp = 40,
    bal = primalityEqFuncBuilder(4, 5.4, 4.2),
    onUseEffects = consumeOrGainEnergy(-2),
    reqs = primalityRequirements(),
    syntax = {shaman = "commune equivalence $target", alchemist = "alchemy parity $target"}
})

aGA("Primality", "Equivalence Boosted", {
    -- TODO: Damage function is based on my own missing HP and their max HP.
    dmg = {eH = 0, eM = 0, sH = 0, sM = 120},
    ep = 0, wp = 40,
    bal = primalityEqFuncBuilder(4, 5.4, 4.2),
    affs = function(_, _, _)
        return {"justice"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = consumeOrGainEnergy(-3),
})

aGA("Primality", "Infest", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 50},
    ep = 0, wp = 10,
    bal = primalityEqFuncBuilder(1, 2.3, 1),
    affs = function(_, _, _)
        return {"infestation"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = generateEnergy,
    reqs = primalityRequirements(),
    syntax = {shaman = "commune infest $target", alchemist = "alchemy infiltrative $target"}
})

aGA("Primality", "Infest Boosted", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 50},
    ep = 0, wp = 10,
    bal = primalityEqFuncBuilder(1, 2.3, 1),
    reqs = primalityRequirements(),
    postEffects = function(st, tt, data) NU.setFlag(tt.name .. "_will_infest", NU.time() + 2, 2); end,
})


aGA("Primality", "Effusion", {
    dmg = {eH = 0, eM = 0, sH = .25, sM = 0},
    ep = 0, wp = 20,
    bal = primalityEqFuncBuilder(1, 4.3, 4),
    affs = function(_, _, _)
        return {"sensitivity"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reqs = primalityRequirements(),
    postEffects = function(st, tt, data) TRACK.stripDef(tt, "deafness"); TRACK.stripDef(tt, "blindness"); end,
    syntax = {shaman = "commune effusion $target", alchemist = "alchemy rousing $target"}
})


aGA("Primality", "Effusion Boosted", {
    dmg = {eH = 0, eM = 0, sH = .25, sM = 0},
    ep = 0, wp = 20,
    bal = primalityEqFuncBuilder(1, 4.3, 4),
    affs = function(_, _, _)
        return {"sensitivity", "stunned"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reqs = primalityRequirements(),
    postEffects = function(st, tt, data) TRACK.stripDef(tt, "deafness"); TRACK.stripDef(tt, "blindness"); end,
})


aGA("Primality", "Spines", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 50},
    ep = 0, wp = 10,
    bal = primalityEqFuncBuilder(1, 2.3, 2),
    affs = function(_, _, _)
        return {"blight"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reqs = primalityRequirements(),
    onUseEffects = generateEnergy,
    syntax = {shaman = "commune spines $target", alchemist = "alchemy pathogen $target"}
})

aGA("Primality", "Spines Boosted", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 50},
    ep = 0, wp = 10,
    bal = primalityEqFuncBuilder(1, 2.3, 2),
    syntax = {shaman = "commune spines $target", alchemist = "alchemy pathogen $target"}
})

aGA("Primality", "Strangle", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 150},
    ep = 0, wp = 54,
    bal = primalityEqFuncBuilder(3, 4.7, 3.8),
    affs = function(_, _, _)
        return {"writhe_vines"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reqs = primalityRequirements(nil, 0, nil, function(st, tt, data) return tt.affs.PRONE; end),
    onUseEffects = consumeEnergy,
    syntax = {shaman = "commune strangle $target", alchemist = "alchemy asphyxiant $target"}
})

aGA("Primality", "Strangle Boosted", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 150},
    ep = 0, wp = 54,
    bal = primalityEqFuncBuilder(3, 4.7, 3.8),
    affs = function(_, _, _)
        return {"writhe_vines"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = consumeOrGainEnergy(-2),
})

aGA("Primality", "Quicken", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 180},
    ep = 0, wp = 70,
    bal = {bal = "equilibrium", cost = 0},
    defs = {"quicken"},
    onUseEffects = consumeOrGainEnergy(-5),
    reqs = primalityRequirements(true, 5),
    syntax = {shaman = "commune quicken $target", alchemist = "alchemy accelerant $target"}
})

aGA("Primality", "Naturaltide", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 150},
    ep = 0, wp = 50,
    bal = {bal = "equilibrium", cost = 2},
    onUseEffects = function(stable, ttable, data) if (data and data.empowerments) then NU.setFlag(stable.name .. "_naturaltide", data.empowerments[1]); end end, -- any effect when ab is used, even if unsuccessful
    reqs = primalityRequirements(true),
    syntax = {shaman = "commune naturaltide $ability", alchemist = "alchemy preparation $ability"}
})

aGA("Primality", "Release", {
    bal = {bal = "equilibrium", cost = 1},
    reqs = primalityRequirements(true),
    syntax = {shaman = "commune release $target", alchemist = "alchemy educe $target"}
})