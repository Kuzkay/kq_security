Config = {}

Config.debug = false

--- SETTINGS FOR ESX
Config.esxSettings = {
    enabled = true,
    -- Whether or not to use the new ESX export method
    useNewESXExport = true,
}

--- SETTINGS FOR QBCORE
Config.qbSettings = {
    enabled = false,
}

--- IF USING A STANDALONE SOLUTION. SIMPLY DISABLE BOTH FRAMEWORKS



-- https://docs.fivem.net/docs/game-references/controls/
-- Use the input index for the "input" value
Config.keybinds = {
    debug = {
        label = 'E',
        name = 'INPUT_PICKUP',
        input = 38,
    },
}


------------------------------------------
--- LASERS
------------------------------------------

Config.laser = {
    -- Overal maximum render distance for all lasers
    maxRenderDistance = 50.0,
    
    -- Laser prop
    prop = {
        -- Whether to use the laser prop
        enabled = true,
        -- The prop model
        model = 'w_at_sr_supp_2',
        -- The prop offset
        offset = vector3(-0.022, 0.0, 0.0),
        -- The prop rotation offset
        rotation = vector3(0.0, 180.0, 0.0),
    },
    -- All lasers
    -- Please refer to the documentation.md file to learn more.
    lasers = {
        ['test'] = {
            origin = vector3(-924.9017, -2946.101, 13.738),
            endPointA = vector3(-920.802, -2949.351, 14.820),
            endPointB = vector3(-920.827, -2949.336, 13.322),

            color = { r = 0, g = 255, b = 21, a = 200 },

            speed = 0.5,
            maxLength = 7.0,

            damage = 5,
            ragdoll = true,

            triggers = {
                {
                    event = 'kq_security:dispatch:client:trigger',
                    type = 'client',
                    parameters = {
                        title = 'Laser tripped!',
                        message = 'a security laser at the LSIA has been tripped.',
                        jobs = { 'police' },
                    },
                }
            }
        },
        ['test2'] = {
            origin = vector3(-921.998, -2951.743, 14.3),
            endPoint = vector3(-926.485, -2948.844, 14.3),

            color = { r = 0, g = 255, b = 21, a = 200 },

            maxLength = 7.0,

            cooldown = 5000,

            alarms = { 'lsia' },
        },
        ['bank'] = {
            origin = vector3(250.4, 222.0, 101.48),
            endPoint = vector3(254.83, 220.50, 101.48),

            color = { r = 255, g = 50, b = 50, a = 200 },

            maxLength = 6.0,
            
            alarms = { 'bank', 'bank2' },
            
            cooldown = 5000,
        },
        ['bank2'] = {
            origin = vector3(256.69, 219.04, 103.21),
            endPointA = vector3(255.85, 215.09, 100.84),
            endPointB = vector3(255.81, 215.10, 102.70),

            color = { r = 255, g = 50, b = 50, a = 200 },

            maxLength = 6.0,
            
            alarms = { 'bank', 'bank2' },
            
            cooldown = 5000,
        },
        ['example_handler'] = {
            origin = vector3(573.30, -3116.0, 18.6),
            endPoint = vector3(573.61, -3119.74, 18.61),
            
            color = { r = 255, g = 50, b = 50, a = 200 },
            
            maxLength = 8.0,
            
            cooldown = 50000,
            
            -- This is an example of a handler which spawns enemies after the laser is triggered
            handler = function()
                local model = 'csb_mweather'
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(1)
                end
                
                local ped = CreatePed(0, model, vector3(582.06, -3118.0, 18.7), 90.0, true, false)
                SetModelAsNoLongerNeeded(model)
                
                GiveWeaponToPed(ped, 'WEAPON_APPISTOL', 60, false, true)
                SetPedCombatAbility(ped, 1)
                
                TaskCombatPed(ped, PlayerPedId(), 0, 16)
            end
        },
    }
}


------------------------------------------
--- ALARM
------------------------------------------

Config.alarm = {
    -- Models for the alarms
    models = {
        -- prop for alarms that are not enabled
        off = 'hei_prop_wall_alarm_off',
        -- prop for alarms which are turned on
        on = 'hei_prop_wall_alarm_on',
    },
    
    -- All alarms
    -- Please refer to the documentation.md file to learn more.
    alarms = {
        ['lsia'] = {
            coords = vector3(-927.49, -2950.59, 16.13),
            rotation = vector3(0.0, 0.0, 60.0),
            duration = 55,

            sound = true,

            light = {
                rgb = { 100, 0, 0 },
                range = 15.0,
                intensity = 5.0,
            }
        },
        ['bank'] = {
            coords = vector3(244.85, 209.00, 107.89),
            rotation = vector3(0.0, 0.0, 170.0),
            duration = 90,

            sound = true,

            light = {
                rgb = { 100, 0, 0 },
                range = 15.0,
                intensity = 5.0,
            }
        },
        ['bank2'] = {
            coords = vector3(249.82, 223.16, 109.44),
            rotation = vector3(0.0, 0.0, 246.0),
            duration = 90,

            sound = true,

            light = {
                rgb = { 100, 0, 0 },
                range = 15.0,
                intensity = 5.0,
            }
        },
        ['pd'] = {
            coords = vector3(452.91, -983.67, 32.20),
            rotation = vector3(0.0, 0.0, 270.0),
            duration = 90,

            sound = true,

            light = {
                rgb = { 100, 0, 0 },
                range = 15.0,
                intensity = 5.0,
            }
        }
    }
}


------------------------------------------
--- CONTROLLER
------------------------------------------

Config.controller = {
    -- Model for the keypad
    model = 'ch_prop_casino_keypad_01',

    -- Hacking difficulty
    hacking = {
        -- amount of games/screens players need to finish to successfully hack a controller
        gamesToWin = 2,
        -- the time in seconds players get to perform the hack
        time = 30,
    },

    -- Command used for hacking. Necessary when using a standalone solution
    command = {
        enabled = true,
        command = 'hack',
    },
    
    
    -- All controllers
    -- Please refer to the documentation.md file to learn more.
    controllers = {
        ['lsia'] = {
            coords = vector3(-930.23, -2955.70, 14.2),
            rotation = vector3(0.0, 0.0, 60.0),

            lasers = {
                'test',
                'test2',
            },

            hacking = {
                hackable = true,

                -- Items are only used for ESX or QBCORE.
                -- When using command, all controllers can be hacked using the command
                hackItems = { 'kq_hacker_usb' },

                disableLasers = true,
                duration = 10000,

                successHandler = function() end,
                failureHandler = function() end,
            },
        },
        ['pd'] = {
            coords = vector3(452.91, -981.69, 31.0),
            rotation = vector3(0.0, 0.0, 270.0),

            hacking = {
                hackable = true,

                -- Items are only used for ESX or QBCORE.
                -- When using command, all controllers can be hacked using the command
                hackItems = { 'kq_hacker_usb' },

                duration = 10000,

                successHandler = function() end,
                failureHandler = function()
                    -- Example of the failure handler triggering an alarm
                    -- Read the documentation file to learn more
                    TriggerServerEvent('kq_security:alarm:server:trigger', {
                        alarms = {'pd'}
                    })
                end,
            },
        }
    }
}


------------------------------------------
--- DISPATCH
------------------------------------------

Config.dispatch = {
    system = 'default',   -- Setting for the dispatch system to use ('default' for the built-in system or 'cd-dispatch', 'core-dispatch-old', 'core-dispatch-new' or 'ps-dispatch' for external systems)

    globalCooldown = 30,  -- The global cooldown in seconds
    blip = {
        sprite = 788,     -- Sprite for the blip
        color = 75,       -- Color for the blip
        scale = 1.0,      -- Scale for the blip

        timeout = 60,     -- Time in seconds for the blip to disappear

        showRadar = true, -- Setting to show the radar blip on the radar
    },
}
