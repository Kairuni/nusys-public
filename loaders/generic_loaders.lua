local function loadOrError(mod, path)
    local success, info = loadfile(NU.getHomeDir() .. "/../nuSys/" .. mod .. "/" .. path .. ".lua");
    if (not success) then
        NU.WARN("Failed to load: " .. mod .." - " .. path .. " : " .. tostring(info) .. "\n");
    end
    return success;
end

local function loadAllFilesInDir(directory)
    local subdirs = {NU.getHomeDir() .. "/../nuSys/" .. directory};

    local function loadFile(path, file, sub)
        if (file ~= "." and file ~= "..") then
            local fullPath = path .. "/" .. file;
            local fileMode = lfs.attributes(fullPath, "mode");
            if (fileMode == "directory") then
                table.insert(sub, fullPath);
            else
                -- NU.DECHO("Loading " .. file .. "\n", 10);
                local func, info = loadfile(path .. "/" .. file);
                if (not func) then
                    NU.WARN("Failed to load " .. file .. " - " .. tostring(info) .. "\n");
                end
                func();
                NU.DECHO("Loaded " .. file .. "\n", 10);
            end
        end
    end

    while (#subdirs > 0) do
        local path = table.remove(subdirs, 1);
        for file in lfs.dir(path) do
            loadFile(path, file, subdirs);
        end
    end
end


return loadOrError, loadAllFilesInDir