AFFS = AFFS or {};

NU.load("affs", "aff_db_reference")();
NU.load("affs", "readable_affs")();
NU.load("affs", "mirror_affs")();
NU.load("affs", "curable_defs")();
NU.load("affs", "discernment")();
NU.load("affs", "mental_affs")();
NU.load("affs", "physical_affs")();
NU.load("affs", "random_curable_affs")();
NU.load("affs", "fake_affs")();
NU.load("affs", "pill_affs")();

AFFS.baseline = table.deepcopy(AFFS.readable);


-- Append curable_defs to the readable_affs:
for _,v in ipairs(AFFS.curable_defs) do
    table.insert(AFFS.readable, v);
end

-- Append fake affs to readable AFFS.
for k,_ in pairs(AFFS.fake) do
    table.insert(AFFS.readable, k);
end

-- For each mirror aff, remove it from the main table and replace it with m_Original, add the opposite aff to the mirrors table, and then set the mirror aff to m_Original.
AFFS.mirrors = {};
for k, v in pairs(AFFS.mirroredMap) do
    local i = table.index_of(AFFS.readable, k);
    table.remove(AFFS.readable, i);
    i = table.index_of(AFFS.readable, v);
    table.remove(AFFS.readable, i);
    table.insert(AFFS.readable, "m_" .. v);
end

for k,v in pairs(AFFS.mirroredMap) do
    AFFS.mirrors[v] = "m_" .. v;
    AFFS.mirrors[k] = "m_" .. v;
end

-- And finally, append no_defname to the afflictions table.
if (not DEFS or not DEFS.readable) then
    error("Defenses failed to load prior to afflictions. Please load defenses first.");
    return;
end

AFFS.defs = {};

for _, defense in ipairs(DEFS.readable) do
    local affName = "no_" .. defense;
    table.insert(AFFS.readable, "no_" .. defense);
    AFFS.defs["no_" .. defense] = defense;
end

-- Build afflictions table based on readables.
-- Original idea was to have integer-value afflictions, but I'm not actually convinced this runs faster in lua.
function NU.buildAffTable()
    local ret_table = {};
    for _,v in ipairs(AFFS.readable) do
        ret_table[v] = false;
    end

    local list_metatable = {
        __index = function(t, k)
            if (k == "selfpity") then
                return t["self_pity"];
            elseif (AFFS.mirrors[k]) then
                return t[AFFS.mirrors[k]];
            else
                --display("Nil aff match." .. k);
                return nil;
            end
        end,

        __newindex = function(t, k, v)
            if (AFFS.mirrors[k]) then
                t[AFFS.mirrors[k]] = v;
            else
                NU.DECHO("Tried to set aff " .. tostring(k) .. " which was not in the table.", 8);
                rawset(t, k, v);
            end
        end,
    }

    setmetatable(ret_table, list_metatable);

    return ret_table;
end

NU.load("affs", "aff_draw_order")();
NU.load("affs", "aff_coloration")();
NU.load("affs", "aff_shortnames")();

AFFS.writheAffs = {};
AFFS.writhes = {};
for _,v in ipairs(AFFS.readable) do
    if (string.match(v, "writhe_")) then
        table.insert(AFFS.writheAffs, v);
        AFFS.writhes[v] = true;
    end
end


AFFS.proneList = {
    "FALLEN",
    "UNCONSCIOUS",
    "frozen",
    "indifference",
    "asleep",
    "stun",
    "paralysis",
    "writhe_armpitlock",
    "writhe_bind",
    "writhe_grappled",
    "writhe_gunk",
    "writhe_hoist",
    "writhe_impaled",
    "writhe_lure",
    "writhe_necklock",
    "writhe_ropes",
    "writhe_stasis",
    "writhe_thighlock",
    "writhe_transfix",
    "writhe_vines",
    "writhe_web",

    "withe_dartpinned",
}

return true;