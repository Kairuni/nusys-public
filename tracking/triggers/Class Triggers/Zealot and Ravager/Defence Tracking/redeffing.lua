TRIG.register("self_already_focalmark", "exact", [[You already possess your focalmark.]] , function() TRACK.addDef(TRACK.getSelf(), "focalmark") end, "ZEALOT_DEFENSES");
TRIG.register("self_already_haste", "exact", [[You are already moving at full haste.]] , function() TRACK.addDef(TRACK.getSelf(), "haste") end, "ZEALOT_DEFENSES");
TRIG.register("self_already_disunion", "exact", [[You have already shattered your spirit - to do so further would cause death.]] , function() TRACK.addDef(TRACK.getSelf(), "disunion") end, "ZEALOT_DEFENSES");

TRIG.register("self_firefist_cd", "exact", [[You cannot ignite your fists again so soon.]],
    function() NU.cooldown(TRACK.getSelf().name .. "_Purification_Firefist", 80) end, "ZEALOT_DEFENSES");
TRIG.register("self_firefist_offcd", "exact", [[You may coat your fists in flames once more.]],
    function() NU.offCD(TRACK.getSelf().name .. "_Purification_Firefist"); end, "ZEALOT_DEFENSES");

TRIG.register("self_mindset_set", "regex", [[You adjust your mindset toward the (\w+) and shift your footing.]] , function()
    if (FLAGS.misc_defs) then
        FLAGS.misc_defs.mindset_star = false;
        FLAGS.misc_defs.mindset_sun = false;
        FLAGS.misc_defs.mindset_moon = false;
    end
    NU.appendFlag("misc_defs", "mindset_" .. matches[2]:lower(), true); end, "ZEALOT_DEFENSES");