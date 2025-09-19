-- So, we have a few problems.
-- Order matters. Order matters a lot. This isn't a new thing, but it's also something YAAS never actually handled - YAAS held sending cures until it could actually work. The existing system is already better than that was.
-- All that said, I think we're probably already good. Just need to rewrite the curing file so it's not as janky as it is, and rewrite queueing.
-- I can't think of anything other than baleq and potential force cases where we'll want to have different rankings for priority.
-- The existing setup in curing.lua can also be expanded to include other free actions beforehand, but at the cost of looking janky.
-- So, I think what we need to do is clearly define the problem:
--     While curing, I want to loop through a list of potential actions until I run out of actions I can add.
--     Some of these actions are free, but require balance and equilibrium.
--     Some of these actions cost balance or equilibrium.
--     Most of these actions will consume some other balance, and cure some guaranteed affliction.
--     Random affliction cures should likely be handled after other cures, so we guarantee we won't waste said random cure.
--
--     Things that require and consume eqbal - Fitness, other class CURES.
--     Things that require and DO NOT consume eqbal - Most class secondary actions (sleights/flare, etc). Renew.
--     Things that have other blockers - tree, concentrate, etc.
--     Things that knock balance (dazed requires recoup)
--
-- We generally know what we want to send based on what balance comes back. We could try to do some cheeky things, like queue pill eat decongestant##smoke yarrow or whatever, but I think that's less trackable and more likely to get fucked by aeon than what it's currently doing.
-- Instead, I think we utilize queues when we're offbal - exactly the way curing is doing now, but clean up the logic.
-- queued_cures needs some work - we don't actually clear queues yet.
-- Need to go through the queueing logic now.
--
-- Just finished rewriting queueing.
-- What we need next is some actions system - we'll be tracking the action, the order, expected cure, and what category it falls under.

--

local balanceMT = {
    __index = function(t, k)
        return t["ability_bal"];
    end
}

local function buildBalanceTable()
    local retTable = {};

    for _,v in ipairs(BALANCES) do
        retTable[v] = false;
    end

    setmetatable(retTable, balanceMT);

    return retTable;
end

ACTIONS = {};

NU.loadAll("actions");

local function buildOrAppend(inStr, syntax, i)
    local outStr = "";
    if (#inStr > 0) then
        outStr = inStr .. NU.config.separator .. syntax;
    else
        outStr = syntax;
    end
    i = i + 1;
    return outStr, i;
end

local function handleActions(actionList, cutAt, doSend)
    if (not gmcp.Char) then return "", 0; end

    local st = TRACK.getSelf();
    local sendStr = "";
    local i = 1;

    if (st.affs.asleep or st.affs.writhe_ice or st.affs.STUN or st.affs.UNCONSCIOUS) then
        -- Let's save myself a bit of pain.
        -- Aetolia itself handles wake.
        return "", 0;
    end

    for _,v in ipairs(actionList) do
        sendStr, i = buildOrAppend(sendStr, v.syntax, i);

        if (v.bal) then
            NU.setFlag(v.bal .. "_sent", v.aff or true, TRACK.latency(v.bal));
        end
        if (v.aff) then
            NU.appendFlag("pending_cures", v.aff, NU.time() + TRACK.latency(), TRACK.latency(v.bal));
        elseif (not v.attack) then
            -- y tho
            display("Something without an aff in the action list?");
            display(v);
        end

        if (cutAt and i >= cutAt and doSend) then
            NU.SEND("touch amnesia" .. NU.config.separator .. sendStr);
            sendStr = "";
            i = 1;
        elseif (cutAt and i >= cutAt) then
            NU.WARN("WEE-OO STRING ABOVE CUT AT LIMIT BUT DO SEND IS FALSE");
        end
    end

    if (sendStr ~= "" and doSend) then
        NU.SEND("touch amnesia" .. NU.config.separator .. sendStr);
    end
    return sendStr, i;
end

-- TODO: Problem with the non-curing sets right now - queues are -not- handled gracefully for most actions because handleActions doesn't touched queueUpdates
function ACTIONS.pulse()
    if (NU.paused) then
        return;
    end

    local st = TRACK.getSelf();

    -- TODO: Channeling block here is insufficient to cover cases where it is a 'channel' that you can still do other shit during, like heelrush.
    if (FLAGS[st.name .. "_channeling"] or st.affs.stun or st.affs.disabled or st.affs.UNCONSCIOUS) then
        NU.promptAppend("PULSE_BLOCK", "ACTION PULSE BLOCKED")
        return;
    end

    -- Before anything else, update our fake AFFS.
    for k,v in pairs(AFFS.fake) do
        if (v.test) then
            local lastState = st.affs[k];
            st.affs[k] = v.test(st);
            if (st.affs[k] ~= lastState) then
                NU.promptAppend("FAKE_" .. k, (st.affs[k] and "+" or "-") .. k);
            end
        end
    end

    -- And update our defenses if they were never set:
    if (not FLAGS.defs_set) then
        TRACK.updateMissingDefs(st);
        NU.setFlag("defs_set", true, -1);
    end

    local act = {
        -- Send whenever - no priority
        freeNoBal = {},
        -- Send when eqbal is available, before any eqbal consuming actions - no priority
        -- i.e. renew/etc.
        eqbalFree = {},
        -- Send when eqbal is available, consumes eqbal (can only do one)
        eqbalConsuming = CreatePriorityQueue(),
        -- Send -after- eqbalConsuming, assuming the other balance was not used:
        postEqbalEquilibrium = {},
        postEqbalBalance = {},

        -- There's also the max action cap of 15, and the action per second limit of 50.

        -- Otherwise, by balance:
        elixir = {},
        pill = {},
        poultice = {},
        pipe = {},
        tree = {},
        focus = {},
        anabiotic = {},

        otherBalanceConsuming = {},

        queueUpdates = {},

        willUseBalance = buildBalanceTable(),
    }

    act.eqbalConsuming:initialize();

    local willCure = {};

    if (NU.config.curing.consuming) then
        ACTIONS.targetedConsumingCures(act.otherBalanceConsuming, willCure, act.queueUpdates, act.willUseBalance);
    end

    if (NU.config.curing.free) then
        ACTIONS.freeCures(act, willCure);
    end

    local randomCureCount = 0;

    if (NU.config.curing.defenses) then
        ACTIONS.defenses(act, willCure);
    end

    if (FLAGS.def_up) then
        ACTIONS.defUp(act, willCure);
    end

    if (NU.config.curing.unknowns) then
        ACTIONS.unknownChecks(act, willCure);
    end

    local secondaryQueueUpdates = {};
    if (OFFENSE.active) then
        OFFENSE.active(act, willCure, randomCureCount);
    elseif (AUTOBASH.active) then
        AUTOBASH.offense(act, willCure, randomCureCount);
    end

    if (NU.config.curing.eqbal) then
        ACTIONS.balEqCures(act, willCure);
    end

    if (NU.config.curing.random) then
        randomCureCount = randomCureCount +
            ACTIONS.randomConsumingCures(act, willCure, act.queueUpdates, act.willUseBalance, randomCureCount);
    end
    -- Above builds the required actions for this pulse. Below executes the actions.

    if (not NU.config.curing.wattle) then
        handleActions(act.otherBalanceConsuming, 12, true);

        handleActions(act.freeNoBal, 12, true);
    end

    if (FLAGS.action_override) then
        local flag = FLAGS.action_override;
        act.eqbalConsuming:put({syntax = flag.syntax, bal = flag.bal, attack = true}, 0);
    end

    if not NU.config.curing.wattle and (#act.eqbalFree > 0 or act.eqbalConsuming:size() > 0) then
        -- NU.promptAppend("DEBUG_FOR_EQBAL",
        --     "FREE: " .. tostring(#act.eqbalFree) .. " QEB: " .. tostring(act.eqbalConsuming:size()))
        table.insert(act.eqbalFree, { syntax = "stand", 1, attack = true });
        table.insert(act.eqbalFree, { syntax = "enemy " .. NU.target, 1, attack = true });
    end
    local freeBalStr, freeBalCount = handleActions(act.eqbalFree, nil, false);

    local balQueue = "balance";
    if (TRACK.remainingBalance(st, "equilibrium") > TRACK.remainingBalance(st, "balance")) then
        balQueue = "equilibrium";
    end

    local eqBalStr, count = "", 0;

    if (not act.eqbalConsuming:empty() and not FLAGS[st.name .. "_channeling_no_qeb"]) then
        local eqBalAction = act.eqbalConsuming:pop();
        if (#eqBalStr > 0) then eqBalStr = eqBalStr .. NU.config.separator; end
        eqBalStr = eqBalStr .. eqBalAction.syntax;
        if (NU.DEBUG == 0) then display(eqBalAction); end
        act.willUseBalance[eqBalAction.bal] = true;
        if (eqBalAction.aff) then
            NU.appendFlag("pending_cures", eqBalAction.aff, NU.time() + TRACK.latency(), TRACK.latency());
        end
        count = count + 1;
    end

    local nextEqBalStr, nextCount = handleActions(act.postEqbalEquilibrium, nil, false);
    if (nextEqBalStr) then
        if (#eqBalStr > 0 and #act.postEqbalEquilibrium > 0) then eqBalStr = eqBalStr .. NU.config.separator; end    
        eqBalStr = eqBalStr .. nextEqBalStr;
        count = count + nextCount;
    end

    nextEqBalStr, nextCount = handleActions(act.postEqbalBalance, nil, false);
    if (nextEqBalStr) then
        if (#eqBalStr > 0 and #act.postEqbalBalance > 0) then eqBalStr = eqBalStr .. NU.config.separator; end
        eqBalStr = eqBalStr .. nextEqBalStr;
        count = count + nextCount;
    end

    if (NU.config.curing.wattle) then
        local otherBalanceStr, otherBalanceCount = handleActions(act.otherBalanceConsuming, 12, false);
        local freeActionStr, freeActionCount = handleActions(act.freeNoBal, 12, false);
        -- freeBalStr
        -- eqBalStr

        -- NU.promptAppend("other", otherBalanceStr);
        -- NU.promptAppend("freeActions", freeActionStr);
        -- NU.promptAppend("freeBal", freeBalStr);
        -- NU.promptAppend("eqBal", eqBalStr);
        if (freeActionStr ~= "") then
            send("nuSysToImmediate " .. freeActionStr, false);
        end
        if (freeBalStr ~= "" or eqBalStr ~= "") then
            local finalStr = freeBalStr;
            if finalStr ~= "" and eqBalStr ~= "" then
                finalStr = finalStr .. NU.config.separator .. eqBalStr;
            elseif finalStr == "" then
                finalStr = eqBalStr;
            end

            send("nuSysToBudge " .. finalStr, false);
        end
    else
        if (freeBalStr and freeBalStr ~= "") then
            local finalStr = "touch amnesia" .. NU.config.separator .. freeBalStr;
            if (st.affs.disorientated or st.affs.RETROGRADE) then
                -- Note that these actions are LOCKED IN when we send them. We cannot change them. So we will not.
                if (not FLAGS.pending_freebal and TRACK.remainingBalance(st, balQueue) <= 2.0 + TRACK.latency()) then
                    NU.SEND(finalStr);
                    NU.SEND("echo CLEAR_FREEBAL_FLAG");
                    NU.setFlag("pending_freebal", finalStr, TRACK.latency());
                end
            else
                QUE.enqueue(balQueue, finalStr, nil, "prepend eqbal Actions");
            end
        else
            QUE.clearQueue("balance", "prepend eqbal Actions")
            QUE.clearQueue("equilibrium", "prepend eqbal Actions")
        end

        if (freeBalCount > 14) then
            NU.WARN("WEE-OO-WEE-OO-WEE-OO TRIED TO SEND MORE THAN 14 PREPEND ACTIONS WEE-OO-WEE-OO");
        end

        if (eqBalStr ~= "") then
            local finalStr = "touch amnesia" .. NU.config.separator .. eqBalStr;
            if (st.affs.disorientated or st.affs.RETROGRADE) then
                -- Note that these actions are LOCKED IN when we send them. We cannot change them. So we will not.
                if (not FLAGS.pending_eqbal and TRACK.remainingBalance(st, balQueue) <= 2.0 + TRACK.latency()) then
                    echo("Sending: " .. finalStr);
                    NU.SEND(finalStr);
                    NU.SEND("echo CLEAR_EQBAL");
                    NU.setFlag("pending_eqbal", finalStr, TRACK.latency());
                end
            else
                QUE.enqueue("eqbal", finalStr, nil, "eqbal Actions");
            end
        else
            QUE.clearQueue("eqbal", "eqbal Actions")
        end

        if (count > 14) then
            NU.WARN("WEE-OO-WEE-OO-WEE-OO TRIED TO SEND MORE THAN 14 ACTIONS WEE-OO-WEE-OO");
        end

        -- Handle queued actions.
        if (not st.affs.RETROGRADE and not st.affs.disorientated and not st.affs.stun) then
            for k, v in pairs(act.queueUpdates) do
                if (not (k == "pipe" and FLAGS[TRACK.getSelf().name .. "_ironcollar"])) then
                    QUE.enqueue(k, v[1], v[3], "Actions");
                    NU.appendFlag("queued_cure_queues", k, v[2], 20);
                    NU.appendFlag("queued_cures", v[2], st.bals[k], 20);
                    if (FLAGS.pending_cures) then
                        FLAGS.pending_cures[v[2]] = nil
                    end
                end
            end
        end
        for k, v in pairs(QUE.queues) do
            if (not act.queueUpdates[k] and k ~= "eqbal" and k ~= "balance" and k ~= "equilibrium") then
                -- if (QUE.hasContents(k)) then
                --      display(k);
                --      display(act.queueUpdates);
                --      display(eqBalStr);
                --  end
                QUE.clearQueue(k, "Actions.")
            end
        end
        if (st.affs.RETROGRADE or st.affs.disorientated) then
            QUE.clearAllQueues();
        end
    end
end

TRIG.register("prompt_flag_clear", "prompt", nil, NU.flagPrompt);