AFFS.focus = {
    "egocentrism", "stupidity", "anorexia", "epilepsy", "mirroring", "delirium", "peace", "paranoia", "hallucinations",
    "dizziness", "indifference", "mania", "pacifism", "infatua", "laxity", "hatred", "generosity", "claustrophobia",
    "vertigo", "faintness", "loneliness", "agoraphobia", "echoes", "gnawing", "masochism", "recklessness", "weariness",
    "impatience",
    "confusion",
    "dementia", "nyctophobia", "patterns", "dread"
};

AFFS.mentals = {};

for _,v in ipairs(AFFS.focus) do
    AFFS.mentals[v] = true;
end