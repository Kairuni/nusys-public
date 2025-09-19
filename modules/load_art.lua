function NU.drawANSIFile(filename)
    local file = io.open(NU.getHomeDir() .. "/../nuSys/load_art/" .. filename, "r");
    local outputString = ansi2decho(file:read("*all"));
    file:close();
    decho(outputString);
end

function NU.displayCatOnDeath()
    NU.drawANSIFile("cat.ans");
    cecho("\n\n<red>Y u so Bad?\n");
end