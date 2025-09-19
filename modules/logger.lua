local STATE_TOOLTIP_FORMAT = [[<h3 style='margin-top: 0; margin-bottom: 5px'>Flags</h3>%s<h3 style='margin-top: 0; margin-bottom: 5px'>Prompt Flags</h3>%s]]

-- TODO: use the prompt flags code here instead, it's a much more compact view of the flag contents and only goes two layers deep.
-- Same code as mudlet:display, except write to a string instead.
local function displayToString(...)
    local arg = {...};
    local str = "";
    arg.n = table.maxn(arg);
    if arg.n > 1 then
        for i = 1, arg.n do
            str = str .. displayToString(arg[i]);
        end
    else
        str = str .. (inspect(arg[1], {newline = ""}) or 'nil') .. '<br>';
    end
    return str;
end

local function buildSystemStateHTMLTooltip()
    return Logger:buildTooltip("System State", string.format(STATE_TOOLTIP_FORMAT, "Turns out there's too much in here right now", "Completely nukes the log."), "bottom");
end

local COLOR_SPAN_FMT = [[<span style='color: rgb(%d,%d,%d);'>]];
local CLOSE_SPAN = [[</span>]];
local TRACKING_TOOLTIP_FORMAT = [[<h3 style='margin-top: 0; margin-bottom: 5px'>%s</h3><h4 style='margin-top: 5px; margin-bottom: 5px'>Afflictions</h4>%s<h4>Limb Data</h4>%s<h4>Balance Remaining</h4>%s<h4>Other Tags</h4>%s]];
local LIST_COMMA = string.format(COLOR_SPAN_FMT, 255,255,255) .. ", " .. CLOSE_SPAN;

local COLOR_SPANS = {};

local function getOrBuildColorSpan(color)
    if (COLOR_SPANS[color]) then
        return COLOR_SPANS[color];
    end
    local colorRGBData = color_table[color] or {255, 0, 255};
    COLOR_SPANS[color] = string.format(COLOR_SPAN_FMT, colorRGBData[1], colorRGBData[2], colorRGBData[3]);
    return COLOR_SPANS[color];
end

local function buildTrackingStateHTMLTooltip(ttable)
    local affString = "";
    for _,v in ipairs(UTIL.afflictionDrawOrder) do
        if (ttable.affs[v]) then
            local colorSpan = getOrBuildColorSpan(UTIL.affColors[v] or "MidnightBlue");
            affString = affString .. (#affString > 0 and LIST_COMMA or "") .. colorSpan .. v .. CLOSE_SPAN;
        end
    end

    local limbString = "";
    for limb,damage in pairs(ttable.wounds) do
        limbString = limbString .. (#limbString > 0 and " - " or "") .. limb .. ": " .. string.format("%.1f", damage);
    end

    local balanceString = "";
    for bal,offbalTime in pairs(ttable.bals) do
        local diff = offbalTime > NU.time() and (offbalTime - NU.time()) or 0;
        balanceString = balanceString .. (#balanceString > 0 and " - " or "") .. bal .. ": " .. string.format("%.2f", diff);
    end

    local tagsString = "";

    local tooltipString = string.format(TRACKING_TOOLTIP_FORMAT, ttable.name, affString, limbString, balanceString, tagsString);

    return Logger:buildTooltip(string.format("STATE: %s", ttable.name), tooltipString, "bottom");
end

local function logSystemStateOnPrompt()
    local stable = TRACK.getSelf();
    local ttable = TRACK.get(NU.target);

    local selfTooltipString = buildTrackingStateHTMLTooltip(stable);
    local targetTooltipString = buildTrackingStateHTMLTooltip(ttable);
    local systemStateString = buildSystemStateHTMLTooltip();
    
    -- For now we're assuming we want system state in both debug and primary logs (but we're only really running debug logs for now anyway)
    NU.LOG_ALL(selfTooltipString .. targetTooltipString .. systemStateString);
end

function NU.LOG_ALL(line)
    for _,loggers in pairs(NU.loggers) do
        for _,logger in pairs(loggers) do
            logger:log(line);
        end
    end
end

function NU.LOG_DEBUG(line)
    for _,logger in pairs(NU.loggers.debug) do
        logger:log(line);
    end
end

function NU.LOG_MAIN(line)
    for _,logger in pairs(NU.loggers.main) do
        logger:log(line);
    end
end

TRIG.register("logger_state_prompt", "prompt", nil, logSystemStateOnPrompt, "LOGGER");