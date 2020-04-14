function MC_SetupPostUIListeners(mc, core, invasion_manager, enableLogging)
    mc.WoundedCharacterController = WoundedCharacterController:new({
        MainController = mc,
    });
    mc.WoundedCharacterController:Initialise(core, enableLogging);

    if _G.ER ~= nil then
        mc.ExpandedSeaEncountersController = ExpandedSeaEncountersController:new({
            MainController = mc,
        });
        mc.ExpandedSeaEncountersController:Initialise(core, invasion_manager, enableLogging);

        local pastNarratives = {};
        if mc.NarrativeController ~= nil then
            pastNarratives = mc.NarrativeController.PastNarratives;
        end
        mc.NarrativeController = NarrativeController:new({
            MainController = mc,
            PastNarratives = pastNarratives,
        });
        mc.NarrativeController:Initialise(core, enableLogging);
        MC_NC_SetupListeners(mc, core);
    end

    mc.AttritionEventsController = AttritionEventsController:new({
        MainController = mc,
    });
    mc.AttritionEventsController:Initialise(core, enableLogging);
end

function MC_NC_SetupListeners(mc, core)
    -- This sets up the global level narratives
    -- These are invasion level events where only one of these can be active
    -- at a time
    -- Note: Even though this only triggers on the player's turn
    -- the effects may target different factions
    core:add_listener(
        "MC_NC_FactionTurnStart_BeginNarrativeGeneration_Global",
        "FactionTurnStart",
        function(context)
            return mc.HumanFaction:name() == context:faction():name();
        end,
        function(context)
            mc.NarrativeController.Logger:Log("MC_NC_FactionTurnStart_BeginNarrativeGeneration_Global");

            mc.NarrativeController.Logger:Log_Finished();
        end,
        true
    );
    -- This sets up the faction level narratives
    -- These are events which can only happen once per faction
    -- or are restricted on a faction level
    core:add_listener(
        "MC_NC_FactionTurnStart_BeginNarrativeGeneration_Faction",
        "FactionTurnStart",
        function(context)
            return IsExcludedFaction(context:faction()) == false;
        end,
        function(context)
            --mc.NarrativeController.Logger:Log("MC_NC_FactionTurnStart_BeginNarrativeGeneration_Faction");
            local faction = context:faction();
            local factionKey = faction:name();
            local regionList = faction:region_list();

            local isHumanFaction = mc.HumanFaction:name() == context:faction():name();
            -- Iterate over all provinces and add into a list
            local factionRegions = {};
            for i = 0, regionList:num_items() - 1 do
                local region = regionList:item_at(i);
                local regionName = region:name();
                local provinceKey = region:province_name();
                local settlement = region:settlement();
                local climateKey = settlement:get_climate();
                factionRegions[regionName] = true;
            end
            local validNarratives = mc.NarrativeController:GenerateNarrativesForFaction(faction, factionRegions, "Faction");
            --mc.NarrativeController.Logger:Log("Generated faction narratives");
            local selectedNarrative = GetRandomItemFromWeightedList(validNarratives);
            if selectedNarrative.NarrativeData ~= nil then
                mc.NarrativeController.Logger:Log("Starting narrative: "..selectedNarrative.NarrativeData.Key);
                local spawnRegion = cm:get_region(selectedNarrative.SpawnRegionKey);
                mc.NarrativeController.Logger:Log("Spawn region is: "..selectedNarrative.SpawnRegionKey);
                mc.NarrativeController:StartNarrative(spawnRegion, "Faction", selectedNarrative.NarrativeData);
                mc.NarrativeController.Logger:Log_Finished();
            end
        end,
        true
    );
    -- This sets up the province level narratives
    -- These can only happen once per province
    -- Note: These are the same scope as rebels in Public Order Expanded
    core:add_listener(
        "MC_NC_FactionTurnStart_BeginNarrativeGeneration_Province",
        "FactionTurnStart",
        function(context)
            return false --IsExcludedFaction(context:faction()) == false;
        end,
        function(context)
            --mc.NarrativeController.Logger:Log("MC_NC_FactionTurnStart_BeginNarrativeGeneration_Province");
            local faction = context:faction();
            local factionKey = faction:name();
            local regionList = faction:region_list();
            -- Iterate over all provinces and add into a list
            local checkedProvinces = {};
            for i = 0, regionList:num_items() - 1 do
                local region = regionList:item_at(i);
                local regionName = region:name();
                local provinceKey = region:province_name();
                if not checkedProvinces[provinceKey]
                -- Oak of ages is excluded from all generation
                and regionName ~= "wh_main_yn_edri_eternos_the_oak_of_ages"
                and Roll100(100) == true then
                    local validNarratives = mc.NarrativeController:GenerateNarrativesForProvince(faction, region, provinceKey);
                    --mc.NarrativeController.Logger:Log("Generated province narratives");
                    local selectedNarrative = GetRandomItemFromWeightedList(validNarratives);
                    if selectedNarrative.NarrativeData ~= nil then
                        mc.NarrativeController:StartNarrative(region, "Province", selectedNarrative.NarrativeData);
                    end
                end
                checkedProvinces[provinceKey] = true;
            end
            --mc.NarrativeController.Logger:Log_Finished();
        end,
        true
    );
    -- This sets up the region level narratives
    -- These won't spawn armies but will be localised to things like weather
    -- Note: For performance reasons (and practical), this only happens for the player
    core:add_listener(
        "MC_NC_FactionTurnStart_BeginNarrativeGeneration_Region",
        "FactionTurnStart",
        function(context)
            return mc.HumanFaction:name() == context:faction():name();
        end,
        function(context)
            mc.NarrativeController.Logger:Log("MC_NC_FactionTurnStart_BeginNarrativeGeneration_Region");

            mc.NarrativeController.Logger:Log_Finished();
        end,
        true
    );
    -- This sets up the military force level narratives
    -- These are still TBD but are expected to trigger after battles and provide some fluff
    -- for generic characters.
    -- Note: For performance reasons (and practical), this only happens for the player
    core:add_listener(
        "MC_NC_FactionTurnStart_BeginNarrativeGeneration_MilitaryForce",
        "FactionTurnStart",
        function(context)
            return mc.HumanFaction:name() == context:faction():name();
        end,
        function(context)
            mc.NarrativeController.Logger:Log("MC_NC_FactionTurnStart_BeginNarrativeGeneration_MilitaryForce");

            mc.NarrativeController.Logger:Log_Finished();
        end,
        true
    );
end

function IsExcludedFaction(faction)
    local factionName = faction:name();
    if factionName == "wh_main_grn_skull-takerz" then
        return false;
    end

    if factionName == "rebels" or
    string.match(factionName, "waaagh") or
    string.match(factionName, "brayherd") or
    string.match(factionName, "intervention") or
    string.match(factionName, "incursion") or
    string.match(factionName, "separatists") or
    string.match(factionName, "qb") or
    factionName == "wh_dlc03_bst_beastmen_chaos" or
    factionName == "wh2_dlc11_cst_vampire_coast_encounters"
    then
        --Custom_Log("Faction is excluded");
        return true;
    end

    return false;
end