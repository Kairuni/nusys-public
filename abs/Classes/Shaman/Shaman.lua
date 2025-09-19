AB["Primality"] = AB["Primality"] or {};

local shamanMentalsList = {};
for k,v in pairs(AFFS.mentals) do
    if (k ~= "mirroring" and k ~= "dread" and k ~= "delirium") then
        table.insert(shamanMentalsList, k);
    end
end

AB["Primality"]["Staticburst Boosted"] = {
    getTargetAffs = function(attacker, target, data)
        return {}, shamanMentalsList, 1;
    end,

    meetsPreReqs = function(attacker, target, data)
        return (not attacker.affs.left_arm_crippled or not attacker.affs.right_arm_crippled) and not attacker.affs.FALLEN and not attacker.affs.asleep and not target.defs.shielded and not target.defs.barrier and not target.defs.manipulation_aegis;
    end,
}