local lokiAffList = {
    "clumsiness",
    "recklessness",
    "asthma",
    "shyness",
    "allergies",
    "paresis",
    "left_arm_crippled",
    "right_arm_crippled",
    "left_leg_crippled",
    "right_leg_crippled",
    "no_deafness",
    "sensitivity",
    "disloyalty",
    "vomiting",
    "no_blindness",
    "haemophilia",
    "stuttering",
    "weariness",
    "dizziness",
    "anorexia",
    "slickness",
    "voyria",
    "no_insomnia",
    "deadening",
    "stupidity",
    "squelched",
    "dyscrasia",
    "peace",
}

local function hitByLoki()
    if (PFLAGS.illusion) then return; end

    NU.setPFlag("expected_hiddens", {source = "loki", affList = lokiAffList, expectedCount = 1});
    --TRACK.addHidden(TRACK.getSelf(), "loki", lokiAffList);
end

TRIG.register("loki", "exact", [[You are confused as to the effects of the venom.]], hitByLoki);
--^(\w+) uses \w+ Fitness\.$ -- Asthma lockbreak
