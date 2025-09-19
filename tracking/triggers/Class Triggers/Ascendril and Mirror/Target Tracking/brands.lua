TRIG.register("emberbrand_tick", "regex", [[^(\w+) spontaneously bursts into flames\.$]], function() TRACK.taff(matches[2], "ablaze"); end, "ASCENDRIL_OFFENSE_TRACKING");

                                         -- ^The Brand of Ember seared upon (\w+) glows, rippling outward as swelting heat eminates from it.
TRIG.register("emberbrand_tick", "regex", [[^The Brand of Ember seared upon (\w+) glows\, fire rippling outward to ignite along (\w+) body\.$]], function() TRACK.taff(matches[2], "ablaze"); end, "ASCENDRIL_OFFENSE_TRACKING");

TRIG.register("emberbrand_cure", "regex", [[^The Emberbrand fades away from (\w+)\'s forehead\.$]], function() TRACK.nameCure(matches[2], "emberbrand"); end, "ASCENDRIL_OFFENSE_TRACKING");
-- ref    nu.setFlag(target.name .. "_emberbrand", true, 45, function() TRACK.cure(target, "emberbrand");

local function onThunderbrand()
    local ttable = TRACK.get(matches[2]);
    TRACK.aff(ttable, "thunderbrand");
    NU.setFlag("thunderbrand", true, 45, function() TRACK.cure(ttable, "thunderbrand"); end);
end

TRIG.register("thunderbrand", "regex", [[^The brooding, relentless pressure leaves an indent upon (\w+)\'s brow, sinking into the Brand of Thunder\.$]], onThunderbrand, "ASCENDRIL_OFFENSE_TRACKING");

local function frostbrandTick()
    -- I'm not sure this is necessary - verify what looking at someone getting ice_encased from frostbrand looks like.
    local ttable = TRACK.get(matches[2]);
    local nextAff = AB.freezeStack(ttable, 1);
    if (nextAff[1]) then
        TRACK.aff(ttable, nextAff[1]);
    end

    ttable.affs.frostbrand = true;
    ttable.affs.direfrost = false;
end

TRIG.register("frostbrand_tick", "regex", [[^The Brand of the Frost pulses with blue\-black light\, (\w+)\'s face contorting against the excruciating\, bone\-deep ache of cold\.$]], frostbrandTick, "ASCENDRIL_OFFENSE_TRACKING");
TRIG.register("frostbrand_cure", "regex", [[^The Frostbrand fades away from (\w+)\'s body\.$]], function() TRACK.nameCure(matches[2], "frostbrand"); end, "ASCENDRIL_OFFENSE_TRACKING");
TRIG.register("direfrost_to_frostbrand", "regex", [[^The gleaming fractals of direfrost unite upon (\w+)\'s body\, solidifying into the biting Brand of the Frost\.$]], function() TRACK.nameCure(matches[2], "direfrost"); TRACK.taff(matches[2], "frostbrand"); end, "ASCENDRIL_OFFENSE_TRACKING");
