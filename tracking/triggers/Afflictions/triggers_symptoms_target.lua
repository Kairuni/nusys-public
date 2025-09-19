-- Ablaze
-- ^Flames leap around (\w+), charring \w+ flesh\.$

-- Addiction
-- ^Growing unfocused, a perverse addiction settles over (\w+)\.$

-- Masochism
-- ^(\w+) drives a clenched fist into \w+ gut\.$

-- Weariness
-- ^(\w+) slumps with a weary groan\.$

-- Paresis escalation
TRIG.register("symptom_paralysis", "regex", [[^(\w+) suddenly seizes up, \w+ entire body locked by paralysis\.$]], function() TRACK.nameCure(matches[2], "paresis"); TRACK.taff(matches[2], "paralysis"); end);

-- Paresis from Allergies escalation
-- ^(\w+)'s limbs go limp under \w+ allergies, leaving \w+ unable to move\.$

-- Shivering symptom
TRIG.register("symptom_shivering", "regex", [[^(\w+) shivers particularly intensely\.$]], function() TRACK.taff(matches[2], "shivering"); end);
-- ^Specks of frost form on (\w+) as \w+ shivers with fear\.$

-- Claus and Agoraphobia
-- ^(\w+) shivers and sweats, \w+ pupils wildly dilated with fear\.$

-- Leaving w/ broken leg
-- ^(\w+) slowly hobbles (\w+)\.$

-- Prone from double break
TRIG.register("symptom_fallen_1", "regex", [[^(\w+)\'s broken legs cause \w+ to fall to the ground in a heap]], function() TRACK.taff(matches[2], "FALLEN"); end);
TRIG.register("symptom_fallen_2", "regex", [[^(\w+)\'s wobbles uncertainly before falling to the ground\, (?:.+) leg pulled awkwardly behind (?:.+) own head\.$]], function() TRACK.taffs(matches[2], "FALLEN", "stupidity"); end);
TRIG.register("symptom_fallen_3", "regex", [[^(\w+) is already fallen upon the ground\.$]], function() TRACK.taff(matches[2], "FALLEN"); end, "TARGET_SYMPTOMS", "Prone when I'm trying to do a prone attack.");


-- self_loathing
-- all give worrywart if fear induced.
-- fear builds from weaving
-- Iesid appears lost in thought for a moment.
-- Iesid furrows his brow as he undergoes some inner turmoil.
-- [Overwhelmed by his thoughts, Iesid dramatically flings himself to the ground.

--
--Iesid furrows his brow as he undergoes some inner turmoil.
--

TRIG.register("self_loathing_1", "regex", [[^(\w+) appears lost in thought for a moment\.$]], function() TRACK.taffs(matches[2], "self_loathing"); end);
TRIG.register("self_loathing_2", "regex", [[^(\w+) furrows \w+ brow as \w+ undergoes some inner turmoil\.$]], function() TRACK.taffs(matches[2], "self_loathing"); end);
TRIG.register("self_loathing_3", "regex", [[^Overwhelmed by \w+ thoughts\, (\w+) dramatically flings \w+ to the ground\.$]], function() TRACK.taffs(matches[2], "self_loathing", "FALLEN"); end);

TRIG.register("ablaze_1_4", "regex", [[^Flames leap around (\w+)\, charring .+ flesh\.$]], function() TRACK.tstack(matches[2], "ablaze", 1, 1, 4) end, "SYMPTOMS", "Ablaze if < 5 stacks.");
TRIG.register("ablaze_5_9", "regex", [[^Hot flames leap around (\w+)\, charring .+ flesh\.$]], function() TRACK.tstack(matches[2], "ablaze", 1, 5, 8) end, "SYMPTOMS", "Ablaze if < 9 stacks.");
TRIG.register("ablaze_9_13", "regex", [[^White\-hot flames leap around (\w+)\, charring .+ flesh\.$]], function() TRACK.tstack(matches[2], "ablaze", 1, 9, 12) end, "SYMPTOMS", "Ablaze if < 13 stacks.");
TRIG.register("ablaze_13", "regex", [[^Deadly flames leap around (\w+)\, charring .+ flesh\.$]], function() TRACK.tstack(matches[2], "ablaze", 1, 13, 99) end, "SYMPTOMS", "Ablaze if >= 13 stacks.");

TRIG.register("flames_relic", "regex", [[^Flames lick out at (\w+) from your body and scorch]], function() TRACK.tstack(matches[2], "ablaze", 1) end, "SYMPTOMS", "Extra ablaze stack from flames relic");

local function mania()
    TRACK.stripTDef(matches[2], "rebounding");
    TRACK.taff(matches[2], "mania");
end

TRIG.register("target_symptom_mania_1", "regex", [[^(\w+) beats ineffectually at your chest\.$]], mania, "SYMPTOMS", "");
TRIG.register("target_symptom_mania_2", "regex", [[^Screaming and spitting\, (\w+) claws at your eyes\.$]], mania, "SYMPTOMS", "");
TRIG.register("target_symptom_mania_3", "regex", [[^(\w+) grabs your arm and begins to chew\, drooling all the while\.$]], mania, "SYMPTOMS", "");
TRIG.register("target_symptom_mania_4", "regex", [[^(\w+) pounds .+ fists maniacally on]], mania, "SYMPTOMS", "");
TRIG.register("target_symptom_mania_5", "regex", [[^(\w+) grabs one arm of .+ and attempts to eat it\.$]], mania, "SYMPTOMS", "");
TRIG.register("target_symptom_mania_6", "regex", [[^Screaming and spitting\, (\w+) claws at Nawan's eyes.]], mania, "SYMPTOMS", "");

TRIG.register("target_symptom_vomit_while_asleep", "regex", [[^(\w+) chokes in .+ sleep as .+ vomits into .+ airway\.$]],
    function() TRACK.taffs(matches[2], "vomiting", "asleep"); end);
TRIG.register("target_symptom_vomiting", "regex", [[^(\w+) doubles over\, vomiting violently\.$]],
    function() TRACK.taff(matches[2], "vomiting"); end);

--    Tor cries out in agonized horror, tortured by an unseen curse.
