WoundedCharacterController = {
    MainController = {};
}

function WoundedCharacterController:new (o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function WoundedCharacterController:Initialise(core, enableLogging)
    self.CampaignName = cm:get_campaign_name();
    self.Logger = Logger:new({});
    self.Logger:Initialise("MightyCampaigns-WoundedCharacters.txt", enableLogging);
    --self:SetupListeners(core);
    self.Logger:Log_Start();
end

function WoundedCharacterController:SetupListeners(core)
    core:add_listener(
        "MC_CharacterKilled",
        "CharacterConvalescedOrKilled",
        function(context)
            local char = context:character();
            return not char:character_type("colonel");
        end,
        function(context)
            local character = context:character();
            if not character:is_null_interface()
            and character:is_wounded() == true then
                if character:has_trait("mc_character_wounds") then
                    local traitPoints = character:trait_points("mc_character_wounds");
                    if traitPoints == 1 then
                        self.Logger:Log("Character has run out of wounds");
                        cm:set_character_immortality("character_cqi:"..character:command_queue_index(), false);
                        self.Logger:Log("Killing character: "..character:character_subtype_key());
                        cm:kill_character(character:command_queue_index(), false, true);
                        self.Logger:Log_Finished();
                    else
                        self.Logger:Log("Character has "..traitPoints.." wounded points");
                        cm:force_add_trait(cm:char_lookup_str(character), "mc_character_wounds", false, (traitPoints - 1), true);
                        self.Logger:Log_Finished();
                    end
                end
            end
        end,
        true
    );

    core:add_listener(
        "MC_CharacterCreated",
        "CharacterCreated",
        function(context)
            local char = context:character();
            return not char:character_type("colonel");
        end,
        function(context)
            local character = context:character();
            if character:has_trait("mc_character_wounds") == false
            and character:is_faction_leader() == false then
                self.Logger:Log("Adding trait to character: "..character:character_subtype_key());
                cm:force_add_trait(cm:char_lookup_str(character), "mc_character_wounds", false, 4, true);
                self.Logger:Log_Finished();
            end
        end,
        true
    );

    core:add_listener(
		"ME_PendingBattle",
		"PendingBattle",
		true,
        function(context)
            self:SetImmortalityForAllCharactersInPendingBattle(true);
        end,
		true
    );

    core:add_listener(
		"ME_BattleCompleted",
		"BattleCompleted",
		true,
        function(context)
            self:SetImmortalityForAllCharactersInPendingBattle(false);
        end,
		true
    );

    core:add_listener(
		"ME_BattleCompletedCameraMove",
		"BattleCompletedCameraMove",
		true,
        function(context)
            self:SetImmortalityForAllCharactersInPendingBattle(false);
        end,
		true
	);
end

function WoundedCharacterController:SetImmortalityForAllCharactersInPendingBattle(immortalityValue)
    for i = 1, cm:pending_battle_cache_num_defenders() do
        local current_char_cqi, current_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(i);
        local militaryForce = cm:model():military_force_for_command_queue_index(tonumber(current_mf_cqi));
        local characterInterfaces = {};
        if militaryForce:has_general()
        and cm:char_is_mobile_general_with_army(militaryForce:general_character()) == true then
            characterInterfaces[#characterInterfaces + 1] = militaryForce:general_character();
        end
        local militaryForceCharacterList = militaryForce:character_list();
        for j = 1, militaryForceCharacterList:num_items() - 1 do
            local militaryForceCharacter = militaryForceCharacterList:item_at(j);
            if cm:char_is_agent(militaryForceCharacter) == true then
                characterInterfaces[#characterInterfaces + 1] = militaryForceCharacter;
            end
        end
        for index, characterInterface in pairs(characterInterfaces) do
            if characterInterface:has_trait("mc_character_wounds") == true then
                cm:set_character_immortality("character_cqi:"..characterInterface:command_queue_index(), immortalityValue);
            end
        end
    end;
    for i = 1, cm:pending_battle_cache_num_attackers() do
        local current_char_cqi, current_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(i);
        local militaryForce = cm:model():military_force_for_command_queue_index(tonumber(current_mf_cqi));
        local characterInterfaces = {};
        if militaryForce:has_general()
        and cm:char_is_mobile_general_with_army(militaryForce:general_character()) == true then
            characterInterfaces[#characterInterfaces + 1] = militaryForce:general_character();
        end
        local militaryForceCharacterList = militaryForce:character_list();
        for j = 1, militaryForceCharacterList:num_items() - 1 do
            local militaryForceCharacter = militaryForceCharacterList:item_at(j);
            if cm:char_is_agent(militaryForceCharacter) == true then
                characterInterfaces[#characterInterfaces + 1] = militaryForceCharacter;
            end
        end
        for index, characterInterface in pairs(characterInterfaces) do
            if characterInterface:has_trait("mc_character_wounds") == true then
                cm:set_character_immortality("character_cqi:"..characterInterface:command_queue_index(), immortalityValue);
            end
        end
    end;
end