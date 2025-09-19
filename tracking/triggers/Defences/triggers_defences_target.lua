-- Fangbarrier Strip
-- ^An undead \w+\'s throat bulges outward, distending as a gout of acrid bile streams onto (\w+)\.$
-- ^You use Assassination Flay \(fangbarrier\) on (\w+)\.$

-- Rebounding up
-- 
TRIG.register("target_rejection_up", "regex", [[^(\w+) focuses \w+ spirit, forming an aura around \w+ that rejects all weapons\.$]], function() TRACK.addDef(TRACK.get(matches[2]), "rebounding"); end);
TRIG.register("target_rebounding_up", "regex", [[^You suddenly perceive the vague outline of an aura of rebounding around (\w+)\.$]], function() TRACK.addDef(TRACK.get(matches[2]), "rebounding"); end);

-- Rebounding strips
-- ^\w+ eyes cloudy and limbs stiff, (\w+) strides in with a smile\.$
-- ^Sand coalesces before \w+ into the form of a blade, and with an indifferent snap of the fingers, \w+ sends it to slice (\w+)\'s rebounding defence\.$ -- TODO: Check combat message for sand slice? ^You use Desiccation Slice on (\w+)\.$
-- ^The stones rip apart (\w+)\'s rebounding defence\.$
-- ^Sand coalesces before you into the form of a blade, and with an indifferent snap of the fingers, you send it to slice (\w+)\'s rebounding defence\.$ -- TODO: Same as above.
-- ^\w+ uses? Terramancy Stoneblast on (\w+)\.$ -- Todo: Combat message.
-- ^With an indifferent snap, you slice apart (\w+)\'s rebounding defence\.$
-- ^With a snap from \w+, (\w+)\'s rebounding defence is sliced apart\.$

-- Self removal
-- ^(\w+)\'s aura of weapons rebounding disappears\.$

-- Shields TODO: Combat meesages, as usual
-- ^\w+ uses? Naturalism Barrier on (\w+)\.$
-- ^The dewdrops evaporate into tiny motes of energy that cohere around (\w+) in a translucent shield\.$
-- ^(\w+) uses Spirituality Aura\.$
-- Tattoos Shield
--*** Illikaal: Tattoos - Shield ***
TRIG.register("target_shield_rebound", "regex", [[^A dizzying beam of energy strikes you as your attack rebounds off of (\w+)\'s shield\.$]], function() TRACK.checkWithIllusion(function() TRACK.addDef(TRACK.get(matches[2]), "shielded") end) end)
TRIG.register("target_shield_cannot_attack", "regex", [[^You are prevented from doing that by the magical shield around (\w+)\.$]], function() TRACK.checkWithIllusion(function() TRACK.addDef(TRACK.get(matches[2]), "shielded") end) end)
TRIG.register("target_rebounding_strip", "regex", [[^(\w+)\'s aura of weapons rebounding disappears\.$]], function() TRACK.removeDef(TRACK.get(matches[2]), "rebounding"); end, "TARGET_TRACKING", "Rebounding stripped.");

-- Shield strips TODO: Strip combat meesages
TRIG.register("no_shield_target", "regex", [[^You touch your tattoo and summon the hammer but (\w+) isn\'t protected\.$]], function() TRACK.removeDef(TRACK.get(matches[2]), "shielded"); end);
--You touch your tattoo and summon the hammer but Kagura isn't protected.
-- ^The protective shield around (\w+) dissipates\.$

-- ^\w+ uses? Tenacity Devastate on (\w+)\.$
-- ^\w+ uses? Savagery Raze \(shield\) on (\w+)\.$
-- ^The stones rip apart (\w+)\'s shielded defence\.$
-- ^.+ uses Animation Shatter on (\w+)\.$
-- ^\w+ uses? Terramancy Stoneblast on (\w+)\.$
-- ^You use Sciomancy Shadowprice Hew on (\w+)\.$
-- ^\w+ uses? Sciomancy Hew on (\w+)\.$
-- ^\w+ uses Corpus Frenzy \(sunder\) on (\w+)\.$
-- ^You use Sciomancy Hew \(fail\) on (\w+)\.$
-- ^You use Sciomancy Shadowprice Hew \(fail\) on (\w+)\.$