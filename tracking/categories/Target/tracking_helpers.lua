function TRACK.isSelf(ttable)
    return ttable == TRACK.getSelf();
end

--- Gets the 'self' tracking table. Always returns the self table.
-- @treturn table
function TRACK.getSelf()
    if (not TRACK.self and gmcp.Char.Status.name) then
        TRACK.self = TRACK.get("you");
    end
    return TRACK.self;
end

function TRACK.getTarget()
    return TRACK.get(NU.target);
end

-- TODO: Inefficient, redo this by AFFS[type] instead.
function TRACK.countType(ttable, typ)
    local count = 0;
    for k,v in pairs(ttable.affs) do
        if (v == true and AFFS[typ][k]) then
            count = count + 1;
        end
    end
    return count;
end

function TRACK.countAffsByList(ttable, affList)
    local count = 0;
    for _,v in ipairs(affList) do
        if (ttable.affs[v]) then
            count = count + 1;
        end
    end
    return count;
end

function TRACK.countTypeByName(target, typ)
    return TRACK.countType(TRACK.get(target), typ);
end
