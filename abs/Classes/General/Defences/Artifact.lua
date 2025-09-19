local artifactGA = function(def, syntax, blocker, bal, cost, addReq)
    cost = cost or 0;
    AB.addGenericAbility("Artifact", def, {defs = {def}, syntax = {Default = syntax}, bal = {cost = cost, bal = bal}, 
        reqs = function(stable) local req = true; if (addReq) then req = addReq(stable); end return req and not stable.defs[def]  and not stable.affs[blocker]; end});
end

artifactGA("nightsight", "goggle toggle nightsight");
artifactGA("thirdeye", "goggle toggle thirdeye");
artifactGA("mindseye", "goggle toggle mindseye");
artifactGA("lifevision", "goggle toggle lifevision");
AB.addGenericAbility("Artifact", "lifevision_mask", {defs = {"lifevision"}, syntax = {Default = "lifevision"}, bal = {cost = 0, bal = nil},
    reqs = function(stable) return not stable.defs["lifevision"]; end});

artifactGA("insight", "goggle toggle insight");
artifactGA("lipreading", "goggle toggle lipreading");
artifactGA("overwatch", "goggle toggle overwatch");
artifactGA("density", "stability", nil, "poultice", 1.5);