GMCP = GMCP or {};
GMCP.handlers = GMCP.handlers or {};

function GMCP.register(name, event, func)
    if (GMCP.handlers[name]) then
        killAnonymousEventHandler(GMCP.handlers[name]);
        GMCP.handlers[name] = nil;
    end
    local handler = registerAnonymousEventHandler(event, func);
    GMCP.handlers[name] = handler;
end


NU.load("gmcp", "affliction_handlers")();
NU.load("gmcp", "defense_handlers")();
NU.load("gmcp", "vitals_handlers")();
NU.load("gmcp", "item_handlers")();
NU.load("gmcp", "room_handlers")();

NU.load("gmcp", "item_tracking")();