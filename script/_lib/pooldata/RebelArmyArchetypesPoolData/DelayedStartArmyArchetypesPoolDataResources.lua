function GetDelayedStartArmyArchetypesPoolDataResources()
    return {
        -- Beastmen
        wh_dlc03_sc_bst_beastmen = {
            DelayedStartKhazrak = {
                RebellionFaction = "wh_dlc03_bst_beastmen",
                SpawnWithExistingCharacter = true,
                AgentSubtypes = {
                    dlc03_bst_khazrak = {
                        AgentSubtypeKey = "dlc03_bst_khazrak",
                    },
                },
                MandatoryUnits = {
                    wh_dlc03_bst_inf_bestigor_herd_0 = 2,
                },
                UnitTags = {"Gors", "WarBeasts", "Centigors", },
                ArmySize = 18,
                Weighting = 0,
                CanSpawnOnSea = false,
                OverrideSpawnRegion = {
                    main_warhammer = { "wh_main_middenland_middenstag", },
                },
            },
            DelayedStartMalagor = {
                RebellionFaction = "wh_dlc03_bst_beastmen",
                -- NOTE: This will if CA gives him his own faction
                SpawnWithExistingCharacter = false,
                AgentSubtypes = {
                    dlc03_bst_malagor = {
                        AgentSubtypeKey = "dlc03_bst_malagor",
                    },
                },
                MandatoryUnits = {
                    wh_dlc03_bst_inf_bestigor_herd_0 = 2,
                },
                UnitTags = {"Gors", "WarBeasts", "Centigors", },
                ArmySize = 18,
                Weighting = 0,
                CanSpawnOnSea = false,
                OverrideSpawnRegion = {
                    main_warhammer = { "wh_main_southern_badlands_agrul_migdhal", },
                    wh2_main_great_vortex = { "wh2_main_vor_southern_badlands_gor_gazan", },
                },
            },
            DelayedStartMorghur = {
                RebellionFaction = "wh_dlc03_bst_beastmen",
                -- NOTE: This will if CA gives him his own faction
                SpawnWithExistingCharacter = false,
                AgentSubtypes = {
                    dlc05_bst_morghur = {
                        AgentSubtypeKey = "dlc05_bst_morghur",
                    },
                },
                MandatoryUnits = {
                    wh_dlc03_bst_inf_bestigor_herd_0 = 2,
                },
                UnitTags = {"Gors", "WarBeasts", "Centigors", },
                ArmySize = 18,
                Weighting = 0,
                CanSpawnOnSea = false,
                OverrideSpawnRegion = {
                    main_warhammer = { "wh_main_parravon_et_quenelles_quenelles", "wh_main_middenland_weismund", "wh_main_talabecland_kappelburg", "wh_main_wissenland_wissenburg", "wh_main_forest_of_arden_gisoreux", },
                },
            },
        },
        -- Brettonia
        wh_main_sc_brt_bretonnia = {
            DelayedStartRepanse = {
                RebellionFaction = "wh2_dlc14_brt_chevaliers_de_lyonesse",
                SpawnWithExistingCharacter = true,
                AgentSubtypes = {
                    wh2_dlc14_brt_repanse = {
                        AgentSubtypeKey = "wh2_dlc14_brt_repanse",
                        AgentSubTypeMount = "wh2_dlc14_anc_mount_brt_repanse_barded_warhorse",
                    },
                },
                MandatoryUnits = {
                    wh_dlc07_brt_cav_questing_knights_0 = 3,
                    wh_main_brt_art_field_trebuchet = 1,
                    wh_dlc07_brt_inf_foot_squires_0 = 2,
                    wh_main_brt_cav_grail_knights = 1,
                },
                UnitTags = {"Peasants", "MenAtArms", "Knights", },
                -- Needs a spot for Henri
                ArmySize = 18,
                Weighting = 0,
                CanSpawnOnSea = true,
                OverrideSpawnRegion = {
                    main_warhammer = { "wh2_main_coast_of_araby_copher", },
                    wh2_main_great_vortex = { "wh2_main_vor_coast_of_araby_copher", },
                },
            },
        },
        -- High Elves
        wh2_main_sc_hef_high_elves = {
            DelayedStartAlithAnar = {
                RebellionFaction = "wh2_main_hef_nagarythe",
                SpawnWithExistingCharacter = true,
                AgentSubtypes = {
                    wh2_dlc10_hef_alith_anar = {
                        AgentSubtypeKey = "wh2_dlc10_hef_alith_anar",
                    },
                },
                MandatoryUnits = {
                    wh2_dlc10_hef_inf_shadow_walkers_0 = 2,
                    wh2_main_hef_mon_great_eagle = 1,
                },
                UnitTags = {"Militia", "Cavalry", "ShadowWarriors", },
                ArmySize = 18,
                Weighting = 0,
                CanSpawnOnSea = false,
                OverrideSpawnRegion = {
                    main_warhammer = { "wh2_main_the_black_coast_arnheim", },
                    wh2_main_great_vortex = { "wh2_main_vor_the_broken_land_black_creek_spire", },
                },
            },
        },
        -- Skaven
        wh2_main_sc_skv_skaven = {
            DelayedStartTretchCravenTail = {
                RebellionFaction = "wh2_dlc09_skv_clan_rictus",
                SpawnWithExistingCharacter = true,
                AgentSubtypes = {
                    wh2_dlc09_skv_tretch_craventail = {
                        AgentSubtypeKey = "wh2_dlc09_skv_tretch_craventail",
                    },
                },
                MandatoryUnits = {
                    wh2_main_skv_inf_stormvermin_0 = 2,
                    wh2_main_skv_inf_stormvermin_1 = 2,
                },
                UnitTags = {"SkavenSlaves", "Warriors", { "ClanMoulder", "ClanSkyre", "ClanEshin", }, },
                ArmySize = 18,
                Weighting = 0,
                CanSpawnOnSea = false,
                OverrideSpawnRegion = {
                    main_warhammer = { "wh2_main_the_clawed_coast_hoteks_column", },
                    wh2_main_great_vortex = { "wh2_main_vor_the_clawed_coast_hoteks_column", },
                },
            },
        },
        -- Vampirates
        wh2_dlc11_sc_cst_vampire_coast = {
            DelayedStartCylostraDirefan = {
                RebellionFaction = "wh2_dlc11_cst_the_drowned",
                SpawnWithExistingCharacter = true,
                AgentSubtypes = {
                    wh2_dlc11_cst_cylostra = {
                        AgentSubtypeKey = "wh2_dlc11_cst_cylostra",
                    },
                },
                MandatoryUnits = {
                    wh2_dlc11_cst_inf_syreens = 1,
                    wh2_dlc11_cst_mon_mournguls_0 = 1,
                    wh2_dlc11_cst_art_carronade = 1,
                },
                UnitTags = {"Zombies", "Beasts", "Syreens", "Monsters", },
                -- Needs a spot for the Ghost Paladin
                ArmySize = 18,
                Weighting = 0,
                CanSpawnOnSea = true,
                OverrideSpawnRegion = {
                    main_warhammer = { "wh2_main_southern_jungle_of_pahualaxa_monument_of_the_moon", },
                    wh2_main_great_vortex = { "wh2_main_vor_grey_guardians_grey_rock_point", },
                },
            },
            DelayedStartAranessaSaltspite = {
                RebellionFaction = "wh2_dlc11_cst_pirates_of_sartosa",
                SpawnWithExistingCharacter = true,
                AgentSubtypes = {
                    wh2_dlc11_cst_aranessa = {
                        AgentSubtypeKey = "wh2_dlc11_cst_aranessa",
                    },
                },
                MandatoryUnits = {
                    wh2_dlc11_cst_mon_rotting_prometheans_0 = 1,
                    wh2_dlc11_cst_inf_zombie_gunnery_mob_3 = 1,
                    wh2_dlc11_cst_inf_sartosa_free_company_0 = 4,
                    wh2_dlc11_cst_art_carronade = 1,
                },
                UnitTags = {"Zombies", "Monsters", },
                ArmySize = 18,
                Weighting = 0,
                CanSpawnOnSea = true,
                OverrideSpawnRegion = {
                    main_warhammer = { "wh2_main_sartosa_sartosa", },
                    wh2_main_great_vortex = { "wh2_main_vor_sartosa_sartosa", },
                },
            },
            DelayedStartCountNoctilus = {
                RebellionFaction = "wh2_dlc11_cst_noctilus",
                SpawnWithExistingCharacter = true,
                AgentSubtypes = {
                    wh2_dlc11_cst_noctilus = {
                        AgentSubtypeKey = "wh2_dlc11_cst_noctilus",
                    },
                },
                MandatoryUnits = {
                    wh2_dlc11_cst_mon_necrofex_colossus_0 = 1,
                    wh2_dlc11_cst_inf_depth_guard_0 = 1,
                    wh2_dlc11_cst_art_carronade = 1,
                },
                UnitTags = {"Zombies", "Beasts", "Syreens", "Monsters", },
                ArmySize = 18,
                Weighting = 0,
                CanSpawnOnSea = true,
                OverrideSpawnRegion = {
                    main_warhammer = { "wh2_main_the_galleons_graveyard", },
                    wh2_main_great_vortex = { "wh2_main_vor_the_galleons_graveyard", },
                },
            },
        },
    };
end

