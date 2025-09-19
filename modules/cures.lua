CURES = CURES or {};

NU.load("cures", "readable_cures")();
NU.load("cures", "aff_to_cure")();
for _, list in pairs(CURES.pill) do
    for _, aff in ipairs(list) do
        AFFS.pill[aff] = true;
    end
end
