--^(\w+) uses Shapeshifting Shedding\.$ -- slickness lockbreak.
-- 

local handleUnknownBays = function()
    NU.setFlag("baying_unknown", true, 60);
    NU.SEND("concentrate");
    if (FLAGS.shapeshifter_bays) then
        TRACK.saffs(FLAGS.shapeshifter_bays);
    end
end

TRIG.register("shapeshifter_baying", "regex", [[^You are jolted by (\w+)\'s snarls\.$]], handleUnknownBays, "SHIFTER_ATTACK_TRACKING", "Shapeshifter hit us with some hidden bays.");