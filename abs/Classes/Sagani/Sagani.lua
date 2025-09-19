AB["Sagani"] = AB["Sagani"] or {};

local aGA = AB.addGenericAbility;
local function dmgConv(eh, em, sh, sm) return {eH = eh, eM = em, sH = sh, sM = sm}; end

aGA("Sagani", "Wall", {ep = -30, defs = {"sagani_wall"}, noshield = true, bal = {["cost"] = 2.0, ["bal"] = "equilibrium"}, arms = 1, syntax = {["sagani"] = "sagani wall"}});
aGA("Sagani", "Presence", {ep = -30, defs = {"sagani_presence"}, noshield = true, bal = {["cost"] = 2.0, ["bal"] = "equilibrium"}, arms = 1, syntax = {["sagani"] = "sagani presence on"}});
aGA("Sagani", "Epicentre", {ep = -30, defs = {"sagani_epicentre"}, noshield = true, bal = {["cost"] = 2.0, ["bal"] = "equilibrium"}, arms = 1, syntax = {["sagani"] = "sagani epicentre on"}});
aGA("Sagani", "Helix", {ep = -30, defs = {"sagani_helix"}, noshield = true, bal = {["cost"] = 2.0, ["bal"] = "equilibrium"}, arms = 1, syntax = {["sagani"] = "sagani helix"}});
aGA("Sagani", "Helix_Stored", {ep = -30, defs = {"sagani_helix_stored"}, noshield = true, bal = {["cost"] = 2.0, ["bal"] = "equilibrium"}, arms = 1, syntax = {["sagani"] = "sagani helix store"}});
aGA("Sagani", "Similitude", {ep = -30, defs = {"sagani_similitude"}, noshield = true, bal = {["cost"] = 2.0, ["bal"] = "equilibrium"}, arms = 1, syntax = {["sagani"] = "sagani similitude on"}});



aGA("Sagani", "Wellspring", {ep = -30, noshield = true, bal = {["cost"] = 3.0, ["bal"] = "equilibrium"}, arms = 1, syntax = {["sagani"] = "sagani wellspring"}});

aGA("Sagani", "Deliquesce", {ep = -30, noshield = true, bal = {["cost"] = 3.0, ["bal"] = "equilibrium"}, arms = 1, syntax = {["sagani"] = "sagani deliquesce $target"}});


aGA("Sagani", "Quarrel", {attackType = "magical", dmg = dmgConv(0.11, 0, 0, 0), dmgType = "magic", wp = -26, noshield = false, bal = {["cost"] = 2.8, ["bal"] = "equilibrium"}, arms = 1,
    affs = function(stable, ttable, data) return {}, {"paresis", "clumsiness", "weariness", "asthma", "haemophilia"}, 1; end, syntax = {["sagani"] = "sagani quarrel $target"}});

aGA("Sagani", "Scald", {attackType = "magical", dmg = dmgConv(0.11, 0, 0, 0), dmgType = "fire", wp = -26, noshield = false, bal = {["cost"] = 2.8, ["bal"] = "equilibrium"}, arms = 1,
    affs = function(stable, ttable, data) return {}, {"stupidity", "indifference", "recklessness", "confusion", "anorexia", "dementia"}, 1; end, syntax = {["sagani"] = "sagani scald $target"}});

aGA("Sagani", "Carbonise", {attackType = "magical", dmg = dmgConv(0.11, 0, 0, 0), dmgType = "cutting", wp = -26, noshield = false, bal = {["cost"] = 2.8, ["bal"] = "equilibrium"}, arms = 1,
    syntax = {["sagani"] = "sagani carbonise $target $limb $venom"}});

-- 11% likmb damage, targetted, but doesn't show in combat message.

    -- getLimbEffects = function(attacker, target, data)
    --     if (data.limb and data.limb ~= "body") then
    --         return {[data.limb] = 14, no_break = false};
    --     end
    --     return {};
    -- end,

-- {"vomiting", "stuttering", "blurry_vision", "dizziness", "weariness", "laxity"}, 2
--aGA("Sagani", "Quarrel", {attackType = "magical", dmg = dmgConv(0.11, 0, 0, 0), dmgType = "magic", wp = -26, noshield = false, bal = {["cost"] = 2.8, ["bal"] = "equilibrium"}, arms = 2, affs = {"FALLEN"}, syntax = {["Sagani"] = "sagani  $target $empowerment"}});

-- TODO: Add other erode effects.
aGA("Sagani", "Erode", {attackType = "magical", dmg = dmgConv(0.11, 0, 0, 0), dmgType = "magic", wp = -26, noshield = true, bal = {["cost"] = 0, ["bal"] = "equilibrium"}, arms = 1, syntax = {["sagani"] = "sagani erode shield"}});

aGA("Sagani", "Cataclysm", {attackType = "magical", dmg = dmgConv(0.11, 0, 0, 0), dmgType = "magic", wp = -26, noshield = false, bal = {["cost"] = 3.5, ["bal"] = "equilibrium"}, arms = 1,
    affs = function(stable, ttable, data) return {}, {"paresis", "clumsiness", "weariness", "asthma", "haemophilia"}, 1; end, syntax = {["Sagani"] = "sagani cataclysm quarrel"}});

-- TODO: Add custom preReqs function for nuclei.
aGA("Sagani", "Flux", {attackType = "magical", dmg = dmgConv(0.44, 0, 0, 0), dmgType = "magic", wp = -26, noshield = false, bal = {["cost"] = 2.8, ["bal"] = "equilibrium"}, arms = 1, syntax = {["sagani"] = "sagani flux $target"}});
aGA("Sagani", "Fortification", {ep = -30, noshield = true, bal = {["cost"] = 3.0, ["bal"] = "equilibrium"}, arms = 1, syntax = {["Sagani"] = "sagani wellspring"}});
aGA("Sagani", "Tornado", {attackType = "magical", dmg = dmgConv(0.44, 0, 0, 0), dmgType = "magic", wp = -26, noshield = false, bal = {["cost"] = 2.8, ["bal"] = "equilibrium"}, arms = 1, syntax = {["sagani"] = "sagani tornado $target"}});