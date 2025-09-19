local function onTriangle()
    if (PFLAGS.illusion) then return; end
    NU.appendPFlag(TRACK.getSelf().name .. "_shape", "triangle");
end

local function onSquare()
    if (PFLAGS.illusion) then return; end
    NU.appendPFlag(TRACK.getSelf().name .. "_shape", "square");
end

local function onCircle()
    if (PFLAGS.illusion) then return; end
    NU.appendPFlag(TRACK.getSelf().name .. "_shape", "circle");
end

TRIG.register("lemniscate_triangle", "exact", [[The spinning points of the Triangle burn themselves into your heart.]], onTriangle, "ARCHIVIST_DEFENSE", "Lemniscate triangle affs.");
TRIG.register("sonder_joy", "exact", [[Joy surges through your psyche, promoting carelessness and positivity.]], onTriangle, "ARCHIVIST_DEFENSE", "Lemniscate triangle affs.");
TRIG.register("lemniscate_square", "exact", [[Sharp straight lines form the Square as they encapsule your thoughts.]], onSquare, "ARCHIVIST_DEFENSE", "Lemniscate square affs.");
TRIG.register("sonder_fear", "exact", [[Fear prickles at your psyche, fomenting panic and reticence.]], onSquare, "ARCHIVIST_DEFENSE", "Lemniscate square affs.");
TRIG.register("lemniscate_circle", "exact", [[The ring of the Circle expands from naught to press upon your reason.]], onCircle, "ARCHIVIST_DEFENSE", "Lemniscate circle affs.");
TRIG.register("sonder_disgust", "exact", [[Disgust overwhelms your psyche, sowing self-doubt and stomach-churning upset.]], onCircle, "ARCHIVIST_DEFENSE", "Lemniscate circle affs.");

-- Your mind turns toward a recent annoyance, rekindling sparks of anger within your mind.
