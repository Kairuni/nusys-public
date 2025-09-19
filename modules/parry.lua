PARRY = {};
local parryModeStats = {};

local parryModes = {};

function PARRY.resetParryModeStats()
    for trackedEntity, stats in pairs(parryModeStats) do
        stats.hitAttempts = 0;
        for mode, _ in pairs(parryModes) do
            parryModeStats.predictions[mode] = {
                positive = 0,
                negative = 0,
                accurate = 0,
            };
            parryModeStats.predictions[mode .. "NoSnapshot"] = {
                positive = 0,
                negative = 0,
                accurate = 0,
            };
        end
    end
end

