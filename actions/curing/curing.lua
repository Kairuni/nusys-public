NU.curing = {};

local cureActions = {
    "pill",
    "pipe",
    "elixir",
    "poultice",
}

-- TODO: This is incomplete.
local cureBlockers = {
    pill = "anorexia",
    pipe = "asthma",
    poultice = "slickness",
    focus = "impatience",
    renew = "impairment",
    fitness = "disrupted",
    elixir = "anorexia",
    concentrate = "confusion",
}

local function hasWritheAff(ttable)
    for _,v in ipairs(AFFS.writheAffs) do
        if (ttable.affs[v]) then return true; end
    end
    return false;
end

local function isBalanceBlocked(cureType, ttable, cureList)
    if (ttable.affs[cureBlockers[cureType]] and not cureList.willCure[cureBlockers[cureType]]) then
        return true;
    end
    return false;
end

local function shouldDig(aff)
    -- Cases where we should dig an aff out, for now only do this for fake AFFS.
    return AFFS.fake[aff] ~= nil;
end

local cureToCommand = {
    pill = "eat C",
    pipe = "smoke C",
    elixir = "sip C",
    poultice = "apply C to L",
    poultice_to_skin = "apply C",
    focus = "focus",
}

local function isAffPending(aff)
    if (NU.DEBUG < 1 and FLAGS.pending_cures and FLAGS.pending_cures[aff]) then
        display(aff);
        display(FLAGS.pending_cures);
        display(NU.time());
        display(FLAGS.pending_cures[aff] - NU.time());
        display(FLAGS.pending_cures[aff] > NU.time());
    end
    local restoFlag = FLAGS[TRACK.getSelf().name .. "_resto_applied"];
    local restoPending = restoFlag and restoFlag[3] == aff;

    if ((FLAGS.pending_cures and FLAGS.pending_cures[aff] and FLAGS.pending_cures[aff] > NU.time()) or restoPending) then
        return true;
    end
    return false;
end

local randomBlocks = {
    hypothermia = function(ttable) return ttable.affs.frostbrand; end,
    shivering = function(ttable) return ttable.affs.frostbrand or ttable.affs.hypothermia; end,
    frigid = function(ttable) return ttable.affs.frostbrand; end,
    frozen = function(ttable) return ttable.affs.frozen; end,
}

function NU.curing.numberRandomCures(ttable, willCure)
    local count = 0;
    for _,v in ipairs(AFFS.irandom) do
        local randomBlocked = randomBlocks[v] and randomBlocks[v](ttable) or false;
        local blocked = TRACK.cannotCure(ttable, v);

        if (ttable.affs[v] and not willCure[v] and not isAffPending(v) and not blocked and not randomBlocked) then
            count = count + 1;
        end
    end

    local singleCountFlags = {
        "renew_sent",
        "tree_sent",
        "para_eqbal",
    }

    local twoCountFlags = {
        "fulcrum_restore_sent",
        "nature_panacea_sent",
    }

    for _,v in ipairs(singleCountFlags) do
        if (FLAGS[v]) then count = count - 1; end
    end

    for _,v in ipairs(twoCountFlags) do
        if (FLAGS[v]) then count = count - 2; end
    end

    count = count + TRACK.getHiddenTypeCount(ttable, AFFS.random, willCure, isAffPending);

    return count;
end


local function isAffQueued(aff)
    if (FLAGS.queued_cures and FLAGS.queued_cures[aff] and FLAGS.queued_cures[aff] > NU.time()) then
        return true;
    end
    return false;
end

local function doKeepPrio(aff)
    local isDef = AFFS.defs[aff];
    if (not isDef or (isDef and DEFS.config[aff:sub(4)].keep)) then
        return true;
    end
    return false;
end

local function willHaveBalance(ttable, balance)
    return TRACK.hasBalance(ttable, balance) or TRACK.remainingBalance(ttable, balance) <= TRACK.latency()
end

-- cureList.willCure a map of balance : cure, consumed balance
local function handleFocus(cureList)
    local st = TRACK.getSelf();
    if (st.affs.muddled and QUE.hasContents("focus")) then
        QUE.clearQueue("focus", "muddled_block");
    end
    if (isBalanceBlocked("focus", st, cureList) or st.affs.muddled or st.vitals.mp <= 500 or st.affs.besilence or st.affs.gloom) then return; end

    for _,v in ipairs(CURES.focus) do
        if (st.affs[v] and not cureList.willCure[v] and not isAffPending(v)) then
            cureList.actions.focus = v;
            if (willHaveBalance(st, "focus")) then
                table.insert(cureList.order, {"focus", v});
                if (#TRACK.getHiddenCandidateIndicies(st, "laxity") > 0) then
                    cureList.actions["focus"] = "focus" .. NU.config.separator .. "cooldowns";
                else
                    cureList.actions["focus"] = "focus";
                end
                cureList.willCure[v] = true;
                break;
            else
                cureList.queueUp["focus"] = {"focus", v}
            end
        end
    end
end

-- TODO: Fuck DRY, let's split this into poultice vs non-poultice. Nobody cares about application location >:(
local function handleCure(queue, cureList, prios)
    local st = TRACK.getSelf();
    if (isBalanceBlocked(queue, st, cureList)) then return; end

    for _, v in ipairs(prios) do
        if (st.affs[v] and not cureList.willCure[v] and not isAffPending(v) and doKeepPrio(v)) then
            local cureAction = CURES.lookup[v][queue];
            local cureTable = CURES[queue][cureAction];
            local location = nil;

            if (queue == "poultice") then -- TODO: Maybe have a different solution here rather than checking against a string every time.
                for poultice, loc in pairs(cureAction) do

                    cureTable = CURES[queue][poultice][loc];
                    cureAction = poultice;
                    location = loc;
                    break;
                end
            end


            if (NU.DEBUG == 0 or cureTable == nil) then
                NU.DECHO("SOMETHING VERY WRONG\n", cureTable == nil and 10 or 0);
                NU.DECHO(tostring(v) .. "\n", cureTable == nil and 10 or 0);
                NU.DECHO(tostring(queue) .. "\n", cureTable == nil and 10 or 0);
                NU.DECHO(tostring(cureAction) .. "\n", cureTable == nil and 10 or 0);
                NU.DECHO(tostring(cureTable) .. "\n", cureTable == nil and 10 or 0);
            else

                -- Test if we can cure this aff due to specific aff blockers
                local blocked = TRACK.cannotCure(st, v, queue, true);
                if (queue == "pill" and st.affs.gorged and FLAGS.gorged_pill and cureAction == FLAGS.gorged_pill) then
                    blocked = true;
                end

                if (TRACK.isAffSealed(st, v)) then
                    blocked = true;
                end

                local willCureOverride = nil;

                for _,aff in ipairs(cureTable) do
                    if (aff == v) then
                        break;
                    elseif (st.affs[aff] and not cureList.willCure[aff] and not shouldDig(v)) then
                        blocked = true;
                        break;
                    elseif (st.affs[aff] and not cureList.willCure[aff] and not willCureOverride) then
                        willCureOverride = aff;
                    end
                end

                if (not blocked and NU.config.stormtouched and queue == "pill" and FLAGS.last_eat == cureAction) then
                    blocked = true;
                end

                if (not blocked) then
                    local cureCmd = cureToCommand[queue]:gsub("C", cureAction);

                    local defense = AFFS.defs[v];
                    local action = defense and DEFS.config[defense].action or nil;
                    if (defense and (action ~= queue or action == "default")) then
                        -- Handle defenses that are prio'd
                        local ab = DEFS.actions[defense][action].ab;
                        local emp = DEFS.actions[defense][action].empowerment or "";
                        local data = DEFS.actions[defense][action].data;
                        if (not ab) then
                            NU.WARN("WEEOOWEEOO " .. defense .. " IS NOT A DEFINED AB.");
                            break;
                        end
                        local syntax = ab.syntax[NU.getClass()] or ab.syntax.Default;
                        syntax = syntax:gsub("$empowerment", emp);
                        if (data) then
                            for target, value in pairs(data) do
                                syntax = syntax:gsub("$" .. target, value);
                            end
                        end

                        cureCmd = syntax;
                    else
                        if (location and location ~= "skin") then
                            cureCmd = cureCmd:gsub("L", location);
                        elseif (location and location == "skin") then
                            cureCmd = cureToCommand.poultice_to_skin:gsub("C", cureAction);
                        end
                    end

                    if (willHaveBalance(st, queue)) then
                        --NU.DECHO("Picked " .. cureCmd .. " for " .. (willCureOverride or v), 10);
                        table.insert(cureList.order, {queue, willCureOverride or v});
                        cureList.actions[queue] = cureCmd;
                        cureList.willCure[willCureOverride or v] = true;
                        QUE.clearQueue(queue, "Sending an action");
                    else
                        --NU.DECHO("Picked " .. cureCmd .. " for " .. (willCureOverride or v), 10);
                        cureList.queueUp[queue] = {cureCmd, willCureOverride or v};
                    end
                    break;
                end
            end
        end
    end
end

function ACTIONS.targetedConsumingCures(actions, willCure, queueUp, balanceTable)
    local st = TRACK.getSelf();
    local cureList = {order = {}, actions = {}, willCure = willCure, queueUp = queueUp};

    local orderCount = 0;
    local lastOrderCount = -1;

    local count = 0;

    while (orderCount ~= lastOrderCount) do
        lastOrderCount = orderCount;
        NU.DECHO(orderCount, 0);
        NU.DECHO("Pre-Focus", 0);

        if (not cureList.actions.focus and not FLAGS["focus_sent"]) then
            handleFocus(cureList);
        end

        for _,v in ipairs(cureActions) do
            NU.DECHO("Cure Action " .. tostring(v) .."\n", 0);
            if (not cureList.actions[v] and not FLAGS[v .. "_sent"]) then
                handleCure(v, cureList, PRIOS.active[v]);
            end
        end
        orderCount = #cureList.order;

        count = count + 1;
        if (count > 100) then
            display("BROKE");
            break;
        end;
    end

    -- TODO: We've got a lot of repeated code here for handling focus vs handling anabiotic vs handling the other queues - see if we can refactor this.
    if (not st.affs.anorexia and not st.affs.destroyed_throat and (st.affs.HP_ANABIOTIC or st.affs.MP_ANABIOTIC or st.affs.plodding or st.affs.idiocy)) then
        if (willHaveBalance(st, "anabiotic") and not isAffPending("HP_M")) then
            table.insert(cureList.order, {"anabiotic", "HP_M"});
            cureList.actions["anabiotic"] = "eat anabiotic";
        elseif (not willHaveBalance(st, "anabiotic")) then
            cureList.queueUp["anabiotic"] = {"eat anabiotic", "HP_M"};
        end
    end

    for _,v in ipairs(cureList.order) do
        -- Build the final action list and prep it for return.
        table.insert(actions, {syntax = cureList.actions[v[1]], bal = v[1], aff = v[2]});
        balanceTable[v[1]] = true;

        -- If we're going to cure something this balance, remove it from the enqueue list.
        for action,tb in pairs(cureList.queueUp) do
            if (tb[2] == v[2]) then
                cureList.queueUp[action] = nil;
                cureList.actions[action] = nil;
            end
        end
    end
end

function ACTIONS.randomConsumingCures(actions, willCure, queueUpdates, willUseBalance, randomCureCount)
    local st = TRACK.getSelf();
    local count = NU.curing.numberRandomCures(TRACK.getSelf(), willCure);
    local curingCount = 0;

    local function getRandomOrKnown(count)

        return "random";
    end

    if (count >= 1 and willHaveBalance(st, "tree")
            and ((not st.affs.paresis and not st.affs.paralysis) or willCure.paresis or willCure.paralysis or willCure.TREE_PARALYSIS)
            and (count-randomCureCount) > #table.keys(willCure)
            and not st.affs.tree_seared
            and not st.affs.faulted
            and not st.affs.frozen
            and not FLAGS.shell_fetish
            and not FLAGS["tree_sent"]
            and not (st.affs.left_arm_crippled and st.affs.right_arm_crippled)
            and not st.affs.disabled
            and not hasWritheAff(st)) then
        willUseBalance.tree = true;
        table.insert(actions.otherBalanceConsuming, {syntax = "touch tree", bal = "tree", aff = getRandomOrKnown(count)});
        count = count - 1;
        curingCount = curingCount + 1;
    end

    return curingCount;
end

function ACTIONS.balEqCures(act, willCure)
    local st = TRACK.getSelf();
    local curingParesis = (not st.affs.paresis and not st.affs.paralysis) or willCure.paresis or willCure.paralysis;
    local lockScare = (st.affs.anorexia or st.affs.gorged or (not curingParesis and willHaveBalance(st, "tree") or st.affs.impatience) or st.affs.slickness) and st.affs.asthma;

    -- TODO: In theory, we should have some writhe prio.
    -- In practice, I don't think it actually matters.
    -- For now:
    local writheAff = false;

    for _,v in ipairs(AFFS.writheAffs) do
        if (st.affs[v]) then writheAff = v; break; end
    end

    if (st.affs.asleep or not writheAff) then
        NU.clearFlag("writhing");
    end

    if (not writheAff and FLAGS.fill_pipe and not st.affs.perplexity) then
        local found = false;
        for k,v in pairs(FLAGS.fill_pipe) do
            table.insert(act.eqbalFree, {syntax = "outc " .. k .. NU.config.separator .. "put " .. k .. " in " .. NU.config.pipes[k], aff = "empty_pipes"});
            found = true;
        end
        if (not found) then
            NU.clearFlag("fill_pipe");
        end
    elseif (not writheAff and FLAGS.fill_pipe) then
        local pipesOutStr = "";
        for k,v in pairs(FLAGS.fill_pipe) do
            if (#pipesOutStr > 0) then
                pipesOutStr = pipesOutStr .. "|";
            end
            pipesOutStr = pipesOutStr .. k;
        end
        NU.promptAppend("perplexity", "PIPES OUT AND perplexity: " .. pipesOutStr);
    end

    PRIOS.active.parry(act); -- not isAffPending("no_parry") and
    if (PARRY.active) then
        PARRY.active(act);
    end

    -- (#act.eqbalFree > 0 or #act.eqbalConsuming > 0) and 
    if (FLAGS.parry and ((FLAGS.parrying and FLAGS.parry ~= FLAGS.parrying) or not FLAGS.parrying) and FLAGS.recent_attack) then
        local parrySyn = NU.getClass() == "zealot" and "fend" or (
                                         NU.getClass() == "Monk" and "guard" or
                                         "parry");
        table.insert(act.eqbalFree, {syntax = parrySyn .. " " .. FLAGS.parry, bal = "eqbal", aff = "no_parry"});
    end

    if (not st.affs.PRONE and not FLAGS.nimbleness_cd and not (st.affs.left_leg_crippled and st.affs.right_leg_crippled) and (
            (
                (st.affs.paresis or st.affs.paralysis or st.affs.asthma) and (st.affs.slickness or st.affs.anorexia or st.affs.wraith or st.affs.soul_disease)
            )
            or
            (
                st.affs.left_arm_broken or st.affs.right_arm_broken or st.affs.left_leg_broken or st.affs.right_leg_broken
            )
        )) then
        table.insert(act.eqbalFree, {syntax = "nimbleness", aff = "no_nimbleness"});
    end

    if (st.affs.FALLEN and not st.affs.left_leg_crippled and not st.affs.right_leg_crippled and not writheAff and not st.affs.frozen and not st.affs.paralysis) then
        table.insert(act.eqbalFree, {syntax = "stand", bal = "eqbal", aff = "fallen"});
    end

    if (TRACK.getTotalHiddenCount(st) > 4 and not st.affs.hypochondria) then
        act.eqbalConsuming:put({syntax = "diag", bal = "balance", aff = "unknown"}, 1);
    end
end

function ACTIONS.freeCures(act, willCure)
    local st = TRACK.getSelf();
    if (st.affs.fear and not isAffPending("fear") and not st.affs.terror) then
        table.insert(act.freeNoBal, {syntax = "compose", aff = "fear"});
    end

    if (FLAGS[TRACK.getSelf().name .. "_ironcollar"] == 1 and not st.affs.perplexity) then
        table.insert(act.freeNoBal, {syntax = "remove " .. FLAGS.last_ironcollar, aff = "ironcollar"});
    end
end

local hiddenDirectChecks = {

}

local hiddenFunctionChecks = {


-- TODO: Tree and renew failing to cure are not removing random curable AFFS.
-- TODO: Ensure failing to cure removes hiddens too
function ACTIONS.unknownChecks(act, willCure)
    local st = TRACK.getSelf();
    for k,v in pairs(hiddenDirectChecks) do
        if (#TRACK.getHiddenCandidateIndicies(st, k) > 0 and not isAffPending("test_" .. k)) then
            local syntax = v.syntax:gsub("$s", st.name):gsub("$t", NU.target);
            local aff = "test_" .. k;
            if (v.bal) then
                table.insert(act.eqbalFree, {syntax = syntax, aff = aff});
            else
                table.insert(act.freeNoBal, {syntax = syntax, aff = aff});
            end
        end
    end
    for k,v in pairs(hiddenFunctionChecks) do
        if (#TRACK.getHiddenCandidateIndicies(st, k) > 0) then
            local checkTest, testValid = v(st, act);

            if (checkTest and testValid) then
                TRACK.hiddenDiscovery(st, k);
                if (string.sub(k, 1, 3) ~= "no_") then
                    TRACK.aff(st, k);
                else
                    TRACK.stripDef(st, string.sub(k, 4));
                end
            elseif (checkTest and not testValid) then
                TRACK.ruleOutHidden(st, k);
            end
        end
    end

    -- And finally, timer based checks.
    TRACK.ruleOutAging(st);
end