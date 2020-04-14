function GetFactionNarrativePoolArmyArchetypesPoolDataResources()
    return {
        wh_main_sc_vmp_vampire_counts = {
            -- Hexenasct armies
            HexensnactNecromancer = {
                AgentSubtypes = {
                    vmp_master_necromancer = {
                        AgentSubtypeKey = "vmp_master_necromancer",
                        AgentSubTypeMount = "wh_dlc04_anc_mount_vmp_master_necromancer_corpse_cart_balefire",
                    },
                },
                MandatoryUnits = {
                    wh_main_vmp_cav_hexwraiths = 1,
                },
                UnitTags = {"Chaff", "Beasts", "Spirits",},
                ArmySize = 12,
                Weighting = 0,
                CanSpawnOnSea = false,
            },
        },
    };
end