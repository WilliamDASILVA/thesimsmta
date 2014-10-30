--[[
	Gameplay - Interaction
]]

Interaction = {}

--[[
			[function] Interaction.vehicleEnter(element vehicle)
	
			* Player enter in the vehicle *
	
			Return: nil
]]
function Interaction.vehicleEnter(vehicle)
	if vehicle and getElementType(vehicle, "vehicle") then
		local maxPlayers = getVehicleMaxPassengers(vehicle);
		local vehicleOccupants = getVehicleOccupants(vehicle);
		if not #vehicleOccupants == maxPlayers+1 then
			outputChatBox("LOL?")
		else
			for k=0,maxPlayers+1 do
				if vehicleOccupants[k] == nil then
					warpPedIntoVehicle(client, vehicle, vehicleOccupants[k]);
					triggerClientEvent(client, "Camera.setFocusOnPlayer", client);
					showCursor(client, false);
				end
			end
		end
	else
		return false;
	end
end

--[[
			[function] Interaction.vehicleExit(vehicle, sit)
	
			* When the player leave the car *
	
			Return: nil
]]
function Interaction.vehicleExit(vehicle, sit)
	if vehicle and source then
		showCursor(source, true);
	end
end

--[[
	Event Handlers
]]
addEvent("Interaction.vehicleEnter", true);
addEventHandler("Interaction.vehicleEnter", getRootElement(), Interaction.vehicleEnter);
addEventHandler("onPlayerVehicleExit", getRootElement(), Interaction.vehicleExit);