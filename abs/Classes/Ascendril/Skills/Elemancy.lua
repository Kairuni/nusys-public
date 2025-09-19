AB["Elemancy"] = AB["Elemancy"] or {};
local aGA = AB.addGenericAbility;

local function removeAfterburn(st)
    if (st.defs.afterburn) then
        NU.clearFlag(st.name .. "_clear_afterburn");
        TRACK.removeDef(st, "afterburn");
    end
end

local function buildResonanceFunc(element)
    return function(st, tt, data)
        if (element == "fire") then
            removeAfterburn(st);
        end

        -- Only adjust resonance if blacked out, otherwise we're gucci.
        if (st.affs.blackout) then
            if (st.vitals.resonance == "half " .. element) then
                st.vitals.resonance = element;
            else
                st.vitals.resonance = "half " .. element;
            end
        end
    end
end

local function bumpResonance(st, element)
    if (st.vitals.resonance == "half " .. element) then
        st.vitals.resonance = element;
    else
        st.vitals.resonance = "half " .. element;
    end
end

local function testResonance(st, resonance)
    -- TODO: Make this work for both Ascendril and BB
    return st.vitals.resonance == resonance;
end

local function buildElemancyRequirements(ignoreShield, cooldown)
    return function(at, tt, data)
        local hasFocus = true;

        return AB.genericRequirements(at, tt, hasFocus and 1 or 2, false, nil, false, ignoreShield, cooldown, 0);
    end
end

local function testElemancyRequirements(at, tt, ignoreShield, cooldown)
    local hasFocus = true;

    return AB.genericRequirements(at, tt, hasFocus and 1 or 2, false, nil, false, ignoreShield, cooldown, 0);
end

local function buildFireEqCost(cost)
    return function(at, tt, data)
        if (at.defs.afterburn) then
            return {self = {bal = "equilibrium", cost = cost / 2}, target = {cost = 0}};
        else
            return {self = {bal = "equilibrium", cost = cost}, target = {cost = 0}};
        end
    end
end

aGA("Elemancy", "Focus", {
    ep = 0, wp = 30,
    dmgType = "unblockable",
    bal = {bal = "equilibrium", cost = 4},
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "focalcast $empowerment $target", bloodborn = ""}
})

-- Current known options - Missile

-- FIRE

-- Bind an element, currently does nothing?
-- TODO: Separate flat mana costs from percent mana costs. 
aGA("Elemancy", "Binding", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = .02},
    ep = 0, wp = 0,
    dmgType = "unblockable",
    bal = {bal = "equilibrium", cost = 3},
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    selfAffs = {}, limbs = nil, defs = {},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    postEffects = nil, -- replace with a function that fires on ab success
    cooldown = nil, attackType = nil,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {ascendril = "bind $element", bloodborn = ""}
})

-- TODO: Replace reqs with something that checks for focus.
aGA("Elemancy", "Spark", {
    dmg = {eH = 0.2, eM = 0, sH = 0, sM = 153},
    ep = 0, wp = 15,
    dmgType = "fire",
    dmgSource = "magical",
    bal = buildFireEqCost(2),
    affs = function(stable, ttable, data)
        return {"blisters", "impairment"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = buildResonanceFunc("fire"),
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast spark $target", bloodborn = ""}
})

-- TODO: Duration 3 minutes, figure out how to handle that
aGA("Elemancy", "Ashenfeet", {
    dmg = {eH = .25, eM = 0, sH = 0, sM = 100},
    ep = 0, wp = 10,
    dmgType = "fire",
    bal = buildFireEqCost(3),
    affs = function(stable, ttable, data)
        return {"ashen_feet"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = buildResonanceFunc("fire"),
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast ashenfeet $target", bloodborn = ""}
})

-- Overloaded, this both is a no-target (up the def) and a target (do the damage) case.
-- 3s eq to cast, 2s hand balance.
-- TODO: Lasts for 20s
aGA("Elemancy", "Fireburst", {
    -- 304 mana cost on shooting someone, 100 on self def.
    dmg = {eH = .185, eM = 0, sH = 0, sM = 100},
    epWpCost = function(st, tt) if (tt) then return 0, 30;  else return 0, 10 end end,
    dmgType = "fire",
    affs = function(st, tt, data) return tt and {"ablaze"} or {}; end,
    defs = function(st, tt, data) return tt and {} or {"fireburst"}; end,
    bal = function(st, tt, _)
        if (tt) then
            return {self = {bal = "arm", cost = 2}, target = {cost = 0}};
        else
            return {self = {bal = "equilibrium", cost = st.defs.afterburn and 1.5 or 3}, target = {cost = 0}};
        end
    end,
    onUseEffects = function(st, tt)
        local flagName = st.name .. "_fireburst_stacks";
        if (not tt) then
            bumpResonance(st, "fire");
            NU.setFlag(flagName, 4, 60);
        elseif (FLAGS[flagName]) then
            FLAGS[flagName] = FLAGS[flagName] - 1;
        end
    end,
    reqs = function(st, tt, data) return testElemancyRequirements(st, tt, true) and not st.defs.fireburst; end,
    syntax = {ascendril = "cast fireburst", bloodborn = ""}
})

aGA("Elemancy", "Fireburst_Punch", {
    reqs = function(st, tt)
        return testElemancyRequirements(st, tt, false) and st.defs.fireburst;
    end,
    syntax = {ascendril = "fireburst $target", bloodborn = ""}
})

aGA("Elemancy", "Blazewhirl", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 812}, -- probably 10% mana
    ep = 0, wp = 80,
    bal = buildFireEqCost(4.5),
    onUseEffects = function(stable, ttable, data)
        bumpResonance(stable, "fire");
        if (TRACK.isSelf(stable)) then
            NU.setFlag("elemental_phenomena", {target = ttable, type = "blazewhirl", hp = 10, loc = gmcp.Room.Info.num}, 360);
        end
        removeAfterburn(stable);
    end,
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast blazewhirl $target", bloodborn = ""}
});

aGA("Elemancy", "Conflagrate", {
    dmg = {eH = .28, eM = 0, sH = 0, sM = 335},
    ep = 0, wp = 50,
    dmgType = "fire",
    bal = buildFireEqCost(3),
    affs = function(st, tt, data)
        return testResonance(st, "fire") and {"ablaze"} or {};
    end,
    onUseEffects = function(st, tt, data)
        bumpResonance(st, "fire");
        removeAfterburn(st);
        TRACK.stripDef(tt, "deafness");
    end,
    reqs = function(st, tt, data) return testElemancyRequirements(st, tt, false) and tt.affs.ablaze; end,
    syntax = {ascendril = "cast conflagrate $target", bloodborn = ""}
})

-- After 5s, grants afterburn def. Def lasts for 16s.
aGA("Elemancy", "Afterburn", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 153},
    ep = 0, wp = 20,
    bal = {bal = "equilibrium", cost = 3},
    onUseEffects = function(stable, ttable, data)
        NU.setFlag(stable.name .. "_afterburning", true, 6);
        NU.setFlag(stable.name .. "_clear_afterburn", true, 45, function() TRACK.removeDef(stable, "afterburn"); end);
    end, -- any effect when ab is used, even if unsuccessful
    reqs = function(st, tt, data)
        return testElemancyRequirements(st, tt, true) and not FLAGS[st.name .. "_afterburning"] and not st.defs
            .afterburn;
    end,
    syntax = {ascendril = "cast afterburn", bloodborn = ""}
})

-- TODO: This doesn't actually do damage on use. Add the damage to triggers.
aGA("Elemancy", "Sunspot", {
    dmg = {eH = .225, eM = 0, sH = 0, sM = 203},
    ep = 0, wp = 20,
    dmgType = "fire",
    bal = buildFireEqCost(3),
    onUseEffects = function(stable, ttable, data) 
        NU.setFlag(stable.name .. "_sunspot", true, 7);
    end,
    reqs = function(st, tt, data)
        return not FLAGS[st.name .. "_sunspot"] and testElemancyRequirements(st, nil, false);
    end,
    syntax = {ascendril = "cast sunspot $target $target2", bloodborn = ""}
})

-- Probably a finisher?
-- This one's big.
-- Targets head, can be parried. Unless ablaze.
-- If blisters, x2 limb.
-- If no arcane, x2 damage.
-- 
-- Requires full fire resonance.
aGA("Elemancy", "Pyroclast", {
    dmg = {eH = .315, eM = 0, sH = 0, sM = 812},
    ep = 0, wp = 90,
    dmgType = "unblockable",
    limbs = function(st, tt, data)
        if (tt.affs.blisters) then
            return {head = 69.00};
        else
            return {head = 23.00};
        end
    end,
    bal = buildFireEqCost(6),
    onUseEffects = function(st, tt, data) if (not TRACK.isSelf(st)) then st.vitals.resonance = "none"; end end,
    postEffects = function(st, tt, data) if (tt.affs.impairment) then TRACK.aff(tt, "stun"); NU.setFlag(tt.name .. "_stun_remove", true, 3, function() tt.affs.stun = false; end); end end,
    reqs = function(st, tt, data)
        return st.vitals.resonance == "fire" and testElemancyRequirements(st, tt, false);
    end,
    syntax = {ascendril = "cast pyroclast $target", bloodborn = ""}
})

-- TODO: This goes into domain effects, blocks scent for a room.
aGA("Elemancy", "Cinder", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 254},
    ep = 0, wp = 25,
    bal = {bal = "equilibrium", cost = 3},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    postEffects = nil, -- replace with a function that fires on ab success
    cooldown = nil, attackType = nil,
    reboundable = nil, noShield = nil, arms = 1, legs = 0, reqs = nil,
    syntax = {ascendril = "cast cinder", bloodborn = ""}
})

-- Does damage on release, costs mana on charge.
-- 24% mana cost.
-- Strips defensive tools, and arcane.
-- Half eq cost, but still same channel time with afterburn.
-- 5s channel
-- TODO: Figure out every def this strips.
aGA("Elemancy", "Disintegrate", {
    dmg = function(st, tt, data)
        if (data.empowerments and data.empowerments[1] == "charge") then
            return 0, 0, 0, 2030;
        else
            return .485, 0, 0, 0;
        end
    end,

    epWpCost = function(st, tt, data) return 0, (data.empowerments and data.empowerments[1] == "charge") and 200 or 0 end,
    dmgType = "unblockable",
    bal = buildFireEqCost(8),
    onUseEffects = function(st, ttable, data)
        if (data.empowerments and data.empowerments[1] ~= "charge") then
            if (ttable) then
                ttable.defs.arcane = false;
            end
            NU.setFlag("recently_disintegrated", true, 10);
        end
        st.vitals.resonance = "none";
    end, -- any effect when ab is used, even if unsuccessful
    reqs = function(st, tt, data)
        return st.vitals.resonance == "fire" and testElemancyRequirements(st, tt, false);
    end,
    channel = function(_, _, data)
        display("Trying disintegrate channel");
        return (data.empowerments and data.empowerments[1] == "charge") and 6 or 0;
    end,
    syntax = {ascendril = "cast disintegrate $target", bloodborn = ""}
})

-- WATER

-- Hits all enemies in current location
-- Doesn't show a message per person hit.
aGA("Elemancy", "Coldsnap", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 153},
    ep = 0, wp = 15,
    dmgType = "cold",
    bal = {bal = "equilibrium", cost = 2},
    onUseEffects = function(st, tt, _)
        bumpResonance(st, "water");
    end, -- any effect when ab is used, even if unsuccessful
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast coldsnap", bloodborn = ""}
})

aGA("Elemancy", "Drench", {
    dmg = function(st, tt, data)
        return 0,
            0.08 + (tt.affs.shivering and 0.06 or 0) + (tt.affs.frigid and 0.12 or 0) + (tt.affs.frozen and 0.13 or 0), 0,
            153;
    end,
    ep = 0, wp = 15,
    bal = {bal = "equilibrium", cost = 3},
    onUseEffects = buildResonanceFunc("water"),
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast drench $target", bloodborn = ""}
})

-- If shivering, knock bal 1.5.
aGA("Elemancy", "Iceray", {
    dmg = {eH = .363, eM = 0, sH = 0, sM = 304},
    ep = 0, wp = 20,
    dmgType = "cold",
    bal = function(st, tt, _)
        return {self = {bal = "equilibrium", cost = 4}, target = {bal = "balance", cost = tt.affs.shivering and 1.5 or 0}};
    end,
    affs = function(stable, ttable, data)
        -- technically knocks off bal if shivering.
        return {}, nil, 0; --return ttable.affs.frozen and {"disrupted"} or {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = function(st, tt, _) bumpResonance(st, "water"); if (tt.affs.frigid) then tt.defs.levitation = false; end end,
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast iceray $target", bloodborn = ""}
})

-- TODO: In room effect tracking
-- Can only be used out of room
-- The ice chips away, releasing Gherond's feet.
-- frozen_feet
-- 33.6% damage raw on tick if onbbal, half offbal.
-- Ticks every 6s
aGA("Elemancy", "Glazeflow", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 812},
    ep = 0, wp = 80,
    bal = {bal = "equilibrium", cost = 4.5},
    onUseEffects = function(stable, ttable, data)
        bumpResonance(stable, "water");
        if (TRACK.isSelf(stable)) then
            NU.setFlag("elemental_phenomena", {target = ttable, type = "glazeflow", hp = 10, loc = gmcp.Room.Info.num}, 360);
        end
    end,
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast glazeflow $target", bloodborn = ""}
});

-- TODO: In room effects - spawns 3 icicles. After 6s, they fire off 2.5s in between.
aGA("Elemancy", "Icicle", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 255},
    ep = 0, wp = 15,
    bal = {bal = "equilibrium", cost = 4},
    onUseEffects = function(st, ttable, data)
        bumpResonance(st, "water");
        display("What");
        display(st.name);
        NU.setFlag(st.name .. "_icicles", {loc = gmcp.Room.Info.num, count = 3}, 16);
        display(FLAGS[st.name .. "_icicles"]);
    end,
    reqs = function(st, tt, _) return testElemancyRequirements(st, tt, true) and not FLAGS[st.name .. "_icicles"]; end,
    syntax = {ascendril = "cast icicle $target", bloodborn = ""}
});

aGA("Elemancy", "Shatter", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 150},
    ep = 0, wp = 10,
    dmgType = "unblockable",
    bal = {bal = "equilibrium", cost = 1},
    onUseEffects = function(st, tt, _)
        bumpResonance(st, "water");
        local icicles = FLAGS[st.name .. "_icicles"];
        if (icicles) then
            NU.setFlag(st.name .. "_shatter", {loc = gmcp.Room.Info.num, count = icicles.count * 3}, 8);
            NU.clearFlag(st.name .. "_icicles");
        end
    end,
    reqs = function(st, tt, _) return testElemancyRequirements(st, tt, true) and FLAGS[st.name .. "_icicles"] and not FLAGS[st.name .. "_shatter"]; end,
    syntax = {ascendril = "cast shatter", bloodborn = ""}
})

-- Crystalize
-- Crystalize with 0 conditionals met should say 'failure' in the cmsg or some such

-- No base mana drain, no affliction.
-- 25% mana drain with no levitation, + writhe_ice
-- 50% with shivering, no levitation, hobbled, writhe_ice.
-- 75% with shivering, no levitation, glazeflow in room. writhe_ice, frozen_feet, and hobbled.
-- No levitation -> writhe_ice.
-- Shivering -> hobbled
-- Glazeflow -> frozen_feet.
-- 25% mana per.
aGA("Elemancy", "Crystalise", {
    dmg = function(st, tt, data)
        local phenomena = FLAGS["elemental_phenomena"];
        local glazeflowCheck = st and TRACK.isSelf(st) and phenomena and phenomena.type == "glazeflow";

        return 0, 0.0 + (tt.affs.shivering and 0.25 or 0) + ((not tt.defs.levitation) and 0.25 or 0) + (glazeflowCheck and 0.25 or 0), 0, 813;
    end,
    ep = 0, wp = 80,
    bal = {bal = "equilibrium", cost = 4},
    affs = function(st, tt, data)
        local phenomena = FLAGS["elemental_phenomena"];
        local glazeflowCheck = st and TRACK.isSelf(st) and phenomena and phenomena.type == "glazeflow";

        local affs = {};
        if (not tt.defs.speed) then table.insert(affs, "writhe_ice"); end
        if (tt.affs.shivering) then table.insert(affs, "hobbled"); end
        if (glazeflowCheck) then table.insert(affs, "frozen_feet"); end

        return affs, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = buildResonanceFunc("water"),
    reqs = function(st, tt, _)
        local phenomena = FLAGS["elemental_phenomena"];
        local glazeflowCheck = st and TRACK.isSelf(st) and phenomena and phenomena.type == "glazeflow";

        return testElemancyRequirements(st, tt, true) and st.vitals.resonance == "water" and (glazeflowCheck or not tt.defs.levitation or tt.affs.shivering);
    end,
    syntax = {ascendril = "cast crystalise $target", bloodborn = ""}
})

-- TODO: Room effect. Stops vision from external.
aGA("Elemancy", "Fog", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 100},
    ep = 0, wp = 10,
    dmgType = "unblockable",
    bal = {bal = "equilibrium", cost = 3},
    onUseEffects = buildResonanceFunc("water"),
    reqs = buildElemancyRequirements(true),
    syntax = {ascendril = "cast fog", bloodborn = ""}
})

-- Charge and release again.
-- On release, 
aGA("Elemancy", "Winterheart", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 2030},
    ep = 0, wp = 200,
    dmgType = "unblockable",
    bal = {bal = "equilibrium", cost = 0},
    onUseEffects = function(stable, ttable, data)
        stable.vitals.resonance = "none";
    end, -- any effect when ab is used, even if unsuccessful
    reqs = function(st, tt, _)
        return testElemancyRequirements(st, tt, true) and st.vitals.resonance == "water";
    end,
    channel = function(_, _, data)
        return (data.empowerments and data.empowerments[1] == "charge") and 6 or 0;
    end,
    syntax = {ascendril = "cast winterheart", bloodborn = ""}
})


-- AIR!
-- Doesn't show target in cmsg, but hits multiple targets.
-- 792 damage to Eliant.
-- 2618 at 3.44 to Eliant.
-- See notes for lines for prone or shield strip.
aGA("Elemancy", "Windlance", {
    dmg = {eH = .167, eM = 0, sH = 0, sM = 100},
    ep = 0, wp = 10,
    dmgType = "electric",
    bal = {bal = "equilibrium", cost = 2},
    onUseEffects = buildResonanceFunc("air"),
    reqs = buildElemancyRequirements(true),
    syntax = {ascendril = "cast windlance $target $target2 $target3", bloodborn = ""}
})

-- TODO: Damage numbers got adjusted, revisit.
aGA("Elemancy", "Pressurize", {
    dmg = function(st, tt, data) return 0, 0, 0, 153; end,
    ep = 0, wp = 10,
    dmgType = "electric",
    bal = {bal = "equilibrium", cost = 2},
    affs = function(st, ttable, data)
        if (st.vitals.resonance == "air") then
            return { "vertigo", "confusion", "laxity" };
        else
            return { "vertigo", "confusion" };
        end
    end,
    onUseEffects = buildResonanceFunc("air"),
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast pressurize $target", bloodborn = ""}
})

aGA("Elemancy", "Arcbolt", {
    -- TODO: Same idea here, apply .391 hp damage on next line.
    dmg = {eH = 0, eM = 0, sH = 0, sM = 304},
    ep = 0, wp = 10,
    dmgType = "electric",
    bal = {bal = "equilibrium", cost = 4},
    -- TODO: This doesn't directly target #1, so apply this on the next line.
    -- affs = function(stable, ttable, data)
    --     return ttable.affs.paresis and {"paralysis"} or {"paresis"};
    -- end,
    onUseEffects = buildResonanceFunc("air"),
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast arcbolt $target $target2", bloodborn = ""}
})

aGA("Elemancy", "Electrosphere", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 812},
    ep = 0, wp = 90,
    dmgType = "unblockable",
    bal = {bal = "equilibrium", cost = 4.5},
    onUseEffects = function(stable, ttable, data)
        bumpResonance(stable, "water");
        if (TRACK.isSelf(stable)) then
            NU.setFlag("elemental_phenomena", {target = ttable, type = "electrosphere", hp = 10, loc = gmcp.Room.Info.num}, 360);
        end
    end,
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast electrosphere $target", bloodborn = ""}
})

-- If dizzy + stupid + one more mental, thunderbrand.
aGA("Elemancy", "Thunderclap", {
    dmg = {eH = .258, eM = 0, sH = 0, sM = 273},
    ep = 0, wp = 20,
    dmgType = "electric",
    bal = {bal = "equilibrium", cost = 3},
    affs = function(stable, ttable, data)
        return (not ttable.defs.deafness) and {"dizziness", "stupidity", "confusion"} or {"dizziness", "stupidity"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = buildResonanceFunc("air"),
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast thunderclap $target", bloodborn = ""}
})


aGA("Elemancy", "Feedback", {
    dmg = function(st, tt, data) return 0, tt.affs.burnout and -1.0 or -0.5, 0, 500; end,
    ep = 0, wp = 50,
    bal = {bal = "equilibrium", cost = 4},
    affs = function(stable, ttable, data)
        return {"UNCONSCIOUS"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    onUseEffects = buildResonanceFunc("air"),
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast feedback $target", bloodborn = ""}
})


aGA("Elemancy", "Aeroblast", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 150},
    ep = 0, wp = 15,
    bal = {bal = "equilibrium", cost = 3},
    onUseEffects = function(stable, ttable, data)
        -- Takes 4.5s to go off, give or take.
        NU.setFlag(stable.name .. "_aeroblast", ttable.name, 6)
        stable.vitals.resonance = "none";
    end, -- any effect when ab is used, even if unsuccessful
    reqs = function(st, tt, _)
        return testElemancyRequirements(st, tt, true) and st.vitals.resonance == "air";
    end,
    syntax = {ascendril = "cast aeroblast $target", bloodborn = ""}
})

aGA("Elemancy", "Capacitance", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 150},
    ep = 0, wp = 15,
    bal = {bal = "equilibrium", cost = 3},
    onUseEffects = function(st, _, _) NU.setFlag(st.name .. "_capacitance", true, 8) end, -- any effect when ab is used, even if unsuccessful
    reqs = function(st, tt, _) return not FLAGS[st.name .. "_capacitance"] and testElemancyRequirements(st, tt, true); end,
    syntax = {ascendril = "cast capacitance", bloodborn = ""}
})


aGA("Elemancy", "Gust", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 153},
    ep = 0, wp = 15,
    bal = {bal = "equilibrium", cost = 2.5},
    onUseEffects = buildResonanceFunc("air"),
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast gust $target $direction", bloodborn = ""}
})


aGA("Elemancy", "Cyclone", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 203},
    ep = 0, wp = 20,
    bal = {bal = "equilibrium", cost = 3},
    onUseEffects = buildResonanceFunc("air"),
    reqs = buildElemancyRequirements(false),
    syntax = {ascendril = "cast cyclone", bloodborn = ""}
})

aGA("Elemancy", "Stormwrath", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 2030},
    ep = 0, wp = 200,
    bal = {bal = "equilibrium", cost = 8},
    onUseEffects = function(stable, ttable, data) stable.vitals.resonance = "none"; end, -- any effect when ab is used, even if unsuccessful
    reqs = function(st, tt, _)
        return testElemancyRequirements(st, tt, true) and st.vitals.resonance == "air";
    end,
    channel = function(_, _, data)
        return (data.empowerments and data.empowerments[1] == "charge") and 6 or 0;
    end,
    syntax = {ascendril = "cast stormwrath", bloodborn = ""}
})






AB["Elemancy"]["Coldsnap-Fire"] = {
    getTargetAffs = function(attacker, target, data)
        return {"stupidity", "recklessness"};
    end,

    getDamage = function(attacker, target, data)
        return 0.16745096263953 * target.vitals.maxhp * 0.4, 0, 0, 0;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2.8023255813953}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        local validResonance = {fire = true};
        return attacker.vitals.resonance ~= nil and validResonance[attacker.vitals.resonance] == true and (not attacker.affs.left_arm_crippled or not attacker.affs.right_arm_crippled) and not attacker.affs.FALLEN and not attacker.affs.asleep and not target.defs.shielded and not target.defs.barrier and not target.defs.manipulation_aegis;
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.resonance = "water";
    end,
}

AB["Elemancy"]["Hailstorm-Fire"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 251;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2.8023255813953}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        local validResonance = {fire = true};
        return attacker.vitals.resonance ~= nil and validResonance[attacker.vitals.resonance] == true and (not attacker.affs.left_arm_crippled or not attacker.affs.right_arm_crippled) and not attacker.affs.FALLEN and not attacker.affs.asleep and not target.defs.shielded and not target.defs.barrier and not target.defs.manipulation_aegis;
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.resonance = "water";
    end,

}

AB["Elemancy"]["Whirlwind"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 800;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return TRACK.isSelf(attacker) and not FLAGS.whirlwind and not FLAGS.snowstorm;
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.resonance = "air";
        NU.setFlag("whirlwind", true, 150);
    end,
}

AB["Elemancy"]["Direfrost"] = {
    getTargetAffs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "failure") and {} or {"direfrost"}
    end,

    getDamage = function(attacker, target, data)
        return 0.21788217503099 * target.vitals.maxhp * 0.4, 0, 0, 151;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3.5}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return (target.affs.shivering or target.affs.frozen or (FLAGS.will_freeze and FLAGS.will_freeze ~= "hypothermia")) and (not attacker.affs.left_arm_crippled or not attacker.affs.right_arm_crippled) and not attacker.affs.FALLEN and not attacker.affs.asleep and not target.defs.shielded and not target.defs.barrier and not target.defs.manipulation_aegis;
    end,

    postEffects = function(attacker, target, data)
        if (FLAGS[target.name .. "_direfrost"]) then

        else
            NU.setFlag(target.name .. "_direfrost", 0, 60, function() target.affs.direfrost = false; end);
        end
        attacker.vitals.resonance = "water";
    end,

}

-- TODO: Update to new resonance function
AB["Elemancy"]["Evaporate"] = {
    -- TODO: Room effects on ab use.
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 251;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.resonance = "fire";
    end,

}

AB["Elemancy"]["Flood"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 251;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 4}, target = {cost = 0}}
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.resonance = "water";
    end,

}

AB["Elemancy"]["Simultaneity"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,
    
    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            NU.appendFlag("misc_defs", "simultaneity", true);
        end
    end
}

AB["Elemancy"]["Direfrost"].syntax = {ascendril = "cast direfrost $target", bloodborn = ""};
AB["Elemancy"]["Evaporate"].syntax = {ascendril = "cast evaporate", bloodborn = ""};
AB["Elemancy"]["Flood"].syntax = {ascendril = "cast flood", bloodborn = ""};
AB["Elemancy"]["Simultaneity"].syntax = {ascendril = "simultaneity", bloodborn = ""};

for k,v in pairs(AB["Elemancy"]) do
    setmetatable(v, AB.abilityMetaTable);
end

