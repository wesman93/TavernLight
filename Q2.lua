-- I noticed that this function assumes that the query returns results. It is also written in a
-- way that only expects one guild name as a result. I have added a check that the db.StoreQuery call
-- results in a valid id and put in a repeat-until loop to print out all guild names rather than just
-- one. I also made sure to make a call to result.free when all printing has finished.

function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    if resultId then
        repeat
            local guildName = result.getString(resultId, "name")
            print(guildName)
        until not result.next(resultId)
        result.free(resultId)
    end
end