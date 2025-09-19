NU = NU or {};

setConsoleBufferSize("main", 500000, 1000)


function NU.getHomeDir()
    -- Designed to fix weird profile name issues, but this didn't work?
    return getMudletHomeDir() -- :gsub('profiles/', 'profiles/"') .. '"';
end

-- display(NU.getHomeDir());
-- display(NU.getHomeDir() .. "/../nuSys/loaders/generic_loaders.lua");

-- internal loader
NU.load, NU.loadAll = loadfile(NU.getHomeDir() .. "/../nuSys/loaders/generic_loaders.lua")();
NU.DEBUG = 5;
NU.paused = true;

function NU.ECHO(msg, color)
    if (not color) then
        color = "white";
    end
    cecho("<red>[<"..color..">NU<red>]:<white> " .. msg);
end

-- TODO: Check for MY Logger package, rather than the Logger table.
NU.loggers = {};
NU.loggers.debug = {};
NU.loggers.main = {};
--if (Logger) then
--    NU.loggers.debug.session = Logger.createLogger("nuSys - Session Debug", {logAllSends = true, maxFilesize = 5000});
--end

local RED_SPAN = getHTMLformat({foreground = {255, 0, 0}, background = {0, 0, 0}});
local YELLOW_SPAN = getHTMLformat({foreground = {255, 255, 0}, background = {0, 0, 0}});
local WHITE_SPAN = getHTMLformat({foreground = {255, 255, 255}, background = {0, 0, 0}});
local LOGGER_DECHO_PREFIX = RED_SPAN .. "[</span>" .. YELLOW_SPAN .. "NU - DEBUG: ";
local LOGGER_DECHO_INFIX = "</span>" .. RED_SPAN .. "]</span>" .. WHITE_SPAN .. ": ";
local LOGGER_DECHO_SUFFIX = "</span><br>";

local function someLoggerIsActive()
    for category,loggers in pairs(NU.loggers) do
        for loggerName, logger in pairs(loggers) do
            if (Logger:isActive(logger.filename)) then
                return true;
            end
        end
    end
    return false;
end

NU.DECHO = Logger and function(msg, level)
    if (NU.DEBUG <= (level or 0) and msg) then
        if (Logger and someLoggerIsActive()) then
            for _,v in pairs(NU.loggers.debug) do
                v:log(LOGGER_DECHO_PREFIX .. tostring(level) .. LOGGER_DECHO_INFIX .. msg .. LOGGER_DECHO_SUFFIX);
            end
        else
            cecho("<red>[<yellow>NU - DEBUG<red>]:<white> " .. msg);
        end
    end
end

function NU.WARN(msg)
    cecho("\n<red>[<yellow>NU - WARNING<red>]:<white> " .. msg);
end

function NU.BIGMSG(msg, numLines, color)
    numLines = numLines or 3;
    color = color or "red";
	cecho("\n<white>[<"..color..">********************************<white>]\n");
	for i=1,numLines,1 do
		cecho("<white>[<"..color..">*        "..msg .. "\n");
	end
	cecho("<white>[<"..color..">********************************<white>]\n");
end

function NU.SEND(msg)
    send(msg, not NU.config.gags.send);
end

function NU.getClass()
    if (gmcp.Char.Status.class) then
        local class = gmcp.Char.Status.class:lower();
        if (class == "(none)") then
            return gmcp.Char.Status.race:lower()
        end

        return class;
    end

    return "(none)"
end

local errored = false;

-- 

local function loadOrErrorModule(path)
    NU.ECHO("<aquamarine>Loading module: " .. path .. "\n");
    local success, info = loadfile(NU.getHomeDir() .. "/../nuSys/modules/" .. path .. ".lua");
    if (not success) then
        NU.WARN("<red>Failed to load module: " .. path .. "\n");
        display(info);
        errored = true;
    else
        success();
        NU.ECHO("<green>Loaded module: " .. path .. "\n");
    end
end

local function onLoad()
    sendGMCP('Core.Supports.Add ["IRE.Tasks 1"]')
    sendGMCP('Core.Supports.Add ["Comm.Channel 1"]')
end

local modules_to_load = {
    -- Initialization/Utils
    "utils",
    "timers",
    "config",

    -- Game State
    "defs",
    "affs",
    "cures",
    "prios",
    "parrying",

    -- Tracking
    "tracking",
    "abs",
    "defup",

    -- Queues
    "queueing",

    -- Actual curing and other actions.
    "actions",

    -- after everything else in-system is established, gmcp and the heartbeat.
    "gmcp",
    "gui",

    "bashing",
    "offenses",
    "gags",

    -- Logger integration
    "logger",

    --    "test",
    -- And the memes:
    "load_art",
};

for _,v in ipairs(modules_to_load) do
    loadOrErrorModule(v);
end

if (errored) then
    cecho("<red>Due to failed module loads, system is paused. Unpause at your own risk.");
end

GMCP.register("send_gmcp", "onLoginSuccess", onLoad);
GMCP.register("start_debug_logger", "onLoginSuccess", function() NU.loggers.debug.session:start() end);
GMCP.register("stop_debug_logger", "sysExitEvent", function() NU.loggers.debug.session:close(); end);

if (gmcp.Char) then -- easy test to see if we've received GMCP data. Needs a more robust 'are we logged in' check. Check how Sunder/Rime do this, maybe?
    onLoad();
    --nu.loggers.debug.session:start();
end

TRIG.register("onLogin", "start", [[Password correct]], function() raiseEvent("onLoginSuccess"); end);

loadOrErrorModule("testing");