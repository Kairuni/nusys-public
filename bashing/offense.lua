local noMountList = {"zealot", "ravager", "predator", "shapeshifter" }

function AUTOBASH.offense(act, willCure, randomCureCount)
    local stable = TRACK.getSelf();
    local saffs = stable.affs;
    local sdefs = stable.defs;
    local offenseSelection = AUTOBASH.classes[NU.getClass()];
    local hpPercent = stable.vitals.hp / stable.vitals.maxhp;
    local mpPercent = stable.vitals.mp / stable.vitals.maxmp;
    local bleed = stable.vitals.bleeding;

    if ((not AUTOBASH.sacrificeTime or AUTOBASH.sacrificeTime <= NU.time()) and NU.config.autoSacrifice) then
        table.insert(act.eqbalFree, {syntax = "sacrifice corpses", attack = true});
        AUTOBASH.sacrificeTime = NU.time() + 240;
    end

    if (FLAGS.need_to_summon_elemental) then
        table.insert(act.eqbalFree, {syntax = "summon elemental", attack = true});
    end

    if (saffs.shock and not sdefs.overdrive) then
        table.insert(act.eqbalFree, {syntax = "overdrive", attack = true});
    end

    if (hpPercent <= 0.4 and NU.offCD("Avoidance_Bolstering")) then
        table.insert(act.eqbalFree, {syntax = "bolster", attack = true});
    end

    if (table.contains(noMountList, NU.getClass())) then
        if (stable.vitals.mounted ~= "0") then
            table.insert(act.eqbalFree, {syntax = "qdmount", attack = true});
        end
    elseif (stable.vitals.mounted == "0" and NU.config.mount) then
        table.insert(act.eqbalFree, {syntax = "recall mount" .. NU.config.separator .. "qmount " .. NU.config.mount, attack = true});
    end

    -- Actions to add - pulse?, shield, cauterize, respiration
    if (#AUTOBASH.aggroQueue == 0 and bleed >= 500) then
        NU.promptAppend("BLEED_WARN", "Bleeding too heavily, waiting.");

        if (NU.getClass() == "zealot") then
            act.eqbalConsuming:put({syntax = "enact cauterize", bal = {bal = "balance", cost = 4}, attack = true}, 3);
        else
            act.eqbalConsuming:put({syntax = "touch worrystone", bal = {bal = "balance", cost = 2}, attack = true}, 3);
        end
    -- elseif (#AUTOBASH.aggroQueue == 0 and hpPercent < .7) then
    --     NU.promptAppend("HP_WARN", "HP too low, waiting.");
    --     act.eqbalConsuming:put({syntax = "touch worrystone", bal = {bal = "balance", cost = 2}, attack = true}, 3);
    -- elseif (#AUTOBASH.aggroQueue == 0 and mpPercent < .5) then
    --     NU.promptAppend("HP_WARN", "HP too low, waiting.");
    --     act.eqbalConsuming:put({syntax = "touch worrystone", bal = {bal = "balance", cost = 2}, attack = true}, 3);
    elseif (hpPercent <= 0.4 and NU.offCD("Tattoos_Crystal")) then
        act.eqbalConsuming:put({syntax = "touch crystal", bal = {bal = "balance", cost = 4}}, 3)
    -- elseif (hpPercent <= 0.2 and mpPercent <= 0.2 and bleed >= 500) then
    --    act.eqbalConsuming:put({syntax = "touch worrystone", bal = {bal = "balance", cost = 4}, attack = true}, 3);
    elseif (hpPercent <= 0.2 and mpPercent <= 0.2 and (stable.defs.shielded or stable.defs.reflection)) then
        act.eqbalConsuming:put({syntax = "touch worrystone", bal = {bal = "balance", cost = 2}, attack = true}, 3);
    elseif (FLAGS.mob_counterattack and false) then
        NU.promptAppend("MOB_COUNTER", "Target is counter attacking, waiting.");
        QUE.clearQueue("eqbal");
    elseif (offenseSelection) then
        offenseSelection(act, willCure, randomCureCount);
    else
        NU.promptAppend("BASH_WARN", "Default bashing.");

        AUTOBASH.genericPickTarget();
        if (not AUTOBASH.target) then return; end

        act.eqbalConsuming:put({syntax = "kill " .. AUTOBASH.target.id, bal = {bal = "balance", cost = 4}, attack = true}, 3);
    end
end