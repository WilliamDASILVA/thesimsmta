--[[
	Server - Main

	Description: Permet de gèrer la partie serveur
]]

Server = {}

for i, v in pairs(getElementsByType("player"))do
	outputDebugString("Spawning..."..getPlayerName(v));
	spawnPlayer(v, 0,0,5);
end

--[[
			[function] Server.playerJoin()
	
			* Quand un utilisateur rejoins le serveur *
	
]]
function Server.playerJoin()
	if source then
	end
end

--[[
	Event Handlers
]]
addEventHandler("onPlayerJoin", getRootElement(), Server.playerJoin);