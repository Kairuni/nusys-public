local aGA = AB.addGenericAbility;

AB["Dictum"] = AB["Dictum"] or {};

-- Blood Curse dictate needs some updates.
-- AB["Dictum"]["Dictate"] = {
--     getTargetAffs = function(attacker, target, data)
--         return nil, {"confusion", "fear", "impatience", "paranoia", "stupidity", "agoraphobia", "masochism", "infatua", "seduction", "epilepsy", "anorexia", "amnesia", "peace", "dementia", "mania", "indifference", "vertigo", "temptation", "recklessness"}, 2;
--     end,

--     meetsPreReqs = function(attacker, target, data)
--         return not attacker.affs.asleep and not target.defs.shielded and not target.defs.barrier and not target.defs.manipulation_aegis;
--     end,
-- }

aGA("Dictum", "Disrupt", {
    ep = 0, wp = 50,
    dmgType = "unblockable",
    bal = {bal = "equilibrium", cost = 3},
    affs = function(stable, ttable, data)
        if (data.empowerments and data.empowerments[1] == "failure") then
            return {};
        end
        return {"disrupted"};
    end,
    arms = 0, legs = 1, reqs = nil,
    syntax = {akkari = "disrupt $target", praenomen = "disrupt $target"}
})

aGA("Dictum", "Tithe", {
    dmg = {eH = 0, eM = 0.10, sH = 0, sM = 0},
    ep = 0, wp = 20,
    bal = {bal = "equilibrium", cost = 2.5},
    arms = 1, legs = 0,
    syntax = {akkari = "tithe $target", praenomen = "siphon $target"}
})

aGA("Dictum", "Exhort", {
    wp = 50,
    bal = {bal = "equilibrium", cost = 3},
    affs = function(stable, ttable, data)
        if (data.empowerments and data.empowerments[1] ~= "unblind") then
            return {"writhe_transfix"};
        end
        return {};
    end,
    onUseEffects = function(stable, ttable, data) 
        if (data.empowerments and data.empowerments[1] == "unblind") then
            TRACK.stripDef(ttable, "blindness");
        end
    end, -- any effect when ab is used, even if unsuccessful
    arms = 0, legs = 0,
    syntax = {akkari = "exhort $target", praenomen = "mesmerize $target"}
})

aGA("Dictum", "Dictate", {
    ep = 0, wp = 10,
    bal = {bal = "equilibrium", cost = 3.76},
    reqs = function(st, tt) return not st.affs.FALLEN and not st.affs.stupidity; end,
    syntax = {akkari = "dictate $aff1 $aff2 $target", praenomen = "whisper $aff1 $aff2 $target"}
})

aGA("Dictum", "Dictate_Single", {
    ep = 0, wp = 10,
    bal = {bal = "equilibrium", cost = 3.76},
    reqs = function(st, tt) return not st.affs.FALLEN and not st.affs.stupidity; end,
    syntax = {akkari = "dictate $aff1 $target", praenomen = "whisper $aff1 $target"}
})


aGA("Dictum", "Telesense", {
    bal = {bal = "equilibrium", cost = 0},
    defs = {"telesense"},
    noShield = true, arms = 2, legs = 0,
    defensive = true,
    syntax = {akkari = "telesense on", praenomen = "telesense on"}
})

aGA("Dictum", "Disturbance", {
    ep = 0, wp = 30,
    bal = {bal = "equilibrium", cost = 3},
    arms = 0, legs = 0,
    syntax = {akkari = "dictate disturbance $mount", praenomen = "whisper panic $mount"}
})

aGA("Dictum", "Proclamation", {
    ep = 0, wp = 10,
    bal = {bal = "equilibrium", cost = 3.75},
    arms = 0, legs = 1,
    syntax = {akkari = "proclamation $aff1 $aff2", praenomen = "trill $aff1 $aff2"}
})

aGA("Dictum", "Dumavai", {
    dmg = {eH = 0, eM = 0, sH = 0, sM = 100},
    ep = 0, wp = 50,
    bal = {bal = "equilibrium", cost = 4.4},
    arms = 0, legs = 0,
    syntax = {akkari = "dumavai $target", praenomen = "annihilate $target"}
})

local function addDictate(akkariName, mentisNameIfDifferent, affOverride)
    aGA("Dictum", akkariName:title(), {
        affs = function(stable, ttable, data) return {affOverride or akkariName}; end,
        syntax = {akkari = akkariName, praenomen = akkariName or mentisNameIfDifferent}
    })
end

addDictate("confusion");
addDictate("fear");
addDictate("impatience");
addDictate("paranoia");
addDictate("stupidity");
addDictate("agoraphobia");
addDictate("masochism");
addDictate("lovers", nil, "infatua");
addDictate("remorse", "seduction");
addDictate("epilepsy");
addDictate("anorexia");
addDictate("amnesia");
addDictate("peace");
addDictate("dementia");
addDictate("mania");
addDictate("indifference");
addDictate("vertigo");
addDictate("contrition", "temptation");
addDictate("recklessness");
