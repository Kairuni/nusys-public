function NU.promptDecorators()
    local ttable = TRACK.getSelf();

end

local function displayHPMPChange(changeFlag, gainColor, lossColor)
    if (changeFlag and not changeFlag.displayed) then
        changeFlag.displayed = true;
        local diff = changeFlag.change;
        cecho("<DarkSlateGray>[");
        cecho(diff > 0 and (gainColor .. "+" .. tostring(diff)) or (lossColor .. tostring(diff)));
        cecho("<DarkSlateGray>]");
    end
end

local function limbColor(ttable, limb)
    local crippled = limb:gsub(" ", "_") .. "_broken";
    local broken = limb:gsub(" ", "_") .. "_broken";
    local mangled = limb:gsub(" ", "_") .. "_mangled";
    if (ttable.affs[mangled]) then
        return "<red>";
    elseif (ttable.affs[broken]) then
        return "<orange>";
    elseif (ttable.affs[crippled]) then
        return "<yellow>"
    else
        return "<white>"
    end
end

function NU.promptTrackingHandler()
    if (not gmcp.Char) then return; end; -- TODO: replace with a proper logged-in check.
    if (not NU.log_mode) then -- If log_mode, pull the timestamp. We'll need to figure out how to do that later.
        NTIME.update();
    end

    local stable = TRACK.getSelf();
    local ttable = TRACK.getTarget();

    -- TODO: Quick hack here - with blackout assume our shielded def is gone. This is NOT accurate, but blackout is a jerk and hides shield removal.
    if (stable.affs.blackout) then
        TRACK.removeDef(stable, "shielded");
        TRACK.removeDef(stable, "rebounding");
    end

    if (not PFLAGS.gagged) then
        UTIL.echoBalances();
        displayHPMPChange(FLAGS.last_hp_change, "<LimeGreen>", "<red>");
        displayHPMPChange(FLAGS.last_mp_change, "<RoyalBlue>", "<MediumPurple>");
        cecho("<black>☼");
        if (NU.paused) then
            cecho("<red>[<white>PAUSED<red>]<reset>");
        end
    end

    -- NU.GUI.misc.promptMiniConsole:clear();
    -- selectCurrentLine();
    -- copy();
    -- NU.GUI.misc.promptMiniConsole:appendBuffer();
    -- NU.LOG_DEBUG("[GAGGED]: " .. copy2html());
    -- replaceLine("");

    local shapeFlagValue = NU.popPFlag(stable.name .. "_shape")

    if (PFLAGS.action_order) then
        for _,v in ipairs(PFLAGS.action_order) do
            -- Handle actions in the order we saw them:
            local action = v[1];
            local aff = v[2];
            local tb = v[3] and PFLAGS[v[3] .. "_cure_table"];
            if (action == "cure") then
                if (PFLAGS.gmcp_rem_aff and PFLAGS.gmcp_rem_aff[aff]) then
                    NU.DECHO("Removing " .. aff, 1);
                    if (PFLAGS.untracked) then NU.appendFlag("last_untracked_remove_affs", aff); end
                    cecho("<blue>[<green>CURE: " .. UTIL.affLongToShort[aff] .. "<blue>]");
                    TRACK.remove(stable, aff);
                    -- We've cured this aff, remove previous affs if it was from a cure source.
                    if (tb) then
                        if (not table.contains(tb, aff)) then
                            NU.DECHO("Warning: Cure of " .. aff .. " via " .. action .. " with table " .. (v[3] and v[3] or "N/A") .. " would have wiped out a cure table.", 5);
                            if (NU.DEBUG <= 4) then
                                display(tb);
                                display(PFLAGS.action_order);
                            end
                        else
                            for _, cure in ipairs(tb) do
                                if (stable.affs[cure] and cure ~= aff and not TRACK.cannotCure(stable, cure)) then
                                    NU.DECHO("Cleared " .. cure .. " as it was prior to " .. aff, 1);
                                    TRACK.remove(stable, cure);
                                elseif (cure == aff) then
                                    break;
                                end
                            end
                            NU.setPFlag(v[3] .. "_handled", true);
                        end
                    elseif (v[3]) then
                        NU.setPFlag(v[3] .. "_handled", true);
                    end
                elseif (v.def) then
                    if (v[3]) then
                        NU.setPFlag(v[3] .. "_handled", true);
                    end
                --else
                    --NU.DECHO("Potential illusion cure of " .. aff, 5);
                end
            elseif (action == "discovery" or action == "aff") then
                if (PFLAGS.gmcp_add_aff and PFLAGS.gmcp_add_aff[aff]) then
                    NU.DECHO("Adding " .. aff, 1);
                    if (PFLAGS.untracked) then NU.appendFlag("last_untracked_add_affs", aff); end
                    if (action == "discovery") then
                        cecho("<blue>[<yellow>DISCOVER: " .. UTIL.affLongToShort[aff] .. "<blue>]");
                        TRACK.hiddenDiscovery(stable, aff);
                    else
                        cecho("<blue>[<red>AFF: " .. UTIL.affLongToShort[aff] .. "<blue>]");
                        -- If we have a shape flag set and we got tagged by a shape, add the previous affs.
                        -- Only pops if we actually consume the value. This should be in correct order.
                        if (shapeFlagValue and AFFS.sealAffs["sealing_" .. shapeFlagValue] and AFFS.sealAffs["sealing_" .. shapeFlagValue][aff]) then 
                            TRACK.onArchivistShape(stable, shapeFlagValue, aff)

                            shapeFlagValue = NU.popPFlag(stable.name .. "_shape")
                        elseif (shapeFlagValue and not AFFS.sealAffs["sealing_" .. shapeFlagValue]) then
                            NU.WARN("Screwed up shape value somehow!");
                        end
                    end
                    TRACK.aff(stable, aff);
                elseif (not stable.affs[aff]) then -- Otherwise, if we don't already have an aff, it might have been an illusion. Note it.
                    if (not aff) then
                        display("What the shit part two: ")
                        display(PFLAGS.action_order)
                    end
                    -- NU.DECHO("Potential illusion aff of " .. aff, 5);
                end
            end
        end
    end

    if (PFLAGS.cure_actions) then
        -- TODO: Determine if we can work a better way to handle cases like GLOOM - we don't want to need to make a special case for every 'delay until balance recovery' cure.
        local function curingGloom(action)
            if (FLAGS.gloom_curing and action == "poultice" and PFLAGS[action][1] == "epidermal") then
                return true;
            end
            return false;
        end

        local function smokedRebounding(action)
            if (PFLAGS.smoke and action == "smoke" and PFLAGS.smoke[1] == "reishi") then
                return true;
            end
            return false;
        end

        for _,v in ipairs(PFLAGS.cure_actions) do
            if (not PFLAGS[v .. "_handled"] and PFLAGS[v .. "_cure_table"] and not curingGloom(v) and not smokedRebounding(v)) then
                --display(PFLAGS);
                NU.DECHO("Failed to cure anything for " .. v .. " -- removing all AFFS.", 6);
                local tb = PFLAGS[v .. "_cure_table"];
                for _, cure in ipairs(tb) do
                    if (not TRACK.cannotCure(stable, cure) and not AFFS.fake[cure]) then
                        TRACK.remove(stable, cure);
                        TRACK.ruleOutHidden(stable, cure);
                    end
                end
                NU.appendPFlag("output_affs", stable.name, true);
            elseif (not PFLAGS[v .. "_handled"] and (v == "tree" or v == "renew" or v == "random")) then
                NU.DECHO("Failed to cure anything for " .. v .. " -- removing all random AFFS.", 6);
                -- TODO: Remove all random AFFS.
                for _,v in ipairs(AFFS.irandom) do
                    if (not TRACK.cannotCure(stable, v)) then
                        TRACK.remove(stable, v);
                        TRACK.ruleOutHidden(stable, v);
                    end
                end
            end
        end
    end

    if (PFLAGS.untracked) then
        NU.setFlag("last_untracked_add_defs", PFLAGS.gmcp_add_def);
        NU.setFlag("last_untracked_remove_defs", PFLAGS.gmcp_rem_def);
        NU.setFlag("last_untracked_limb_damage", PFLAGS.last_limb_damage);
        NU.setFlag("last_untracked_limb_target", PFLAGS.last_limb_hit);
    end

    if (FLAGS.prompt_append) then
        for k,v in pairs(FLAGS.prompt_append) do
            cecho('<yellow>[<white>' .. v .. '<yellow>]');
        end
        NU.clearFlag("prompt_append");
    end

    if (PFLAGS.output_affs) then
        for k,_ in pairs(PFLAGS.output_affs) do
            echo("\n");
            local etable = TRACK.get(k);
            if (TRACK.isSelf(etable)) then
                cecho(" <green>[<aquamarine>" .. etable.name);
            else
                cecho(" <yellow>[<red>" .. etable.name);
            end
            echo(": ");
            local printed = false;
            for _, aff in ipairs(UTIL.afflictionDrawOrder) do
                if (etable.affs[aff] and not AFFS.fake[aff]) then
                    if (printed) then cecho("<reset>, "); end
                    cecho(UTIL.affLongToShort[aff]);
                    printed = true;
                end
            end
            if (TRACK.isSelf(etable)) then
                cecho("<green>]<aquamarine>");
            else
                cecho("<yellow>]<red>");
            end
        end
    end
    if (PFLAGS.output_self_wounds) then
        cecho("<orange>\n[");
        for k,v in pairs(stable.wounds) do
            cecho(k .. ": " .. limbColor(ttable, k) ..  tostring(v) .. "<reset> ");
        end
        cecho("<orange>]<reset>");
    end

    if (PFLAGS.output_wounds) then
        cecho("<blue>\n[");
        for k,v in pairs(ttable.wounds) do
            cecho(k .. ": " .. limbColor(ttable, k) ..  tostring(v) .. "<reset> ");
        end
        cecho("<blue>]<reset>");
    end

    if (PFLAGS.expected_hiddens and PFLAGS.expected_hiddens.source ~= "loki" and #PFLAGS.expected_hiddens.affList > 0) then
        NU.WARN("Expected hiddens still existed, but were not found : " .. PFLAGS.expected_hiddens.source);
    end

    -- Log the prompt, add it to the miniconsole, update prompt appends, add valid prompt appends to miniconsole,
    -- log prompt appends, then delete the line.
    -- NU.GUI.misc.promptMiniConsole:clear();
    -- NU.GUI.misc.promptMiniConsole:decho(copy2decho());
    -- replaceLine("");
    -- What is this even doing.
    if (getCurrentLine() == "") then
        --deleteLine();
    end

    -- TODO: We've disabled the time based pulse and added this here. See how it behaves.
    ACTIONS.pulse();
    NTIME.update();
end

TRIG.register("prompt_tracking", "prompt", nil, NU.promptTrackingHandler);