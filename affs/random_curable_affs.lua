AFFS.random = {};
AFFS.irandom = {};

for aff,state in pairs(NU.aff_db_reference) do
    if (state.random) then
        AFFS.random[aff] = true;
        table.insert(AFFS.irandom, aff);
    end
end