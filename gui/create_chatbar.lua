local leftSize = NU.GUI.leftSize;
local rightSize = NU.GUI.rightSize;
local topSize = NU.GUI.topSize;
local botSize = NU.GUI.bottomSize;

setBorderTop(topSize);

NU.GUI.topContainer = Geyser.Container:new({
    name = "topContainer", x = 0, y = 0,
    width = "100%", height = topSize,
});

local chatBarContainer = Geyser.Container:new({
     name = "chatBarContainer", x = 0, y = 0,
     width = "100%", height = "10%"
}, NU.GUI.topContainer);

local chatContainer = Geyser.Container:new({
     name = "chatContainer", x = 0, y = "15%",
     width = "100%", height = "90%",
}, NU.GUI.topContainer);

function NU.GUI.functions.hideAllChats()
     for k,v in pairs(NU.GUI.chats) do
            v:hide();
     end
end

function NU.GUI.functions.resetAllChatButtons()
    for k,v in pairs(NU.GUI.chatButtons) do
            v:setColor("dark_slate_gray");
            v:setFgColor("white");
    end
end

local function buildChat(cname, num)
    local chat = Geyser.MiniConsole:new({
        name = cname .. "Chat", x = 0, y = 0,
        width = "100%", height = "100%",
    }, chatContainer);
    chat:setColor("black");
    chat:setFontSize(NU.GUI.fontSize);
    chat:enableAutoWrap();
    chat:enableScrollBar();

    NU.GUI.chats[cname .. "Chat"] = chat;

    local spot = -10 + 10 * num;

    local strLoc = tostring(spot);
    strLoc = strLoc .. "%";

    local chatButton = Geyser.Label:new({
             name = cname.."ChatButton", x = strLoc, y = 0,
             width = "10%", height = "100%",
             color = "dark_slate_gray", fgColor = "white",
             message = [[<center>]] .. cname:gsub("^%l", string.upper) .. [[</center>]],
    }, chatBarContainer);

    NU.GUI.chatButtons[cname.."ChatButton"] = chatButton;

    NU.GUI.functions[cname .. "EnableChat"] = function()
        NU.GUI.functions.hideAllChats();
        NU.GUI.functions.resetAllChatButtons();
        chatButton:setColor("green");
        chatButton:setFgColor("black");
        chat:show();
    end

    chatButton:setClickCallback("NU.GUI.functions." .. cname .. "EnableChat");
end

buildChat("all",1);
buildChat("web",2);
buildChat("city",3);
buildChat("guild",4);
buildChat("clan",5);
buildChat("sect",6);
buildChat("order",7);
buildChat("tells",8);
buildChat("other",9);
buildChat("says",10);

function NU.GUI.functions.appendChat(chat)
    selectCurrentLine();
    copy();
    appendBuffer("allChat");
    appendBuffer(chat);
    NU.setPFlag("chat_already_appended", true);
end

NU.GUI.functions.hideAllChats();
NU.GUI.functions.allEnableChat();
