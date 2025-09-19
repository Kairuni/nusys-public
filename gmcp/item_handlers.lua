-- TODO: Make this more general - for now it's just a single function, recording ironcollar - but we might want it to have other functionality for item tracking later.
function GMCP.addItem()
    local item = gmcp.Char.Items.Add.item;
    if (item.name == "an iron collar") then
        NU.setFlag("last_ironcollar", item.id, 60);
    end
end

GMCP.register("gmcp_add_items", "gmcp.Char.Items.Add", GMCP.addItem);