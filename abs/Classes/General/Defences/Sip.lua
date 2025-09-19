local sipGA = function(def, syntax, free, addReq)
    AB.addGenericAbility("Sip", def, {defs = {def}, syntax = {Default = syntax}, bal = {cost = free and 0 or BALANCE_DATA.other_elixir.mean, bal = free and nil or "elixir"},
        reqs = function(stable) local req = true; if (addReq) then req = addReq(stable); end return req and not stable.defs[def] and not stable.affs.anorexia; end});
end

sipGA("harmony", "sip harmony", false);
sipGA("levitation", "sip levitation", false);
sipGA("arcane", "sip arcane", false);
sipGA("speed", "sip speed", false, function(stable) return stable.actions.exSpeed < NU.time(); end);
sipGA("vigor", "sip vigor", false);