-- TODO: Add Direblow, Heelrush, 65 bleed for Rive, fix Dislocate for left/right arm target, fix whipburst for Flame empowerment.
local aGA = AB.addGenericAbility;
local function dmgConv(eh, em, sh, sm) return { eH = eh, eM = em, sH = sh, sM = sm }; end
local function crystalismReqs(vibration, ignoreShield, cooldown, other)
    ignoreShield = ignoreShield or false;
    return function(st, tt, data)
        return AB.genericRequirements(st, tt, 0, false, nil, false, ignoreShield, st.name .. cooldown, 0) and
            (other and other() or true); -- and ROOM_STATUS.VIBES.ELIADON[vibration]
    end
end

local function affStack(...)
    local stack = { ... };
    return function(st, tt, data)
        return AB.linearStack(tt, stack);
    end
end

--aGA("Crystalism", "Tones ", { dmg = dmgConv(0.0, 0.0, 0.0, 50), dmgType = "unblockable", wp = 20, reqs = crytalismReqs(""), bal = { cost = .0, bal = "ability_bal" }, syntax = {["siderealist"] = "strike tone "} });
aGA("Crystalism", "Tones Palpitation",
    {
        dmg = dmgConv(0.15, 0.0, 0.0, 50),
        dmgType = "magic",
        wp = 20,
        reqs = crystalismReqs("palpitation"),
        bal = { cost = 5.0, bal = "ability_bal" },
        syntax = { ["siderealist"] = "strike tone palpitation $target" }
    });
aGA("Crystalism", "Tones Dissipate",
    {
        dmg = dmgConv(0.0, 0.07, 0.0, 50),
        dmgType = "unblockable",
        wp = 20,
        reqs = crystalismReqs("dissipate"),
        bal = { cost = 4.0, bal = "ability_bal" },
        syntax = { ["siderealist"] = "strike tone dissipate $target" }
    });
aGA("Crystalism", "Tones Tremors",
    {
        dmg = dmgConv(0.0, 0.0, 0.0, 50),
        dmgType = "unblockable",
        wp = 20,
        reqs = crystalismReqs("termors"),
        bal = { cost = 3.5, bal = "ability_bal" },
        onUseEffects = function(st, tt, data)
            TRACK.useBalance(tt, "balance", 0.7);
        end,
        syntax = { ["siderealist"] = "strike tone tremors $target" }
    });
aGA("Crystalism", "Tones Harmony",
    { dmg = dmgConv(-0.04, -0.04, 0.0, 50), dmgType = "unblockable", wp = 20, reqs = crystalismReqs("harmony"), bal = { cost = 6.0, bal = "ability_bal" }, syntax = { ["siderealist"] = "strike tone harmony $target" } });
aGA("Crystalism", "Tones Creeps",
    {
        dmg = dmgConv(0.0, 0.0, 0.0, 50),
        affs = affStack("loneliness", "masochism"),
        dmgType = "unblockable",
        wp = 20,
        reqs =
            crystalismReqs("creeps"),
        bal = { cost = 3.5, bal = "ability_bal" },
        syntax = { ["siderealist"] = "strike tone creeps $target" }
    });
aGA("Crystalism", "Tones Oscillate",
    {
        dmg = dmgConv(0.0, 0.0, 0.0, 50),
        affs = { "muddled" },
        onUseEffects = function(_, tt, _)
            local flagName = tt.name .. "_muddled_strip";
            if (not FLAGS[flagName] or FLAGS[flagName] > NU.time() + 7.5) then
                -- NU.time() + 6 to give it some flexibility
                NU.setFlag(flagName, NU.time() + 4, TRACK.isSelf(tt) and 12 or 7.5,
                    function()
                        TRACK.cure(tt, "muddled");
                    end);
            end
        end,
        dmgType = "unblockable",
        wp = 20,
        reqs = crystalismReqs(
            "oscillate"),
        bal = { cost = 3.5, bal = "ability_bal" },
        syntax = { ["siderealist"] = "strike tone oscillate $target" }
    });
aGA("Crystalism", "Tones Revelation",
    { dmg = dmgConv(0.0, 0.0, 0.0, 50), dmgType = "unblockable", wp = 20, reqs = crystalismReqs("revelation", true), bal = { cost = 6.0, bal = "ability_bal" }, syntax = { ["siderealist"] = "strike tone revelation" } });
aGA("Crystalism", "Tones Disorientation",
    {
        dmg = dmgConv(0.0, 0.0, 0.0, 50),
        affs = affStack("epilepsy", "mania"),
        dmgType = "unblockable",
        wp = 20,
        reqs = crystalismReqs("disorientation"),
        bal = { cost = 3.5, bal = "ability_bal" },
        syntax = { ["siderealist"] = "strike tone disorientation $target" }
    });
-- TODO: anything about energize
aGA("Crystalism", "Tones Energize",
    {
        dmg = dmgConv(0.0, 0.0, 0.0, 50),
        dmgType = "unblockable",
        wp = 20,
        reqs =
            crystalismReqs("energize"),
        bal = { cost = 8.0, bal = "ability_bal" },
        syntax = { ["siderealist"] = "strike tone energize $target" }
    });
aGA("Crystalism", "Tones Stridulation",
    {
        dmg = dmgConv(0.0, 0.0, 0.0, 50),
        affs = function(_, tt, _) if (tt.defs.deafness) then return {} else return { "sensitivity" }; end end,
        postEffects = function(_, tt, _) TRACK.stripDef(tt, "deafness"); end,
        dmgType = "unblockable",
        wp = 20,
        reqs = crystalismReqs("stridulation"),
        bal = { cost = 4.0, bal = "ability_bal" },
        syntax = { ["siderealist"] = "strike tone stridulation $target" }
    });
aGA("Crystalism", "Tones Crystalforest",
    {
        dmg = dmgConv(0.0, 0.0, 0.0, 50),
        onUseEffects = function(_, tt, _) TRACK.stripDef(tt, "shielded"); end,
        dmgType =
        "unblockable",
        wp = 20,
        reqs = crystalismReqs("crystalforest", "_Crystalism_Tones Crystalforest"),
        cooldown = 20,
        bal = { cost = 3.5, bal = "ability_bal" },
        syntax = { ["siderealist"] = "strike tone crystalforest $target" }
    });
aGA("Crystalism", "Tones Gravity",
    {
        dmg = dmgConv(0.0, 0.0, 0.0, 50),
        dmgType = "unblockable",
        wp = 20,
        reqs = crystalismReqs("gravity"),
        onUseEffects = function(
            _, tt, _)
            TRACK.stripDef(tt, "levitation");
        end,
        bal = { cost = 2.5, bal = "ability_bal" },
        syntax = { ["siderealist"] = "strike tone gravity $target" }
    });
aGA("Crystalism", "Tones Dissension",
    {
        dmg = dmgConv(0.0, 0.0, 0.0, 50),
        affs = { "dissonance" },
        dmgType = "unblockable",
        wp = 20,
        reqs = crystalismReqs("dissension"),
        bal = { cost = 4.0, bal = "ability_bal" },
        syntax = { ["siderealist"] = "strike tone dissension $target" }
    });
aGA("Crystalism", "Tones Plague",
    { dmg = dmgConv(0.0, 0.0, 0.0, 50), dmgType = "unblockable", wp = 20, reqs = crystalismReqs("plague"), bal = { cost = 4.5, bal = "ability_bal" }, syntax = { ["siderealist"] = "strike tone plague $target" } });
aGA("Crystalism", "Tones Lullaby",
    {
        dmg = dmgConv(0.0, 0.0, 0.0, 50),
        affs = function(_, tt, _)
            if (tt.defs.insomnia) then
                return {};
            elseif (tt.affs.ASLEEP) then
                return { "hypersomnia" }
            else
                return { "ASLEEP" };
            end
        end,
        postEffects = function(_, tt, _) TRACK.stripDef(tt, "insomnia"); end,
        dmgType = "unblockable",
        wp = 20,
        reqs = crystalismReqs("lullaby"),
        bal = { cost = 3.5, bal = "ability_bal" },
        syntax = { ["siderealist"] = "strike tone lullaby $target" }
    });
