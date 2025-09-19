local balanceMT = {
    __index = function(t, k)
        if (k == "secondary") then
            return t["ability_bal"];
        else
            return nil;
        end
    end
}

function TRACK.buildBalanceTable()
    local retTable = {};

    for _,v in ipairs(BALANCES) do
        retTable[v] = -1;
    end

    setmetatable(retTable, balanceMT);

    return retTable;
end

function TRACK.useBalance(ttable, bal, amount, tolerance, adder, multiplier)
    -- This is a fairly loaded idea.
    -- If a reference is provided, amount doesn't really matter. So we've loaded amount and reference into the same variable.
    -- Assuming a tolerance of 3 for 99.7% chance it's recovered by the time we test for it.
    if (type(amount) == "table") then
        local balTime = amount.mean * (multiplier or 1) + (adder or 0) + amount.stdDev * (tolerance or 3)
        ttable.bals[bal] = NU.time() + balTime;
        if (NU.DEBUG) then
            NTIME.timer(balTime,
                function() NU.DECHO("Expected " .. bal .. " recovery for " .. ttable.name .. ".", 10); end);
        end
    else
        ttable.bals[bal] = NU.time() + amount;
        -- NU.ECHO(ttable.name ..
        -- " used bal " ..
        -- bal ..
        -- " for " .. tostring(amount) .. "recovery at " .. tostring(NU.time() + amount) .. " from " .. tostring(NU.time()));
        if (PFLAGS.untracked) then
            NU.setFlag("last_untracked_balance_cost", {bal, amount});
        end
        if (NU.DEBUG) then
            NTIME.timer(amount,
                function() NU.DECHO("Expected " .. bal .. " recovery for " .. ttable.name .. ".", 10); end);
        end
    end
end

function TRACK.hasBalance(ttable, bal)
    if (ttable.bals[bal] == nil) then
        NU.ECHO("BAL MISSING: " .. tostring(bal));
    end
    if (not ttable.bals[bal]) then
        display(bal)
        return false;
    end
    return NU.time() >= ttable.bals[bal];
end

function TRACK.remainingBalance(ttable, bal)
    return math.max(ttable.bals[bal] - NU.time(), 0);
end