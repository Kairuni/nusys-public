function GMCP.defenseAdd()
    --nu.appendPFlag("gmcp_add_def", gmcp.Char.Defences.Add.name, true);
    local ttable = TRACK.getSelf();
    ttable.defs[gmcp.Char.Defences.Add.name] = true;
    ttable.affs["no_" .. gmcp.Char.Defences.Add.name] = false;

    NU.appendPFlag("gmcp_add_def", gmcp.Char.Defences.Add.name);
end

function GMCP.defenseRemove()
    local ttable = TRACK.getSelf();
    for _,v in ipairs(gmcp.Char.Defences.Remove) do
        NU.appendPFlag("gmcp_rem_def", v, true);

        ttable.defs[v] = false;
        if (DEFS.config[v] and DEFS.config[v].keep) then
            ttable.affs["no_" .. v] = true;
        end
    end
end

function GMCP.defenseList()
    local ttable = TRACK.getSelf();

    -- Wipe the aff list
    ttable.defs = {};
    TRACK.updateMissingDefs(ttable);

    -- Load it from the list.
    for _,v in ipairs(gmcp.Char.Defences.List) do
        ttable.affs["no_" .. v.name] = false;
        ttable.defs[v.name] = true;
    end
end

GMCP.register("gmcp_add_def", "gmcp.Char.Defences.Add", GMCP.defenseAdd);
GMCP.register("gmcp_rem_def", "gmcp.Char.Defences.Remove", GMCP.defenseRemove);
GMCP.register("gmcp_list_def", "gmcp.Char.Defences.List", GMCP.defenseList);
