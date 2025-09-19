local pillGA = function(def, syntax, free)
    AB.addGenericAbility("Pill", def, {defs = {def}, syntax = {Default = syntax}, bal = {cost = free and 0 or BALANCE_DATA.pill.mean, bal = free and nil or "pill"}, reqs = function(stable) return not stable.defs[def] and not stable.affs.anorexia; end});
end

local insomnia = function(def, syntax, free)
    AB.addGenericAbility("Pill", def, {defs = {def}, syntax = {Default = syntax}, bal = {cost = free and 0 or BALANCE_DATA.pill.mean, bal = free and nil or "pill"}, reqs = function(stable) return not stable.defs[def] and not stable.affs.anorexia and not stable.affs.hypersomnia; end});
end

pillGA("blindness", "eat amaurosis");
pillGA("deafness", "eat ototoxin");
pillGA("waterbreathing", "eat waterbreathing");
insomnia("insomnia", "eat kawhepill");
pillGA("instawake", "eat stimulant");
pillGA("deathsight", "eat thanatonin", true);
pillGA("thirdeye", "eat acuity", true);