local MAX_NUM_SAVE_TABLE_KEYS = 200;

local cm = nil;
local context = nil;

function MC_InitialiseLoadHelpers(cmObject, contextObject)
    out("MC: Initialising load helpers");
    cm = cmObject;
    context = contextObject;
end