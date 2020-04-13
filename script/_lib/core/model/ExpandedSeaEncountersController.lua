ExpandedSeaEncountersController = {
    MainController = {},
    InvasionManager = {},
    LastEncounterData = {},
    SubcultureEncounterChance = {
        wh_main_sc_brt_bretonnia = {
            Weighting = 3,
        },
        wh_main_sc_chs_chaos = {
            Weighting = 2,
        },
        wh2_main_sc_def_dark_elves = {
            Weighting = 10,
        },
        wh_main_sc_emp_empire = {
            Weighting = 8,
        },
        wh_main_sc_grn_greenskins = {
            Weighting = 4,
        },
        wh2_main_sc_hef_high_elves = {
            Weighting = 6,
        },
        wh_main_sc_nor_norsca = {
            Weighting = 10,
        },
        wh2_main_sc_skv_skaven = {
            Weighting = 4,
        },
        wh2_dlc09_sc_tmb_tomb_kings = {
            Weighting = 3,
        },
        wh2_dlc11_sc_cst_vampire_coast = {
            Weighting = 12,
        },
    },
}

function ExpandedSeaEncountersController:new (o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function ExpandedSeaEncountersController:Initialise(core, invasion_manager, enableLogging)
    self.Logger = Logger:new({});
    self.Logger:Initialise("MightyCampaigns-ExpandedSeaEncounters.txt", enableLogging);
    self.InvasionManager = invasion_manager;
    self:SetupListeners(core);
    self:SetupValidEncounterSubcultureWeightings();
    self.Logger:Log_Start();
end

function ExpandedSeaEncountersController:SetupValidEncounterSubcultureWeightings()
    local humanSubculture = self.MainController.HumanFaction:subculture();
    if humanSubculture == "wh2_main_sc_hef_high_elves" then
        self.SubcultureEncounterChance["wh2_main_sc_hef_high_elves"] = nil;
    elseif humanSubculture == "wh_main_sc_emp_empire" then
        self.SubcultureEncounterChance["wh_main_sc_emp_empire"].Weighting = 4;
    elseif humanSubculture == "wh2_dlc09_sc_tmb_tomb_kings" then
        self.SubcultureEncounterChance["wh2_dlc09_sc_tmb_tomb_kings"] = nil;
    elseif humanSubculture == "wh2_main_sc_def_dark_elves" then
        self.SubcultureEncounterChance["wh2_main_sc_def_dark_elves"].Weighting = 2;
    end
end

function ExpandedSeaEncountersController:SetupListeners(core)
    core:add_listener(
        "MC_SeaEncounterEntered",
        "AreaEntered",
        function(context)
            local areaKey = context:area_key();
            local faction = context:character():faction();
            return faction:name() == self.MainController.HumanFaction:name()
            and string.match(areaKey, "test_marker") ~= nil;
        end,
        function(context)
            local areaKey = context:area_key();
            self.Logger:Log("AreaEntered: "..areaKey);
            local character = context:character();
            if cm:char_is_mobile_general_with_army(character) then
                local ramData = self:ReRollArmyEncounters();
                if ramData ~= nil then
                    self.LastEncounterData = ramData;
                    self:SetLocalisedEncounterNameKey(ramData);
                    if _G.IsIDE == true then
                        self:AssignGeneralForLastEncounter()
                    end
                end
            end
            self.Logger:Log_Finished();
        end,
        true
    );
end

-- This works by overriding the random army data for the key 'encounter_force'
function ExpandedSeaEncountersController:ReRollArmyEncounters()
    local encounterSubculture = self:GetEncounterSubculture();
    self.Logger:Log("Encounter subculture will be: "..encounterSubculture);
    if _G.ER == nil then
        self.Logger:Log("ERROR: Can't find ER");
        return nil;
    end
    local subcultureArmyArchetypes = _G.ER:GetRebelArmyArchetypesForSubculture(encounterSubculture);
    if subcultureArmyArchetypes == nil then
        self.Logger:Log("ERROR: No encounter archetypes found");
    else
        self.Logger:Log("Got archetype list");
        local armyArchetypeKey = GetRandomItemFromWeightedList(subcultureArmyArchetypes, true);
        self.Logger:Log("Encounter army archetype will be: "..armyArchetypeKey);
        local armyArchetypeResources = _G.ER:GetResourcesForRebelArmyArchetypes(encounterSubculture, armyArchetypeKey);
        local agentSubTypeKey = "";
        for key, value in pairs(armyArchetypeResources.AgentSubtypes) do
            if key == 1 then
                agentSubTypeKey = GetRandomObjectFromList(armyArchetypeResources.AgentSubtypes);
            else
                agentSubTypeKey = GetRandomObjectKeyFromList(armyArchetypeResources.AgentSubtypes);
            end
            break;
        end
        self.Logger:Log("Selected general as: "..agentSubTypeKey);
        local encounterData = {
            ForceKey = "encounter_force",
            FactionKey = "wh2_dlc11_cst_vampire_coast_encounters",
            SubcultureKey = encounterSubculture,
            AgentSubTypeKey = agentSubTypeKey,
            MandatoryUnits = armyArchetypeResources.MandatoryUnits,
            UnitTags = armyArchetypeResources.UnitTags,
            ArmyArchetypeKey = armyArchetypeKey,
        };
        -- First we setup the new army force string
        local encounterArmySize = _G.ER.ArmyGenerator:GetArmySize() + 3;
        if encounterArmySize > 19 then
            encounterArmySize = 19;
        end
        local ramData = {
            ForceKey = encounterData.ForceKey,
            ArmySize = encounterArmySize,
            ForceData = encounterData,
        };
        self.Logger:Log("Before generate force for turn.");
        _G.ER.ArmyGenerator:GenerateForceForTurn(ramData, encounterArmySize);
        self.Logger:Log("Changed army composition.");
        return ramData;
    end
    return nil;
end

function ExpandedSeaEncountersController:GetEncounterSubculture()
    local chosenSubculture = GetRandomItemFromWeightedList(self.SubcultureEncounterChance, true);
    return chosenSubculture;
end

function ExpandedSeaEncountersController:SetLocalisedEncounterNameKey(ramData)
    local factionKey = ramData.ForceData.FactionKey;
    local subcultureKey = ramData.ForceData.SubcultureKey;
    local encounterFactionNameKey = "mc_"..subcultureKey.."_sea_encounter_faction_name";
    self.Logger:Log("Changing faction name key: "..encounterFactionNameKey);
    cm:change_localised_faction_name(factionKey, encounterFactionNameKey);
end

function ExpandedSeaEncountersController:AssignGeneralForLastEncounter()
    local lastEncounterData = self.LastEncounterData;
    --local defaultRebelFactionForSubculture = _G.ER:GetRebellionFactionForSubculture(lastEncounterData.ForceData.SubcultureKey, false);
    local faction = cm:get_faction(lastEncounterData.ForceData.FactionKey);
    if faction:is_null_interface() then
        self.Logger:Log("Faction is null interface");
    end
    -- Note: This will always assign a Vampirate name because that is the only names the faction has access to
    local canUseFemaleNames = _G.ER.CharacterGenerator:GetGenderForAgentSubType(lastEncounterData.ForceData.AgentSubTypeKey);
    local foreName = "";
    if canUseFemaleNames then
        foreName = "names_name_5894568";
    else
        foreName = "names_name_5894567";
    end
    self.Logger:Log("Adding agent subtype for invasion: "..lastEncounterData.ForceData.AgentSubTypeKey);
    self.Logger:Log_Finished();
    return {
        AgentSubTypeKey = lastEncounterData.ForceData.AgentSubTypeKey,
        Forename = foreName,
        ClanName = foreName,
    };
end