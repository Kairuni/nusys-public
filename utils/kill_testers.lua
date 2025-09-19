function UTIL.syzygyKill(affs, hp) -- TODO: Clean up, the end of an era :'(
    if (hp <= 0.60
            and affs.spiritbrand
            and affs.mistbrand
            and affs.emberbrand) then
        return true;
    end
    return false;
end

function UTIL.retributionKill(affs)
    if (affs.delirium and affs.extravasation and affs.crippled_body and affs.paralysis) then
        return true;
    end
    return false;
end

function UTIL.proneTest(affs)
    local pList = {"prone", "frozen", "indifferent", "unconscious", "asleep", "stun", "paralysis"};

    for _,v in ipairs(pList) do
        if (affs[v]) then
            return true;
        end
    end
    return false;
end

function UTIL.executeKill(affs, addProne)
    --[[if ("head_broken" and ("right_arm_broken" or "left_arm_broken" or "right_leg_broken" or "left_leg_broken")) then
        -- TODO: If I'm actually using this, swap this.
        if (NU.proneTest(affs) or addProne) then
            return true;
        end
    end]]
    return false;
end

function UTIL.isSoftLocked(affTable)
    if (affTable.slickness and affTable.anorexia and affTable.asthma) then
        return true;
    else
        return false;
    end
end

function UTIL.isHardLocked(affTable)
    if (UTIL.isSoftLocked(affTable) and affTable.impatience and (affTable.paralysis or affTable.paresis)) then
        return true;
    else
        return false;
    end
end

function UTIL.isTrueLocked(affTable)
    if (UTIL.isHardLocked(affTable) and (affTable.disrupted or affTable.indifference)) then
        return true;
    else
        return false;
    end
end