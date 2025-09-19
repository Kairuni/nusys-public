--

local aGA = AB.addGenericAbility;
local function dmgConv(eh, em, sh, sm) return { eH = eh, eM = em, sH = sh, sM = sm }; end

-- TODO: Weapon arm needs to not be broken.
aGA("Ostension", "Vayua Attack",
    {
        dmg = dmgConv(0.15, 0.0, 0.0, 50),
        dmgType = "cutting",
        ep = 40,
        -- TODO: Update how we handle weapon hinder
        arms = 0,
        onUseEffects = function(st, tt, data) NU.setPFlag("venom_target", tt); end,
        bal = { cost = 2.58, bal = "balance" },
        syntax = { ["siderealist"] = "jab $target $venom" }
    });

aGA("Ostension", "Averroes Bolt",
    {
        dmg = dmgConv(0.15, 0.0, 0.0, 50),
        dmgType = "magic",
        ep = 40,
        arms = 0,
        limbs = function(attacker, target, data)
            if (not data.limb) then
                return {};
            end

            return { [data.limb] = 15.0 };
        end,
        onUseEffects = function(st, tt, data) NU.setPFlag("venom_target", tt); end,
        bal = { cost = 3.0, bal = "balance" },
        syntax = { ["siderealist"] = "bolt $target $limb" }
    });
