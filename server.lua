local QBCore = exports['qb-core']:GetCoreObject()

-- Register the ID card as a usable item
QBCore.Functions.CreateUseableItem("id_card", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player then
        local playerInfo = {
            firstname = Player.PlayerData.charinfo.firstname,
            lastname = Player.PlayerData.charinfo.lastname,
            birthdate = Player.PlayerData.charinfo.birthdate,
            gender = Player.PlayerData.charinfo.gender == 0 and "Male" or "Female",
            nationality = Player.PlayerData.charinfo.nationality or "USA",
            citizenid = Player.PlayerData.citizenid,
        }
        
        -- Get player coordinates
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        
        -- Get all players
        local players = GetPlayers()
        
        for _, playerId in pairs(players) do
            local targetPed = GetPlayerPed(playerId)
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(coords - targetCoords)
            
            -- Show to players within 5 meters (including self)
            if distance <= 5.0 then
                TriggerClientEvent('idcard:display', playerId, playerInfo)
            end
        end
        
        -- Notification to the player showing ID
        TriggerClientEvent('QBCore:Notify', source, "You showed your ID card", "success")
    end
end)
