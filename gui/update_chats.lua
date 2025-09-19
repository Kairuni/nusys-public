function NU.GUI.functions.onGMCPComm()
    local chat = "other";
    if string.starts(gmcp.Comm.Channel.Text.channel, "says") then
        chat = "says"
    elseif string.starts(gmcp.Comm.Channel.Text.channel, "ct") then
        chat = "city"
    elseif string.starts(gmcp.Comm.Channel.Text.channel, "gt") then
        chat = "guild"
    elseif string.starts(gmcp.Comm.Channel.Text.channel, "cnt") then
        chat = "city"
    elseif string.starts(gmcp.Comm.Channel.Text.channel, "ot") then
        chat = "order"
    elseif string.starts(gmcp.Comm.Channel.Text.channel, "web") then
        chat = "web"
    elseif string.starts(gmcp.Comm.Channel.Text.channel, "clt") then
        chat = "clan"
    elseif string.starts(gmcp.Comm.Channel.Text.channel, "tell") then
        chat = "tells"
    elseif string.starts(gmcp.Comm.Channel.Text.channel, "emotes") then
        chat = "says"
    end

    local replaced = ansi2decho(gmcp.Comm.Channel.Text.text);
    NU.DECHO("Chat: " .. chat .. "Chat attempted to update with " .. replaced, 0);
    decho(chat .. "Chat", replaced .."\n");
    decho("allChat", replaced .."\n");
end

GMCP.register("update_chats", "gmcp.Comm.Channel.Text", NU.GUI.functions.onGMCPComm)