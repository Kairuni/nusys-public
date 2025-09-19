CONVERT = {};

CONVERT.pillLTS = {
    ["antipsychotic pill"] = "antipsychotic",
    ["pill of amaurosis"] = "amaurosis",
    ["steroid pill"] = "steroid",
    ["opiate pill"] = "opiate",
    ["kawhe pill"] = "kawhe",
    ["pill of acuity"] = "acuity", -- Does not consume pill balance
    ["coagulation pill"] = "coagulation",
    ["euphoriant pill"] = "euphoriant",
    ["eucrasia pill"] = "eucrasia",
    ["ototoxin pill"] = "ototoxin",
    ["decongestant pill"] = "decongestant",
    ["stimulant pill"] = "stimulant", -- Does not consume pill balance
    ["depressant pill"] = "depressant",
    ["anabiotic pill"] = "anabiotic", -- Consumes anabiotic balance
    ["somnium pill"] = "somnium",
    ["pill of waterbreathing"] = "waterbreathing",
    ["thanatonin pill"] = "thanatonin", -- Does not consume pill balance
    ["hardening paste"] = "paste",

    ["yarrow root"] = "yarrow",
    ["willow bark"] = "willow",
    ["reishi mushroom"] = "reishi",
    ["panacea pill"] = "panacea",
}

CONVERT.empowermentToAff    = {
    xentio = "clumsiness",
    eurypteria = "recklessness",
    kalmia = "asthma",
    digitalis = "shyness",
    darkshade = "allergies",
    curare = "paresis",
    epteth = "left_right_arm_crippled",
    epseth = "left_right_leg_crippled",
    prefarar = "sensi_level",
    monkshood = "disloyalty",
    euphorbia = "vomiting",
    oculus = "no_blindness",
    hepafarin = "haemophilia",
    vernalius = "weariness",
    larkspur = "dizziness",
    slike = "anorexia",
    delphinium = "sleep_level",
    loki = "any_venom",
    aconite = "stupidity",
    gecko = "slickness",
    scytherus = "dyscrasia",
    ouabain = "peace",
    voyria = "voyria",
    sumac = "damage",
    camus = "damage",
    selarnia = "squelched",
    jalk = "stuttering",
    vardrax = "deadening",
    euryptera = "recklessness",
}

CONVERT.affToEmpowerment = {};
for k,v in pairs(CONVERT.empowermentToAff ) do
    CONVERT.affToEmpowerment[v] = k;
end
CONVERT.affToEmpowerment["no_deafness"] = "prefarar";

CONVERT.discernmentConversion = {
    ["crippled right leg"] = "right_leg_crippled",
    ["crippled right arm"] = "right_arm_crippled",
    ["crippled left leg"] = "left_leg_crippled",
    ["crippled left arm"] = "left_arm_crippled",
    lovers = "infatua",
    scytherus = "dyscrasia",
    ["heart flutter"] = "arrhythmia",
    ["limp veins"] = "hypotension",
    ["self pity"] = "self_pity",
    ["thin blood"] = "dyscrasia",
}

local discernMetaTable = {
    __index = function(t, k)
        return k:gsub(" ", "_");
    end
}

setmetatable(CONVERT.discernmentConversion, discernMetaTable);

CONVERT.numberToInt = {
    ["one"] = 1,
    ["two"] = 2,
    ["three"] = 3,
    ["four"] = 4,
    ["five"] = 5,
    ["six"] = 6,
    ["seven"] = 7,
    ["eight"] = 8,
    ["nine"] = 9,
    ["ten"] = 10,
    ["eleven"] = 11,
    ["twelve"] = 12,
    ["thirteen"] = 13,
    ["fourteen"] = 14,
    ["fifteen"] = 15,
    ["sixteen"] = 16,
    ["seventeen"] = 17,
    ["eighteen"] = 18,
    ["nineteen"] = 19,
    ["twenty"] = 20,
    ["twenty-one"] = 21,
    ["twenty-two"] = 22,
    ["twenty-three"] = 23,
    ["twenty-four"] = 24,
    ["twenty-five"] = 25,
    ["twenty-six"] = 26,
    ["twenty-seven"] = 27,
    ["twenty-eight"] = 28,
    ["twenty-nine"] = 29,
    ["thirty"] = 30,
    ["thirty-one"] = 31,
    ["thirty-two"] = 32,
    ["thirty-three"] = 33,
    ["thirty-four"] = 34,
    ["thirty-five"] = 35,
    ["thirty-six"] = 36,
    ["thirty-seven"] = 37,
    ["thirty-eight"] = 38,
    ["thirty-nine"] = 39,
    ["forty"] = 40,
    ["forty-one"] = 41,
    ["forty-two"] = 42,
    ["forty-three"] = 43,
    ["forty-four"] = 44,
    ["forty-five"] = 45,
    ["forty-six"] = 46,
    ["forty-seven"] = 47,
    ["forty-eight"] = 48,
    ["forty-nine"] = 49,
    ["fifty"] = 50,
}