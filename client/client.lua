local inZone = false

function onExit(self)
    inZone = true
    lib.notify({
        title = Config.TitleHaKilep,
        description = Config.DescriptionHaKilep,
        type = Config.TypeHaKilep,
        position = 'top'
    })
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)

    SetEntityInvincible(playerPed, true)
    NetworkSetFriendlyFireOption(false)
	ClearPlayerWantedLevel(PlayerPedId())
    SetEntityCanBeDamaged(vehicle, true)

CreateThread(function ()
    while true do
        for k, v in ipairs(Config.zones) do
            if cache.vehicle and inZone == true then
                SetVehicleMaxSpeed(cache.vehicle, v.speedLimit)
                Wait(50)
            else
                Wait(1000)
            end 
        end

        if IsControlJustPressed(0, 106) and inZone then
            SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
        end
    end 
end)
    
end

function onEnter(self)
    inZone = false
    lib.notify({
        title = Config.TitleHaBelep,
        description = Config.DescriptionHaBelep,
        type = Config.TypeHaBelep,
        position = 'top'
    })
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)

    SetEntityInvincible(playerPed, false)
    NetworkSetFriendlyFireOption(true)
    SetEntityCanBeDamaged(vehicle, true)

end

CreateThread(function ()
    for k,v in pairs(Config.zones) do
        local zone = lib.zones.sphere({
            coords = v.coords,
            radius = v.radius,
            debug = v.debug,
            onEnter = onEnter,
            onExit = onExit
        })
    end
end)
