local aGA = AB.addGenericAbility;
local function dmgConv(eh, em, sh, sm) return {eH = eh, eM = em, sH = sh, sM = sm}; end

local function aGBA(ability, dmg, bal, balCost, affs, defs, limbs, cooldown, dmgType, reboundable, noshield, syntax, otherArgs)
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
    aGA("Beastmastery", ability, args);
    AB.Beastmastery[ability].name = ability;
end

aGBA("Beastcall", 0.05, "equilibrium", 3.72, nil, nil, nil, nil, nil, false, true, "beastcall $empowerment", {onUseEffects = function(attacker, _, data)
    if (TRACK.isSelf(attacker)) then
       NU.setPFlag("beastmastery_expected", true);
    end
end});

-- Redeyes - if shock, then stun. If impaired, longer stun. 4s stun. 2s eq.  The gaze holds Gherond, drawing him into its lupine eyes. on success.
-- swoop can apply venom:
-- You order a proud hawk to swoop down at Gherond.
-- High above, a proud hawk lets out a piercing call and begins descending directly at Gherond.
-- Equilibrium Used: 2.79 seconds

-- Weaken - 1.86 eq. sapped_constitution for 20s.

-- Pummel - 3.72. 20% limb damage.
-- *** BEASTMASTERY - PUMMEL (right arm): Gherond *** UNTRACKED
-- At your command, a brown bear brings its massive paws crashing down on Gherond's right arm, pummeling it mercilessly.
-- Gherond's right arm breaks from all the damage.

aGBA("Pummel", 0.05, "equilibrium", 3.72, nil, nil, {["damage"] = 20.0, ["targetable"] = true}, nil, "blunt", false, false, "orgyuk pummel $target $limb");
-- Quarter - 3.72 eq. 20% damage per limb. If > current hp, instakill.
aGBA("Mawcrush", 0.2, "equilibrium", 3.72, nil, nil, nil, nil, "blunt", false, false, "orgyuk mawcrush $target");

-- Web - writhe_web at 2.79s eq. 20s cd.
aGBA("Web", nil, "equilibrium", 2.8, {"writhe_web"}, nil, nil, nil, nil, false, false, "spider web $target");
-- Intoxicate - makes spider bite. An elusive spider scuttles towards Gherond and sinks its venomous fangs into his body. Intoxicated aff makes next venom hidden, then cures. Looks like `You feel strange and dizzy as the venom circulates.`
-- Intercept - An elusive spider ceases its interception attempts. - stops a target from running on normal movement, 1s balance knock. Costs 2.79 eq.
-- Negate - reduce cutting/blunt resists. 25s duration. 1.86 eq.
-- Acid - Keeps bloodscourge active.
