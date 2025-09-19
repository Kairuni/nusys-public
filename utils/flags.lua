FLAGS = FLAGS or {};
TFLAGS = TFLAGS or {};
PFLAGS = PFLAGS or {};

function NU.setFlag(name, val, time, funcOnFinish)
    if (TFLAGS[name]) then
        NU.DECHO("Clearing old timer for flag: " .. name .. " with ID " .. tostring(TFLAGS[name]) .. "\n", 3);
        NTIME.delete(TFLAGS[name]);
    end

    NU.DECHO("Creating a new flag: " .. name .. " (" .. tostring(val) .. ")\n", 3);
    if (time and time > 0) then
        TFLAGS[name] = NTIME.timer(time,
            function()
                local overrideRepeat, doRepeat = false, false;
                -- TODO: there might be a cleaner way to do this, but we're basically letting finishing functions tell the timer whether to repeat or not.
                if (funcOnFinish) then
                    overrideRepeat, doRepeat = funcOnFinish();
                end
                if (not overrideRepeat or (overrideRepeat and not doRepeat)) then
                    FLAGS[name] = nil;
                    TFLAGS[name] = nil;
                    NU.DECHO("Clearing flag: " .. name, 4);
                else
                    NU.DECHO("Renewing flag: " .. name, 4);
                end

                return overrideRepeat, doRepeat;
            end);
    end
    FLAGS[name] = val;
end

function NU.appendFlag(name, val, asKey, time)
    if (FLAGS[name] and type(FLAGS[name]) ~= "table") then
        NU.DECHO("Tried to append to non-table flag.", 10);
        return;
    elseif (not FLAGS[name]) then
        NU.setFlag(name, {}, time);
    elseif (FLAGS[name]) then
        NU.setFlag(name, FLAGS[name], time);
    end

    if (asKey) then
        FLAGS[name][val] = asKey;
    else
        table.insert(FLAGS[name], val);
    end

end

function NU.promptAppend(category, msg)
    NU.appendFlag("prompt_append", category, msg, 5);
end

function NU.clearFlag(name)
    if (TFLAGS[name]) then
        NTIME.delete(TFLAGS[name]);
    end
    FLAGS[name] = nil;
    TFLAGS[name] = nil;
end

function NU.cooldown(name, time)
    NU.setFlag(name .. "_cd", NU.time() + time, time);
end

function NU.remainingCD(name)
    return FLAGS[name .. "_cd"] and FLAGS[name .. "_cd"] - NU.time() or 0;
end

function NU.offCD(name)
    return not FLAGS[name .. "_cd"];
end

function NU.removeCD(name)
    NU.clearFlag(name .. "_cd");
end

-- Sets a flag that expires on prompt.
function NU.setPFlag(name, val)
    PFLAGS[name] = val;
end

function NU.clearPFlag(name)
    PFLAGS[name] = nil;
end

function NU.appendPFlag(name, val, asKey)
    if (PFLAGS[name] and type(PFLAGS[name]) ~= "table") then
        NU.DECHO("Tried to append to non-table prompt flag.", 10);
        return;
    end
    PFLAGS[name] = PFLAGS[name] or {};

    if (asKey) then
        PFLAGS[name][val] = true;
    else
        table.insert(PFLAGS[name], val);
    end
end

function NU.popPFlag(name)
    local flagValue = nil;
    if (PFLAGS[name] and type(PFLAGS[name] == "table")) then
        flagValue = table.remove(PFLAGS[name], 1);
    else
        NU.DECHO("Pop pflag called for " .. name .. " - which is not a table.", 3)
    end
    return flagValue;
end

function NU.flagPrompt()
    -- if (PFLAGS.gag_enqueue) then
    --     DeleteLine();
    -- end

    if (NU.DEBUG < 2) then
        for k,v in pairs(PFLAGS) do
            if (type(v) == "table") then
                echo(k .. " - {");
                for ik,iv in pairs(v) do
                    if (type(iv) == "table") then
                        echo(ik .. " - {");
                        for jk,jv in pairs(iv) do
                            echo(jk .. ":" .. tostring(jv) .. ", ");
                        end
                        echo("}, ");
                    else
                        echo(ik .. ":" .. tostring(iv) .. ", ");
                    end
                end
                echo("}\n");
            else
                echo(k .. " - " .. tostring(v) .. "\n");
            end
        end
    end
    LAST_PFLAGS = PFLAGS;
    PFLAGS = {};
end