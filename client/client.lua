function onEnter(...)
    notify("enter")
end

--Basic notify function, we should use dictionary. But we have 2 condition, it's not necessarily. 

function notify(typeof)
    if typeof == "enter" then
        lib.notify({
            title = Config.TitleHaKilep,
            description = Config.DescriptionHaKilep,
            type = Config.TypeHaKilep,
            position = 'top'
        })
    elseif typeof == "exit" then
        lib.notify({
            title = Config.TitleHaBelep,
            description = Config.DescriptionHaBelep,
            type = Config.TypeHaBelep,
            position = 'top'
        })
    end
end

--When player inside this area 

function inside(self)
    local ped = GetPlayerPed(self.id)
    local curveh = GetVehiclePedIsIn(ped, false)
    if curveh then
        SetVehicleMaxSpeed(curveh, Config.speedLimit)
        SetEntityCanBeDamaged(curveh, true)
    end
    SetEntityInvincible(ped, true)
    NetworkSetFriendlyFireOption(false)
    ClearPlayerWantedLevel(PlayerPedId())
    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
end

--Exit function 

function onExit(self)
    notify("exit")
    local ped = GetPlayerPed(self.id)
    local curveh = GetVehiclePedIsIn(ped, false)
    if curveh then
        SetEntityCanBeDamaged(curveh, true)
    end
    SetEntityInvincible(ped, false)
    NetworkSetFriendlyFireOption(true)
end

--Create Zones

CreateThread(function()
    for k, v in pairs(Config.zones) do
        local zone = lib.zones.sphere({
            coords = v.coords,
            radius = v.radius,
            debug = v.debug,
            inside = inside,
            onEnter = onEnter,
            onExit = onExit
        })
    end
end)
