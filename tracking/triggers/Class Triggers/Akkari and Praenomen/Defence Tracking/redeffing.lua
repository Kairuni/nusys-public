TRIG.register("self_already_relentless", "exact", [[You are already relentlessly resisting that which would harm you.]] , function() TRACK.addDef(TRACK.getSelf(), "relentless") end, 
"AKKARI_DEFENSES");
TRIG.register("self_already_acuity", "exact", [[Your senses are already sharpened to nearby movement.]] , function() TRACK.addDef(TRACK.getSelf(), "acuity") end, "AKKARI_DEFENSES");
TRIG.register("self_already_resolve", "exact", [[Your resolve is already shielding you from magical assault.]] , function() TRACK.addDef(TRACK.getSelf(), "resolve") end, "AKKARI_DEFENSES");
TRIG.register("self_already_holylight", "exact", [[You are already bringing fear to your enemies through an aura of light.]] , function() TRACK.addDef(TRACK.getSelf(), "holylight") end, 
"AKKARI_DEFENSES");
TRIG.register("self_already_spiritbolster", "exact", [[You have already bolstered the strength of your squire.]] , function() TRACK.addDef(TRACK.getSelf(), "spiritbolster") end, "AKKARI_DEFENSES");