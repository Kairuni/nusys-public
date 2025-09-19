TRACKED = {};
TRACK = TRACK or {};
TRACK.self = nil;
NU.target = "none";

function TRACK.latency(balance)
    local st = TRACK.getSelf();
    if (st.affs.RETROGRADE or st.affs.disorientated or (balance and balance == "pipe" and FLAGS[st.name .. "_ironcollar"])) then
        return 1.5 + 0.4 + (0.5 * (st.affs.RETROGRADE and 1 or 0)); -- getNetworkLatency() * 2;
    end
    -- return 0.8;           -- For testing server.
    return 0.2; -- getNetworkLatency() * 2;
end

function TRACK.checkWithIllusion(func)
    if (PFLAGS.illusion) then return; end
    func();
end

NU.loadAll("tracking");