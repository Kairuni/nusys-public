TRIG.register("gag_stutter", "exact", [[You stutter incoherently.]], function() NU.gag("stuttering"); end);
TRIG.register("gag_uncon", "exact", [[You are unconscious and thus incapable of action.]], function() NU.gag("unconscious"); NU.appendFlag("prompt_append", "UNCON", "UNCON"); end);
--TRIG.register("gag_stupidity", "exact", [[In your stupidity, you forgot what you were trying to do. Oops.]], function() NU.gag("stupidity"); end);

TRIG.register("afflicted_gag", "regex", [[^You are afflicted with (\w+)\.$]], function() NU.gag("afflicted"); end);
TRIG.register("gag_discovery", "regex", [[^You have discovered (\w+)\.$]], function() NU.gag("afflicted"); end);
TRIG.register("cure_gag", "regex", [[^You have cured (\w+)\.$]], function() NU.gag("cured"); end);

TRIG.register("stun_gag", "exact", [[You are too stunned to be able to do anything.]], function() NU.gag("stunned"); end);