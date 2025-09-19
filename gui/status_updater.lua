local limbs = {
    head = "headState",
    torso = "torsoState",
    right_arm = "rarmState",
    left_arm = "larmState",
    right_leg = "rlegState",
    left_leg = "llegState",
}

local limbColors = {
    none = "green",
    broken = "yellow",
    damaged = "orange",
    mangled = "red"
}

function NU.GUI.functions.updateGUIStatus()
    local defaultColor = "blue";
    local softColor = "yellow";
    local hardColor = "orange";
    local trueColor = "red";
    local killColor = "purple";

    if (not gmcp.Char) then -- not logged in
        return;
    end

    local stable = TRACK.getSelf();
    local ttable = TRACK.get(NU.target);

    local affs = stable and stable.affs or {};
    local tAffs = ttable and ttable.affs or {};

    NU.GUI.functions.buildAffList(NU.GUI.afflictions.affs, affs);
    NU.GUI.functions.buildAffList(NU.GUI.afflictions.tAffs, tAffs);

    local selfLabel = NU.GUI.misc.personalState;
    local targLabel = NU.GUI.misc.targetState;

    if (UTIL.syzygyKill(affs, stable.vitals.hp / stable.vitals.maxhp) or UTIL.retributionKill(affs)) then
        selfLabel:setColor(killColor);
    elseif (UTIL.isTrueLocked(affs)) then
        selfLabel:setColor(trueColor);
    elseif (UTIL.isHardLocked(affs)) then
        selfLabel:setColor(hardColor);
    elseif (UTIL.isSoftLocked(affs)) then
        selfLabel:setColor(softColor);
    else
        selfLabel:setColor(defaultColor);
    end

    if (UTIL.syzygyKill(tAffs, ttable and (ttable.vitals.hp / ttable.vitals.maxhp) or 100) or UTIL.retributionKill(tAffs)) then
        targLabel:setColor(killColor);
    elseif (UTIL.isTrueLocked(tAffs)) then
        targLabel:setColor(trueColor);
    elseif (UTIL.isHardLocked(tAffs)) then
        targLabel:setColor(hardColor);
    elseif (UTIL.isSoftLocked(tAffs)) then
        targLabel:setColor(softColor);
    else
        targLabel:setColor(defaultColor);
    end
       for k,v in pairs(limbs) do
        if (affs[k .. "_mangled"]) then
            NU.GUI.misc[v]:setColor(limbColors.mangled);
        elseif (affs[k .. "_broken"]) then
            NU.GUI.misc[v]:setColor(limbColors.damaged);
        elseif (k ~= "head" and k ~= "torso" and affs[k .. "_crippled"]) then
            NU.GUI.misc[v]:setColor(limbColors.broken);
        else
            NU.GUI.misc[v]:setColor(limbColors.none);
        end

        NU.GUI.misc[v]:echo("<center>"..tostring(stable and stable.wounds[k:gsub("_", " ")] or 0.0) .. "</center>");
    end


    for k,v in pairs(limbs) do
        if (tAffs[k .. "_mangled"]) then
            NU.GUI.misc["t"..v]:setColor(limbColors.mangled);
        elseif (tAffs[k .. "_broken"]) then
            NU.GUI.misc["t"..v]:setColor(limbColors.damaged);
        elseif (k ~= "head" and k ~= "torso" and tAffs[k .. "_crippled"]) then
            NU.GUI.misc["t"..v]:setColor(limbColors.broken);
        else
            NU.GUI.misc["t"..v]:setColor(limbColors.none);
        end

        NU.GUI.misc["t"..v]:echo("<center>"..tostring(ttable and ttable.wounds[k:gsub("_", " ")] or 0.0) .. "</center>");
    end
end