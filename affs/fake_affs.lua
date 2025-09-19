-- Fake affs - these are processed whenever a new aff is added to a ttable or an aff is cured on a ttable.
-- These are in the cure above the corresponding actual affliction. First entry is a function, second is the aff it CURES.
AFFS.fake = {
    SUPER_ABLAZE = {test = function(ttable) return ttable.affs.ablaze and ttable.stacks.ablaze > 7; end, willCure = {"ablaze"}},
    SUPER_ABLAZE_BROKEN_TORSO = {test = function(ttable) return ttable.affs.torso_broken and ttable.stacks.ablaze > 7; end, willCure = {"torso_broken"}},
    GONNA_DIE_FROZEN = {test = function(ttable) return ttable.affs.frozen and (ttable.affs.FALLEN or ttable.affs.writhe_impaled); end, willCure = {"frozen"}},
    FROSTBRAND_SHIVERING = {test = function(ttable) return ttable.affs.shivering and ttable.affs.frostbrand and (ttable.affs.left_leg_broken or ttable.affs.right_leg_broken or ttable.affs.left_arm_broken or ttable.affs.right_arm_broken); end},

    VOID_OR_WEAKVOID = {test = function(ttable) return ttable.affs.void or ttable.affs.weakvoid; end},
    -- TODO: Test thin blood + voyria
    --START_VOYRIA = {test = function(ttable) return ttable.affs.voyria and nu.time() - ttable.voyriaStarted > 12; end, willCure = {"voyria"}},

    -- If rot gets extra painful.
    SHADEROT_SPIRIT_BIG = {test = function(ttable) return ttable.affs.rot_spirit and FLAGS.rot_spirit and FLAGS.rot_spirit > 20 end, willCure = {"rot_body"}},

    CONFUSED_AND_DISRUPTED = {test = function(ttable) return ttable.affs.confusion and ttable.affs.disrupted; end, willCure = {"confusion"}},

    TREE_PARALYSIS = { test = function(ttable) return ((ttable.affs.paresis or ttable.affs.paralysis) and ttable.bals.tree <= ttable.bals.pill) end, willCure = { "paresis", "paralysis" } },

    -- Added via addAff
    FALLEN = {test = function(ttable) return ttable.vitals.fallen; end},
    UNCONSCIOUS = {},

    PRONE = {test = function(ttable) for _,v in ipairs(AFFS.proneList) do if (ttable.affs[v]) then return true; end end return false; end},

    PRONE_LEFT_LEG_BROKEN = {test = function(ttable) return ttable.affs.left_leg_broken and ttable.affs.PRONE; end},
    PRONE_RIGHT_LEG_BROKEN = {test = function(ttable) return ttable.affs.right_leg_broken and ttable.affs.PRONE; end},
    LEFT_LEG_PRERESTORE = {test = function(ttable) return ttable.wounds["left leg"] >= NU.config.preRestore.left_leg; end},
    RIGHT_LEG_PRERESTORE = {test = function(ttable) return ttable.wounds["right leg"] >= NU.config.preRestore.right_leg; end},
    LEFT_ARM_PRERESTORE = {test = function(ttable) return ttable.wounds["left arm"] >= NU.config.preRestore.left_arm; end},
    RIGHT_ARM_PRERESTORE = {test = function(ttable) return ttable.wounds["right arm"] >= NU.config.preRestore.right_arm; end},
    HEAD_PRERESTORE = {test = function(ttable) return ttable.wounds.head >= NU.config.preRestore.head; end},
    TORSO_PRERESTORE = {test = function(ttable) return ttable.wounds.torso >= NU.config.preRestore.torso; end},

    BOTH_ARMS_CRIPPLED_ONE_CURABLE = {
        test = function(ttable)
            return ttable.affs.left_arm_crippled and ttable.affs.right_arm_crippled and (not ttable.affs.left_arm_broken or not ttable.affs.right_arm_broken);
        end,
    },

    -- TODO: Let's see how this pans out, but I've removed the straight reckless check from this to try to better track hpmp.
    HP_SIP = {
        test = function(ttable)
            return ttable.vitals.hp / ttable.vitals.maxhp <= NU.config.heals.sip_hp or
                ttable.affs.blackout or #TRACK.getHiddenCandidateIndicies(ttable, "recklessness") > 0;
        end
    },
    MP_SIP = {
        test = function(ttable)
            return ttable.vitals.mp / ttable.vitals.maxmp <= NU.config.heals.sip_mp or
                ttable.affs.blackout;
        end
    },
    HP_ANABIOTIC = {
        test = function(ttable)
            return ttable.vitals.hp / ttable.vitals.maxhp <=
                NU.config.heals.anabiotic_hp or ttable.affs.blackout or
                #TRACK.getHiddenCandidateIndicies(ttable, "recklessness") > 0;
        end
    },
    MP_ANABIOTIC = {
        test = function(ttable)
            return ttable.vitals.mp / ttable.vitals.maxmp <=
                NU.config.heals.anabiotic_mp or ttable.affs.blackout;
        end
    },

    UNKNOWN_MENDARMS = {test = function(ttable) return TRACK.getHiddenTypeCount(ttable, AFFS.armMendable) > 1; end},
    UNKNOWN_MENDLEGS = {test = function(ttable) return TRACK.getHiddenTypeCount(ttable, AFFS.legMendable) > 1; end},
    UNKNOWN_MENDSKIN = {test = function(ttable) return TRACK.getHiddenTypeCount(ttable, AFFS.skinMendable) > 1; end},
    UNKNOWN_FOCUSABLE = {test = function(ttable) return TRACK.getHiddenTypeCount(ttable, AFFS.mentals) > 1; end},
    RETROGRADE = { test = function(_) return FLAGS.recent_retrograde_proc and true or false; end },

    -- TODO: Make this depend on time.
    VOYRIA_GONNADIE = { test = function(ttable) return ttable.affs.voyria; end },
    ALLERGIES_PARALYSIS = { test = function(ttable) return ttable.stacks.allergies >= 5; end },
    ALLERGIES_GONNADIE = { test = function(ttable) return ttable.stacks.allergies == 11; end }
};