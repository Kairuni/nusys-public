local Keep = {
    "luminesce",
    "gleam",
};

local Defup = {
    "luminesce",
    "blueshift",
    "stargleam",
};

local ast = AB.Astranomia;

local Actions = {
    luminesce = { ab = ast.Luminesce },
    blueshift = { ab = ast.Blueshift },
    stargleam = { ab = ast.Gleam },
};

for k, v in pairs(Actions) do
    if (not v.ab) then
        display("WARNING: No AB for " .. k);
    end
    -- Add if it's not in the config and actions list
    DEFS.config[k] = { action = "siderealist", keep = table.contains(Keep, k), defup = table.contains(Defup, k), classList = { "siderealist" } };

    if (not DEFS.actions[k]) then
        DEFS.actions[k] = {};
    end

    DEFS.actions[k].siderealist = v;
end
