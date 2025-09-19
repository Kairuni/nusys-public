AB["Performance"] = AB["Performance"] or {};

-- TODO: Bard revamp, this is extremely broken due to AB.genericRequirements updates over time.
AB["Performance"]["Tempo"] = {
    getDamage = function(attacker, target, data)
        return 0.23, 0, 0, 151;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 2.05}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return not FLAGS.skip_tempo and AB.genericRequirements(attacker, target, 1, false, true, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
        NU.setFlag("skip_tempo", true, 3);
    end,

    syntax = {bard = "tempo $target $empowerment"};
}

AB["Performance"]["Rhythm"] = {
    getDamage = function(attacker, target, data)
        return 0.2 * target.vitals.maxhp * 0.4, 0, 0, 151;
    end,

    postEffects = function(attacker, target, data)
        NU.setFlag("skip_tempo", true, 2);
    end,
}

AB["Performance"]["Needle"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 1}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, true, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
        if (not FLAGS.needle_venom and TRACK.isSelf(attacker) and #data.empowerments > 0 and data.empowerments[1] ~= "dodge") then
            NU.setFlag("needle_venom", data.empowerments[1], 5);
        end
    end,

    syntax = {bard = "needle $target $empowerment"};
}

AB["Performance"]["Charisma"] = {
    getSelfDefs = function(attacker, target, data)
        return {"charisma"};
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, false, false);
    end,

    syntax = {bard = "charisma"},
}

AB["Performance"]["Equipoise"] = {
    getSelfDefs = function(attacker, target, data)
        return {"equipoise"};
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, false, false);
    end,

    syntax = {bard = "equipoise on"},
}

AB["Performance"]["Tolerance"] = {
    getSelfDefs = function(attacker, target, data)
        return {"tolerance"};
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 4}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, false, false);
    end,

    syntax = {bard = "tolerance"},
}

AB["Performance"]["Seduce"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 2}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
    end,

    syntax = {bard = "seduce $target"},
}

AB["Performance"]["Deflect"] = {
    getSelfDefs = function(attacker, target, data)
        return {"deflecting"};
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
    end,

    syntax = {bard = "deflect $target"},
}

AB["Performance"]["Quip"] = {
    getTargetAffs = function(attacker, target, data)
        return {"hatred"};
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 2}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
    end,

    syntax = {bard = "quip $target"},
}

AB["Performance"]["Stretching"] = {
    getSelfDefs = function(attacker, target, data)
        return {"stretching"};
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
    end,

    syntax = {bard = "stretching on"},
}

AB["Performance"]["Tackle"] = {
    getTargetAffs = function(attacker, target, data)
        return {"FALLEN"};
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
    end,

    syntax = {bard = "tackle $target"},
}

AB["Performance"]["Sock"] = {
    getTargetAffs = function(attacker, target, data)
        return AB.linearStack(target, {"dizziness", "dazed"});
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
        if (target.affs.dazed) then
            NU.setFlag("sock_movement", true, 3);
        end
    end,

    syntax = {bard = "sock $target"},
}

AB["Performance"]["Harry"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 2}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, true, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
    end,

    syntax = {bard = "harry $target $empowerment"},
}

AB["Performance"]["Ridicule"] = {
    getTargetAffs = function(attacker, target, data)
        if (TRACK.numAffs(target) >= 3) then
            return {"self_loathing", "magnanimity"}
        else
            return {"self_loathing"}
        end
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 2.05}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
    end,

    syntax = {bard = "ridicule $target"},
}

AB["Performance"]["Hiltblow"] = {
    getTargetAffs = function(attacker, target, data)
        return { "clumsiness", "misery" };
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 2.05}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return not FLAGS.skip_tempo and AB.genericRequirements(attacker, target, 1, false, true, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
    end,

    syntax = {bard = "hiltblow $target"},
    canHitRebounding = true,
}

AB["Performance"]["Crackshot"] = {
    getTargetAffs = function(attacker, target, data)
        return {"dizziness", "perplexity"};
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 3}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
    end,

    syntax = {bard = "crackshot $target"},
}

AB["Performance"]["Pierce"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 3}, target = {cost = 0}}
    end,

    canHitRebounding = true,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
        target.defs[data.empowerments[1]] = false;
    end,

    syntax = {bard = "pierce $target"},
}

AB["Performance"]["Bravado"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 2.4}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, true, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
        NU.setFlag("bravado_cd", NU.time() + 11, 11);
    end,

    syntax = {bard = "bravado $target $empowerment"},
}

AB["Performance"]["Cadence"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "balance", cost = 2.4}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return AB.genericRequirements(attacker, target, 1, false, true, false);
    end,

    postEffects = function(attacker, target, data)
        if (attacker.vitals.dithering and attacker.vitals.dithering > 0) then
            attacker.vitals.dithering = attacker.vitals.dithering - 1;
        end
    end,

    syntax = {bard = "cadence $target"},
}