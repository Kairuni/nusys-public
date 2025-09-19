AB["Fulcrum_Old"] = AB["Fulcrum_Old"] or {};

AB["Fulcrum_Old"]["Collapse"] = {
    balance = function(attacker, target, data)
        return {self = {bal = "equilibrium", cost = 2}, target = {cost = 0}}
    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            if (FLAGS.misc_defs) then
                FLAGS.misc_defs.fulcrum_construct = nil;
            end
        end
    end
}

AB["Fulcrum_Old"]["Collapse"].syntax = {ascendril = "fulcrum collapse", bloodborn = ""};