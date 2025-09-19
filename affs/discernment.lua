AFFS.discernment = {
    ["a crippled right leg"] = "right_leg_crippled",
    ["a crippled right arm"] = "right_arm_crippled",
    ["a crippled left leg"] = "left_leg_crippled",
    ["a crippled left arm"] = "left_arm_crippled",
    lovers = "infatua",
    scytherus = "dyscrasia",
    ["heart flutter"] = "arrhythmia",
    ["limp veins"] = "asthma",
    ["self pity"] = "self_pity",
}

local discernMetaTable = {
    __index = function(t, k)
        return k:gsub(" ", "_");
    end
}

setmetatable(AFFS.discernment, discernMetaTable);