TRIG.register("symptom_self_limb", "start", [[You slowly limp to the]], function()
    local stable = TRACK.getSelf();
    if (not stable.affs.left_leg_crippled and not stable.affs.right_leg_crippled) then
        TRACK.addHidden(stable, "Limp", {"left_leg_crippled", "right_leg_crippled"});
    end
end, "SELF_SYMPTOMS", "When trying to move, limping indicates a broken leg.");
TRIG.register("symptom_self_arm_crippled", "start", [[You slowly make your way]], function()
    local stable = TRACK.getSelf();
    if (not stable.affs.left_leg_crippled and not stable.affs.right_leg_crippled) then
        TRACK.addHidden(stable, "FlyingArm", {"left_arm_crippled", "right_arm_crippled"});
    end
end, "SELF_SYMPTOMS", "When trying to move in the air, indicates a broken arm.");

TRIG.register("symptom_faintness_unconscious", "exact", [[You suddenly feel incredibly faint as the world fades into black.]], function() TRACK.saffs("UNCONSCIOUS"); end);
TRIG.register("symptom_faintness_unconscious_2", "exact", [[Being unconscious, you collapse upon the floor.]],
    function() TRACK.saffs("UNCONSCIOUS"); end);
TRIG.register("symptom_unconsciousness_over", "exact", [[You regain consciousness with a start.]],
    function() TRACK.cure(TRACK.getSelf(), "UNCONSCIOUS"); end);

TRIG.register("stack_count", "regex", [[^Your (\w+) affliction now has (\d+) stacks\.$]], function() TRACK.getSelf().stacks[matches[2]] = tonumber(matches[3]); end, "SELF_SYMPTOMS", "Add to stacks for afflictions.");

