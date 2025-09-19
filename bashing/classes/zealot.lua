function AUTOBASH.classes.zealot(act, willCure, randomCureCount)
    local stable = TRACK.getSelf();
    local saffs = stable.affs;
    local queuedAfflictions = {};

    local zeal = AB.Zeal;
    local puri = AB.Purification;
    local tat = AB.Tattoos;

    local hpPercent = stable.vitals.hp / stable.vitals.maxhp;
    local bleed = stable.vitals.bleeding;

    -- local target = AUTOBASH.target;
    AUTOBASH.genericPickTarget();
    if (not AUTOBASH.target) then
        NU.promptAppend("BTARG", "No btarg");
        return;
    end

    local choice = zeal.Flow;

    if (FLAGS.mob_shield) then
        choice = tat.Hammer;
    end

    -- cauterize, respiration
    if (hpPercent <= 0.55) then
        choice = zeal.Respiration;
    end
    if (not FLAGS.imp_mode) then
        local syntax = choice.syntax.zealot and choice.syntax.zealot:gsub("$target", AUTOBASH.target.id) or
            choice.syntax.Defualt:gsub("$target", AUTOBASH.target.id);
        syntax = syntax:gsub("$empowerment1", "pummel");
        syntax = syntax:gsub("$empowerment2", "pummel");
        act.eqbalConsuming:put({ syntax = syntax, bal = choice.balance(stable).self.bal, attack = true }, 3.3);
    else
        local pummelSyntax = zeal.Flow.syntax.zealot:gsub("$target", AUTOBASH.target.id):gsub("$empowerment1", "pummel")
            :gsub("$empowerment2", "pummel") .. "##eval";
        local syntax = (not FLAGS.mob_shield) and ("imperial attack " .. AUTOBASH.target.id .. "##eval") or
            choice.syntax.Defualt:gsub("$target", AUTOBASH.target.id);

        local imp_hp = FLAGS.imp_hp;

        if (imp_hp and imp_hp.hp < 100) then
            act.eqbalConsuming:put({ syntax = pummelSyntax, bal = choice.balance(stable).self.bal, attack = true }, 3.3);
        else
            act.eqbalConsuming:put({ syntax = syntax, bal = choice.balance(stable).self.bal, attack = true }, 3.3);
        end
    end
end