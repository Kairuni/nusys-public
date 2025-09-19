VITALS = {};
VITALS.vitalsOrder = {
    "charge_right",
    "charge_left", -- Templar/Rev blade charge
    "energy", -- Shaman 'Energy'
    "resonance", -- Ascendril 'Resonance'
    "essence", -- Necromancer essence
    "devotion", -- Lumie devo
    "spark", -- Lumie spark
    "momentum", -- Tera?
    "kai", -- Monk
    "fury", -- Wf?
    "bio", -- Archivist
    "shadowprice", -- Scio
    "psi", -- newZealot
    "dithering", -- bard
    "knife_stance", -- predator
    "first_regalia", -- Sidereal
    "second_regalia",
    "apparition",
    "sandstorm",


    "ability_bal", -- Class balance
    "balance",
    "bleeding",
    "blind",
    "blood",
    "cloak",
    "deaf",
    "elevation",
    "elixir", -- Elixir Balance?
    "ep", -- Endurance Points
    "equilibrium",
    "fallen",
    "fangbarrier",
    "focus",
    "herb",
    "hp",
    "left_arm", -- Left arm balance
    "right_arm",
    "madness",
    "maxep",
    "maxhp",
    "maxmp",
    "maxwp",
    "moss",
    "mounted",
    "mp",
    "phased",
    "pipe",
    "prone",
    "renew",
    "residual",
    "salve",
    "soul",
    "tree",
    "wield_left",
    "wield_right",
    "wp",
    "writhing",
}

VITALS.numberVitals = {
    blood = true,
    bleeding = true,
    ep = true,
    hp = true,
    maxep = true,
    maxhp = true,
    maxmp = true,
    maxwp = true,
    mp = true,
    residual = true,
    soul = true,
    wp = true,

    dithering = true,

    charge_right = true,
    charge_left = true, -- Templar/Rev blade charge
    energy = true, -- Shaman 'Energy'
    kai = true,
    apparition = true,
    sandstorm = true,
}

VITALS.balanceConversion = {
    elixir = "elixir",
    focus = "focus",
    herb = "pill",
    salve = "poultice",
    tree = "tree",
    moss = "anabiotic",
}

VITALS.booleanVitals = {
    ability_bal = true,
    balance = true,
    blind = true,
    cloak = true,
    deaf = true,
    elixir = true,
    equilibrium = true,
    fallen = true,
    fangbarrier = true,
    focus = true,
    herb = true,
    left_arm = true,
    madness = true,
    moss = true,
    phased = true,
    pipe = true,
    prone = true,
    renew = true,
    right_arm = true,
    salve = true,
    tree = true,
}

VITALS.ignoredVitals = {
    charstats = true,
    xp = true,
    maxxp = true,
    nl = true,
    string = true,
    vote = true,
}

VITALS.hpmana = {
    hp = true,
    maxhp = true,
    mp = true,
    maxmp = true,
}

VITALS.endwp = {
    ep = true,
    maxep = true,
    wp = true,
    maxwp = true,
}

-- Named from the gmcp.Char.Vitals values, rather than the actual game balances.
BALANCES = {
    -- Offensive balances
    "balance",
    "left_arm",
    "right_arm",

    "equilibrium",

    "ability_bal",

    -- Curing balances
    "elixir",
    "focus",
    "pill",
    "pipe",
    "poultice",
    "tree",
    "anabiotic"
};

function VITALS.buildVitals()
    local tbRet = {};
    for _,v in ipairs(VITALS.vitalsOrder) do
        if (VITALS.numberVitals[v]) then
            tbRet[v] = 0;
            if (VITALS.hpmana[v]) then
                tbRet[v] = 6000;
            elseif (VITALS.endwp[v]) then
                tbRet[v] = 30000;
            end
        elseif (VITALS.booleanVitals[v]) then
            if (VITALS.balanceConversion[v]) then
                tbRet[VITALS.balanceConversion[v]] = true
            else
                tbRet[v] = true;
            end
        else
            tbRet[v] = "";
        end
    end
    return tbRet;
end
