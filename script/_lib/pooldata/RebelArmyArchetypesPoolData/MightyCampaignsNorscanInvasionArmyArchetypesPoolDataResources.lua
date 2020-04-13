function GetMightyCampaignsNorscanInvasionArmyArchetypesPoolDataResources()
    return {
        wh_main_sc_nor_norsca = {
            ChieftainInvasionArmy = {
                AgentSubtypes = {"nor_marauder_chieftain",  },
                UnitTags = {"Warriors", "Horsemen", "WarBeasts", },
                Weighting = 1,
                CanSpawnOnSea = true,
                OverrideSpawnRegion = {
                    main_warhammer = "wh_main_peak_pass_gnashraks_lair",
                },
                OverrideTargetRegion = {
                    main_warhammer = "wh_main_peak_pass_karak_kadrin",
                },
            },
        },
    };
end