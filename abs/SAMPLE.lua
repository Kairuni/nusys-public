-- Note - these would normally be in 'abilities'.
local Test_Skill = {};
Test_Skill.TestAbility = {
    -- Returns {visible affs}, {possible hidden affs}, expected hidden count
    getTargetAffs = function(attacker, target, data)
        -- attacker is a 'tracked' table, same with target.
        -- limb comes from cmsg, data comes from cmsg.
        if (target.affs["stupidity"]) then
            return {"paresis", "hypothermia"}, {"dread"};
        else
            return {"blackout"};
        end
    end,

    -- Returns {visible limb damage}, {hidden limb damage}
    -- For Tekura specifically, we might need to do something fancy
    -- due to Turmoil
    -- If we know the limb, we can pass in the limb - which we will if we're the attacker
    -- However, if we're the target, this is potentially hidden and fuckkkkkkkkkkkk that.
    getLimbEffects = function(attacker, target, data)
        return {["left arm"] = 3, ["right_arm"] = 3, no_break = true};
    end,

    -- Returns end/wp cost.
    getCost = function()
        return 0, 0
    end,

    -- Returns damage, mana damage, self damage, self mana damage.
    getDamage = function(attacker, target, data)
        return 0, 0, 0, 0;
    end,

    -- Returns attacker balance knock, defender balance knock
    -- Append _noreduce to bal name if not reduacble.
    balance = function(attacker, target, weapons)
        return {"equilibrium", 2.56}, {"balance", 1};
    end,

    -- Effects that trigger after we know the attack landed.
    postEffects = function(attacker, target)

    end,

    meetsPreReqs = function(attacker, target, weapons)
        return true;
    end,
};