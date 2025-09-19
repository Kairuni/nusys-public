--
TRIG.register("siderealist_alteration_hit", "regex",
    [[^Dread manifests on (\w+)\'s face as (\w+) takes hold\.$]],
    function() TRACK.taff(matches[2], CONVERT.discernmentConversion[matches[3]]); end, "SIDEREALIST_OFFENSE",
    "Alteration swap.");

TRIG.register("siderealist_stillness_moonlet", "regex",
    [[^In (?:.+|his) terror, (\w+) cries out for the moon \- and then quails as (?:.+|he) beholds its emergent face\.$]],
    function() TRACK.taffs(matches[2], "stupidity", "confusion", "dementia", "hallucinations", "moonlet") end,
    "SIDEREALIST_OFFENSE", "Full stillnness.");


TRIG.register("siderealist_failed_alteration", "regex", [[^(\w+) does not have (\w+)\.$]],
    function() TRACK.nameCure(matches[2], CONVERT.discernmentConversion[matches[3]]); end, "SIDEREALIST_OFFENSE",
    "Failed alteration attempt");

TRIG.register("siderealist_alteration_offcd", "exact", [[You feel yourself swell with the power to alter others.]],
    function() NU.removeCD(TRACK.getSelf().name .. "_Astranomia_Alteration") end, "SIDEREALIST_OFFENSE",
    "Failed alteration attempt");
-- You feel the capacity to forge stars from raw mana.



-- TODO: 20% heal on nebula.
TRIG.register("siderealist_nebula_target", "regex",
    [[^Glimmering pinpricks of light swirl around (\w+) as .+ wounds close up\.$]], function() end, "SIDEREALIST_OFFENSE",
    "Target Nebula Proc");
TRIG.register("siderealist_nebula_self", "exact",
    [[Glimmering pinpricks of light swirl around you, restoring your health.]],
    function() end, "SIDEREALIST_OFFENSE", "Self Nebula Proc");

--
-- A tiny orange-hued star manifests overhead, captured in your orbit.
TRIG.register("siderealist_gleam_stacks", "regex",
    [[^A tiny (\w+)\-hued star manifests overhead\, captured in your orbit\.$]],
    function() NU.offCD(TRACK.getSelf().name .. "_inflict_" .. matches[2]); end, "SIDEREALIST_OFFENSE", "Gleam star cd.");
-- TRIG.register("siderealist_gleam_stacks", "regex", [[^Your gleam defence now has (\d+) stacks\.$]],
--     function() TRACK.getSelf().stacks.gleam = tonumber(matches[2]); end, "SIDEREALIST_OFFENSE", "Gleam stacks");

TRIG.register("siderealist_asterism_proc", "regex",
    [[^The tiny stars around (\w+) thrum, connecting with radiant lines\.$]],
    function()
        -- Asterism fires every 8 seconds
        -- So we can make some assumptions:
        local tt = TRACK.get(matches[2]);
        local asterismFlag = FLAGS[tt.name .. "_asterism"];
        local candidates = {};
        if (asterismFlag) then
            for aff, _ in pairs(asterismFlag) do
                if (not tt.affs[aff]) then
                    table.insert(candidates, aff);
                end
            end
        end

        -- If only one is possible, it must be it.
        if (#candidates == 1) then
            TRACK.affs(tt, candidates);
        end

        -- Otherwise, set a time.
        NU.setFlag(tt.name .. "_next_asterism", true, 9, function()
            -- This one could potentially lead to mistracking, or could potentially clinch something.
            -- We'll need to figure out which.
            -- Basically, if we ever get here, they have every single aff.
            if (tt.affs.asterism and asterismFlag) then
                for aff, _ in pairs(asterismFlag) do
                    TRACK.aff(tt, aff);
                end
            end
        end);
    end, "SIDEREALIST_OFFENSE", "Asterism proccing");

TRIG.register("siderealist_erode", "regex", [[([a-z_ -]+) defence corrodes to twinkling dust\.$]],
    function()
        if (not PFLAGS.asterism_erode_target) then return; end;
        TRACK.stripDef(PFLAGS.asterism_erode_target, matches[2]);
        if (matches[2] ~= "shielded") then
            TRACK.stripDef(PFLAGS.asterism_erode_target, "shielded");
        end
    end, "SIDEREALIST_OFFENSE", "Erode success.");

--     local cdStr = skill .. "_" .. ability;
-- (attacker.name .. "_" .. cdStr)
TRIG.register("siderealist_crystalforest_muted", "exact", [[There is no crystalforest for you to shatter.]],
    function() NU.cooldown(TRACK.getSelf().name .. "_Crystalism_Tones Crystalforest", 20); end, "SIDEREALIST_OFFENSE", "");

TRIG.register("siderealist_crystalforest_active", "exact",
    [[A jagged forest of razor-sharp, tiny crystals rises from the ground.]],
    function() NU.removeCD(TRACK.getSelf().name .. "_Crystalism_Tones Crystalforest"); end, "SIDEREALIST_OFFENSE", "");


VIBE_TIMING = {};
local function TRACK_VIBE_TIME(vibe, data) -- TODO: Remove this after we get data.
    VIBE_TIMING[vibe] = VIBE_TIMING[vibe] or {};
    table.insert(VIBE_TIMING[vibe], { time = NU.time(), data = data });
end

-- Creeps Vibration
TRIG.register("siderealist_creeps_vibe", "regex",
    [[^(\w+) is suffering the effects of your creeps \((\w+)\) vibration\.$]],
    function()
        TRACK.taff(matches[2], CONVERT.discernmentConversion[matches[3]]); TRACK_VIBE_TIME("creeps",
            CONVERT.discernmentConversion[matches[3]]);
    end, "SIDEREALIST_OFFENSE", "");
TRIG.register("siderealist_cavitation_vibe", "regex",
    [[^(\w+) is suffering the effects of your cavitation \((left leg|right leg|left arm|right arm|head|torso)\) vibration\.$]],
    function()
        TRACK.damageLimb(TRACK.get(matches[2]), matches[3], 3.4); TRACK_VIBE_TIME("cavitation");
    end, "SIDEREALIST_OFFENSE", "");

local vibrationToEffect = {
    adduction = {},
    disorientation = { affs = { "dizziness" } },
    plague_broken_arms = { affs = { "right_arm_crippled", "left_arm_crippled" } },
    plague_broken_legs = { affs = { "left_leg_crippled", "right_leg_crippled", "FALLEN" } },
    -- plague_vomiting = { affs = { "vomiting" } },
    dissipate = { mp = 0.055 },
    energize = {},
    creeps_claustrophobia = { affs = { "claustrophobia" } },
    creeps_agoraphobia = { affs = { "agoraphobia" } },
    creeps_shyness = { affs = { "shyness" } },
    oscillate = {},
    lullaby = { defStrip = { "insomnia" } },
    palpitation = { hp = 0.0925 },
    dissension = {},
    gravity = { defStrip = { "levitation" } },
    tremors = { affs = { "FALLEN" } },
    stridulation = { affs = { "disrupted" } },
}

-- Generic Vibration                      --^(.*) is suffering the effects of your (\w+) vibration\.$
TRIG.register("siderealist_generic_vibe", "regex", [[^(.*) is suffering the effects of your (\w+) vibration\.$]],
    function()
        local tt = TRACK.get(matches[2]);
        local effect = vibrationToEffect[matches[3]];
        echo("Vibe hit: " .. matches[3]);
        TRACK_VIBE_TIME(matches[3]);
        if (effect.defStrip) then
            for _, def in ipairs(effect.defStrip) do
                TRACK.stripDef(tt, def)
            end
        end
        if (effect.hp) then
            TRACK.abilityDamage(tt, 0, effect.hp, 1.0, 1.0, "magic", "Crystalism", matches[3]);
        end
        if (effect.mp) then
            TRACK.damage(tt, 0.0, effect.mp * tt.vitals.maxmp);
        end
        if (effect.affs) then
            for _, aff in ipairs(effect.affs) do
                TRACK.aff(tt, aff);
                -- local VA = PFLAGS.DISCERNMENT_VIBEALERT_HACK;
                -- if (VA and VA.name == matches[2]) then
                --     if (VA.aff == aff) then
                --         TRACK.cure(tt, aff);
                --     end
                -- end
            end
        end
    end,
    "SIDEREALIST_OFFENSE", "Some vibration hit.");

-- Gherond begins to vibrate in tune with a disruptive harmony.
TRIG.register("siderealist_dissonance_hit", "regex", [[^(\w+) begins to vibrate in tune with a disruptive harmony\.$]],
    function()
        TRACK.taff(matches[2], "dissonance");

        -- local VA = PFLAGS.DISCERNMENT_VIBEALERT_HACK;
        local tt = TRACK.get(matches[2]);
        TRACK_VIBE_TIME("dissonance");
        -- if (VA and VA.name == matches[2]) then
        --     if (VA.aff == "dissonance") then
        --         TRACK.cure(tt, "dissonance");
        --     end
        -- end
    end, "SIDEREALIST_OFFENSE", "Dissension vibe.");


--TRIG.register("siderealist_", "", [[]], function() end, "SIDEREALIST_OFFENSE", "");
--                                                   ^(\w+) is suffering the effects of your plague \((.+)\) vibration\.$
TRIG.register("siderealist_plague_vibe_hit", "regex",
    [[^(\w+) is suffering the effects of your plague \((.+)\) vibration\.$]],
    function()
        local VA = PFLAGS.DISCERNMENT_VIBEALERT_HACK;
        local effect = "plague_" .. matches[3]:gsub(" ", "_");
        local discern = CONVERT.discernmentConversion[matches[3]];
        local tt = TRACK.get(matches[2]);
        if (vibrationToEffect[effect]) then
            TRACK.affs(tt, vibrationToEffect[effect].affs);
            TRACK_VIBE_TIME("plague", vibrationToEffect[effect].affs);

            -- if (VA and VA.name == matches[2]) then
            --     for _, aff in ipairs(vibrationToEffect[effect].affs) do
            --         if (VA.aff == aff) then
            --             TRACK.cure(tt, aff);
            --             break;
            --         end
            --     end
            -- end
        elseif (discern) then
            TRACK.aff(tt, discern);
            TRACK_VIBE_TIME("plague", discern);
            -- if (VA and VA.name == matches[2]) then
            --     if (VA.aff == discern) then
            --         TRACK.cure(tt, discern);
            --     end
            -- end
        else
            echo("Untracked plague: " .. effect);
            TRACK_VIBE_TIME("plague", effect);
        end
    end, "SIDEREALIST_OFFENSE", "");
TRIG.register("siderealist_plague_tone_hit", "regex", [[^(\w+) has received the plague of (.+)\.$]],
    function()
        local tt = TRACK.get(matches[2]); -- how tf is this a table
        local discern = CONVERT.discernmentConversion[matches[3]];

        TRACK.aff(tt, discern);

        local VA = PFLAGS.DISCERNMENT_VIBEALERT_HACK;
        if (VA and VA.name == tt.name) then
            if (VA.aff == discern) then
                TRACK.cure(tt, discern);
            end
        end
    end, "SIDEREALIST_OFFENSE", "");

local function echoesHit()
    local name = matches[2]:lower();
    TRACK.taff(matches[2], "echoes");

    local glimmercrest_flag = name .. "_glimmercrest"
    NU.setFlag(glimmercrest_flag, NU.time() + 12, 12,
        function()
            FLAGS[glimmercrest_flag] = NU.time() + 12;
            return true, true;
        end);
end

local function phosphenesHit()
    local name = matches[2]:lower();
    TRACK.taff(matches[2], "phosphenes");

    local sprite_flag = name .. "_sprite"
    NU.setFlag(sprite_flag, NU.time() + 12, 12,
        function()
            FLAGS[sprite_flag] = NU.time() + 12;
            return true, true;
        end);
end

TRIG.register("siderealist_echoes_hit", "regex",
    [[^A medusan glimmercrest swirls around (\w+)\, its nebulaic centre emanating whispers\.$]],
    echoesHit, "SIDEREALIST_OFFENSE", "");

TRIG.register("siderealist_phosphenes_hit", "regex",
    -- A cosmic sprite races around (\w+) in a corkscrew streak of swirling sidereal light\.
    [[^A cosmic sprite races around (\w+) in a corkscrew streak of swirling sidereal light\.$]],
    phosphenesHit, "SIDEREALIST_OFFENSE", "");
-- TRIG.register("siderealist_self_enigma_over", "exact", [[Blissful silence engulfs you as you sigh in relief.]],
--     function() NU.clearFlag(TRACK.getSelf().name .. "_enigma"); end, "SIDEREALIST_OFFENSE", "");
-- TRIG.register("siderealist_target_enigma_over", "regex", [[^(\w+) sighs in relief\.$]],
--     function() NU.clearFlag(matches[2]:lower() .. "_enigma"); end, "SIDEREALIST_OFFENSE", "");
--
TRIG.register("siderealist_eventide_used", "exact",
    [[You invoke the soothing embrace of a starswept night and swathe yourself in its dusky glory, driving out ailments.]],
    function() NU.cooldown(TRACK.getSelf().name .. "_Astranomia_Eventide", 18) end);
TRIG.register("siderealist_eventide_cooldown", "exact", [[You cannot invoke the night's embrace again so soon.]],
    function() NU.cooldown(TRACK.getSelf().name .. "_Astranomia_Eventide", 18) end);
TRIG.register("siderealist_eventide_cooldown_over", "exact", [[You may invoke night's soothing energy once more.]],
    function() NU.removeCD(TRACK.getSelf().name .. "_Astranomia_Eventide"); end);

TRIG.register("siderealist_equinox_cooldown", "exact", [[You cannot conjure another rejuvenating equinox so soon!]],
    function() NU.cooldown(TRACK.getSelf().name .. "_Astranomia_Equinox", 20) end);
TRIG.register("siderealist_equinox_cooldown_over", "exact",
    [[Equinoctial balance returns to you, allowing you to conjure its aid once more.]],
    function() NU.removeCD(TRACK.getSelf().name .. "_Astranomia_Equinox"); end);

TRIG.register("siderealist_replicate_absorb_target", "regex",
    [[^You sweep your illuminated gaze along the magical energies around (\w+)\, intent upon unravelling (.+) technique\.$]],
    function()
        NU.setPFlag("replicate_absorb_target", matches[2]);
    end)
-- You forge a replica of 'dsk eaku xentio curare' from cosmic energy.

TRIG.register("siderealist_replicate_absorb_failure", "regex",
    [[^You sweep your illuminated gaze along (.+)\, but detect no unusual magical energies\.$]],
    function()
        --
    end)

-- A shard of cosmic gleam flies forward and strikes Gherond.
-- Add this for some more damage



TRIG.register("siderealist_stillness_success", "regex",
    -- Buckling beneath the enervating lash, Nawan issues a bloodcurdling scream.
    [[^Buckling beneath the enervating lash\, (\w+) issues a bloodcurdling scream\.$]],
    function()
        local tt = TRACK.get(matches[2]);
        local affs = AB.linearStack(tt, { "stupidity", "confusion", "dementia", "hallucinations" }, 2);
        TRACK.affs(tt, affs);
        TRACK.abilityDamage(tt, 0, 0.2, 1.0, 1.0, "asphyxiation", "Astranomia", "Stillness");
    end);
TRIG.register("siderealist_stillness_success_on_me", "exact",
    [[You scream til your final breath in the face of enervating cosmic sorcery, your lungs set aflame.]],
    function()
        TRACK.aff(TRACK.getSelf(), "echoes");
    end);


TRIG.register("siderealist_stillness_failed_on_target", "regex",
    [[^(\w+) resists? the stellar scourge\, (.+) guard held steady against the cosmic sorcery\.$]],
    function()
        TRACK.nameCure(matches[2], "echoes");
    end);

--
-- Black and white cosmic energy rises up you and meets in the middle.
-- The haunting echoes leave you.
--

TRIG.register("siderealist_centrum_active", "exact",
    [[You shift the focus of your cosmic energy collection onto a free hand.]], function()
        NU.cooldown(TRACK.getSelf().name .. "_Astranomia_Centrum", 30);
        TRACK.getSelf().defs.centrum = true;
    end, "SIDEREALIST_OFFENSE", "Centrum active");

TRIG.register("siderealist_centrum_already_active", "exact",
    [[You cannot imbue your arms with cosmic power just yet.]], function()
        NU.cooldown(TRACK.getSelf().name .. "_Astranomia_Centrum", 30);
    end, "SIDEREALIST_OFFENSE", "Centrum already active");

TRIG.register("siderealist_centrum_over", "exact",
    [[Your arm now fatigued, you return to using both hands.]], function()
        NU.cooldown(TRACK.getSelf().name .. "_Astranomia_Centrum", 20);
        TRACK.stripDef(TRACK.getSelf(), "centrum");
    end, "SIDEREALIST_OFFENSE", "Centrum already active");

TRIG.register("siderealist_centrum_over", "exact",
    [[You can draw cosmic energy to one hand once more.]], function()
        NU.offCD(TRACK.getSelf().name .. "_Astranomia_Centrum");
    end, "SIDEREALIST_OFFENSE", "Centrum CD over");

TRIG.register("siderealist_retrograde_start", "exact",
    [[As the retrogradation vibration embeds itself, time itself appears to slow.]], function()
        NU.setFlag("recent_retrograde_proc", true, 4);
    end, "SIDEREALIST_EFFECTS", "New retrograde.")

TRIG.register("siderealist_retrograde", "exact", [[A slow wave pulses through you, dulling your reactions.]], function()
    NU.setFlag("recent_retrograde_proc", true, 4);
end, "SIDEREALIST_EFFECTS", "Recent retrograde.")

TRIG.register("siderealist_retrograde_over", "exact", [[The air grows calmer as the retrogradation vibration stills.]],
    function() NU.clearFlag("recent_retrograde_proc"); end, "SIDEREALIST_EFFECTS", "Retrograde over.")

ALIAS.register("enable_replicate", "^doRep$",
    function()
        NU.setFlag("replicate_mode", not FLAGS.replicate_mode); NU.ECHO("Replicate Mode: " .. (FLAGS.replicate_mode and
            "<green>ON" or "<red>OFF"));
    end);

ALIAS.register("enable_parallax", "^doParallax$",
    function()
        NU.setFlag("parallax_mode", not FLAGS.parallax_mode); NU.ECHO("Parallax Mode: " .. (FLAGS.parallax_mode and
            "<green>ON" or "<red>OFF"));
    end);

local function onIrradiatedLimb()
    TRACK.damageLimbByName(matches[2], matches[3], 7);
    TRACK.nameCure(matches[2], "irradiated_limb");
end
TRIG.register("irradiation_proc", "regex",
    [[^The arcane force around (\w+)'s (left arm|right arm|left leg|right leg|head|torso) flares to a harsh glare, then expires\.$]],
    onIrradiatedLimb, "ASCENDRIL_OFFENSE_TRACKING");

-- onUseEffects = function(st, tt, data)  end,

-- So 6322, highest 410 against 0.28 poison, lowest 290 against 0.49 cold.

local function chromaflareColor(color, dmgType)
    return function()
        local tt = TRACK.get(matches[2]);
        NU.cooldown(st.name .. "_inflict_" .. color, 21);
        TRACK.abilityDamage(tt, 0, 0.09, 1.0, 1.0, dmgType, "Astranomia", "Chromaflare (" .. color .. ")");
    end
end

TRIG.register("chromaflare_yellow", "regex", [[^The yellow\-hued miniature star's collapse torments (\w+) with electrical mayhem\.$]], chromaflareColor("yellow", "electric"), "SIDEREALIST_OFFENSE", "Chromaflare star cooldown.")
TRIG.register("chromaflare_orange", "regex", [[^The orange\-hued miniature star's collapse steals the air from (\w+)'s lungs\.$]], chromaflareColor("orange", "asphyxiation"), "SIDEREALIST_OFFENSE", "Chromaflare star cooldown.")
TRIG.register("chromaflare_blue", "regex", [[^The blue\-hued miniature star's collapse wracks (\w+)'s flesh with hoarfrost\.$]], chromaflareColor("blue", "cold"), "SIDEREALIST_OFFENSE", "Chromaflare star cooldown.")
TRIG.register("chromaflare_violet", "regex", [[^The violet\-hued miniature star's collapse causes (\w+) to wince\.$]], chromaflareColor("violet", "psychic"), "SIDEREALIST_OFFENSE", "Chromaflare star cooldown.")
TRIG.register("chromaflare_indigo", "regex", [[^The indigo\-hued miniature star's collapse unleashes raw arcana upon (\w+)\.$]], chromaflareColor("indigo", "magic"), "SIDEREALIST_OFFENSE", "Chromaflare star cooldown.")
TRIG.register("chromaflare_green", "regex", [[^The green\-hued miniature star's collapse floods (\w+)'s lungs with lethal gases\.$]], chromaflareColor("green", "poison"), "SIDEREALIST_OFFENSE", "Chromaflare star cooldown.")
TRIG.register("chromaflare_red", "regex", [[^The red\-hued miniature star's collapse captures (\w+) within a fiery cataclysm\.$]], chromaflareColor("red", "fire"), "SIDEREALIST_OFFENSE", "Chromaflare star cooldown.")
