--[[
	Server - Main

	Description: Permet de gèrer la partie serveur
]]

Server = {}


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