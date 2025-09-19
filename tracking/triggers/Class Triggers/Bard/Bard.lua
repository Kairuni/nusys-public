local straightRunebandAff = {
    stupidity = "paranoia",
    paranoia = "ringing_ears",
    ringing_ears = "loneliness",
    loneliness = "exhaustion",
    exhaustion = "laxity",
    laxity = "clumsiness",
    clumsiness = "stupidity",
}

local reverseRunebandAffs = {};
for k,v in pairs(straightRunebandAff) do
    reverseRunebandAffs[v] = k;
end

local function runebandHit()
    local ttable = TRACK.get(matches[2]);
    local currentDir = FLAGS[ttable.name .. "_runeband"];
    local currentTable = (currentDir == 1) and straightRunebandAff or reverseRunebandAffs;
    local lastHit = FLAGS[ttable.name .. "_runeband_last"] or ((currentDir == 1) and "clumsiness" or "paranoia");
    local nextAff = currentTable[lastHit];
    local nextDirection = FLAGS[ttable.name .. "_runeband_next"];
    NU.clearFlag(ttable.name .. "_runeband_next");

    creplaceLine("<green>RUNEBAND HIT " .. ttable.name .. ": " .. UTIL.affLongToShort[nextAff]);

    TRACK.aff(ttable, nextAff);

    NU.setFlag(ttable.name .. "_runeband", nextDirection or currentDir, 16);
    NU.setFlag(ttable.name .. "_runeband_last", nextAff, 16);
end

local function runebandReverse()
    local ttable = TRACK.get(matches[2]);
    local currentDir = FLAGS[ttable.name .. "_runeband_next"] or FLAGS[ttable.name .. "_runeband"];
    if (not currentDir or currentDir == 2) then
        NU.setFlag(ttable.name .. "_runeband_next", 1, 16);
    else
        NU.setFlag(ttable.name .. "_runeband_next", 2, 16);
    end
end

local function globeHit()
    local ttable = TRACK.get(matches[2]);
    local globesFlag = FLAGS[ttable.name .. "_globes"];
    local nextAff = table.remove(globesFlag, 1);
    if (#globesFlag == 0) then
        NU.clearFlag(ttable.name .. "_globes");
    end

    TRACK.aff(ttable, nextAff);
end

local function runebandFade()
    local ttable = TRACK.get(matches[2]);
    NU.clearFlag(ttable.name .. "_runeband");
    NU.clearFlag(ttable.name .. "_runeband_next");
    NU.clearFlag(ttable.name .. "_runeband_last");
end

TRIG.register("rhythm_end", "exact", [[You ease your grip upon your falchion.]], function() NU.clearFlag("skip_tempo"); end);
TRIG.register("self_runeband_hit", "exact", [[The shifting runes within the band capture your attention.]], function() creplaceLine("<red>RUNEBAND HIT"); end);
TRIG.register("runeband_hit", "regex", [[^The shifting runes within the band around (\w+) capture \w+ attention\.$]], runebandHit);
TRIG.register("runeband_reverse", "regex", [[^The brilliant rune bands encircling (\w+) reverse \w+ pattern, changing its spin\.$]], runebandReverse);
TRIG.register("runeband_fade", "regex", [[^The shifting band of runes around (\w+) has crumbled in your absence\.$]], runebandFade);

TRIG.register("globe_hit_1", "regex", [[^The searing globe rattles (\w+)\'s thoughts as it spins out of existence\.$]], globeHit);
TRIG.register("globe_hit_2", "regex", [[^The final globe burns itself into (\w+)\'s thoughts as it fades into obscurity\.$]], globeHit);

TRIG.register("boundary_fade", "exact", [[The boundary disappears.]], function() NU.clearFlag("boundary"); end);

TRIG.register("discordance_hidden", "exact", [[The music engulfs you with contrarient emotions.]], function()
    NU.setPFlag("expected_hiddens", {source = "discordance", affList = {"hallucinations", "masochism", "mania"}, expectedCount = 1});
end);

TRIG.register("bladestorm_hit", "regex", [[^A dark dagger plunges down from the skies and into (\w+)\, sinking up to the hilt\.$]], function() NU.setPFlag("venom_target", TRACK.get(matches[2])); end);
TRIG.register("bladestorm_finalhit", "regex", [[^The final dagger plunges down from the skies and into (\w+)\, sinking into flesh\.$]], function() NU.setPFlag("venom_target", TRACK.get(matches[2])); NU.clearFlag(matches[2]:lower() .. "_bladestorm"); end);
TRIG.register("bladestorm_timeout", "exact", [[The daggers held within the sky vanish into wisps of smoke.]], function() NU.clearFlag(NU.target .. "_bladestorm"); end);


TRIG.register("needle_applied", "regex", [[^(\w+) appears flushed and somewhat unsteady on \w+ feet\.$]], function() if (FLAGS.needle_venom) then display("WEEOO"); TRACK.taff(matches[2], CONVERT.empowermentToAff [FLAGS.needle_venom]); end end);

-- TODO: BIG REFACTOR of -EVERY FLAG- that uses name .. "_something". Add these in tracking, with appropriate time values too. It can even internally use flags if it wants to. This code is gross.
TRIG.register("ironcollar_self_locked", "exact", [[An iron collar snaps shut around your throat, sealing itself together.]], function() NU.setFlag(TRACK.getSelf().name .. "_ironcollar", 2, 60); end);
TRIG.register("ironcollar_self_none", "exact", [[You aren't wearing an iron collar.]], function() NU.clearFlag(TRACK.getSelf().name .. "_ironcollar"); end);
TRIG.register("ironcollar_self_removed", "exact", [[You remove an iron collar.]], function() NU.clearFlag(TRACK.getSelf().name .. "_ironcollar"); end);
TRIG.register("ironcollar_locked", "regex", [[An iron collar snaps shut around (\w+)\'s throat, sealing itself together\.$]], function() NU.setFlag(matches[2]:lower() .. "_ironcollar", 2, 60); end);
TRIG.register("ironcollar_removed", "regex", [[(\w+) removes an iron collar\.$]], function() NU.clearFlag(matches[2]:lower() .. "_ironcollar"); end);
TRIG.register("ironcollar_failed", "regex", [[An iron collar snaps shut in (\w+)\'s hand, clamping only air\.$]], function() NU.clearFlag(matches[2]:lower() .. "_ironcollar"); end);

TRIG.register("soundblast_hit", "regex", [[^(\w+) grabs \w+ ears as [\w\s]+ is shaken by the sound\.$]], function() TRACK.taff(matches[2], "no_deafness"); TRACK.taff(matches[2], "ringing_ears"); end);

local function anelaceBroke()
    local val = FLAGS.wove_anelace;
    if (val and val > 1) then
        FLAGS.wove_anelace = val - 1;
    else
        NU.clearFlag("wove_anelace");
    end
end
TRIG.register("anelace_broke_weaponbelt", "exact", [[A sharp anelace breaks into shimmering light in your weaponbelt as it crumbles apart.]], anelaceBroke);
TRIG.register("anelace_broke_inventory", "exact", [[A sharp anelace breaks into shimmering light in your hands as it crumbles apart.]], anelaceBroke);

TRIG.register("audience_set", "regex", [[^You choose to play your music for (\w+)\.$]], function() NU.setFlag("audience_target", matches[2]:lower(), 120); end);

local function clearBoundary()
    if (FLAGS.bard_boundaries) then
        local n = table.index_of(FLAGS.bard_boundaries, gmcp.Room.Info.num);
        if (n) then table.remove(FLAGS.bard_boundaries, n); end
    end
end

TRIG.register("boundary_fell", "exact", [[A glimmer catches your eye as the boundary of light disappears.]], clearBoundary);

local function enableColdreads()
    TRIG.enable(TRIGS.coldread_unremarkable);
    TRIG.enable(TRIGS.coldread_capture_1);
    TRIG.enable(TRIGS.coldread_capture_2);
    TRIG.enable(TRIGS.coldread_end);
end

local function disableColdreads()
    TRIG.disable(TRIGS.coldread_unremarkable);
    TRIG.disable(TRIGS.coldread_capture_1);
    TRIG.disable(TRIGS.coldread_capture_2);
    TRIG.disable(TRIGS.coldread_end);
end

local emotions = {
    "sadness", "happiness", "surprise", "anger", "stress", "fear", "disgust"
};

TRIG.register("coldread_start", "regex", [[^You perform a cold read of (\w+)]],
    function()
        NU.setPFlag("coldreading", matches[2]:lower());
        enableColdreads();
        NU.gag("coldread");
end
);
TRIG.register("coldread_unremarkable", "regex", [[emotional state is unremarkable.]],
    function()
        NU.clearFlag(PFLAGS.coldreading .. "_major_emotion");
        for _,v in ipairs(emotions) do
            NU.clearFlag(PFLAGS.coldreading .. "_" .. v);
        end
        disableColdreads();
    end
);

local majorMap = {
    sad = "sadness", happy = "happiness", fearful = "fear", angry = "anger", surprised = "surprise", stressed = "stress", disgusted = "disgust", neutral = "neutral"
}

TRIG.register("coldread_capture_1", "regex", [[emotional state is predominantly (\w+)]],
    function()
        -- Refactor to use TRACK.setState
        -- Add resetting for state tracking.
        -- Add some UI for this?
        if (majorMap[matches[2]]) then
            NU.setFlag(PFLAGS.coldreading .. "_major_emotion", majorMap[matches[2]]);
        else
            NU.promptAppend("coldreadFailure", "Failed coldread major map on " .. matches[2]);
            NU.setFlag(PFLAGS.coldreading .. "_major_emotion", matches[2]);
        end
        NU.gag("coldread");
    end
);
TRIG.register("coldread_capture_2", "regex", [[(\w+) is at (\d+)\%]],
    function()
        -- Refactor to use TRACK.setState
        -- Add resetting for state tracking.
        -- Add some UI for this?
        NU.setFlag(PFLAGS.coldreading .. "_" .. matches[2]:lower(), tonumber(matches[3]));
        NU.gag("coldread");
    end
);
TRIG.register("coldread_end", nil, "disgust",
    function()
        local msg = FLAGS[PFLAGS.coldreading .. "_major_emotion"]:sub(0, 2);
        if (msg == "ne") then
            msg = "<blue>" .. msg;
        else
            msg = "<red>" .. msg;
        end

        for _,v in ipairs(emotions) do
            local val = FLAGS[PFLAGS.coldreading .. "_" .. v];
            local col = val > 50 and "<red>" or "<blue>";
            msg = msg .. "<white> | " .. v:sub(0, 2) .. ": " .. col .. tostring(val);
        end
        NU.promptAppend("coldreads", msg)
        disableColdreads();
    end
);

disableColdreads();


--halfbeat
TRIG.register("halfbeat_active", "exact", [[Your tone shifts as it picks up speed.]], function() NU.promptAppend("halfbeat_active", "<green>+halfbeat"); NU.setFlag("halfbeat_active", NU.time() + 20, 30); NU.gag("halfbeat"); end);
TRIG.register("halfbeat_inactive", "exact", [[Your songs lose their tempo as your body calms itself.]], function() NU.promptAppend("halfbeat_active", "<red>-halfbeat"); NU.clearFlag("halfbeat_active"); NU.setFlag("next_halfbeat", NU.time() + 20); NU.gag("halfbeat"); end);

TRIG.register("quip_mania", "regex", [[^The insult drives (\w+) particularly mad\, whose face fills with anger\.$]], function() TRACK.taff(matches[2], "mania"); end);

TRIG.register("discordance_hit", "regex", [[^The music engulfs (\w+) with (\w+)\.$]], function() TRACK.taff(matches[2], matches[3]); end);



local function clearSingingOrPlaying(song, target)
    if (FLAGS.singing and FLAGS.singing == song) then NU.clearFlag("singing"); else NU.clearFlag("playing"); end
    creplaceLine("<green>" .. song:upper() .. " HIT" .. (target and ": " .. target or "!"));
end

TRIG.register("released_song_hold", "exact", [[You release your hold upon your song.]], function() NU.clearFlag("held_song"); end);

-- Decadence over - addiction
TRIG.register("decadence_hit", "exact", [[Your tantalizing song coils around your audience with the hedonistic slink of silk, concluding with a single velvety note lingering in the ether.]], function() clearSingingOrPlaying("decadence"); end);
TRIG.register("decadence_effected", "regex", [[^You sense that your decadent song has affected (\w+)\.$]], function() TRACK.taff(matches[2], "addiction"); end);

-- Charity over - generosity
TRIG.register("charity_hit", "exact", [[Your charming song weaves its well-natured notes through the air, instilling a sense of altruism.]], function() clearSingingOrPlaying("charity"); end);
TRIG.register("charity_effected", "regex", [[^You sense that your charitable song has affected (\w+).$]], function() TRACK.taff(matches[2], "generosity"); end);

-- Fascination over - writhe_stasis
TRIG.register("fascination_effected", "regex", [[^Like an auditory snare\, your song captivates (\w+)'s attention, arresting]], function() clearSingingOrPlaying("fascination"); TRACK.taff(matches[2], "writhe_stasis"); end);
--

-- Youth over - heal
TRIG.register("youth_hit", "exact", [[With a jubiliant crescendo, your humble ditty instills itself into the hearts of your allies.]], function() clearSingingOrPlaying("youth", "foundation or harmony"); end);
--

-- Feasting over - Eat a bunch
TRIG.register("feasting_hit", "exact", [[Your melody reaches its crescendo, its famishing effects now felt by all.]], function() clearSingingOrPlaying("feasting"); end);

-- Unheard fail
TRIG.register("unheard_failed", "start", [[Your forceful, demanding song reaches]], function() clearSingingOrPlaying("unheard"); end);

TRIG.register("sorrow_effected", "regex", [[^The morbid cadence of your sombre ballad incites a deep and profound sorrow in (\w+)\.$]], function() clearSingingOrPlaying("sorrow", matches[2]); TRACK.taff(matches[2], "squelched"); TRACK.taff(matches[2], "migraine"); end);

-- Merriment active (held)
TRIG.register("merriment_hit", "exact", [[With a jubilant smile, you increase the volume on your merry song, sending it further and yon.]], function() clearSingingOrPlaying("merriment"); NU.setFlag("held_song", "merriment", 20); end);
TRIG.register("merriment_held", "exact", [[Not quite raucous, but filled with merry wonder, you sing a happy, upbeat tune.]], function() NU.setFlag("held_song", "merriment", 6); end);

TRIG.register("awakening_hit", "exact", [[With a final, flourishing note, your powerful song awakens the inner emotions of those around you.]], function() clearSingingOrPlaying("awakening"); end);
TRIG.register("awakening_effected", "regex", [[^(\w+) gazes at you in awe\, lost in a windfall of emotional awakening\.]], function() NU.setFlag(matches[2]:lower() .. "_major_emotion", "neutral", 500); end);
TRIG.register("awakening_over", "regex", [[^(\w+)\'s emotions settle back into normalcy\.]], function() NU.clearFlag(matches[2]:lower() .. "_major_emotion"); end);

TRIG.register("doom_hit", "exact", [[]], function()    end);
TRIG.register("doom_effected", "regex", [[^Unable to escape the song-woven and soul-fuelled destruction of the darkly vibrating notes\, your tune finds and captivates (\w+), bringing doom upon (\w+)\.$]], function() clearSingingOrPlaying("doom", matches[2]); end);
TRIG.register("doom_fail", "regex", [[^The oppressive weight of doom dissipates about (\w+) without fanfare\.$]], function() end);
TRIG.register("doom_damage", "regex", [[^(\w+) sags as the oppressive weight of doom descends upon]], function() end);

TRIG.register("foundation_hit", "exact", [[With a jubiliant crescendo, your humble ditty instills itself into the hearts of your allies.]], function() clearSingingOrPlaying("foundation", "youth or harmony"); end);

TRIG.register("destiny_hit", "exact", [[The flow of destiny favours you as your song ends with a single strident note.]], function() clearSingingOrPlaying("destiny"); end);

TRIG.register("tranquility_hit", "exact", [[The melody releases its full potential, capturing the hearts of those around you.]], function() clearSingingOrPlaying("tranquility"); NU.setFlag("held_song", "tranquility", 20); end);
TRIG.register("tranquility_held", "regex", [[Peace, tranquility, and a cosy warmth suffuse your body and soul as you sing.]], function() TRACK.taff(matches[2], ""); end);

TRIG.register("harmony_hit", "exact", [[With a jubiliant crescendo, your humble ditty instills itself into the hearts of your allies]], function() clearSingingOrPlaying("harmony", "foundation or youth"); end);

TRIG.register("remembrance_hit", "exact", [[You quiet song ends with a sombre tone as your mind swirls with past memories.]], function() clearSingingOrPlaying("remembrance"); end);

-- Hero
--
TRIG.register("hero_hit", "regex", [[^Heroism and courage touch (\w+) as your rowdy anthem lifts him up in its musical arms\.$]], function() clearSingingOrPlaying("hero", matches[2]); end);
TRIG.register("hero_held", "exact", [[Boisterous and begging for a sing-along, you belt out a stirring anthem for all to hear.]], function() NU.setFlag("held_song", "hero", 20); end);


--
TRIG.register("fate_hit", "exact", [[^The eerie\, impenitent evensong embraces (\w+)\, creating a song-woven darkness that swathes]], function() clearSingingOrPlaying("fate", matches[2]); end);
TRIG.register("fate_effected", "regex", [[^The darkness expands\, turning thick and billowing\, and swallowing the (\w+) exit from (\w+)\.$]], function() end);
TRIG.register("fate_gone", "regex", [[^A sudden breeze buffets (\w+)\, dissipating the darkness following (\w+) into the ether\.$]], function() end);

TRIG.register("oblivion_hit", "exact", [[Your dolent song, and its inevitable conclusion, instills quivering, quarreling notes of dread into your very soul.]], function() clearSingingOrPlaying("oblivion");    NU.setFlag("held_song", "oblivion", 20); end);

TRIG.register("bravado_cd", "exact", [[Your bravado swells with new-found strength.]], function() NU.clearFlag("bravado_cd"); end);