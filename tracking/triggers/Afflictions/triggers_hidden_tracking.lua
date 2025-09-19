local function discover(aff, apply)
    local st = TRACK.getSelf();
    if (not apply) then
        TRACK.ruleOutHidden(st, aff)
    else
        TRACK.hiddenDiscovery(st, aff);
    end

    NU.promptAppend("H - " .. aff, (apply and "<red>" or "<green>") .. "H - " .. aff);

    if (apply) then
        TRACK.aff(st, aff)
    end
end

local function gagIfHidden(aff)
    local st = TRACK.getSelf();
    if (#TRACK.getHiddenCandidateIndicies(st, aff) > 0) then
        NU.gag("hidden_check");
    end
end

-- 
-- 

-- local function dementiaCheck()
--     local st = TRACK.getSelf();
--     if (#TRACK.getHiddenCandidateIndicies(st, "dementia") > 0 and tonumber(matches[2]) ~= gmcp.Room.Info.num) then
--         TRACK.hiddenDiscovery(st, "dementia");
--         TRACK.aff(st, "dementia");
--     end
-- end
-- TRIG.register("dementia_check1", "regex", [[^\-+\s*Area\s*(?:\d+)\:\s*(?:.+)\s*v(\d+)\s*\-+$]], dementiaCheck);
-- TRIG.register("dementia_check2", "regex", [[^\-+\s*v(\d+)\s*\-+$]], dementiaCheck);
TRIG.register("hidden_dementia", "exact", [[You see multiple strange people, all staring at you.]], function() gagIfHidden("dementia"); discover("dementia", true); end)
TRIG.register("hidden_no_dementia", "exact", [[You see the following people here:]], function() gagIfHidden("dementia"); discover("dementia", false); end)

TRIG.register("hidden_no_disfigurement_1", "substr", [[appears to obey, but you question it.]], function() gagIfHidden("disfigurement"); discover("disfigurement", false); end)
TRIG.register("hidden_no_disfigurement_2", "substr", [[is already hostile towards]], function() gagIfHidden("disfigurement"); discover("disfigurement", false); end)
TRIG.register("hidden_no_disfigurement_3", "exact", [[They all seem to settle down.]], function() gagIfHidden("disfigurement"); discover("disfigurement", false); end)
TRIG.register("hidden_no_disfigurement_4", "exact", [[They obey your command.]], function() gagIfHidden("disfigurement"); discover("disfigurement", false); end)

-- You command no presence with others, disfigured as you are.

TRIG.register("hidden_laxity_check", "regex", [[^Survival Focusing\s+(\d+) seconds$]], function() if (tonumber(matches[2]) > 5) then discover("laxity", true); else discover("laxity", false); end end)

TRIG.register("hidden_no_anorexia", "exact", [[Try as you might, you cannot eat that.]], function() gagIfHidden("anorexia"); discover("anorexia", false); end)
TRIG.register("hidden_no_asthma", "exact", [[That pipe has nothing smokeable in it.]], function() gagIfHidden("asthma"); discover("asthma", false); end)

TRIG.register("hidden_no_insomnia", "exact", [[You are already an insomniac.]],
    function()
        gagIfHidden("no_insomnia");
        discover("no_insomnia", false);
    end);
TRIG.register("hidden_insomnia", "exact",
    [[You clench your fists, grit your teeth, and banish all possibility of sleep.]],
    function()
        gagIfHidden("no_insomnia");
        discover("no_insomnia", true);
    end);
-- BACKUPS - I somehow lost an asthma???:
TRIG.register("hidden_asthma_backup", "exact", [[Your lungs are far too constricted to smoke.]], function() TRACK.saffs("asthma"); end)
TRIG.register("hidden_slickness_backup", "exact", [[The poultice would slide right off your slick skin. What's the point?]], function() TRACK.saffs("slickness"); end)
TRIG.register("hidden_anorexia_backup", "exact", [[The idea of putting something in your stomach sickens you.]], function() TRACK.saffs("anorexia"); end)
TRIG.register("hidden_masochism_backup", "exact",
    [[You attempt to stomp on your own earlobe, but gravity takes hold of you and you cannot stop yourself from falling.]],
    function() TRACK.saffs("stupidity"); end)

-- Chameleon worked
TRIG.register("hidden_no_impairment", "exact", [[You know of no one by that name.]], function() gagIfHidden("impairment"); discover("impairment", false); end)
TRIG.register("hidden_have_impairment", "exact", [[Your input, 'irongrip' is not a valid command. Type HELP BASECOMMANDS for a list of common commands.]], function() gagIfHidden("impairment"); discover("impairment", true); end)

-- Concentrate
TRIG.register("hidden_no_confusion1", "exact", [[You already possess equilibrium.]], function() gagIfHidden("confusion"); discover("confusion", false); end)
TRIG.register("hidden_no_confusion2", "exact", [[You are already concentrating on regaining equilibrium.]], function() gagIfHidden("confusion"); discover("confusion", false); end)

--Slickness if we add a check
--TRIG.register("hidden_have_slickness", "exact", [[The poultice would slide right off your slick skin. What's the point?]], function() discover("slickness", true); NU.gag("hidden_check"); end)

--meditate
TRIG.register("hidden_have_impatience", "exact", [[You cannot be bothered to do that, it is too boring.]], function() discover("impatience", true); end)
TRIG.register("hidden_no_impatience1", "exact", [[Your mental prowess is already swollen to its maximum.]], function() discover("impatience", false); end)
TRIG.register("hidden_no_impatience2", "exact", [[You close your eyes, bow your head, and empty your mind of all thought.]], function() discover("impatience", false); NU.gag("hidden_check"); end)

-- These two need to be above paranoia and peace starts, or they get prematurely enabled.
-- needs to be above the . to avoid immediately turning it off.
TRIG.register("hidden_check_end_enemies_allies_gag", "exact", [[-------------------------------------------]], function()
    NU.gag("hidden_check");
    TRIG.disable(TRIGS.hidden_check_enemies_allies_name_gag);
    TRIG.disable(TRIGS.hidden_check_end_enemies_allies_gag);
end)
TRIG.disable(TRIGS.hidden_check_end_enemies_allies_gag);

TRIG.register("hidden_check_enemies_allies_name_gag", "regex", [[.]], function()
    NU.gag("hidden_check");
    TRIG.enable(TRIGS.hidden_check_end_enemies_allies_gag);
end)
TRIG.disable(TRIGS.hidden_check_enemies_allies_name_gag);
--Paranoia
TRIG.register("hidden_no_paranoia", "start", [[You claim these people as allies:]], function()
    if (#TRACK.getHiddenCandidateIndicies(TRACK.getSelf(), "paranoia") > 0) then
        discover("paranoia", false);
        TRIG.enable(TRIGS.hidden_check_enemies_allies_name_gag);
        TRIG.disable(TRIGS.hidden_check_end_enemies_allies_gag);
        NU.gag("hidden_check");
    end
end)
TRIG.register("hidden_have_paranoia", "exact", [[Allies are for weaklings - you have no allies!]], function()
    discover("paranoia", true);
    NU.gag("hidden_check");
end)
TRIG.register("hidden_enemies_paranoia", "exact",
    [[Everyone is, of course, an enemy, but these people really sicken you:]],
    function()
        discover("paranoia", true); discover("peace", false); TRIG.enable(TRIGS.hidden_check_enemies_allies_name_gag);
        TRIG.disable(TRIGS.hidden_check_end_enemies_allies_gag);
    end)
TRIG.register("hidden_check_enemies_allies_done", "regex", [[^You possess \d+ (?:allies|enemies|ally|enemy)\.$]], function() NU.gag("hidden_check"); TRIG.disable(TRIGS.hidden_check_enemies_allies_name_gag); end)
TRIG.register("hidden_check_enemies_allies_NONE_done", "regex", [[^You have no (?:allies|enemies)\.$]], function() NU.gag("hidden_check"); TRIG.disable(TRIGS.hidden_check_enemies_allies_name_gag); end)
TRIG.register("hidden_check_enemies_allies_NONE_done", "exact", [[Your enemies are pardoned due to divine grace.]], function() NU.gag("hidden_check"); TRIG.disable(TRIGS.hidden_check_enemies_allies_name_gag); end)

--Peace
TRIG.register("hidden_no_peace", "start", [[You claim these people as foes:]], function()
    if (#TRACK.getHiddenCandidateIndicies(TRACK.getSelf(), "peace") > 0) then
        discover("peace", false);
        TRIG.enable(TRIGS.hidden_check_enemies_allies_name_gag);
        TRIG.disable(TRIGS.hidden_check_end_enemies_allies_gag);
        NU.gag("hidden_check");
    end
end)
TRIG.register("hidden_have_peace", "exact", [[Maaaaaaaan, why can't like, everyone just get along? You know?]],
    function()
        discover("peace", true);
        NU.gag("hidden_check");
    end)


--Stuttering
TRIG.register("hidden_no_stuttering", "exact", [[(Speech Therapy): You say, "Hello, did you perchance make me start stuttering?"]], function() discover("stuttering", false); NU.gag("hidden_check"); end)
TRIG.register("hidden_have_stuttering", "regex", [[^\(Speech Therapy\): You say\, \"H.*\.\.]], function() discover("stuttering", true); NU.gag("hidden_check"); end)

--Blackout specific cases:
TRIG.register("reflection_strip", "exact", [[One of your reflections has been destroyed! You have 0 left.]], function() TRACK.removeDef(TRACK.getSelf(), "reflection"); end);
TRIG.register("shield_strip", "exact", [[Your aggressive action causes the nearly invisible magical shield around you to fade away.]], function() TRACK.removeDef(TRACK.getSelf(), "shielded"); end);
TRIG.register("blackout_pacifism", "exact", [[You are feeling far too passive to do that.]], function() discover("pacifism", true); end);

