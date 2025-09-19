-- Offenses by class
OFFENSES = OFFENSES or {};
-- Offense related functions.
OFFENSE = OFFENSE or {};

function OFFENSE.brokenArm(stable)
    return stable.affs.left_arm_crippled or stable.affs.right_arm_crippled;
end

function OFFENSE.doubleArmBreak(stable)
    return stable.affs.left_arm_crippled and stable.affs.right_arm_crippled;
end

function OFFENSE.blockers(stable)
    --local shouldPauseForRebounding = stable.defs.rebounding and DEFS.config.rebounding.keep;

    for _,v in ipairs(AFFS.writheAffs) do
        if (stable.affs[v]) then return true; end
    end
    return not FLAGS.bypass_blockers and (stable.affs.asleep or stable.affs.paralysis or stable.affs.disabled or stable.defs.shielded or stable.defs.barrier or stable.defs.reflection);
end

--NU.load("offenses", "General")();
--NU.load("offenses", "Ascendril/Ascendril")();
--NU.load("offenses", "Akkari/Akkari")();
--NU.load("offenses", "Bard/Bard")();
--NU.load("offenses", "Zealot/Zealot")();
--NU.load("offenses", "Predator/Predator")();
--NU.load("offenses", "Tidesage/Tidesage")();
--NU.load("offenses", "Siderealist/Siderealist")();
--NU.load("offenses", "Shaman/Shaman")();
