CURES.lookup = {}

local function processOneDepth(cureList, affToFind, doOthers)
    for k,v in pairs(cureList) do
        if ((k ~= "skin" and k ~= "arms" and k ~= "legs") or doOthers) then
            for _,v in ipairs(v) do
                if (v == affToFind) then
                    return k;
                end
            end
        end
    end
    return nil;
end

local function processZeroDepth(cureList, affToFind)
    for _,v in ipairs(cureList) do
        if (affToFind == v) then
            return true;
        end
    end
    return false;
end

for _,v in ipairs(AFFS.readable) do
    CURES.lookup[v] = {};
    local tb = CURES.lookup[v];

    tb.pill = processOneDepth(CURES.pill, v);
    tb.pipe = processOneDepth(CURES.pipe, v);
    tb.elixir = processOneDepth(CURES.elixir, v);
    tb.poultice = {};
    tb.poultice.epidermal = processOneDepth(CURES.poultice.epidermal, v);
    tb.poultice.mending = processOneDepth(CURES.poultice.mending, v, true);
    tb.poultice.soothing = processOneDepth(CURES.poultice.soothing, v, true);
    tb.poultice.caloric = processOneDepth(CURES.poultice.caloric, v);
    tb.poultice.mass = processOneDepth(CURES.poultice.mass, v);
    tb.poultice.restoration = processOneDepth(CURES.poultice.restoration, v);
    tb.time = processZeroDepth(CURES.time, v);
    tb.other = processZeroDepth(CURES.other, v);
    tb.focus = processZeroDepth(CURES.focus, v);
    tb.writhe = processZeroDepth(CURES.writhe, v);
end
