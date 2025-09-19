AB["Thaumaturgy"] = AB["Thaumaturgy"] or {};
local aGA = AB.addGenericAbility;

local function buildThaumaturgyRequirements(ignoreShield, cooldown)
    return function(at, tt, data)
        return AB.genericRequirements(at, tt, 2, false, nil, false, ignoreShield, cooldown, 0) and FLAGS.misc_defs and FLAGS.misc_defs.fulcrum_construct;
    end
end

local function testThaumaturgyRequirements(at, tt, ignoreShield, cooldown)
    return AB.genericRequirements(at, tt, 2, false, nil, false, ignoreShield, cooldown, 0) and FLAGS.misc_defs and FLAGS.misc_defs.fulcrum_construct;
end

AB["Thaumaturgy"]["Convergence"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 300;
    end,

    getCost = function() return 0, 40 end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 5}, target = {cost = 0}}

    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            NU.appendFlag("misc_defs", "fulcrum_harmony", true);
        end
    end,

    meetsPreReqs = function(attacker, target, data)
        return FLAGS.misc_defs and FLAGS.misc_defs.fulcrum_construct;
    end,
}


AB["Thaumaturgy"]["Inferno"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 1000;
    end,
    balance = function(attacker, target, data)
        return {self = {bal = "Secondary", cost = 8}, target = {cost = 0}}

    end,

    meetsPreReqs = function(attacker, target, data)
        return (TRACK.isSelf(attacker) and ((not FLAGS.glimpse or FLAGS.glimpse ~= "fire") and not FLAGS.glimpse_starting) or false) and (not attacker.affs.left_arm_crippled and not attacker.affs.right_arm_crippled) and not attacker.affs.FALLEN and not attacker.affs.asleep;
    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            if (data.empowerments[1] == "end") then
                NU.setFlag("glimpse", "fire", 70);
                NU.setFlag("next_glimpse_hit", NU.time() + 5.5, 5.5);
            else
                NU.setFlag("glimpse_starting", true, 4);
            end
        end
    end,
}

AB["Thaumaturgy"]["Calamity"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 500;
    end,
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,
    meetsPreReqs = function(attacker, target, data)
        return FLAGS.misc_defs and FLAGS.misc_defs.fulcrum_construct;
    end,
}

AB["Thaumaturgy"]["Vortex"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 400;
    end,
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}

    end,
    meetsPreReqs = function(attacker, target, data)
        return FLAGS.misc_defs and FLAGS.misc_defs.fulcrum_construct;
    end,
}

AB["Thaumaturgy"]["Schism"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 251;
    end,

    getCost = function() return 0, 25 end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            if (data.empowerments[1] == "on") then
                NU.appendFlag("misc_defs", "fulcrum_schism", true);
            elseif (FLAGS.misc_defs) then
                FLAGS.misc_defs.fulcrum_schism = nil;
            end
            --display(data);
        end
    end,

    meetsPreReqs = function(attacker, target, data)
        return FLAGS.misc_defs and FLAGS.misc_defs.fulcrum_construct;
    end,
}


AB["Thaumaturgy"]["Imbalance"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 251;
    end,

    getCost = function() return 0, 25 end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            if (data.empowerments and data.empowerments[1] == "on") then
                NU.appendFlag("misc_defs", "fulcrum_imbalance", true);
            elseif (FLAGS.misc_defs) then
                FLAGS.misc_defs.fulcrum_imbalance = nil;
            end
            --display(data);
        end
    end,

    meetsPreReqs = function(attacker, target, data)
        return FLAGS.misc_defs and FLAGS.misc_defs.fulcrum_construct;
    end,
}


AB["Thaumaturgy"]["Spiritrift"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 301;
    end,

    getCost = function() return 0, 25 end,

    balance = function(attacker, target, data)
        return { self = { bal = "equilibrium", cost = 2 }, target = { cost = 0 } }
    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            if (data.empowerments and data.empowerments[1] == "on") then
                NU.appendFlag("misc_defs", "fulcrum_spiritrift", true);
            elseif (FLAGS.misc_defs) then
                FLAGS.misc_defs.fulcrum_spiritrift = nil;
            end
            --display(data);
        end
    end,

    meetsPreReqs = function(attacker, target, data)
        return FLAGS.misc_defs and FLAGS.misc_defs.fulcrum_construct;
    end,
}

AB["Thaumaturgy"]["Degradation"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 210;
    end,

    getCost = function() return 0, 25 end,

    balance = function(attacker, target, data)
        return { self = { bal = "equilibrium", cost = 2 }, target = { cost = 0 } }
    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            if (data.empowerments and data.empowerments[1] == "on") then
                NU.appendFlag("misc_defs", "fulcrum_degradation", true);
            elseif (FLAGS.misc_defs) then
                FLAGS.misc_defs.fulcrum_degradation = nil;
            end
            --display(data);
        end
    end,

    meetsPreReqs = function(attacker, target, data)
        return FLAGS.misc_defs and FLAGS.misc_defs.fulcrum_construct;
    end,
}
AB["Thaumaturgy"]["Eruption"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 400;
    end,
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 5.8139534883721}, target = {cost = 0}}

    end,
    meetsPreReqs = function(attacker, target, data)
        return FLAGS.misc_defs and FLAGS.misc_defs.fulcrum_construct;
    end,
}

AB["Thaumaturgy"]["Push"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 400;
    end,
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}

    end,
    meetsPreReqs = function(attacker, target, data)
        return FLAGS.misc_defs and FLAGS.misc_defs.fulcrum_construct;
    end,
}

AB["Thaumaturgy"]["Typhoon"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 1000;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "secondary", cost = 8}, target = {cost = 0}}

    end,

    meetsPreReqs = function(attacker, target, data)
        return (TRACK.isSelf(attacker) and ((not FLAGS.glimpse or FLAGS.glimpse ~= "air") and not FLAGS.glimpse_starting) or false) and (not attacker.affs.left_arm_crippled and not attacker.affs.right_arm_crippled) and not attacker.affs.FALLEN and not attacker.affs.asleep;
    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            if (data.empowerments[1] == "end") then
                NU.setFlag("glimpse", "air", 70);
                NU.setFlag("next_glimpse_hit", NU.time() + 5.5, 5.5);
            else
                NU.setFlag("glimpse_starting", true, 4);
            end
        end
    end,
}

AB["Thaumaturgy"]["Maelstrom"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 1000;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "secondary", cost = 8}, target = {cost = 0}}

    end,

    meetsPreReqs = function(attacker, target, data)
        return (TRACK.isSelf(attacker) and ((not FLAGS.glimpse or FLAGS.glimpse ~= "water") and not FLAGS.glimpse_starting) or false) and (not attacker.affs.left_arm_crippled and not attacker.affs.right_arm_crippled) and not attacker.affs.FALLEN and not attacker.affs.asleep;
    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            if (data.empowerments[1] == "end") then
                NU.setFlag("glimpse", "water", 70);
                NU.setFlag("next_glimpse_hit", NU.time() + 5.5, 5.5);
            else
                NU.setFlag("glimpse_starting", true, 4);
            end
        end
    end,
}

AB["Thaumaturgy"]["Flare"] = {
    getTargetAffs = function(attacker, tt, data)
        local glimpse = FLAGS.glimpse;
        local affs = {};

        if (glimpse) then
            if (glimpse == "water" and tt.affs.frozen) then
                table.insert(affs, "FALLEN");
            elseif (glimpse == "fire" and tt.affs.ablaze) then
                -- TODO: Handle balance knocks.
            elseif (glimpse == "air" and tt.affs.muddled) then
                -- TODO: Handle mana drain.
            end
        end

        return affs;
    end,

    getDamage = function(attacker, target, data)
        return 0.1 * target.vitals.maxhp * 0.4, 0, 0, 100;
    end,

    meetsPreReqs = function(attacker, target, data)
        return (not attacker.affs.left_arm_crippled or not attacker.affs.right_arm_crippled) and not attacker.affs.FALLEN and not attacker.affs.asleep and not target.defs.shielded and not target.defs.barrier and not target.defs.manipulation_aegis;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "secondary", cost = 5}, target = {cost = 0}}
    end,
}

AB["Thaumaturgy"]["Shift"] = {
    getSelfDefs = function(attacker, target, data)
        return {"fulcrum_shift"};
    end,
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 251;
    end,
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3.4883720930233}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return not attacker.affs.asleep and not attacker.affs.FALLEN and FLAGS.fulcrum_expand and
            not (attacker.affs.left_arm_crippled and attacker.affs.right_arm_crippled) and not FLAGS.fulcrum_shift_cd;
    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            NU.setFlag("fulcrum_shift_cd", true, 20);
        end
    end
}

AB["Thaumaturgy"]["Restore"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 90;
    end,
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2.54}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return not attacker.affs.asleep and not FLAGS.fulcrum_restore_cd and FLAGS.misc_defs and FLAGS.misc_defs.fulcrum_construct;
    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            NU.setFlag("fulcrum_restore_cd", true, 20);
            TRACK.cureAction("You", "random");
        end
    end
}

AB["Thaumaturgy"]["Construct"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 672;
    end,
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 4}, target = {cost = 0}}

    end,
    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            NU.appendFlag("misc_defs", "fulcrum_construct", true);
        end
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 2, nil, nil, false, true, nil, nil) and FLAGS.misc_defs and FLAGS.misc_defs.simultaneity;
    end
}

AB["Thaumaturgy"]["Alert"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 400;
    end,
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}

    end,
}

AB["Thaumaturgy"]["Enrapture"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 5.5}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return (not attacker.affs.left_arm_crippled or not attacker.affs.right_arm_crippled) and not attacker.affs.FALLEN and not attacker.affs.asleep and not target.defs.shielded and not target.defs.barrier and not target.defs.manipulation_aegis and target.affs.PRONE;
    end,

    channel = function(st, tt, data)
        return (data.empowerments and data.empowerments[1] == "start") and 7 or 0;
    end
}

aGA("Thaumaturgy", "Enrich", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 400},
    epWpCost = function(st, tt) return 0, 40 end,
    bal = function(st, tt, _)
            return {self = {bal = "equilibrium", cost = 0}, target = {cost = 0}};
    end,
    reqs = function(st, tt, _) return testThaumaturgyRequirements(st, nil, true) and NU.offCD(st.name .. "_Fulcrum_Enrich"); end,
    syntax = {ascendril = "fulcrum enrich $element", bloodborn = ""}
})


aGA("Thaumaturgy", "Interfuse", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 100},
    epWpCost = function(st, tt) return 0, 10 end,
    bal = function(st, tt, _)
            return {self = {bal = "equilibrium", cost = 3.5}, target = {cost = 0}};
    end,
    onUseEffects = function(st, tt, _) NU.clearFlag(st.name .. "_fulcrum_expand"); end,
    reqs = function(st, tt, _) return testThaumaturgyRequirements(st, nil, true) and FLAGS.fulcrum_expand; end,
    syntax = {ascendril = "fulcrum interfuse", bloodborn = ""}
})


aGA("Thaumaturgy", "Expand", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 481},
    epWpCost = function(st, tt) return 0, 50 end,
    bal = function(st, tt, _)
            return {self = {bal = "equilibrium", cost = 0}, target = {cost = 0}};
    end,
    onUseEffects = function(st, tt, _) NU.setFlag(st.name .. "_fulcrum_expand", true, 360); end,
    reqs = function(st, tt, _) return testThaumaturgyRequirements(st, nil, true) and not FLAGS[st.name .. "_fulcrum_expand"]; end,
    syntax = {ascendril = "fulcrum expand", bloodborn = ""}
})

local brandMap = {
    frost = "frostbrand",
    ember = "emberbrand",
    thunder = "thunderbrand",
}

aGA("Thaumaturgy", "Branding", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 481},
    epWpCost = function(st, tt) return 0, 50 end,
    affs = function(st, tt, data)
        if (data.empowerments and data.empowerments[1]) then
            return {brandMap[data.empowerments[1]]};
        end
        return {};
    end,
    bal = function(st, tt, _)
            return {self = {bal = "equilibrium", cost = 0}, target = {cost = 0}};
    end,
    onUseEffects = function(st, tt, _) st.vitals.resonance = "none"; end,
    reqs = function(st, tt, data) return testThaumaturgyRequirements(st, nil, true) and not FLAGS.fulcrum_expand; end,
    syntax = {ascendril = "fulcrum branding $target $brand", bloodborn = ""}
})

AB["Thaumaturgy"]["Convergence"].syntax = {ascendril = "fulcrum convergence", bloodborn = ""};
AB["Thaumaturgy"]["Flare"].syntax = {ascendril = "fulcrum $empowerment $target", bloodborn = ""};
AB["Thaumaturgy"]["Restore"].syntax = {ascendril = "fulcrum restore", bloodborn = ""};
AB["Thaumaturgy"]["Inferno"].syntax = {ascendril = "fulcrum glimpse fire", bloodborn = ""};
AB["Thaumaturgy"]["Calamity"].syntax = {ascendril = "fulcrum calamity $empowerment", bloodborn = ""};
AB["Thaumaturgy"]["Vortex"].syntax = {ascendril = "fulcrum vortex on", bloodborn = ""};
AB["Thaumaturgy"]["Schism"].syntax = {ascendril = "fulcrum schism on", bloodborn = ""};
AB["Thaumaturgy"]["Imbalance"].syntax = {ascendril = "fulcrum imbalance on", bloodborn = ""};
AB["Thaumaturgy"]["Spiritrift"].syntax = { ascendril = "fulcrum spiritrift on", bloodborn = "" };
AB["Thaumaturgy"]["Degradation"].syntax = { ascendril = "fulcrum degradation on", bloodborn = "" };
AB["Thaumaturgy"]["Eruption"].syntax = {ascendril = "fulcrum eruption", bloodborn = ""};
AB["Thaumaturgy"]["Push"].syntax = {ascendril = "fulcrum push $target", bloodborn = ""};
AB["Thaumaturgy"]["Typhoon"].syntax = {ascendril = "fulcrum glimpse air", bloodborn = ""};
AB["Thaumaturgy"]["Maelstrom"].syntax = {ascendril = "fulcrum glimpse water", bloodborn = ""};
AB["Thaumaturgy"]["Shift"].syntax = {ascendril = "fulcrum shift", bloodborn = ""};
AB["Thaumaturgy"]["Construct"].syntax = {ascendril = "fulcrum construct", bloodborn = ""};
AB["Thaumaturgy"]["Alert"].syntax = {ascendril = "fulcrum alert", bloodborn = ""};
AB["Thaumaturgy"]["Enrapture"].syntax = {ascendril = "fulcrum enrapture $target", bloodborn = ""};
