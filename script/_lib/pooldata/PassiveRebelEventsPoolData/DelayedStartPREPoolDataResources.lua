function GetDelayedStartPREPoolDataResources()
    return {
        default = {
            -- Beastmen
            DelayedStartKhazrak = {
                PRESubculture = "wh_dlc03_sc_bst_beastmen",
                ArmyArchetypes = {"DelayedStartKhazrak", },
                CleanUpRebelForce = false,
                EffectBundleKey = nil,
                EffectBundleEffects = {
                },
                PREDuration = 20,
                InitialRebellionIncident = {
                    default = "poe_generic_incursion",
                },
                TriggerArmySpawnWhenPREEnds = true,
            },
            --[[DelayedStartMalagor = {
                MinimumRequiredPublicOrder = 0,
                MinimumTurn = 120,
                TriggerCritieria = {
                    IsUnique = true,
                },
                PRESubculture = "wh_dlc03_sc_bst_beastmen",
                ArmyArchetypes = {"DelayedStartMalagor", },
                CleanUpRebelForce = false,
                EffectBundleKey = nil,
                EffectBundleEffects = {
                },
                PREDuration = 10,
                InitialRebellionIncident = {
                    default = "poe_generic_incursion",
                },
                TriggerArmySpawnWhenPREEnds = true,
            },
            DelayedStartMorghur = {
                MinimumRequiredPublicOrder = 50,
                MinimumTurn = 40,
                TriggerCritieria = {
                    Timeout = 20,
                    UniqueArmyArchetype = true,
                },
                PRESubculture = "wh_dlc03_sc_bst_beastmen",
                ArmyArchetypes = {"DelayedStartMorghur", },
                CleanUpRebelForce = false,
                EffectBundleKey = nil,
                EffectBundleEffects = {
                },
                PREDuration = 5,
                InitialRebellionIncident = {
                    default = "poe_generic_incursion",
                },
                TriggerArmySpawnWhenPREEnds = true,
            },--]]
            -- Bretonnia
            DelayedStartRepanse = {
                PRESubculture = "wh_main_sc_brt_bretonnia",
                ArmyArchetypes = {"DelayedStartRepanse", },
                CleanUpRebelForce = false,
                EffectBundleKey = nil,
                EffectBundleEffects = {
                },
                PREDuration = 5,
                InitialRebellionIncident = {
                    default = "poe_generic_incursion",
                },
                TriggerArmySpawnWhenPREEnds = true,
            },
            -- High Elves
            DelayedStartAlithAnar = {
                PRESubculture = "wh2_main_sc_hef_high_elves",
                ArmyArchetypes = {"DelayedStartAlithAnar", },
                CleanUpRebelForce = false,
                EffectBundleKey = nil,
                EffectBundleEffects = {
                },
                PREDuration = 5,
                InitialRebellionIncident = {
                    default = "poe_generic_incursion",
                },
                TriggerArmySpawnWhenPREEnds = true,
            },
            -- Skaven
            DelayedStartTretchCravenTail = {
                MinimumRequiredPublicOrder = 50,
                MinimumTurn = 60,
                TriggerCritieria = {
                    IsUnique = true,
                },
                PRESubculture = "wh2_main_sc_skv_skaven",
                ArmyArchetypes = {"DelayedStartTretchCravenTail", },
                CleanUpRebelForce = false,
                EffectBundleKey = nil,
                EffectBundleEffects = {
                },
                PREDuration = 5,
                InitialRebellionIncident = {
                    default = "poe_generic_incursion",
                },
                TriggerArmySpawnWhenPREEnds = true,
            },
            -- Vampirates
            DelayedStartCylostraDirefan = {
                PRESubculture = "wh2_dlc11_sc_cst_vampire_coast",
                ArmyArchetypes = {"DelayedStartCylostraDirefan", },
                CleanUpRebelForce = false,
                EffectBundleKey = nil,
                EffectBundleEffects = {
                },
                PREDuration = 5,
                InitialRebellionIncident = {
                    default = "poe_generic_incursion",
                },
                TriggerArmySpawnWhenPREEnds = true,
            },
            DelayedStartAranessaSaltspite = {
                PRESubculture = "wh2_dlc11_sc_cst_vampire_coast",
                ArmyArchetypes = {"DelayedStartAranessaSaltspite", },
                CleanUpRebelForce = false,
                EffectBundleKey = nil,
                EffectBundleEffects = {
                },
                PREDuration = 5,
                InitialRebellionIncident = {
                    default = "poe_generic_incursion",
                },
                TriggerArmySpawnWhenPREEnds = true,
            },
            DelayedStartCountNoctilus = {
                PRESubculture = "wh2_dlc11_sc_cst_vampire_coast",
                ArmyArchetypes = {"DelayedStartCountNoctilus", },
                CleanUpRebelForce = false,
                EffectBundleKey = nil,
                EffectBundleEffects = {
                },
                PREDuration = 25,
                InitialRebellionIncident = {
                    default = "poe_generic_incursion",
                },
                TriggerArmySpawnWhenPREEnds = true,
            },
        },
    };
end