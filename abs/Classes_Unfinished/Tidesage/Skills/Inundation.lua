local aGA = AB.addGenericAbility;

local function inundationPreReqs(arms, legs, noShield, canFallen)

    return function(attacker, target, _)
        local room = gmcp.Room.Info.num;
        local fogExists = FLAGS.my_fog_rooms and FLAGS.my_fog_rooms[room] or false;

        return fogExists and AB.genericRequirements(attacker, target, arms, false, false, canFallen, noShield or false, nil, legs);
    end
end

-- TODO: Fill in the blanks with the above.

aGA("Inundation", "Hydrate", {
    bal = {bal = "equilibrium", cost = 3.0},
    onUseEffects = function(stable, _, _) end, -- any effect when ab is used, even if unsuccessful
    reqs = inundationPreReqs(0, 0, true, true),
    syntax = {tidesage = "fog hydrate", Terradrim = "sand scour"}
});

aGA("Inundation", "Inundate", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3},
    onUseEffects = function(stable, ttable, data) local room = gmcp.Room.Info.num; if (stable == TRACK.getSelf()) then NU.appendFlag("my_fog_rooms", room, true); end end, -- any effect when ab is used, even if unsuccessful
    noShield = true, arms = 1, legs = 0, reqs = nil,
    syntax = {tidesage = "fog inundate", Terradrim = "sand flood"}
});

aGA("Inundation", "Drift", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2},
    onUseEffects = function(stable, ttable, data) end, -- Target leaves the room, though this might not need tracking
    reboundable = nil, noShield = true,
    reqs = function(at, tt, data) end,
    syntax = {tidesage = "fog drift $direction", Terradrim = "sand sandwalk $direction"}
});

aGA("Inundation", "Swell", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 4},
    onUseEffects = function(stable, ttable, data)
        if (data.empowerments) then
            for _, exit in ipairs(data.empowerments) do
                local roomExits = getRoomExits(gmcp.Room.Info.num);
                if (roomExits) then
                    if (roomExits[exit]) then
                        NU.appendFlag("my_fog_rooms", roomExits[exit], true);
                    end
                end
            end
        end
    end, -- Data 'empowerment' will be 'direction' - detect which room that should be based on map data, set that flag as in inundate.
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog swell $direction", Terradrim = "sand surge $direction"}
});

aGA("Inundation", "Snare", {
    ep = 0, wp = 0,
    affs = {"fog_snared"},
    bal = {bal = "equilibrium", cost = 4.0},
    cooldown = 20, attackType = nil,
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog snare $target", Terradrim = "sand trap $target"},
    onUseEffects = function(stable, ttable, data) NU.setFlag(ttable.name .. "_fog_snared", true, 40, function() TRACK.cure(ttable, "fog_snared"); end) end,
});

aGA("Inundation", "Intruders", {
    ep = 0, wp = 0,
    bal = {bal = "balance", cost = 0},
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog intruders", Terradrim = "sand presences"} -- Prints out a list of people in your fog.
});

aGA("Inundation", "Revel", { -- wp regen over time, probably don't actually need this.
    ep = 0, wp = 0,
    dmgType = "unblockable",
    bal = {bal = "equilibrium", cost = 1},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog revel", Terradrim = "sand ruminate"}
});

aGA("Inundation", "Apparition", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 4},
    reqs = function(st, tt, data) return st.vitals.apparition == 0 and st.vitals.sandstorm == 0 and AB.genericRequirements(st, tt, 1, false, false, false, true, nil, 0) end,
    syntax = {tidesage = "fog apparition", Terradrim = "sand sandstorm"}
});

aGA("Inundation", "Obscure", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 1.0},
    defs = {"fog_obscure"},
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog obscure on", Terradrim = "sand concealment on"}
});

-- TODO: Find a Teradrim or Shaman or Alchemist to test this one.
aGA("Inundation", "Negate", {
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
    syntax = {tidesage = "fog negate", Terradrim = "sand dominion"}
});

-- TODO: Get the lines for this and update eq/etc.
aGA("Inundation", "Switch", {
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
    syntax = {tidesage = "fog switch", Terradrim = "sand shift"}
});

aGA("Inundation", "Fluctuations", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2.5},
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    defs = {"fluctuations"},
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog fluctuations on", Terradrim = "sand disturbances on"}
});

aGA("Inundation", "Hail", {
    dmg = {eH = 1, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    dmgType = "cutting",
    bal = {bal = "equilibrium", cost = 4.0},
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog hail", Terradrim = "sand blast"}
});

aGA("Inundation", "Chase", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 5.0},
    affs = function(stable, ttable, data)
        return {}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog chase $target", Terradrim = "sand simoon $target"}
});

-- TODO: Some mechanism for fog room effect tracking. Will help for Shaman, too.
aGA("Inundation", "Effervesce", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2.0},
    onUseEffects = function(stable, ttable, data) end, -- Set a flag for the current fog room that makes it so it can't be scented.
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog effervesce", Terradrim = "sand distort"}
});

aGA("Inundation", "Harden", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 4.0},
    defs = {"shielded"},
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog harden", Terradrim = "sand shield"}
});

aGA("Inundation", "Sirensong", {
    ep = 0, wp = 0,
    bal = {bal = "balance", cost = 2.0},
    defs = {"sirensong"},
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog sirensong on", Terradrim = "sand swelter on"}
});

-- TODO: Some mechanism for fog room effect tracking. Will help for Shaman, too.
aGA("Inundation", "Befuddle", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2.0},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog befuddle", Terradrim = "sand confound"}
});

aGA("Inundation", "Panoptic", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2.5},
    defs = {"panoptic"},
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog panoptic on", Terradrim = "sand projection on"}
});

aGA("Inundation", "Ebb", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3.5},
    onUseEffects = function(stable, ttable, data) local room = gmcp.Room.Info.num; if (stable == TRACK.getSelf() and FLAGS.my_fog_rooms) then FLAGS.my_fog_rooms[room] = nil; end end,
    reboundable = nil, noShield = true, arms = 2, legs = 0,
    reqs = nil, -- TODO: Custom prereqs function for inundation skills that require fog in room.
    syntax = {tidesage = "fog ebb", Terradrim = "sand wave"}
});


-- TODO: Some mechanism for fog room effect tracking. Will help for Shaman, too.
-- Lowers celerity and stops dash.
aGA("Inundation", "Murk", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog murk", Terradrim = "sand instability"}
});

-- TODO: Some mechanism for fog room effect tracking. Will help for Shaman, too.
-- Damage if they get proned without levitation.
aGA("Inundation", "Stalagmites", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2.0},
    onUseEffects = function(stable, ttable, data) end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog stalagmites", Terradrim = "sand spikes"}
});

-- Spread fog to all adjacent rooms.
aGA("Inundation", "Fogbank", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 6.5},
    onUseEffects = function(stable, ttable, data)
        local roomExits = getRoomExits(gmcp.Room.Info.num);
        if (roomExits) then
            for exit, destination in pairs(roomExits) do
                NU.appendFlag("my_fog_rooms", destination, true);
            end
        end
    end, -- any effect when ab is used, even if unsuccessful
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog bank", Terradrim = "sand desert"}
});

aGA("Inundation", "Gyre", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 0},
    onUseEffects = function(stable, ttable, data)
        local room = gmcp.Room.Info.num;
        local fogExists = FLAGS.my_fog_rooms and FLAGS.my_fog_rooms[room] or false;

        if (fogExists) then
            FLAGS.my_fog_rooms[room] = nil;
        end
        NU.setFlag(stable.name .. "_apparition", 4);
    end,
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog gyre", Terradrim = "sand whirl"}
});

aGA("Inundation", "Blanket", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 4},
    defs = {"fog_blanket"},
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog blanket me", Terradrim = "sand "} -- Targetable, but I'm going to be lazy for this for now.
});

aGA("Inundation", "Subsume", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2},
    defs = {"barrier"},
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog subsume", Terradrim = "sand meld"}
});

-- Probably only manual for ranged stuff.
aGA("Inundation", "Glacier", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 0},
    onUseEffects = function(stable, ttable, data) end,
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog glacier", Terradrim = "sand pillar"}
});

aGA("Inundation", "Gnash", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 2.51},
    affs = function(stable, ttable, data)
        return {}, {"recklessness", "dizziness", "sensitivity", "epilepsy", "stupidity"}, 1;
    end,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog gnash $target $empowerment", Terradrim = "sand whip $target $empowerment"}
});

aGA("Inundation", "Unseen", {
    dmg = {eH = 3, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    dmgType = "cutting",
    bal = {bal = "equilibrium", cost = 2},
    affs = function(stable, ttable, data)
        display(data);
        -- Cripples the limb in data, or random if you're the target.
        local affs = data.limb and {data.limb:gsub(" ", "_") .. "_crippled"} or {};
        return affs, {"left_arm_crippled", "right_arm_crippled", "left_leg_crippled", "right_leg_crippled"}, 1; -- Visible, hidden possibilities, hidden count
    end,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog unseen $target $empowerment", Terradrim = "sand scourge $target $empowerment"}
});

aGA("Inundation", "Abyss", {
    ep = 0, wp = 0,
    bal = {bal = "equilibrium", cost = 3},
    reboundable = nil, noShield = true, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog abyss $target $empowerment", Terradrim = "sand slice $target $empowerment"}
});

aGA("Inundation", "Feelers", {
    dmg = {eH = 3, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    dmgType = "cutting",
    bal = {bal = "equilibrium", cost = 3.0},
    limbs = function(attacker, target, data)
        return {[data.limb] = 7.0};
    end,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog feelers $target $limb $empowerment", Terradrim = "sand shred $target $limb $empowerment"}
});

aGA("Inundation", "Terrors", {
    dmg = {eH = 3, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    dmgType = "cutting",
    bal = {bal = "equilibrium", cost = 3.0},
    affs = function(stable, ttable, data)
        return {"slough"}, {}, 0; -- Visible, hidden possibilities, hidden count
    end,
    reboundable = nil, noShield = nil, arms = 2, legs = 0, reqs = nil,
    syntax = {tidesage = "fog terrors $target $empowerment", Terradrim = "sand curse $target $empowerment"},
    onUseEffects = function(stable, ttable, data) NU.setFlag(ttable.name .. "_slough", true, 16, function() TRACK.cure(ttable, "slough"); end) end,
});

aGA("Inundation", "Undertow", {
    dmg = {eH = 4, eM = 0, sH = 0, sM = 0},
    ep = 0, wp = 0,
    dmgType = "cutting",
    bal = {bal = "equilibrium", cost = 3},
    -- TODO: Strips levitation, but need to test how long the strip lasts for.
    onUseEffects = function(stable, ttable, data) NU.setFlag(ttable.name .. "_undertow", NU.time() + 20, 20); end, -- any effect when ab is used, even if unsuccessful
    reqs = nil,
    syntax = {tidesage = "fog undertow $target $empowerment", Terradrim = "sand quicksand $target $empowerment"}
});