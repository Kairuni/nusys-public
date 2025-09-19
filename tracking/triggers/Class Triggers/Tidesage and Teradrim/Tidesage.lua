TRIG.register("tidesage_yearn_off_cd", "exact", [[You may once again yearn for the sea to lend you its succour.]], function() NU.removeCD(TRACK.getSelf().name .. "_Wavebreaking_Yearn"); end, "TIDESAGE_OFFENSE", "");
TRIG.register("tidesage_already_encrusted", "exact", [[Barnacles already cover your arms.]], function() TRACK.addDef(TRACK.getSelf(), "encrusted"); end, "TIDESAGE_OFFENSE", "");
TRIG.register("tidesage_already_wavebreaking", "exact", [[You have already adopted the wavebreaker's stance.]], function() TRACK.addDef(TRACK.getSelf(), "wavebreaking"); end, "TIDESAGE_OFFENSE", "");
TRIG.register("tidesage_wavebreak_triggered", "regex", [[^Retaliating with the wrath of the oceans, you deny the strength of (\w+)\'s .+, freezing it in a layer of thick ice.]], function() NU.setPFlag("wavebreak", TRACK.get(matches[2])); end,
    "TIDESAGE_OFFENSE", "When hit by a target, break the weapon arm.");
-- TODO: Pull the actual weapon arm somehow.
TRIG.register("tidesage_wavebreak_limb", "substr", [[fierce grip secures the weapon\, however the arm badly twists\.$]], function() if (PFLAGS.wavebreak) then TRACK.addHidden(PFLAGS.wavebreak, "wavebreak", {"left_arm_crippled", "right_arm_crippled"}) end end, "TIDESAGE_OFFENSE", "Adds the broken limb to the target.");

-- Riptide removing rebounding
-- The riptide washes away Emhyra's rebounding defence.

-- Capsize fuckery
TRIG.register("tidesage_capsize_limb_break", "regex", [[^\w+ (right arm|left arm|right leg|left leg) snaps under the impact\.$]], function() TRACK.aff(PFLAGS.attack_target, matches[2]:gsub(" ", "_") .. "_crippled"); end, "TIDESAGE_OFFENSE", "When capsize breaks a limb, add the cripple.");
TRIG.register("tidesage_capsize_prompt", "regex", [[.]], function() TRIG.disable(TRIGS.tidesage_capsize_limb_break); TRIG.disable(TRIGS.tidesage_capsize_prompt); end, "TIDESAGE_OFFENSE", "When capsize breaks a limb, add the cripple.");

TRIG.register("tidesage_engulf_cooldown", "exact", [[Your elemental_engulf defence has been stripped.]], function() NU.cooldown(TRACK.getSelf().name .. "_Engulf", 15); end, "TIDESAGE_OFFENSE", "Puts engulf on cooldown");
TRIG.register("tidesage_engulf_available", "exact", [[You may once again work in tandem with your elemental.]], function() NU.removeCD(TRACK.getSelf().name .. "_Engulf"); end, "TIDESAGE_OFFENSE", "Engulf off cooldown")


-- In theory I should have these as a trigger group enabled on Bombard and disabled on prompt, but w/e.
-- First is 4.0, second is 3.5, third is 3.06.
-- But we need to verify that it hits and isn't parried. So we need some tracking fuckery here.
local broadsideDamage = {
    4.0,
    3.5,
    3.06,
}

TRIG.register("tidesage_broadside_confirm", "regex", [[.]], function()
    local broadside = PFLAGS.non_ab_limb_attacks;
    if (broadside) then
        TRACK.damageLimb(broadside.ttable, broadside.limb, broadsideDamage[PFLAGS.broadside_count]);
    end
    TRIG.disable(TRIGS.tidesage_broadside_confirm);
end, "TIDESAGE_OFFENSE", "Triggers when we've confirmed a broadside hit.");

TRIG.register("tidesage_broadside", "regex", [[^You bombard (\w+)'s (right leg|left leg|right arm|left arm|head|torso) as your relentless broadside continues the assault.]],
function()
    if (PFLAGS.illusion) then return; end
    if (PFLAGS.broadside_count) then
        NU.setPFlag("broadside_count", PFLAGS.broadside_count + 1)
    else
        NU.setPFlag("broadside_count", 1)
    end
    NU.setPFlag("non_ab_limb_attacks", {ttable = TRACK.get(matches[2]), limb = matches[2]});
end,
"TIDESAGE_OFFENSE", "Triggers when we're making a broadside attack.");

local bruiseTable = {
    light = "_bruised",
    moderate = "_bruised_moderate",
    critical = "_bruised_critical"
}
TRIG.register("tidesage_limb_bruising", "regex", [[^Your strikes cause (\w+) bruising on (\w+)'s (right leg|left leg|right arm|left arm|head|torso)\.$]],
function()
    TRACK.taff(matches[3], matches[4]:gsub(" ", "_") .. bruiseTable[matches[2]]);
end, "TIDESAGE_OFFENSE", "Triggers whenever a Tidesage bruises limbs");

local daubMap = {
    tentacle = "red",
    wave = "blue",
    mouth = "yellow",
    cephalopod = "green",
    fin = "purple",
    eye = "gold",
}

TRIG.register("daub_tracker", "regex", [[^You have daubed a (\w+) lesser mark onto a (\w+) greater mark\.$]],
function()
    NU.setFlag("daub", {minor = daubMap[matches[2]], major = daubMap[matches[3]]})
end,
"TIDESAGE_DEFENSES", "Tracks which daub you have active via DEF.")

local function removeFogInRoom()
    local room = gmcp.Room.Info.num;
    if (FLAGS.my_fog_rooms) then
        FLAGS.my_fog_rooms[room] = false;
    end
end

local function removeFogExceptLocal()
    local room = gmcp.Room.Info.num;
    if (FLAGS.my_fog_rooms) then
        for otherRoom, _ in pairs(FLAGS.my_fog_rooms) do
            if (otherRoom ~= room) then
                FLAGS.my_fog_rooms[otherRoom] = nil;
            end
        end
    end
end

local function applyToMatchedRooms()
    local roomList = mmp.searchRoom(matches[2]);
    for id, name in pairs(roomList) do
        NU.appendFlag("my_fog_rooms", id, true);
    end
end

TRIG.register("tidesage_remove_local_fog", "exact", [[Bereft of any remaining magics, the thick fog inundating the area blows away on a cold breeze.]], removeFogInRoom, "TIDESAGE_OFFENSE", "");
TRIG.register("tidesage_remove_fog_on_failed_apparition_with_typo", "exact", [[There is insufficient fog here for you to form an apparitiion.]], removeFogInRoom, "TIDESAGE_OFFENSE", "");
TRIG.register("tidesage_remove_fog_on_failed_apparition", "exact", [[There is insufficient fog here for you to form an apparitiion.]], removeFogInRoom, "TIDESAGE_OFFENSE", "");
TRIG.register("tidesage_remove_remote_fog", "exact", [[Your control over the distant fog wanes as you relax a fraction of your will.]], removeFogExceptLocal, "TIDESAGE_OFFENSE", "");
TRIG.register("tidesage_add_fog_from_chase", "regex", [[^Your fog has settled over the area at (.+)\.$]], applyToMatchedRooms, "TIDESAGE_OFFENSE", "");


local levels = {
    scarce = 0,
    light = 1,
    moderate = 2,
    severe = 3,
    massive = 4,

    humanoid = 0,
    twisted = 1,
    warped = 2,
    abominable = 3,
    monstrous = 4,
}

local function setApparitionSize()
    if (PFLAGS.illusion) then return; end;

    NU.setFlag(TRACK.getSelf().name .. "_apparition", levels[matches[2]]);
end

-- Turns out gmcp.Char.Vitals.apparition is a thing.

-- TRIG.register("tidesage_already_have_apparition", "exact", [[You have already formed an eldritch apparition.]],
--     function()
--         if (PFLAGS.illusion) then return; end;

--         local myFlag = TRACK.getSelf().name .. "_apparition";
--         local apparition_size = FLAGS[myFlag];
--         if (not apparition_size) then
--             NU.setFlag(myFlag, 1);
--         end
--     end, "TIDESAGE_OFFENSE", "");
-- TRIG.register("tidesage_apparition_used", "regex", [[^The fathomless stature of your apparition diminishes to (\w+) as it empowers your attack\.$]],
    -- setApparitionSize, "TIDESAGE_OFFENSE", "Whenever a Tidesage uses their apparition for free Inundation.");
-- Esani's eldritch apparitions swells in both size and stature as yet more waves of thick fog bolster its fathomless form.
-- TRIG.register("tidesage_apparition_growth", "exact", [[Your eldritch apparition swells in both size and stature as yet more waves of thick fog bolster its fathomless form.]],
--     function()
--         if (PFLAGS.illusion) then return; end
--         local myFlag = TRACK.getSelf().name .. "_apparition";
--         local apparition_size = FLAGS[myFlag];
--         if (apparition_size and apparition_size < 4) then
--             FLAGS[myFlag] = FLAGS[myFlag] + 1;
--         elseif (not apparition_size) then
--             NU.setFlag(myFlag, 1);
--         end
--     end, "TIDESAGE_OFFENSE", "");


TRIG.register("tidesage_brume", "regex", [[^Your dexterous manoeuvre inspires your apparition to greater fathoms: it now lurks in a (\w+) state\.$]], setApparitionSize, "TIDESAGE_OFFENSE", "");

--TRIG.register("", "", [[]], function() end, "TIDESAGE_OFFENSE", "");
-- The presence of another frozen glacier elsewhere in this area defies you raising your own.


-- *** INUNDATION - GNASH: Nawan ***
TRIG.register("tidesage_inundation_gnash_affliction", "regex", [[^The sudden silhouette leaves (\w+) with (\w+)\.$]], function() TRACK.taff(matches[2], matches[3]) end, "TIDESAGE_OFFENSE", "");


-- Lidless and impassive, the eyes of the apparition stare menacingly at Nawan, jagged shards of ice assailing him.
-- bleed

--  -- From Stalagmites.
TRIG.register("tidesage_stalagmite_fallen", "regex", [[^(\w+) cries out as myriad icy spikes plunge into .+ body\.$]], function() TRACK.taff(matches[2], "FALLEN"); end, "TIDESAGE_OFFENSE", "");

-- Abyss:
local abyssDefOrder = {
    "rebounding",
    "shielded",
    "cloak"
}
TRIG.register("tidesage_abyss_strip", "regex", [[^Teeming with sibilant promises\, the abyssal voices persuade (\w+) to part with the (\w+) defence\.$]],
    function()
        for _,def in ipairs(abyssDefOrder) do
            if (def == matches[3]:lower()) then
                break;
            end
            TRACK.stripTDef(matches[2], def)
        end
        TRACK.stripTDef(matches[2], matches[3]:lower())
    end,
"TIDESAGE_OFFENSE", "");


-- golem hitting:
-- 
local function handleTidesageElementalCMSG()
    local ab = AB.Synthesis[matches[2]];
    local tt = TRACK.get(matches[3]);
    local st = TRACK.getSelf()

    if (ab and tt ~= TRACK.getSelf()) then
        local visibleAffs, _, _ = ab.getTargetAffs(st, tt);
        local damage, _, _, _ = ab.getDamage(st, tt);
        local dmgType = ab.getDamageType and ab.getDamageType(st, tt) or "blunt";
        local limbDamage = ab.getLimbEffects(st, tt);

        for _,v in ipairs(visibleAffs) do
            TRACK.aff(tt, v);
        end

        local damageLimb = limbDamage.no_break;
        limbDamage.no_break = nil;

        for limb, limb_damage in pairs(limbDamage) do
            OFFENSE.general.trackParryModeOnHit(limb, false);
            TRACK.damageLimb(tt, limb, limb_damage, damageLimb)
        end

        if (ab.onUseEffects) then ab.onUseEffects(st, tt); end

        tt.vitals.hp = tt.vitals.hp - (tt.vitals.maxhp * damage * tt.audits[dmgType]);
    end
end

TRIG.register("tidesage_elemental_handling", "regex", [[^A synthetic crystal elemental uses Synthesis (\w+) on (\w+)\.$]], handleTidesageElementalCMSG, "TIDESAGE_OFFENSE", "");
--  -- level of freeze
TRIG.register("tidesage_elemental_freeze", "regex", [[^Frost spreads from the impact, and (\w+) shivers as a deep chill pervades .+ body\.$]],
    function() local tt = TRACK.get(matches[2]); local affs = AB.freezeStack(tt, 1); TRACK.affs(tt, affs); end, "TIDESAGE_OFFENSE", "Level of freeze from blue ink.");

-- 
TRIG.register("tidesage_elemental_parry_strip", "regex", [[^As (\w+) parries the blow, a synthetic crystal elemental enacts a vengeful reprisal, leaving him reeling and vulnerable\.$]], function()
    local st = TRACK.getSelf();
    display(math.max(TRACK.remainingBalance(st, "balance"), TRACK.remainingBalance(st, "equilibrium")));
    display("Elemental hit?");
    local flagTimer = math.min(math.max(TRACK.remainingBalance(st, "balance"), TRACK.remainingBalance(st, "equilibrium")), 3);
    if (matches[2]:lower() == NU.target and flagTimer > 0) then
        NU.setFlag("cleared_parry", matches[2], flagTimer);
    end
end, "TIDESAGE_OFFENSE", "Sets the cleared_parrry flag (which is a blanket offense flag for current target, not tracked per target).");


TRIG.register("tidesage_start_permafrost", "exact",
    [[Memories of the sea and all its frigid fury roil in the back of your mind as your arms splay wide and your head rolls back and you inhale, a deep and languorous breath. Frost gathers at your fingertips and begins spreading inwards as the temperature plummets.]],
    function() NU.setFlag("permafrost_deffing", true, 6); end, "TIDESAGE_DEFENSES", "Permafrost starting");
--[[Warmth returns to the air as your concentration falters, the aura of permafrost dispersing before it can fully form.]]

local sirensong_affs = {
    "dizziness", "vertigo", "anorexia", "weariness"
};

TRIG.register("tidesage_sirensong_hiddens", "exact", [[Your thoughts jumble in a haze of confusion as the crooning notes of a siren's song enrapture your mind.]], function()
    NU.setPFlag("expected_hiddens", {source = "sirensong", affList = sirensong_affs, expectedCount = 1});
end, "TIDESAGE_HIDDEN_TRACKING", "");