MC = {};
_G.MC = MC;

-- Helpers
require 'script/_lib/core/helpers/MC_DataHelpers';
require 'script/_lib/core/helpers/MC_LoadHelpers';
require 'script/_lib/core/helpers/MC_SaveHelpers';
-- Models
require 'script/_lib/core/model/MCController';
require 'script/_lib/core/model/AttritionEventsController';
require 'script/_lib/core/model/Logger';
require 'script/_lib/core/model/WoundedCharacterController';
-- Note: This requires public order expanded
require 'script/_lib/core/model/ExpandedSeaEncountersController';
require 'script/_lib/core/model/NarrativeController';
-- Listeners
require 'script/_lib/core/listeners/MCListeners';

function zz_mighty_campaigns()
    local enableLogging = true;
    out("MC: Main mod function");
    MC = MCController:new({

    });
    MC:Initialise(enableLogging);
    MC.Logger:Log("Initialised");
    if cm:is_new_game() then
        -- Setup the delayed start faction starts (ie remove them)
        MC:DelayedStartInitialisation();
    else

    end
    MC_SetupPostUIListeners(MC, core, invasion_manager, enableLogging);
    MC.Logger:Log_Finished();
    _G.MC = MC;
    out("MC: Finished setup");
end

-- Saving/Loading Callbacks
cm:add_saving_game_callback(
    function(context)
        out("MC: Saving callback");
        out("MC: Finished saving");
    end
);

cm:add_loading_game_callback(
    function(context)
        out("MC: Loading callback");
        out("MC: Finished loading");
	end
);