function GetGlobalNarrativePoolData()
    return {
        default = {
            wh_main_incident_all_abandoned_settlement = {
                PlayerOnly = true,
                SpawnCriteria = {
                    ExcludedFactions = { "wh2_main_sc_skv_skaven", },
                },
                SpawnTargets = {
                    "region",
                },
                SpawnPREs = {
                    
                },
            },
        },
    };
end