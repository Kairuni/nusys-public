function TRACK.abilityDamage(tt, flatHP, percentHP, flatScalar, percentScalar, attackElement, skill, ability)
    local multiplier = attackElement and tt.audits[attackElement] or 1.0;
    -- display(tt.vitals.maxhp);
    -- display(flatHP);
    -- display(percentHP);
    -- display(flatScalar);
    -- display(percentScalar);
    -- display(multiplier)
    -- display(tt.vitals.maxhp * percentScalar * percentHP);
    -- display((((tt.vitals.maxhp * percentScalar * percentHP) + (flatScalar * flatHP)) * multiplier));
    -- display(tt.vitals.maxhp)

    local amount = (((tt.vitals.maxhp * percentScalar * percentHP) + flatScalar * flatHP) * multiplier * (tt.affs.sensitivity and 1.3 or 1.0));

    skill = skill or "Non";
    ability = ability or "CMSG";

    NU.setFlag("LAST_HP_DAMAGE", { target = tt, skill = skill, ability = ability, amount = amount });

    TRACK.hpchange(tt, -amount, 0)
end