function GetDelayedStartPoolData()
    return {
        -- Beastmen
        wh_dlc03_bst_beastmen = {
        },
        -- Bretonnia
        wh2_dlc14_brt_chevaliers_de_lyonesse = {
            GrantTerritoryTo = {
                main_warhammer = "wh2_main_brt_knights_of_origo",
                wh2_main_great_vortex = "wh2_main_brt_knights_of_origo",
            },
        },
        -- High Elves
        -- Alith Anar
        wh2_main_hef_nagarythe = {
            GrantTerritoryTo = {
                main_warhammer = "wh2_main_def_bleak_holds",
                wh2_main_great_vortex = "wh2_main_def_karond_kar",
            },
        },
        -- Skaven
        wh2_dlc09_skv_clan_rictus = {
            GrantTerritoryTo = {
                main_warhammer = "wh2_main_def_the_forgebound",
                wh2_main_great_vortex = "wh2_main_def_the_forgebound",
            },
        },
        -- Vampirates
        -- Cylostra
        wh2_dlc11_cst_the_drowned = {
            GrantTerritoryTo = {
                main_warhammer = "wh2_main_grn_blue_vipers",
                wh2_main_great_vortex = "wh2_main_def_ssildra_tor",
            },
        },
        -- Aranessa
        wh2_dlc11_cst_pirates_of_sartosa = {
            --[[SpawnArmy = {
                FactionKey = "wh2_main_rogue_pirates_of_trantio",
            },--]]
            GrantTerritoryTo = {
                main_warhammer = "wh_main_teb_tilea",
                wh2_main_great_vortex = "wh_main_teb_tilea",
            },
        },
        -- Noctilus
        wh2_dlc11_cst_noctilus = {
            -- Excluded from being removed if the player is Vangheist (Mixu's mod)
            ExcludedIfPlayerFaction = { "wh2_main_cst_the_shadewraith", },
            AbandonTerritory = true,
        },
        -- Vlad
        wh_main_vmp_schwartzhafen = {
            GrantTerritoryTo = {
                main_warhammer = "wh_main_vmp_vampire_counts",
                wh2_main_great_vortex = "wh_main_vmp_vampire_counts",
            },
        },
        -- Vangheist
        wh2_main_cst_the_shadewraith = {
            -- Excluded from being removed if the player is Vangheist (Mixu's mod)
            ExcludedIfPlayerFaction = { "wh2_dlc11_cst_noctilus", },
            AbandonTerritory = true,
        },
        -- Public Order expanded testing
        --[[wh_main_brt_bretonnia = {
            AbandonTerritory = true,
        },
        wh2_main_def_naggarond = {
            AbandonTerritory = true,
        },
        wh_main_dwf_dwarfs = {
            AbandonTerritory = true,
        },
        wh_main_emp_empire = {
            AbandonTerritory = true,
        },
        wh_main_grn_greenskins = {
            AbandonTerritory = true,
        },
        wh2_main_hef_eataine = {
            AbandonTerritory = true,
        },
        wh2_main_lzd_hexoatl = {
            AbandonTerritory = true,
        },
        wh2_main_skv_clan_skyre = {
            AbandonTerritory = true,
        },
        wh2_dlc09_tmb_khemri = {
            AbandonTerritory = true,
        },
        wh_main_vmp_vampire_counts = {
            AbandonTerritory = true,
        },--]]
        --[[wh_main_brt_bretonnia = {
            GrantTerritoryTo = {
                main_warhammer = "wh_main_emp_marienburg",
            },
        },
        wh2_main_def_naggarond = {
            GrantTerritoryTo = {
                main_warhammer = "wh_main_emp_marienburg",
            },
        },
        wh_main_dwf_dwarfs = {
            GrantTerritoryTo = {
                main_warhammer = "wh_main_emp_marienburg",
            },
        },
        wh_main_emp_empire = {
            GrantTerritoryTo = {
                main_warhammer = "wh_main_emp_marienburg",
            },
        },
        wh_main_grn_greenskins = {
            GrantTerritoryTo = {
                main_warhammer = "wh_main_emp_marienburg",
            },
        },
        wh2_main_hef_eataine = {
            GrantTerritoryTo = {
                main_warhammer = "wh_main_emp_marienburg",
            },
        },
        wh2_main_lzd_hexoatl = {
            GrantTerritoryTo = {
                main_warhammer = "wh_main_emp_marienburg",
            },
        },
        wh2_main_skv_clan_skyre = {
            GrantTerritoryTo = {
                main_warhammer = "wh_main_emp_marienburg",
            },
        },
        wh2_dlc09_tmb_khemri = {
            GrantTerritoryTo = {
                main_warhammer = "wh_main_emp_marienburg",
            },
        },
        wh_main_vmp_vampire_counts = {
            GrantTerritoryTo = {
                main_warhammer = "wh_main_emp_marienburg",
            },
        },--]]
    };
end