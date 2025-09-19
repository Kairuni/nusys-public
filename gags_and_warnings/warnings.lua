TRIG.register("snap_warning", "regex", [[^(\w+) snaps .+ fingers in front of you\.$]], function() NU.BIGMSG("SNAPPED SNAPPED SNAPPED"); end);

TRIG.register("noose_warning", "exact", [[You feel uneasy as you hear the sound of something above you.]], function()
    NU.BIGMSG("NOOSE_1"); send("touch tentacle Seurimas##touch tentacle Whirran##touch tentacle Amyie##qeb n" .. NU.config.separator .. "ne" .. NU.config.separator .. "e" .. NU.config.separator .. "se" .. NU.config.separator .. "s" .. NU.config.separator .. "sw" .. NU.config.separator .. "w" .. NU.config.separator); end);
TRIG.register("noose_warning", "exact", [[A dark silhouette catches your eye from above, lowering some rope in hand towards you.]], function()
    NU.BIGMSG("NOOSE_1"); send("touch tentacle Seurimas##touch tentacle Whirran##touch tentacle Amyie##qeb ne" .. NU.config.separator .. "e" .. NU.config.separator .. "se" .. NU.config.separator .. "s" .. NU.config.separator .. "sw" .. NU.config.separator .. "w" .. NU.config.separator .. "nw"); end);
