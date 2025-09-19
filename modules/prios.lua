PRIOS = {};
local refAffTable = NU.buildAffTable();

local function printMissing(missingPrios, priosWithoutAffs, class)
    if (#missingPrios > 0) then
        NU.WARN("Found " .. tostring(#missingPrios) .. " missing prios for <green>" .. class .. "<reset>: " .. table.concat(missingPrios, ","));
    end
    if (#priosWithoutAffs > 0) then
        NU.WARN("Found " .. tostring(#priosWithoutAffs) .. " prios with no aff in the table for <green>" .. class .. "<reset>: " .. table.concat(priosWithoutAffs, ","));
    end
end

local function testOneDepthPrios(priorityList, cureTable, class, ret)
    local missingPrios = {};
    local priosWithoutAffs = {};
    for cure,cureList in pairs(cureTable) do
        if (cure ~= "thanatonin" and cure ~= "kawhe" and cure ~= "acuity") then
            for _,aff in ipairs(cureList) do
                if ((cure ~= "opiate" or aff ~= "slickness") and aff ~= "clear_insomnia" and aff ~= "plodding" and aff ~= "idiocy" and aff ~= "no_speed") then
                    local foundAffInPrios = false;
                    for _,prioAff in ipairs(priorityList) do
                        if (aff == prioAff) then
                            foundAffInPrios = true;
                        end
                    end
                    if (not foundAffInPrios) then
                        table.insert(missingPrios, aff);
                    end
                end
            end
        end
    end

    for _,prioAff in ipairs(priorityList) do
        if (refAffTable[prioAff] == nil) then
            table.insert(priosWithoutAffs, prioAff);
        end
    end

    if (not ret) then
        printMissing(missingPrios, priosWithoutAffs, class);
    else
        return missingPrios, priosWithoutAffs;
    end
end

local function testTwoDepthPrios(priorityList, cureTable, class)
    local missingPrios = {};
    local priosWithoutAffs = {};
    for _,v in pairs(cureTable) do
        local mP, pWA = testOneDepthPrios(priorityList, v, class, true)
        missingPrios = table.n_union(missingPrios, mP);
        priosWithoutAffs = table.n_union(priosWithoutAffs, pWA);
    end

    printMissing(missingPrios, priosWithoutAffs, class);
end

-- Default Class Prios (not customized per class)
--nu.load("prios/default", "default")();
NU.loadAll("prios");

-- nil out the unused tables.
for _, classTables in pairs(PRIOS) do
    for prioClass, prioTables in pairs(classTables) do
        if (table.size(prioTables) == 0) then
            classTables[prioClass] = nil;
        end
    end
end

local prioClassMetatable = {
    __index = function(t, k)
        return rawget(t, UTIL.classMirrors[k]);
    end
}

setmetatable(PRIOS, prioClassMetatable);

-- Set prios to default.
local priosMetaTable = {
    __index = function(t, k)
        return PRIOS.default.generic[k];
    end
}

for currentClass, classTables in pairs(PRIOS) do
    for prioClass, prioTables in pairs(classTables) do
        if (currentClass ~= "default" or prioClass ~= "generic") then
            setmetatable(prioTables, priosMetaTable);
        end
    end
end

PRIOS.active = PRIOS.default.generic;

local oneDepthToTest = {
    "pill", "elixir", "pipe"
}

local twoDepthToTest = {
    "poultice"
}

local classList = table.n_union({"generic"}, UTIL.classList);

for _,v in ipairs(classList) do
    NU.DECHO("Testing " .. v .. " prios:\n", 3);
    local prioSet = PRIOS.default[v:lower()];

    if (prioSet) then
        for _,group in ipairs(oneDepthToTest) do
            if (prioSet[group]) then
                NU.DECHO("Testing " .. v .. " prios " .. group .. ":\n", 3);
                testOneDepthPrios(prioSet[group], CURES[group], v);
            end
        end
        for _,group in ipairs(twoDepthToTest) do
            if (prioSet[group]) then
                NU.DECHO("Testing " .. v .. " prios " .. group .. ":\n", 3);
                testTwoDepthPrios(prioSet[group], CURES[group], v);
            end
        end
    else
       cecho("<red>No prios for " .. v .. "\n");
    end
end

echo("\n");

ALIAS.register("set_prios", [[^pr (.+)$]], function()
    local prios = matches[2]:lower();
    local classPrios = PRIOS[NU.getClass()] and PRIOS[NU.getClass()][prios] or nil;
    local basePrios = PRIOS.default[prios];
    if (classPrios) then
        PRIOS.active = classPrios;
        NU.ECHO(matches[2] .. ": <green>ACTIVE");
        NU.setFlag("recent_attack", true, 10);
    elseif (basePrios) then
        PRIOS.active = basePrios;
        NU.ECHO(matches[2] .. ": <green>ACTIVE");
        NU.setFlag("recent_attack", true, 10);
    else
      NU.ECHO("Either prios not found or in TODO category.");
    end
end)