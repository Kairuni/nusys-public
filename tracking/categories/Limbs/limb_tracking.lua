local rippleLimbs = {
    ["left arm"] = true,
    ["right arm"] = true,
    ["torso"] = true,
};

function TRACK.restoLimb(ttable, location, ignoreRipple, cureAmount)
    if (rippleLimbs[location] and ttable.affs.internal_disarray and not ignoreRipple) then
        return ttable.wounds[location];
    end

    local baseAmount = 30.0;
    local affSub = location:gsub(" ", "_");
    if (FLAGS[ttable.name .. "_regenerate"]) then
        if (ttable.affs[affSub .. "_mangled"]) then
            baseAmount = 45.0;
        else
            baseAmount = 40.0;
        end
    end

    local fleshbane = FLAGS[ttable.name .. "_fleshbaned"];
    if (fleshbane) then
        baseAmount = baseAmount - (fleshbane * 2);
    end

    local wounds = ttable.wounds;
    local amount = cureAmount or baseAmount;

    if (wounds[location]) then
        wounds[location] = wounds[location] - amount;
        if (wounds[location] < 0.0) then
            wounds[location] = 0;
        end
    end

    return wounds[location];
end

function TRACK.damageLimb(ttable, location, amount, ignoreBreak)
    local wounds = ttable.wounds;
    local iced = ttable.affs.ice_encased;
    local isSelf = TRACK.isSelf(ttable);

    NU.setPFlag("last_limb_hit", location);
    NU.setFlag("last_limb_hit", location);
    NU.setPFlag("last_limb_wounds", wounds[location]);
    NU.setPFlag("last_limb_damage", amount);

    wounds[location] = wounds[location] + (amount * ((iced and not isSelf) and 1.5 or 1.0));

    if (wounds[location] >= 100.0) then
        wounds[location] = 100;
    end

    local affSubstr = location:gsub(" ", "_");

    -- TODO: use these flags to test for wounds accuracy.
    if (not ttable.affs[affSubstr .. "_mangled"] and wounds[location] >= (2/3 * 100)) then
        NU.setPFlag(ttable.name .. "_" .. location .. "_ex_mangled", true);
    elseif (not ttable.affs[affSubstr .. "_broken"] and wounds[location] >= (1/3 * 100)) then
        NU.setPFlag(ttable.name .. "_" .. location .. "_ex_broken", true);
    end
    if (not TRACK.isSelf(ttable)) then
        NU.setPFlag("output_wounds", true);
    else
        NU.setPFlag("output_self_wounds", true);
    end

    return wounds[location];
end

function TRACK.damageLimbByName(name, location, amount, ignoreBreak)
    local ttable = TRACK.get(name);
    local isSelf = TRACK.isSelf(ttable);

    TRACK.damageLimb(ttable, location, amount, ignoreBreak);

    if (isSelf) then
        NU.appendPFlag("self_limb_damage", {location, amount});
    end
end

function TRACK.parry()
    if PFLAGS.illusion then return; end
    creplaceLine("<orange>>>>> PARRIED! <<<<")
    local parried = matches[2];
    local ttable = PFLAGS.attack_to_apply and PFLAGS.attack_to_apply.ttable;

    if (ttable) then
        local atable = PFLAGS.attack_to_apply.atable;
        local abTable = PFLAGS.attack_to_apply.abTable;
        local data = PFLAGS.attack_to_apply.data;
        local limbDamage = abTable.getLimbEffects(atable, ttable, data);
        limbDamage.no_break = nil;
        for limb,_ in pairs(limbDamage) do
            OFFENSE.general.trackParryModeOnHit(limb, true);
        end

        if (ttable.affs.sore_wrist) then
            local cannotBreak = not ttable.affs.stiffness;
            TRACK.damageLimb(ttable, "left arm", 4, cannotBreak);
            TRACK.damageLimb(ttable, "right arm", 4, cannotBreak);
        end

        NU.setFlag("last_parry", {limb = parried, time = NU.time()}, 60);
        NU.clearPFlag(ttable.name .. "_" .. parried .. "_ex_mangled");
        NU.clearPFlag(ttable.name .. "_" .. parried .. "_ex_broken");
    end

    NU.clearPFlag("attack_to_apply");
    NU.clearPFlag("non_ab_limb_attacks");
end

function TRACK.setLimbDamage(ttable, location, amount)
    ttable.wounds[location] = amount;
end