local aGA = AB.addGenericAbility;
local function dmgConv(eh, em, sh, sm) return {eH = eh, eM = em, sH = sh, sM = sm}; end

local function aGPA(ability, dmg, bal, balCost, affs, defs, limbs, cooldown, dmgType, reboundable, noshield, syntax, otherArgs)
    local args = {
        dmg = dmg and dmgConv(dmg, 0, 0, 0) or nil,
        dmgType = dmg and (dmgType or "cutting") or nil,
        ep = -50,
        affs = affs,
        defs = defs,
        bal = {
            ["cost"] = balCost,
            ["bal"] = bal,
        },
        arms = 1,
        limbs = limbs,
        cooldown = cooldown,
        noshield = noshield,
        rebounding = reboundable,
        syntax = {["Predator"] = syntax},
    }
    if (otherArgs) then
        args = table.union(args, otherArgs);
    end
    aGA("Predation", ability, args);
    AB.Predation[ability].name = ability;
end

-- Regeneration - same as monk regen. Regeneration on. No cost.
aGPA("Spacing", nil, "balance", 3.72, nil, {"spacing"}, nil, nil, false, true, "spacing");
-- Secondwind -- Wake faster. No cost.
aGPA("Secondwind", nil, "balance", nil, nil, {"secondwind"}, nil, nil, false, true, "secondwind");
-- Goad - Make them target randomly. 3.16 bal
-- Dartshot - consumes a dart, delivers a venom. 1.66 bal 
-- Windwalk - Defense, similar to shroud. 1.86 eq
aGPA("Windwalk", nil, "equilibrium", 2, nil, {"windwalk"}, nil, nil, false, true, "windwalk");
-- Grabhold - Anti-flying. 0.93s bal.
aGPA("Grabhold", 0.05, "balance", 1, nil, {"grabhold"}, nil, nil, false, false, "grabhold $target");

-- Pheromones - pacify target. 1.74. Can combo.
aGPA("Pheromones", nil, "balance", 1.75, {"pheromones"}, nil, nil, nil, false, false, "pheromones");
-- Entice - force follow, 2.37
-- Preservation - gives preserval, fire and cold res.
aGPA("Preserval", nil, "balance", nil, nil, {"preserval"}, nil, nil, false, true, "preservation");
-- Arouse - 0.79 for a 50% heal, 90s cooldown. You are unable to arouse your body again so soon.
aGPA("Arouse", nil, "balance", 1, nil, nil, nil, 90, nil, false, true, "arouse");
-- Mindnumb - impairment, can combo. 2.13.
aGPA("Mindnumb", nil, "balance", 2.13, {"impairment"}, nil, nil, nil, false, false, "mindnumb");
-- Ferocity - 25s cd, random aff cure. You are not able to purge another affliction just yet. You feel your strength of body return.
aGPA("Ferocity", nil, "balance", 2.51, nil, nil, nil, 25, false, true, "ferocity");
-- Aversion. Aversion def. AVERT EYES, AVERT OFF. No glyph/aegis impact. 1.2s. Have to have masked.
-- Pindown. 3.16 bal. If data is fail, nothing. If success, writhe_dartpinned. Can be used in series, but only to start the combo.
aGPA("Pindown", nil, "balance", 3, function(_, ttable, data) if (not data.other) then return {"writhe_dartpinned"}; end return {}; end, nil, nil, nil, false, false, "pindown");

-- Daggerthrow. 3.27. If adjacent, embedded_dagger. Can PULL DAGGER FROM BODY for 1s bal. 
-- Quickassess - no AB, but we know what quickassess is.
-- Defang. 3.95 bal. defang defense. Bal upset on parry.
aGPA("Defang", nil, "balance", 4, nil, {"defang"}, nil, 25, false, true, "defang");
-- Threadtrap - if no mass, pull them back. Kinda meh? Need firewalls.
-- Twinshot - basically dstab, 2.37 bal, but can be done within LOS. Rebounding if in-room, otherwise no.
aGPA("Twinshot", .1, "balance", 2.37, nil, nil, nil, nil, "cutting", true, false, "twinshot $target $venom1 $venom2");
-- Cirisosis - Can use cirosisis venom. 
        -- You dextrously flick your wrist forward, two swift darts flying towards Gherond.
        -- Your dart strikes Gherond, digging curare into his flesh.
        -- Your dart strikes Gherond, digging cirisosis into his flesh.

    -- Gherond is no longer affected by your morphing venom.
    -- Gherond has escaped the effects of your morphing venom.

-- Culmination - No cost, uber-dodge. Culmination defense.
aGPA("Culmination", nil, "balance", nil, nil, {"culmination"}, nil, 25, false, true, "culmination");