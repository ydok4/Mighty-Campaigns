function GetGenericInvasionREPoolDataResources()
    return {
        default = {
            InvasionPeakPassNorsca = {
                MinimumRequiredPublicOrder = -99,
                PRESubculture = "wh_main_sc_nor_norsca",
                ArmyArchetypes = {"ChieftainStandardArmy", },
                CleanUpRebelForce = false,
                EffectBundleKey = "er_effect_bundle_generic_incursion_region",
                EffectBundleEffects = {
                    wh_main_effect_public_order_events = -5,
                },
                PREDuration = 8,
                InitialRebellionIncident = {
                    default = "poe_generic_incursion",
                },
                TriggerArmySpawnWhenPREEnds = true,
                IsRebelSpawnLocked = true,
                Incidents = {
                    default = {
                        mc_norsca_invasion_peak_pass_incident_1 = {
                            NumberOfTurns = 1,
                            SpawnArmyArchetype = true,
                            ArmyArchetypeSubcultures = {
                                wh_main_sc_grn_greenskins = {
                                    Weighting = 2,
                                    ArmyArchetypes = {
                                        OrcWarboss = {
                                            Weighting = 1,
                                        },
                                    },
                                },
                                wh_dlc03_sc_bst_beastmen = {
                                    Weighting = 2,
                                },
                                wh_main_sc_nor_norsca = {
                                    Weighting = 2,
                                },
                            },
                        },
                    },
                },
                AutoDilemmas = {
                    --[[default = {
                        wh2_main_dilemma_treasure_hunt_spider_nest = {
                            NumberOfTurns = 10,
                        },
                    },--]]
                },
                AgentDeployDilemmas = {
                    --[[default = {
                        wh2_main_dilemma_treasure_hunt_skaven_ambush = {
                            NumberOfTurns = 4,
                        },
                    },--]]
                },
                Weighting = 0,
            },
        },
    };
end