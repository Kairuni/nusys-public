-- Default Prio Sets
PRIOS.default = {};
PRIOS.default.generic = {};

for _,v in ipairs(UTIL.classList) do
    PRIOS.default[v:lower()] = {};
end