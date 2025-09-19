TRIG.register("self_nimbleness_cd", "exact", [[Your muscles are too tired to become nimble again so soon.]], function() TRACK.checkWithIllusion(function() NU.setFlag("nimbleness_cd", true, 10); end) end);
TRIG.register("self_nimbleness_cd_over", "exact", [[Your muscles have recovered enough for you to be nimble once more.]], function() TRACK.checkWithIllusion(function() NU.clearFlag("nimbleness_cd"); end) end);

TRIG.register("self_already_density", "exact", [[You are already quite the dense one!]], function() TRACK.addDef(TRACK.getSelf(), "density") end);
TRIG.register("self_already_insomnia", "exact", [[You are already an insomniac.]], function() TRACK.addDef(TRACK.getSelf(), "insomnia") end);
TRIG.register("self_already_deathsight", "exact", [[Your mind is already touched by the Underking.]], function() TRACK.addDef(TRACK.getSelf(), "deathsight") end);
TRIG.register("self_already_clarity", "exact", [[You have already filled your mind with clarity.]], function() TRACK.addDef(TRACK.getSelf(), "clarity") end);

TRIG.register("self_already_speed", "exact", [[Your sense of time is already heightened.]], function() TRACK.addDef(TRACK.getSelf(), "speed") end);
TRIG.register("self_already_insulated", "exact", [[You already have the insulation defense!]], function() TRACK.addDef(TRACK.getSelf(), "insulation") end);

--[[
You touch the tree of life tattoo.
Your tree of life tattoo glows faintly for a moment then fades, leaving you unchanged.]]
TRIG.register("self_rebounding_hit", "exact", [[The attack rebounds off your rebounding aura!]],
    function() TRACK.addDef(TRACK.getSelf(), "rebounding") end);
TRIG.register("self_already_rebounding", "exact", [[You are already benefitting from an aura of weapons rebounding.]],
    function() TRACK.addDef(TRACK.getSelf(), "rebounding") end);

--
--
