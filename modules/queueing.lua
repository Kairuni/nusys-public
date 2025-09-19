QUE = {
    queues = {
        -- Each queue will actively track what it's sending, what's been inqueued, and an expiry timer on trying to send that action.
        balance = {syntax = "qb ", sendExpiry = -1, sending = nil, inq = nil, actions = nil},
        equilibrium = {syntax = "qe ", sendExpiry = -1, sending = nil, inq = nil, actions = nil},
        eqbal = {syntax = "qeb ", sendExpiry = -1, sending = nil, inq = nil, actions = nil},
        elixir = {syntax = "queue elixir ", sendExpiry = -1, sending = nil, inq = nil, actions = nil},
        anabiotic = {syntax = "queue anabiotic ", sendExpiry = -1, sending = nil, inq = nil, actions = nil},
        pill = {syntax = "queue pill ", sendExpiry = -1, sending = nil, inq = nil, actions = nil},
        poultice = {syntax = "queue poultice ", sendExpiry = -1, sending = nil, inq = nil, actions = nil},
        pipe = {syntax = "queue pipe ", sendExpiry = -1, sending = nil, inq = nil, actions = nil},
        tree = {syntax = "queue tree ", sendExpiry = -1, sending = nil, inq = nil, actions = nil},
        focus = {syntax = "queue focus ", sendExpiry = -1, sending = nil, inq = nil, actions = nil},
        secondary = {syntax = "queue secondary ", sendExpiry = -1, sending = nil, inq = nil, actions = nil},
    },
}

QUE.enqueueNameToQueue = {
        ["act"] = QUE.queues.eqbal,
        ["recover balance"] = QUE.queues.balance,
        ["balance"] = QUE.queues.balance,
        ["recover equilibrium"] = QUE.queues.equilibrium,
        ["equilibrium"] = QUE.queues.equilibrium,
        ["sip an elixir"] = QUE.queues.elixir,
        ["elixir"] = QUE.queues.elixir,
        ["sip"] = QUE.queues.elixir,
        ["eat anabiotic"] = QUE.queues.anabiotic,
        ["anabiotic"] = QUE.queues.anabiotic,
        ["moss"] = QUE.queues.anabiotic,
        ["eat a pill"] = QUE.queues.pill,
        ["pill"] = QUE.queues.pill,
        ["herb"] = QUE.queues.pill,
        ["use a poultice"] = QUE.queues.poultice,
        ["poultice"] = QUE.queues.poultice,
        ["salve"] = QUE.queues.poultice,
        ["smoke a pipe"] = QUE.queues.pipe,
        ["pipe"] = QUE.queues.pipe,
        ["use tree"] = QUE.queues.tree,
        ["tree"] = QUE.queues.tree,
        ["focus"] = QUE.queues.focus,
}

local enqueueNameMT = {
    __index = function(t, k)
        if (QUE.queues[k]) then
            return QUE.queues[k];
        elseif (k == "poultice") then
            return QUE.queues.poultice;
        elseif (k == "pill") then
            return QUE.queues.pill;
        else
            return QUE.queues.secondary;
        end
    end
}

setmetatable(QUE.enqueueNameToQueue, enqueueNameMT);

-- Check if queue timers are expired - if so, resend the queueing command.
-- TODO: Enable this, it currently does nothing.
function QUE.queuePulse()
    for k,v in pairs(QUE.queues) do
        if (v.sending and v.sendExpiry < NU.time()) then
            v.sendExpiry = NU.time() + TRACK.latency();
            NU.SEND(v.sending);
        end
    end
end

-- Called when we get the 'All queued cleared' message.
function QUE.clearedAllQueues()
    for k,v in pairs(QUE.queues) do
        v.inq = nil;
        v.sending = nil;
        v.actions = nil;
        v.sendExpiry = -1;
    end
    NU.clearFlag("queued_cures");
    NU.clearFlag("queued_cure_queues");
    NU.gag("que");
end

-- Called when a queue goes through -or- when a queue is cleared.
function QUE.clearedSomeQueue(queue)
    local tb = QUE.enqueueNameToQueue[queue];
    tb.inq = nil;
    tb.sending = nil;
    tb.actions = nil;
    tb.sendExpiry = -1;
    NU.gag("que");

    if (FLAGS.queued_cure_queues and FLAGS.queued_cure_queues[queue]) then
        local affCure = FLAGS.queued_cure_queues[queue];
        FLAGS.queued_cures[affCure] = nil;
        FLAGS.queued_cure_queues[queue] = nil;
    end
end

-- Called when we enqueue something.
function QUE.onEnqueue(queue, content)
    local tb = QUE.enqueueNameToQueue[queue];
    content = string.trim(content);
    tb.inq = content;
    if (content ~= tb.sending and not NU.config.curing.wattle) then
        NU.WARN("Queue contents: [[" .. content .. "]] did not match what was sent. Expected: [[" .. tostring(tb.sending) .. "]]");
    end
    tb.sending = nil;
    tb.sendExpiry = -1;
    NU.gag("que");
end

-- Called to enqueue something
function QUE.enqueue(queue, content, actions, source)
    local tb = QUE.enqueueNameToQueue[queue];
    content = string.trim(content);
    NU.DECHO("ENQUEUED " .. queue .. " FROM " .. source, 1);
    if (content ~= tb.sending and content ~= tb.inq) then
        -- Strip left/right whitespace.
        tb.sending = content;
        tb.sendExpiry = NU.time() + TRACK.latency();
        tb.actions = actions;
        NU.ECHO("TEMP : enqueue for " ..
            tostring(queue) .. " with content " .. tostring(content) .. " from " .. tostring(source));
        NU.SEND(tb.syntax .. content);
    end
end

-- Called to clear a specific queue
function QUE.clearQueue(queue, source)
    local tb = QUE.queues[queue];
    NU.DECHO("CLEARED " .. queue .. " FROM " .. source, 1);
    if ((tb.inq and not tb.sending and tb.sendExpiry > NU.time()) or tb.sending) then
        NU.ECHO("TEMP : Clear queue for " .. queue .. " from " .. tostring(source))
        NU.SEND(tb.syntax);
        tb.sending = nil;
        tb.actions = nil;
        tb.sendExpiry = NU.time() + TRACK.latency();
    end
end

-- Temp function to check if inq or sending.
function QUE.hasContents(queue)
    local tb = QUE.queues[queue];
    if (tb.inq or tb.sending) then
        return true;
    end
    return false;
end

-- Called to clear all queues.
function QUE.clearAllQueues()
    for k,v in pairs(QUE.queues) do
        if ((v.inq and not v.sending and v.sendExpiry > NU.time()) or v.sending) then
            NU.ECHO("Clear all queues called");
            NU.SEND(v.syntax);
            v.sending = nil;
            v.actions = nil;
            v.sendExpiry = NU.time() + TRACK.latency();
        end
    end
end

function QUE.matchActions(queue, actions)
    local tb = QUE.queues[queue];
    if (tb.actions and #tb.actions == #actions) then
        local i = 1;
        for _,v in ipairs(actions) do
            if (tb.actions[i] ~= actions[i]) then
                return false;
            end
            i = i + 1;
        end
        return true;
    end
    return false;
end

NU.load("queueing", "triggers_queue_tracking")();
