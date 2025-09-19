TRIG.register("off_pillbal_gag", "start", [[You cannot eat another]], function() NU.gag("pill_offbal"); end);
TRIG.register("off_poulticebal_gag", "exact", [[You are not yet able to absorb another poultice.]], function() NU.gag("poultice_offbal"); end);
TRIG.register("off_secondarybal_gag", "exact", [[You must recover fulcrum balance first.]], function() NU.gag("secondary_offbal"); end);
TRIG.register("gag_offbal_focus", "exact", [[You concentrate, but your mind is too tired to focus.]], function() NU.gag("focus_offbal"); end);
TRIG.register("gag_off_eq_1", "exact", [[You must regain equilibrium first.]], function() NU.gag("off_eq"); end);
TRIG.register("gag_off_eq_2", "exact", [[You must recover equilibrium first.]], function() NU.gag("off_eq"); end);

-- Replacements:
TRIG.register("poultice_bal_replace", "exact", [[You are again able to absorb a poultice.]], function() creplaceLine("<green>Bal+: <cyan>POULTICE") end);
TRIG.register("anabiotic_bal_replace", "exact", [[You can swallow another anabiotic pill.]], function() creplaceLine("<green>Bal+: <blue>ANA") end);
TRIG.register("elixir_bal_replace", "exact", [[You may drink another healing elixir.]], function() creplaceLine("<green>Bal+: <gray>ELIXIR") end);
TRIG.register("tree_bal_replace", "exact", [[Your tree tattoo tingles slightly.]], function() creplaceLine("<green>Bal+: <SeaGreen>TREE") end);
TRIG.register("smoke_bal_replace", "exact", [[You may smoke another herb.]], function() creplaceLine("<green>Bal+: <SkyBlue>PIPE") end);
TRIG.register("pill_bal_replace", "exact", [[You may swallow another pill.]], function() creplaceLine("<green>Bal+: <orchid>PILL") end);
TRIG.register("bal_bal_replace", "exact", [[You have recovered balance on all limbs.]], function() creplaceLine("<green>Bal+: <DarkViolet>BALANCE") end);
TRIG.register("eq_bal_replace", "exact", [[You have recovered equilibrium.]], function() creplaceLine("<green>Bal+: <sky_blue>EQUILIBRIUM") end);