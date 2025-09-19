AFFS.sealAffs = {
    sealing_square = {shyness = true, dizziness = true, faintness = true, epilepsy = true};
    sealing_triangle = {laxity = true, infatua = true, peace = true, magnanimity = true};
    sealing_circle = {mercy = true, masochism = true, mania = true, recklessness = true};
}

AFFS.shapeAffOrder = {
    square = {"dizziness", "faintness", "epilepsy", "shyness"},
    triangle = {"laxity", "infatua", "peace", "magnanimity"},
    circle = {"mercy", "masochism", "mania", "recklessness"},
}

-- TODO: combine with cannotCure?
function TRACK.isAffSealed(ttable, aff)
    for sealAff, sealedAffs in pairs(AFFS.sealAffs) do
        if (ttable.affs[sealAff] and sealedAffs[aff]) then
            return true;
        end
    end
    return false;
end

function TRACK.onArchivistShape(ttable, shape, aff)
    if (not AFFS.sealAffs["sealing_" .. shape][aff]) then
        return;
    end

    for _, shape_aff in ipairs(AFFS.shapeAffOrder[shape]) do
        if (shape_aff == aff) then break; end
        TRACK.aff(ttable, shape_aff);
    end
end

-- This is supposed to be called when hit by a shape and with a known aff, but this is more appropriate in the Archivist AB function for Geometrics Square/Circle/Triangle/etc.
--function nu.onShape(ttable, shape, aff)
--    local stack = AFFS.shape_aff_order[shape];
--
--    if (aff) then
--        for _,v in ipairs(stack) do
--            if (v == aff) then
--                return;
--            end
--            nu.addAff(v);
--        end
--    end

function NU.on_hiddenShapeAff(a)
    if (AFFS.sealAffs.square[a]) then
        NU.onShape("square", a)
        NU.silentRemKnownAff(a);
    elseif (AFFS.sealAffs.circle[a]) then
        NU.onShape("circle", a)
        NU.silentRemKnownAff(a);
    else
        NU.onShape("triangle", a)
        NU.silentRemKnownAff(a);
    end
end

function NU.onArchivistSeal(shape)
    local stack = AFFS.shape_aff_order [shape];
    for _,v in ipairs(stack) do
        NU.addAff(v);
    end
end

local function GetNextAff(st, shape, additionalAffs)
    additionalAffs = additionalAffs or {};

    for _, v in ipairs(AFFS.shapeAffOrder[shape]) do
        if (not st.affs[v] and not additionalAffs[v]) then
            return v;
        end
    end
    return shape;
end

local function BuildHiddenShape(data)
    local triTable = data.triangle and {aff = data.triangle, children = {}, parents = {}} or nil;
    local circleTable = data.circle and {aff = data.circle, children = {}, parents = {}} or nil;
    local squareTable = data.square and {aff = data.square, children = {}, parents = {}} or nil;

    return {possibilities = {triangle = triTable, circle = circleTable, square = squareTable}, knownShape = "UNKNOWN"};

end

local function GetBaselineHiddenShape(st)
    local triAff = GetNextAff(st, "triangle");
    local circleAff = GetNextAff(st, "circle");
    local squareAff = GetNextAff(st, "square");

    return BuildHiddenShape({triangle = triAff, circle = circleAff, square = squareAff});
end


local function GetHiddenShapeAffsTable(trackedShapeState)
    local affsTable = {};

    affsTable[trackedShapeState.aff] = true;
    local shapesToProcess = {trackedShapeState};

    while (#shapesToProcess > 0) do
        local nextShape = table.remove(shapesToProcess, 1);

        for _, parent in ipairs(nextShape.parents) do
            for _, shapeState in pairs(parent.possibilities) do
                table.insert(shapesToProcess, shapeState);
            end
        end

        affsTable[nextShape.aff] = true;
    end

    return affsTable;
end

local function xor(a, b)
    return not (not a == not b);
end

local function CompareShapes(firstShape, secondShape)
    for shape, data in pairs(firstShape.possibilities) do
        if (not secondShape.possibilities[shape] or data.aff ~= secondShape.possibilities[shape].aff) then
            return false;
        end
    end

    for shape, data in pairs(secondShape.possibilities) do
        if (not firstShape.possibilities[shape] or data.aff ~= firstShape.possibilities[shape].aff) then
            return false;
        end
    end

    return true;
end

ANTIARCHI = ANTIARCHI or {};
ANTIARCHI.branches = {};

function ANTIARCHI.OnHiddenShape()
    local st = TRACK.getSelf();

    -- Two cases - either we already have some potential branches, or we do not.
    for _, branch in ipairs(ANTIARCHI.branches) do
        -- For each isolated "shape" in the branch, add its next aff as a child.
        local baselineHiddenShape = GetBaselineHiddenShape(st);
        local newShapes = {baselineHiddenShape};
        for _, level in ipairs(branch) do
            for _, hiddenShape in ipairs(level) do
                for shape, state in pairs(hiddenShape.possibilities) do
                    -- For each of the possibilities at this level, add it to the final level.
                    local affsFromChain = GetHiddenShapeAffsTable(state);
                    local nextAff = GetNextAff(st, shape, affsFromChain);
                    local newShape = BuildHiddenShape({[shape] = nextAff});
                    local foundShape = nil;
                    for _, v in ipairs(newShapes) do
                        if (CompareShapes(v, newShape)) then
                            foundShape = v;
                            break;
                        end
                    end

                    if (not foundShape) then
                        table.insert(newShape.possibilities[shape].parents, hiddenShape);
                        table.insert(newShapes, newShape);
                    else
                        table.insert(foundShape.possibilities[shape].parents, hiddenShape);
                    end
                end
            end
        end
        table.insert(branch, newShapes);
    end

    -- If there are no branches, then just add a new branch.
    if (#ANTIARCHI.branches == 0) then
        table.insert(ANTIARCHI.branches, {{GetBaselineHiddenShape(st)}});
    end
end

-- function ANTIARCHI.

local function displayArchivistAffs()
    for branch_number, branch in ipairs(ANTIARCHI.branches) do
        -- For each isolated "shape" in the branch, add its next aff as a child.
        for i, level in ipairs(branch) do
            cecho("\n" .. tostring(i) .. ": ");
            for _, hiddenShape in ipairs(level) do
                cecho("<orange>[");
                local count = 0;
                for shape, shapeData in pairs(hiddenShape.possibilities) do
                    if (count > 0) then
                        echo(", ");
                    end
                    cecho("<white>" .. shapeData.aff);
                    count = count + 1;
                end
                cecho("<orange>]   ");
            end
        end
    end
end


-- TODO: Remove this after we figure out actual anti-Archivist bits. Not actual system functionality, just a debug check.
NTIME.timer(5, function()
    -- TESTING:
    cecho("\n<red>NEW HIDDEN SHAPE!\n");
    ANTIARCHI.OnHiddenShape();
    displayArchivistAffs()
    cecho("\n<red>NEW HIDDEN SHAPE!\n");
    ANTIARCHI.OnHiddenShape();
    displayArchivistAffs()
    cecho("\n<red>NEW HIDDEN SHAPE!\n");
    ANTIARCHI.OnHiddenShape();
    displayArchivistAffs()
    cecho("\n<red>NEW HIDDEN SHAPE!\n");
    ANTIARCHI.OnHiddenShape();
    displayArchivistAffs()
end);