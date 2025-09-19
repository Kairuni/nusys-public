function AUTOBASH.classes.shaman(act, willCure, randomCureCount)
    local stable = TRACK.getSelf();
    local saffs = stable.affs;
    local queuedAfflictions = {};

    local prim = AB.Primality;

    local hpPercent = stable.vitals.hp / stable.vitals.maxhp;
    local bleed = stable.vitals.bleeding;

    -- local target = AUTOBASH.target;
    AUTOBASH.genericPickTarget();
    if (not AUTOBASH.target) then
        NU.promptAppend("BTARG", "No btarg");
        return;
    end

    local choice = prim.Lightning;

    if (FLAGS.mob_shield) then
        choice = prim.Leafstorm;
    end

    local syntax = choice.syntax.shaman:gsub("$target", AUTOBASH.target.id);
    if (FLAGS[stable.name .. "_familiar_morph"] and FLAGS[stable.name .. "_familiar_morph"] == "a wyvern spirit" and not FLAGS.hold_morph) then
        table.insert(act.eqbalFree, {syntax = "familiar morph bear##order loyals follow me", attack = true, bal = "equilibrium"});
    elseif (not FLAGS.hold_morph) then
        table.insert(act.eqbalFree, {syntax = "familiar morph wyvern##order loyals follow me", attack = true, bal = "equilibrium"});
    end

    if (stable.vitals.energy > 1) then
        table.insert(act.eqbalFree, {syntax = prim.Boosting.syntax.shaman, attack = true, bal = "equilibrium"});
    end
    act.eqbalConsuming:put({syntax = syntax, bal = choice.balance(stable).self.bal, attack = true}, 3.3);
end