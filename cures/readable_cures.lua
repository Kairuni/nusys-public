CURES.pill = {
    antipsychotic = {
        "sadness", "confusion", "CONFUSED_AND_DISRUPTED", "dementia", "hallucinations", "paranoia", "hatred", "hypersomnia", "addiction", "psychosis", "blight"
    },
    euphoriant = {
        "self_pity", "stupidity", "dizziness", "faintness", "shyness", "epilepsy", "impatience", "dissonance", "infestation", "clear_insomnia"
    },
    decongestant = {
        "baldness", "clumsiness", "hypochondria", "weariness", "asthma", "sensitivity", "ringing_ears", "impairment", "sepsis"
    },
    depressant = {
        "commitment_fear", "mercy", "recklessness", "egocentrism", "masochism", "agoraphobia", "loneliness", "mania", "vertigo", "claustrophobia", "nyctophobia"
    },
    coagulation = {
        "body_odor", "lethargy", "allergies", "ALLERGIES_PARALYSIS", "ALLERGIES_GONNADIE", "delirium",
        "extravasation", "vomiting", "exhaustion", "dyscrasia", "rend", "haemophilia"
    },
    steroid = {
        "hubris", "pacifism", "peace", "agony", "accursed", "hypotension", "infatua", "laxity", "superstition", "generosity", "justice", "magnanimity"
    },
    eucrasia = {
        "worrywart", "misery", "hopelessness", "echoes", "hollow", "narcolepsy", "perplexity", "self_loathing"
    },
    opiate = {
        "paresis", "paralysis", "TREE_PARALYSIS", "mirroring", "crippled_body", "crippled", "blisters", "slickness", "arrhythmia", "slough"
    },
    anabiotic = {
        "plodding", "idiocy"
    },
    panacea = {
        "stormtouched", "patterns", "rot_wither", "rot_spirit", "SHADEROT_SPIRIT_BIG", "rot_heat", "rot_body", "rot_benign"
    },
    stimulant = {
        "no_instawake",
    },
    pluck = {
        "no_courage",
    },
    thanatonin = {
        "no_deathsight",
    },
    waterbreathing = {
        "no_waterbreathing",
    },
    amaurosis = {
    },
    ototoxin = {
    },
    kawhe = {
        "no_insomnia",
    },
    acuity = {
        "no_thirdeye",
    },
};

CURES.pipe = {
    willow = {
        "aeon", "hellsight", "deadening"
    },
    yarrow = {
        "slickness", "withering", "disfigurement", "migraine",
    },
    reishi = {
        "besilence", "no_rebounding"
    },
};

CURES.elixir = {
    levitation = {"no_levitation"},
    immunity = {"voyria", "VOYRIA_GONNADIE"}, -- "START_VOYRIA"},
    harmony = {"no_harmony"},
    speed = {"no_speed"},
    arcane = {"no_arcane"},
    infusion = {"squelched", "etherflux"},
    ["the arcane"] = {"no_arcane"},
    health = {"HP_SIP"},
    mana = {"MP_SIP"},
};

CURES.poultice = {
    epidermal = {
        head = {"indifference", "stuttering", "blurry_vision", "burnt_eyes", "clear_blindness", "gloom", "clear_deafness"},
        torso = { "anorexia", "gorged", "manablight", "effused_blood" },
        skin = {}, -- "anorexia", "gorged", "effused_blood", "indifference", "stuttering", "blurry_vision", "burnt_eyes"
    },

    mending = {
        head = {"head_bruised_critical", "destroyed_throat", "crippled_throat", "head_bruised_moderate", "head_bruised"},
        torso = {"torso_bruised_critical", "lightwound", "trick_flame", "SUPER_ABLAZE", "ablaze", "cracked_ribs", "torso_bruised_moderate", "torso_bruised"},
        ['left arm'] = {"left_arm_bruised_critical", "left_arm_crippled", "left_arm_bruised_moderate", "left_arm_bruised", "left_arm_dislocated"},
        ['right arm'] = {"right_arm_bruised_critical", "right_arm_crippled", "right_arm_bruised_moderate", "right_arm_bruised", "right_arm_dislocated"},
        ['left leg'] = {"left_leg_bruised_critical", "left_leg_crippled", "left_leg_bruised_moderate", "left_leg_bruised", "left_leg_dislocated"},
        ['right leg'] = {"right_leg_bruised_critical", "right_leg_crippled", "right_leg_bruised_moderate", "right_leg_bruised", "right_leg_dislocated"},
        arms = {"left_arm_bruised_critical", "left_arm_crippled", "left_arm_bruised_moderate", "left_arm_bruised", "left_arm_dislocated", "right_arm_bruised_critical", "right_arm_crippled", "BOTH_ARMS_CRIPPLED_ONE_CURABLE", "right_arm_bruised_moderate", "right_arm_bruised", "right_arm_dislocated", "UNKNOWN_MENDARMS"},
        legs = {"left_leg_bruised_critical", "left_leg_crippled", "left_leg_bruised_moderate", "left_leg_bruised", "left_leg_dislocated", "right_leg_bruised_critical", "right_leg_crippled", "right_leg_bruised_moderate", "right_leg_bruised", "right_leg_dislocated", "UNKNOWN_MENDLEGS"},
        skin = {
            -- "head_bruised_critical",
            -- "head_bruised_moderate",
            -- "head_bruised",
            -- "destroyed_throat",
            -- "crippled_throat",
            -- "torso_bruised_critical",
            -- "lightwound",
            -- "ablaze",
            -- "cracked_ribs",
            -- "torso_bruised_moderate",
            -- "torso_bruised",
            -- "left_arm_bruised_critical",
            -- "left_arm_crippled",
            -- "left_arm_bruised_moderate",
            -- "left_arm_bruised",
            -- "left_arm_dislocated",
            -- "right_arm_bruised_critical",
            -- "right_arm_crippled",
            -- "right_arm_bruised_moderate",
            -- "right_arm_bruised",
            -- "right_arm_dislocated",
            -- "left_leg_bruised_critical",
            -- "left_leg_crippled",
            -- "left_leg_bruised_moderate",
            -- "left_leg_bruised",
            -- "left_leg_dislocated",
            -- "right_leg_bruised_critical",
            -- "right_leg_crippled",
            -- "right_leg_bruised_moderate",
            -- "right_leg_bruised",
            -- "right_leg_dislocated",
            -- "UNKNOWN_MENDSKIN",
        },
    },

    soothing = {
        head = { "phosphenes", "whiplash" },
        torso = {"backstrain", "muscle_spasms", "stiffness"},
        arms = {"sore_wrist", "weak_grip"},
        legs = {"sore_ankle"},
        skin = {}, -- "whiplash", "backstrain", "muscle_spasms", "stiffness", "sore_wrist", "weak_grip", "sore_ankle"
    },

    caloric = {
        head = { "mindfog" },
        torso = {"hypothermia", "frozen", "GONNA_DIE_FROZEN", "frigid", "shivering", "FROSTBRAND_SHIVERING", "VOID_OR_WEAKVOID"},
        skin = {}, -- "hypothermia", "frozen", "GONNA_DIE_FROZEN", "frigid", "shivering", "FROSTBRAND_SHIVERING", "VOID_OR_WEAKVOID"
    },

    mass = {
        torso = {"no_density"},
    },

    restoration = {
        head = {"mauled_face", "head_mangled", "head_broken", "smashed_throat", "voidgaze", "HEAD_PRERESTORE"},
        torso = {"collapsed_lung", "spinal_rip", "burnt_skin", "SUPER_ABLAZE_BROKEN_TORSO", "torso_mangled", "torso_broken", "crushed_chest", "heatspear", "deepwound", "TORSO_PRERESTORE"},
        ['left arm'] = {"left_arm_amputated", "left_arm_mangled", "left_arm_broken", "LEFT_ARM_PRERESTORE"},
        ['right arm'] = {"right_arm_amputated", "right_arm_mangled", "right_arm_broken", "RIGHT_ARM_PRERESTORE"},
        ['left leg'] = {"left_leg_amputated", "left_leg_mangled", "left_leg_broken", "PRONE_LEFT_LEG_BROKEN", "LEFT_LEG_PRERESTORE"},
        ['right leg'] = {"right_leg_amputated", "right_leg_mangled", "right_leg_broken", "PRONE_RIGHT_LEG_BROKEN", "RIGHT_LEG_PRERESTORE"},
        arms = {"left_arm_amputated", "left_arm_mangled", "left_arm_broken", "LEFT_ARM_PRERESTORE", "right_arm_amputated", "right_arm_mangled", "right_arm_broken", "RIGHT_ARM_PRERESTORE"},
        legs = {"left_leg_amputated", "left_leg_mangled", "left_leg_broken", "PRONE_LEFT_LEG_BROKEN", "LEFT_LEG_PRERESTORE", "right_leg_amputated", "right_leg_mangled", "right_leg_broken", "PRONE_RIGHT_LEG_BROKEN", "RIGHT_LEG_PRERESTORE"},
        skin = {},
    },
}

local skinOrder = {
    "head",
    "torso",
    "left arm",
    "right arm",
    "left leg",
    "right leg",
}

local mendingSkin = CURES.poultice.mending.skin;
local restoSkin = CURES.poultice.restoration.skin;
local epidermalSkin = CURES.poultice.epidermal.skin;
local caloricSkin = CURES.poultice.caloric.skin;
for _,limb in ipairs(skinOrder) do
    for _,aff in ipairs(CURES.poultice.mending[limb]) do
        table.insert(mendingSkin, aff);
    end

    for _,aff in ipairs(CURES.poultice.restoration[limb]) do
        table.insert(restoSkin, aff);
    end
    for _, aff in ipairs(CURES.poultice.caloric[limb] or {}) do
        table.insert(caloricSkin, aff);
    end

    for _, aff in ipairs(CURES.poultice.epidermal[limb] or {}) do
        table.insert(epidermalSkin, aff);
    end
end
table.insert(mendingSkin, "UNKNOWN_MENDSKIN");

-- CURES.poultice.caloric.skin = CURES.poultice.caloric.torso;
CURES.poultice.mass.skin = CURES.poultice.mass.torso;

AFFS.armMendable = {};
AFFS.legMendable = {};
AFFS.skinMendable = {};
for _,v in ipairs(CURES.poultice.mending.arms) do
    AFFS.armMendable[v] = true;
end
for _,v in ipairs(CURES.poultice.mending.legs) do
    AFFS.legMendable[v] = true;
end
for _,v in ipairs(CURES.poultice.mending.skin) do
    AFFS.skinMendable[v] = true;
end

CURES.time = {
    "right_leg_ravaged",
    "left_leg_ravaged",
    "right_arm_ravaged",
    "left_arm_ravaged",
    "right_leg_numbed",
    "left_leg_numbed",
    "right_arm_numbed",
    "left_arm_numbed",
    "head_ravaged",
    "torso_ravaged",

    "shadowbrand",
    "frostbrand",
    "windbrand",
    "emberbrand",
    "spiritbrand",
    "mistbrand",
    "stonebrand",
    "airwreath",
    "frostwreath",
    "irradiated_limb",

    "blackout",

    "sealing_square",
    "sealing_triangle",
    "sealing_circle",

    "amplify_spirit",
    "amplify_blunt",
    "amplify_asphyxiation",
    "amplify_psychic",
    "amplify_poison",
    "amplify_shadow",
    "amplify_cutting",
    "amplify_cold",
    "amplify_electric",
    "amplify_magic",
    "amplify_unblockable",
    "amplify_fire",

    "magic_weakness",
    "cutting_weakness",
    "blunt_weakness",
    "cold_weakness",
    "shadow_weakness",
    "electric_weakness",
    "poison_weakness",
    "fire_weakness",
    "psychic_weakness",
    "spirit_weakness",

    "sapped_constitution",
    "sapped_dexterity",
    "sapped_intelligence",
    "sapped_strength",
    "sapped_stats",

    "ripped_throat",
    "ripped_spleen",
    "ripped_groin",

    "ravaged",
    "soul_poison",
    "crushed_kneecaps",
    "crushed_elbows",

    "direfrost",
    "penance",
    "malevolence",
    "turmoil",
    "soulroot",

    "void",
    "weakvoid",

    "frozen_feet",
    "quicksand",

    "varach_rot",

    "stonevice",

    "shadow_coat",

    "bloodlust",
    "numbed_skin",
    "shock",
    "wraith",

    "mutation_sickness",
    "corsin_weight",

    "shadowsphere",
    "sand_trapped",
    "farag_rot",
    "thorns",
    "backstabbed",

    "taunted",

    "omen",

    "achromatopsia",
    "infernal_shroud",
    "infernal_seal",
    "flash_blindness",
    "typhonpoison",

    "mental_fatigue",

    "vitalbane",
    "disorientated",
    "shadowed",

    "stun",
    "thunderstorm",
    "mindclamped",
    "voidtrapped",
    "intimidated",

    "punished_arms",
    "petrified",

    "salve_seared",
    "battle_hunger",

    "marked",
    "halted",
    "distortion",
    "lemniscate",
    "nightmare",

    "burnout",
    "polymorph",
    "troubled_breathing",
    "imbued",
    "despair",

    "impeded",
    "soul_disease",
    "resonance",
    "possessed",
    "punished_legs",
    "lifebane",
    "tree_seared",
    "flared",
    "terror",

    "fleshbane",
    "manabarbs",
    "bowelgore",
    "etherflux",
    "staggered",
    "was_tricked",
    "internal_disarray",
    "backbreak",
    "misfortune",
    "intoxicated",
    "bloodscourge",
    "lesser_atrophy",
    "city_hatred",
    "burden",
    "thunderbrand",
    "lightheart",

    "goaded",
    "attuned",
    "forestbrand",
    "awakened",
    "soulbound",

    "acidic_ink",
    "infernal_explosion",
    "symbol_marked",
    "blackstar",
    "vacuity",

    "atrophy",
    "oblivion",

    "arrow_wound",
    "battlelust",

    "asterism",
    "dustring",
    "moonlet",
    "ashen_feet"
};

CURES.other = {
    "ice_encased",
    "illgrasp",
    "hobbled",
    "immobility",
    "trickery",
    "asphyxiation_weakness",
    "barbed_arrow",
    "embedded_dagger",

    "asleep",
    "hypertension",
    "soulchill",
    "temptation",
    "seduction",
    "fear",
    "spiritbane",
    "spirit_tendril",

    "embedded_axe",
    "bulimia",
    "psi_tether",
    "dazed",

    "conviction",
    "barbs",
    "disrupted",

    "oiled",
    "eldritch_invocation",
    "soulpuncture",

    "disabled",
    "leeched_aura",
    "vinethorns",
    "itchy",
    "glasslimb",
};

CURES.focus = {
    "muddled",
    "egocentrism",
    "stupidity",
    "anorexia",
    "epilepsy",
    "mirroring",
    "delirium",
    "peace",
    "paranoia",
    "hallucinations",
    "dizziness",
    "indifference",
    "mania",
    "pacifism",
    "infatua",
    "laxity",
    "hatred",
    "generosity",
    "claustrophobia",
    "vertigo",
    "faintness",
    "loneliness",
    "agoraphobia",
    "masochism",
    "recklessness",
    "weariness",
    "impatience",
    "confusion",
    "dementia",
    "nyctophobia",
    "patterns",
    "dread",
    "UNKNOWN_FOCUSABLE",
};

CURES.writhe = {
    writhe_impaled = 2,
    writhe_armpitlock = 3, -- 6
    writhe_necklock = 3, -- 6
    writhe_thighlock = 3, -- 6
    writhe_transfix = 2.7, -- 5.4
    writhe_bind = 3, -- 6
    writhe_gunk = 5, --7
    writhe_ropes = 2, -- or 3
    writhe_vines = 2, -- or 3
    writhe_web = 2, -- or 3
    writhe_hoist = 2, -- or 3
    writhe_grappled = 2, -- or 3
    writhe_stasis = 3, -- or 4
    writhe_dartpinned = 4,

    writhe_lure = 2,
    writhe_ice = 3,
};

CURES.defense = {

};