TRIG = TRIG or {};
TRIGS = TRIGS or {};
TRIG_CAT = {};

-- Initialize the nusys group.
-- permGroup(name, itemtype, parent)
--   where itemtype is trigger, alias, timer, script, or key
--   where parent is the NAME of the existing item to create this under.
local function createGroupIfNotExists(name, itemtype, parent)
    if (exists(name, itemtype) == 0) then
        permGroup(name, itemtype, parent);
    else
        NU.DECHO("Skipped creating " .. name .. " with item type " .. itemtype, 5);
    end
end

createGroupIfNotExists("NU", "alias");
createGroupIfNotExists("NU", "trigger");
createGroupIfNotExists("NU", "timer");
createGroupIfNotExists("NU", "script");
createGroupIfNotExists("NU", "key");

function TRIG.register(name, typ, match, func, category, description, skipAntiIllusion)
    if (TRIGS[name]) then
        local trigger = TRIGS[name];
        killTrigger(trigger.id);

        if (trigger.category and TRIG_CAT[trigger.category]) then
            local index = table.index_of(TRIG_CAT[trigger.category], name);
            if (index) then
                table.remove(TRIG_CAT[trigger.category], index);
            end
        end
        TRIGS[name] = nil;
    end

    local trig = nil;
    description = description or "Undescribed";
    category = category or "NONE";

    if (not skipAntiIllusion) then
        local originalFunc = func;
        local newFunc = function()
            if (PFLAGS.illusion and not skipAntiIllusion) then
                cecho("<red> - Illusion"); return;
            end
            originalFunc();
        end
        func = newFunc;
    end

    if (not typ or typ == "substr") then
        trig = tempTrigger(match, func);
    elseif (typ == "start") then
        trig = tempBeginOfLineTrigger(match, func);
    elseif (typ == "exact") then
        trig = tempExactMatchTrigger(match, func);
    elseif (typ == "prompt") then
        trig = tempPromptTrigger(func);
    elseif (typ == "regex") then
        trig = tempRegexTrigger(match, func);
    else
        cecho("<red>Unsupported trigger type: " .. typ);
        return nil;
    end


    TRIGS[name] = {id = trig, match = match or "", category = category, description = description};

    TRIG_CAT[category] = TRIG_CAT[category] or {};
    table.insert(TRIG_CAT[category], name);
end

-- The very first triggers should be anti-illsuion so these fire before literally anything else.
TRIG.register("end_illusion", "prompt", nil, function() NU.clearPFlag("illusion"); NU.clearPFlag("illusion_instances"); end, "Anti-Illusion", "For testing for illusions", true);
TRIG.register("some_illusion", "exact", [[** Illusion **]], function()
    if ((PFLAGS.illusion_instances and PFLAGS.illusion_instances >= 2) or PFLAGS.illusion) then
        PFLAGS.illusion = nil;
        PFLAGS.illusion_instances = PFLAGS.illusion_instances + 1;
    else
        NU.setPFlag("illusion", true);
        NU.setPFlag("illusion_instances", 0);
    end
end, "Anti-Illusion", "For testing for illusions", true);


function TRIG.disable(trigger)
    disableTrigger(trigger.id);
end

function TRIG.enable(trigger)
    enableTrigger(trigger.id);
end

ALIAS = ALIAS or {};
ALIASES = ALIASES or {};
ALIAS_CAT = {};

function ALIAS.register(name, regex, func, category, description)
    if (ALIASES[name]) then
        local alias = ALIASES[name];
        -- for conversion
        if (type(alias) == "number") then
            killAlias(alias);
        else
            killAlias(alias.id);
        end
    end

    description = description or "Undescribed";
    category = category or "NONE";

    ALIASES[name] = {id = tempAlias(regex, func), category = category, match = regex, description = description};

    ALIAS_CAT[category] = ALIAS_CAT[category] or {};
    table.insert(ALIAS_CAT[category], name);
end

local function displayByCategory(objectCategoryTable, objectTable, objectName, category)
    if (category == "") then
        NU.ECHO(objectName .. " Categories:\n");
        for k,_ in pairs(objectCategoryTable) do
            echo("    ");
            echo(k);
            echo("\n");
        end
    elseif (objectCategoryTable[category]) then
        NU.ECHO(objectName .. "s in the " .. category .. " category:\n");
        for i,name in ipairs(objectCategoryTable[category]) do
            echo(" ");
            echo(i);
            echo(": ");
            echo(name);
            echo(" - ");
            echo(objectTable[name].match);
            echo(" - ");
            echo(objectTable[name].description);
            echo("\n");
        end
    else
        NU.ECHO("The trigger category " .. category .. " does not exist.");
    end
end

local function displayTriggers(category)
    displayByCategory(TRIG_CAT, TRIGS, "Trigger", category);
end

local function displayAliases(category)
    displayByCategory(ALIAS_CAT, ALIASES, "Alias", category);
end

ALIAS.register("Display Triggers", [[^NU TRIGS\s*(\w*)$]], function() displayTriggers(matches[2]); end);
ALIAS.register("Display Aliases", [[^NU CMDS\s*(\w*)$]], function() displayAliases(matches[2]); end);