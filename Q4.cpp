/*
* The memory leak issue here is from not cleaning up the pointers (player, item) properly. By
* assigning 'nullptr' to them, we ensure that the pointers will not continue reserving memory after
* the function has executed. I also wanted to note that, depending on the c++ version, you would
* assign 'NULL' to them instead.
*
* I decided not to delete the pointers, because that would trigger the object's destructor; this would
* also be triggered by the end of the function. That may not matter if the object has a destructor
* that prevents this, but I cannot assume this is the case. We would not want either the player or
* item objects to no longer exist in memory after function execution. 
 */

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            player = nullptr; // or player = NULL depending on c++ version
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        item = nullptr; // or item = NULL depending on c++ version
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    player = nullptr;
    item = nullptr;
}