NU.config = {
    separator = "##",
    gags = {
        que = false,
        cmsg_formatter = true,
        send = false,
        prompt = true,
        cure_formatter = true,
    },
    curing = {
        defenses = false,

        unknown = true,
        wattle = true,
    },
    heals = {
        sip_hp = 0.82,
        sip_mp = 0.82,
        anabiotic_hp = 0.72,
        anabiotic_mp = 0.3,
        pulse_hp = 0.3,
        pulse_mp = 0.2,
    },
    preRestore = {
        head = 7,
        torso = 3,
        left_arm = 13,
        right_arm = 18,
        left_leg = 5,
        right_leg = 3
    },
    goggles = true,
    pipes = {
        reishi = "87018",
        yarrow = "87074",
        willow = "86996",
    },

    mount = "Eliant",

    autoSacrifice = true,
}

function NU.gag(gag)
    -- We'll do all of these at once, but for now we want the gags to work.
    if (NU.config.gags[gag]) then
        NU.LOG_DEBUG("[GAGGED]: " .. copy2html());
        moveCursorEnd();
        deleteLine();
        return true;
    elseif (NU.config.gags[gag] == nil) then
        NU.DECHO("No gag config set up for " .. gag .. " - temporarily adding.", 10);
        NU.config.gags[gag] = true;
    end
    return false;
end