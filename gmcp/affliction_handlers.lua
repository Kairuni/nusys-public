function GMCP.afflictionAdd()
    NU.appendPFlag("gmcp_add_aff", gmcp.Char.Afflictions.Add.name, true);
end

function GMCP.afflictionRemove()
    for _,v in ipairs(gmcp.Char.Afflictions.Remove) do
        NU.appendPFlag("gmcp_rem_aff", v, true);
    end
end

function GMCP.afflictionList()
    local ttable = TRACK.getSelf();
    echo("Got affliction list.");
    -- Wipe the aff list
    for k,_ in pairs(ttable.affs) do
        if (string.sub(k, 1, 3) ~= "no_") then
            ttable.affs[k] = false;
        end
    end

    ttable.hidden = {};

    -- Load it from the list.
    for _,v in ipairs(gmcp.Char.Afflictions.List) do
        ttable.affs[v.name] = true;
    end
end

GMCP.register("gmcp_add_aff", "gmcp.Char.Afflictions.Add", GMCP.afflictionAdd);
GMCP.register("gmcp_rem_aff", "gmcp.Char.Afflictions.Remove", GMCP.afflictionRemove);
GMCP.register("gmcp_list_aff", "gmcp.Char.Afflictions.List", GMCP.afflictionList);
