AB.Tattoos = {};

local tattooGA = function(def, syntax, bal, cost, addReq)
    cost = cost or 0;
    AB.addGenericAbility("Tattoos", def, {defs = {def}, syntax = {Default = syntax}, bal = {cost = cost, bal = bal}, 
        reqs = function(stable) local req = true; if (addReq) then req = addReq(stable); end return req and not stable.defs[def] and AB.genericRequirements(stable, nil, 1, false, false, true, true); end});
end

tattooGA("cloak", "touch cloak", "equilibrium", 1);
tattooGA("mindseye", "touch mindseye", "equilibrium", 3);
tattooGA("flame", "touch flame", "equilibrium", 3);

AB["Tattoos"]["Shield"] = {
    balance = function(_, _, _)
        return {self = {bal = "equilibrium", cost = 4}, target = {cost = 0}}
    end,

    onUseEffects = function(attacker, target, data)
        attacker.defs.shielded = true;
    end,
    syntax = { Default = "touch shield" },

    meetsPreReqs = function(atable, ttable, data)
        return not atable.affs.paralysis and not atable.affs.FALLEN;
    end
}


AB["Tattoos"]["Feather"] = {
    balance = function(_, _, _)
        return { self = { bal = "equilibrium", cost = 4 }, target = { cost = 0 } }
    end,

    onUseEffects = function(attacker, target, data)
        TRACK.cure(attacker, "FALLEN");
    end,

    syntax = { Default = "touch feather" },

    meetsPreReqs = function(atable, ttable, data)
        return not atable.affs.paralysis and atable.affs.FALLEN and atable.defs.levitation and
            not (atable.affs.left_arm_crippled and atable.affs.right_arm_crippled);
    end
}

AB["Tattoos"]["Hammer"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,

    postEffects = function(attacker, target, data)
        TRACK.stripDef(target, "shielded")
    end,

    syntax = {Default = "touch hammer $target"},

    meetsPreReqs = function(atable, ttable, data)
        return ttable.defs.shielded and not atable.affs.paresis and not atable.affs.paralysis and not atable.affs.FALLEN;
    end
}

AB.addGenericAbility("Tattoos", "Crystal", {syntax = {Default = "touch crystal", cooldown = 900}});

-- Your crystal tattoo tingles slightly.