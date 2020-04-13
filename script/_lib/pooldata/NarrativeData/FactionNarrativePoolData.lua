function GetFactionNarrativePoolData()
    return {
        default = {
            -- Beastmen
            DelayedStartKhazrak = {
                Key = "DelayedStartKhazrak",
                PlayerOnly = false,
                Tags = {"delayedstart", "beastmen", },
                SpawnCriteria = {
                    MinimumRequiredPublicOrder = 0,
                    MinimumTurn = 100,
                    IsUnique = true,
                },
                SpawnData = {
                    PREs = {
                        DelayedStartKhazrak = {
                            SubcultureKey = "wh_dlc03_sc_bst_beastmen",
                            TargetOverrides = {
                                Region = {
                                    main_warhammer = "wh_main_middenland_middenheim",
                                },
                                TargetAnyRegionInProvince = false,
                            },
                        },
                    },
                },
            },
            -- Bretonnia
            DelayedStartRepanse = {
                Key = "DelayedStartRepanse",
                PlayerOnly = false,
                Tags = {"delayedstart", "bretonnia", },
                SpawnCriteria = {
                    MinimumRequiredPublicOrder = -99,
                    MinimumTurn = 0,
                    IsUnique = true,
                },
                SpawnData = {
                    PREs = {
                        DelayedStartRepanse = {
                            SubcultureKey = "wh_main_sc_brt_bretonnia",
                            TargetOverrides = {
                                Region = {
                                    main_warhammer = "wh2_main_coast_of_araby_copher",
                                    wh2_main_great_vortex = "wh2_main_vor_coast_of_araby_copher",
                                },
                                TargetAnyRegionInProvince = false,
                            },
                        },
                    },
                },
            },

            -- High Elves
            DelayedStartAlithAnar = {
                Key = "DelayedStartAlithAnar",
                PlayerOnly = false,
                Tags = {"delayedstart", "highelves", },
                SpawnCriteria = {
                    MinimumRequiredPublicOrder = 25,
                    MinimumTurn = 100,
                    IsUnique = true,
                },
                SpawnData = {
                    PREs = {
                        DelayedStartAlithAnar = {
                            SubcultureKey = "wh2_main_sc_hef_high_elves",
                            TargetOverrides = {
                                Region = {
                                    main_warhammer = "wh2_main_the_black_coast_arnheim",
                                    wh2_main_great_vortex = "wh2_main_vor_the_broken_land_black_creek_spire",
                                },
                                TargetAnyRegionInProvince = false,
                            },
                        },
                    },
                },
            },

            -- Skaven
            DelayedStartTretchCravenTail = {
                Key = "DelayedStartTretchCravenTail",
                PlayerOnly = false,
                Tags = {"delayedstart", "skaven", },
                SpawnCriteria = {
                    MinimumRequiredPublicOrder = 50,
                    MinimumTurn = 60,
                    IsUnique = true,
                },
                SpawnData = {
                    PREs = {
                        DelayedStartTretchCravenTail = {
                            SubcultureKey = "wh2_main_sc_skv_skaven",
                            TargetOverrides = {
                                Region = {
                                    main_warhammer = "wh2_main_the_clawed_coast_hoteks_column",
                                    wh2_main_great_vortex = "wh2_main_vor_the_clawed_coast_hoteks_column",
                                },
                                TargetAnyRegionInProvince = false,
                            },
                        },
                    },
                },
            },

            -- Vampirates
            DelayedStartCylostraDirefan = {
                Key = "DelayedStartCylostraDirefan",
                PlayerOnly = false,
                Tags = {"delayedstart", "vampirates", },
                SpawnCriteria = {
                    MinimumRequiredPublicOrder = 50,
                    MinimumTurn = 60,
                    IsUnique = true,
                },
                SpawnData = {
                    PREs = {
                        DelayedStartCylostraDirefan = {
                            SubcultureKey = "wh2_dlc11_sc_cst_vampire_coast",
                            TargetOverrides = {
                                Region = {
                                    main_warhammer = "wh2_main_southern_jungle_of_pahualaxa_monument_of_the_moon",
                                    wh2_main_great_vortex = "wh2_main_vor_grey_guardians_grey_rock_point",
                                },
                                TargetAnyRegionInProvince = false,
                            },
                        },
                    },
                },
            },
            DelayedStartAranessaSaltspite = {
                Key = "DelayedStartAranessaSaltspite",
                PlayerOnly = false,
                Tags = {"delayedstart", "vampirates", },
                SpawnCriteria = {
                    MinimumRequiredPublicOrder = 0,
                    MinimumTurn = 80,
                    IsUnique = true,
                },
                SpawnData = {
                    PREs = {
                        DelayedStartAranessaSaltspite = {
                            SubcultureKey = "wh2_dlc11_sc_cst_vampire_coast",
                            TargetOverrides = {
                                Region = {
                                    main_warhammer = "wh2_main_sartosa_sartosa",
                                    wh2_main_great_vortex = "wh2_main_vor_sartosa_sartosa",
                                },
                                TargetAnyRegionInProvince = false,
                            },
                        },
                    },
                },
            },
            DelayedStartCountNoctilus = {
                Key = "DelayedStartCountNoctilus",
                PlayerOnly = false,
                Tags = {"delayedstart", "vampirates", },
                SpawnCriteria = {
                    MinimumRequiredPublicOrder = -99,
                    MinimumTurn = 70,
                    IsUnique = true,
                },
                SpawnData = {
                    PREs = {
                        DelayedStartCountNoctilus = {
                            SubcultureKey = "wh2_dlc11_sc_cst_vampire_coast",
                            TargetOverrides = {
                                Region = {
                                    main_warhammer = "wh2_main_the_galleons_graveyard",
                                    wh2_main_great_vortex = "wh2_main_vor_the_galleons_graveyard",
                                },
                                TargetAnyRegionInProvince = false,
                            },
                        },
                    },
                },
            },

            -- Generic greenskin
            mc_greenskin_invasion = {
                PlayerOnly = false,
            },
            mc_norscan_invasion = {
                PlayerOnly = false,
            },
            

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