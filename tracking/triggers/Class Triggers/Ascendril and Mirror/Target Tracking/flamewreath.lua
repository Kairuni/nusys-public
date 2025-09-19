local function onFlamewreath()
    if (PFLAGS.last_firelash) then
        TRACK.damageLimbByName(matches[2], matches[3], 8);
    else
        TRACK.damageLimbByName(matches[2], matches[3], 7);
    end
    TRACK.nameCure(matches[2], "flamewreathed_limb");
end
TRIG.register("flamewreath_proc", "regex", [[^The flames around (\w+)\'s (left arm|right arm|left leg|right leg|head|torso) ignite in intensity and then expire\, their energy spent\.$]], onFlamewreath, "ASCENDRIL_OFFENSE_TRACKING");