--[[
	Gameplay - Player
]]

Player = {}

--[[
			[function] Player.spawn()
	
			* Spawn a player *
	
			Return: nil
]]
function Player.spawn()
	if client then
		outputChatBox("SPAWING");
		local cam = setCameraTarget(client, client);
		local data = getElementData(client, "userdata");
		if data then
			spawnPlayer(client, data.posX, data.posY, data.posZ);
			setElementDimension(client, 1);
		else
			outputDebugString("Couldn't spawn the player ("..getPlayerName(client)..") because no data.")
		end
	end
end


--[[
	Event Handlers
]]
addEvent("Player.spawn", true);
addEventHandler("Player.spawn", getRootElement(), Player.spawn);