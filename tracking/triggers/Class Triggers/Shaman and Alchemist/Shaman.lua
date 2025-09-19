local shamanMentalsList = {};
for k,v in pairs(AFFS.mentals) do
    if (k ~= "mirroring" and k ~= "dread" and k ~= "delirium") then
       table.insert(shamanMentalsList, k);
    end
end

local boneList = {};
for _,v in ipairs(CURES.pill.antipsychotic) do
    if (NU.aff_db_reference[v] and NU.aff_db_reference[v].mental) then
       table.insert(boneList, v);
    end
end

-- TODO: Pull this into its own helper.
local lokiAffList = {
    "clumsiness",
    "recklessness",
    "asthma",
    "shyness",
    "allergies",
    "paresis",
    "left_arm_crippled",
    "right_arm_crippled",
    "left_leg_crippled",
    "right_leg_crippled",
    "no_deafness",
    "sensitivity",
    "disloyalty",
    "vomiting",
    "no_blindness",
    "haemophilia",
    "stuttering",
    "weariness",
    "dizziness",
    "anorexia",
    "slickness",
    "voyria",
    "no_insomnia",
    "deadening",
    "stupidity",
    "squelched",
    "dyscrasia",
    "peace",
}

local function hitByLoki()
    

    NU.setPFlag("expected_hiddens", {source = "loki", affList = lokiAffList, expectedCount = 1});
    --TRACK.addHidden(TRACK.getSelf(), "loki", lokiAffList);
end

TRIG.register("shaman_bone_fetish", nil, [['s bone fetish resounds with a chiming echo that shatters your shield and reels your mind.]], function()
    NU.setPFlag("expected_hiddens", {source = "bone_fetish", affList = boneList, expectedCount = 1});
end);

TRIG.register("staticburst_hidden", "exact", [[The air around you hums with residual static energy and another painful jolt wracks your body.]], function()
    NU.setPFlag("expected_hiddens", {source = "staticburst", affList = shamanMentalsList, expectedCount = 1});
end);
-- I have no idea what this line is, but it's apparently not staticburst_hidden.
-- TRIG.register("staticburst_alchemist_hidden", "exact", [[Relapse comes suddenly in the form of a startling jolt, your mind seizing under the renewed currents.]], function()
--     NU.setPFlag("expected_hiddens", {source = "staticburst", affList = shamanMentalsList, expectedCount = 1});
-- end);
-- Are there two?
TRIG.register("staticburst_alchemist_hidden_on_cast", "exact", [[Residual static adheres to the conductive serum sheening your skin, the resulting jolt setting your muscles to spasming.]], function()
    NU.setPFlag("expected_hiddens", {source = "staticburst", affList = shamanMentalsList, expectedCount = 1});
end);
TRIG.register("staticburst_alchemist_hidden_repeat", "exact", [[Relapse comes suddenly in the form of a startling jolt, your mind seizing under the renewed currents.]], function()
    NU.setPFlag("expected_hiddens", {source = "staticburst", affList = shamanMentalsList, expectedCount = 1});
end);


TRIG.register("warding_hidden", "exact", [[You feel a strange buzz light up your mind.]], function()
    NU.setPFlag("expected_hiddens", {source = "shaman_warding", affList = shamanMentalsList, expectedCount = 1});
end);

TRIG.register("cougar_hidden", "exact", [[A cougar spirit leaps forward, landing a heavy swipe upon the back of your head.]], function()
    NU.setPFlag("expected_hiddens", {source = "shaman_cougar", affList = {"impairment", "blurry_vision", "clumsiness"}, expectedCount = 1});
end);

TRIG.register("alchemist_toxic_hidden", "exact", [[Clouds of toxic vapour surround a toxic experiment as it lumbers towards you, taking a bite out of your skin.]], hitByLoki);
TRIG.register("shaman_spider_hidden", "exact", [[A spider spirit quickly scuttles forward to sink its fangs into you.]],
    hitByLoki);


TRIG.register("shell_active", "start", [[Your tree tattoo becomes hot to the touch as]], function()  NU.setFlag("shell_fetish", true, 5); end);
TRIG.register("shell_inactive", "start", [[The clattering of ]], function()  NU.clearFlag("shell_fetish"); end);
TRIG.register("shell_treetouch", "exact", [[You quickly pull your hand away from the scorching surface of your tree tattoo.]], function()  NU.setFlag("shell_fetish", true, 5); end);


TRIG.register("shaman_premonition_cure_fail", "exact", [[An uncertain feeling within your mind prevents the malady from lifting.]], function() TRACK.saffs("dread"); end, "SHAMAN_SYMPTOM_TRACKING", "Shows when we fail a cure due to premonition.");


TRIG.register("shaman_lifebloom_trigger", "exact", [[The pain of your wounds is suddenly washed away by life-force welling up from within you.]], function() NU.cooldown(TRACK.getSelf().name .. "_Primality_Lifebloom", 360); end, "SHAMAN_SYMPTOM_TRACKING", "Lifebloom CD trigger.");

-- You remove your previous fetishes from your quarterstaff and quickly string up a horn fetish, a bark fetish and a stone fetish.
TRIG.register("shaman_offense_fetish_string", "regex", [[^You quickly string an? (\w+) fetish, an? (\w+) fetish and an? (\w+) fetish onto your quarterstaff\.$]], function()
    NU.clearFlag("shaman_fetishes");
    NU.setFlag("shaman_fetishes", {[matches[2]] = true, [matches[3]] = true, [matches[4]] = true});
end, "Shaman Offense", "");
TRIG.register("shaman_offense_fetish_restring", "regex", [[^You remove your previous fetishes from your quarterstaff and quickly string up an? (\w+) fetish, an? (\w+) fetish and an? (\w+) fetish\.$]], function()
    NU.clearFlag("shaman_fetishes");
    NU.setFlag("shaman_fetishes", {[matches[2]] = true, [matches[3]] = true, [matches[4]] = true});
end, "Shaman Offense", "");
TRIG.register("shaman_offense_fetish_remove_all", "exact", [[You quickly remove each fetish strung from a Shamanic quarterstaff.]], function()
    NU.clearFlag("shaman_fetishes");
end, "Shaman Offense", "");
TRIG.register("shaman_pancake_still_cd", "exact", [[You cannot purify your body of ailments again just yet.]], function()
    NU.cooldown("Eliadon_Naturalism_Panacea", 5);
end, "Shaman Offense", "");
TRIG.register("shaman_offense_familiar_on_cd", "exact", [[You cannot morph your familiar again so soon.]], function()
    NU.cooldown("Eliadon_Shamanism_Morph", 300);
end, "Shaman Offense", "");
TRIG.register("shaman_offense_familiar_already_morphed", "exact", [[Your familiar has already assumed that form.]], function()
    NU.cooldown("Eliadon_Shamanism_Morph", 30);
end, "Shaman Offense", "");
TRIG.register("shaman_offense_familiar_kill_set", "regex", [[^You order .*(a wyvern|a bear).* to kill]], function()
    NU.setFlag(TRACK.getSelf().name .. "_familiar_morph", matches[2] .. " spirit");
end, "Shaman Offense", "");
TRIG.register("shaman_offense_familiar_not_in_room", "exact", [[You must be with your familiar to do that.]], function() NU.clearFlag("familiar_in_room"); end, "Shaman Offense", "");

TRIG.register("shaman_offense_staticburst_proc", "regex", [[^Your jolts of static energy have disrupted (.*)\'s mental state with (.*)\.$]], function()
    local staticburstFlag = matches[2]:lower() .. "_staticburst";
    if (FLAGS[staticburstFlag]) then
        FLAGS[staticburstFlag] = FLAGS[staticburstFlag] - 1;
        display(FLAGS[staticburstFlag]);
        if (FLAGS[staticburstFlag] <= 0) then
            NU.clearFlag(staticburstFlag);
        end
    end
    TRACK.taff(matches[2], matches[3]);
end, "Shaman Offense", "");

TRIG.register("shaman_offense_naturaltide_release", "exact", [[You throw your spiritual gates wide and pour forth your gathered energy.]], function()
    NU.clearFlag(TRACK.getSelf().name .. "_naturaltide"); end,
"Shaman Offense", "");

TRIG.register("shaman_offense_stormbolt_over", "regex", [[^The skies around (.*) clear as the thunderstorm dissipates\.$]], function()
    NU.clearFlag(matches[2]:lower() .. "_stormbolt");
end, "Shaman Offense", "");

TRIG.register("shaman_offense_slam_fallen", "regex", [[^The frenzied air reaches its peak of intensity and slams into (.*) with a ferocity that knocks .* to the ground\.$]], function()
    TRACK.taff(matches[2], "FALLEN");
end, "Shaman Offense", "");

local omenMap = {
    lightly = 0.15,
    heavily = 0.30,
    forcefully = 0.45,
    devastatingly = 0.6,
}

TRIG.register("shaman_offense_omen_landing", "regex", [[^Your omen (?:falls|settles|drops) (\w+) on(?:to)? (.*)\.$]], function()
        TRACK.abilityDamage(TRACK.get(matches[3]), 0, omenMap[matches[2]], 1.0, 1.0, "unblockable", "Shamanism", "Omen");
    NU.clearFlag(matches[2]:lower() .. "_omen_count");
end, "Shaman Offense", "");

TRIG.register("shaman_offense_vinelash_venom", "regex", [[^You discern that (.*) has been afflicted by the (.*) venom\.$]], function()
    local aff = CONVERT.empowermentToAff [matches[3]:lower()];
    TRACK.taff(matches[2], aff);
end, "Shaman Offense", "");

TRIG.register("shaman_offense_already_omened", "exact", [[An omen has already been cast upon them.]], function()
    if (FLAGS[NU.target .. "_omen_count"]) then return; end
    NU.setFlag(NU.target .. "_omen_count", 0, 12);
end, "Shaman Offense", "");

TRIG.register("shaman_offense_spider_bites", "regex", [[^A spider spirit quickly scuttles forward to sink its fangs into (\w+)\.$]], function()
    if (matches[2]:lower() == NU.target) then
        NU.setFlag(NU.target .. "_shaman_spider_bites",
            FLAGS[NU.target .. "_shaman_spider_bites"] and FLAGS[NU.target .. "_shaman_spider_bites"] + 1 or 1);
        if (FLAGS[NU.target .. "_shaman_spider_bites"] == 6) then
            NU.ECHO("<orange>WEB NEXT ATTACK");
            NU.setFlag("predicted_spider_web", NU.time() + 10, 10);
        else
            NU.ECHO("<red>" .. tostring(6 - FLAGS[NU.target .. "_shaman_spider_bites"]) .. "<green> until web!");
        end
    end
end, "Shaman Offense", "");
-- Deftly spinning a web of silk, a spider spirit traps Eliadon within it.
TRIG.register("shaman_offense_spider_web", "regex", [[^Deftly spinning a web of silk\, a spider spirit traps (\w+) within it\.$]], function()
    NU.setFlag(NU.target .. "_shaman_spider_bites", 0)
    TRACK.taff(matches[2], "writhe_web");
end, "Shaman Offense", "");


TRIG.register("shaman_offense_shell_inactive", "regex", [[^The clattering of your shell fetish diminishes as the glow fades from (.*)\'s tree tattoo\.$]], function()
    NU.clearFlag("shaman_shell_active");
end, "Shaman Offense", "");

TRIG.register("shaman_offense_shell_active", "regex", [[^(\w+)\'s tree tattoo glows red as your shell fetish clatters noisily\.$]], function()
    NU.setFlag("shaman_shell_active", true, 12);
end, "Shaman Offense", "");

TRIG.register("shaman_offense_clear_fetish_effects", "exact", [[Your fetishes cease their rattling as their attunement fades.]], function()
    NU.clearFlag("shaman_shell_active");
    NU.clearFlag("shaman_bone_active");
    NU.clearFlag("shaman_feather_active");

    -- TODO: clear other fetish effects.
end, "Shaman Offense", "");

TRIG.register("shaman_offense_bone_shield_break", "regex", [[^Your bone fetish resounds with a chiming echo that shatters (\w+)\'s shield\.$]], function()
    NU.clearFlag("shaman_bone_active");
end, "Shaman Offense", "");

TRIG.register("shaman_offense_bone_active", "exact", [[The bone fetish clatters against your quarterstaff.]], function()
    NU.setFlag("shaman_bone_active", true, 60);
end, "Shaman Offense", "");


TRIG.register("shaman_offense_feather_active", "regex", [[^Static crackles around your feather fetish, spreading out to envelop (\w+)\.$]], function()
    NU.setFlag("shaman_feather_active", true, 60);
end, "Shaman Offense", "");
TRIG.register("shaman_offense_feather_trigger", "regex", [[^The static around (\w+) sparks with light\, seemingly more alive\.$]], function()
    NU.clearFlag("shaman_feather_active");
    TRACK.taff(matches[2], "stormtouched");
end, "Shaman Offense", "");

-- probably not needed
-- A thorned stalk abruptly strikes out at Nawan, flaying his skin.
-- Nawan is already suffering from a static burst.

TRIG.register("shaman_offense_vinelash_venom", "regex", [[^Your quarterstaff leaches (\w+) into (\w+)\'s blood\.$]], function()
    local aff = CONVERT.empowermentToAff [matches[2]:lower()];
    TRACK.taff(matches[3], aff);
end, "Shaman Offense", "");
TRIG.register("shaman_offense_vinelash_venom_hit_by", "regex",
    [[^You wince as (\w+)'s quarterstaff leaches curare into your bloodstream\.$]], function()
    NU.setFlag("recent_venom", NU.time() + 10, 10);
end, "Shaman Triggers", "");


TRIG.register("shaman_offense_leafstorm_strip", "regex", [[^(\w+)\'s (\w+) defense has been shredded\.$]], function()
    local def = matches[3];
    if (def == "magical shield") then
        def = "shielded";
    else
        TRACK.stripTDef(matches[2], "shielded");
    end
    TRACK.stripTDef(matches[2], def);
end, "Shaman Offense", "");
TRIG.register("shaman_offense_divulgence", "regex", [[^The esoteric curse sways your foe \- (\w+) is now stricken with (\w+)\.$]], function()
    TRACK.taff(matches[2], matches[3]);
end, "Shaman Offense", "");

TRIG.register("shaman_offense_vinethorns", "regex", [[^A multitude of thorns break off from the vine\, remaining hooked in (\w+)\'s skin\.$]], function()
    local flagName = matches[2]:lower() .. "_vinethorns";
    NU.setFlag(flagName, FLAGS[flagName] and FLAGS[flagName] + 1 or 1, 60);
end, "Shaman Offense", "");
TRIG.register("shaman_offense_vinethorns_cure", "regex", [[^(\w+) quickly plucks off a cluster of thorns embedded in .+ and tosses them aside\.$]], function()
    local flagName = matches[2]:lower() .. "_vinethorns";
    NU.setFlag(flagName, FLAGS[flagName] and FLAGS[flagName] - 1 or 0, 60);
    if (FLAGS[flagName] <= 0) then
        NU.clearFlag(flagName);
    end
end, "Shaman Offense", "");

TRIG.register("shaman_offense_vitalbane_over", "regex", [[^(\w+)\'s poisoned vitals have regained their health\.$]], function() TRACK.nameCure(matches[2], "vitalbane"); end, "Shaman Offense", "");

TRIG.register("shaman_offense_stormbolt_lightningbolt", "regex", [[^A bolt of lightning arcs down from the storm cloud plaguing (\w+) and engulfs .+\, electricity rippling over .+ body\.$]], function()
    local flagName = matches[2]:lower() .. "_stormbolt";
    NU.setFlag(flagName, FLAGS[flagName] and FLAGS[flagName] - 1 or 0, 60);
    if (FLAGS[flagName] <= 0) then
        NU.clearFlag(flagName);
    end
end, "Shaman Offense", "");

-- The air around Sryaen hums with residual static energy, his body spasming with the forthcoming jolt.
-- probably don't need, but we can maybe use it to gate the staticburst proc.


TRIG.register("shaman_offense_delayed_infest", "regex", [[^(\w+)\'s skin twitches and shifts\, then suddenly erupts into a horrifying mass of squirming larvae\.$]],
function()
    TRACK.taff(matches[2], "infestation");
end, "Shaman Offense", "");
TRIG.register("shaman_offense_delayed_spines", "regex", [[^The seething mass of vines encircling (\w+) constricts\, their barbs sinking deep into .+ skin\.$]],
function()
    TRACK.taff(matches[2], "blight");
end, "Shaman Offense", "");

TRIG.register("shaman_offense_quicken_stacks", "regex", [[^Your quicken defence now has (\d+) stacks\.$]], function() TRACK.getSelf().stacks.quicken = tonumber(matches[2]); end, "Shaman Offense", "");

TRIG.register("shaman_offense_naturaltide_release_failure", "exact", [[You have not prepared any ability for release.]], function() NU.clearFlag(TRACK.getSelf().name .. "_naturaltide"); end, "Shaman Offense", "");
TRIG.register("shaman_offense_fetish_reattune", "regex", [[Your fetishes are already attuned to that target!]], function() NU.setFlag(NU.target .. "_fetish_attuned", true, 60); end, "Shaman Offense", "");
TRIG.register("shaman_offense_greenfoot", "exact", [[Lush plantlife sprouts beneath your feet, blanketing the vicinity in quick motion.]], function()
    NU.setFlag("overgrowth_active", true);
end, "Shaman Offense", "");
-- TRIG.register("shaman_offense_", "regex", [[]], function() end, "Shaman Offense", "");
-- TRIG.register("shaman_offense_", "regex", [[]], function() end, "Shaman Offense", "");
-- TRIG.register("shaman_offense_", "regex", [[]], function() end, "Shaman Offense", "");

-- *** Noube: ALCHEMY - CURRENTS CATALYSED: you *** UNTRACKED
-- STATICBURST BOOSTED - probably need to look into that.
-- Residual static adheres to the conductive serum sheening your skin, the resulting jolt setting your muscles to spasming.