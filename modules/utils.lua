local function keep_alive()
    sendGMCP("Core.KeepAlive")
    if NU.keep_alive then
        killTimer(NU.keep_alive)
    end
    -- This tempTimer will likely survive the overall timers purge. We'll decide that later.
    NU.keep_alive = tempTimer(180, keep_alive)
end

keep_alive();

NU.base_time = getEpoch();
NU.log_time = 0;

-- Get the current time, drop in replacement for os.clock.
function NU.time()
    if (NU.LOG_MODE) then
    return NU.log_time;
    else
    return getEpoch() - NU.base_time;
    end
end

UTIL = UTIL or {};

function UTIL.echoHelper(bal, char, limiters)
    local ret = "";
    local ttable = TRACK.getSelf();

    if (bal <= NU.time()) then
        ret = "<white>";
        if (limiters) then
            for i,v in ipairs(limiters) do
                if (ttable.affs[v]) then
                    ret = "<orange>";
                end
            end
        end
        if (char == "t" and FLAGS.shell_fetish) then
            ret = "<orange>";
        end
    else
        ret = "<red>";
    end
return ret .. char .. "<reset>";
end

function UTIL.echoBalances()
    local str = "";
    local bal = TRACK.getSelf().bals;
    str = str .. UTIL.echoHelper(bal.elixir,        "q", {"anorexia", "destroyed_throat"});
    str = str .. UTIL.echoHelper(bal.pill,        "h", {"anorexia", "destroyed_throat"});
    str = str .. UTIL.echoHelper(bal.poultice,         "s", {"slickness"});
    str = str .. UTIL.echoHelper(bal.pipe,        "p", {"asthma"});
    str = str .. UTIL.echoHelper(bal.focus,         "f", {"impatience", "muddled"});
    str = str .. UTIL.echoHelper(bal.tree,        "t", {"paresis", "paralysis"});
    str = str .. UTIL.echoHelper(bal.anabiotic,        "m", {"anorexia", "destroyed_throat"});
    cecho(str);
end

UTIL.classList = {
    "Akkari",
    "Alchemist",
    "Archivist",
    "Ascendril",
    "Bard",
    "Bloodborn",
    "Carnifex",
    "Earthcaller",
    "Executor",
    "Indorani",
    "Infiltrator",
    "Luminary",
    "Monk",
    "Oneiromancer",
    "Praenomen",
    "Predator",
    "Ravager",
    "Revenant",
    "Runecarver",
    "Sciomancer",
    "Sentinel",
    "Shaman",
    "Shapeshifter",
    "Templar",
    "Teradrim",
    "Tidesage",
    "Voidseer",
    "Warden",
    "Wayfarer",
    "Zealot"
}

local classMirrors = {
    praenomen = "akkari",
    shaman = "alchemist",
    voidseer = "archivist",
    bloodborn = "ascendril",
    warden = "carnifex",
    luminary = "earthcaller",
    sentinel = "executor",
    oneiromancer = "indorani",
    templar = "revenant",
    sciomancer = "runecarver",
    tidesage = "teradrim",
    ravager = "zealot"
}

UTIL.classMirrors = {};

for k,v in pairs(classMirrors) do
    UTIL.classMirrors[k] = v;
    UTIL.classMirrors[v] = k;
end

NU.loadAll("utils");
