CreateThread(function()
    for k, v in pairs(Config.zones) do
        local zone = lib.zones.sphere({
            coords = v.coords,
            radius = v.radius,
            debug = v.debug,
            inside = function()
                SetEntityInvincible(cache.ped, false)
                NetworkSetFriendlyFireOption(true)
                SetEntityCanBeDamaged(cache.vehicle, true)
            end
        })
        local blip1 = AddBlipForCoord(v.coords)

        SetBlipSprite(blip1, 487)
        SetBlipColour(blip1, 45)
        SetBlipScale(blip1, 1.2)
        SetBlipAsShortRange(blip1, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.blip)
        EndTextCommandSetBlipName(blip1)

        local blip3 = AddBlipForRadius(v.coords, v.radius)
        SetBlipColour(blip3, 69)
        SetBlipAlpha(blip3, 150)
    end
end)
