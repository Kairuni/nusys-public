TRIG.register("eq_used", "regex", [[^Equilibrium Used\: ([\d\.]+) seconds?$]], function()
    local st = TRACK.getSelf();
    TRACK.useBalance(st, "equilibrium", tonumber(matches[2]))
    NU.setPFlag("next_bal_type_for_ttr", "equilibrium");
end);
TRIG.register("bal_used", "regex", [[^Balance Used\: ([\d\.]+) seconds?$]], function()
    local st = TRACK.getSelf();
    TRACK.useBalance(st, "balance", tonumber(matches[2]))
    NU.setPFlag("next_bal_type_for_ttr", "balance");
end);

TRIG.register("time_to_recover", "regex", [[^Time to recover\: ([\d\.]+) seconds?$]], function()
    if (PFLAGS.next_bal_type_for_ttr) then
        local st = TRACK.getSelf();
        TRACK.useBalance(st, PFLAGS.next_bal_type_for_ttr, tonumber(matches[2]))
    end
end, "Balance Tracking", "When you're already off a balance.");

TRIG.register("fulcrum_used", "regex", [[^Fulcrum Balance Used\: ([\d\.]+) seconds?$]],
    function() TRACK.useBalance(TRACK.getSelf(), "ability_bal", tonumber(matches[2])) end);
TRIG.register("hackles_used", "regex", [[^Hackles Balance Used\: ([\d\.]+) seconds?$]],
    function() TRACK.useBalance(TRACK.getSelf(), "ability_bal", tonumber(matches[2])) end);
TRIG.register("cosmic_used", "regex", [[^Cosmic Balance Used\: ([\d\.]+) seconds?$]],
    function() TRACK.useBalance(TRACK.getSelf(), "ability_bal", tonumber(matches[2])) end);

--    You may draw upon complex cosmic forces again.
