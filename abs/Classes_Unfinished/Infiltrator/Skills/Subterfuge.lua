AB["Subterfuge"] = AB["Subterfuge"] or {};

AB["Subterfuge"]["Bedazzle"] = {
    getTargetAffs = function(attacker, target, data)
        return nil, {"vomiting", "stuttering", "blurry_vision", "dizziness", "weariness", "laxity"}, 2;
    end,

    meetsPreReqs = function(attacker, target, data)
        return (not attacker.affs.left_arm_crippled and not attacker.affs.right_arm_crippled) and not attacker.affs.FALLEN and not attacker.affs.asleep and not target.defs.shielded and not target.defs.barrier and not target.defs.manipulation_aegis;
    end,
}