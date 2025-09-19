local ele = AB.Elemancy;
local arc = AB.Arcanism;
local thaum = AB.Thaumaturgy;
local tatt = AB.Tattoos;

function AUTOBASH.classes.ascendril(act, willCure, randomCureCount)
    local stable = TRACK.getSelf();
    local saffs = stable.affs;
    local queuedAfflictions = {};

    local hpPercent = stable.vitals.hp / stable.vitals.maxhp;
    local bleed = stable.vitals.bleeding;

    local canStall = false;

    -- local target = AUTOBASH.target;
    AUTOBASH.genericPickTarget();
    if (not AUTOBASH.target) then
        NU.promptAppend("BTARG", "No btarg");
        return;
    end

    local choice = ele.Arcbolt;

    if (FLAGS.mob_shield) then
        choice = ele.Windlance;
    end

    local syntax = "";
    if (not choice.syntax.ascendril) then
        syntax = "cast arcbolt $target";
        act.eqbalConsuming:put({syntax = syntax, bal = choice.balance(stable).self.bal, attack = true}, 3);
        return;
    end
    syntax = choice.syntax.ascendril:gsub("$target2", "");
    syntax = choice.syntax.ascendril:gsub("$target", AUTOBASH.target.id);
    syntax = syntax:gsub(" $empowerment", "");
    syntax = syntax:gsub(" $limb", " torso");

    if (FLAGS.prism_mode) then
        -- Here's a little bit tricksy - we basically always want to prism, but we have to crit enough for it to be worthwhile.
        -- We also don't want to get obliterated.
        -- So, basing this off the aggro count and mob count. We're tying this into the AHH bits for now so I can copypasta it for Aloli.
        local prismCount = FLAGS.prism_count or 5;

        if (#AUTOBASH.aggroQueue < prismCount and #AUTOBASH.aggroQueue > 1) then
            syntax = syntax:gsub("cast ", "cast prism ");
        end
    end

    -- if (hpPercent <= 0.45 and arc.Reflection.meetsPreReqs(stable) and not stable.defs.reflection) then
    --     choice = arc.Reflection;
    --     syntax = choice.syntax.ascendril;
    -- elseif (hpPercent <= 0.4 and not stable.defs.shielded) then
    --     choice = tatt.Shield;
    -- end;

    if ((stable.defs.reflection or stable.defs.shielded) and hpPercent < 0.75 and not (choice == tatt.Shield or choice == arc.Reflection)) then
        return;
    end
    act.eqbalConsuming:put({syntax = syntax, bal = choice.balance(stable).self.bal, attack = true}, 3);
end