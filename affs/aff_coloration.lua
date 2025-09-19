UTIL.affColors = {};

local affColorsBase = {
    -- Should be replaced with a loop on defenses.
    DarkSlateGray = {
        
    },
    purple = {
        "accursed", "emberbrand", "flamebrand", "frostbrand", "delirium", "mistbrand", "extravasation", "shadowbrand", "spiritbrand", "stonebrand", "thunderbrand", "vinethorns2", "windbrand"
    },
    red = {
        "aeon", "asleep", "blight", "destroyed_throat", "direfrost", "disorientated", "disturb_confidence",
        "disturb_impulse", "disturb_inhibition", "disturb_sanity", "dread", "irradiated_limb",
        "head_bruised_critical", "head_broken", "head_mangled", "infestation", "left_arm_bruised_critical", "left_leg_bruised_critical", "lemniscate", "paralysis", "prone", "PRONE_LEFT_LEG_BROKEN",
        "PRONE_RIGHT_LEG_BROKEN", "punished_arms", "punished_legs", "right_arm_bruised_critical", "right_leg_bruised_critical", "ripped_groin", "ripped_spleen", "sapped_stats", "sealing_circle",
        "sealing_square", "sealing_triangle", "spiritbane", "stormtouched", "SUPER_ABLAZE", "SUPER_ABLAZE_BROKEN_TORSO", "torso_bruised_critical", "TREE_PARALYSIS", "vinethorns1"
    },
    orange = {
        "agony", "airwreath", "anorexia", "asthma", "dissonance", "frostwreath", "hypothermia", "ice_encased", "impatience", "indifference", "left_arm_broken",
        "left_leg_broken", "muddled", "ravaged", "recklessness", "right_arm_broken", "right_leg_broken", "slickness", "soulburn", "soulfire",
        "stupidity", "terror", "torso_broken", "vinethorns", "writhe_gunk", "writhe_stasis"
    },
    yellow = {
        "achromatopsia", "amplify_asphyxiation", "amplify_blunt", "amplify_cold", "amplify_cutting", "amplify_electric", "amplify_fire", "amplify_magic", "amplify_poison",
        "amplify_psychic", "amplify_shadow", "amplify_spirit", "amplify_unblockable", "backstrain", "barbs", "broken_arms", "broken_legs", "bulimia", "burnout",
        "clear_blindness", "clear_deafness", "clear_insomnia", "deafness", "deepwound", "gloom", "hemorrhage", "hollow", "HYPOTHERMIA_TORSO_DAMAGE", "imbued",
        "impeded", "itchy", "lightwound", "m_tree_seared", "malevolence", "marked", "muscle_spasms", "nightmare", "no_blind", "nyctophobia", "panacea",
        "paresis", "polymorph", "possessed", "prone_head_broken", "psi_tether", "salve_seared", "sensitivity_nodeaf", "rot", "SHADEROT_2_BIG", "rot_benign",
        "rot_body", "rot_heat", "rot_spirit", "rot_wither", "shadowsphere", "shock", "skin_broken", "skin_mangled", "sore_ankle", "sore_wrist",
         "spirit_tendril", "staticburst", "stiffness", "TREE_PARALAYSIS", "trick_flame", "turmoil", "typhonpoison", "unknown", "unknown_arm", "unknown_leg",
          "varach_rot", "voidgaze", "voidtrapped", "weak_grip", "weariness", "whiplash", "worrywart"
    },
    DimGray = {
        "blaze", "blisters", "disabled", "heatspear", "laxity", "m_shadowed", "magnanimity", "mindtether",  "taunted", "writhe_grappled"
    }
}

for _,v in ipairs(DEFS.readable) do
    UTIL.affColors["no_" .. v] = "DarkSlateGray";
end

for color,affs in pairs(affColorsBase) do
    for _,aff in ipairs(affs) do
        UTIL.affColors[aff] = color; -- string.format("%s", color);
    end
end

for _,v in ipairs(AFFS.readable) do
    if (not UTIL.affColors[v]) then
        NU.WARN("No aff color for " .. v);
    end
end
local affColors_mt = {
    __index = function(t, k)
        return "SlateGray";
    end
}

setmetatable(UTIL.affColors, affColors_mt);
