-- local ele = AB.Elemancy;
-- local thaum = AB.Thaumaturgy;

-- function ACTIONS.classCures.ascendril(act, willCure, randomCureCount)
--     local count = NU.curing.numberRandomCures(TRACK.getSelf(), willCure) - randomCureCount;
--     local st = TRACK.getSelf();

--     local curingParesis = (not st.affs.paresis and not st.affs.paralysis) or willCure.paresis or willCure.paralysis;

--     -- TODO: Add other danger conditions to these.
--     -- TODO: Make it so these won't ruin kills by inopportune uses.
--     if (((count > 1 and curingParesis) -- case for no paresis for full effect.
--             or
--             (count > 1 and (st.affs.paresis or st.affs.paralysis) and (st.affs.anorexia or st.affs.gorged) and (st.affs.slickness or st.affs.asthma)))
--         and
--             thaum.Restore.meetsPreReqs(st) -- case for partial lock
--         ) then

--         act.eqbalConsuming:put({syntax = thaum.Restore.syntax[NU.getClass()], bal = thaum.Restore.balance(st).self.bal, attack = true}, 2);
--     end

--     local lockScare = (st.affs.anorexia or st.affs.gorged or not curingParesis) and (st.affs.slickness or st.affs.asthma);
--     local bashScare = (st.vitals.hp / st.vitals.maxhp) < .5;
--     local limbScare = (st.affs.left_arm_broken or st.affs.right_arm_broken or st.affs.left_leg_broken or st.affs.right_leg_broken);

--     if ((lockScare or bashScare or limbScare) and thaum.Shift.meetsPreReqs(st) and not AUTOBASH.active) then
--         act.eqbalConsuming:put({syntax = thaum.Shift.syntax[NU.getClass()], bal = thaum.Shift.balance(st).self.bal, attack = true}, 1);
--     end
-- end