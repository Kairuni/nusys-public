--You order a gryphon and an efreeti to assume a passive stance.
TRIG.register("touch_amnesia", "exact", [[You have no amnesia.]], function() NU.gag("touch_amnesia"); end);

TRIG.register("gag_no_riding", "exact", [[You are not currently riding anything.]], function() NU.gag("not_riding"); end);

TRIG.register("outc_gagging", "regex", [[^You remove (\d+) .+ bringing the total in the cache to (\d+)\.$]], function() NU.gag("outc_gag"); end);

TRIG.register("emptyline_gag", "regex", [[^$]], function() if (not NU.paused) then NU.gag("empty"); end end);

NU.loadAll("gags_and_warnings");