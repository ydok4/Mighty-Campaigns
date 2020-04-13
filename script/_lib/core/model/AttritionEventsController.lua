AttritionEventsController = {
    MainController = {},
    -- Note: The value is not used, it is mostly just for reference
    AttritionKeys = {
        attrition = "campaign_map_attritions_campaign_map_tooltip_event_attrition",
        athel_loren = "campaign_map_attritions_campaign_map_tooltip_athel_loren",
        besieged = "campaign_map_attritions_campaign_map_tooltip_besieged",
        chaos_territory = "campaign_map_attritions_campaign_map_tooltip_chaos_territory",
        chaos_wastes = "campaign_map_attritions_campaign_map_tooltip_chaos_wastes",
        deep_sea = "campaign_map_attritions_campaign_map_tooltip_deep_sea",
        desert = "campaign_map_attritions_campaign_map_tooltip_desert",
        disease = "campaign_map_attritions_campaign_map_tooltip_disease",
        horde_infighting = "campaign_map_attritions_campaign_map_tooltip_horde_infighting",
        lizard_defenders = "campaign_map_attritions_campaign_map_tooltip_lizard_defenders",
        maelstrom = "campaign_map_attritions_campaign_map_tooltip_maelstrom",
        mist = "campaign_map_attritions_campaign_map_tooltip_mist",
        mountain = "campaign_map_attritions_campaign_map_tooltip_mountain",
        non_vampire_territory = "campaign_map_attritions_campaign_map_tooltip_non_vampire_territory",
        nurgle_plague = "campaign_map_attritions_campaign_map_tooltip_nurgle_plague",
        sea_monster_storm = "campaign_map_attritions_campaign_map_tooltip_sea_monster_storm",
        reef = "campaign_map_attritions_campaign_map_tooltip_reef",
        snow = "campaign_map_attritions_campaign_map_tooltip_snow",
        storm_level_1 = "campaign_map_attritions_campaign_map_tooltip_storm_level_1",
        storm_level_2 = "campaign_map_attritions_campaign_map_tooltip_storm_level_2",
        storm_level_3 = "campaign_map_attritions_campaign_map_tooltip_storm_level_3",
        storm_level_4 = "campaign_map_attritions_campaign_map_tooltip_storm_level_4",
        storm_level_5 = "campaign_map_attritions_campaign_map_tooltip_storm_level_5",
        storm_sandstorm = "campaign_map_attritions_campaign_map_tooltip_storm_sandstorm",
        swamp = "campaign_map_attritions_campaign_map_tooltip_swamp",
        vampire_territory = "campaign_map_attritions_campaign_map_tooltip_vampire_territory",
        wasteland = "campaign_map_attritions_campaign_map_tooltip_wasteland",
    },
    LocalisedAttritionTooltips = {},
}

function AttritionEventsController:new (o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function AttritionEventsController:Initialise(core, enableLogging)
    self.Logger = Logger:new({});
    self.Logger:Initialise("MightyCampaigns-AttritionEvents.txt", enableLogging);
    self:SetupListeners(core);
    self:BuildLocalisedUICache();
    self.Logger:Log_Start();
end

function AttritionEventsController:SetupListeners(core)
    core:add_listener(
        "MC_IncomingMessage",
        "CharacterEntersAttritionalArea",
        function(context)
            local character = context:character();
            return self.MainController.HumanFaction:name() == character:faction():name();
        end,
        function(context)
            self.Logger:Log("CharacterEntersAttritionalArea listener");
            local character = context:character();
            local cqi = character:command_queue_index();
            local character3dLabel = find_uicomponent(core:get_ui_root(), "3d_ui_parent", "label_"..cqi);
            if character3dLabel ~= nil then
                self.Logger:Log("Found character 3d UI: ".."label_"..cqi);
                local attrition3dIcon = find_uicomponent(character3dLabel, "list_parent", "status_docker", "status_bar", "attrition");
                if attrition3dIcon then
                    local toolTipText = attrition3dIcon:GetTooltipText();
                    if toolTipText ~= nil then
                        self.Logger:Log("Current attrition tooltip is: "..toolTipText);
                        local attritionType = self.LocalisedAttritionTooltips[toolTipText];
                        if attritionType == nil then
                            self.Logger:Log("ERROR: Can't find attrition type for tooltip");
                        else
                            self.Logger:Log("Tooltip matches attrition type: "..attritionType);
                        end
                    else
                        self.Logger:Log("Tool tip does not have any text");
                    end
                else
                    self.Logger:Log("Missing attrition icon");
                end
            else
                self.Logger:Log("Character does not have 3d UI");
            end
            self.Logger:Log_Finished();
        end,
        true
    );
end

function AttritionEventsController:BuildLocalisedUICache()
    for attritionType, localisedKey in pairs(self.AttritionKeys) do
        local localisedAttritionTooltip = effect.get_localised_string("campaign_map_attritions_campaign_map_tooltip_"..attritionType);
        self.LocalisedAttritionTooltips[localisedAttritionTooltip] = attritionType;
    end
end

function AttritionEventsController:PrintChildUIElements(parent, depth)
    for j = 0, parent:ChildCount() - 1 do
        local child = UIComponent(parent:Find(j));
        local childId = child:Id();
        self.Logger:Log("Depth: "..depth.." Id:"..childId);
        if parent:ChildCount() > 0 then
            self:PrintChildUIElements(child, depth + 1);
        end
    end
end