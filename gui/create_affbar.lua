local leftSize = NU.GUI.leftSize;
local rightSize = NU.GUI.rightSize;
local topSize = NU.GUI.topSize;
local botSize = NU.GUI.bottomSize;

setBorderLeft(leftSize);

local leftContainer = Geyser.Container:new({
    name = "leftContainer", x = 0, y = topSize + 10,
    width = leftSize, height = -10,
});

NU.GUI.misc.affLabel = Geyser.Label:new({
     name = "affLabel", x = 0, y = 0,
     width = "100%", height = "2.5%",
     color = "dark_slate_gray", fgColor = "white",
     message = [[<center>My Affs</center>]],
}, leftContainer);

local affContainer = Geyser.Container:new({
    name = "affContainer", x = 0, y = "2.5%",
    width = "100%", height = "35%",
}, leftContainer);

NU.GUI.afflictions["affs"] = Geyser.MiniConsole:new({
     name = "affs", x = 0, y = 0,
     width = "100%", height = "100%",
}, affContainer);
NU.GUI.afflictions["affs"]:setColor("black");
NU.GUI.afflictions["affs"]:enableAutoWrap();

NU.GUI.misc.headState = Geyser.Label:new({
     name = "headState", x = "40%", y = "35%",
     width = "20%", height = "5%",
     color = "green", fgColor = "black",
    message = [[h]];
}, leftContainer);

NU.GUI.misc.torsoState = Geyser.Label:new({
     name = "torsoState", x = "40%", y = "40%",
     width = "20%", height = "5%",
     color = "green", fgColor = "black",
    message = [[t]];
}, leftContainer);

NU.GUI.misc.larmState = Geyser.Label:new({
     name = "larmState", x = "10%", y = "37.5%",
     width = "20%", height = "5%",
     color = "green", fgColor = "black",
    message = [[la]];
}, leftContainer);

NU.GUI.misc.llegState = Geyser.Label:new({
     name = "llegState", x = "10%", y = "42.5%",
     width = "20%", height = "5%",
     color = "green", fgColor = "black",
    message = [[ll]];
}, leftContainer);

NU.GUI.misc.rarmState = Geyser.Label:new({
     name = "rarmState", x = "-30%", y = "37.5%",
     width = "20%", height = "5%",
     color = "green", fgColor = "black",
    message = [[ra]];
}, leftContainer);

NU.GUI.misc.rlegState = Geyser.Label:new({
     name = "rlegState", x = "-30%", y = "42.5%",
     width = "20%", height = "5%",
     color = "green", fgColor = "black",
    message = [[rl]];
}, leftContainer);

NU.GUI.misc.personalState = Geyser.Label:new({
     name = "personalState", x = 0, y = "47.5%",
     width = "100%", height = "2.5%",
     color = "dark_slate_gray", fgColor = "white",
}, leftContainer);


NU.GUI.misc.tAffLabel = Geyser.Label:new({
     name = "tAffLabel", x = 0, y = "50%",
     width = "100%", height = "2.5%",
     color = "dark_slate_gray", fgColor = "white",
     message = [[<center>Target Affs</center>]],
}, leftContainer);

local tAffContainer = Geyser.Container:new({
    name = "tAffContainer", x = 0, y = "52.5%",
    width = "100%", height = "35%",
}, leftContainer);

NU.GUI.afflictions["tAffs"] = Geyser.MiniConsole:new({
     name = "tAffs", x = 0, y = 0,
     width = "100%", height = "100%",
}, tAffContainer);
NU.GUI.afflictions["tAffs"]:setColor("black");
NU.GUI.afflictions["tAffs"]:enableAutoWrap();

NU.GUI.misc.targetState = Geyser.Label:new({
     name = "targetState", x = 0, y = "97.5%",
     width = "100%", height = "2.5%",
     color = "dark_slate_gray", fgColor = "white",
}, leftContainer);

NU.GUI.misc.theadState = Geyser.Label:new({
     name = "theadState", x = "40%", y = "85%",
     width = "20%", height = "5%",
     color = "green", fgColor = "black",
    message = [[h]];
}, leftContainer);

NU.GUI.misc.ttorsoState = Geyser.Label:new({
     name = "ttorsoState", x = "40%", y = "90%",
     width = "20%", height = "5%",
     color = "green", fgColor = "black",
    message = [[t]];
}, leftContainer);

NU.GUI.misc.tlarmState = Geyser.Label:new({
     name = "tlarmState", x = "10%", y = "87.5%",
     width = "20%", height = "5%",
     color = "green", fgColor = "black",
    message = [[la]];
}, leftContainer);

NU.GUI.misc.tllegState = Geyser.Label:new({
     name = "tllegState", x = "10%", y = "92.5%",
     width = "20%", height = "5%",
     color = "green", fgColor = "black",
    message = [[ll]];
}, leftContainer);

NU.GUI.misc.trarmState = Geyser.Label:new({
     name = "trarmState", x = "-30%", y = "87.5%",
     width = "20%", height = "5%",
     color = "green", fgColor = "black",
    message = [[ra]];
}, leftContainer);

NU.GUI.misc.trlegState = Geyser.Label:new({
     name = "trlegState", x = "-30%", y = "92.5%",
     width = "20%", height = "5%",
     color = "green", fgColor = "black",
    message = [[rl]];
}, leftContainer);

function NU.GUI.functions.buildAffList(mini, afftable)
    mini:clear();
    local first = true;
    for i,v in ipairs(UTIL.afflictionDrawOrder) do
        if (afftable[v]) then
            mini:cecho(first and "" or "<reset>, ");
            first = false;
            mini:cecho(UTIL.affLongToShort[v]);
        end
    end
end


