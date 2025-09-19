local poulticeGA = function(def, syntax, free, addReq)
    AB.addGenericAbility("Poultice", def, {defs = {def}, syntax = {Default = syntax}, bal = {cost = free and 0 or BALANCE_DATA.poultice.mean, bal = free and nil or "poultice"}, 
        reqs = function(stable) local req = true; if (addReq) then req = addReq(stable); end return req and not stable.defs[def] and not stable.affs.slickness; end});
end

poulticeGA("fangbarrier", "apply paste", true, function(stable) return not FLAGS[stable.name .. "_fangbarrier"]; end);
poulticeGA("density", "apply mass");