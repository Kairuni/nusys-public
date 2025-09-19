TRIG.register("enrapture_stopped", "exact", [[Your woven matrix of elements shatters along with your concentration.]],
    function()
        NU.BIGMSG("ENRAPTURE BROKE"); NU.clearFlag(TRACK.getSelf().name .. "_channeling");
    end, "ASCENDRIL_OFFENSE_TRACKING");
