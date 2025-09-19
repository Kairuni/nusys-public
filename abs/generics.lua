function AB.addGenericAbility(skill, ability, args)
    -- damage, balCost, affs, limbDamage, defs)
    AB[skill] = AB[skill] or {};
    AB[skill][ability] = {};
    local ab = AB[skill][ability];
    local dmg = args.dmg;
    local bal = args.bal
    local affs = args.affs;
    local selfAffs = args.selfAffs;
    local limbs = args.limbs;
    local defs = args.defs;
    local syntax = args.syntax;
    local onUseEffects = args.onUseEffects;
    local postEffects = args.postEffects;
    local reqs = args.reqs;
    local reboundable = args.rebounding;
    local noShield = args.noShield;
    local cooldown = args.cooldown;
    local arms = args.arms or 2;
    local legs = args.legs or 0; -- Defaulting to 0 here because most added abilities assume 0. This was added after general use.
    local epCost = args.ep;
    local wpCost = args.wp;
    local dmgType = args.dmgType or "unblockable";
    local attackType = args.attackType;
    local encrust = args.encrust;
    local epWpCost = args.epWpCost;
    local notarget = args.notarget;
    local channel = args.channel;
    local defensive = args.defensive;

    if (not syntax) then
        NU.WARN("WEEOOWEEOO NO SYNTAX SUPPLIED FOR " .. ability);
    end

    if (defs) then
        if (type(defs) == "function") then
            ab.getSelfDefs = defs;
        else
            ab.getSelfDefs = function(attacker, target, data) return defs; end
        end
    end

    if (type(dmg) == "function") then
        ab.getDamage = dmg;
    else
        ab.getDamage = dmg and function(attacker, target, data)
            if (target) then
                return dmg.eH, dmg.eM, dmg.sH, dmg.sM;
            else
                return 0, 0, 0, 0;
            end
        end or nil;
    end
    -- TODO: Refactor getDamageType to include multi-damage types.
    ab.getDamageType = function(attacker, target, data) return dmgType; end;
    if (type(bal) == "function") then
        ab.balance = bal;
    else
        ab.balance = function(_, _, _) return {self = {bal = (bal or {}).bal, cost = (bal or {}).cost or 0}, target = {cost = 0}}; end
    end
    if (affs and type(affs) == "function") then
        -- display("Setting affs as a function for ", skill, ability)
        ab.getTargetAffs = affs;
    else
        ab.getTargetAffs = affs and function() return affs; end or nil;
    end

    if (selfAffs and type(selfAffs) == "function") then
        ab.getSelfAffs = selfAffs;
    else
        ab.getSelfAffs = selfAffs and function() return selfAffs; end or nil;
    end

    if (limbs and type(limbs) == "function") then
        ab.getLimbEffects = limbs;
    else
        ab.getLimbEffects = limbs and (
            limbs.targetable and
                function(attacker, target, data)
                    if (data.limb) then return {[data.limb] = limbs.damage, no_break = false}; end
                    return {};
                end
            or
                function(attacker, target, data)
                    return limbs.set;
                end
        ) or nil;
    end
    ab.syntax = syntax;
    ab.canHitRebounding = reboundable;
    ab.onUseEffects = onUseEffects;
    local cdStr = skill .. "_" .. ability;
    if (cooldown and postEffects) then
        NU.WARN("<red>POST EFFECTS AND COOLDOWN PROVIDED FOR " .. skill .. " - " .. ability .. " - defaulting to postEffects.\n");
    end

    -- TODO: Move to on use?
    ab.postEffects = postEffects or (cooldown and function(at, _, _) NU.cooldown(at.name .. "_" .. cdStr, cooldown) end or nil);

    if (reqs and (noShield)) then
        NU.WARN("<red>Reqs and noshield supplied for " .. skill .. " - " .. ability .. " - defaulting to reqs.\n");
    end

    if (not encrust) then
        ab.meetsPreReqs = reqs or function(attacker, target, data)
            return AB.genericRequirements(attacker, target, arms, false, false, false, noShield or defensive or notarget or false, cooldown and (attacker.name .. "_" .. cdStr) or nil, legs);
        end
    else
        if (reqs) then
            cecho("<red>Warning: reqs and encrust provided for " .. skill .. " - " .. ability .. " - defaulting to reqs.")
            ab.meetsPreReqs = reqs;
        else
            ab.meetsPreReqs = function(attacker, target, data)
                local encrustArms = attacker.defs.encrusted and 1 or 2;
                return AB.genericRequirements(attacker, target, encrustArms, false, false, false, noShield or false, cooldown and (attacker.name .. "_" .. cdStr) or nil, legs);
            end
        end
    end
    if (epCost or wpCost) then
        ab.getCost = function() return epCost, wpCost end
    elseif (epWpCost) then
        ab.getCost = epWpCost;
    end
    ab.attackType = attackType;

    ab.channel = args.channel;
end