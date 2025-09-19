-- Called on the self table
-- TODO: See other TODO in the defense section for adding a shorter keeplist to iterate through.
function TRACK.updateMissingDefs(ttable)
    for k,_ in pairs(ttable.affs) do
        local isDef = string.sub(k, 1, 3) == "no_";

        if (isDef) then
            local defName = isDef and k:sub(4) or nil;
            local alternativeActive = false;
            if (not DEFS.config[defName]) then
                echo(k);
            elseif (DEFS.config[defName].alternatives) then
                for _,v in ipairs(DEFS.config[defName].alternatives) do
                    if (ttable.defs[defName]) then
                        alternativeActive = true;
                    end
                end
            end
            local defAndKeepup = DEFS.config[defName] and DEFS.config[defName].keep and not ttable.defs[defName] and not alternativeActive;
            local correctClass = DEFS.config[defName] and (not DEFS.config[defName].classList or table.contains(DEFS.config[defName].classList, NU.getClass())) or false;
            if (defAndKeepup and correctClass) then
                ttable.affs[k] = true;
            else
                ttable.affs[k] = false;
            end
        end
    end
end

function TRACK.removeDef(ttable, def)
    if (ttable.defs[def]) then
        ttable.defs[def] = false;
    end
end

function TRACK.addDef(ttable, def)
    if (not def) then
        return;
    end
    ttable.defs[def] = true;
    if (TRACK.isSelf(ttable)) then
        TRACK.updateMissingDefs(ttable);
    end
end