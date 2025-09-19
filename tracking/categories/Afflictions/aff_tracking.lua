function TRACK.affmsg(aff)
    if (PFLAGS.illusion) then return; end
    NU.appendPFlag("action_order", {"aff", aff});
end

function TRACK.discover(aff)
    if (PFLAGS.illusion) then return; end
    -- Aff discovery, primarily focused on hiddens.
    NU.appendPFlag("action_order", {"discovery", aff});
end

function TRACK.taff(target, aff)
    -- Target affliction message.
    if (PFLAGS.illusion) then return; end
    local ttable = TRACK.get(target);
    TRACK.aff(ttable, aff);
end

function TRACK.taffs(target, ...)
    -- Target affliction message.
    local ttable = TRACK.get(target);
    for _,aff in ipairs({...}) do
        TRACK.aff(ttable, aff);
    end
end

function TRACK.tstack(target, aff, increment, minimum, maximum)
    local ttable = TRACK.get(target);
    TRACK.stack(ttable, aff, increment, minimum, maximum)
end

function TRACK.stack(ttable, aff, increment, minimum, maximum)
    if (PFLAGS.illusion) then return; end
    if (ttable.stacks[aff] and ttable.affs[aff]) then
        if (ttable.stacks[aff] < (minimum or 0)) then
            ttable.stacks[aff] = minimum;
        elseif (ttable.stacks[aff] > (maximum or 9999)) then
            ttable.stacks[aff] = maximum;
        else
            ttable.stacks[aff] = ttable.stacks[aff] + (increment or 1);
        end
        display(ttable.stacks);
    end
end

TRACK.empowermentCONVERT = {
    left_right_arm_crippled = function(target) end,
    left_right_leg_crippled = function(target) end,
    sensi_level = function(target) end,
    sleep_level = function(target) end,
    any_venom = function(target) end,
    damage = function(target) end,
}

-- Builds a prompt flag for missable (clumsy, miss) afflictions.
function TRACK.missable_taff(target, aff)
    if (PFLAGS.illusion) then return; end
    NU.appendPFlag("taffs", {target, aff});
end

function TRACK.affs(ttable, affList)
    if (PFLAGS.illusion) then return; end
    -- Target affliction message.
    for _,aff in ipairs(affList) do
        TRACK.aff(ttable, aff);
    end
end

function TRACK.saffs(...)
    local affList = {...};
    local stable = TRACK.getSelf();
    for _,aff in ipairs(affList) do
        TRACK.aff(stable, aff);
    end
end

function TRACK.aff(ttable, aff)
    -- Adds an affliction to ttable.
    if (PFLAGS.illusion) then return; end
    --local affName = AFFS.mirrors[aff] or aff;

    if (ttable.stacks[aff] and not ttable.affs[aff]) then
        ttable.stacks[aff] = 0;
    elseif (aff == "sapped_strength") then
        TRACK.stack(ttable, aff)
    end
    -- TODO: Figure out a better way to handle sensitivity level.
    if (aff == "sensi_level") then
        if (ttable.defs.deafness) then
            TRACK.stripDef(ttable, "deafness");
            return;
        else
            aff = "sensitivity";
        end
    end
    if (not (aff == "paresis" and ttable.affs.paralysis)) then
        ttable.affs[aff] = true;
        NU.DECHO("Applied " .. aff .. " to " .. ttable.name, 1);
    end
    NU.appendPFlag("output_affs", ttable.name, true);
end

function TRACK.stripDef(ttable, def)
    ttable.defs[def] = false;
end

function TRACK.stripTDef(tname, def)
    TRACK.stripDef(TRACK.get(tname), def);
end

function TRACK.resetAffs(ttable)
    for k,_ in pairs(ttable.affs) do
        ttable.affs[k] = false;
    end
    ttable.hidden = {};
end

function TRACK.remove(ttable, aff)
    -- TODO: make this remove this aff from hidden as well.
    if (PFLAGS.illusion) then return; end

    ttable.affs[aff] = false;
    NU.DECHO("Removed " .. aff .. " from " .. ttable.name, 1);
    if (ttable.stacks[aff]) then
        ttable.stacks[aff] = 0;
    end
    NU.appendPFlag("output_affs", ttable.name, true);
end

function TRACK.numAffs(ttable, category)
    local count = 0;
    if (not category) then
        for _,v in ipairs(AFFS.baseline) do
            if (ttable.affs[v]) then
                count = count + 1;
            end
        end
    else
        for _,v in ipairs(category) do
            if (ttable.affs[v]) then
                count = count + 1;
            end
        end
    end
    return count;
end