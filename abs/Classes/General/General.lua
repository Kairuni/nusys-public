AB.Avoidance = {};
AB.Hunting = {};

AB["Avoidance"]["Nimbleness"] = {
    getSelfDefs = function(attacker, target, data)
        return {"nimbleness"};
    end,

    meetsPreReqs = function(attacker, target, data)
        return not FLAGS.nimbleness_cd;
    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            NU.setFlag("nimbleness_cd", NU.time() + 60, 60);
        end
    end
}

AB["Hunting"]["Fitness"] = {
    getSelfDefs = function(attacker, target, data)
        return {"nimbleness"};
    end,

    meetsPreReqs = function(attacker, target, data)
        return not FLAGS.fitness_cd;
    end,

    postEffects = function(attacker, target, data)
        TRACK.cure(attacker, "asthma");
        TRACK.aff(attacker, "exhaustion");
        if (TRACK.isSelf(attacker)) then
            NU.setFlag("fitness_cd", NU.time() + 20, 20);
        end
    end
}