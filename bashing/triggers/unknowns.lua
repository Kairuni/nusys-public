local function oneArmFunc()
    NU.setPFlag("expected_hiddens", {source = "bashing", affList = {"left_arm_crippled", "right_arm_crippled"}, expectedCount = 1});
end
local function twoArmFunc()
    NU.setPFlag("expected_hiddens", {source = "bashing", affList = {"left_arm_crippled", "right_arm_crippled"}, expectedCount = 2});
end
local function oneLegFunc()
    NU.setPFlag("expected_hiddens", {source = "bashing", affList = {"left_leg_crippled", "right_leg_crippled"}, expectedCount = 1});
end
local function twoLegFunc()
    NU.setPFlag("expected_hiddens", {source = "bashing", affList = {"left_leg_crippled", "right_leg_crippled"}, expectedCount = 2});
end
local function legAndFreeze()
    NU.setPFlag("expected_hiddens", {source = "bashing", affList = {"left_leg_crippled", "right_leg_crippled", "frozen"}, expectedCount = 2});
end
local function oneLimbFunc()
    NU.setPFlag("expected_hiddens", {source = "bashing", affList = {"left_arm_crippled", "right_arm_crippled", "left_leg_crippled", "right_leg_crippled"}, expectedCount = 1});
end
local function allLimbsFunc()
    NU.setPFlag("expected_hiddens", {source = "bashing", affList = {"left_arm_crippled", "right_arm_crippled", "left_leg_crippled", "right_leg_crippled"}, expectedCount = 4});
end
local function expectDamage()
    NU.setPFlag("expect_damage", true);
end

-- Single random broken limb
TRIG.register("bashing_nazetu_limb_break", "exact", [[With a softly-spoken word from a deformed Nazetu priest, your bones suddenly and agonizingly rearrange themselves.]], oneLimbFunc, "BASHING");
TRIG.register("bashing_ravenous_shark_limb_break", "exact", [[Blood floats up through the water as a blackened, ravenous shark seizes your arm in its maw, nearly tearing it from your body and snapping bones in the process.]], oneLimbFunc, "BASHING");

-- Multiple random broken limbs
TRIG.register("bashing_helba_depths_breaks", "exact", [[A towering fungal abomination lashes out with a massive limb, sending you to the ground with the pummeling strike. Your body screams in agony as your bones snap, pop, and crack beneath the pitiless assault.]], function() NU.setPFlag("expected_hiddens", {source = "bashing", affList = {"left_arm_crippled", "right_arm_crippled", "left_leg_crippled", "right_leg_crippled"}, expectedCount = 2}); end, "BASHING");

-- broken leg
TRIG.register("bashing_hound_leg_break", "exact", [[Growling in anger, a fierce hound leaps toward you, sinking his teeth into your leg and viciously shaking it, mangling the limb horribly.]], oneLegFunc, "BASHING");
TRIG.register("bashing_vakmut_leg_break_1", "exact", [[A snarling vakmut warhound lunges forward, heaving its bulk into you with a snarl and sends you flailing to the ground.]], oneLegFunc, "BASHING");
TRIG.register("bashing_hound_leg_break_2", "exact", [[A snarling vakmut warhound lunges forward, spittle flying from its jaws as it latches onto your leg, savaging it.]], oneLegFunc, "BASHING");
TRIG.register("bashing_tcanna_crab_legbreak", "exact", [[A blue crab snaps down on your leg and holds tight, crushing through bone and flesh as it drags you to the ground.]], oneLegFunc, "BASHING");
TRIG.register("bashing_aslinn_leg_break", "exact", [[A cruel Aslinn guard lands a punishing blow to your leg with her truncheon.]], oneLegFunc, "BASHING");
-- A dark green alligator lashes out of the water, snaring your leg in its teeth and shaking you roughly, the limb snapping in half with a large crack.

-- 2 broken leg
TRIG.register("bashing_tcanna_tortoise_legs_break", "exact", [[An oversized tortoise snaps its jaws at you several times before grasping your leg, biting down hard enough to crush the bone.]], twoLegFunc, "BASHING");
TRIG.register("bashing_tcanna_crab_legs_break", "exact", [[Scuttling to the side, a blue crab reaches out with its arms, snagging both of your legs in its claws before crushing them with a loud snap.]], twoLegFunc, "BASHING");


TRIG.register("bashing_tcanna_goose_legs_break", "exact", [[A white goose bites at your legs back and forth, scratching off flesh before it manages to get a good snag on one and then the other, shaking its head until the limbs break.]], legAndFreeze, "BASHING");

TRIG.register("bashing_eftehl_guard", "exact", [[Targeting your legs in a moment of opportunity, a ghost of a castle guard sends a pair of back-to-back strikes with his maces in an attempt to crush and shatter bones.]], twoLegFunc, "BASHING");

-- quad break
TRIG.register("bashing_tcanna_jaguar_quad_break", "exact", [[A spotted jaguar swiftly mounts a tree branch and dives at you from above, its weight breaking your arms and legs.]], allLimbsFunc, "BASHING");

-- broken arm
TRIG.register("bashing_darkwalker_arm_break", "exact", [[With a growl of defiance, a blackened darkwalker turns swiftly, its blackened armour shifting as it brings the jagged longsword slashing through your arm viciously, nearly severing the limb.]], oneArmFunc, "BASHING");
TRIG.register("bashing_chiakhi_arm_break", "exact", [[Lieutenant Chiakhi pulls a few threads of emerald luminescence from the air and whips them into your arm, disintegrating the bone.]], oneArmFunc, "BASHING");
TRIG.register("bashing_corrupter_arm_break", "exact", [[A Nazetu corrupter reaches out with a skeletal hand and encloses your arm in an iron grip, easily crushing bone and nearly ripping the appendage from its socket.]], oneArmFunc, "BASHING");
TRIG.register("bashing_aslinn_arm_break", "exact", [[A cruel Aslinn guard brings her truncheon down on your arm with brutal force.]], oneArmFunc, "BASHING");
TRIG.register("bashing_tcanna_gorilla_arm_break", "exact", [[Grasping your arm between its teeth, a silverback gorilla bites down hard, ripping through flesh and breaking bone.]], oneArmFunc, "BASHING");

-- 2 arms broken
TRIG.register("bashing_tcanna_cougar_arms_break", "exact", [[You raise both arms to try and block a lithe cougar's claws as it launches forward on two legs and tears through flesh to break the bones in your arms.]], twoArmFunc, "BASHING");

TRIG.register("bashing_creature_loki_damage", "exact", [[As the creature beneath Tiyen Esityi flexes its limbs and emits a strange, guttural resonance, emerald luminescence pours forth to scourge and corrupt all nearby.]], expectDamage, "BASHING");


-- Hissing loudly a dire, plagued rat leaps at you and latches upon your arm with its filthy teeth, with a fierce locking of its jaw you feel the bones in your arm begin to snap under the pressure.
--You have been afflicted with a hidden affliction!
--[NU - WARNING]: Untracked hidden affliction!
--[FirstAid]: Predicting firstaid_predict_arms

-- Voyria
-- A feral Hokkali soldier twitches violently, then disgorges a virulent stream of vomit at you!
-- The energy of your fiery aura reaches its limit and flares, purging off impurity.
-- You begin feeling slightly flushed.

-- Loki

-- Dozens of large quills spray forth from a spine-necked arrex's neck as it makes a low dive, your flesh stinging with toxins as several find purchase in your flesh.
-- The energy of your fiery aura reaches its limit and flares, purging off impurity.
-- You are confused as to the effects of the venom.
-- You have been afflicted with a hidden affliction!

-- Rearing up on its back pairs of legs, an armored, brown basilisk tears into you with four sets of venomous claws, ripping open large bloody wounds that burn horribly and begin blistering at the edges in mere moments.
-- You jerk your body to the side, lessening the blow.
-- Health Lost: 892, cutting, none
-- You are confused as to the effects of the venom.
-- You have been afflicted with a hidden affliction!

-- A hundred-strings jellyfish is carried into you by an errant current, its tentacles wracking your body with pain as they inject venom.
-- Health Lost: 1755, poison, none
-- The energy of your fiery aura reaches its limit and flares, purging off impurity.
-- Health Gain: 438
-- You are confused as to the effects of the venom.
-- You have been afflicted with a hidden affliction!


-- Dazed
-- With each revisited bite more savage than the last, the waters soon cloud profusely with your blood as you are left in a haze of pain and terror.
-- -> recoup


TRIG.register("bashing_damage_0", "exact", [[A horrifically deformed woodpecker opens its mouth, then belts a squawk that resounds painfully in your skull.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 0.");
TRIG.register("bashing_damage_1", "exact", [[A dull roar shimmers through the suddenly still air, exploding into agonizing actuality in a brutal crackling of brilliant sapphire flames that wreathe around your body, called forth by a cautious Xorani guard's will.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 1.");
TRIG.register("bashing_damage_2", "exact", [[A mutated kelki ravager leaps at you, knocking you to the ground as he claws and bites at your throat.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 2.");
TRIG.register("bashing_damage_3", "exact", [[As the creature beneath Tiyen Esityi's antennae begin to vibrate faster, a horrible screaming sense of pure agony and hatred washes over the area.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 3.");
TRIG.register("bashing_damage_4", "exact", [[With visible effort a victimised intruder lifts a distended arm and beats you with the dead weight.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 4.");
TRIG.register("bashing_damage_5", "exact", [[You exert your superior mental control and will your wounds to fully clot.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 5.");
TRIG.register("bashing_damage_6", "exact", [[Filling the air with sharp crackling sounds, brilliant sapphire light coils in twisted whorls around a wiry Xorani guard's staff, suddenly flaring out to strike at you like dozens of slender knives.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 6.");
TRIG.register("bashing_damage_7", "exact", [[Shimmering crimson light coils around a suspicious Xorani patrol's hands, which he directs in a sudden rush out at you. The power sinks beneath skin and into flesh, thousands of biting, ripping mouths tearing like long-starved piranha.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 7.");
TRIG.register("bashing_damage_8", "exact", [[Brilliant crimson light screams out from the staff of an arrogant Xorani master at arms, slamming painfully into you as the magic scours your skin.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 8.");
TRIG.register("bashing_damage_9", "exact", [[A deformed kelki ravener grabs your arm, channeling crackling bioelectrical energy into your body as your muscles lock up.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 9.");
TRIG.register("bashing_damage_10", "exact", [[A vile kelki prowler darts towards you, swiping her clawed hand across your torso.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 10.");
TRIG.register("bashing_damage_11", "exact", [[A suspicious Xorani patrol points his staff at you, and a crackling roar of orange-tipped crimson flame explodes outward, slamming painfully into you and charring your skin almost down to the bone.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 11.");
TRIG.register("bashing_damage_12", "exact", [[The enticement of the insubstantial whispers around you begins to pull at the fraying edges of your sanity.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 12.");
TRIG.register("bashing_damage_13", "exact", [[Fire coils in seething, iridescent crimson waves around a suspicious Xorani patrol's scaled hands, erupting abruptly and slamming into your form, burning your flesh painfully.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 13.");
TRIG.register("bashing_damage_16", "exact", [[A bolt of emerald energy, conjured by a mutated Nazetu intercessor's firm gesticulation, lances squarely through your chest.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 16.");
TRIG.register("bashing_damage_17", "exact", [[A gurgling bellow spilling forth from its gaping maw, a Nazetu corrupter brings a gigantic fist crashing down on you.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 17.");
TRIG.register("bashing_damage_18", "exact", [[Ghorahel, the kelki abomination wraps his tentacle around your throat, lifting you into the air and slamming you into the ground before releasing you.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 18.");
TRIG.register("bashing_damage_19", "exact", [[An arrogant Xorani master at arms gives a deep, rumbling laugh, raising his hands over his head. Seething crimson light screams across your skin, turning the air to incandescent flame.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 19.");
TRIG.register("bashing_damage_21", "exact", [[Iridescent sapphire light wreathes around a wiry Xorani guard's wooden staff, surging suddenly outward to envelop you, agonizing coils of seething power searing your skin.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 21.");
TRIG.register("bashing_damage_22", "exact", [[A mutated deer bashes one of its heads against you!]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 22.");
TRIG.register("bashing_damage_23", "exact", [[A coruscating swarm of pale blue light screams from the staff of a cautious Xorani guard, brutally cold tendrils of icy fire freezing your limbs.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 23.");
TRIG.register("bashing_damage_24", "exact", [[An ominous tension fills the air as a mutated Nazetu intercessor raises several of his hands and your vision is suddenly overcome with a blinding emerald light.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 24.");
TRIG.register("bashing_damage_25", "exact",
    [[Several barbed appendages burst forth from a ball of chitinous legs and rake across your skin.]], expectDamage,
    "BASHING", "Autocapture bashing trigger for damage: 25.");
TRIG.register("bashing_damage_27", "exact", [[As his chanted words hover menacingly in the air, dark violet power coils around a merciless Xorani warrior's hands, which he directs in a shadow-wreathed blast to painfully slam into you.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 27.");
TRIG.register("bashing_damage_28", "exact", [[A mutated Nazetu intercessor assumes a hostile mudra, a wicked gleam in his eyes, and powerful waves of nausea slam into you.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 28.");
TRIG.register("bashing_damage_29", "exact", [[Scuttling forward in an unnerving display, a ball of chitinous legs careens its mass into you, bowling you over.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 29.");
TRIG.register("bashing_damage_30", "exact", [[A Nazetu corrupter reaches out with a skeletal hand and encloses your arm in an iron grip, easily crushing bone and nearly ripping the appendage from its socket.]], oneArmFunc, "BASHING", "Autocapture bashing trigger for damage: 30.");
TRIG.register("bashing_damage_31", "exact", [[A gibbering kelki reaver lunges at you, claws raking your flesh as he knocks you to the ground.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 31.");
TRIG.register("bashing_damage_32", "exact", [[A merciless Xorani warrior twirls his staff in a startlingly graceful move, a crackling rush of violet power pouring forth to slam into you, crackling through your body painfully.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 32.");
TRIG.register("bashing_damage_33", "exact", [[A mutated Nazetu intercessor snarls angrily at you and moves in for the kill.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 33.");
TRIG.register("bashing_damage_34", "exact", [[A supply officer pulls his enormous arm back and drives his fist into your face, the crunch and squelch of meat and bone audible.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 34.");
TRIG.register("bashing_damage_35", "exact", [[Ghorahel, the kelki abomination slams his tentacle into the ground as sparks of bioelectricity cascade out from his body and into his surroundings.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 35.");
TRIG.register("bashing_damage_36", "exact", [[A sharp limb lashes out from a ball of chitinous legs and pierces straight through your chest.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 36.");
TRIG.register("bashing_damage_37", "exact", [[You are suddenly snapped out of your stupor as a monstrous coelacanth tears out a portion of your flesh with its razor sharp teeth.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 37.");
TRIG.register("bashing_damage_38", "exact", [[A mutated kelki ravager darts towards you, swiping his clawed hand across your torso.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 38.");
TRIG.register("bashing_damage_39", "exact", [[The creature beneath Tiyen Esityi lashes out with its smaller legs, each one tipped with a claw sharper than the finest razor, its speed inescapable as they impale you.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 39.");
TRIG.register("bashing_damage_40", "exact", [[You are confused as to the effects of the venom.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 40.");
TRIG.register("bashing_damage_41", "exact", [[A hideous aelthotan snarls angrily at you and moves in for the kill.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 41.");
TRIG.register("bashing_damage_42", "exact", [[Snarling, a vile kelki prowler rakes her claws across your body, spilling blood all around.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 42.");
TRIG.register("bashing_damage_43", "exact", [[A deformed kelki ravener shrieks and rakes her claws across your body, carving deep, bleeding wounds into your flesh.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 43.");
TRIG.register("bashing_damage_44", "exact", [[The echoes of her chant reverberating through the air, a cautious Xorani guard points her staff at you, pale blue light screaming out to pierce you like shards of brutal ice.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 44.");
TRIG.register("bashing_damage_45", "exact", [[As the insubstantial whispers sink into your subconscious, you feel somehow diminished.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 45.");
TRIG.register("bashing_damage_46", "exact", [[A mutated deer rears up and slams its hooves into you!]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 46.");
TRIG.register("bashing_damage_47", "exact", [[queue anabiotic eat anabiotic]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 47.");
TRIG.register("bashing_damage_48", "exact", [[Ghorahel, the kelki abomination's tentacle darts out, seizing one of your limbs and pulling hard to yank you close enough to tear into your flesh with tooth and claw.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 48.");
TRIG.register("bashing_damage_49", "exact", [[Flames lick out at a monstrous coelacanth from your body and scorch its flesh.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 49.");
TRIG.register("bashing_damage_50", "exact", [[A merciless Xorani warrior calmly points his staff at you, and a pulsating blast of violet power pours forth, brutally scouring your skin.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 50.");
TRIG.register("bashing_damage_51", "exact", [[Ghorahel, the kelki abomination slams the clawed tip of his tentacle into your face as he rakes his knife-like claws across your flesh.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 51.");
TRIG.register("bashing_damage_52", "exact", [[A mutated kelki ravager wraps his tentacle around your throat, squeezing until your vision fades.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 52.");
TRIG.register("bashing_damage_53", "exact", [[A deformed kelki ravener darts towards you, swiping her clawed hand across your torso.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 53.");
TRIG.register("bashing_damage_54", "exact", [[A vile kelki prowler shrieks and rakes her claws across your body, carving deep, bleeding wounds into your flesh.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 54.");
TRIG.register("bashing_damage_55", "exact", [[Your health drains away as your impaled body shudders due to shock.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 55.");
TRIG.register("bashing_damage_56", "exact", [[Pulling a metal instrument from its pulpy flesh, a victimised intruder lurches forward and stabs you with it.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 56.");
TRIG.register("bashing_damage_57", "exact", [[You are impaled and must writhe off before you may do that.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 57.");
TRIG.register("bashing_damage_58", "exact", [[A deformed kelki ravener lunges at you, claws raking your flesh as she knocks you to the ground.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 58.");
TRIG.register("bashing_damage_59", "exact", [[A mutated kelki ravager slams his tentacle into your body with tremendous force, eliciting a resounding crunch of broken bone and covering you with a disgusting layer of slime.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 59.");
TRIG.register("bashing_damage_60", "exact", [[A wiry Xorani guard spins his staff in a graceful twist, and brilliant sapphire light screams outward, brutally searing through your body.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 60.");
TRIG.register("bashing_damage_61", "exact", [[A vile kelki prowler slams her tail into your leg, knocking you to the ground with a sickening crunch.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 61.");
TRIG.register("bashing_damage_63", "exact", [[Your mind and body quakes under your accumulated psionic energy.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 63.");
TRIG.register("bashing_damage_64", "exact", [[Caelakan, an arrogant prince chants a somewhat garbled string of words, eyes wide with terror. Still, a searing wave of white-tipped emerald flames obediently shimmers forth, which he directs straight for you.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 64.");
TRIG.register("bashing_damage_65", "exact", [[A scathing blast of crimson flame shoots out from the hands of an arrogant Xorani master at arms, the agonizing blaze wreathing your limbs.]], expectDamage, "BASHING", "Autocapture bashing trigger for damage: 65.");