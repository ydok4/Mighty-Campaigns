function GetProvinceNarrativePoolData()
    return {
        default = {
            mc_goblin_raids = {
                Key = "mc_goblin_raids",
                PlayerOnly = false,
                Tags = {"incursion", "greenskin", },
                SpawnCriteria = {
                    ExcludedFactions = nil,
                    IncludedFactions = nil,
                    RequiresDeadFactions = nil,
                    UseProvinceRebellionMap = "wh_main_sc_grn_greenskins",
                    MinimumRequiredPublicOrder = 20,
                    IsUnique = false,
                    Timeout = 10,
                },
                SpawnData = {
                    PREs = {
                        GoblinRaids = {
                            SubcultureKey = "wh_main_sc_grn_greenskins",
                            TargetOverrides = {
                                Region = nil,
                                TargetAnyRegionInProvince = true,
                            },
                        },
                    },
                },
            },
            mc_night_goblin_raids = {

            },
            mc_orc_raids = {

            },
            mc_savage_orc_raids = {

            },

            wh_main_incident_all_beastmen_raids = {
                PlayerOnly = false,
            },
        },
    };
end