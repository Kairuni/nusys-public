local leftSize = NU.GUI.leftSize;
local rightSize = NU.GUI.rightSize;
local botSize = NU.GUI.bottomSize;

setBorderBottom(0);
-- setBorderBottom(botSize);

-- local bottomContainer = Geyser.Container:new({
--     name = "bottomContainer", x = leftSize, y = -botSize-3,
--     width = "100%-" .. tostring(rightSize + leftSize) .. "px", height = botSize,
-- });

-- local stylesheet = Geyser.StyleSheet:new([[
--     font: "Bitstream Vera Sans Mono";
--     font-size: 11pt;
-- ]])

-- NU.GUI.misc.promptMiniConsole = Geyser.MiniConsole:new({
--     name = "promptMiniConsole", x = 0, y = 0,
--     width = "100%", height = "100%",
-- }, bottomContainer);
-- NU.GUI.misc.promptMiniConsole:setColor("black");
-- NU.GUI.misc.promptMiniConsole:setFontSize(NU.GUI.fontSize);
-- setWindowWrap("promptMiniConsole", 100);
--setWindowWrap("affs", 200);