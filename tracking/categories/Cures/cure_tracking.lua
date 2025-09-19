local function limbRestoCheck(ttable, aff)
    local flag = FLAGS[ttable.name .. "_resto_applied"];
    local location = flag and flag[2];
    if (flag) then
        local _, expectedCure = TRACK.getCureData(ttable, "poultice", "restoration", location);
        if (expectedCure == aff) then
            return true;
        end
    end
    return false;
end

local function brokenLimbCheck(ttable, restoAff, queue)
    local willRestoCure = limbRestoCheck(ttable, restoAff);
    local queueIsPoultice = (queue == "poultice");
    local haveRestoAff = ttable.affs[restoAff];
    local mendingBlocked = haveRestoAff and not willRestoCure;

    if (queueIsPoultice) then -- I think I could have gotten away with return (queueIsPoultice and mendingBlocked) or haveRestoAff instead, but this works.
        return mendingBlocked
    end
    return haveRestoAff;
end

local function mendingBlockerCheck(ttable, queue, aff, curing)
    if (curing) then
        return brokenLimbCheck(ttable, aff, queue);
    else
        return ttable.affs[aff];
    end
end

local blockedConditions = {
    left_arm_crippled = function(ttable, queue, curing) return mendingBlockerCheck(ttable, queue, "left_arm_broken", curing); end,
    right_arm_crippled = function(ttable, queue, curing) return mendingBlockerCheck(ttable, queue, "right_arm_broken", curing); end,
    left_leg_crippled = function(ttable, queue, curing) return mendingBlockerCheck(ttable, queue, "left_leg_broken", curing); end,
    right_leg_crippled = function(ttable, queue, curing) return mendingBlockerCheck(ttable, queue, "right_leg_broken", curing); end,

    left_arm_bruised = function(ttable, queue, curing) return mendingBlockerCheck(ttable, queue, "left_arm_broken", curing); end,
    right_arm_bruised = function(ttable, queue, curing) return mendingBlockerCheck(ttable, queue, "right_arm_broken", curing); end,
    left_leg_bruised = function(ttable, queue, curing) return mendingBlockerCheck(ttable, queue, "left_leg_broken", curing); end,
    right_leg_bruised = function(ttable, queue, curing) return mendingBlockerCheck(ttable, queue, "right_leg_broken", curing); end,

    left_arm_bruised_moderate = function(ttable, queue, curing) return mendingBlockerCheck(ttable, queue, "left_arm_broken", curing); end,
    right_arm_bruised_moderate = function(ttable, queue, curing) return mendingBlockerCheck(ttable, queue, "right_arm_broken", curing); end,
    left_leg_bruised_moderate = function(ttable, queue, curing) return mendingBlockerCheck(ttable, queue, "left_leg_broken", curing); end,
    right_leg_bruised_moderate = function(ttable, queue, curing) return mendingBlockerCheck(ttable, queue, "right_leg_broken", curing); end,

    hypothermia = function(ttable, queue, _) return queue ~= "poultice" and ttable.affs.frostbrand or false; end,
    shivering = function(ttable, queue, _) return ttable.affs.frozen and queue == "poultice"; end,
    frozen = function(ttable, queue, _) return queue ~= "poultice" and ttable.affs.frostbrand or false; end,
    gloom = function(_, _, _) return FLAGS.gloom_cure; end,

    ablaze = function(ttable, _, _) return ttable.affs.heatspear; end,
    SUPER_ABLAZE = function(ttable, _, _) return ttable.affs.heatspear; end,

    left_arm_broken = function(ttable, _, _) return limbRestoCheck(ttable, "left_arm_broken"); end,
    right_arm_broken = function(ttable, _, _) return limbRestoCheck(ttable, "right_arm_broken"); end,
    left_leg_broken = function(ttable, _, _) return limbRestoCheck(ttable, "left_leg_broken"); end,
    right_leg_broken = function(ttable, _, _) return limbRestoCheck(ttable, "right_leg_broken"); end,
    PRONE_LEFT_LEG_BROKEN = function(ttable, _, _) return limbRestoCheck(ttable, "left_leg_broken"); end,
    PRONE_RIGHT_LEG_BROKEN = function(ttable, _, _) return limbRestoCheck(ttable, "right_leg_broken"); end,
    torso_broken = function(ttable, _, _) return limbRestoCheck(ttable, "torso_broken"); end,
    head_broken = function(ttable, _, _) return limbRestoCheck(ttable, "head_broken"); end,

    left_arm_mangled = function(ttable, _, _) return limbRestoCheck(ttable, "left_arm_mangled"); end,
    right_arm_mangled = function(ttable, _, _) return limbRestoCheck(ttable, "right_arm_mangled"); end,
    left_leg_mangled = function(ttable, _, _) return limbRestoCheck(ttable, "left_leg_mangled"); end,
    right_leg_mangled = function(ttable, _, _) return limbRestoCheck(ttable, "right_leg_mangled"); end,
    torso_mangled = function(ttable, _, _) return limbRestoCheck(ttable, "torso_mangled"); end,
    head_mangled = function(ttable, _, _) return limbRestoCheck(ttable, "head_mangled"); end,

    -- Blockers for delayed defenses that we're controlling via the defs system.
    no_rebounding = function(ttable, _) return TRACK.isSelf(ttable) and not DEFS.actions.rebounding.pipe.ab.meetsPreReqs(ttable); end,
    no_speed = function(ttable, _) return TRACK.isSelf(ttable) and not DEFS.actions.speed.sip.ab.meetsPreReqs(ttable); end,
}

-- TODO: Add 'will resto cure' to this batch to allow for the left_arm_crippled etc affs to no longer be blocked.
function TRACK.cannotCure(ttable, aff, queue, curing)
    return blockedConditions[aff] and blockedConditions[aff](ttable, queue, curing) or false;
end

-- Given a target table, return the first aff found in that table.
-- Was going to make it 'n' affs, but I don't think there's any reason to do that.
function TRACK.expectedCure(ttable, cureTable, failureList, bypassList)
    local failed = failureList or {};
    local bypass = bypassList or {};

    if (ttable.affs.dread) then
        failed.blight = true;
        failed.infestation = true;
    end

    for k,v in pairs(AFFS.sealAffs) do
        if (ttable.affs[k]) then
            bypassList = table.union(bypassList, v);
        end
    end

    if (cureTable) then
        for _,v in ipairs(cureTable) do
            local is_def = AFFS.defs[v];
            if (ttable.affs[v] and not bypass[v]) then
                if (failed[v] or TRACK.cannotCure(v)) then
                    return nil;
                else
                    return v;
                end
            elseif (not ttable.defs.rebounding and v == "no_rebounding") then -- TODO: Remove this hack for tracking reishi smoke on targets after fixing all def strip abilities (razes) to apply no_defense.
                return v, nil;
            elseif (is_def) then
                return v, is_def;
            end
        end
    end
    return nil;
end

function TRACK.nameCure(tname, aff)
    TRACK.cure(TRACK.get(tname), aff);
end

function TRACK.cure(ttable, aff, def)
    if (PFLAGS.illusion) then NU.ECHO("Illusion"); return; end
    if (not ttable) then return; end
    if (not aff) then return; end
    local isSelf = TRACK.isSelf(ttable);

    if (isSelf and PFLAGS.gmcp_rem_aff and not PFLAGS.gmcp_rem_aff[aff]) then
        NU.DECHO("Illusioned cure for " .. aff, 3);
        return;
    end

    if (isSelf) then
        NU.appendPFlag("action_order", {"cure", aff, PFLAGS.next_cure, def = def});
        NU.clearPFlag("next_cure");
    end
    if ((ttable and ttable.affs[aff]) or def) then
        if (ttable and ttable.affs[aff]) then ttable.affs[aff] = false; end -- TODO: clean this up, kinda just had to hack in blindness and deafness cures as defense cures here - but clear_blindness and clear_deafness aren't actually AFFS.

        if (FLAGS.pending_cures) then
            FLAGS.pending_cures[aff] = nil;
        end

        NU.appendPFlag("output_affs", ttable.name, true);
    elseif (isSelf) then
        TRACK.hiddenDiscovery(ttable, aff);
    end

    NU.DECHO("Cure: " .. ttable.name .. " " .. aff .. ": ", 1);
end

function TRACK.hpchange(ttable, health, mana)
    if (PFLAGS.illusion) then return; end
    ttable.vitals.hp = ttable.vitals.hp + health;
    ttable.vitals.mp = ttable.vitals.mp + mana;

    if (ttable.vitals.mp < 0) then
        ttable.vitals.mp = 0;
    elseif (ttable.vitals.mp > ttable.vitals.maxmp) then
        ttable.vitals.mp = ttable.vitals.maxmp;
    end

    if (ttable.vitals.hp < 0) then
        ttable.vitals.hp = 0;
        NU.DECHO("How are they not dead?", 5);
    elseif (ttable.vitals.hp > ttable.vitals.maxhp) then
        ttable.vitals.hp = ttable.vitals.maxhp;
    end
end

function TRACK.heal(ttable, health, mana)
    TRACK.hpchange(ttable, health, mana);
end

function TRACK.damage(ttable, health, mana)
    health = health or 0;
    mana = mana or 0;
    TRACK.hpchange(ttable, -health, -mana);
end

local function randomExpect(...)
    return "random";
end

TRACK.actionsTable = {
    eat = {
        convert = CONVERT.pillLTS,
        baseCures = CURES.pill,
        defenses = {
            amaurosis = "blindness",
            ototoxin = "deafness",
        },
        balCon = {
            anabiotic = {"anabiotic", BALANCE_DATA.anabiotic},
            panacea = {"pill", BALANCE_DATA.panacea_pill},
            other = {"pill", BALANCE_DATA.pill},
        },
        healMap = {
            anabiotic = {0.1, 0.1};
        },
        hiddenClear = "anorexia",
        color = "SpringGreen",
    },

    focus = {
        baseCures = CURES.focus,
        balCon = {
            other = {"focus", BALANCE_DATA.focus, nil, function(ttable) return ttable.affs.delirium and 2 or 1 end},
        },
        hiddenClear = "impatience",
        color = "navy",
    },

    poultice = {
        baseCures = CURES.poultice,
        balCon = {
            restoration = {"poultice", BALANCE_DATA.restoration_poultice},
            other = {"poultice", BALANCE_DATA.poultice},
        },
        hiddenClear = "slickness",
        color = "ansiMagenta",
    },

    resto_apply = {
        color = "DarkViolet"
    },

    self_sip = {
        baseCures = CURES.elixir,
        defenses = { -- This might not be needed.
            arcane = "arcane",
            levitation = "levitation",
        },
        balCon = {
            health = {"elixir", BALANCE_DATA.health},
            mana = {"elixir", BALANCE_DATA.health},
            infusion = {"elixir", BALANCE_DATA.health},
            other = {"elixir", BALANCE_DATA.other_elixir}
        },
        healMap = {
            health = {0.25, 0},
            mana = {0, 0.25},
        },
        hiddenClear = "anorexia",
        color = "gold",
    },

    targ_sip_revealed = {
        baseCures = CURES.elixir,
        balCon = {
            health = {"elixir", BALANCE_DATA.health},
            mana = {"elixir", BALANCE_DATA.health},
            infusion = {"elixir", BALANCE_DATA.health},
            other = {"elixir", BALANCE_DATA.other_elixir}
        },
        healMap = {
            health = {0.25, 0},
            mana = {0, 0.25},
        },
        hiddenClear = "anorexia",
        color = "gold",
    },

    tree = {
        balCon = {
            other = {"tree", BALANCE_DATA.tree},
        },
        expectFunc = randomExpect,
        color = "cyan",
    },

    renew = {
        balCon = {
            other = {"renew", BALANCE_DATA.renew},
        },
        expectFunc = randomExpect,
        hiddenClear = "impairment",
    },

    smoke = {
        baseCures = CURES.pipe,
        balCon = {
            other = {"pipe", BALANCE_DATA.smoke},
        },
        hiddenClear = "asthma",
        color = "SlateGray",
    },

    -- TODO: Remove concentrate if not necessary.
    concentrate = {
        baseCures = {"disrupted"},
        balCon = {
            other = {"equilibrium", 4};
        },
        hiddenClear = "confusion",
    },

    -- misc random.
    random = {
        expectFunc = function(...) return "random"; end
    },
}

local nilFunc = function(ttable) return nil; end
local oneFunc = function(ttable) return 1; end

-- Slightly faster lookups by not needing to seek this every time.
local actionsTable = TRACK.actionsTable;

function TRACK.getCureData(ttable, action, cure, location)
    local cureS = actionsTable[action].convert and actionsTable[action].convert[cure] or cure;
    local balancesToUse = (actionsTable[action].balCon and (actionsTable[action].balCon[cureS] or actionsTable[action].balCon.other)) or nil;
    local expectFunc = actionsTable[action].expectFunc or TRACK.expectedCure;
    local healMap = actionsTable[action].healMap;

    NU.DECHO("GCD " .. tostring(ttable.name) .. ": " .. tostring(action) .. ", " .. tostring(cureS) .. ", " .. tostring(location), 4);
    if (balancesToUse) then
        TRACK.useBalance(ttable, balancesToUse[1], balancesToUse[2], nil, (balancesToUse[3] or nilFunc)(ttable), (balancesToUse[4] or oneFunc)(ttable));
    end

    local cureTable = actionsTable[action].baseCures;
    if (cureS) then
        cureTable = cureTable[cureS];
    end
    if (location) then
        cureTable = cureTable[location];
    end

    if (healMap and healMap[cureS]) then
        if (healMap[cureS][1] > 0) then
            NU.setFlag("LAST_HP_HEAL", {source = cureS, amount = healMap[cureS][1] * ttable.vitals.maxhp});
        end
        if (healMap[cureS][2] > 0) then
            NU.setFlag("LAST_MP_HEAL", {source = cureS, amount = healMap[cureS][2] * ttable.vitals.maxmp * (ttable.affs.burnout and 0.5 or 1)});
        end
        TRACK.heal(ttable, healMap[cureS][1] * ttable.vitals.maxhp, healMap[cureS][2] * ttable.vitals.maxmp * (ttable.affs.burnout and 0.5 or 1));
    end
    local defTable = actionsTable[action].defenses;

    -- TODO: This is technically not the correct spot for this.
    if (defTable and defTable[cureS]) then
        TRACK.addDef(ttable, defTable[cureS]);
    end

    local expectedCure, expectedDef = expectFunc(ttable, cureTable);

    return cureS, expectedCure, cureTable, expectedDef;
end

local function replaceCureLine(ttable, cureS, expectedCure, location, action)
    local isSelf = TRACK.isSelf(ttable);
    if (isSelf) then
        local otherCures = PFLAGS.extra_cure_notifications or {};
        local outputLine = "<green>[SELF]: -" ..
            (expectedCure and ("<" .. UTIL.affColors[expectedCure] .. ">" .. expectedCure) or "NO CURE") ..
            " (" ..
            (action and ("<" .. (TRACK.actionsTable[action].color or "white") .. ">" .. action) or "MISSING_ACTION") ..
            (((cureS or location) and true or false) and (": " .. (cureS or "") .. (location and (" - " .. location) or "")) or "") ..
            ")";
        for _, v in ipairs(otherCures) do
            outputLine = v .. "\n" .. outputLine;
        end

        if (NU.config.gags.cure_formatter) then
            creplaceLine(outputLine);
        end
    else
        local otherCures = PFLAGS.extra_cure_notifications or {};
        local outputLine = "<red>[" ..
            ttable.name:upper() ..
            "]: <green>-" ..
            (expectedCure and ("<" .. UTIL.affColors[expectedCure] .. ">" .. expectedCure) or "NO CURE") ..
            " (" ..
            (action and ("<" .. (TRACK.actionsTable[action].color or "white") .. ">" .. action) or "MISSING_ACTION") ..
            (((cureS or location) and true or false) and (": " .. (cureS or "") .. (location and (" - " .. location) or "")) or "") ..
            ")";
        for _, v in ipairs(otherCures) do
            outputLine = v .. "\n" .. outputLine;
        end

        -- TODO: fix these, remove the replacement.
        if (NU.config.gags.cure_formatter) then
            creplaceLine(outputLine);
        end
    end
end

-- TODO: Split this into each category of cures. DRY is nice but this has gotten absurd.
function TRACK.cureAction(target, action, cure, location, flags)
    if (PFLAGS.illusion) then return; end
    local ttable = TRACK.get(target);

    if ((action == "targ_sip" or action == "targ_sip_revealed") and ttable.affs.whiplash) then
        TRACK.damageLimb(ttable, "head", 6.5, not ttable.affs.stiffness);
    end

    -- For the case where a target applied resto and applies another poultice.
    -- TODO: Pull this out of this function and the resto applied function, give it its own function. Only call it when a poultice is applied.
    if (action == "poultice") then
        -- TODO: This is checking the existence of the flag twice.
        NU.DECHO("\nPoultice cure " .. tostring(FLAGS[ttable.name .. "_resto_applied"]) .. ": ", 6);
        if (FLAGS[ttable.name .. "_resto_applied"]) then
            NU.DECHO("\nPoultice, running check resto cure.\n", 6);
            TRACK.checkRestoCure(ttable.name);
            NU.clearFlag(ttable.name .. "_resto_applied");
        end
    end

    local skipReplace = false;
    if (action == "focus") then
        local muddleFlag = FLAGS[ttable.name .. "_muddled_strip"];
        -- Add some wiggle room to muddleFlag.
        if ((ttable.affs.muddled and not muddleFlag) or (muddleFlag and ttable.affs.muddled and muddleFlag <= NU.time())) then
            ttable.affs.muddled = false;
        else
            skipReplace = true;
            echo("\n" ..
                tostring(muddleFlag) ..
                "\n" ..
                tostring(ttable.affs.muddled) ..
                "\n" ..
                tostring(muddleFlag and muddleFlag <= NU.time()) ..
                " t: " .. tostring(NU.time()) .. "\n");
        end
    end
    local cureS, expectedCure, cureTable, expectedDef = TRACK.getCureData(ttable, action, cure, location);
    local isSelf = TRACK.isSelf(ttable);

    -- TODO: I don't like these two being here like this, but I couldn't think of anything cleaner at the time.
    --     The triggers are already doing some weird shit by passing in the flags when nothing else does, but I need to interrupt the usual self flag setting
    --     and add some method for triggering the target affs at the correct timing.
    --     Note that with this setup we'll also need to clear the flag if we see something that strips speed or rebounding.
    if (flags and flags.speed and expectedCure == "no_speed") then
        local exTime = 6.5 + TRACK.latency();
        ttable.actions.exSpeed = NU.time() + exTime;
        local speedFunc = function() TRACK.cure(ttable, "no_speed"); end
        NU.setFlag(ttable.name .. "_speed", ttable.actions.exSpeed, exTime, not isSelf and speedFunc or nil);
        return;
    end

    if (flags and flags.rebounding and expectedCure == "no_rebounding") then
        local exTime = BALANCE_DATA.rebounding.mean + BALANCE_DATA.rebounding.stdDev * 2
        ttable.actions.exRebound = NU.time() + exTime;
        local reboundFunc = function() TRACK.cure(ttable, "no_rebounding"); end
        NU.setFlag(ttable.name .. "_rebounding", ttable.actions.exRebound, exTime, not isSelf and reboundFunc or nil);
        return;
    end

    if (not isSelf) then
        TRACK.cure(ttable, expectedCure);
        TRACK.addDef(ttable, expectedDef);
        NU.DECHO("EXPECTED TARGET: " .. tostring(action) .. ", " .. tostring(cureS) .. ", " .. tostring(location) .. " , " .. tostring(expectedCure), 4);

        if (ttable.affs.thunderbrand and action == "focus") then
            TRACK.damage(ttable, 250, 250);
        end
    else
        if (actionsTable[action].hiddenClear) then
            TRACK.ruleOutHidden(ttable, actionsTable[action].hiddenClear);
        end

        -- User targetted - this is handled on prompt.
        NU.setPFlag("next_cure", action);
        NU.setPFlag(action, {cureS, location});
        NU.setPFlag("ex_"..action.."_cure", expectedCure);
        if (expectedCure == "gloom") then
            NU.setFlag("gloom_curing", true, 3);
        end
        NU.setPFlag(action .. "_cure_table", cureTable);
        NU.appendPFlag("cure_actions", action);

        if (action == "eat") then
            NU.setFlag("last_eat", cureS, 3600);
        end

        NU.DECHO("EXPECTED: " .. tostring(action) .. ", " .. tostring(cureS) .. ", " .. tostring(location) .. " , " .. tostring(expectedCure), 5);
        TRIG.enable(TRIGS.cure_msg);
    end
    if (not skipReplace) then
        replaceCureLine(ttable, cureS or cure, expectedCure, location, action);
    end
end

function TRACK.appliedRestoration(target, location)
    if (PFLAGS.illusion) then return; end
    local ttable = TRACK.get(target);

    if (FLAGS[ttable.name .. "_resto_applied"]) then
        TRACK.checkRestoCure(ttable.name);
        NU.clearFlag(ttable.name .. "_resto_applied");
    end

    local cureS, expectedCure = TRACK.getCureData(ttable, "poultice", "restoration", location);
    local isSelf = TRACK.isSelf(ttable);

    local data = BALANCE_DATA.restoration_poultice;
    local func = function() TRACK.checkRestoCure(ttable.name); end

    local delay = data.mean + data.stdDev * 2.4;

    -- TODO: If location is skin, try to pull the limb from the cure we're actually doing.
    NU.setFlag(ttable.name .. "_resto_applied", {ttable.name, location, expectedCure, NU.time() + delay}, delay, isSelf and nil or func);
    -- And replace the line.

    replaceCureLine(ttable, "resto_apply", expectedCure, location, "poultice");
end

local testableLocations = {
    skin = true,
    legs = true,
    arms = true
}
-- Called on poultice applications and after the timer from appliedRestoration expires. We should know our own poultice cure, and if it didn't fizzle on application we know our cure was going to go through.
function TRACK.checkRestoCure(target)
    NU.DECHO("\nChecking for resto cure for " .. target .. ":", 6);
    local ttable = TRACK.get(target);
    local isSelf = TRACK.isSelf(ttable);

    local flag = FLAGS[ttable.name .. "_resto_applied"];
    local location = flag and flag[2] or "none";

    if (flag and not isSelf) then
        NU.DECHO(" Found resto cure for " .. target .. "\n", 6);
        -- Recalculate expected cure in case they got something else:
        local cureS, expectedCure = TRACK.getCureData(ttable, "poultice", "restoration", location);
        -- Need to determine actual location if it's legs/arms/skin.
        if (testableLocations[location]) then
            -- Extract the limb from the aff name:

        end

        local limbDamage = 0;
        -- Handle limb damage:
        if (not (expectedCure == "heatspear" or expectedCure == "crushed_chest" or expectedCure == "deepwound")) then
            limbDamage = TRACK.restoLimb(ttable, location);
            if (not limbDamage) then
                display("What the shit.");
                display(location);
                display(flag);
                display(expectedCure);
                -- This is a band-aid. Sort out the resto cure bit.
                limbDamage = 100.0;
            end
        end

        if (expectedCure) then
            local mangleCure = expectedCure:find("mangled");
            local brokenCure = expectedCure:find("broken")
            if ((not mangleCure and not brokenCure) or (limbDamage < 2 / 3 * 100 and mangleCure) or (limbDamage < 1 / 3 * 100 and brokenCure)) then
                TRACK.cure(ttable, expectedCure);
            end
            local restoLine = "\n<red>[" ..
                ttable.name:upper() ..
                "]: <green>-" ..
                (expectedCure or "NO CURE") ..
                " (" ..
                ("RESTORATION") ..
                ": " .. (location and (" - " .. location) or "") .. ")";
            cecho(restoLine);
            NU.appendPFlag("extra_cure_notifications", restoLine);
        end
    end
end