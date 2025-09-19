function AUTOBASH.classes.sagani(act, willCure, randomCureCount)
    local stable = TRACK.getSelf();
    local saffs = stable.affs;
    local queuedAfflictions = {};

    local sagani = AB.Sagani;

    local hpPercent = stable.vitals.hp / stable.vitals.maxhp;
    local bleed = stable.vitals.bleeding;

    -- local target = AUTOBASH.target;
    AUTOBASH.genericPickTarget();
    if (not AUTOBASH.target) then
        NU.promptAppend("BTARG", "No btarg");
        return;
    end

    local choice = sagani.Quarrel;

    if (FLAGS.mob_shield) then
        choice = sagani.Erode;
    end

    -- cauterize, respiration
    if (hpPercent <= 0.55) then
        choice = sagani.Wellspring;
    end
    local syntax = choice.syntax.sagani:gsub("$target", AUTOBASH.target.id);
    act.eqbalConsuming:put({syntax = syntax, bal = choice.balance(stable).self.bal, attack = true}, 3.3);
end