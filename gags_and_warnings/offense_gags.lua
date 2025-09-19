TRIG.register("order_gag", "start", [[You order ]], function() NU.gag("entity_orders"); end);
TRIG.register("order_gag_kill", "start", [[They obey your command.]], function() NU.gag("entity_orders"); end);
TRIG.register("order_gag_passive", "start", [[They all seem to settle down.]], function() NU.gag("entity_orders"); end);

TRIG.register("entities_hostile", nil, [[is already hostile towards]], function() NU.gag("entity_orders"); end);
TRIG.register("meditate_break_gag", "exact", [[You snap your head up as you break your meditation.]], function() NU.gag("meditation"); end);

TRIG.register("start_tumble", "start", [[You begin to tumble agilely to the]], function() NU.BIGMSG("TUMBLING"); end);
TRIG.register("tumble_stopped", "exact", [[You bring your tumbling to a halt.]], function() NU.BIGMSG("TUMBLE STOPPED"); end);

local function targetLeavingTrigger()
    if (matches[2]:lower() == NU.target) then
        replaceLine("");
        NU.BIGMSG("TARGET RAN " .. matches[3]:upper(), 3, "purple");
    end
end

local function targetEnteredTrigger()
    if (matches[2]:lower() == NU.target) then
        replaceLine("");
        NU.BIGMSG("TARGET ARRIVED", 3, "magenta")
    end
end

local function targetTumbling()
    if (matches[2]:lower() == NU.target) then
        replaceLine("");
        NU.BIGMSG("TARGET TUMBLING: " .. matches[3]);
        NU.setFlag("target_tumbling", NU.time() + 6, 6);
    end
end

local function targetTumbled()
    if (matches[2]:lower() == NU.target) then
        replaceLine("");
        NU.BIGMSG("TARGET TUMBLED - OUT OF ROOM: " .. matches[3]);
        NU.clearFlag("target_tumbling");
    end
end

TRIG.register("target_left_1", "regex", [[(\w+) leaves to the (\w+)]], targetLeavingTrigger);
TRIG.register("target_left_2", "regex", [[(\w+) suddenly leaps away to the (\w+)]], targetLeavingTrigger);
TRIG.register("target_left_3", "regex", [[(\w+) strides away to the (\w+)]], targetLeavingTrigger);
TRIG.register("target_left_4", "regex", [[^(\w+) leaps majestically to the (\w+)\.]], targetLeavingTrigger);
TRIG.register("target_left_5", "regex", [[^(\w+) rushes out to the (\w+)\, .+ body alight with flames\.$]], targetLeavingTrigger);
TRIG.register("target_trees", "regex", [[^(\w+) grabs a firm hold and swings up and out of sight to the (\w+)\.$]], targetLeavingTrigger);
TRIG.register("target_entered_1", "regex", [[^(\w+) arrives from]], targetEnteredTrigger);
TRIG.register("target_entered_2", "regex", [[^(\w+) swiftly gallops in]], targetEnteredTrigger);

TRIG.register("target_entered_1", "regex", [[^(\w+) begins to tumble towards the (\w+)\.$]], targetTumbling);
TRIG.register("target_entered_2", "regex", [[^(\w+) tumbles out to the (\w+)\.$]], targetTumbled);