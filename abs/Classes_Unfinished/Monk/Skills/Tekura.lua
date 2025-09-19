--FLAGS.parrying

local aGA = AB.addGenericAbility;

aGA("Tekura", "Feint", {
    ep = 0, wp = 0,
    bal = {bal = "balance", cost = 3.5},
    onUseEffects = function(stable, ttable, data) if (TRACK.isSelf(ttable)) then NU.setFlag("parrying", data.limb); end end,
    cooldown = 20, attackType = "punch",
    reboundable = nil, noShield = nil, arms = 2, legs = 0,
    syntax = {Monk = "feint $target $limb"}
})