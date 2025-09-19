local stack = {
    "shield_strip",
    "laesan_vertical",
    "laesan_lateral",
    "vertical_bash",
    "lateral",
    "vertical",
    "swiftkick"
}

function AUTOBASH.classes.predator(act, willCure, randomCureCount)
    local stable = TRACK.getSelf();
    local saffs = stable.affs;
    local queuedAfflictions = {};

    local kp = AB.Knifeplay;
    local pred = AB.Predation;

    local hpPercent = stable.vitals.hp / stable.vitals.maxhp;
    local bleed = stable.vitals.bleeding;

    AUTOBASH.genericPickTarget();
    if (not AUTOBASH.target) then
        NU.promptAppend("BTARG", "No btarg");
        return;
    end

    local choice = nil;

    -- cauterize, respiration
    if (hpPercent <= 0.60 and pred.Arouse.meetsPreReqs(stable)) then
        choice = pred.Arouse;
    end

    if (choice) then
        act.eqbalConsuming:put({syntax = choice.syntax.Predator, bal = choice.balance(stable).self.bal, attack = true}, 2);
    end

    OFFENSE.predator.stackOffense(act, willCure, randomCureCount, stack, {}, true);
end

