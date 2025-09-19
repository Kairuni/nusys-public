-- TODO: Go through every state tracking trigger and make sure we have the illusion gating in place.
-- Self limb damage tracking - sets ignoreBreak to true because we have aff tracking.
TRIG.register("limb_damage", "regex", [[^Your (head|torso|right arm|left arm|right leg|left leg) has taken ([\d\.]+)\% damage\.$]], function() TRACK.damageLimb(TRACK.getSelf(), matches[2], tonumber(matches[3]), true) end);
TRIG.register("limb_cure", "regex", [[^Your (head|torso|right arm|left arm|right leg|left leg) has recovered ([\d\.]+)\% damage\.$]], function() TRACK.restoLimb(TRACK.getSelf(), matches[2], true, tonumber(matches[3])); end);
TRIG.register("limb_zero_damage", "exact", [[The poultice mashes uselessly against your body.]], function() if (FLAGS[TRACK.getSelf().name .. "_resto_applied"]) then TRACK.setLimbDamage(TRACK.getSelf(), FLAGS[TRACK.getSelf().name .. "_resto_applied"][2], 0.0) end end);

TRIG.register("start_wounds", "regex", [[^You take a moment to assess how damaged (\w+)\'?s? limbs are\:$]], function() if (PFLAGS.illusion) then return; end NU.setPFlag("assessing", TRACK.get(matches[2])); TRIG.enable(TRIGS.wounds_lines); TRIG.enable(TRIGS.wounds_eq); end);
TRIG.register("wounds_lines", "regex", [[^(Head|Torso|Left arm|Right arm|Left leg|Right leg)\:\s+([\d\.]+)]], function() TRACK.setLimbDamage(PFLAGS.assessing, matches[2]:lower(), tonumber(matches[3])); end);
TRIG.register("wounds_eq", "start", [[Equilibrium Used:]], function() TRIG.disable(TRIGS.wounds_lines); TRIG.disable(TRIGS.wounds_eq); end);
TRIG.disable(TRIGS.wounds_lines);
TRIG.disable(TRIGS.wounds_eq);

-- In theory this should play nice - disable apply_attack if we match one of these lines, re-enable it next line.
local function limbBreak()
    TRACK.taff(matches[2], matches[3]:gsub(" ", "_") .. "_crippled");
    TRACK.taff(matches[2], matches[3]:gsub(" ", "_") .. "_broken");
    TRIG.enable(TRIGS.limb_break_attack_reenabler);
    TRIG.disable(TRIGS.apply_attack);
end
local function limbMangled()
    TRACK.taff(matches[2], matches[3]:gsub(" ", "_") .. "_crippled");
    TRACK.taff(matches[2], matches[3]:gsub(" ", "_") .. "_broken");
    TRACK.taff(matches[2], matches[3]:gsub(" ", "_") .. "_mangled");
    TRIG.enable(TRIGS.limb_break_attack_reenabler);
    TRIG.disable(TRIGS.apply_attack);
end
local function limbBreakAttackReenabler()
    TRIG.enable(TRIGS.apply_attack);
    TRIG.disable(TRIGS.limb_break_attack_reenabler);
end

TRIG.register("limb_break_attack_reenabler", "regex", [[.]], limbBreakAttackReenabler)

TRIG.register("limb_broken", "regex", [[^(\w+)\'s (head|torso|right arm|left arm|right leg|left leg) (?:breaks from all the damage|is shredded into meaty ribbons)\.$]], limbBreak);
TRIG.register("head_broken", "regex", [[^(\w+) grows sluggish, .+ (head) marred with trauma\.$]], limbBreak);
TRIG.register("torso_broken", "regex", [[^(\w+) shudders from the discomfort suffered to .+ (torso)\.$]], limbBreak);

TRIG.register("limb_mangled", "regex", [[^(\w+)\'s (head|torso|right arm|left arm|right leg|left leg) has been (beaten|torn) into uselessness\.$]], limbMangled);
TRIG.register("head_mangled", "regex", [[^(\w+) groans loudly, clutching .+ mangled and bloodied (head)\.$]], limbMangled);


local function regeneration()
    if (PFLAGS.illusion) then return; end
    local ttable = TRACK.get(matches[2]);
    NU.setFlag(ttable.name .. "_regenerate", true, 5);
end
TRIG.register("regenerate", "regex", [[^(\w+) becomes flushed as .+ (head|torso|right arm|left arm|right leg|left leg) heals with quickened haste\.$]], regeneration);

TRIG.register("active_parrying", "regex", [[^You will now attempt to parry attacks to your (head|torso|right arm|left arm|right leg|left leg)\.$]], function() if (not PFLAGS.illusion) then NU.setFlag("parrying", matches[2], 20); end end);
TRIG.register("active_parrying2", "regex", [[^You will attempt to parry attacks to your (head|torso|right arm|left arm|right leg|left leg)\.$]], function() if (not PFLAGS.illusion) then NU.setFlag("parrying", matches[2], 20); end end);
TRIG.register("active_intercept", "regex", [[^You will now attempt to intercept and counter attacks coming at your (head|torso|right arm|left arm|right leg|left leg)\.$]], function() if (not PFLAGS.illusion) then NU.setFlag("parrying", matches[2], 20); end end);
TRIG.register("active_guarding", "regex", [[^You will attempt to throw those who attack your (head|torso|right arm|left arm|right leg|left leg)\.$]], function() if (not PFLAGS.illusion) then NU.setFlag("parrying", matches[2], 20); end end);
TRIG.register("active_fending", "regex", [[^You will now try and fend off attacks aimed at your (head|torso|right arm|left arm|right leg|left leg)\.$]], function() if (not PFLAGS.illusion) then NU.setFlag("parrying", matches[2], 20); end end);
TRIG.register("active_oppose", "regex", [[^You will ruthlessly oppose attacks on your (head|torso|right arm|left arm|right leg|left leg)\.$]], function() if (not PFLAGS.illusion) then NU.setFlag("parrying", matches[2], 20); end end);


TRIG.register("zealot_fend", "regex", [[^With a free hand\, \w+ fends off the attack on \w+ (head|torso|right arm|left arm|right leg|left leg|legs|arms)\.$]], TRACK.parry);
TRIG.register("ravager_oppose", "regex", [[^With a predatory growl\, \w+ opposes the attack on \w+ (head|torso|right arm|left arm|right leg|left leg|legs|arms)\, denying it purchase\.$]], TRACK.parry);
TRIG.register("zealot_rebuke", "regex", [[\'s chains tighten and rebuke the blow on \w+ (head|torso|right arm|left arm|right leg|left leg|legs|arms) with blinding light.]], TRACK.parry);
TRIG.register("guarding", "regex", [[guards the attack on \w+ (head|torso|right arm|left arm|right leg|left leg|legs|arms)\.$]], TRACK.parry);
TRIG.register("parry", "regex", [[parries the attack on \w+ (head|torso|right arm|left arm|right leg|left leg|legs|arms) with a deft maneuver\.$]], TRACK.parry);
TRIG.register("predator_defang", "regex", [[parries the attack to \w+ (head|torso|right arm|left arm|right leg|left leg|legs|arms), pushing you back\.$]], TRACK.parry);



TRIG.register("monk_guard", "regex", [[steps into the attack on \w+ (head|torso|right arm|left arm|right leg|left leg|legs|arms)\, grabs your arm\, and shakes you violently\.$]], function() NU.clearFlag("parrying"); end);
TRIG.register("golem_parry_strip", nil, [[golem lashes out as you parry the blow, rattling your defences.]], function() NU.clearFlag("parrying"); end);
TRIG.register("elemental_parry_strip", nil, [[enacts a vengeful reprisal, leaving you reeling and vulnerable.]], function() NU.clearFlag("parrying"); end);
TRIG.register("parry_stop", "exact", [[You cease your attempts at parrying.]], function() NU.clearFlag("parrying"); end);