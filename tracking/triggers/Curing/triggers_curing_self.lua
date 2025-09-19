-- Note - order matters here.
-- We want to define things in reverse order so that we don't evaluate triggers early.
-- i.e. any_eating triggers before cure_msg, so it -must- be after cure_msg or when we TRIG.enable it breaks things.

-- Disables the three cure (non-msg) related TRIGS.
local function disableCureTriggers()
    TRIG.disable(TRIGS.some_cure);
    TRIG.disable(TRIGS.some_def_strip_cure);
    TRIG.disable(TRIGS.no_cure);
    TRIG.disable(TRIGS.some_def_strip_cure);
    TRIG.disable(TRIGS.some_def_gain_cure);
    TRIG.disable(TRIGS.no_cure_prompt);
end

-- Register one cure - if expected cures is set, decrement it.
local function registerCure(affliction)
    --display(affliction);
    if (PFLAGS.next_cure) then
        NU.appendPFlag(PFLAGS.next_cure .. "_cure", affliction);
    end
    if (not PFLAGS.expected_cures or PFLAGS.expected_cures == 1) then
        TRIG.disable(TRIGS.some_cure);
        TRIG.disable(TRIGS.no_cure_prompt);
        TRIG.disable(TRIGS.no_cure);
        TRIG.disable(TRIGS.some_def_strip_cure);
        TRIG.disable(TRIGS.some_def_gain_cure);
    else
        PFLAGS.expected_cures = PFLAGS.expected_cures - 1;
        if (PFLAGS.expected_cures <= 0) then
            PFLAGS.expected_cures = nil;
        end
    end
end

-- Catch the cure.
TRIG.register("some_def_gain_cure", "regex", [[^You have gained the ([A-Za-z\-\_]+) defence\.$]], function() NU.DECHO("Cured def.", 1); TRACK.cure(TRACK.getSelf(), "no_" .. matches[2], true); registerCure("no_" .. matches[2]); NU.setPFlag("did_cure", true); end);
TRIG.register("some_def_strip_cure", "regex", [[^Your ([A-Za-z\-\_]+) defence has been stripped\.$]], function() NU.DECHO("Cured def strip.", 1); TRACK.cure(TRACK.getSelf(), "clear_" .. matches[2], true); registerCure("clear_" .. matches[2]); NU.setPFlag("did_cure", true); end);
TRIG.register("some_cure", "regex", [[^You have cured ([A-Za-z\-\_]+)\.$]], function() NU.DECHO("Cured.\n", 1); TRACK.cure(TRACK.getSelf(), matches[2]); registerCure(matches[2]); NU.setPFlag("did_cure", true); end);
-- Catch any other line.
TRIG.register("no_cure_prompt", "prompt", nil, function() NU.DECHO("No cure.\n", 1); disableCureTriggers() end);
TRIG.register("no_cure", "regex", ".", function() NU.DECHO("No cure.\n", 1); disableCureTriggers() end);
-- Catch cure message, for self case.
TRIG.register("cure_msg", "regex", ".", function() NU.DECHO("On cure msg.\n", 1); TRIG.disable(TRIGS.cure_msg); TRIG.enable(TRIGS.some_cure); TRIG.enable(TRIGS.no_cure); TRIG.enable(TRIGS.no_cure_prompt); TRIG.enable(TRIGS.some_def_strip_cure); TRIG.enable(TRIGS.some_def_gain_cure); end);
TRIG.register("health_sip", "exact", [[The elixir heals and soothes you.]], function() NU.DECHO("Cured.\n", 1); NU.setPFlag("self_sip_handled", true); disableCureTriggers(); end);
TRIG.register("anabiotic_eat", "exact", [[You feel your health and mana replenished.]], function() NU.DECHO("Cured anabiotic.\n", 1); NU.setPFlag("eat_handled", true); end);

TRIG.register("some_raw_cure", "regex", [[^You have cured ([A-Za-z\-\_]+)\.$]], function() if (PFLAGS.did_cure) then PFLAGS.did_cure = nil; else NU.DECHO("Raw cured.\n", 2); TRACK.cure(TRACK.getSelf(), matches[2]); end end);
TRIG.register("some_raw_def_strip", "regex", [[^Your ([A-Za-z\-\_]+) defence has been stripped\.$]], function() TRACK.removeDef(TRACK.getSelf(), matches[2]); end);

TRIG.disable(TRIGS.cure_msg);
TRIG.disable(TRIGS.some_cure);
TRIG.disable(TRIGS.no_cure);
TRIG.disable(TRIGS.no_cure_prompt);
TRIG.disable(TRIGS.some_def_strip_cure);
TRIG.disable(TRIGS.some_def_gain_cure);

-- Failed cures:
TRIG.register("no_cure_poultice", "exact", [[The poultice mashes uselessly against your body.]], function() NU.DECHO("No poultice cure.", 2); disableCureTriggers(); end);

-- Catch self and mixed cure lines.
-- TODO: Update .+ to the list of possible pills.
TRIG.register("any_eating", "regex", [[^(?:You sense )?(\w+) swallows? (?:a|an|some) (.+)\.$]], function() NU.DECHO("On swallow.\n", 1); TRACK.cureAction(matches[2], "eat", matches[3]); end);
TRIG.register("self_focus", "exact", [[You focus your mind intently on curing your mental maladies.]],
    function()
        NU.DECHO("On self focus.\n", 1); TRACK.cureAction("You", "focus"); NU.setPFlag("expect_damage", true);
    end);
TRIG.register("any_normal_poultice", "regex",
    [[^(?:You sense )?(\w+) presse?s? an? (epidermal|mending|caloric|soothing|mass) poultice against \w+ (head|torso|arms|legs|left arm|right arm|left leg|right leg|flesh|skin)\, rubbing (?:the poultice|it) into \w+ flesh\.$]],
    function() TRACK.cureAction(matches[2], "poultice", matches[3], matches[4]); end);
TRIG.register("any_resto_poultice", "regex",
    [[^(?:You sense )?(\w+) presse?s? a restoration poultice against \w+ (head|torso|arms|legs|left arm|right arm|left leg|right leg|flesh|skin)\, rubbing (?:the poultice|it) into \w+ flesh\.$]],
    function() TRACK.appliedRestoration(matches[2], matches[3]); end);
TRIG.register("any_smoke", "regex", [[^(?:You sense )?(\w+) takes? a long drag off \w+ pipe filled with (\w+)\.$]], function() NU.DECHO("On any smoke.", 1); TRACK.cureAction(matches[2], "smoke", matches[3], nil, {rebounding = (matches[3] == "reishi")}); if (matches[2] == "You") then NU.setPFlag("smoked", matches[3]); end end);
--TRIG.register("self_concentrate", "exact", [[You begin intense concentration to restore your equilibrium.]], function() TRACK.cureAction("You", "concentrate"); end);
TRIG.register("self_sip", "regex", [[^You take a drink of an elixir of (levitation|harmony|arcane|speed|immunity|health|mana)]], function() TRACK.cureAction("You", "self_sip", matches[2], nil, {speed = (matches[2] == "speed")}); end);
TRIG.register("self_sip_empty", "regex", [[^You down the last drop of an elixir of (levitation|harmony|arcanespeed|immunity|health|mana)]], function() TRACK.cureAction("You", "self_sip", matches[2]); end);
TRIG.register("self_pipe_empty_1", "exact", [[What is it you wish to smoke?]], function() if (FLAGS.pipe_sent) then local herb = CURES.lookup[FLAGS.pipe_sent].pipe; NU.appendFlag("fill_pipe", herb, true); end end);
TRIG.register("self_pipe_empty_2", "exact", [[That pipe has nothing smokeable in it.]], function() if (FLAGS.pipe_sent) then local herb = CURES.lookup[FLAGS.pipe_sent].pipe; NU.appendFlag("fill_pipe", herb, true); end end);
TRIG.register("self_pipe_empty_3", "exact", [[Your pipe is now empty.]],
    function()
        if (PFLAGS.smoked) then
            NU.appendFlag("prompt_append", "EP", "EMPTY " .. PFLAGS.smoked, 5); NU.appendFlag("fill_pipe", PFLAGS.smoked,
                true);
        end
    end);
TRIG.register("self_pipe_fill", "regex", [[^You fill your pipe with (?:a|some) (yarrow|reishi|willow)]], function() if (FLAGS.fill_pipe) then FLAGS.fill_pipe[matches[2]] = nil; end end);
TRIG.register("self_pipe_fill", "exact", [[The pipe is full.]], function() NU.clearFlag("fill_pipe"); end);

-- Renew
--TRIG.register("self_erase", "exact", [[You grit your teeth as a wave of energy courses throughout your body, purging it of maladies.]], function() TRACK.cureAction("You", "renew"); end);
--TRIG.register("self_reconstitute", "exact", [[With a sinister grin, you will your body to repair itself of afflictions.]], function() TRACK.cureAction("You", "renew"); end);
--TRIG.register("self_renew", "exact", [[With a faint but confident smile, you invoke the healing power of Life to purge afflictions from your body.]], function() TRACK.cureAction("You", "renew"); end);

-- Randoms
TRIG.register("any_tree", "regex", [[^(\w+) touche?s? (?:a|the) tree of life tattoo\.$]], function() TRACK.cureAction(matches[2], "tree"); end);

TRIG.register("self_crystal", "exact", [[You touch the crystal tattoo, but nothing happens.]], function() NU.cooldown("Tattoos_Crystal", 200); end);

-- Paste
-- You apply some hardening paste to yourself.
-- 
-- Kalena applies some hardening paste to herself.
TRIG.register("any_paste", "regex", [[^(\w+) appl(?:y|ies) some hardening paste]], function() print("Fangbarrier for " .. matches[2]); if (PFLAGS.illusion) then return; else local name = TRACK.get(matches[2]).name; NU.setFlag(name .. "_fangbarrier", true, 7, function() TRACK.nameCure(name, "no_fangbarrier") end); end end);
TRIG.register("self_already_paste", "exact", [[You have already applied a wet coat to your skin.]], function() if (PFLAGS.illusion) then return; else local name = TRACK.getSelf().name; NU.setFlag(name .. "_fangbarrier", true, 7, function() TRACK.nameCure(name, "no_fangbarrier") end); end end);

-- Starburst -- Probably put these in the combat message tracker.
--^(\w+) uses? Illumination Rebirth\.$
--^(\w+) uses? Tattoos Starburst\.$
--^(\w+) uses? Purification Resurgence\.$

-- Writhe start:
