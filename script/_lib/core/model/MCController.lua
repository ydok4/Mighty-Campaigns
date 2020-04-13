MCController = {
    DelayedStartHistory = {},
    AttritionEventsController = {},
}

function MCController:new (o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function MCController:Initialise(enableLogging)
    self.CampaignName = cm:get_campaign_name();
    self.HumanFaction = self:GetHumanFaction();
    self.ArmyGenerator = ArmyGenerator:new({

    });
    self.CharacterGenerator = CharacterGenerator:new({
    });
    self.CharacterGenerator:Initialise(enableLogging);
    self.Logger = Logger:new({});
    self.Logger:Initialise("MightyCampaigns.txt", enableLogging);
    self.Logger:Log_Start();
end

function MCController:DelayedStartInitialisation()
    self.Logger:Log("DelayedStartInitialisation");
    -- Disable world events
    cm:disable_event_feed_events(true, "all", "", "");
    local delayedStartFactions = _G.MCResources.DelayedStartResources;
    for factionKey, delayedStartData in pairs(delayedStartFactions) do
        local faction = cm:get_faction(factionKey);
        local excludedFromPlayer = false;
        if delayedStartData.ExcludedIfPlayerFaction ~= nil then
            for index, excludedFactionKey in pairs(delayedStartData.ExcludedIfPlayerFaction) do
                if excludedFactionKey == self.HumanFaction:name() then
                    excludedFromPlayer = true;
                    break;
                end
            end
        end
        if faction and factionKey ~= self.HumanFaction:name()
        and excludedFromPlayer == false then
            self.Logger:Log("Delaying: "..faction:name());
            cm:kill_all_armies_for_faction(faction);
            local factionRegionList = faction:region_list();
            if delayedStartData.GrantTerritoryTo ~= nil then
                -- Transfer territory
                local transferToFaction = delayedStartData.GrantTerritoryTo[self.CampaignName];
                if transferToFaction ~= nil then
                    for i = 0, factionRegionList:num_items() - 1 do
                        local current_region = factionRegionList:item_at(i);
                        if not current_region:is_abandoned() then
                            local regionName = current_region:name();
                            self.Logger:Log("Transfering region: "..regionName.." to faction: "..transferToFaction);
                            cm:transfer_region_to_faction(current_region:name(), transferToFaction);
                        end
                    end
                end
            elseif delayedStartData.AbandonTerritory == true then
                for i = 0, factionRegionList:num_items() - 1 do
                    local current_region = factionRegionList:item_at(i);
                    if not current_region:is_null_interface()
                    and not current_region:is_abandoned() then
                        self.Logger:Log("Abandoning region: "..current_region:name());
                        cm:set_region_abandoned(current_region:name());
                        self.Logger:Log("Abandoned region: "..current_region:name());
                    end
                end
            end
            -- If the faction is beastmen then we lock the recruitment of Malagor
            -- and Morghur so we can spawn new copies of them
            if factionKey == "wh_dlc03_bst_beastmen" then
                --cm:lock_starting_general_recruitment("2140784127", factionKey);
                --cm:lock_starting_general_recruitment("2140784189", factionKey);
            end
        end
    end
    -- Re-enable world events
    cm:disable_event_feed_events(false, "all", "", "");
end

function MCController:GetHumanFaction()
    local allHumanFactions = cm:get_human_factions();
    if allHumanFactions == nil then
        return allHumanFactions;
    end
    for key, humanFaction in pairs(allHumanFactions) do
        local faction = cm:model():world():faction_by_key(humanFaction);
        return faction;
    end
end