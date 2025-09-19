-- 13.15.2 Hunting Overhaul
--     13.15.1 < Hunting Areas                           Instances > 13.15.3
-- In your adventures, you will start to encounter denizens that act more intelligently than others, drawing from a set of behaviors and actions to make
-- hunting more difficult and interesting.
-- Currently, there are three areas in the game which are being used as a sort of trial for an AI overhaul:
-- Tcanna Island
-- Torturer's Caverns
-- Drakuum
 
-- This help file's primary function is to point out base archetypes, their behaviors, and how they are overcome.
-- Most archetypes are countered easier with certain stats, so specific statpacks might be better suited for hunting different enemies.
-- |-----------------------------------------------------------------------|
-- |Ambusher:   Attacks from hiding      | INT+DEX to counter              |
-- |Berserker:  Enrages at low health    | INT. PACIFY to counter          |
-- |Bloody:     Hurts more when bleeding | Clotting/mana to counter        |
-- |Bruiser:    Can critically hit       | CON to reduce damage            |
-- |Counterer:  Will counterattack       | STR to overpower                |
-- |Defender:   Gains high resistances   | PUSH to remove guard, STR-based |
-- |Devastator: Channels big attacks     | DEX attacks or STR PUSH         |
-- |Healer:     Will try to heal self    | DEX to interrupt                |
-- |Mender      Will try to heal allies  | DEX to interrupt                |
-- |Punisher:   Hates magical shields    | Don't shield                    |
-- |Tricky:     Feigns death             | INT check                       |
-- |Resilient:  Crit immune              | N/A                             |
-- |Stunner:    Stuns                    | CON to reduce chance            |
-- |Wary:       Helps allies             | INT check                       |
-- |-----------------------------------------------------------------------|
-- In addition, these overhauled denizens can be PROBED to see just what behaviors they possess. In this case, we will use a bandit as our example
-- target.
-- Ambusher:   A bandit is looking for a place to hide.
-- Berserker:  A bandit looks like he is ready to snap.
-- Bloody:     A bandit is stained with blood.
-- Bruiser:    A bandit has a critical air about him.
-- Counterer:  A bandit is battle-hardened.
-- Defender:   A bandit is sturdy.
-- Devastator: A bandit appears ready to devastate his foes.
-- Healer:     A bandit is surprisingly vigorous.
-- Mender:     A bandit searches for friends in need.
-- Punisher:   A bandit looks prepared to punish those who trifle with him.
-- Tricky:     A bandit seems like a natural trickster.
-- Resilient:  A bandit is resilient.
-- Stunner:    A bandit moves with stunning force.
-- Wary:       A bandit regards his surroundings warily.
-- The following relics are rare and may drop from the denizens in these areas:
-- Torturers Caverns:
-- - a stiff technique scroll (all classes)
-- - a sad vox iterator
-- - a skeletal minipet cage [a skeletal fish]
-- - a bony pelt (Werecroc)
-- Drakuum:
-- - a ghostly flair
-- - a haunting vox iterator
-- - a ghostly minipet cage [a wandering spirit pup]
-- - a dark pelt (Wereraven)
-- Tcanna Island:
-- - a monkeyish technique scroll (all classes)
-- - a seabreeze vox iterator
-- - an islander minipet cage [a little leopard cub]
-- - an islander pelt (Werewolf, Werebear, Werecroc, Wereraven)
--     13.15.1 < Hunting Areas                           Instances > 13.15.3

-- A box jellyfish braces and prepares to make a counterattack.
-- A box jellyfish lashes out with a sudden counter attack!
-- A box jellyfish ceases preparing to counter.

local function counter()
    NU.setFlag("mob_counterattack", true, 10);
end

local function clearCounter()
    NU.clearFlag("mob_counterattack")
end

TRIG.register("bashing_counterattacking", "substr", [[braces and prepares to make a counterattack.]], counter, "BASHING");
TRIG.register("bashing_counterattacked", "substr", [[lashes out with a sudden counter attack!]], clearCounter, "BASHING");
TRIG.register("bashing_counter_stopped", "substr", [[ceases preparing to counter.]], clearCounter, "BASHING");
TRIG.register("bashing_counter_broke", "regex", [[^You knock .+ out of .+ countering preparation with raw power!]], clearCounter, "BASHING");
TRIG.register("bashing_hit_shield", "start", [[A dizzying beam of energy strikes you as your attack rebounds off of]], function() NU.setFlag("mob_shield", true, 1); end);

-- A black bear readies to deliver a devastating blow!
-- A black bear continues preparing to unleash a devastating blow.
-- A black bear is interrupted from its devastating attack.