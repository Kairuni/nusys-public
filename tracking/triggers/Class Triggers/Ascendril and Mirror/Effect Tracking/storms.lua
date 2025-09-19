local function tickDirefrost(target_name)
    if (FLAGS[target_name .. "_direfrost"]) then
        FLAGS[target_name .. "_direfrost"] = FLAGS[target_name .. "_direfrost"] + 1;
        if (FLAGS[target_name .. "_direfrost"] > 5) then
            TRACK.nameCure("target_name", "direfrost");
            NU.clearFlag(target_name .. "_direfrost");
        end
    end
end

TRIG.register("whirlwind_stopping_snowstorm", "exact", [[You cannot summon a snowstorm while an arcane whirlwind already rages here!]], function() if (not FLAGS.whirlwind) then NU.setFlag("whirlwind", true, 20);end end, "ASCENDRIL_OFFENSE_TRACKING");

TRIG.register("snowstorm_tick_1", "exact", [[The arcane snowstorm rages about you, chilling you to the bone.]], function() if (not FLAGS.snowstorm) then NU.setFlag("snowstorm", true, 20); end tickDirefrost(NU.target); end, "ASCENDRIL_OFFENSE_TRACKING");
TRIG.register("snowstorm_tick_2", "exact", [[Power and cold bite through your senses as the arcane snowstorm roars around you.]], function() if (not FLAGS.snowstorm) then NU.setFlag("snowstorm", true, 20); end tickDirefrost(NU.target); end, "ASCENDRIL_OFFENSE_TRACKING");

TRIG.register("snowstorm_end", "exact", [[The arcane snowstorm subsides.]], function() NU.clearFlag("snowstorm"); end, "ASCENDRIL_OFFENSE_TRACKING");
TRIG.register("snowstorm_end2", "exact", [[Dwindling into gusting drifts of snow that fade into nothing, an arcane snowstorm subsides.]], function() NU.clearFlag("snowstorm"); end, "ASCENDRIL_OFFENSE_TRACKING");