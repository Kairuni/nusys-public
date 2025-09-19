TRIG.register("nature_panacea_replace", "exact", [[You may once again purify your body of ailments.]], function() creplaceLine("<green>Bal+: <medium_spring_green>** PANACEA **") end);

TRIG.register("boost_gag_1", "exact", [[You will your natural energy flow to your fingertips and prepare to empower your next attack.]], function() NU.gag("shaman_boost"); end);
TRIG.register("boost_gag_2", "exact", [[You are already boosting your next attack!]], function() NU.gag("shaman_boost"); end);
TRIG.register("energy_gag", "exact", [[You do not have enough natural energy for that feat.]], function() NU.gag("shaman_boost"); end);
TRIG.register("fetish_gag", "exact", [[Your fetishes are already attuned to that target!]], function() NU.gag("shaman_attune"); end);