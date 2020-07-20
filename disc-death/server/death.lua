RegisterServerEvent('disc-death:setDead')
AddEventHandler('disc-death:setDead', function(isDead)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    MySQL.Async.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
        ['@isDead'] = isDead,
        ['@identifier'] = xPlayer.getIdentifier()
    })
end)

ESX.RegisterServerCallback('disc-death:getDead', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT is_dead FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(results)
        cb(results[1].is_dead)
    end)
end)

ESX.RegisterServerCallback('disc-death:isPlayerDead', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)

    MySQL.Async.fetchAll('SELECT is_dead FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(results)
        cb(results[1].is_dead)
    end)
end)
