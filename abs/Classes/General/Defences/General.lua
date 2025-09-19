local generalGA = function(def, syntax, blocker, bal, cost, addReq)
    cost = cost or 0;
    AB.addGenericAbility("General", def, {defs = {def}, syntax = {Default = syntax}, bal = {cost = cost, bal = bal}, 
        reqs = function(stable) local req = true; if (addReq) then req = addReq(stable); end return req and not stable.defs[def]  and not stable.affs[blocker]; end});
end

generalGA("insomnia", "insomnia");
generalGA("nightsight", "nightsight");
generalGA("deathsight", "deathsight", nil, "equilibrium");
generalGA("thirdeye", "thirdeye");
generalGA("safeguard", "safeguard", "impairment", "balance");
generalGA("irongrip", "irongrip", "FALLEN", "balance", 3,
    function(st) return not st.affs.left_arm_crippled and not st.affs.right_arm_crippled; end);
generalGA("hiding", "hide", nil, "balance", 4, function() return #gmcp.Room.Players == 0; end);
generalGA("clarity", "clarity", nil, "equilibrium", 2.5);
generalGA("selfishness", "selfishness", nil, "equilibrium", 0.5);