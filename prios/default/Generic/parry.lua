function PRIOS.default.generic.parry(act)
    local limbs = {"left leg", "right leg", "left arm", "right arm", "torso", "head"};
    if (not FLAGS.parry) then
        NU.setFlag("parry", limbs[math.random(#limbs)], 5);
    end
end