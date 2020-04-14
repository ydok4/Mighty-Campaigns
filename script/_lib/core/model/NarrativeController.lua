NarrativeController = {
    -- Reference to the base mighty campaigns controller
    MainController = {},
    -- Contains the narrative resources for the different scopes
    NarrativeResources = {},
    -- Tracks narrative events triggered previously
    PastNarratives = {
        Global = {},
        Faction = {},
        Province = {},
        Region = {},
        MilitaryForce = {},
    },
}

function NarrativeController:new (o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function NarrativeController:Initialise(core, enableLogging)
    self.Logger = Logger:new({});
    self.Logger:Initialise("MightyCampaigns-NarrativeController.txt", enableLogging);
    self.Logger:Log_Start();
    self:InitialisePastNarratives();
    -- Load narrative resources
    self:LoadNarrativeResources();
end

function NarrativeController:InitialisePastNarratives()
    if self.PastNarratives == nil then
        self.PastNarratives = {};
    end

    if self.PastNarratives.Global == nil then
        self.PastNarratives.Global = {};
    end
    if self.PastNarratives.Faction == nil then
        self.PastNarratives.Faction = {};
    end
    if self.PastNarratives.Province == nil then
        self.PastNarratives.Province = {};
    end
    if self.PastNarratives.Region == nil then
        self.PastNarratives.Region = {};
    end
    if self.PastNarratives.MilitaryForce == nil then
        self.PastNarratives.MilitaryForce = {};
    end
end

function NarrativeController:LoadNarrativeResources()
    require 'script/_lib/pooldata/NarrativeData/GlobalNarrativePoolData';
    require 'script/_lib/pooldata/NarrativeData/FactionNarrativePoolData';
    require 'script/_lib/pooldata/NarrativeData/ProvinceNarrativePoolData';
    require 'script/_lib/pooldata/NarrativeData/RegionNarrativePoolData';
    require 'script/_lib/pooldata/NarrativeData/MilitaryForceNarrativePoolData';
    self.NarrativeResources = {
        GlobalNarratives = GetGlobalNarrativePoolData(),
        FactionNarratives = GetFactionNarrativePoolData(),
        ProvinceNarratives = GetProvinceNarrativePoolData(),
        RegionNarratives = GetRegionNarrativePoolData(),
        MilitaryForceNarratives = GetMilitaryForceNarrativePoolDataNarrativePoolData(),
    };
end

function NarrativeController:GetNarrativePoolResources(resourceKey)
    return self.NarrativeResources[resourceKey];
end

function NarrativeController:GenerateNarrativesForProvince(faction, region, provinceKey)
    local factionName = faction:name();
    local subcultureKey = faction:subculture();
    -- Grab generic PREs for the occupying subculture
    local provinceLevelNarratives = self:GetNarrativePoolResources("ProvinceNarratives");
    local applicableNarratives = {};
    -- Combine the default narratives with the subculture specific ones
    for cultureKey, cultureNarratives in pairs(provinceLevelNarratives) do
        if cultureKey == "default"
        or cultureKey == subcultureKey then
            for narrativeKey, narrativeData in pairs(cultureNarratives) do
                applicableNarratives[narrativeKey] = narrativeData;
            end
        end
    end
    local validNarratives = {};
    for narrativeKey, narrativeData in pairs(applicableNarratives) do
        self.Logger:Log("Checking narrative: "..narrativeKey);
        -- A narrative is valid if it passes all of the spawn criteria
        -- and the potential target faction controls at least one of the target regions
        -- Note: We also make sure we are currently checking the target province so it doesn't get
        -- checked multiple times
        local validTarget = false;
        if narrativeData.SpawnData ~= nil
        and narrativeData.SpawnData.PREs ~= nil then
            for preKey, preData in pairs(narrativeData.SpawnData.PREs) do
                if preData.TargetOverrides ~= nil
                and preData.TargetOverrides.Region ~= nil then
                    local overrideRegion = preData.TargetOverrides.Region[self.MainController.CampaignName];
                    if overrideRegion ~= nil then
                        local targetRegion = cm:get_region(overrideRegion);
                        if targetRegion:province_name() == provinceKey
                        and targetRegion:owning_faction():name() == factionName then
                            validTarget = true;
                            break;
                        end
                    end
                else
                    validTarget = true;
                end
            end
        end

        if validTarget == true
        and narrativeData.SpawnCriteria ~= nil then
            local validNarrative = true;
            local validNarrative = self:CheckSpawnCriteria(narrativeKey, region, "Province", narrativeData.SpawnCriteria);
            if validNarrative == true then
                validNarratives[narrativeKey] = {
                    NarrativeData = narrativeData,
                    Weighting = 10,
                };
            end
        end
    end
    return validNarratives;
end

function NarrativeController:GenerateNarrativesForFaction(faction, factionRegions, scope)
    local factionName = faction:name();
    local subcultureKey = faction:subculture();
    -- Grab generic PREs for the occupying subculture
    local scopeResources = scope.."Narratives";
    local provinceLevelNarratives = self:GetNarrativePoolResources(scopeResources);
    local applicableNarratives = {};
    -- Combine the default narratives with the subculture specific ones
    for cultureKey, cultureNarratives in pairs(provinceLevelNarratives) do
        if cultureKey == "default"
        or cultureKey == subcultureKey then
            for narrativeKey, narrativeData in pairs(cultureNarratives) do
                applicableNarratives[narrativeKey] = narrativeData;
            end
        end
    end
    local validNarratives = {};
    for narrativeKey, narrativeData in pairs(applicableNarratives) do
        -- A narrative is valid if it passes all of the spawn criteria
        -- and the potential target faction controls at least one of the target regions
        -- Note: We also make sure we are currently checking the target province so it doesn't get
        -- checked multiple times
        local validTarget = false;
        if narrativeData.SpawnData ~= nil
        and narrativeData.SpawnData.PREs ~= nil then
            for preKey, preData in pairs(narrativeData.SpawnData.PREs) do
                if preData.TargetOverrides ~= nil
                and preData.TargetOverrides.Region ~= nil then
                    local overrideRegion = preData.TargetOverrides.Region[self.MainController.CampaignName];
                    if overrideRegion ~= nil then
                        local targetRegion = cm:get_region(overrideRegion);
                        if targetRegion:owning_faction():name() == factionName then
                            validTarget = true;
                            break;
                        end
                    end
                else
                    validTarget = true;
                end
            end
        end

        if validTarget == true
        and narrativeData.SpawnCriteria ~= nil then
            local validNarrative = true;
            validNarrative = self:CheckFactionSpawnCriteria(narrativeKey, faction, "Faction", narrativeData.SpawnCriteria);
            if validNarrative == true then
                local foundValidRegion = false;
                local potentialSpawnRegions = {};
                for regionKey, regionData in pairs(factionRegions) do
                    if self:CheckRegionSpawnCriteria(narrativeKey, regionKey, "Faction", narrativeData.SpawnCriteria) == true then
                        foundValidRegion = true;
                        potentialSpawnRegions[regionKey] = true;
                    end
                end
                if foundValidRegion == true then
                    self.Logger:Log("Valid narrative: "..narrativeKey);
                    local spawnRegionKey = GetRandomObjectKeyFromList(potentialSpawnRegions);
                    validNarratives[narrativeKey] = {
                        SpawnRegionKey = spawnRegionKey,
                        NarrativeData = narrativeData,
                        Weighting = 10,
                    };
                end
            end
        end
    end
    return validNarratives;
end

function NarrativeController:CheckFactionSpawnCriteria(narrativeKey, faction, scope, spawnCriteria)
    local factionName = faction:name();
    local subcultureKey = faction:subculture();
    local turnNumber = cm:model():turn_number();
    -- Check the minimum turn needed for the narrative to be valid
    if spawnCriteria.MinimumTurn ~= nil
    and turnNumber < spawnCriteria.MinimumTurn then
        return false;
    end
    -- Check if the faction or subculture is excluded/included
    -- A faction needs to pass both of these checks
    if spawnCriteria.ExcludedFactions ~= nil then
        if spawnCriteria.ExcludedFactions[factionName] == true
        or spawnCriteria.ExcludedFactions[subcultureKey] == true then
            return false;
        end
    end
    if spawnCriteria.IncludedFactions ~= nil then
        if spawnCriteria.IncludedFactions[factionName] == false
        or spawnCriteria.IncludedFactions[subcultureKey] == false then
            return false;
        end
    end
    -- Some factions require another faction to be dead to spawn
    if spawnCriteria.RequiresDeadFaction ~= nil then
        for index, deadFactionKey in pairs(spawnCriteria.RequiresDeadFaction) do
            local deadFaction = cm:get_faction(deadFactionKey);
            if not deadFaction:is_dead() then
                return false;
            end
        end
    end
    -- We check if this is a unique narrative and that it hasn't occurred before.
    -- These unique events are special because they get stored in both the global and the scope
    -- narrative history
    if spawnCriteria.IsUnique == true then
        if self.PastNarratives.Global[narrativeKey] ~= nil then
            return false;
        end
    end
    -- Now we check the narrative history
    -- We check if it fulfills the timeout criteria
    if spawnCriteria.Timeout ~= nil
    and self.PastNarratives[scope] ~= nil then
        if scope == "Faction"
        and self.PastNarratives[scope][factionName] ~= nil then
            local history = self.PastNarratives[scope][factionName];
            for index, scopeNarrativeHistory in pairs(history) do
                if scopeNarrativeHistory.NarrativeKey == narrativeKey
                and scopeNarrativeHistory.TurnNumber + spawnCriteria.Timeout > turnNumber then
                    return false;
                end
            end
        end
    end
    return true;
end

function NarrativeController:CheckRegionSpawnCriteria(narrativeKey, regionKey, scope, spawnCriteria)
    local region = cm:get_region(regionKey);
    local regionName = region:name();
    local faction = region:owning_faction();
    local provinceKey = region:province_name();
    local settlement = region:settlement();
    local climateKey = settlement:get_climate();
    local income = region:town_wealth_growth();
    local turnNumber = cm:model():turn_number();
    local isHumanFaction = self.MainController.HumanFaction:name() == faction:name();
    if isHumanFaction == true then
        self.Logger:Log("Player region: "..regionName.." Climate: "..climateKey.." Income: "..income);
    end
    -- Check if the region has the minimum public order needed
    -- Note: If two factions own regions in the province, both will be checked
    if spawnCriteria.MinimumRequiredPublicOrder ~= nil
    and region:public_order() < spawnCriteria.MinimumRequiredPublicOrder then
        return false;
    end
    if spawnCriteria.ClimateSuitability ~= nil then
        if faction:get_climate_suitability(climateKey) ~= spawnCriteria.ClimateSuitability then
            return false;
        end
    end

    if spawnCriteria.MinimumIncome ~= nil
    and spawnCriteria.MinimumIncome < income then
        return false;
    end

    if spawnCriteria.ValidClimates ~= nil
    and TableHasKey(spawnCriteria.ValidClimates, climateKey) == false then
        return false;
    end

    -- Some spawns need to have a subculture in the rebellion map
    if spawnCriteria.UseProvinceRebellionMap ~= nil then
        local provinceResources = _G.ER:GetProvinceRebellionResources(provinceKey);
        if provinceResources == nil
        or provinceResources.RebelSubcultures[spawnCriteria.UseProvinceRebellionMap] == nil then
            return false;
        end
    end

    -- Now we check the narrative history
    -- We check if it fulfils the timeout criteria
    if spawnCriteria.Timeout ~= nil
    and self.PastNarratives[scope] ~= nil then
        if scope == "Province"
        and self.PastNarratives[scope][provinceKey] ~= nil then
            local history = self.PastNarratives[scope][provinceKey];
            for index, scopeNarrativeHistory in pairs(history) do
                if scopeNarrativeHistory.NarrativeKey == narrativeKey
                and scopeNarrativeHistory.TurnNumber + spawnCriteria.Timeout > turnNumber then
                    return false;
                end
            end
        end
    end
    return true;
end

function NarrativeController:StartNarrative(region, scope, narrativeData)
    if narrativeData.SpawnData ~= nil
    and narrativeData.SpawnData.PREs ~= nil then
        -- We need to start any PREs attached to the narrative and generate targets
        for preKey, narrativePREData in pairs(narrativeData.SpawnData.PREs) do
            local preResources = _G.ER:GetPREPoolDataResource(narrativePREData.SubcultureKey, preKey);
            local armyArchetypeKey = GetRandomObjectFromList(preResources.ArmyArchetypes);
            local armyArchetypeResources = _G.ER:GetArmyArchetypeData(preResources.PRESubculture, armyArchetypeKey);
            local preFactionKey = armyArchetypeResources.RebellionFaction;
            if armyArchetypeResources.RebellionFaction == nil then
                preFactionKey = _G.ER:GetRebellionFactionForSubculture(preResources.PRESubculture);
            end
            local preData = {
                PRESubcultureKey = narrativePREData.SubcultureKey,
                PREFactionKey = preFactionKey,
                PREData = preResources,
                Weighting = 10,
            };
            local targetRegion = region;
            if narrativePREData.TargetOverrides ~= nil then
                if narrativePREData.TargetOverrides.Region ~= nil then
                    local overrideRegion = narrativePREData.TargetOverrides.Region[self.MainController.CampaignName];
                    targetRegion = cm:get_region(overrideRegion);
                elseif narrativePREData.TargetOverrides.TargetAnyRegionInProvince == true then
                    local overrideRegion = _G.ER:GetRebellionRegionForNewRebellion(region);
                    targetRegion = cm:get_region(overrideRegion);
                end
            end
            _G.ER:AddPREToRegion(targetRegion, preKey, preData);
        end
        local historyKey = "";
        if scope == "Faction" then
            historyKey = region:owning_faction():name();
        elseif scope == "Province" then
            historyKey = region:province_name();
        end
        self:AddPastNarrative(region, scope, narrativeData, historyKey);
    end
end

function NarrativeController:AddPastNarrative(region, scope, narrativeData, key)
    local turnNumber = cm:model():turn_number();
    if scope == "Global" then
        self.PastNarratives.Global[narrativeData.Key] = {
            NarrativeKey = narrativeData.Key,
            TurnNumber = turnNumber;
        };
    elseif scope == "Faction"
    or scope == "Province" then
        if self.PastNarratives[scope][key] == nil then
            self.PastNarratives[scope][key] = {};
        end
        local pastNarrativesForScope = self.PastNarratives[scope][key];
        pastNarrativesForScope[#pastNarrativesForScope + 1] = {
            NarrativeKey = narrativeData.Key,
            TurnNumber = turnNumber,
        };
        if narrativeData.SpawnCriteria ~= nil
        and narrativeData.SpawnCriteria.IsUnique == true then
            self:AddPastNarrative(region, "Global", narrativeData);
        end
    elseif scope == "Region" then

    elseif scope == "MiltaryForce" then

    end
end