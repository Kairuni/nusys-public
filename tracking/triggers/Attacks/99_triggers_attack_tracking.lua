
-- Combat Messages and attacks missing

TRIG.register("last_envenom", "regex", [[^You rub some (\w+) on]], function() NU.setFlag("last_envenom", matches[2], 3) end);

-- ANYTHING THAT STOPS ATTACKS MUST BE DECLARED AND LOADED BEFORE THIS TRIGGER
-- ANYTHING THAT STOPS ATTACKS MUST BE DECLARED AND LOADED BEFORE THIS TRIGGER
-- ANYTHING THAT STOPS ATTACKS MUST BE DECLARED AND LOADED BEFORE THIS TRIGGER
-- ANYTHING THAT STOPS ATTACKS MUST BE DECLARED AND LOADED BEFORE THIS TRIGGER
-- ANYTHING THAT STOPS ATTACKS MUST BE DECLARED AND LOADED BEFORE THIS TRIGGER
TRIG.register("capture_flavor", "regex", [[.]], TRACK.applyAttack);
TRIG.register("apply_attack", "regex", [[.]], TRACK.applyAttack);
TRIG.disable(TRIGS.apply_attack);

local function disableOtherCmsgsThisLine()
    TRIG.disable(TRIGS.cmsg_basic_target);
    TRIG.disable(TRIGS.cmsg_with_limb);
    TRIG.disable(TRIGS.cmsg_with_target_and_paren);
    TRIG.disable(TRIGS.cmsg_with_paren);
    TRIG.disable(TRIGS.cmsg_with_no_target);
    TRIG.enable(TRIGS.cmsg_reenabler);
end

local function cmsgCap()
    if (PFLAGS.illusion) then return; end
    TRACK.cmsg(matches.self, matches.tree, matches.ability, matches.other, matches.target, matches.limb);
    disableOtherCmsgsThisLine();
end


local function enableCmsgs()
    TRIG.enable(TRIGS.cmsg_basic_target);
    TRIG.enable(TRIGS.cmsg_with_limb);
    TRIG.enable(TRIGS.cmsg_with_target_and_paren);
    TRIG.enable(TRIGS.cmsg_with_paren);
    TRIG.enable(TRIGS.cmsg_with_no_target);
    TRIG.disable(TRIGS.cmsg_reenabler);
end

TRIG.register("cmsg_reenabler", "regex", ".", enableCmsgs);
TRIG.register("cmsg_basic_target", "regex", [[^(?<self>\w+) uses? (?<tree>\w+) (?<ability>[A-Za-z\-\s]+) on (?<target>.+)\.$]], cmsgCap);
TRIG.register("cmsg_with_limb", "regex", [[^(?<self>\w+) uses? (?<tree>\w+) (?<ability>[A-Za-z\-\s]+) \((?<limb>left arm|right arm|left leg|right leg|head|torso)\) on (?<target>.+)\.$]], cmsgCap);
TRIG.register("cmsg_with_target_and_paren", "regex", [[^(?<self>\w+) uses? (?<tree>\w+) (?<ability>[A-Za-z\-\s]+) \((?<other>.*)\) on (?<target>.+)\.$]], cmsgCap);
TRIG.register("cmsg_with_paren", "regex", [[^(?<self>\w+) uses? (?<tree>\w+) (?<ability>[A-Za-z\-\s]+) \((?<other>.*)\)\.$]], cmsgCap);
TRIG.register("cmsg_with_no_target", "regex", [[^(?<self>\w+) uses? (?<tree>\w+) (?<ability>[A-Za-z\-\s]+)\.$]], cmsgCap);

TRIG.register("some_discovery", "regex", [[^You have discovered ([A-Za-z\-\_]+)\.$]], function() TRACK.discover(matches[2]); end);
TRIG.register("some_afflict", "regex", [[^You are afflicted with ([A-Za-z\-\_]+)\.$]],
    function() TRACK.affmsg(matches[2]); end);
TRIG.register("some_hidden", "exact", [[You have been afflicted with a hidden affliction!]], function() TRACK.onHidden(); end);

--  TRACK.cure(TRACK.getSelf(), matches[2]); registerCure(matches[2]); NU.setPFlag("did_cure", true);
TRIG.register("aff_transformation", "regex", [[^Your (.+) has transformed into (.+)\.$]],
    function()
        TRACK.cure(TRACK.getSelf(), matches[2]);
        NU.setPFlag("did_cure", true);
        TRACK.affmsg(matches[3]);
    end);


-- Giant weapon attack list:
-- ^\w+ uses? Corpus Gash on (\w+)\.$ -- TODO: Combat messages.
-- ^\w+ uses? Corpus Gash \(light\) on (\w+)\.$
-- ^The \w+ connects, sending a tremendous shock through (\w+)\.$
-- ^Swinging .+ in a powerful arc\, \w+ tears into (\w+)\.$
-- ^\w+ scores (\w+) with a wild blow from .+\.$
-- ^With a brutal swipe of .+\, \w+ rips up (\w+)\.$
-- ^Slicing downward with .+\, \w+ carves (\w+) open\.$
-- ^Thrusting forward, \w+ drives .+ into (\w+)\.$
-- ^\w+ throws \w+ weight behind .+\, driving it into (\w+)\.$
-- ^\w+ punctures? (\w+) with
-- ^\w+ hacks into (\w+) ruthlessly with .+\.$
-- ^Cutting forcefully, \w+ rends (\w+) with .+\.$
-- ^You use Savagery Spinning on (\w+)\.$
-- ^With an arcing blow, you swing at (\w+) with .+\.$
-- ^You cut open (\w+) with an overhead slash from .+\.$
-- ^Charging forward, you hew into \w+ with .+\.$
-- ^With a violent upward swing, you mangle (\w+) with .+\.$
-- moves in a wicked blur as you bury it in (\w+)\.$
-- ^Whirling .+ around your body, you chop fiercely into (\w+)\.$
-- ^With a diagonal slash, you cleave into (\w+) with .+\.$
-- ^Leaping in, you rip (\w+) open with .+\.$
-- ^You sweep .+ before you, brutally carving into (\w+)\.$
-- ^You nimbly cut into (\w+) with .+\.$
-- ^You lacerate (\w+) with a swing of .+\.$
-- ^You gash open (\w+) with a flick of .+\.$
-- ^\w+ uses? Tenacity Slaughter on (\w+)\.$
-- ^You use Savagery Razehack on (\w+)\.$
-- ^\w+ uses? Savagery Spinning on (\w+)\.$
-- ^\w+ uses? Savagery Carve on (\w+)\.$
-- ^You use Savagery Carve on (\w+)\.$
-- ^\w+ drives .+ into (\w+) with a vicious stab\.$
-- ^Lunging in, \w+ sticks (\w+) with .+\.$
-- ^As \w+ pierces through (\w+)\'s rebounding, \w+ sends the tip of .+ to scourge \w+ flesh\.$
-- ^\w+ jabs (\w+) with .+\.$
-- ^You score (\w+) with a wild blow from .+\.$
-- ^\w+ uses? Corpus Gash \(light\) on (\w+).
-- Bringing about .+, \w+ slashes into (\w+)\.$
-- ^\w+ steps in quickly, wounding (\w+) with .+\.$
-- ^You strike out at (\w+), slashing \w+ with .+\.$
-- ^Cutting with precision, you strike (\w+) with .+\.$
-- ^Bringing about .+, you slash into (\w+)\.$
-- ^Stepping in quickly, you wound (\w+) with a .+\.$
-- ^With an arcing blow, \w+ swing at (\w+) with .+\.$
-- ^With an arcing blow, \w+ swings at (\w+) with .+\.$
-- ^Charging forward, \w+ hews into (\w+) with .+\.$
-- ^\w+ nimbly cuts into (\w+) with .+\.$
-- ^\w+ lacerates (\w+) with a swing of .+\.$
-- ^\w+ gashes open (\w+) with a flick of .+\.$