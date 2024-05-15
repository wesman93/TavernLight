-- I decided to clean up events that may still be referencing the Player object.
-- Once the player has decided to logout, there is no reason to keep track of 
-- events for that Player. Upon logging in, these events can be resubscribed.

local events = {}

local function releaseStorage(player)
    player:setStorageValue(1000, -1)
end

function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player)
    end
    
    local playerId = player:getId()
    stopEvent(playerId)
    events[playerId] = nil
    return true
end