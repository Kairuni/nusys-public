-- Apply venom, ignore rebounding?
-- ^It slices straight through (\w+) and sinks into the ground, stained red\.$

-- Post hit effects:
-- The attack rebounds back onto you!
-- This combat message is a special case, basically just stops venoms from self hitting (but also means no venoms hit)
-- ^(\w+) uses Battlefury Mastery Rebound\.$

-- Misses
-- ^Stepping quickly out of the way\, (\w+) dodges the attack\.$
-- ^(\w+) parries the attack on \w+ (?:left arm|right arm|left leg|right leg|torso|head) with a deft maneuver\.$
-- ^You strike clumsily at (\w+)\, completely missing \w+ with
-- ^Tears blur your vision as you attempt to strike (\w+) with
local function onMiss(source, color)
    color = color or "red";
    return function()
        creplaceLine("<" .. color .. "><<<< " .. source .. " >>>>");
        NU.clearPFlag("attack_to_apply");
    end
end

local onDodge = onMiss("DODGED", "orange");
local onBlurry = onMiss("BLURRY MISS", "coral");
local onClumsy = onMiss("CLUMSY MISS", "peru");
local onReflect = onMiss("REFLECTION", "ansi_cyan");


TRIG.register("miss_blurry_1", "start", [[Your vision blurs as you strike at]], onBlurry);
TRIG.register("miss_blurry_2", "start", [[Tears blur your vision as you attempt to strike]], onBlurry);
TRIG.register("miss_blurry_3", "start", [[Your blurry vision inhibits your accuracy]], onBlurry);
TRIG.register("miss_clumsy_1", "start", [[You strike clumsily at]], onClumsy);
TRIG.register("miss_clumsy_2", "start", [[You strike out clumsily and miss your mark.]], onClumsy);
TRIG.register("miss_dodge_1", "start", [[Stepping quickly out of the way,]], onDodge);
TRIG.register("miss_dodge_2", "substr", [[dodging the attack.]], onDodge);
TRIG.register("miss_dodge_3", "substr", [[dodges the attack.]], onDodge);
TRIG.register("miss_reflection", "regex", [[^A reflection of (\w+) blinks out of existence\.$]], onReflect);

-- Discernment for venoms
-- The attack rebounds back onto you!
TRIG.register("hit_rebounding", "exact", [[The attack rebounds back onto you!]], function() TRACK.checkWithIllusion(function() TRACK.get(NU.target).defs.rebounding = true; NU.clearPFlag("attack_to_apply"); NU.setPFlag("venom_target", TRACK.getSelf()); end) end);
TRIG.register("venom_discernment", "regex", [[^You discern that a layer of (\w+) has rubbed off your weapon\.$]], function() TRACK.checkWithIllusion(function() if (not PFLAGS.venom_target) then NU.DECHO("NO VENOM TARGET SET!", 7); else local aff = CONVERT.empowermentToAff [matches[2]:lower()]; display(matches[2]); TRACK.aff(PFLAGS.venom_target, aff); end end) end);


-- Cleanse venoms
-- ^You run a hand along .*\, cleansing all effects from it\.$
