NU.items = {
    room = {},
    inv = {},
};

function GMCP.itemList()
    local loc = gmcp.Char.Items.List.location;
    NU.items[loc] = {};
    for _,v in ipairs(gmcp.Char.Items.List.items) do
        table.insert(NU.items[loc], v);
    end

    if (gmcp.Char.Items.List.location == "room") then
        AUTOBASH.updateAggroQueue();
    end
end

function GMCP.itemRemove()
    local loc = gmcp.Char.Items.Remove.location;
    local tb = NU.items[loc];
    local index = -1;
    local id = gmcp.Char.Items.Remove.item.id;

    if (not tb) then
        return;
    end

    for i,v in ipairs(NU.items[loc]) do
        if (v.id == id) then
            index = i;
            break;
        end
    end

    if (index ~= -1) then
        table.remove(NU.items[loc], index);
    end

    if (gmcp.Char.Items.Remove.location == "room") then
        AUTOBASH.updateAggroQueue();
    end
end

function GMCP.itemAdd()
    local loc = gmcp.Char.Items.Add.location;
    local tb = NU.items[loc];
    if (not tb) then
        tb = {};
        NU.items[loc] = tb;
    end
    local item = gmcp.Char.Items.Add.item;

    table.insert(NU.items[loc], item);

    if (gmcp.Char.Items.Add.location == "room") then
        AUTOBASH.updateAggroQueue();
    end
end

GMCP.register("gmcp_items_list", "gmcp.Char.Items.List", GMCP.itemList);
GMCP.register("gmcp_items_remove", "gmcp.Char.Items.Remove", GMCP.itemRemove);
GMCP.register("gmcp_items_add", "gmcp.Char.Items.Add", GMCP.itemAdd);