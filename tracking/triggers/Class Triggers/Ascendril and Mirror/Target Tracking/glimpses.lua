local affMap = {
    air = {"vertigo", "muddled"},
    water = {"hypothermia", "shivering", "frigid", "frozen"},
    fire = {"ablaze"},
}

local function glimpseHit()
    local map = affMap[PFLAGS.glimpse];
    local ttable = TRACK.get(matches[2]);
    for _,v in ipairs(map) do
        if (not ttable.affs[v]) then
            TRACK.aff(ttable, v);
            break;
        end
    end
end


TRIG.register("water_glimpse", "exact", [[Rhythmic and unyielding, the violent waves crash and wrench at the victims caught in their undertow.]], function() NU.setPFlag("glimpse", "water"); NU.setFlag("next_glimpse_hit", NU.time() + 7, 7); creplaceLine("<steel_blue>WATER GLIMPSE"); end, "ASCENDRIL_OFFENSE_TRACKING");
TRIG.register("air_glimpse", "exact", [[Lightning flashes and crackles through the air, tearing through the winds that assault those trapped in the storm.]], function() NU.setPFlag("glimpse", "air"); NU.setFlag("next_glimpse_hit", NU.time() + 7, 7); creplaceLine("<khaki>AIR GLIMPSE"); end, "ASCENDRIL_OFFENSE_TRACKING");
TRIG.register("fire_glimpse", "exact", [[Harsh winds whip burning debris and choking ash into a frenzy as the inferno rages on.]], function() NU.setPFlag("glimpse", "fire"); NU.setFlag("next_glimpse_hit", NU.time() + 7, 7); creplaceLine("<firebrick>FIRE GLIMPSE");    end, "ASCENDRIL_OFFENSE_TRACKING");

TRIG.register("glimpse_effect", "regex", [[^Your glimpse affects (\w+)\.$]], glimpseHit);
TRIG.register("glimpse_end", "regex", [[^Your glimpse of (Air|Water|Fire) has ended\.$]], function() NU.clearFlag("glimpse"); NU.clearFlag("next_glimpse_hit"); end, "ASCENDRIL_OFFENSE_TRACKING");
TRIG.register("glimpse_inactive", "exact", [[You do not have a glimpse active in this room.]], function() NU.clearFlag("glimpse"); NU.clearFlag("next_glimpse_hit"); end, "ASCENDRIL_OFFENSE_TRACKING");
