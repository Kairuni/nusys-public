AB["Weaving"] = AB["Weaving"] or {};

AB["Weaving"]["Runeband"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and not FLAGS[target.name .. "_runeband"] and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        NU.setFlag(target.name .. "_runeband", 1, 16);
        NU.setFlag(target.name .. "_runeband_last", "clumsiness", 16);
        attacker.vitals.dithering = 3;
    end,

    syntax = {bard = "weave runeband $target"},
}

AB["Weaving"]["Aurora"] = {
    getSelfDefs = function(attacker, target, data)
        return {"aurora"};
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    syntax = {bard = "weave aurora"},
}

AB["Weaving"]["Tearing"] = {
    getDamage = function(attacker, target, data)
        return 0.2 * target.vitals.maxhp * 0.4, 0, 0, 75;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.dithering = 1;
    end,

    syntax = {bard = "weave tearing $target"},
}

AB["Weaving"]["Starfall"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 0;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        NU.setFlag("starfall", true, 15);
        attacker.vitals.dithering = 1;
    end,

    syntax = {bard = "weave starfall"},
}


AB["Weaving"]["Facsimile"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.dithering = 0;
    end,

    syntax = {bard = "weave facsimile $target"},
}

AB["Weaving"]["Image"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        NU.setFlag(attacker.name .. "_image", true, 30);
        attacker.vitals.dithering = 2;
    end,

    syntax = {bard = "weave image $target"},
}

AB["Weaving"]["Nullstone"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        NU.setFlag(attacker.name .. "_nullstone", 1, 60);
        attacker.vitals.dithering = 1;
    end,

    syntax = {bard = "weave nullstone"},
}

AB["Weaving"]["Swindle"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return FLAGS[target .. "_globes"] and attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.dithering = 5;
    end,

    syntax = {bard = "weave swindle $target"},
}

AB["Weaving"]["Globes"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2.5}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        NU.setFlag(target.name .. "_globes", {"dizziness", "confusion", "perplexity"}, 180);
        attacker.vitals.dithering = 0;
    end,

    syntax = {bard = "weave globes $target"},
}

AB["Weaving"]["Headstitch"] = {
    getTargetAffs = function(attacker, target, data)
        return {"besilence", "deadening"};
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2.6}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.dithering = 1;
    end,

    syntax = {bard = "weave headstitch $target"},
}

AB["Weaving"]["Anelace"] = {
    getTargetAffs = function(attacker, target, data)
        if (data.empowerments and data.empowerments[1] == "stab") then
            return {"hollow", "narcolepsy"};
        else
            return {};
        end
    end,

    getDamage = function(attacker, target, data)
        if (target) then
            return 0.1 * target.vitals.maxhp * 0.4, 0, 0, 0;
        else
            return 0, 0, 0, 0;
        end
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        if (target) then
            return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
        else
            return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, nil, 1, false, false, false);
        end
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.dithering = 2;
        if (target) then
            local val = FLAGS.wove_anelace;
            if (val and val > 1) then
                FLAGS.wove_anelace = val - 1;
            else
                NU.clearFlag("wove_anelace");
            end
        else
            if (TRACK.isSelf(attacker)) then
                NU.setFlag("wove_anelace", FLAGS.wove_anelace and FLAGS.wove_anelace + 1 or 1, 120);
            end
        end
    end,

    syntax = {bard = "quickwield left anelace" .. NU.config.separator .. "stab $target"},
}

AB["Weaving"]["Weave_Anelace"] = {
    balance = AB["Weaving"]["Anelace"].balance,
    meetsPreReqs = AB["Weaving"]["Anelace"].meetsPreReqs,
    syntax = {bard = "weave anelace"},
}


AB["Weaving"]["Barbs"] = {
    getTargetAffs = function(attacker, target, data)
        return {"manabarbs"};
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.dithering = 2;
    end,

    syntax = {bard = "weave barbs $target"},
}

AB["Weaving"]["Boundary"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        NU.appendFlag("bard_boundaries", gmcp.Room.Info.num, false, 420);
        attacker.vitals.dithering = 2;
    end,

    syntax = {bard = "weave boundary"},
}

AB["Weaving"]["Thurible"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        NU.setFlag(attacker.name .. "_thurible", "held", 60);
        attacker.vitals.dithering = 3;
    end,

    syntax = {bard = "weave thurible"},
}

AB["Weaving"]["Polarity"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and FLAGS.boundary and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.dithering = 2;
    end,

    syntax = {bard = "weave polarity $target"},
}

AB["Weaving"]["Bladestorm"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and not FLAGS[target.name .. "_bladestorm"] and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.dithering = 2;
        NU.setFlag(target.name .. "_bladestorm", 3, 60);
    end,

    syntax = {bard = "weave bladestorm $target"},
}

AB["Weaving"]["Ironcollar"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and not FLAGS[target.name .. "_ironcollar"] and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.dithering = 2;
        NU.setFlag(target.name .. "_ironcollar", 1, 60);
    end,

    syntax = {bard = "weave ironcollar $target"},
}

AB["Weaving"]["Mindbreak"] = {
    getTargetAffs = function(attacker, target, data)
        return {"squelched", "migraine"};
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.dithering = 1;
    end,

    syntax = {bard = "weave mindbreak $target"},
}

AB["Weaving"]["Heartcage"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 4}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        local hasBoundary = false;
        if (FLAGS.bard_boundaries) then
            local n = table.index_of(FLAGS.bard_boundaries, gmcp.Room.Info.num);
            if (n) then hasBoundary = true; end
        end

        local emotion = FLAGS[target.name .. "_major_emotion"];

        if (emotion == "neutral") then return false; end


        local emotionMet = emotion and (FLAGS[target.name .. "_" .. emotion] >= 50) or false;

        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false)
            and target.affs.FALLEN and FLAGS[target.name .. "_ironcollar"] and hasBoundary and emotionMet
            and not FLAGS.heartcage_forming and not FLAGS.heartcage_held;
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.dithering = 5;
        if (TRACK.isSelf(attacker)) then
            NU.setFlag("heartcage_forming", target.name, 20);
        end
    end,

    syntax = {bard = "weave heartcage $target"},
}

AB["Weaving"]["Soundblast"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return attacker.vitals.dithering == 0 and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        attacker.vitals.dithering = 2;
    end,

    syntax = {bard = "weave soundblast"},
}

--abilities["Weaving"][""] = {
--    getTargetAffs = function(attacker, target, data)
--        return {};
--    end,

--    getDamage = function(attacker, target, data)
--        return 0.1 * target.vitals.maxhp * 0.4, 0, 0, 0;
--    end,

--    balance = function(attacker, target, data)
--        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
--    end,

--    meetsPreReqs = function(attacker, target, data)
--        return attacker.vitals.dithering == 0 and abilities.genericRequirements(attacker, target, 2, false, false, false);
--    end,

--    postEffects = function(attacker, target, data)

--    end,
--}

