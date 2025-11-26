-- Receive ID card display from server
RegisterNetEvent('idcard:display', function(playerInfo)
    -- Display the ID card UI
    SendNUIMessage({
        type = "showIDCard",
        data = playerInfo
    })
    
    -- Auto close after 5 seconds
    SetTimeout(5000, function()
        SendNUIMessage({
            type = "hideIDCard"
        })
    end)
end)