

local Keep = {
    "encrusted",
    "expose_brume",
    "sealegs",
    "shore_leave",
};

local Defup = {
    "encrusted",
    "expose_brume",
    "permafrost",
    "wavebreaking",
    "fog_obscure",
    "sirensong",
    "sealegs",
    "tideflux",
    "currents",
    "shore_leave",
    "lifebond",
};

local bal = "balance";
local eq = "equilibrium";

local wb = AB.Wavebreaking;
local app = AB.Inundation;
local synth = AB.Synthesis;

local Actions = {
    encrusted = {ab = wb.Encrust},
    expose_rime = {ab = wb.Rime},
    expose_brume = {ab = wb.Brume},
    permafrost = {ab = wb.Permafrost},
    wavebreaking = {ab = wb.Wavebreak},
    fog_obscure = {ab = app.Obscure},
    fluctuations = {ab = app.Fluctuations},
    panoptic = {ab = app.Panoptic},
    sirensong = {ab = app.Sirensong},
    sealegs = {ab = wb.Sealegs},
    tideflux = {ab = wb.Flux},
    currents = {ab = wb.Currents},
    shore_leave = {ab = wb.Shore},
    lifebond = {ab = synth.Lifebond},
};

for k,v in pairs(Actions) do
    -- Add if it's not in the config and actions list
    -- TODO: Better way for adding these kind of defs to Config. Might have some shared ones that would get overridden.
    DEFS.config[k] = {action = "tidesage", keep = table.contains(Keep, k), defup = table.contains(Defup, k), classList = {"tidesage", "teradrim"}};

    if (not DEFS.actions[k]) then
        DEFS.actions[k] = {};
    end

    DEFS.actions[k].tidesage = v;
end