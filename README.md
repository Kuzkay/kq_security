# KuzQuality Security toolkit | Docs

___

## Intro | Entity types

### Laser
A line between two points. Detects anything which breaks the line between said points.
When the line between the points is broken, events or callbacks can be triggered.
Lasers can be oscillating between two end points as well. The color and opacity of the lasers can be adjusted
dynamically. 

### Controller
A hackable controller panel which has the ability to temporarily disable defined lasers or trigger a
callback function; on both: success and failure.

### Alarm
An auditory and visual alarm. Once triggered it will play off an alarm sound and flash lights for a defined duration.

___

## Usage | Basics

To call the exported functions, use the FiveM exports.

**Example**
`exports['kq_security']:CreateLaser(name, data)`

___
## Basic usage | Lasers

### Laser properties
> - origin - vector3*
>   -  The starting point of the laser
> - endPoint - vector3
>   - The end point of the laser
> - endPointA - vector3
>   - The primary endpoint of a laser. Used for moving lasers. Always used in combination with endPointB
> - endPointB - vector3
>   - The secondary endpoint of a laser. Used for moving lasers. Always used in combination with endPointA
> - color - table
>   - A table containing the rgba values of the laser color. e.g `{r = 255, g = 0, b = 0, a = 255}`
> - speed - float
>   - Movement speed of the laser. Only used for moving lasers
> - maxLength - float*
>   - Max length of the laser
> - damage - int
>   - Amount of damage that the laser should deal
> - ragdoll - boolean
>   - Whether the laser should make players ragdoll on hit
> - handler - function/callback
>   - Callback function triggered upon laser trigger
> - triggers - table
>   - A custom table containing events which will be triggered upon laser trigger
>   - See below for an example table
> - alarms - table
>   - Table with the names of the alarms which the laser will trigger
> - cooldown - int
>   - Cooldown duration in milliseconds; aka, time between each laser trigger event
> - active - boolean
>   - Whether the laser should be active upon creation
>   
> (* = Required)

**Example:**

```lua
local data = {
    origin = vector3(-924.9017, -2946.101, 13.738),
    endPointA = vector3(-920.802, -2949.351, 14.820),
    endPointB = vector3(-920.827, -2949.336, 13.322),

    color = { r = 0, g = 255, b = 21, a = 100 },

    speed = 0.5,
    maxLength = 15.0,

    damage = 5,
    ragdoll = true,

    alarms = { 'lsia' },

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
```

### Laser event triggers
As seen above, lasers can trigger events upon trigger.
See below to find out more about the structure of these events
> Triggers is a table of multiple event triggers. These should contain the following values:
> - event - string
>   - the event name which should be triggered
> - type - string - options: server, client
>   - The network type of the event
> - parameters - table
>   - Parameters which will be sent in the event as its parameters

**Example:**
```lua
data.triggers = {
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
```


### Create
Used for creating a new laser
> `CreateLaser(name, data)`
>
> **Arguments**
> - Name - String - Unique key of the laser
> - Data - Table - Table containing all laser properties
> 
> **Returns**
> - Laser object - This object can be used to manipulate the laser after its creation

### Getting the list of all lasers
> `GetAllLasers()`
>
> **Returns**
> - Table of all laser objects

### Getting a laser by its name
> `GetLaserByName(name)`
>
> **Arguments**
> - Name - String - Name of the laser you're trying to retrieve
> 
> **Returns**
> - Laser object

### Getting the nearest laser
> `GetNearestLaser(coords, maxDistance)`
> 
> **Arguments**
> - Coords - vector3 - The location from which you're trying to find the nearest laser
> - MaxDistance - float - The maximum distance in meters in which you're looking for a laser
> 
> **Returns**
> - Laser object
> - Distance to the laser
> > Returns `nil` when nothing is found

___
## Basic usage | Controllers

### Controller properties
> - coords - vector3*
>   - The location of the controller
> - rotation - vector3*
>   - The rotation of the controller
> - lasers - table
>   - The table containing laser names which will be affected upon hacking
> - hacking - table*
>   - A table containing the following values:
>     - hackable - boolean*
>       - Whether the controller should be hackable
>     - disableLasers - boolean*
>       - Whether the controller should disable the lasers upon hacking
>     - duration - int*
>       - Duration of the lasers outage in milliseconds
>     - hackItems - table of items*
>       - List of item names which are able to be used as the hacking tool
>     - successHandler - function/callback
>       - The callback which will be called upon a successful hack of the controller
>     - failureHandler - function/callback
>       - The callback which will be called upon a failure to hack the controller
> 
> (* = Required)

**Example data**
```lua
local data = {
    coords = vector3(-930.23, -2955.70, 14.2),
    rotation = vector3(0.0, 0.0, 60.0),

    lasers = {
        'myLaser',
        'myAnotherLaser',
    },

    hacking = {
        hackable = true,

        disableLasers = true,
        duration = 10000,
        
        -- Items are only used for ESX or QBCORE.
        -- When using command, all controllers can be hacked using the command
        hackItems = { 'kq_hacker_usb' },
        
        successHandler = function() print('I was hacked') end,
        failureHandler = function() print('I survived the attack') end,
    },
}
```


### Create
Used for creating a new controller
> `CreateController(name, data)`
>
> **Arguments**
> - Name - String - Unique key of the controller
> - Data - Table - Table containing all controller properties
> 
> **Returns**
> - Controller object - This object can be used to manipulate the controller after its creation

### Getting the list of all controllers
> `GetAllControllers()`
>
> **Returns**
> - Table of all controller objects

### Getting a controller by its name
> `GetControllerByName(name)`
>
> **Arguments**
> - Name - String - Name of the controller you're trying to retrieve
> 
> **Returns**
> - Controller object

### Getting the nearest controller
> `GetNearestController(coords, maxDistance)`
> 
> **Arguments**
> - Coords - vector3 - The location from which you're trying to find the nearest controller
> - MaxDistance - float - The maximum distance in meters in which you're looking for a controller
> 
> **Returns**
> - Controller object
> - Distance to the controller
> > Returns `nil` when nothing is fo
___
## Basic usage | Alarms

### Alarm properties
> - coords - vector3*
>   - The location of the controller
> - rotation - vector3*
>   - The rotation of the controller
> - duration - number*
>   - Duration of how long the alarm will be going off for in seconds
> - sound - boolean*
>   - Whether the alarm should emit sound
> - light - table*
>   - A table containing the following values
>     - rgb - table
>       - A table containing the rgb values of the light. e.g. `{100, 0, 0}`
>     - range - float
>       - Range/size of the light in meters
>     - intensity - float
>       - Intensity of the emitted light
> 
> 
> (* = Required)

**Example data**
```lua
local data = {
    coords = vector3(-927.49, -2950.59, 16.13),
    rotation = vector3(0.0, 0.0, 60.0),
    duration = 15,

    sound = true,

    light = {
        rgb = { 100, 0, 0 },
        range = 15.0,
        intensity = 5.0,
    }
}
```


### Create
Used for creating a new alarm
> `CreateAlarm(name, data)`
>
> **Arguments**
> - Name - String - Unique key of the alarm
> - Data - Table - Table containing all alarm properties
> 
> **Returns**
> - Alarm object - This object can be used to manipulate the alarm after its creation

### Getting the list of all alarms
> `GetAllAlarms()`
>
> **Returns**
> - Table of all alarm objects

### Getting an alarm by its name
> `GetAlarmByName(name)`
>
> **Arguments**
> - Name - String - Name of the alarm you're trying to retrieve
> 
> **Returns**
> - Alarm object

### Getting the nearest alarm
> `GetNearestAlarm(coords, maxDistance)`
> 
> **Arguments**
> - Coords - vector3 - The location from which you're trying to find the nearest alarm
> - MaxDistance - float - The maximum distance in meters in which you're looking for an alarm
> 
> **Returns**
> - Alarm object
> - Distance to the alarm
> > Returns `nil` when nothing is found


___

## Advanced usage | Lasers
Once you have created a laser you are able to modify it on the go.

**Example:**
```lua
-- Create a new laser
local laser = exports['kq_security']:CreateLaser('myLaser', laserData)

-- Disable the laser
laser.SetActive(false)
```

### Laser functions
> `Delete()`
> 
> Deletes the laser

> `SetActive(active)`
> 
> Sets the lasers active state (true or false)

> `SetHandler(callback)`
> 
> Sets the trigger handler to a new callback function

> `SetTrigger(triggerTable)`
> 
> Sets the trigger to a new trigger table (see basic usage for table example)

> `SetColor(colorTable)`
> 
> Sets a new color. Color table example: `{r = 0, g = 255, b = 0, a = 150}`

> `SetOpacity(newOpacity)`
> 
> Sets the laser opacity to a new value without affecting its color

> `SetSpeed(newSpeed)`
> 
> Changes the laser speed. Only affects moving lasers

> `SetCooldown(newCooldown)`
> 
> Changes the laser trigger cooldown

___

## Advanced usage | Controllers
Once you have created a controller you are able to modify it on the go.

**Example:**
```lua
-- Create a new controller
local controller = exports['kq_security']:CreateController('myController', controllerData)

-- Delete the controller
controller.Delete()
```

### Controller functions
> `Delete()`
> 
> Deletes the controller

___

## Advanced usage | Alarms
Once you have created an alarm you are able to modify it on the go.

**Example:**
```lua
-- Create a new alarm
local alarm = exports['kq_security']:CreateAlarm('myAlarm', alarmData)

-- Trigger the alarm manually
alarm.Trigger()
```

### Alarm functions
> `Delete()`
> 
> Deletes the alarm

> > `Trigger()`
> 
> Triggers the alarm


## Full usage example | Laser
```lua
local laserData = {
    origin = vector3(-924.9017, -2946.101, 13.738),
    endPointA = vector3(-920.802, -2949.351, 14.820),
    endPointB = vector3(-920.827, -2949.336, 13.322),

    color = { r = 0, g = 255, b = 21, a = 100 },

    speed = 0.5,
    maxLength = 15.0,

    damage = 5,
    ragdoll = true,

    alarms = {
        'lsia'
    },
    
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
}

local laser = exports['kq_security']:CreateLaser('myUniqueLaserName', laserData)

--- Making the laser flash on and off (obviously, this is just an example)
CreateThread(function()
    local state = true
    while true do
        -- Flip the state
        state = not state
        
        -- Set the laser state
        laser.SetActive(state)
        
        -- Wait 1 second
        Citizen.Wait(1000)
    end
end)
```

___
## Full usage example | Controller
```lua
local controllerData = {
    coords = vector3(-930.23, -2955.70, 14.2),
    rotation = vector3(0.0, 0.0, 60.0),

    lasers = {
        'myUniqueLaserName',
        'myOtherLaser',
    },

    hacking = {
        hackable = true,

        disableLasers = true,
        duration = 10000,

        -- Items are only used for ESX or QBCORE.
        -- When using command, all controllers can be hacked using the command
        hackItems = { 'kq_hacker_usb' },

        successHandler = function() print('I have been hacked') end,
        failureHandler = function() print('I survived the hacker') end,
    },
}

local controller = exports['kq_security']:CreateController('myUniqueControllerName', controllerData)
```

___
## Full usage example | Alarm
```lua
local alarmData = {
    coords = vector3(-927.49, -2950.59, 16.13),
    rotation = vector3(0.0, 0.0, 60.0),
    duration = 15,

    sound = true,

    light = {
        rgb = { 100, 0, 0 },
        range = 15.0,
        intensity = 5.0,
    }
}

local alarm = exports['kq_security']:CreateAlarm('myUniqueAlarmName', alarmData)

--- Now, if you wish to trigger the alarms manually/from your script. You'd do the following (on each client)
alarm.Trigger()
```

### Synchronised alarms
If you want to trigger alarms for all clients at once. You may use the server event:
> `kq_security:alarm:server:trigger`

This event takes a table containing the lasers as its argument. Example:

```lua
TriggerServerEvent('kq_security:alarm:server:trigger', {
    alarms = {'alarm1', 'alarm2'}
})
```
