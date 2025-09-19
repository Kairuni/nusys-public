-- Sanity check
local zeroDepthCategories = {
    "other",
    "time",
    "focus",
};

local oneDepthCategories = {
    "pill",
    "pipe",
    "elixir",
};

local twoDepthCategories = {
    "poultice",
};

local mapCategories = {
    "writhe",
    "defense",
};

local mapToCureCategories = {
};

local missingAffs = {};

local hasCure = NU.buildAffTable();

for _,category in ipairs(zeroDepthCategories) do
    for _,aff in ipairs(CURES[category]) do
        if (not table.contains(AFFS.readable, aff) and not table.contains(AFFS.readable, "m_" .. aff)) then -- This is the only category with mirrored affs for now.
            missingAffs[aff] = true;
        end

        hasCure[aff] = true;
    end
end

for _,category in ipairs(oneDepthCategories) do
    for subcategory,_ in pairs(CURES[category]) do
        for _,aff in ipairs(CURES[category][subcategory]) do
            if (not table.contains(AFFS.readable, aff)) then
                missingAffs[aff] = true;
            end

            hasCure[aff] = true;
        end
    end
end

for _,category in ipairs(twoDepthCategories) do
    for subcategory,_ in pairs(CURES[category]) do
        for limb,_ in pairs(CURES[category][subcategory]) do
            for _,aff in ipairs(CURES[category][subcategory][limb]) do
                if (not table.contains(AFFS.readable, aff)) then
                    missingAffs[aff] = true;
                end
                hasCure[aff] = true;
            end
        end
    end
end

for _,category in pairs(mapCategories) do
    for aff,_ in pairs(CURES[category]) do
        if (not table.contains(AFFS.readable, aff)) then
            missingAffs[aff] = true;
        end

        hasCure[aff] = true;
    end
end

for _,category in pairs(mapToCureCategories) do
    for _,aff in pairs(CURES[category]) do
        if (not table.contains(AFFS.readable, aff)) then
            missingAffs[aff] = true;
        end

        hasCure[aff] = true;
    end
end

if (table.size(missingAffs) > 0) then
    cecho("<red>Missing affliction definitions for the following affs: ");
    for k,_ in pairs(missingAffs) do
        echo(k .. ", ");
    end
    echo("\n");
end

local first = true;
local no_def_detected = false;

for k,v in pairs(hasCure) do
    if (not AFFS.fake[k] and not string.match(k, "no_") and not string.match(k, "m_")) then -- If it's not a fake aff, not a no_def aff, and not a mirrored aff, then note the missing cure.
        if (not v) then
            if (first) then
                cecho("<red>Missing cure for: " .. k .. ", ");
                first = false;
            else
                cecho("<red>" .. k .. ", ");
            end
        end
    end
end
echo("\n");