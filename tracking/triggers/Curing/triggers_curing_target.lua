-- Catch target normal balance CURES.
TRIG.register("targ_focus", "regex", [[^A look of extreme focus crosses the face of (\w+)\.$]], function() NU.DECHO("On target focus.\n", 1); TRACK.cureAction(matches[2], "focus"); end);
-- Gherond 
-- New line for sipping.
TRIG.register("targ_sip_with_reveal", "regex", [[^(?:You sense )?(\w+) drinks? an elixir of (.+) from]], function() TRACK.cureAction(matches[2], "targ_sip_revealed", matches[3], nil, nil); end);
TRIG.register("targ_sip_empty", "regex", [[^(?:You sense )?(\w+) empties out an elixir of (.+) into]], function() TRACK.cureAction(matches[2], "targ_sip_revealed", matches[3], nil, nil); end);

-- Waking up
TRIG.register("targ_wake1", "regex", [[^(\w+) wakes up with a gasp of pain\.$]], function() TRACK.nameCure(matches[2], "asleep"); end);
TRIG.register("targ_wake2", "regex", [[^(\w+) opens \w+ eyes and yawns mightily\.$]], function() TRACK.nameCure(matches[2], "asleep"); end);
TRIG.register("targ_wake3", "regex", [[^(\w+) awakens with a start\.$]], function() TRACK.nameCure(matches[2], "asleep"); end);

TRIG.register("targ_fangbarrier_up", "regex", [[^A thick, hardened shell of paste has formed around (\w+)\.$]], function() TRACK.addDef(TRACK.get(matches[2]), "fangbarrier"); end, "AKKARI_OFFENSE_TRACKING", "");

-- Renew
--TRIG.register("targ_recon", "regex", [[^With a sinister grin, (\w+)\'s body seems to repair itself before your very eyes\.$]], function() NU.DECHO("On target renew.\n", 1); TRACK.cureAction(matches[2], "renew"); end);
--TRIG.register("targ_erase", "regex", [[^(\w+)\'s form seems to shimmer before she stands taller\, looking healthier\.$]], function() NU.DECHO("On target renew.\n", 1); TRACK.cureAction(matches[2], "renew"); end);
--TRIG.register("targ_renew", "regex", [[^(\w+)\'s smiles faintly as a healing glow seems to push afflictions from his body\.$]], function() NU.DECHO("On target renew.\n", 1); TRACK.cureAction(matches[2], "renew"); end);

-- Standing
TRIG.register("targ_stand", "regex", [[^(\w+) stands up and stretches \w+ arms out wide\.$]], function()
    local ttable = TRACK.get(matches[2]);
    if (ttable.affs.backstrain) then
        TRACK.damageLimb(ttable, "torso", 10, not ttable.affs.stiffness);
    end

    TRACK.cure(ttable, "FALLEN");
end);
-- Other stands that will be covered by combat messages:
TRIG.register("targ_TEMP_KIPUP", "regex", [[^(\w+) uses Tekura Kipup \(\w+\)\.$]], function()
    local ttable = TRACK.get(matches[2]);
    if (ttable.affs.backstrain) then
        TRACK.damageLimb(ttable, "torso", 10, not ttable.affs.stiffness);
    end

    TRACK.cure(ttable, "FALLEN");
end);
TRIG.register("targ_TEMP_RISEKICK", "regex", [[^(\w+) uses Zeal Risekick on \w+\.$]], function()
    local ttable = TRACK.get(matches[2]);
    if (ttable.affs.backstrain) then
        TRACK.damageLimb(ttable, "torso", 10, not ttable.affs.stiffness);
    end

    TRACK.cure(ttable, "FALLEN");
end);

-- Mass tracking
TRIG.register("t_mass_loss", "regex", [[^A great weight seems to have been lifted from (\w+)\.$]], function() TRACK.taff(matches[2], "no_density"); end);

-- Other
TRIG.register("targ_concentrate", "regex", [[^(\w+)\'s eyes lose their focus suddenly\.$]], function() TRACK.nameCure(matches[2], "disrupted"); end);

-- Catch discernment
-- You discern that Illikaal has cured the effects of a broken left arm.
-- 14:28:57.812 Eaku touches a tree of life tattoo.
-- 14:28:57.813 You discern that Eaku has cured the effects of crippled right arm.
TRIG.register("discernment_1", "regex", [[^You discern that (\w+) has cured the effects of ([A-Za-z\-\s]+)\.$]], function() TRACK.nameCure(matches[2], CONVERT.discernmentConversion[matches[3]]); end);
--^You discern that (\w+) has resisted the ([A-Za-z\-\s]+) affliction\.$
TRIG.register("discernment_2", "regex", [[^You discern that (\w+) has resisted the ([A-Za-z\-\s]+) affliction\.$]],
    function()
        TRACK.nameCure(matches[2], CONVERT.discernmentConversion[matches[3]]);
        NU.setPFlag("DISCERNMENT_VIBEALERT_HACK", { name = matches[2], aff = CONVERT.discernmentConversion[matches[3]] })
    end);

-- Kaido Immunity trigger
TRIG.register("targ_kai_immunity", "regex", [[^(\w+)\'s face flushes as \w+ body purges the (\w+) venom\.$]], function() TRACK.nameCure(matches[2], CONVERT.empowermentToAff [matches[3]]); end);

-- Countercurrent
TRIG.register("any_countercurrent", "regex", [[^The countercurrent coating (\w+)\'s skin wicks away (\w+) before it can take\.$]], function() TRACK.nameCure(matches[2], CONVERT.empowermentToAff [matches[3]]); end);

-- Blackout
TRIG.register("targ_blackout_end", "regex", [[^(\w+) blinks rapidly, rubbing \w+ eyes\.$]], function() TRACK.nameCure(matches[2], "blackout"); end);

-- Writhes
TRIG.register("cure_webbed", "regex", [[^(\w+) ha(?:s|ve) writhed free of .+ bindings\.$]], function() TRACK.nameCure(matches[2], "writhe_web"); end);
TRIG.register("cure_tfix", "regex", [[^(\w+) ha(?:s|ve) writhed free of \w+ state of transfixion\.$]], function() TRACK.nameCure(matches[2], "writhe_transfix"); end);
TRIG.register("cure_ropes", "regex", [[^(\w+) ha(?:s|ve) writhed free of \w+ entanglement by ropes\.$]], function() TRACK.nameCure(matches[2], "writhe_ropes"); end);
TRIG.register("cure_bind", "regex", [[^(\w+) ha(?:s|ve) writhed free of \w+ tied ropes\.$]], function() TRACK.nameCure(matches[2], "writhe_bind"); end);
TRIG.register("cure_impale", "regex", [[^(\w+) ha(?:s|ve) writhed free of \w+ impalement\.$]], function() TRACK.nameCure(matches[2], "writhe_impaled"); end);
TRIG.register("cure_grapple", "regex", [[^(\w+) ha(?:s|ve) freed .+ from the grappling\.$]], function() TRACK.nameCure(matches[2], "writhe_grappled"); end);
TRIG.register("cure_jawlock", "regex", [[^(\w+) ha(?:s|ve) writhed free of \w+ (\w+)-jawlock\.$]], function() TRACK.nameCure(matches[2], "writhe_"..matches[3] .. "lock"); end);
TRIG.register("cure_flame", "regex", [[^(\w+)\'s flame tattoo flares suddenly, melting away the (\w+) around \w+\.$]], function() TRACK.nameCure(matches[2], "writhe_" .. matches[3]); end);
TRIG.register("cure_impale2", "regex", [[^With a look of agony on \w+ face, (\w+) manages to writhe \w+self free\.$]], function() TRACK.nameCure(matches[2], "writhe_impaled"); end);

-- Class Specific
-- Luminary/Earthcaller:
-- ^(\w+) uses Illumination Warmth\.$ -- probably build this into the combat messages table, cures one level of freezing.

-- Indorani/Oneiromancer
TRIG.register("leeched_aura_cured", "regex", [[^(\w+) appears to regain a little colour\.$]], function() TRACK.nameCure(matches[2], "leeched_aura"); end);
TRIG.register("leeched_aura_release", "regex", [[^You release the stolen life aura of (\w+) upon the wind\.$]], function() TRACK.nameCure(matches[2], "leeched_aura"); end);

-- Scio
TRIG.register("gloom_cured", "regex", [[^The despairing gloom has lifted from (\w+)\.$]], function() TRACK.nameCure(matches[2], "gloom"); end);

-- Remove ablaze, not sure what class this is
TRIG.register("flame_shield_ablaze_cure", "regex", [[^(\w+)\'s shield of flame repels the fiery attack\.$]], function() TRACK.nameCure(matches[2], "ablaze"); end);

-- Remove uncon
TRIG.register("cure_unconsciousness", "regex", [[^(\w+) regains consciousness with a start\.$]], function() TRACK.nameCure(matches[2], "UNCONSCIOUS"); end, "TARGET_CURES", "Unconsciousness ending.");
TRIG.register("boar_handler", "exact", [[Your boar tattoo tingles as it regenerates your health.]], function()
    NU.gag("boar");
    for _, tt in pairs(TRACKED) do
        if (not TRACK.isSelf(tt)) then
            TRACK.heal(tt, 0.05 * tt.vitals.maxhp, 0.0 * tt.vitals.maxmp * (tt.affs.burnout and 0.5 or 1));
        end
    end
end);
TRIG.register("moon_handler", "exact", [[Your moon tattoo tingles as it regenerates your mana.]], function()
    NU.gag("moon");
    for _, tt in pairs(TRACKED) do
        if (not TRACK.isSelf(tt)) then
            TRACK.heal(tt, 0.0 * tt.vitals.maxhp, 0.02 * tt.vitals.maxmp * (tt.affs.burnout and 0.5 or 1));
        end
    end
end);
