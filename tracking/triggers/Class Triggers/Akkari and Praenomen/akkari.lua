TRIG.register("akkari_recruit_doctrine", "regex", [[^A fervent .+ uses Discipline Doctrine \(disruption\)\.$]], function() end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_recruit_mana_drain_1", "regex", [[^A fervent .+ releases a clarion battlecry that cleaves through the air\, leaving (\w+) reeling]], function() TRACK.damage(TRACK.get(matches[2]), 0, 250); end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_recruit_mana_drain_2", "regex", [[^A fervent .+ rebukes (\w+) in a strident call to action, the holy verses leaving]], function() TRACK.damage(TRACK.get(matches[2]), 0, 250); end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_recruit_paresis", "regex", [[^A fervent .* crouches low and strikes at (\w+)'s spine, causing .* muscles to seize\.$]], function() TRACK.taff(matches[2], "paresis"); end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_recruit_haemophilia", "regex", [[^A fervent .+ sashays forward in a frenzy, lashing out at (\w+) in a flurry of rage-fuelled strikes\.$]], function() TRACK.taff(matches[2], "haemophilia"); end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_recruit_hallucinations", "regex", [[^A fervent .+ lurches at (\w+) with violent purpose before turning away at the last moment, its feinting manoeuvre leaving .+ mind reeling\.$]], function() TRACK.taff(matches[2], "hallucinations"); end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_recruit_strip_fangbarrier", "regex", [[^A fervent .+ flourishes its weapon before (\w+)'s eyes in an unerring display of skill, sweat breaking out upon .* skin in recognition of the harrowing assault\.$]], function() TRACK.stripTDef(matches[2], "fangbarrier"); end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_penitence_fangbarrier_strip", "regex", [[^(\w+)\'s protective coating sloughs away as crushing guilt causes]], function() TRACK.stripTDef(matches[2], "fangbarrier"); end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_denounce_corruption", "regex", [[^Motes of light pulse beneath (\w+)\'s skin, .+ veins twisting oddly as the scouring incandescence wreaks havoc upon .+ insides\.$]], function()
    NU.setFlag(matches[2] .. "_black_bile", true, 60);
end, "AKKARI_OFFENSE_TRACKING", "");

local blackBileTable = {
    "weariness",
    "clumsiness",
    "vomiting",
}

local function onBlackBile()
    local tt = TRACK.get(matches[2]);
    TRACK.aff(tt, "effused_blood");
    for _, v in ipairs(blackBileTable) do
        if (not tt.affs[v]) then
            TRACK.aff(tt, v);
            return;
        end
    end
end

TRIG.register("akkari_black_bile_effect", "regex", [[^(\w+)\'s skin turns a sickly colour and black bile seeps from .+ mouth\.$]], onBlackBile, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_effused_blood_1", "regex", [[^(\w+) looks horrified as his skin begins to weep with vivid red blood.]], function() TRACK.taff(matches[2], "effused_blood"); end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_effused_blood_2", "regex", [[^(\w+) screams as his veins burst open spilling precious life blood to the ground.]], function() TRACK.taff(matches[2], "effused_blood"); end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_remorse_effect", "regex", [[^(\w+)'s terrible remorse instills certainty of purpose in your mind\.$]], function() TRACK.taff(matches[2], "remorse"); end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_contrition_effect", "regex", [[^The weight of (\w+)'s contrition suffuses your body with righteous vigour\.$]], function() TRACK.taff(matches[2], "contrition"); end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_holylight_proc", "regex", [[^Terror consumes (\w+) as the pitiless light inspires (self_pity|sadness|hubris|commitment fear) in .+ heart\.$]], function()
    TRACK.taff(matches[2], CONVERT.discernmentConversion[matches[3]]);
end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_already_passionate", nil, [[already burns with a passion for justice.]], function() NU.setFlag(TRACK.getSelf().name .. "_passion", true, 600); end, "AKKARI_OFFENSE_TRACKING", "");
-- TRIG.register("akkari_attend_off_cd", "", [[You may demand their attendance once more.]], function() end, "AKKARI_OFFENSE_TRACKING", "");
-- TRIG.register("akkari_1p_vilify", "", [[You declare that all shall know of Zarranik's villainy, and incite the brand you have placed to consume.]], function() end, "AKKARI_OFFENSE_TRACKING", "");
TRIG.register("akkari_3p_vilify", "regex",
    [[^The brand of the pariah upon the brow of (\w+) suddenly bursts into incandescent flame\, casting .+ features into stark relief\.$]],
    function()
        local tt = TRACK.get(matches[2]); TRACK.damage(tt, 0, tt.vitals.maxmp * 0.08);
        NU.clearFlag(tt.name .. "_pariah");
    end, "AKKARI_OFFENSE_TRACKING", "Villify Mana Drain");
-- TRIG.register("akkari_", "", [[]], function() end, "AKKARI_OFFENSE_TRACKING", "");
-- TRIG.register("akkari_", "", [[]], function() end, "AKKARI_OFFENSE_TRACKING", "");
-- TRIG.register("akkari_", "", [[]], function() end, "AKKARI_OFFENSE_TRACKING", "");

-- TRACK.countAffsByList(ttable, affList)
-- Denounce Strife
-- sadness, confusion, dementia, hallucinations, paranoia, hatred, hypersomnia, addiction, blood curse, and blight

-- if 3 ^ then make my pet attack with its thing

-- Denounce Darkness
-- If 3 euphoriant, then sap dexterity.

-- Denounce Evil
-- Drain mana if 3 depressant

-- Need lines for each.

-- Blood rune?
-- ^You declare that all shall know of (\w+)'s villainy, and incite the brand you have placed to consume\.$
-- ^The brand of the pariah you had placed upon (\w+) fades from your awareness\.$




-- has remorse

-- Has contrition

