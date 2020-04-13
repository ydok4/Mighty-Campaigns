local MAX_NUM_SAVE_TABLE_KEYS = 200;

local cm = nil;
local context = nil;

function MC_InitialiseSaveHelpers(cmObject, contextObject)
    out("EnR: Initialising save helpers");
    cm = cmObject;
    context = contextObject;
end