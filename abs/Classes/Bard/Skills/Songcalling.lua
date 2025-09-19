AB["Songcalling"] = AB["Songcalling"] or {};

local function songBalance(attacker, target, data)
    return {self = {bal = "equilibrium", cost = FLAGS.halfbeat_active and 2 or 4}, target = {cost = 0}}
end

AB["Songcalling"]["Charity"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return ((data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false)) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "charity", 10);
        else
            NU.setFlag("singing", "charity", 10);
        end
    end,

    syntax = {bard = "sing song of Charity"};
}


AB["Songcalling"]["Fascination"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "fascination", 10);
        else
            NU.setFlag("singing", "fascination", 10);
        end
    end,

    syntax = {bard = "sing song of Fascination"};
}


AB["Songcalling"]["Feasting"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "feasting", 10);
        else
            NU.setFlag("singing", "feasting", 10);
        end
    end,

    syntax = {bard = "sing song of Feasting"};
}


AB["Songcalling"]["Decadence"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "decadence", 10);
        else
            NU.setFlag("singing", "decadence", 10);
        end
    end,

    syntax = {bard = "sing song of Decadence"};
}


AB["Songcalling"]["Sorrow"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "sorrow", 10);
        else
            NU.setFlag("singing", "sorrow", 10);
        end
    end,

    syntax = {bard = "sing song of Sorrow"};
}


AB["Songcalling"]["Merriment"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "merriment", 10);
        else
            NU.setFlag("singing", "merriment", 10);
        end
    end,

    syntax = {bard = "sing song of Merriment"};
}


AB["Songcalling"]["Doom"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "doom", 10);
        else
            NU.setFlag("singing", "doom", 10);
        end
    end,

    syntax = {bard = "sing song of Doom"};
}


AB["Songcalling"]["Foundation"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "foundation", 10);
        else
            NU.setFlag("singing", "foundation", 10);
        end
    end,

    syntax = {bard = "sing song of Foundation"};
}


AB["Songcalling"]["Destiny"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "destiny", 10);
        else
            NU.setFlag("singing", "destiny", 10);
        end
    end,

    syntax = {bard = "sing song of Destiny"};
}


AB["Songcalling"]["Tranquility"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "tranquility", 10);
        else
            NU.setFlag("singing", "tranquility", 10);
        end
    end,

    syntax = {bard = "sing song of Tranquility"};
}


AB["Songcalling"]["Awakening"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "awakening", 10);
        else
            NU.setFlag("singing", "awakening", 10);
        end
    end,

    syntax = {bard = "sing song of Awakening"};
}


AB["Songcalling"]["Harmony"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "harmony", 10);
        else
            NU.setFlag("singing", "harmony", 10);
        end
    end,

    syntax = {bard = "sing song of Harmony"};
}


AB["Songcalling"]["Remembrance"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "remembrance", 10);
        else
            NU.setFlag("singing", "remembrance", 10);
        end
    end,

    syntax = {bard = "sing song of Remembrance"};
}


AB["Songcalling"]["Unheard"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "unheard", 10);
        else
            NU.setFlag("singing", "unheard", 10);
        end
    end,

    syntax = {bard = "sing song of The Unheard"};
}


AB["Songcalling"]["Hero"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "hero", 10);
        else
            NU.setFlag("singing", "hero", 10);
        end
    end,

    syntax = {bard = "sing song of The Hero"};
}


AB["Songcalling"]["Fate"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "fate", 10);
        else
            NU.setFlag("singing", "fate", 10);
        end
    end,

    syntax = {bard = "sing song of Fate"};
}


AB["Songcalling"]["Oblivion"] = {
    balance = songBalance;

    meetsPreReqs = function(attacker, target, data)
        return (data.empowerments and data.empowerments[1] == "play") and AB.genericRequirements(attacker, target, 2, false, false, false) or (AB.genericRequirements(attacker, target, 0, false, false, false) and not attacker.affs.crippled_throat and not attacker.affs.crushed_throat and not attacker.affs.destroyed_throat);
    end,

    postEffects = function(attacker, target, data)
        if (data and data.empowerments[1] == "play") then
            NU.setFlag("playing", "oblivion", 10);
        else
            NU.setFlag("singing", "oblivion", 10);
        end
    end,

    syntax = {bard = "sing song of Oblivion"};
}

AB["Songcalling"]["Induce"] = {
    meetsPreReqs = function(attacker, target, data)
        return (FLAGS.playing or FLAGS.singing) and AB.genericRequirements(attacker, target, 2, false, false, false);
    end,

    postEffects = function(attacker, target, data)
        if (data.empowerments) then
            NU.setFlag(target.name .. "_major_emotion", data.empowerments[1], 500);
        end
    end,

    syntax = {bard = "induce $empowerment in $target"};
}

local aGA = AB.addGenericAbility;
aGA("Songcalling", "Euphonia", {
    ep = 0, wp = 50,
    bal = {bal = "equilibrium", cost = 1},
    defs = {"euphonia"},
    defensive = true,
    arms = 2, legs = 0,
    syntax = {bard = "euphonia"}
})

aGA("Songcalling", "Discordance", {
    ep = 0, wp = 50,
    bal = {bal = "equilibrium", cost = 1},
    defs = {"discordance"},
    defensive = true,
    arms = 2, legs = 0,
    syntax = {bard = "discordance"}
})

aGA("Songcalling", "Halfbeat", {
    ep = 0, wp = 50,
    bal = {bal = "equilibrium", cost = 1},
    defs = {"halfbeat"},
    defensive = true,
    arms = 2, legs = 0,
    syntax = {bard = "halfbeat"}
})