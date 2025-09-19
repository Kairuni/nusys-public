function GMCP.vitals()
    local ttable = TRACK.get("You");
    for _,v in ipairs(VITALS.vitalsOrder) do
        if (VITALS.numberVitals[v]) then
            NU.setFlag("last_vitals_" .. v, ttable.vitals[v]);
            if (not ttable.affs.recklessness or (v ~= "hp" and v ~= "mp")) then
                ttable.vitals[v] = tonumber(gmcp.Char.Vitals[v]);
            end
        elseif (VITALS.booleanVitals[v]) then
            local vitalName = VITALS.balanceConversion[v] or v;

            local oldVal = ttable.vitals[vitalName];
            local newVal = (gmcp.Char.Vitals[v] == "1");

            ttable.vitals[vitalName] = newVal;

            if (ttable.bals[vitalName]) then
                if (ttable.vitals[vitalName]) then
                    ttable.bals[vitalName] = -1;
                end
                if (oldVal == true and newVal == false) then
                    -- clear sent flags:
                    NU.clearFlag(vitalName .. "_sent");
                end
            end
        else
            ttable.vitals[v] = gmcp.Char.Vitals[v];
        end
    end
end

GMCP.register("gmcp_vitals", "gmcp.Char.Vitals", GMCP.vitals);