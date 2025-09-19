local aGA = AB.addGenericAbility;
local function dmgConv(eh, em, sh, sm) return { eH = eh, eM = em, sH = sh, sM = sm }; end
local function astranomiaReqs(ignoreShield, cooldown, other)
    ignoreShield = ignoreShield or false;
    return function(st, tt, data)
        return AB.genericRequirements(st, tt, (st.defs.centrum or (data and data.centrum)) and 1 or 2, false, nil, false,
                ignoreShield, cooldown, 0) and st.defs.luminesce and
            (other and other(st, tt, data) or true); -- and ROOM_STATUS.VIBES.ELIADON[vibration]
    end
end

-- TODO: Weapon arm needs to not be broken.
aGA("Astranomia", "Ray",
    {
        dmg = dmgConv(0.3, 0.0, 0.0, 50),
        dmgType = "magic",
        wp = 30,
        reqs = astranomiaReqs(),
        bal = { cost = 4.0, bal = "equilibrium" },
        syntax = { siderealist = "astra ray $target" }
    });


-- *** ASTRANOMIA - ALTERATION (from paralysis): Gherond *** UNTRACKED
-- Gherond sinks into themself as the slough affliction lays claim.
-- Capture the from paralysis to cure it.

aGA("Astranomia", "Alteration",
    {
        dmg = dmgConv(0, 0.0, 0.0, 100),
        wp = 20,
        reqs = astranomiaReqs(),
        onUseEffects = function(st, tt, data)
            if (data.empowerments) then
                local aff = data.empowerments[1]:gsub("from ", "");
                TRACK.cure(tt, CONVERT.discernmentConversion[aff]);
            end
        end,
        bal = { cost = 3.0, bal = "equilibrium" },
        cooldown = 10,
        syntax = { siderealist = "astra alteration $target $cure into $aff" }
    });

aGA("Astranomia", "Luminesce", {
    bal = { cost = 2.0, bal = "equilibrium" },
    defs = { "luminesce" },
    syntax = { siderealist = "astra luminesce" }
});
aGA("Astranomia", "Gleam", {
    bal = { cost = 2.0, bal = "equilibrium" },
    defs = { "gleam" },
    reqs = astranomiaReqs(),
    syntax = { siderealist = "astra gleam on" }
});
aGA("Astranomia", "Blueshift", {
    bal = { cost = 2.0, bal = "equilibrium" },
    defs = { "blueshift" },
    reqs = astranomiaReqs(),
    syntax = { siderealist = "astra blueshift" }
});

aGA("Astranomia", "Centrum", {
    bal = { cost = 0.0, bal = "equilibrium" },
    defs = { "centrum" },
    syntax = { siderealist = "astra centrum" }
});

local gleamOptions = {
    burning = "recklessness",
    crushing = "gnawing",
    radiant = "dizziness",
    noxious = "clumsiness",
    frigid = "mindfog",
    temporal = "paresis",
    twisted = "paranoia",
}

local gleamStars = {
    burning = "red",
    crushing = "orange",
    radiant = "yellow",
    noxious = "green",
    frigid = "blue",
    temporal = "indigo",
    twisted = "violet"
}

aGA("Astranomia", "Gleam Inflict",
    {
        affs = function(st, tt, data)
            if (data.empowerments) then
                local aff = gleamOptions[data.empowerments[1]];
                return { aff };
            end
            return {};
        end,
        dmg = dmgConv(0, 0.0, 0.0, 150),
        wp = 20,
        arms = 1,
        bal = { cost = 2.4, bal = "equilibrium" },
        onUseEffects = function(st, tt, data) NU.cooldown(st.name .. "_inflict_" .. gleamStars[data.empowerments[1]], 13); end,
        syntax = { siderealist = "astra inflict $target $color" }
    });

aGA("Astranomia", "Chromaflare", {
        dmg = dmgConv(0, 0.0, 0.0, 860),
        wp = 20,
        arms = 1,
        bal = { cost = 3.0, bal = "equilibrium" },
        syntax = { siderealist = "astra chromaflare $target" }
});

aGA("Astranomia", "Erode", {
    dmg = dmgConv(0, 0, 0, 75),
    wp = 15,
    bal = { cost = 2.0, bal = "equilibrium" },
    reqs = astranomiaReqs(true),
    syntax = { siderealist = "astra erode $target" },
    onUseEffects = function(st, tt, data)
        NU.setPFlag("asterism_erode_target", tt); TRACK.stripDef(tt, "shielded");
    end,
});

aGA("Astranomia", "Coruscation", {
    dmg = dmgConv(-0.15, 0.0, 0.0, 100),
    wp = 22,
    reqs = astranomiaReqs(),
    bal = { cost = 3.0, bal = "equilibrium" },
    syntax = { siderealist = "astra coruscation" }
});

-- TODO: 4 aff pre-req
aGA("Astranomia", "Asterism", {
    dmg = dmgConv(0, 0, 0, 507),
    wp = 350,
    bal = { cost = 3.0, bal = "equilibrium" },
    reqs = astranomiaReqs(),
    syntax = { siderealist = "astra asterism $target" },
    affs = function(st, tt, data)
        if (#data.empowerments > 0) then
            return {};
        end
        return { "asterism" };
    end,
    onUseEffects = function(st, tt, data)
        if (#data.empowerments > 0) then
            return;
        end

        local activeAffs = {};
        for aff, have in pairs(tt.affs) do
            if (have) then
                activeAffs[aff] = true;
            end
        end
        NU.setFlag(tt.name .. "_asterism", activeAffs, 150, function() TRACK.cure(tt, "asterism"); end);
    end,
})

-- Mana Lost: 335
-- *** ASTRANOMIA - ASTERISM (failure): Gherond *** UNTRACKED
-- Equilibrium Used: 3.44 seconds (4)

aGA("Astranomia", "Absorb", {
    dmg = dmgConv(0, 0, 0, 507),
    wp = 100,
    bal = { cost = 2.0, bal = "equilibrium" },
    syntax = { siderealist = "astra absorb $target" },
    -- No point handling onUseEffects here, no cmsg.
    -- However:
    --     wp: -100
    -- Warning: This is not a Safe PK target.
    -- Mana Lost: 335
    -- Lifting a hand, you pull at the cosmic stream around Gherond, observing a single thought and adding it to your own.
    -- You have replicated 'tide breach gherond' into cosmic energy.
    -- You have gained the replicate defence.
    -- Equilibrium Used: 1.72 seconds (2)
});

AB["Astranomia"]["Parallax"] = {
    getSelfDefs = function(attacker, target, data)
        return { "parallax" };
    end,
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 100;
    end,
    balance = function(attacker, target, data)
        return { self = { bal = "equilibrium", cost = 2, fixed = true }, target = { cost = 0 } }
    end,

    meetsPreReqs = function(attacker, target, data)
        return (not attacker.affs.left_arm_crippled and not attacker.affs.right_arm_crippled and not attacker.affs.left_leg_crippled and not attacker.affs.right_leg_crippled) and
            not attacker.affs.FALLEN and not attacker.affs.asleep;
    end,

    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker) and FLAGS.parallaxing) then
            FLAGS.parallaxing.fire = NU.time() + FLAGS.parallaxing.time;
            NU.setFlag("parallax", FLAGS.parallaxing, FLAGS.parallaxing.time);
            NU.clearFlag("parallaxing");
        end
    end,

    syntax = { siderealist = "astra parallax $time $spell" }
}

AB["Astranomia"]["Parallax Release"] = {
    getRemovedSelfDefs = function(attacker, target, data)
        return { "parallax" };
    end,
    postEffects = function(attacker, target, data)
        if (TRACK.isSelf(attacker)) then
            NU.clearFlag("parallax");
        end
    end,
}

-- wp: -150
-- Bal+: EQUILIBRIUM
-- Mana Lost: 201
-- *** ASTRANOMIA - STILLNESS: Gherond *** UNTRACKED
-- Terror suffuses Gherond as a small moonlet drifts out from behind them.
-- Equilibrium Used: 2.15 seconds (2.5)
-- Linear stack, 2 at a time:

aGA("Astranomia", "Stillness", {
    wp = 150,
    dmg = dmgConv(0, 0, 0, 500),
    dmgType = "psychic",
    bal = { cost = 2.5, bal = "equilibrium" },
    syntax = { siderealist = "astra stillness $target" },
    reqs = astranomiaReqs(),
})

aGA("Astranomia", "Superbolide", {
    dmg = dmgConv(0.2, 0, 0, 1000),
    wp = 500,
    bal = { cost = 6.0, bal = "equilibrium" },
    syntax = { siderealist = "astra superbolide" },
    reqs = astranomiaReqs(),
})

aGA("Astranomia", "Equinox", {
    dmg = dmgConv(0.2, 0, 0, 90),
    wp = 40,
    bal = { cost = 3.0, bal = "equilibrium" },
    syntax = { siderealist = "astra equinox $target" },
    cooldown = 20,
    arms = 0,
})

aGA("Astranomia", "Eventide", {
    dmg = dmgConv(0.2, 0, 0, 90),
    wp = 40,
    bal = { cost = 1.0, bal = "equilibrium" },
    syntax = { siderealist = "astra eventide" },
    cooldown = 18,
    arms = 0,
})

-- TODO: channel
aGA("Astranomia", "Moonlet", {
    dmg = dmgConv(0, 0, 0, 500),
    wp = 350,
    bal = { cost = 4.0, bal = "equilibrium" },
    syntax = { siderealist = "astra moonlet $target" },

    channel = function(_, _, data)
        display("Trying moonlet channel");
        return (data.empowerments and data.empowerments[1] == "start") and 4 or 0;
    end,
    reqs = astranomiaReqs(),

    affs = function(st, tt, data)
        if (data.empowerments and data.empowerments[1] == "end") then
            if (tt) then
                return { "moonlet" };
            end
        end
        return {};
    end,

    postEffects = function(st, tt, data)
        -- Fade after 90s
        NU.setFlag(tt.name .. "_moonlet", true, 150, function() TRACK.cure(tt, "moonlet"); end);
    end
})

-- TODO: Add pre-req of 60% hp
aGA("Astranomia", "Dustring", {
    dmg = dmgConv(0, 0, 0, 500),
    wp = 350,
    bal = { cost = 3.0, bal = "equilibrium" },

    reqs = astranomiaReqs(),

    syntax = { siderealist = "astra dustring $target" },
    affs = function(st, tt, data)
        if (#data.empowerments > 0) then
            return {};
        end
        return { "dustring" };
    end,
    onUseEffects = function(st, tt, data)
        if (#data.empowerments > 0) then
            if (tt.vitals.hp < tt.vitals.maxhp * 0.6) then
                tt.vitals.hp = tt.vitals.maxhp * 0.7;
            end
            return;
        end

        if (tt.vitals.hp > tt.vitals.maxhp * 0.6) then
            tt.vitals.hp = tt.vitals.maxhp * 0.6;
        end
        NU.setFlag(tt.name .. "_dustring", true, 150, function() TRACK.cure(tt, "dustring"); end);
    end,
})

aGA("Astranomia", "Enigma", {
    dmg = dmgConv(0, 0, 0, 100),
    wp = 10,
    bal = { cost = 2, bal = "equilibrium" },

    reqs = astranomiaReqs(true),

    syntax = { siderealist = "astra enigma" },

    onUseEffects = function(st, tt, data)
        NU.setFlag(st.name .. "_enigma", true);
    end,
})

aGA("Astranomia", "Syzygy", {
    dmg = dmgConv(0, 0, 0, 1000),
    wp = 300,
    bal = { cost = 4.0, bal = "equilibrium" },
    syntax = { siderealist = "astra syzygy $target" },

    reqs = astranomiaReqs(false, nil,
        function(st, tt, data) return tt.affs.asterism and tt.affs.moonlet and tt.affs.dustring; end),

    onUseEffects = function(st, tt, data)
        -- TODO: Mixed damage.
        -- Handle that here.
        TRACK.abilityDamage(tt, 0, .25, 1.0, 1.0, "magic", "Astranomia", "Syzygy");
        TRACK.abilityDamage(tt, 0, .2, 1.0, 1.0, "shadow", "Astranomia", "Syzygy");
        TRACK.abilityDamage(tt, 0, .2, 1.0, 1.0, "spirit", "Astranomia", "Syzygy");
        TRACK.cure(tt, "asterism");
        TRACK.cure(tt, "moonlet");
        TRACK.cure(tt, "dustring");

        -- *** Eliadon: ASTRANOMIA - SYZYGY: you *** UNTRACKED[NU]: UNTRACKED BUT IT'S BEEN TOO LONG SINCE LAST VITALS, SKIPPING.
        -- Health Lost: 1419, magic, arcane
        -- Health Lost: 1692, spirit, arcane
        -- Health Lost: 1986, shadow, arcane
        -- The horrible wounds inflicted upon your body send you into shock.
        -- 1380[21%], 3043[100%], 96%, 103% ebscspdb B: -57 32000[100%]   56:477 qhspftm[-5097]☼[PAUSED][CURE: moonlet][CURE: asterism][CURE: dustring][AFF: shock]
    end,
})


aGA("Astranomia", "Blueshift", {
    dmg = dmgConv(0, 0, 0, 0),
    wp = 10,
    defs = { "blueshift" },
    bal = { cost = 1.5, bal = "equilibrium" },
    syntax = { siderealist = "astra blueshift" },
})

aGA("Astranomia", "Centrum", {
    dmg = dmgConv(0, 0, 0, 100),
    wp = 10,
    bal = { cost = 0.0, bal = "equilibrium" },
    defs = { "centrum" },
    syntax = { siderealist = "astra centrum" },
    cooldown = 30,
    onUseEffects = function(st, tt, data)
        NU.setFlag(st.name .. "_astra_centrum", true, 10, function() TRACK.stripDef(st, "centrum"); end)
    end,
})

aGA("Astranomia", "Foresight", {
    dmg = dmgConv(0, 0, 0, 0),
    wp = 10,
    defs = { "foresight" },
    cooldown = 30,
    bal = { cost = 1.0, bal = "equilibrium" },
    syntax = { siderealist = "astra foresight" },
})
