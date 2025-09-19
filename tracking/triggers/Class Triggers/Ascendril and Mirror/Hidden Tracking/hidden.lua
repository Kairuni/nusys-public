TRIG.register("gorge_pill", "regex", [[^As you go to eat (?:an?|a stack of \d+) (\w+ pill)s?\, you realize you couldn\'t possibly stomach any more of that\.]], function()
    NU.setFlag("gorged_pill", CONVERT.pillLTS[matches[2]], 300);
end, "ASCENDRIL_EFFECTS", "Gorged - prevents eating a specific pill.");
--As you go to eat a decongestant pill, you realize you couldn't possibly stomach any more of that.

