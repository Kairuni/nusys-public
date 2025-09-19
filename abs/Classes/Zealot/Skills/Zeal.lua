-- TODO: Add Direblow, Heelrush, 65 bleed for Rive, fix Dislocate for left/right arm target, fix whipburst for Flame empowerment.
local aGA = AB.addGenericAbility;
local function dmgConv(eh, em, sh, sm) return {eH = eh, eM = em, sH = sh, sM = sm}; end

aGA("Zeal", "Mindset", {ep = -10, noshield = false,
    bal = {["cost"] = 1, ["bal"] = "balance"}, arms = 2,
    syntax = {["zealot"] = "mindset $empowerment", ["ravager"] = "attitude $empowerment"},
    postEffects = function(_, _, data) NU.appendFlag("misc_defs", "mindset_" .. data.empowerments[1], true); end});
aGA("Zeal", "Haste", {ep = -30, defs = {"haste"}, noshield = true, bal = {["cost"] = 0, ["bal"] = "balance"}, arms = 2, syntax = {["zealot"] = "haste $empowerment", ["ravager"] = "velocity $empowerment"}});
aGA("Zeal", "Wrath", {ep = -26, defs = {"wrath"}, noshield = true, arms = 0, syntax = {["zealot"] = "wrath $empowerment", ["ravager"] = "predation $empowerment"}, cooldown = 30});
aGA("Zeal", "Disunion", {ep = -136, defs = {"disunion"}, noshield = false, bal = {["cost"] = 1, ["bal"] = "balance"}, arms = 2, syntax = {["zealot"] = "disunion", ["ravager"] = "exhilarate"}});
aGA("Zeal", "Swagger", {cures = {"paresis"}, selfAffs = {"sapped_strength"}, defs = {"swagger"}, noshield = false, arms = 2, syntax = {["zealot"] = "swagger", ["ravager"] = "contempt"}, ep = -50});
aGA("Zeal", "Respiration", {ep = -98, noshield = false, bal = {["cost"] = 2.5, ["bal"] = "balance"}, arms = 2, syntax = {["zealot"] = "respiration $empowerment", ["ravager"] = "seethe $empowerment"}});
aGA("Zeal", "Rebuke", {ep = -166, defs = {"rebuke"}, noshield = false, cooldown = 10, arms = 2, syntax = {["zealot"] = "rebuke $limb", ["ravager"] = "bait $limb"}});
aGA("Zeal", "Litheness", {ep = -26, defs = {"litheness"}, noshield = false, arms = 2, syntax = {["zealot"] = "litheness $empowerment", ["ravager"] = "reflexes $empowerment"}});


-- TODO: Make all of these onUseEffects rather than have the wounds/damage on combat message?
aGA("Zeal", "Pummel", {attackType = "punch", dmg = dmgConv(0.137, 0, 0, 0), dmgType = "blunt", ep = -36, noshield = false, bal = {["cost"] = 3, ["bal"] = "balance"}, arms = 2, limbs = {["damage"] = 9.5, ["targetable"] = true}, syntax = {["zealot"] = "pummel $target $limb", ["ravager"] = "bully $target $limb"}});
aGA("Zeal", "Palmforce",
    { attackType = "punch", dmg = dmgConv(0.101, 0, 0, 0), dmgType = "blunt", ep = -26, noshield = false, bal = { ["cost"] = 2.8, ["bal"] = "balance" }, arms = 2, syntax = { ["zealot"] = "palmforce $target $empowerment", ["ravager"] = "clobber $target $empowerment" } });
aGA("Zeal", "Clawtwist", {attackType = "punch", dmg = dmgConv(0.1315, 0, 0, 0), dmgType = "blunt", ep = 31, noshield = false, bal = {["cost"] = 3.1, ["bal"] = "balance"}, arms = 2, limbs = {["set"] = {["torso"] = 8.5}, ["targetable"] = false}, syntax = {["zealot"] = "clawtwist $target", ["ravager"] = "plexus $target"}});
aGA("Zeal", "Dislocate", {
    affs = function(_, _, data) return {data.limb:gsub(" ", "_") .. "_dislocated"}; end,
    noshield = false, bal = {["cost"] = 3.1, ["bal"] = "balance"}, arms = 2, syntax = {["zealot"] = "dislocate $target $limb", ["ravager"] = "bustup $target $limb"}, ep = -20,
    onUseEffects = function(_, ttable, data) NU.setPFlag("dislocate_firing", {ttable = ttable, aff = data.limb:gsub(" ", "_") .. "_dislocated"}); end
});
aGA("Zeal", "Twinpress", {affs = {"muscle_spasms", "stiffness"}, noshield = false, bal = {["cost"] = 2.8, ["bal"] = "balance"}, arms = 2, syntax = {["zealot"] = "twinpress $target", ["ravager"] = "pressure $target"}, ep = -15});
aGA("Zeal", "Direblow", {attackType = "punch",
    bal = {["cost"] = 3.0, ["bal"] = "balance"},
    syntax = {zealot = "direblow $target", ravager = "haymaker $target"},
    onUseEffects = function(st, tt, data) NU.setFlag(st.name .. "_channeling", "direblow", 3) end,
})

aGA("Zeal", "Wanekick", {dmg = dmgConv(0.119, 0, 0, 0), dmgType = "blunt", ep = -15, noshield = false, bal = {["cost"] = 2.8, ["bal"] = "balance"}, legs = 2, limbs = {["damage"] = 9, ["targetable"] = true}, syntax = {["zealot"] = "wanekick $target $limb", ["ravager"] = "kneecap $target $limb"}});
aGA("Zeal", "Sunkick", {dmg = dmgConv(0.1195041322314, 0, 0, 0), dmgType = "blunt", affs = {"stupidity", "dizziness"}, limbs = {["set"] = {["head"] = 6}, ["targetable"] = false}, noShield = false, bal = {["cost"] = 3.1, ["bal"] = "balance"}, legs = 2, syntax = {["zealot"] = "sunkick $target", ["ravager"] = "concuss $target"}, ep = -20});
aGA("Zeal", "Edgekick", {dmg = dmgConv(0.10859504132231, 0, 0, 0), dmgType = "blunt", affs = {"crippled_throat"}, limbs = {["set"] = {["head"] = 3.5}, ["targetable"] = false}, noShield = false, bal = {["cost"] = 2.7, ["bal"] = "balance"}, legs = 2, syntax = {["zealot"] = "edgekick $target", ["ravager"] = "windipe $target"}, ep = -15});
aGA("Zeal", "Heelrush", {dmg = dmgConv(0.04, 0, 0, 0), dmgType = "blunt", ep = -36, noshield = false, bal = {["cost"] = 3.3, ["bal"] = "balance"},
        legs = 2,
        onUseEffects = function(attacker, target, data)
            NU.setPFlag("pending_limb_hit", {
                target = target,
                loc = data.limb,
                dmg = 5.5
            });
            NU.setFlag(attacker.name .. "_heelrushing", data.limb, 6);
        end,
        syntax = { ["zealot"] = "heelrush $target $limb", ["ravager"] = "overpower $target $limb" }
    });

aGA("Zeal", "Anklepin", {dmg = dmgConv(0.073, 0, 0, 0), dmgType = "blunt", affs = {"sore_ankle"},
    noshield = false, bal = {["cost"] = 2.9, ["bal"] = "balance"}, arms = 1, syntax = {["zealot"] = "anklepin $target", ["ravager"] = "hobble $target"}, ep = -11});
aGA("Zeal", "Jawcrack", {dmg = dmgConv(0.073057851239669, 0, 0, 0), dmgType = "blunt", affs = {"stuttering", "blurry_vision"},
    noshield = false, bal = {["cost"] = 2.9, ["bal"] = "balance"}, arms = 1, syntax = {["zealot"] = "jawcrack $target", ["ravager"] = "slug $target"}, ep = -5});
aGA("Zeal", "Descent", {dmg = dmgConv(0.073057851239669, 0, 0, 0), dmgType = "blunt", affs = {"backstrain"},
    noshield = false, bal = {["cost"] = 2.8, ["bal"] = "balance"}, arms = 1, syntax = {["zealot"] = "descent $target", ["ravager"] = "flog $target"}, ep = -5});
aGA("Zeal", "Wristlash", {dmg = dmgConv(0.073057851239669, 0, 0, 0), dmgType = "blunt", affs = {"sore_wrist"},
    noshield = false, bal = {["cost"] = 3, ["bal"] = "balance"}, arms = 1, syntax = {["zealot"] = "wristlash $target", ["ravager"] = "maim $target"}, ep = 11});
aGA("Zeal", "Rive", {dmg = dmgConv(0.073057851239669, 0, 0, 0), dmgType = "blunt", ep = 11, noshield = false, bal = {["cost"] = 3.2, ["bal"] = "balance"}, arms = 1, syntax = {["zealot"] = "rive $target", ["ravager"] = "butcher $target"}});
aGA("Zeal", "Uprise", {dmg = dmgConv(0.073057851239669, 0, 0, 0), dmgType = "blunt", affs = {"whiplash"},
    noshield = false, bal = {["cost"] = 3, ["bal"] = "balance"}, arms = 1, syntax = {["zealot"] = "uprise $target", ["ravager"] = "whiplash $target"}, ep = -5});
aGA("Zeal", "Whipburst", {dmg = dmgConv(0.034545454545455, 0, 0, 0), dmgType = "fire", ep = -5, noshield = false, arms = 1, syntax = {["zealot"] = "whipburst $target", ["ravager"] = "tenderise $target"}});


-- MUST BE PRONE from someone else.
aGA("Zeal", "Risekick", {
    dmgConv(0.13917355371901, 0, 0, 0),
    dmgType = "blunt",
    ep = -15,
    reqs = function(attacker, target, data) return attacker.affs.FALLEN and AB.genericRequirements(attacker, target, 0, false, false, true, false, false, 2); end,
    bal = {["cost"] = 2.8, ["bal"] = "balance"},
    limbs = {["set"] = {["torso"] = 5}, ["targetable"] = false},
    syntax = {["zealot"] = "risekick $limb", ["ravager"] = "rebound $limb"}
});


aGA("Zeal", "Flow", {
    bal = {["cost"] = 3, ["bal"] = "balance"},
    syntax = {zealot = "flow $target $empowerment1 $empowerment2", ravager = "onslaught $target $empowerment1 $empowerment2"},

    reqs = function(attacker, target, data)
        local first = data.ab1;
        local second = data.ab2;

        if (first and second) then
            return first.meetsPreReqs(attacker, target, data) and second.meetsPreReqs(attacker, target, data);
        else
            return AB.genericRequirements(attacker, target, 1, false, false, false, false, false, 2);
        end
    end

});

aGA("Zeal", "Hackles", {
    bal = {["cost"] = 6.5, ["bal"] = "ability_bal"},
    syntax = {zealot = "hackles $target $empowerment", ravager = "assail $target $empowerment"},

    reqs = function(attacker, target, data)
        local ab = data.ab;
        if (ab) then
            return ab.meetsPreReqs(attacker, target, data);
        else
            return AB.genericRequirements(attacker, target, 1, false, false, false, false, false, 0);
        end
    end
});

aGA("Zeal", "Blitz", {dmg = dmgConv(0.119, 0, 0, 0), dmgType = "blunt", ep = -15, noshield = false, bal = {["cost"] = 4, ["bal"] = "balance"}, legs = 2, syntax = {["zealot"] = "blitz", ["ravager"] = "rampage"}});
