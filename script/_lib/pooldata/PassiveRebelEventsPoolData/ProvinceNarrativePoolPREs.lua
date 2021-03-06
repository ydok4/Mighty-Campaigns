function GetProvinceNarrativePREPoolDataResources()
    return {
        default = {
            GoblinRaids = {
                PRESubculture = "wh_main_sc_grn_greenskins",
                ArmyArchetypes = {"GoblinWolfRiderz", },
                CleanUpRebelForce = false,
                EffectBundleKey = "er_effect_bundle_generic_incursion_region",
                EffectBundleEffects = {
                    wh_main_effect_public_order_events = -5,
                },
                PREDuration = 3,
                InitialRebellionIncident = {
                    default = "mc_goblin_raids_1",
                },
                Incidents = {
                    default = {
                        mc_goblin_raids_0 = {
                            NumberOfTurns = 1,
                        }
                    },
                },
                TriggerArmySpawnWhenPREEnds = true,
            },
            NightGoblinRaids = {
                PRESubculture = "wh_main_sc_grn_greenskins",
                ArmyArchetypes = {"NightGoblinWarboss", },
                CleanUpRebelForce = false,
                EffectBundleKey = "er_effect_bundle_generic_incursion_region",
                EffectBundleEffects = {
                    wh_main_effect_public_order_events = -5,
                },
                PREDuration = 3,
                InitialRebellionIncident = {
                    default = "mc_night_goblin_raids_1",
                },
                Incidents = {
                    default = {
                        mc_night_goblin_raids_0 = {
                            NumberOfTurns = 1,
                        }
                    },
                },
                TriggerArmySpawnWhenPREEnds = true,
            },
        },
        -- Empire
        wh_main_sc_emp_empire = {

        },
    };
end