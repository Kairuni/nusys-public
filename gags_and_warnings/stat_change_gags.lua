TRIG.register("hpmp_change_prompt_gag", "prompt", nil, function() NU.gag("hpmp_change"); TRIG.disable(TRIGS.hpmp_change_prompt_gag); end)
TRIG.register("hpmp_change_disable_promptgag", "regex", ".", function() TRIG.disable(TRIGS.hpmp_change_prompt_gag); end)
TRIG.register("mana_loss_gag", "regex", [[^Mana (Gain|Lost)\: (\d+)]], function()
    local asNumber = tonumber(matches[3]);
    local last = FLAGS.last_mp_change;
    NU.setFlag("last_mp_change", {change = (matches[2] == "Gain" and 1 or -1) * asNumber + ((last and not last.displayed) and last.change or 0), displayed = false});
    if (PFLAGS.untracked) then NU.setFlag("last_untracked_mana_change", asNumber); end
    if (asNumber <= 150) then
        NU.gag("hpmp_change");
        TRIG.enable(TRIGS.hpmp_change_prompt_gag);
    end
end);
-- TODO: For sensitivity detection we need to be able to check if health loss was increased by >= 1.4x - to do this we need to track ab damage.
-- So, here, we need to build some record of attacks over the course of a fight, and record the most recent damage value.
-- Simply enough, if said damage value is greater than previous x 1.4, we have sensitivity.
TRIG.register("health_loss_gag", "regex", [[^Health (Gain|Lost)\: (\d+)]], function()
    local asNumber = tonumber(matches[3]);
    if (matches[2] == "Lost") then
        NU.setPFlag("expect_damage", true);
        NU.setPFlag("hp_loss", asNumber);
    end
    local last = FLAGS.last_hp_change;
    NU.setFlag("last_hp_change", {change = (matches[2] == "Gain" and 1 or -1) * asNumber + ((last and not last.displayed) and last.change or 0), displayed = false});
    raiseGlobalEvent("health_change", TRACK.getSelf().name, (matches[2] == "Gain" and 1 or -1) * asNumber);
    if (PFLAGS.untracked) then NU.setFlag("last_untracked_health_change", asNumber); end
    if (asNumber <= 150) then
        NU.gag("hpmp_change");
        TRIG.enable(TRIGS.hpmp_change_prompt_gag);
    end
end);
