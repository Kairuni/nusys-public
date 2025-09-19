-- Schism
local schism_pool = {
    "misery",
    "recklessness",
    "masochism",
    "stupidity",
    "impatience",
}

TRIG.register("ascendril_schism", "regex", [[^Your fulcrum affects (\w+) with (\w+)\.$]], function() TRACK.taff(matches[2], matches[3]); NU.setFlag("next_schism", NU.time() + 10, 12); end, "ASCENDRIL_OFFENSE_TRACKING", "Schism hitting");
TRIG.register("ascendril_schism_hitting_me", "exact", [[Your soul and body grate against each other, wracked into a deadly schism.]], function()
    NU.setPFlag("expected_hiddens", {source = "ascendril_schism", affList = schism_pool, expectedCount = 1});
end, "ASCENDRIL_HIDDEN_TRACKING", "When schism hits you.");

-- Imbalance
TRIG.register("ascendril_imbalance", "regex", [[^Your fulcrum strips (\w+) of the (\w+) defence\.$]], function() TRACK.stripTDef(matches[2], matches[3]); NU.setFlag("next_imbalance", NU.time() + 11, 13); end, "ASCENDRIL_OFFENSE_TRACKING", "Imbalance hitting");

-- Afterburn


local function targetAfterburning()
    local name = matches[2];
    NU.setFlag(name .. "_clear_afterburn", true, 45, function() TRACK.removeDef(TRACK.get(name), "afterburn"); end);
end

TRIG.register("ascendril_already_afterburning", "regex", [[Your are already preparing to enhance your fire spells.]], function() NU.setFlag(TRACK.getSelf().name .. "_afterburning", true, 6); end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_afterburn_already_active", "exact", [[Your fire spells already shimmer with arcane strength.]], function() TRACK.getSelf().defs.afterburn = true; end, "ASCENDRIL_OFFENSE_TRACKING", "");
-- TRIG.register("ascendril_afterburn_engaged", "exact", [[With a flare of heat, your body begins to slightly steam in preparation to strike.]],  function() NU.setFlag(TRACK.getSelf().name .. "_afterburning", true, 6); end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_other_afterburn_engaged", "regex", [[^The air around (\w+) shimmers and twists as a flare of heat escapes]], targetAfterburning, "ASCENDRIL_OFFENSE_TRACKING", "");

-- ashen_feet triggering
TRIG.register("ascendril_ashen_feet_activation", "regex", [[^Flames burst from under (\w+)\'s feet and consume .+ legs in a horrific blaze\.$]], function() TRACK.nameCure(matches[2], "ashen_feet"); TRACK.taffs(matches[2], "left_leg_crippled", "right_leg_crippled"); end, "ASCENDRIL_OFFENSE_TRACKING", "Ashen feet activation.");

-- focus missiles hitting (8.8%)
TRIG.register("ascendril_focalcast_missile", "regex", [[^You release a magic missile that streaks out and roars into (\w+)\.$]], function() TRACK.abilityDamage(TRACK.get(matches[2]), 0, 0.088, 1.0, 1.0, "magic"); end, "ASCENDRIL_OFFENSE_TRACKING", "");


-- 
-- The blazing fury falls downward, but Jhura manages to step out of the way of its path.
-- 
TRIG.register("ascendril_enable_sunspot", "exact", [[From the sky, the burning point of flare erupts into a brilliant column of blazing fury. Crackling with overwhelming power, it falls like a vengeful comet, scorching everything in its path.]], function() TRIG.enable(TRIGS.ascendril_sunspot_landing); TRIG.enable(TRIGS.ascendril_disable_sunpot); end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_sunspot_landing", "regex", [[^The blazing fury consumes (\w+)\, the flames hungrily devouring every inch of .+ being\.$]], function()
    TRACK.abilityDamage(TRACK.get(matches[2]), 0, 0.36, 1.0, 1.0, "fire");
end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_disable_sunpot", "regex", [[.]], function()
    TRIG.disable(TRIGS.ascendril_sunspot_landing);
    TRIG.disable(TRIGS.ascendril_disable_sunpot);
end, "ASCENDRIL_OFFENSE_TRACKING", "");


TRIG.register("ascendril_glazeflow_fallen", "regex", [[^Frozen tendrils sprout from a flow of icy glaze, adhering to (\w+)'s skin and sapping]], function()
    TRACK.abilityDamage(TRACK.get(matches[2]), 0, 0.13, 1.0, 1.0, "cold");
    TRACK.taff(matches[2], "FALLEN");
end, "ASCENDRIL_OFFENSE_TRACKING", "");


TRIG.register("ascendril_icicle_confirm", "regex", [[.]], function()
    if (not PFLAGS.non_ab_limb_attacks) then return; end
    local tt = PFLAGS.non_ab_limb_attacks.ttable;
    display("Icicle confirmed", PFLAGS.non_ab_limb_attacks.limb);
    TRACK.abilityDamage(tt, 0, 0.35, 1.0, 1.0, "cold");
    TRACK.damageLimb(tt, "torso", 12);
    TRIG.disable(TRIGS.ascendril_icicle_confirm);
end, "ASCENDRIL_OFFENSE_TRACKING", "Confirming limb damage for icicle.")

TRIG.disable(TRIGS.ascendril_icicle_confirm);

TRIG.register("ascendril_icicle_hits", "regex", [[^A vicious icicle launches through the sky and pierces into (\w+)\'s stomach with its pointed tip\.$]],
function()
    local flagName = TRACK.getSelf().name .. "_icicles";
    if (FLAGS[flagName]) then
        FLAGS[flagName].count = FLAGS[flagName].count - 1;
        if (FLAGS[flagName].count == 0) then
            NU.clearFlag(flagName);
        end
    end

    NU.setPFlag("non_ab_limb_attacks", {ttable = TRACK.get(matches[2]), limb = "torso"});
    TRIG.enable(TRIGS.ascendril_icicle_confirm);
end, "ASCENDRIL_OFFENSE_TRACKING", "");


--TRIG.register("ascendril_icicle_miss", "", [[An icicle whizzies through the sky, missing completey and shattering against the ground.]], function() end, "ASCENDRIL_OFFENSE_TRACKING", "");

TRIG.register("ascendril_shatter_confirm", "regex", [[.]], function()
    if (not PFLAGS.non_ab_limb_attacks) then return; end

    display("Shatter confirmed", PFLAGS.non_ab_limb_attacks.limb);

    local tt = PFLAGS.non_ab_limb_attacks.ttable;
    local limb = PFLAGS.non_ab_limb_attacks.limb;
    TRACK.abilityDamage(tt, 0, 0.03, 1.0, 1.0, "blunt");
    TRACK.damageLimb(tt, limb, 4);
    TRIG.disable(TRIGS.ascendril_shatter_confirm);
end, "ASCENDRIL_OFFENSE_TRACKING", "Confirming limb damage for icicle.")

TRIG.disable(TRIGS.ascendril_shatter_confirm);

TRIG.register("ascendril_shatter_impacts", "regex", [[^Winding through the air\, an ice shard buries itself into (\w+)\'s (left arm|right arm|left leg|right leg|head|torso)\.$]],
function()
    NU.setPFlag("non_ab_limb_attacks", {ttable = TRACK.get(matches[2]), limb = matches[3]});
    TRIG.enable(TRIGS.ascendril_shatter_confirm);
end, "ASCENDRIL_OFFENSE_TRACKING", "");
-- 
-- 
-- 
-- The elemental attack combines with a raging whirl of fire, forming into a flow of icy glaze.
local transformTable = {
    ["a shocking, electric sphere"] = "electrosphere",
    ["a raging whirl of fire"] = "blazewhirl",
    ["a flow of icy glaze"] = "glazeflow",
}
TRIG.register("ascendril_phenomena_transform", "regex", [[^The elemental attack combines with (.+), forming into (.+)\.$]], function()
    local existingPhenomena = FLAGS.elemental_phenomena;
    NU.setFlag("elemental_phenomena", {target = existingPhenomena and existingPhenomena.target or TRACK.get(NU.target), type = transformTable[matches[3]], hp = existingPhenomena and existingPhenomena.hp - 1 or 9, loc = gmcp.Room.Info.num}, 360);
end, "ASCENDRIL_OFFENSE_TRACKING", "Phenomena Transformation");

-- TRIG.register("ascendril_electrosphere_chasing", "", [[The loud crackling from an electric sphere grows quiet as it floats out to the southeast.]], function() end, "ASCENDRIL_OFFENSE_TRACKING", "");
-- TRIG.register("ascendril_electrosphere_slowdown", "regex", [[Gherond is surrounded by a static hum as the Idreth attempts to leave.]], function() end, "ASCENDRIL_OFFENSE_TRACKING", "");


TRIG.register("ascendril_writhe_ice_from_winterheart", "regex", [[^The icy grip around (\w+)\'s heart spreads\, enveloping .+ within clear crystalised ice\.$]], function() TRACK.taff(matches[2], "writhe_ice") end, "ASCENDRIL_OFFENSE_TRACKING", "");

TRIG.register("ascendril_windlance_shieldstrip", "regex", [[^The lance rips through (\w+)\'s magical shield, tearing it apart as it passes\.]], function() TRACK.stripTDef(matches[2], "shielded"); end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_windlance_prone", "regex", [[^The force of the lance knocks (\w+) from .+ feet, the static wind shocking]], function() TRACK.taff(matches[2], "FALLEN"); end, "ASCENDRIL_OFFENSE_TRACKING", "");

local function onThunderbrand()
    local ttable = TRACK.get(matches[2]);
    TRACK.aff(ttable, "thunderbrand");
    NU.setFlag("thunderbrand", true, 120, function() TRACK.cure(ttable, "thunderbrand"); end);
end

TRIG.register("ascendril_thunderbrand", "regex", [[^The brooding, relentless pressure leaves an indent upon (\w+)\'s brow, sinking into the Brand of Thunder\.$]], onThunderbrand, "ASCENDRIL_OFFENSE_TRACKING");

local function onAeroblast()
    local tt = TRACK.get(matches[2]);

    if (tt.affs.dizziness and tt.affs.veritgo) then
        TRACK.aff(tt, "disrupt");
    end

    if (tt.affs.stupidity and tt.affs.confusion) then
        TRACK.aff(tt, "dazed");
    end

    if (tt.affs.torso_broken) then
        TRACK.stripDef(tt, "speed");
    end
    -- if (tt.affs.dizziness and tt.affs.vertigo and tt.affs.stupidity and tt.affs.confusion) then
    --     TRACK.abilityDamage(tt, 0, 0.48, 1.0, 1.0, "blunt");
    -- elseif ((tt.affs.dizziness and tt.affs.vertigo) or (tt.affs.stupidity and tt.affs.confusion)) then
    --     TRACK.abilityDamage(tt, 0, 0.25, 1.0, 1.0, "blunt");
    -- else
        
    -- end
    TRACK.abilityDamage(tt, 0, 0.16, 1.0, 1.0, "blunt");

end

local function onAeroblastElectric()
    local tt = TRACK.get(matches[2]);

    TRACK.abilityDamage(tt, 0, 0.10, 1.0, 1.0, "blunt");
    TRACK.abilityDamage(tt, 0, 0.078, 1.0, 1.0, "electric");

    TRACK.aff(tt, "vomiting");
end

-- The howling winds converge on either side of Ellaor and crash into his magical shield.
TRIG.register("ascendril_aeroblast_blunt", "regex", [[^The howling winds crash into either side of (\w+), flipping them over and smashing them against the ground\.$]], onAeroblast, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_aeroblast_retriggered", "regex", [[^The Brand of Thunder on (\w+) pulses, releasing electricity into the air as it surges and circles around\.$]],
function()
    local flagName = TRACK.getSelf().name .. "_aeroblast";
    if (FLAGS[flagName]) then
        NU.setFlag(flagName, matches[2], 6);
    end
end,
"ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_aeroblast_electric", "regex", [[^The electrified winds crash into either side of (\w+) with a thunderous boom\, flipping them over and smashing them against the ground\.$]], onAeroblastElectric, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_etherflux_applied", "regex", [[^Elemental energy ripples across (\w+)\, sizzling as it irratiates .+ skin\.$]], function() TRACK.taff(matches[2], "etherflux"); end, "ASCENDRIL_OFFENSE_TRACKING", "");



TRIG.register("ascendril_disintegrate_strip", "regex", [[^Their (.+) defence disintegrates under the flames\.]], function() end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_channel_stop", "exact", [[Your spell loses its focal power and dissipates.]],
function() NU.clearFlag(TRACK.getSelf().name .. "_channeling"); end, "ASCENDRIL_OFFENSE_TRACKING",
    "When a channel fizzles");
TRIG.register("ascendril_schism_already_up", "exact", [[Your fulcrum is already resonating with a dissonant effect.]], function() NU.appendFlag("misc_defs", "fulcrum_schism", true); end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_imbalance_already_up", "exact", [[Your fulcrum is already resonating with an imbalancing effect.]], function() NU.appendFlag("misc_defs", "fulcrum_imbalance", true); end, "ASCENDRIL_OFFENSE_TRACKING", "");
-- Fire Enrich
-- 
TRIG.register("ascendril_enrich_on_cd", "exact", [[You cannot enrich your fulcrum again so soon.]], function()
    NU.cooldown(TRACK.getSelf().name .. "_Fulcrum_Enrich", 30);
end, "ASCENDRIL_OFFENSE_TRACKING", "");

TRIG.register("ascendril_enrich_fire", "exact", [[Drawing on the essence of hearth, forge, and the deep veins of the world, you align your fulcrum's resonance with fire.]], function()
    NU.cooldown(TRACK.getSelf().name .. "_Fulcrum_Enrich", 30);
end, "ASCENDRIL_OFFENSE_TRACKING", "");
-- Water Enrich
--
TRIG.register("ascendril_enrich_water", "exact", [[Your will sinking into the fluid continuity of rivers and the hammering pulse of the tide, you align your fulcrum's resonance with water.]], function()
    NU.cooldown(TRACK.getSelf().name .. "_Fulcrum_Enrich", 30);
end, "ASCENDRIL_OFFENSE_TRACKING", "");

-- Air Enrich
-- 
TRIG.register("ascendril_enrich_air", "exact", [[Your breath rising into the crackling potential of the wind and storm, you align your fulcrum's resonance with air.]], function()
    NU.cooldown(TRACK.getSelf().name .. "_Fulcrum_Enrich", 30);
end, "ASCENDRIL_OFFENSE_TRACKING", "");


TRIG.register("ascendril_already_icicled", "exact", [[You have already conjured an icicle barrage.]], function() NU.setFlag(TRACK.getSelf().name .. "_icicles", {loc = gmcp.Room.Info.num, count = 3}, 5); end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_no_icicle", "exact", [[You haven't conjured an icicle barrage.]], function() NU.clearFlag(TRACK.getSelf().name .. "_icicles"); end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_frostbrand_hypothermia", "regex",
[[^Limned with ice, (\w+)'s skin becomes a pale blue beneath the Brand of the Frost's chilling grasp\.$]],
function() TRACK.taffs(matches[2], "hypothermia", "frozen") end, "ASCENDRIL_OFFENSE_TRACKING", "");
-- TRIG.register("ascendril_", "", [[]], function() end, "ASCENDRIL_OFFENSE_TRACKING", "");

-- Arcbolt impact
-- The arcing chain of electricity slams into Eaku, the deafening impact causing his body to jerk wildly.


local function newGlimpseHit()
    if (not PFLAGS.new_glimpse) then
        return;
    end

    local tt = TRACK.get(matches[2]);

    if (PFLAGS.new_glimpse == "fire" and tt.affs.ablaze) then
        -- TODO: Handle balance knocks?
    elseif (PFLAGS.new_glimpse == "water" and tt.affs.hypothermia) then
        TRACK.aff(tt, AB.freezeStack(tt, 1));
    elseif (PFLAGS.new_glimpse == "air" and tt.affs.vertigo) then
        TRACK.aff(tt, "muddled");
    end
end

TRIG.register("water_glimpse", "exact", [[Rhythmic and unyielding, ethereal waves crash and wrench at the victims caught in their transplanic undertow.]], function() NU.setPFlag("new_glimpse", "water"); NU.setFlag("next_glimpse_hit", NU.time() + 7, 7); creplaceLine("<steel_blue>WATER GLIMPSE"); end, "ASCENDRIL_OFFENSE_TRACKING");
TRIG.register("air_glimpse", "exact", [[Lightning flashes and crackles through the air, each flash searing those with a mirage of an alien tempest.]], function() NU.setPFlag("new_glimpse", "air"); NU.setFlag("next_glimpse_hit", NU.time() + 7, 7); creplaceLine("<khaki>AIR GLIMPSE"); end, "ASCENDRIL_OFFENSE_TRACKING");
TRIG.register("fire_glimpse", "exact", [[Debris and ash whirl all around chokingly, painting a vivid, ghostly dance of a far-off, blazing land.]], function() NU.setPFlag("new_glimpse", "fire"); NU.setFlag("next_glimpse_hit", NU.time() + 7, 7); creplaceLine("<firebrick>FIRE GLIMPSE"); end, "ASCENDRIL_OFFENSE_TRACKING");

TRIG.register("glimpse_effect", "regex", [[^Your glimpse affects (\w+)\.$]], newGlimpseHit);

TRIG.register("glimpse_end", "regex", [[^Your glimpse of (Air|Water|Fire) has ended\.$]], function() NU.clearFlag("glimpse"); NU.clearFlag("next_glimpse_hit"); end, "ASCENDRIL_OFFENSE_TRACKING");
TRIG.register("glimpse_inactive", "exact", [[You do not have a glimpse active in this room.]], function() NU.clearFlag("glimpse"); NU.clearFlag("next_glimpse_hit"); end, "ASCENDRIL_OFFENSE_TRACKING");

-- TODO: Move this somewhere that makes sense
-- You glance over Gherond and see that his health is at 6948/7048.
TRIG.register("target_hp_values", "regex", [[^You glance over (\w+) and see that .+ health is at (\d+)\/(\d+)\.$]], function() TRACK.setHP(TRACK.get(matches[2]), tonumber(matches[3]), tonumber(matches[4])); end, "TARGET_TRACKING", "Assess HP/MAXHP set.");
TRIG.register("target_mana_values", "regex", [[^(\w+)\'s mana stands at (\d+)/(\d+)\.$]], function() TRACK.setMP(TRACK.get(matches[2]), tonumber(matches[3]), tonumber(matches[4])); end, "TARGET_TRACKING", "Contemplate MP/MAXMP set.");
TRIG.register("ascendril_thaum_detect", "regex", [[^Your fulcrum detects (\w+) to have a health of (\d+) and a mana of (\d+)\.$]],
function()
    local tt = TRACK.get(matches[2]);
    TRACK.setHP(tt, tonumber(matches[3]));
    TRACK.setMP(tt, tonumber(matches[4]));
    NU.setFlag("recently_detected", true, 12);
end, "ASCENDRIL_OFFENSE_TRACKING", "");

TRIG.register("ascendril_blazewhirl_succ", "regex", [[^The flames surrounding (\w+) get sucked into the raging fire whirl as it spins past]], function() TRACK.nameCure(matches[2], "ablaze"); end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_blazewhirl_out", "exact", [[The blazewhirl dwindles down to glowing embers that scatter across the space.]], function() NU.clearFlag("elemental_phenomena"); end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_capacitance_disrupt", "regex",
    [[^Bolts of shocking energy spark outwards from your hands, leaping into (\w+) in a lightning-fast flash\.$]],
    function() TRACK.taffs(matches[2], "disrupted") end, "ASCENDRIL_OFFENSE_TRACKING", "");
-- 

TRIG.register("ascendril_aeroblast_stun_proc", "regex", [[^With a thundering roar, (\w+) erupts into blinding white\-hot plasma that wreathes itself around .+\.$]], function() local tt = TRACK.get(matches[2]); TRACK.aff(tt, "stun"); NU.setFlag(tt.name .. "_stun_remove", true, 3, function() TRACK.remove(tt, "stun"); end); end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_pressurize_laxity", "regex", [[^The powerful pressure causes a lack of blood flow to (\w+)\'s head, leaving .+ with a lax expression\.$]], function() TRACK.taff(matches[2], "laxity"); end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_coldsnap_hit", "regex", [[^Frost forms upon (\w+)\, plunging .+ body temperature into a deep cold\.$]], function()
    local tt = TRACK.get(matches[2]);
    TRACK.affs(tt, AB.freezeStack(tt, 2));
    if (tt.affs.frostbrand) then
        TRACK.abilityDamage(tt, 0, .18, 1, 1, "cold");
    end


end, "ASCENDRIL_OFFENSE_TRACKING", "");

TRIG.register("emberbrand_tick", "regex",
    [[^The Brand of Ember seared upon (\w+) glows, rippling outward as sweltering heat eminates from it\.$]],
    function()
        local tt = TRACK.get(matches[2]); if (tt.affs.clumsiness) then
            TRACK.aff(tt, "weariness");
        else
            TRACK.aff(tt,
                "clumsiness");
        end
    end, "ASCENDRIL_OFFENSE_TRACKING");
TRIG.register("ascendril_blazewhirl_tick", "regex", [[^Streaks of fire burn (\w+)\'s body as a raging whirl of fire rotates its mass through .+\.$]], function() local tt = TRACK.get(matches[2]); TRACK.abilityDamage(tt, 0, 0.005, 1.0, 1.0, "fire"); NU.setFlag("blazewhirl_stacks", FLAGS.blazewhirl_stacks and FLAGS.blazewhirl_stacks + 1 or 1, 60); end, "ASCENDRIL_OFFENSE_TRACKING", "");
TRIG.register("ascendril_no_simultaneity", "start", [[You do not have a channel open to]],
    function() if (FLAGS.misc_defs) then FLAGS.misc_defs.simultaneity = false; end end, "ASCENDRIL_OFFENSE_TRACKING", "");
-- TRIG.register("ascendril_", "", [[Crackling cobalt energy arcs throughout the air, the wicked tines of catastrophic lightning lancing through Irra.]], function() end, "ASCENDRIL_OFFENSE_TRACKING", "");
-- TRIG.register("ascendril_", "", [[]], function() end, "ASCENDRIL_OFFENSE_TRACKING", "");
-- TRIG.register("ascendril_", "", [[]], function() end, "ASCENDRIL_OFFENSE_TRACKING", "");
-- TRIG.register("ascendril_", "", [[]], function() end, "ASCENDRIL_OFFENSE_TRACKING", "");
-- TRIG.register("ascendril_", "", [[]], function() end, "ASCENDRIL_OFFENSE_TRACKING", "");