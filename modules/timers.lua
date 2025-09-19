NTIMERS = {};
NTIME = {};

-- Timers break Mudlet pretty hard
-- And we don't actually have callbacks on most of our flags.
-- So, were's going to replicate tempTimer here.

-- tempTimer(duration, function to execute)

-- not a local, in case we want to reference it later.
NTIME.TIMER_ID = 0;

function NTIME.timer(time, func, _repeating)
    NTIME.TIMER_ID = NTIME.TIMER_ID + 1;
    NTIMERS[NTIME.TIMER_ID] = {startTime = NU.time(), endTime = NU.time() + time, func = func, repeating = _repeating};
    NU.DECHO("New timer with ID: " .. tostring(NTIME.TIMER_ID) .. " - start time: " ..
        tostring(NTIMERS[NTIME.TIMER_ID].startTime) .. " end time: " .. tostring(NTIMERS[NTIME.TIMER_ID].endTime) .. "\n",
        3);
    return NTIME.TIMER_ID;
end

function NTIME.convertTimestamp(timestamp)
    -- This is explicitly for Aetolia combat log timestamps from the sect scorebook.
    -- 01:24:45:21
    -- HH:MM:SS:MS/10

    -- NU.time() is in seconds, so:

    local hh, mm, ss, ms10 = string.match(timestamp, "(%d+):(%d+):(%d+):(%d+)");
    local time =
        -- Hours, i.e. 10th hour * 60 seconds in a minute * 60 minutes in an hour
        tonumber(hh) * 60 * 60 +
        -- Minutes, more straightforward - 60 seconds per minute.
        tonumber(mm) * 60 +
        -- Seconds
        tonumber(ss) +
        -- Timestamp is ms/10, so div by 10 instead of 100.
        (tonumber(ms10) / 10);

    return time;
end

function NTIME.update(_timestamp)
    local time = _timestamp and NTIME.convertTimestamp(_timestamp) or NU.time()

    local toRemove = {};
    for id, timer in pairs(NTIMERS) do
        -- structured as: {startTime = NU.time(), endTime = NU.time() + time, func = func, repeating = _repeating};
        if (timer.endTime <= time) then
            local overrideRepeat, doRepeat = false, false;
            if (timer.func) then
                overrideRepeat, doRepeat = timer.func();
            end

            if (not timer.repeating or (overrideRepeat and not doRepeat)) then
                table.insert(toRemove, id);
            else
                local duration = timer.endTime - timer.startTime;
                timer.startTime = time;
                timer.endTime = time + duration;
            end
        end
    end

    for _,id in ipairs(toRemove) do
        NTIMERS[id] = nil;
    end
end

function NTIME.delete(id)
    if (NTIMERS[id]) then
        NTIMERS[id] = nil;
        return true;
    end
    return false;
end