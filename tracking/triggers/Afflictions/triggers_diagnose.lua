-- Eaku is:
-- afflicted with dread.
-- afflicted with infestation.
-- afflicted with blight.
-- afflicted with agoraphobia.
-- Equilibrium Used: 1.25 seconds (1.453488372093)

TRIG.register("start_diagnose", "regex", [[^(\w+) is\:$]], function()
    NU.setPFlag("diagnosing", matches[2]);
    TRACK.resetAffs(TRACK.get(matches[2]));
    TRIG.enable(TRIGS.diag_lines);
    TRIG.enable(TRIGS.diag_eq);

    -- Class hooks
    NU.clearFlag("reclamation_failed");
end);
TRIG.register("diag_lines", "regex", [[^afflicted with (\w+)\.]], function()
    TRACK.taff(PFLAGS.diagnosing, CONVERT.discernmentConversion[matches[2]]);
end);
TRIG.register("diag_eq", "start", [[Equilibrium Used:]], function()
    TRIG.disable(TRIGS.diag_lines);
    TRIG.disable(TRIGS.diag_eq);
end);
TRIG.disable(TRIGS.diag_lines);
TRIG.disable(TRIGS.diag_eq);
