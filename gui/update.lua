NU.load("gui", "status_updater")();

function NU.GUI.functions.update()
    if (not gmcp.Char) then return; end
    NU.GUI.functions.updateGUIStatus();
    --nu.setFlag("gui_updated", true, 0.1, GUIUpdater);
end

NU.GUI.functions.update();