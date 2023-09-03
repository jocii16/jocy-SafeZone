CreateThread(function()
    for k, v in pairs(Config.zones) do
        local zone = lib.zones.sphere({
            coords = v.coords,
            radius = v.radius,
            debug = v.debug,
            inside = function()
                SetEntityInvincible(cache.ped, true)
                NetworkSetFriendlyFireOption(true)
                SetEntityCanBeDamaged(cache.vehicle, true)
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 263, true)
            end
        })

       if Config.zones[k].EnableBlip then
        local blip1 = AddBlipForCoord(v.coords)

        SetBlipSprite(blip1, 461)
        SetBlipColour(blip1, 45)
        SetBlipScale(blip1, 0.85)
        SetBlipAsShortRange(blip1, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.blip)
        EndTextCommandSetBlipName(blip1)

        local blip3 = AddBlipForRadius(v.coords, v.radius)
        SetBlipColour(blip3, 69)
        SetBlipAlpha(blip3, 150) 
        end
    end
end)
