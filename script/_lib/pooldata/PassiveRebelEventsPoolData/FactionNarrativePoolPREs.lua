function GetFactionNarrativePREPoolDataResources()
    return {
        default = {

        },
        -- Empire
        wh_main_sc_vmp_vampire_counts = {
            HexensnachtNecromancer = {
                PRESubculture = "wh_main_sc_vmp_vampire_counts",
                ArmyArchetypes = {"HexensnactNecromancer", },
                CleanUpRebelForce = true,
                ArmySpawnChance = 10,
                AllowedNumberOfRandomSpawns = 1,
                EffectBundleKey = "er_effect_bundle_generic_incursion_region",
                EffectBundleEffects = {
                    wh_main_effect_public_order_events = -10,
                },
                PREDuration = 5,
                InitialRebellionIncident = {
                    default = "mc_hexensnact_necromancer_0",
                },
                Incidents = {
                    default = {
                        mc_hexensnact_0 = {
                            NumberOfTurns = 1,
                        },
                        mc_hexensnact_1 = {
                            NumberOfTurns = 4,
                        }
                    },
                },
                CleanupForcesWhenPREEnds = true,
                IsRebelSpawnLocked = true,
            },
        },
    };
end