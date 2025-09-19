function TRACK.cmsg(attacker, skill, ability, other, target, limb)
    if (PFLAGS.illusion) then return; end
    local atable = TRACK.get(attacker);
    local ttable = TRACK.get(target);
    local isSelf = TRACK.isSelf(atable);
    local abTable = AB[skill] and AB[skill][ability];
    local isMirror = NU.skillMirrors[skill] and true or false;

    local skillColor = isMirror and "<SteelBlue>" or "<DeepSkyBlue>";
    local tColor = "<aquamarine>";
    if (not isSelf) then
        tColor = "<DarkOrange>";
        skillColor = isMirror and "<goldenrod>" or "<LightGoldenrod>";
    end

    -- TODO: Add functionality for proper ab name overrides (i.e. Ku'init -> Stupidity)
    --       ONLY apply to ABs, not to skills. Tired of this nonsense.
    local skillName = skill;
    local abName = NU.abMirrors[skill] and NU.abMirrors[skill][ability] or ability;

    local otherString = other and (" (" .. other .. ")") or "";
    local limbString = limb and (" (" .. limb .. ")") or "";
    local targetString = target and (": " .. target) or "";

    local addendumLine = (not abTable) and " <red>UNTRACKED<reset>" or "";

    if (TRACK.isSelf(atable) and NU.config.gags.cmsg_formatter) then
        creplaceLine("<aquamarine>*** ".. skillColor .. skillName:upper() .. " - " .. abName:upper() .. otherString .. limbString .. "<red>" .. targetString .. "<aquamarine> ***" .. addendumLine);
    elseif (NU.config.gags.cmsg_formatter) then
        creplaceLine("<red>*** <red>" .. attacker .. ": ".. skillColor .. skillName:upper() .. " - " .. abName:upper() .. otherString .. limbString .. tColor .. targetString .. "<red> ***" .. addendumLine);
    end
    if (isMirror) then
        selectCurrentLine();
        setLink(function() end, skill .. " " .. ability);
    end

    if (not abTable) then -- TODO: Remove this after all balance consuming ABs are tracked.
        atable.wounds_snapshot = table.deepcopy(atable.wounds);
        atable.bals.balance = NU.time() + 3;
    end

    if (not abTable and FLAGS.last_vitals_ep) then
        NU.setFlag("last_untracked_ab", {skill = skillName, ab = abName}, 60);
        NU.setPFlag("untracked", true);

        NU.clearFlag("last_untracked_add_affs");
        NU.clearFlag("last_untracked_remove_affs");

        NU.clearFlag("last_untracked_add_defs");
        NU.clearFlag("last_untracked_remove_defs");

        NU.clearFlag("last_untracked_balance_cost");
        NU.clearFlag("last_untracked_health_change");
        NU.clearFlag("last_untracked_mana_change");

        NU.clearFlag("last_untracked_limb_damage");
        NU.clearFlag("last_untracked_limb_target");

        NU.clearFlag("last_untracked_damage_type");
        NU.setFlag("last_untracked_ep", atable.vitals.ep - FLAGS.last_vitals_ep, 60);
        NU.setFlag("last_untracked_wp", atable.vitals.wp - FLAGS.last_vitals_wp, 60);

        return;
    elseif (not abTable) then
        NU.ECHO("<red>UNTRACKED BUT IT'S BEEN TOO LONG SINCE LAST VITALS, SKIPPING.");
        return;
    end

    NU.setPFlag("attack_target", ttable);
    NU.setPFlag("venom_target", ttable);

    local data = abTable.convertData(other, limb);
    if (abTable.onUseEffects) then abTable.onUseEffects(atable, ttable, data); end

    NU.setPFlag("attack_to_apply", {atable = atable, ttable = ttable, abTable = abTable, skill = skill, ability = ability, target = target, data = data}); -- limb = limb, other = other, 

    TRACK.cure(atable, "UNCONSCIOUS");
    TRACK.cure(atable, "STUN");
    TRACK.cure(atable, "writhe_ice");

    if (not abTable.defensive) then
        TRACK.removeDef(atable, "shielded");
        TRACK.removeDef(atable, "rebounding");
    end

    NU.setFlag("recent_attack", true, 20);
    TRIG.enable(TRIGS.apply_attack);
end

local woundsSnapshotBalances = {
    balance = true,
    equilibrium = true,
}

function TRACK.applyAttack()
    local flagT = PFLAGS.attack_to_apply;
    if (not flagT) then
        TRIG.disable(TRIGS.apply_attack);
        return;
    end

    -- display("Attack being applied?");

    local atable = flagT.atable;
    local ttable = flagT.ttable;
    local abTable = flagT.abTable;
    local skill = flagT.skill;
    local ability = flagT.ability;
    local target = flagT.target;
    local data = flagT.data;
    --local limb = flagT.limb;
    --local other = flagT.other;

    -- Tracking your own attacks.
    --local data = abTable.convertData(other, limb);

    -- Returns {visible affs}, {possible hidden affs}, expected hidden count
    local visibleAffs, hiddenAffs, hiddenCount = abTable.getTargetAffs(atable, ttable, data);
    local defs = abTable.getSelfDefs(atable, ttable, data);
    local targetCures = abTable.getTargetCures(atable, ttable, data);
    -- TODO: Skipping self affs and self cures for now, not sure they're ever relevant.
    local damage, manaDamage, selfDamage, selfManaDamage, damageData = abTable.getDamage(atable, ttable, data);
    local dmgType = abTable.getDamageType and abTable.getDamageType(atable, ttable, data) or "blunt";
    local expectedBalance = abTable.balance(atable, ttable, data);
    local selfBal = expectedBalance.self;
    local channel = abTable.channel and abTable.channel(atable, ttable, data);

    local limbDamage = abTable.getLimbEffects(atable, ttable, data);

    local defStrip = abTable.getRemovedSelfDefs(atable, ttable, data);

    for _, def in ipairs(defStrip) do
        TRACK.stripDef(atable, def);
    end
    -- First, handle hidden effects of given abilities.
    -- This is the more important part for self tracking -
    if (not TRACK.isSelf(atable)) then
        NU.players[atable.name] = true;
        if (TRACK.isSelf(ttable)) then
            if (hiddenAffs) then
                -- display("We have hiddens!");
                NU.setPFlag("expected_hiddens", { source = ability, affList = hiddenAffs, expectedCount = hiddenCount });
            end

            if (damage > 0 or manaDamage > 0) then
                NU.setPFlag("expect_damage", true);
            end
            if (ttable.affs.recklessness) then
                damageData = damageData or { flatHP = 0, percentHP = damage };
                TRACK.abilityDamage(ttable, damageData.flatHP, damageData.percentHP, 1.0, 1.0, dmgType, skill, ability);
                TRACK.damage(ttable, 0.0, manaDamage * ttable.vitals.maxhp);
            end
        end

        -- Snapshot the attacker's limbs for parry prediction.
        if (selfBal and selfBal.bal and selfBal.cost and woundsSnapshotBalances[selfBal.bal]) then
            atable.wounds_snapshot = table.deepcopy(atable.wounds);
            atable.bals.balance = NU.time() + selfBal.cost;
        end

        if (not abTable.defensive) then
            TRACK.removeDef(atable, "shielded");
            TRACK.removeDef(atable, "rebounding");
            TRACK.removeDef(atable, "barrier");
        end
        if (defs) then
            for _, def in ipairs(defs) do
                TRACK.addDef(atable, def);
            end
        end
        NU.setPFlag("ab_used", skill .. "-" .. ability);

        if (channel) then
            if (channel == 0) then
                NU.clearFlag(atable.name .. "_channeling");
            else
                NU.setFlag(atable.name .. "_channeling", ability, channel);
            end
        else
            NU.clearFlag(atable.name .. "_channeling");
        end
    else
        NU.setPFlag("expected_bal", expectedBalance);

        -- TODO: Expand this as we add more abilities - for now we're ONLY handling visibleAffs, as those should be applied 100% of the time.
        NU.setPFlag("last_ttable_hit", ttable);

        if (channel) then
            if (channel == 0) then
                NU.clearFlag(atable.name .. "_channeling");
            else
                NU.setFlag(atable.name .. "_channeling", ability, channel);
            end
        else
            NU.clearFlag(atable.name .. "_channeling");
        end

        if (ttable and dmgType and dmgType == "fire") then
            TRACK.stack(ttable, "ablaze", 1);
        end

        if (atable.affs.recklessness or #TRACK.getHiddenCandidateIndicies(atable, "recklessness") > 0) then
            TRACK.damage(atable, 0.0, selfManaDamage);
        end
        -- ?????
        -- This probably should always be true? Did I do this for the test room case?
        if (not TRACK.isSelf(ttable)) then
            if (not abTable.defensive) then
                TRACK.cure(ttable, "pacifism");
            end

            if (targetCures) then
                for _,v in ipairs(targetCures) do
                    TRACK.cure(ttable, v);
                    --display(v);
                end
            else
                NU.WARN("Error - " .. skill .. " - " .. ability .. ": invalid cures return.")
            end

            if (visibleAffs) then
                for _,v in ipairs(visibleAffs) do
                    TRACK.aff(ttable, v);
                end
            else
                NU.WARN("Error - " .. skill .. " - " .. ability .. ": invalid visible affs returned.")
            end

            -- TODO: Damage
            if (ttable) then
                damageData = damageData or {flatHP = 0, percentHP = damage};
                TRACK.abilityDamage(ttable, damageData.flatHP, damageData.percentHP, 1.0, 1.0, dmgType, skill, ability);

                -- And sap mana.
                ttable.vitals.mp = ttable.vitals.mp - ((manaDamage or 0) * ttable.vitals.maxmp);
                NU.setFlag("LAST_MANA_DAMAGE", {skill = skill, ability = ability, amount = ((manaDamage or 0) * ttable.vitals.maxmp)});
                if (ttable.vitals.mp >= ttable.vitals.maxmp) then
                    ttable.vitals.mp = ttable.vitals.maxmp;
                end
                if (ttable.vitals.mp < ttable.vitals.maxmp * 0.25) then
                    TRACK.aff(ttable, "burnout");
                    NU.setFlag(ttable.name .. "_remove_burnout", true, 20, function() TRACK.cure(ttable, "burnout"); end);
                end

                local hpAmount = 100 * ttable.vitals.hp / ttable.vitals.maxhp;
                local mpAmount = 100 * ttable.vitals.mp / ttable.vitals.maxmp;
                local hpString = string.format("%.2f", hpAmount);
                local mpString = string.format("%.2f", mpAmount);
                local hpColor = hpAmount > 75 and "<green>" or (hpAmount > 25 and "<yellow>" or "<red>");
                local mpColor = hpAmount > 75 and "<navy>" or (hpAmount > 25 and "<dodger_blue>" or "<white>");

                NU.promptAppend("target_hp_mp", ttable.name .. ": " .. hpColor .. hpString .. " - " .. mpColor .. mpString .. "<reset>");
            end
            -- TODO: Balance

            if (limbDamage) then
                local damageLimb = limbDamage.no_break;
                limbDamage.no_break = nil;

                for limb, limb_damage in pairs(limbDamage) do
                    OFFENSE.general.trackParryModeOnHit(limb, false);
                    -- TODO: Better targeting rune impl.
                    limb_damage = abTable.canHitRebounding and limb_damage * 1.05 or limb_damage;
                    TRACK.damageLimb(ttable, limb, limb_damage, damageLimb)
                end
            else
                NU.WARN("Error - " .. skill .. " - " .. ability .. ": invalid limb damage return.")
            end
        end
    end

    -- Fire off any 'other effects' - in Elemancy's case this will be flamewreath.
    abTable.postEffects(atable, ttable, data);

    TRIG.disable(TRIGS.apply_attack);
    NU.clearPFlag("attack_to_apply");
end