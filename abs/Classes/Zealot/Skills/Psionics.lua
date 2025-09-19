-- You begin to regulate your psionic energy to 200%.
-- psi regulate ###
-- Psi costs for each
-- locate 10
-- psi flash missing flash_blindness
-- psi dull hidden indifference.
-- psi recover single mental cure. 50 psi cost.
-- psi absorb?
-- Vacuum missing as can't use on self
-- mindspark psi cost to -50
-- Tether fake aff/flag.
-- psi bending no combatmessage gives bending def. You are already bending magical ranged attacks.
-- psi corporality no combatmessages gives corporality def. You already possess a psionic clamp over your vicinity.
-- psi disable specific skills. Implement this separately.
-- psi step can't test on self.

local aGA = AB.addGenericAbility;
local function dmgConv(eh, em, sh, sm) return {eH = eh, eM = em, sH = sh, sM = sm}; end

aGA("Psionics", "Locate", {rebounding = false, noShield = false, bal = {["cost"] = 1.16, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "psi locate $target", ["ravager"] = "ego pinpoint $target"}});
aGA("Psionics", "Fetch", {psiCost = 100, noshield = false, bal = {["cost"] = 4.04, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "psi fetch $target", ["ravager"] = "ego haul $target"}});
aGA("Psionics", "Flash", {ep = -16, psiCost = 50, noshield = false, bal = {["cost"] = 3.49, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "psi flash", ["ravager"] = "ego peak"}});
aGA("Psionics", "Neutralise", {psiCost = 50,strips = {["speed"] = true, ["levitation"] = true}, noShield = false, bal = {["cost"] = 3.52, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "psi neutralise $target", ["ravager"] = "ego redress $target"}});
aGA("Psionics", "Lance", {dmgConv(0.18876033057851, 0, 0, 0), dmgType = "magic", psiCost = 200, noshield = false, bal = {["cost"] = 4.01, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "psi lance $target", ["ravager"] = "ego trip $target"}});
aGA("Psionics", "Dull", {ep = -16, psiCost = 30, affs = {"indifference"}, noshield = false, bal = {["cost"] = 2.33, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "psi dull $target", ["ravager"] = "ego inadequacy $target"}});
aGA("Psionics", "Recover", {psiCost = 60, noshield = false, bal = {["cost"] = 2.31, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "psi recover", ["ravager"] = "ego boost"}});
aGA("Psionics", "Deprival", {affs = {"dementia", "paranoia", "mercy"}, psiCost = 50, noshield = false, bal = {["cost"] = 3.49, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "psi deprive $target", ["ravager"] = "ego boast $target"}});
aGA("Psionics", "Absorption", {psiCost = 0, noshield = false, bal = {["cost"] = 4.65, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "psi absorb $target", ["ravager"] = "ego monopolise $target"}});
aGA("Psionics", "Shock", {dmgConv(0.19081186193486, 0, 0, 0), dmgType = "psychic", ep = 16, psiCost = 150, cures = {"dementia"}, noShield = false, bal = {["cost"] = 3.69, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "psi shock $target", ["ravager"] = "ego trauma $target"}, rebounding = false});
aGA("Psionics", "Sliver", {ep = 16, psiCost = 300, noshield = false, bal = {["cost"] = 2.29, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "psi sliver $target", ["ravager"] = "ego pry $target"}});
aGA("Psionics", "Mindspark", {defs = {"mindspark"}, noshield = false, arms = 2, bal = {["cost"] = 0, ["bal"] = "equilibrium"}, psiCost = 230, syntax = {["zealot"] = "psi mindspark", ["ravager"] = "ego inflate"}});
aGA("Psionics", "Tether", {affs = {"psi_tether"}, psiCost = -90, noshield = false, bal = {["cost"] = 3.43, ["bal"] = "equilibrium"}, arms = 2, syntax = {["zealot"] = "psi tether $target", ["ravager"] = "ego kneel $target"}});
aGA("Psionics", "Torrent", {wp = -30, psiCost = -2755, noshield = false, arms = 2, syntax = {["zealot"] = "psi torrent", ["ravager"] = "ego guts"}});

aGA("Psionics", "Vacuum", {wp = -30, psiCost = 150, noshield = false, arms = 2, syntax = {["zealot"] = "psi vacuum", ["ravager"] = "ego dethrone"}});

aGA("Psionics", "Disable", {wp = -2, cooldown = 93, noshield = false, arms = 2, syntax = {["zealot"] = "psi disable $target $empowerment", ["ravager"] = "ego outlaw $target $empowerment"}});