-- The main change here is checking for edge cases and printing out different error messages. The
-- function should not assume that the player has a party in the first place. If there is a party, it
-- should check whether or not the player is also the party leader. When the player is in a party and
-- the leader, it should not assume that a Player object with the provided name exists within the
-- party.

-- Some small tweaks I made were making the "player" variable local and replacing "k,v" in the for
-- loop with "_,v", since we are only concerned with the value in this case. The loop will also return
-- when it successfully finds the player and calls party:removeMember. This will eliminate the need to
-- iterate over all pairs every time the function is used.

function removePartyMember(playerId, membername)
    local player = Player(playerId)
    local party = player:getParty()
    local leader = party:getLeader()

    if playerId ~= leader:getId() then
        print("The player is not the party leader.")
        return
    end

    if party then
        for _,v in pairs(party:getMembers()) do
            if v == Player(membername) then
                party:removeMember(Player(membername))
                return
            end
        end
        print("Player could not be removed from the party. Target player name is invalid.")
    else
        print("The player does not have a party.")
    end
end