_G.MCResources = {
    DelayedStartResources = {},
};

-- Generic invasion resources
--[[require 'script/_lib/pooldata/ProvinceSubcultureRebellionsPoolData/MightyCampaignsProvinceSubcultureRebellionsPoolDataResources'

_G.ERResources.AddAdditionalProvinceRebellionResources(GetMightyCampaignsProvinceSubcultureRebellionsPoolDataResources());

require 'script/_lib/pooldata/RebelArmyArchetypesPoolData/MightyCampaignsNorscanInvasionArmyArchetypesPoolDataResources'

_G.ERResources.AddAdditionalRebelArmyArchetypesResources("wh_main_sc_nor_norsca", GetMightyCampaignsNorscanInvasionArmyArchetypesPoolDataResources(), false);

require 'script/_lib/pooldata/PassiveRebelEventsPoolData/GenericInvasionPREPoolDataResources'

_G.ERResources.AddAdditionalPassiveRebelEventResources(GetGenericInvasionREPoolDataResources());--]]

-- Delayed start resources
require 'script/_lib/pooldata/DelayedStartPoolData/DelayedStartPoolData'
_G.MCResources.DelayedStartResources = GetDelayedStartPoolData();


-- Delayed start PRE resources
require 'script/_lib/pooldata/PassiveRebelEventsPoolData/DelayedStartPREPoolDataResources'
_G.ERResources.AddAdditionalPassiveRebelEventResources(GetDelayedStartPREPoolDataResources());
-- Delayed Start army archetypes
require 'script/_lib/pooldata/RebelArmyArchetypesPoolData/DelayedStartArmyArchetypesPoolDataResources'
require 'script/_lib/core/helpers/ER_DataHelpers';
local delayedStartResources = GetDelayedStartArmyArchetypesPoolDataResources();
for subcultureKey, subcultureData in pairs(delayedStartResources) do
    _G.ERResources.AddAdditionalRebelArmyArchetypesResources(subcultureKey, subcultureData, false);
end
-- Delayed start province resources
--[[require 'script/_lib/pooldata/ProvinceSubcultureRebellionsPoolData/DelayedStartProvincePoolDataResources'
_G.ERResources.AddAdditionalProvinceRebellionResources(GetDelayedStartProvincePoolDataResources());--]]

-- Narrative resources
-- PREs
require 'script/_lib/pooldata/PassiveRebelEventsPoolData/GlobalNarrativePoolPREs'
_G.ERResources.AddAdditionalPassiveRebelEventResources(GetGlobalNarrativePREPoolDataResources());
require 'script/_lib/pooldata/PassiveRebelEventsPoolData/FactionNarrativePoolPREs'
_G.ERResources.AddAdditionalPassiveRebelEventResources(GetFactionNarrativePREPoolDataResources());
require 'script/_lib/pooldata/PassiveRebelEventsPoolData/ProvinceNarrativePoolPREs'
_G.ERResources.AddAdditionalPassiveRebelEventResources(GetProvinceNarrativePREPoolDataResources());
--Army archetypes
require 'script/_lib/pooldata/RebelArmyArchetypesPoolData/FactionNarrativePoolArmyArchetypesPoolDataResources'
local factionNarrativeArmyArchetypes = GetFactionNarrativePoolArmyArchetypesPoolDataResources();
for subcultureKey, subcultureData in pairs(factionNarrativeArmyArchetypes) do
    _G.ERResources.AddAdditionalRebelArmyArchetypesResources(subcultureKey, subcultureData, false);
end