function TRACK.addHidden(ttable, source, affList)
    local affMap = {};
    for _,v in ipairs(affList) do
        -- In theory hiddens shouldn't show up if we already have the aff.
        if (not ttable.affs[v]) then
            affMap[v] = true;
        end
    end
    table.insert(ttable.hidden, { source = source, affMap = affMap, chanceCured = 0.0, appliedTime = NU.time() });
end

function TRACK.getHiddenCandidateIndicies(ttable, aff)
    local ret = {};
    for i,v in ipairs(ttable.hidden) do
        if (v.affMap[aff]) then
            table.insert(ret, i);
        end
    end
    return ret;
end

function TRACK.getTotalHiddenCount(ttable, testFunc)
    local count = 0;
    for _,v in ipairs(ttable.hidden) do
        if (not testFunc or testFunc(ttable, v)) then
            count = count + 1.0 - v.chanceCured;
        end
    end
    return count;
end

function TRACK.getHiddenTypeCount(ttable, typeTable, willCure, isAffPending)
    willCure = willCure or {};
    isAffPending = isAffPending or function() return false; end;

    local count = 0.0;
    for _,v in ipairs(ttable.hidden) do
        local adder = 1.0;
        local typeCount = 0;
        local affCount = 0;
        for aff,active in pairs(v.affMap) do
            if (active) then
                if (typeTable[aff] and not ttable.affs[aff] and not TRACK.cannotCure(ttable, aff) and not willCure[aff] and not isAffPending(aff)) then
                    typeCount = typeCount + 1;
                end
                affCount = affCount + 1;
            end
        end
        local typeRatio = typeCount / affCount;
        adder = (typeRatio > v.chanceCured) and typeRatio or v.chanceCured;
        count = count + (adder - v.chanceCured)
    end
    return count;
end

-- Called when we detect that there was no hidden affliction for this aff.
function TRACK.ruleOutHidden(ttable, aff)
    if (PFLAGS.illusion) then return; end

    --echo("\nRuled out hidden on " .. ttable.name .. " : " .. aff .. "\n");
    local i = 1;
    local discovered = {};
    while (i <= #ttable.hidden) do
        ttable.hidden[i].affMap[aff] = nil;
        if (table.size(ttable.hidden[i].affMap) == 1) then
            local toAff = table.remove(ttable.hidden, i);
            --echo("\nOnly one aff left, so it must be " .. toAff .. "\n");
            -- TODO: Determine if we need a taff.
            table.insert(discovered, toAff);
        elseif (table.size(ttable.hidden[i].affMap) == 0) then
            NU.WARN("\nRan out of hidden options for " .. ttable.hidden[i].source .. " Hidden Affs.\n");
            table.remove(ttable.hidden, i);
        else
            i = i + 1;
        end
    end

    for _, toAff in ipairs(discovered) do
        TRACK.hiddenDiscovery(ttable, toAff);
    end
end

function TRACK.ruleOutAging(ttable)
    if (PFLAGS.illusion) then return; end

    --echo("\nRuled out hidden on " .. ttable.name .. " : " .. aff .. "\n");
    local i = 1;
    local discovered = {};

    while (i <= #ttable.hidden) do
        local ht = ttable.hidden[i];
        if (ht.affMap.vomiting and ht.appliedTime + 15 >= NU.time()) then
            ht.affMap.vomiting = nil;
        end
        if (ht.affMap.allergies and ht.appliedTime + 8 >= NU.time()) then
            ht.affMap.allergies = nil;
        end
        if (ht.affMap.dyscrasia and FLAGS.recent_venom and FLAGS.recent_venom > NU.time()) then
            ht.affMap.dyscrasia = nil;
        end
        if (table.size(ttable.hidden[i].affMap) == 1) then
            local toAff = table.remove(ttable.hidden, i);
            table.insert(discovered, toAff);
        elseif (table.size(ttable.hidden[i].affMap) == 0) then
            NU.WARN("\nRan out of hidden options for " .. ttable.hidden[i].source .. " Hidden Affs.\n");
            table.remove(ttable.hidden, i);
        else
            i = i + 1;
        end
    end
    for _, toAff in ipairs(discovered) do
        TRACK.hiddenDiscovery(ttable, toAff);
    end
end

-- Called when we either cure an aff we
function TRACK.hiddenDiscovery(ttable, aff)
    if (PFLAGS.illusion) then return; end
    --local affName = AFFS.mirrors[aff] or aff;

    --echo("\nDiscovering " .. ttable.name .. " : " .. aff .. "\n")
    -- Do nothing if we knew we had the aff.
    if (ttable.affs[aff]) then return; end

    local possible = TRACK.getHiddenCandidateIndicies(ttable, aff)
    --display(possible);

    -- If there's only one possibility, just remove that possibility.
    if (#possible == 1) then
        --display("Removing the whole thing for the possible index.");
        --echo("\nRemoving the only possibly hidden candidate.\n");
        table.remove(ttable.hidden, possible[1]);
    else
        --display("Digging through possibilities.");
        -- Otherwise, go through each possibility and set the detected aff to false to remove it from further consideration (TODO: maybe invert the logic here so we set it to true instead for 'already observed')
        -- Sets the chance that this hidden was cured up to a max of 1.0.
        for _,index in ipairs(possible) do
            if (ttable.hidden[index].affMap[aff]) then
                --echo("\nRemoved candidate from index " .. tostring(index) .. "\n");
                ttable.hidden[index].affMap[aff] = nil;
                local newChance = ttable.hidden[index].chanceCured + (1.0 / #possible);
                ttable.hidden[index].chanceCured = (1.0 > newChance) and newChance or 1.0;
            end
        end
    end

    -- Now that we've cleaned out some choices from the hidden table, if we're down to 1 possible aff remaining and that hasn't been removed from our list, add it.
    -- NOTE: This is the part I'm most skeptical about. Test this thoroughly. We can leave the above intact while removing this.
    -- Also try a few specific test cases against this.
    for _,v in ipairs(ttable.hidden) do
        if (v.chanceCured < 1.0) then
            local lastAff = "";
            local count = 0;
            -- Shouldn't need to do this whole thing if we nil out known hiddens across the board.
            for testAff, isPossible in pairs(v.affMap) do
                --echo("\nTesting " .. testAff .. " (" .. tostring(isPossible) .. ")" .. "\n");
                if (isPossible) then
                    lastAff = testAff;
                    count = count + 1;
                end
            end

            if (count == 1) then
                v.chanceCured = 1.0;
                v.affMap[lastAff] = nil;
                echo("\nOnly one hidden aff left: " .. lastAff .. "\n");
                TRACK.aff(ttable, lastAff);
            end
        end
    end

    -- Finally, delete any now-useless hiddens.
    local i = 1;
    local len = #ttable.hidden;
    -- echo("\n" .. tostring(len) .. "\n");
    while (i <= len) do
        if (ttable.hidden[i].chanceCured >= 1.0) then
            echo("\n100% chance cured." .. "\n");
            table.remove(ttable.hidden, i);
            len = #ttable.hidden;
        else
            i = i + 1;
        end
    end
end

function TRACK.onHidden()
    if (PFLAGS.illusion) then return; end
    if (not PFLAGS.expected_hiddens) then
        NU.WARN("Untracked hidden affliction!" .. "\n");
        return;
    end

    TRACK.addHidden(TRACK.getSelf(), PFLAGS.expected_hiddens.source, PFLAGS.expected_hiddens.affList);
    cecho(" ");
    cecho("HC: " .. tostring(#TRACK.getSelf().hidden));
    cecho("New Hidden Candidate: ")
    for i, v in ipairs(PFLAGS.expected_hiddens.affList) do
        if (i > 1) then
            echo(", ");
        end
        echo(v);
    end
    PFLAGS.expected_hiddens.expectedCount = PFLAGS.expected_hiddens.expectedCount - 1;
    if (PFLAGS.expected_hiddens.expectedCount == 0) then
        NU.clearPFlag("expected_hiddens");
    end
end