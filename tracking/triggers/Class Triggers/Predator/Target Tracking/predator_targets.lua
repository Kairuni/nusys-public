TRIG.register("predator_fleshbane_fester", "regex", [[^The (\w+) slices on (\w+) fester, interfering with the restoration]], function() TRACK.checkWithIllusion(function() NU.setFlag(matches[3]:lower() .. "_fleshbaned", CONVERT.numberToInt[matches[2]], 4); end); end);
TRIG.register("predator_fleshbane_ending", "regex", [[^(\w+)\'s wounds cease to weep foul looking fluids\.$]], function() TRACK.nameCure(matches[2], "fleshbane") end);

-- Reduces Gherond limb  resto by 2 * count
-- Your precision strike causes confusion in Gherond. - flashkick confusion
