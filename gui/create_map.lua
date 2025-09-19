local leftSize = NU.GUI.leftSize;
local rightSize = NU.GUI.rightSize;
local topSize = NU.GUI.topSize;
local botSize = NU.GUI.bottomSize;

setBorderRight(rightSize);

NU.GUI.rightContainer = Geyser.Container:new({
    name = "rightContainer", x = -rightSize, y = topSize,
    width = rightSize, height = -1,
});

NU.GUI.mapContainer = Geyser.Container:new({
    name = "mapContainer", x = 0, y = 0,
    width = "100%", height = "75%",
}, NU.GUI.rightContainer);

-- Either this, or mapview map.
NU.GUI.mudletMapper = Geyser.Mapper:new({
    name = "mudletMapper", x = 0, y = 0,
    width = "100%", height = "100%",
}, NU.GUI.mapContainer);

--function nu.GUI.functions.mapViewReset()
--    nu.GUI.mapViewMapper:clear();
--end

--function nu.GUI.functions.mapViewAppend()
--    selectCurrentLine();
--    copy();
--    appendBuffer("mapViewMapper");
--    deleteLine();
--end

--local function mapCapture()
--    if (not nu.GUI.mapViewMapper.hidden) then
--        TRIG.enable(TRIGS.map_gated_capture);
--        TRIG.enable(TRIGS.map_gated_end1);
--        TRIG.enable(TRIGS.map_gated_end2);
--        nu.GUI.functions.mapViewReset()
--    end
--end

--local function gatedMapEnd()
--    TRIG.disable(TRIGS.map_gated_capture);
--    TRIG.disable(TRIGS.map_gated_end1);
--    TRIG.disable(TRIGS.map_gated_end2);
--end

--nu.GUI.mapViewMapper:show();
--nu.GUI.mudletMapper:hide();

--TRIG.register("map_capture1", "regex", [[^\-+\s*Area\s*(\d+)\:\s*(.*)\s*v(\d+)\s*\-+$]], mapCapture);
--TRIG.register("map_capture2", "regex", [[^\-+\s*v(\d+)\s*\-+$]], mapCapture);
--TRIG.register("map_gated_capture", "regex", [[(.+)]], nu.GUI.functions.mapViewAppend);
--TRIG.register("map_gated_end1", "regex", [[^\-+\s*([-\d]+):([-\d]+):([-\d]+)\s*\-+$]], gatedMapEnd);
--TRIG.register("map_gated_end2", "regex", [[^\-+\s*(.*)\s*\-*\s*([-\d]+):([-\d]+):([-\d]+)\s*\-+$]], gatedMapEnd);

--gatedMapEnd();




