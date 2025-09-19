local function isCurePending(aff)
    return FLAGS.pending_cures and FLAGS.pending_cures[aff] and FLAGS.pending_cures[aff] > NU.time()
end

local function willHaveBalance(ttable, balance)
    if (balance == "eqbal") then
        return (TRACK.hasBalance(ttable, "balance") or TRACK.remainingBalance(ttable, "balance") <= TRACK.latency())
                    and (TRACK.hasBalance(ttable, "equilibrium") or TRACK.remainingBalance(ttable, "equilibrium") <= TRACK.latency())
    end
    return TRACK.hasBalance(ttable, balance) or TRACK.remainingBalance(ttable, balance) <= TRACK.latency()
end

local function defenseActions(defense, defConfig, act, willCure, affStr)
    local st = TRACK.getSelf();
    if (not DEFS.actions[defense]) then
        NU.WARN("WARNING: Defense " .. defense .. " not in the actions list.");
        return;
    elseif (not DEFS.actions[defense][defConfig.action]) then
        NU.WARN("WARNING: Defense " .. defense .. " has no configured action.");
        return;
    elseif (not DEFS.actions[defense][defConfig.action].ab) then
        NU.WARN("No AB configured.")
        return
    end
    local defAction = DEFS.actions[defense][defConfig.action];
    local ab = DEFS.actions[defense][defConfig.action].ab;
    local emp = DEFS.actions[defense][defConfig.action].empowerment or "";
    local data = DEFS.actions[defense][defConfig.action].data;

    if (DEFS.actions[defense][defConfig.action].usePrio) then
        -- If it's flagged with usePrio, just skip this entirely.
        return;
    end

    if (not ab) then
        NU.WARN("WEEOOWEEOO " .. defense .. " IS NOT A DEFINED AB.");
        return;
    end

    local balance = ab.balance and ab.balance(st, nil, data) or nil;
    if (balance) then
        -- If this is a standard balance, return. We only want to handle eqbal in here.
        if (balance.self and CURES[balance.self]) then
            return;
        end
    end

    local syntax = ab.syntax[NU.getClass()] or ab.syntax.Default;
    if (not syntax) then
        display(defense);
        display(ab);
        return;
    end
    syntax = syntax:gsub("$empowerment", emp);
    if (data) then
        for target, value in pairs(data) do
            syntax = syntax:gsub("$" .. target, value);
        end
    end


    if (ab.meetsPreReqs(st)) then
        local balance = ab.balance().self;
        local bal = balance.bal;
        local balCost = balance.cost;

        if (bal and balCost and balCost > 0 and not act.willUseBalance[bal] and willHaveBalance(st, bal)) then -- 
            -- If it doesn't require eqbal, eq, or bal:
            if (bal ~= "eqbal" and bal ~= "balance" and bal ~= "equilibrium" and not isCurePending(affStr)) then
                act.willUseBalance[bal] = true;
                willCure[affStr] = true;
                table.insert(act.otherBalanceConsuming, {syntax = syntax, bal = bal, aff = affStr});
            else
                act.eqbalConsuming:put({syntax = syntax, bal = bal, aff = affStr}, defAction.priorOverride or 5);
                willCure[affStr] = true;
            end
        elseif (bal and (not balCost or balCost == 0)) then
            table.insert(act.eqbalFree, {syntax = syntax, aff = affStr});
            willCure[affStr] = true;
        elseif (not bal and not isCurePending(affStr)) then
            table.insert(act.freeNoBal, {syntax = syntax, aff = affStr});
            willCure[affStr] = true;
        end
    end
end

function ACTIONS.defenses(act, willCure)
    local st = TRACK.getSelf();

    for k,v in pairs(DEFS.config) do
        -- TODO: Remove non-eqbal defenses from this. Let the proper queues handle them by priority.
        local miscDeffed = FLAGS.misc_defs and FLAGS.misc_defs[k];
        local affStr = "no_" .. k;
        if (v.keep and st.affs[affStr] and not miscDeffed and not willCure[affStr] and (not v.classList or table.contains(v.classList, NU.getClass()))) then
            defenseActions(k, v, act, willCure, affStr);
        end
    end
end

function ACTIONS.defUp(act, willCure)
    local st = TRACK.getSelf();
    local found = false;
    for k,v in pairs(DEFS.config) do
        local affStr = "no_" .. k;
        local miscDeffed = FLAGS.misc_defs and FLAGS.misc_defs[k];
        local classValid = not v.classList or table.contains(v.classList, NU.getClass());
        if (v.defup and not st.defs[k] and not willCure[affStr] and not miscDeffed and classValid) then -- not isCurePending(affStr) and 
            defenseActions(k, v, act, willCure, "no_" .. k);
            NU.DECHO("Added defup for " .. k .. "\n", 4);
            found = true;
        elseif (v.defup and not st.defs[k] and not miscDeffed and classValid and (isCurePending(affStr) or willCure[affStr])) then
            found = true;
            NU.DECHO("Keeping defup active for " .. k .. "\n", 4);
        elseif (v.defup and not st.defs[k] and not miscDeffed and classValid) then
            display(k);
            display(v.defup);
            display(st.defs[k]);
            display(miscDeffed);
            display(classValid);
            display(isCurePending(affStr));
            display(willCure[affStr]);
        end
    end
    if (not found) then NU.ECHO("Done deffing up.\n"); NU.clearFlag("def_up"); end
end