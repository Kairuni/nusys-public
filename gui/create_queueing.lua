--[[YAAS.GUIMisc.queueContainer = Geyser.Container:new({
    name = "queueContainer", x = 0, y = "-25%",
    width = "100%", height = "25%",
}, rightContainer);

YAAS.GUIMisc.queues = Geyser.MiniConsole:new({
     name = "queues", x = 0, y = 0,
     width = "100%", height = "100%",
}, YAAS.GUIMisc.queueContainer);
YAAS.GUIMisc.queues:setColor("black");
YAAS.GUIMisc.queues:setFontSize(9);]]