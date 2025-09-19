local function limbDmgWithConfirmation(target, loc, dmg, aff)
    if (PFLAGS.illusion) then return; end
    NU.setPFlag("pending_limb_hit", { target = TRACK.get(target), loc = loc, dmg = dmg, aff = aff });
end

local function applyLimbDamage()
    local toApply = PFLAGS["pending_limb_hit"];
    if (PFLAGS.illusion or not toApply or TRACK.isSelf(toApply.target)) then return; end
    TRACK.damageLimb(toApply.target, toApply.loc, toApply.dmg);
    if (toApply.aff) then
        TRACK.aff(toApply.target, toApply.aff);
    end
end

TRIG.register("heelrush_2", "regex", [[^Whirling your foot around\, you land it into (\w+)\'s (head|torso|left arm|right arm|left leg|right leg) with a second hit\.$]], function() limbDmgWithConfirmation(matches[2], matches[3], 8.0) end, "ZEALOT_OFFENSE_TRACKING");
TRIG.register("heelrush_3", "regex", [[^With the last of your momentum\, you heave a straight kick into (\w+)\'s (head|torso|left arm|right arm|left leg|right leg)\.$]], function() limbDmgWithConfirmation(matches[2], matches[3], 11.0) end, "ZEALOT_OFFENSE_TRACKING");
TRIG.register("heelrush_hits", "exact", "Your blow lands heavily with weight.", applyLimbDamage, "ZEALOT_OFFENSE_TRACKING")
-- The above is fine, rather than `Your blow lands heavily with weight.` - because we explicitly track parry by undoing the limb damage.
-- We can adjust this later for damage when implemented? Alternatively, we can set a flag preHit for Zealot limb damage. Need to verify this is what it does on miss.

TRIG.register("direblow_heavy", "regex", [[^With your boundless strength\, you drive your rigid hand through (\w+)\.$]], function() limbDmgWithConfirmation(matches[2], "torso", 20.0, "deepwound"); end, "ZEALOT_OFFENSE_TRACKING");
TRIG.register("direblow_heavy_connect", "exact", [[Your hand parts flesh and delivers a deep, gory wound.]], applyLimbDamage, "ZEALOT_OFFENSE_TRACKING");
TRIG.register("direblow_light", "regex", [[^Weakened\, you thrust your rigid hand into (\w+) with low momentum\.$]], function() limbDmgWithConfirmation(matches[2], "torso", 7.5, "lightwound"); end, "ZEALOT_OFFENSE_TRACKING");
TRIG.register("direblow_light_connect", "exact", [[Your hand sinks partly in as blood oozes around it.]], applyLimbDamage, "ZEALOT_OFFENSE_TRACKING");

-- TODO: Pull the cmsg target.
TRIG.register("palmforce_connect", "regex", [[^The generated force knocks .+ to the floor\.$]],
    function() TRACK.taff(NU.target, "FALLEN"); end, "ZEALOT_OFFENSE_TRACKING");
TRIG.register("direblow_made_light", "exact", [[You opt for a weaker blow as you act early.]], function() creplaceLine("<red>WEAKENED DIREBLOW"); end, "ZEALOT_LINE_REPLACEMENTS");

TRIG.register("firefist_ablaze", "regex", [[^Your burning fist catches (\w+) alight in a pale\, triumphant blaze\.$]], function() TRACK.taff(matches[2], "ablaze"); end, "ZEALOT_OFFENSE_TRACKING");

TRIG.register("hellcat_fire", "regex", [[^A hellcat shreds (\w+) with blazing claws\, heat lashing forth to scourge]], function() TRACK.tstack(matches[2], "ablaze") end, "ZEALOT_OFFENSE_TRACKING", "Hellcat stacks");

TRIG.register("zealot_pendulum_cd", "exact", [[Your spirit has yet to recover enough to enact that skill once more]], function() NU.cooldown("Purification_Pendulum", 20); end, "ZEALOT_OFFENSE_TRACKING", "Pendulum CD.");
TRIG.register("zealot_pendulum_off_cd", "exact", [[You feel your spirit swell with renewed energy.]], function() NU.offCD("Purification_Pendulum"); end, "ZEALOT_OFFENSE_TRACKING", "Pendulum off CD.");

TRIG.register("zealot_wrath_parry", "regex", [[^You see (\w+) shift .+ parry to .+ (head|torso|left arm|right arm|left leg|right leg)\.$]], function() NU.setFlag("last_seen_parry", matches[3], 12); end, "ZEALOT_OFFENSE_TRACKING", "Wrath parry tracking.")
TRIG.register("zealot_wrath_off_cd", "exact", [[You may call upon your wrath once more.]], function() NU.offCD("Zeal_Wrath"); end, "ZEALOT_OFFENSE_TRACKING", "Wrath off CD.")
TRIG.register("zealot_welt", "regex", [[^A throbbing welt forms on (\w+)\'s (head|torso|left arm|right arm|left leg|right leg)\.$]], function() NU.setFlag("zealot_welt_" .. matches[2]:lower(), matches[3], 4); end, "ZEALOT_OFFENSE_TRACKING", "Welt formed");
TRIG.register("zealot_welt_damage", "regex", [[^(w+) winces as .+ (head|torso|left arm|right arm|left leg|right leg) throbs from duress\.$]], function() NU.clearFlag("zealot_welt"); TRACK.damageLimbByName(matches[2], matches[3], 6.5, false); end, "ZEALOT_OFFENSE_TRACKING", "Welt damage");

TRIG.register("zealot_rebuke_off_cd", "exact", [[You may rebuke an attack on your limbs once more.]], function() NU.offCD("Purification_Rebuke"); end, "ZEALOT_OFFENSE_TRACKING", "Rebuke CD.");

TRIG.register("already_dislocated", "exact", [[You apply a bit of force, however the bone is already damaged.]],
function()
if (PFLAGS.dislocate_firing) then
    TRACK.cure(PFLAGS.dislocate_firing.ttable, PFLAGS.dislocate_firing.aff);
end;
end, "ZEALOT_OFFENSE_TRACKING", "Failed dislocate.")
-- You apply a bit of force, however the bone is already damaged.
TRIG.register("dislocation_break", "regex", [[^The prolonged dislocation of (\w+)\'s (head|torso|left arm|right arm|left leg|right leg) has exacerbated the injury\.$]],
    function()
        TRIG.enable(TRIGS.dislocation_break_success);
        TRIG.enable(TRIGS.dislocation_mangle_success);
        if (TRIG.illusion) then return; end
        NU.setPFlag("nextDislocate", {ttable = TRACK.get(matches[2]), limb = matches[3]});
    end,
"SYMPTOM_DISLOCATE", "Dislocate triggering.");

TRIG.register("dislocation_break_success", "regex", [[(left arm|right arm|right leg|left leg) breaks from all the damage\.$]],
    function()
        TRIG.disable(TRIGS.dislocation_break_end);
        TRIG.disable(TRIGS.dislocation_break_success);
        TRIG.disable(TRIGS.dislocation_mangle_success);
        local ttable = PFLAGS.nextDislocate.ttable;
        local limb = matches[2];
        if (ttable.wounds[limb] < 33.33) then
            TRACK.setLimbDamage(ttable, limb, 33.3333);
            NU.setPFlag(ttable.name .. "_" .. limb .. "_ex_broken", true);
        end
    end,
"SYMPTOM_DISLOCATE_SUCCESS", "Dislocate triggering.");

TRIG.register("dislocation_mangle_success", "regex", [[(left arm|right arm|right leg|left leg) has been beaten into uselessness\.$]],
    function()
        TRIG.disable(TRIGS.dislocation_break_end);
        TRIG.disable(TRIGS.dislocation_break_success);
        TRIG.disable(TRIGS.dislocation_mangle_success);
        local ttable = PFLAGS.nextDislocate.ttable;
        local limb = matches[2];
        if (ttable.wounds[limb] >= 33.33 and ttable.wounds[limb] < 66.66) then
            TRACK.setLimbDamage(ttable, limb, 66.6666);
            NU.setPFlag(ttable.name .. "_" .. limb .. "_ex_mangled", true);
        end
    end,
"SYMPTOM_DISLOCATE_SUCCESS", "Dislocate mangle triggering.");
TRIG.register("dislocation_break_end", "regex", [[.]], function() TRIG.disable(TRIGS.dislocation_break_success); TRIG.disable(TRIGS.dislocation_mangle_success); TRIG.disable(TRIGS.dislocation_break_end); end, "SYMPTOM_DISLOCATE_SUCCESS", "Dislocate didn't trigger.");


TRIG.register("zealot_infernal_trigger", "regex", [[^The Infernal Seal upon (\w+) flares sharply\, setting]], function() TRACK.taff(matches[2], "ablaze"); end, "ZEALOT_OFFENSE_TRACKING", "Infernal ablaze");

-- The Infernal Seal on Rijetta's chest releases a shower of holy flame, blanketing the air about her with a burning shroud.
-- what is this

TRIG.register("zealot_pyromania_running", "exact", [[You have already enacted pyromania.]], function() NU.setFlag("pyromania", true, 10); end, "ZEALOT_OFFENSE_TRACKING", "Already pyromania'd");
TRIG.register("zealot_pyromania_shield", "regex", [[^The ground vents open\, and a hellish torrent of heat destroys (\w+)\'s magical shield\.$]], function() TRACK.stripDef(TRACK.get(matches[2]), "shielded"); end, "ZEALOT_OFFENSE_TRACKING", "Pyromania shield strip");
TRIG.register("zealot_pyromania_damage", "regex", [[^The ground vents open\, and a hellish torrent of heat and ash scourge (\w+)\.$]], function() TRACK.tstack(matches[2], "ablaze"); end, "ZEALOT_OFFENSE_TRACKING", "Pyromania damage");
TRIG.register("zealot_pyromania_over", "exact", [[You feel the heat in the ground dissipate.]], function() NU.clearFlag("pyromania"); end, "ZEALOT_OFFENSE_TRACKING", "Pyromania ending.");

-- Dazed, no limb damage
--With a quick spin, you twist your palm and strike Jakarn's face.
--You hear a satisfying crack of sound as your palm connects.

-- After 7 seconds
-- 
-- 5% limb damage on movement
-- Add this to RemovePlayer and AddPlayer.

-- On stand, 10% damage to torso if backstrain

-- On parry, 4% limb damage to both arms

-- On sip, 6.5% to head with whiplash



TRIG.register("zealot_disable_off_cd", "exact", [[You can disable another ability once more.]], function() NU.offCD("Psionics_Disable"); end, "ZEALOT_OFFENSE_TRACKING", "Pendulum off CD.");
-- Kalena wavers, but she resists your mental seperation.
-- You have disabled Kalena's ability to use 'Parry'.

TRIG.register("zealot_vacuum_breaks", "start", [[You raise a hand skyward, consuming the air between]], function() TRIG.enable(TRIGS.zealot_vacuum_landing); TRIG.enable(TRIGS.zealot_vacuum_miss); end, "ZEALOT_OFFENSE_TRACKING", "Starting vacuum.");
TRIG.register("zealot_vacuum_landing", "regex", [[^(\w+) plummets from the skies\, hitting the ground with a dull\, heavy crunch\.$]], function() TRACK.taffs(matches[2], "left_leg_crippled", "right_leg_crippled") TRIG.disable(TRIGS.zealot_vacuum_landing); TRIG.disable(TRIGS.zealot_vacuum_miss); end, "ZEALOT_OFFENSE_TRACKING", "Starting vacuum.");
TRIG.register("zealot_vacuum_miss", "regex", [[.]], function() TRIG.disable(TRIGS.zealot_vacuum_landing); TRIG.disable(TRIGS.zealot_vacuum_miss); end, "ZEALOT_OFFENSE_TRACKING", "Starting vacuum.");

TRIG.register("zealot_psi_tether", "regex", [[^You feel the psionic tether between you and (\w+)) snap with stinging recoil\.$]], function() NU.setFlag("tether_snapped", true, 3.5); end, "ZEALOT_OFFENSE_TRACKING", "Psi tether snapping");

TRIG.register("zealot_welt_throb", "regex", [[^(\w+) winces as .+ (left leg|right leg|torso|head|left arm|right arm) throbs from duress\.$]], function() TRACK.damageLimb(TRACK.get(matches[2]), matches[3], 6.5) end, "ZEALOT_OFFENSE_TRACKING", "Welt limb damage.");

-- Not Zealot, but for vacuum triggering:
-- The air ripples around Luca, eddying after him as he ascends southward.
-- Luca flies away to the beyond.

-- sliver: Your enhanced senses inform you that Luca has appeared to the south.

-- step chases even across elevations.

-- You feel the psionic tether between you and Luca snap with stinging recoil.
-- Unconscious for 3.5s.
-- Luca regains consciousness with a start.

-- Channeling palmforce strike, maybe others?
-- You shift into a stance that allows for a follow up.