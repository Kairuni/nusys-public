AB["Arcanism"] = AB["Arcanism"] or {};


AB["Arcanism"]["Arcaneskin"] = {
    getSelfDefs = function(attacker, target, data)
        return {"arcaneskin"};
    end,

    getDamage = function(attacker, target, data)
        return 0, 0, 0, 75;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3.5}, target = {cost = 0}}
    end,
}

AB["Arcanism"]["Observation Glyph"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 100;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Gravity Glyph"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 300;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Ensorcell"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 100;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 5}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Countercurrent"] = {
    getSelfDefs = function(attacker, target, data)
        return {"countercurrent"};
    end,

    getDamage = function(attacker, target, data)
        return 0, 0, 0, 200;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Entrapment Glyph"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 100;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Mirage"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 1000;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 6}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Arrogance Glyph"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 200;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Vivacity"] = {
    getSelfDefs = function(attacker, target, data)
        return { "empowered_board" };
    end,

    getDamage = function(attacker, target, data)
        return 0, 0, 0, 51;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Missiles"] = {
    getSelfDefs = function(attacker, target, data)
        return {"missiles"};
    end,

    getDamage = function(attacker, target, data)
        return 0, 0, 0, 51;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,
}

AB["Arcanism"]["Reflection"] = {
    getSelfDefs = function(attacker, target, data)
        return {"reflection"};
    end,

    getDamage = function(attacker, target, data)
        return 0, 0, 0, 51;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,

    meetsPreReqs = function(attacker, target, data)
        return not FLAGS.reflection_charges or FLAGS.reflection_charges < 3;
    end,

    onUseEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            if (FLAGS.reflection_charges) then
                FLAGS.reflection_charges = FLAGS.reflection_charges + 1;
            else
                NU.setFlag("reflection_charges", 1, 240);
            end
        end
    end
}


AB["Arcanism"]["River"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 200;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3.5}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Addling Glyph"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 300;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Irritation Glyph"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 100;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Clarity Glyph"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 300;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Manatap"] = {
    meetsPreReqs = function(st, tt, data)
        return AB.genericRequirements(st, tt, 1, false, nil, false, true, nil, 0);
    end,
    defensive = true,
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,
}

AB["Arcanism"]["Destruction Glyph"] = {
    getTargetAffs = function(attacker, target, data)
        local affList = {};
        for _,v in ipairs(data.empowerments) do
            table.insert(affList, v);
        end
        return affList;
    end,

    getDamage = function(attacker, target, data)
        return 0, 0, 0, 200;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Leaching Glyph"] = {
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 200;
    end,

    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 3}, target = {cost = 0}}
    end,

}

AB["Arcanism"]["Arcaneskin"].syntax = {ascendril = "cast arcaneskin", bloodborn = ""};
AB["Arcanism"]["Observation Glyph"].syntax = {ascendril = "trace observation", bloodborn = ""};
--abilities["Arcanism"]["Dispel"].syntax = {ascendril = "cast dispel here", bloodborn = ""};
AB["Arcanism"]["Gravity Glyph"].syntax = {ascendril = "trace gravity", bloodborn = ""};
AB["Arcanism"]["Ensorcell"].syntax = {ascendril = "cast ensorcell aegis", bloodborn = ""};
AB["Arcanism"]["Countercurrent"].syntax = {ascendril = "cast countercurrent", bloodborn = ""};
AB["Arcanism"]["Entrapment Glyph"].syntax = {ascendril = "trace entrapment", bloodborn = ""};
AB["Arcanism"]["Mirage"].syntax = {ascendril = "cast mirage", bloodborn = ""};
AB["Arcanism"]["Arrogance Glyph"].syntax = {ascendril = "trace arrogance", bloodborn = ""};
AB["Arcanism"]["Vivacity"].syntax = { ascendril = "cast vivacity", bloodborn = "" };
AB["Arcanism"]["River"].syntax = {ascendril = "cast river $empowerment", bloodborn = ""};
AB["Arcanism"]["Addling Glyph"].syntax = {ascendril = "trace addling", bloodborn = ""};
AB["Arcanism"]["Missiles"].syntax = {ascendril = "cast missiles on", bloodborn = ""};
AB["Arcanism"]["Irritation Glyph"].syntax = {ascendril = "trace irritation", bloodborn = ""};
--abilities["Arcanism"]["Transfix"].syntax = {ascendril = "cast transfix $target", bloodborn = ""};
AB["Arcanism"]["Clarity Glyph"].syntax = {ascendril = "trace clarity", bloodborn = ""};
AB["Arcanism"]["Manatap"].syntax = {ascendril = "cast manatap $empowerment", bloodborn = ""};
AB["Arcanism"]["Destruction Glyph"].syntax = {ascendril = "trace $empowerment", bloodborn = ""};
AB["Arcanism"]["Leaching Glyph"].syntax = {ascendril = "trace leaching", bloodborn = ""};
AB["Arcanism"]["Reflection"].syntax = {ascendril = "cast reflection", bloodborn = ""};