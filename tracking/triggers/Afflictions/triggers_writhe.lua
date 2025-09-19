TRIG.register("start_writhe_tfix", "exact", [[You begin trying to wrest your mind free of that which has transfixed it.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_roped", "exact", [[You begin to work at the knots in the ropes around your wrists and ankles.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_jawlock", "exact", [[You begin to twist your arm violently, trying to release your armpit from the vicious jaws.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_embrace", "exact", [[You exert your will and attempt to writhe free of the vampire's embrace.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_impale1", "exact", [[You begin to writhe furiously to escape the blade that has impaled you.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_impale2", "exact", [[You begin to writhe furiously to escape the sword-like snout that has impaled you.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_vampire", "exact", [[You concentrate intently, desperately seeking to throw off the unnatural attraction from your mind.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_teradrim", "exact", [[You begin to struggle free from your quicksand prison.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_jawlock2", "exact", [[You begin to shake your leg violently, trying to release it from the vicious jaws.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_vines", "exact", [[You begin to untangle yourself from the forest vines.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_webbed", "exact", [[You begin to wrestle the webs clinging to your limbs.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_gunk", "exact", [[You begin trying to free yourself of the sticky gunk.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_impale3", "exact", [[You begin to writhe furiously to escape your deathly impalement.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_entangle", "exact", [[You begin to struggle free of your entanglement.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_impale4", "start", [[You begin to writhe furiously to escape your impalement from]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_grapple", "start", [[You begin trying to writhe out of the grapple]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);
TRIG.register("start_writhe_stasis", "exact", [[You call upon your will to cleanse your mind of its stasis.]], function() if (not PFLAGS.illusion) then NU.setFlag("writhing", true, 10); end end);

TRIG.register("writhe_failed", "exact", [[You attempt to writhe helplessly, achieving nothing at all.]],
function()
    if (not PFLAGS.illusion) then
        for aff,speed in pairs(CURES.writhe) do
            TRACK.cure(TRACK.getSelf(), aff);
        end
    end
end);