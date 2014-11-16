--[[
	Gameplay - Mouvement
]]

Mouvement = {}
Mouvement.start ={}
Mouvement.endpoint = {}
Mouvement.pickup = {}
Mouvement.isMoving = false;
Mouvement.pickup.size = 1.5;
Mouvement.pickup.texture = nil;
Mouvement.isEnabled = true;



--[[
			[function] Mouvement.init()
	
			* Demarre le mouvement du joueur selon le click du curseur *
	
			Return: nil
]]
function Mouvement.init()
	Mouvement.pickup.texture = dxCreateTexture("client/files/walking.png");
	addEventHandler("onClientClick", getRootElement(), Mouvement.onClick);
	addEventHandler("onClientRender", getRootElement(), Mouvement.render);
end

--[[
			[function] Mouvement.onClick(button, state, x, y, wX, wY, wZ, element)
	
			* Quand l'utilisateur clique *
	
			Return: nill
]]
function Mouvement.onClick(button, state, x, y, wX, wY, wZ, element)
	if (button == "left") and (state == "down")then
		Mouvement.start.x, Mouvement.start.y, Mouvement.start.z = getElementPosition(getLocalPlayer())
		local distance = getDistanceBetweenPoints3D(Mouvement.start.x, Mouvement.start.y, Mouvement.start.z, wX, wY, wZ)
		if distance <= 30 then
			Mouvement.endpoint.x, Mouvement.endpoint.y, Mouvement.endpoint.z = wX, wY, wZ;
			if not isPedInVehicle(getLocalPlayer()) then
				local rot = Misc.findRotation(Mouvement.start.x, Mouvement.start.y, Mouvement.endpoint.x, Mouvement.endpoint.y);
				setPedRotation(getLocalPlayer(), rot);
				if distance >= 0 and distance <= 5 then
					setPedAnimation(getLocalPlayer(), "ped", "WALK_player");
					Mouvement.isMoving = true;
				else
					setPedAnimation(getLocalPlayer(), "ped", "run_player");
					Mouvement.isMoving = true;
				end
			end
		end
	end
end

--[[
			[function] Mouvement.setEnabled(enabled)
	
			* Set the player mouvement enabled or not *
	
			Return: nil
]]
function Mouvement.setEnabled(enabled)
	echo("Mouvement:"..tostring(enabled));
	Mouvement.isEnabled = enabled;
end

function Mouvement.render()
	-- check for position
	local playerX, playerY, playerZ = getElementPosition(getLocalPlayer())
	if Mouvement.isEnabled then
		if Mouvement.endpoint.x then
			local distance = getDistanceBetweenPoints3D(playerX, playerY, playerZ, Mouvement.endpoint.x, Mouvement.endpoint.y, Mouvement.endpoint.z)
			if distance <= 1.1 then
				setPedAnimation(getLocalPlayer(), false);
				Mouvement.isMoving = false;
			end

			-- render endpoint
			if Mouvement.isMoving then
				dxDrawMaterialLine3D (Mouvement.endpoint.x, Mouvement.endpoint.y-(Mouvement.pickup.size/2), getGroundPosition(Mouvement.endpoint.x, Mouvement.endpoint.y, Mouvement.endpoint.z+1)+0.25, Mouvement.endpoint.x, Mouvement.endpoint.y+(Mouvement.pickup.size/2), getGroundPosition(Mouvement.endpoint.x, Mouvement.endpoint.y, Mouvement.endpoint.z+1)+0.25, Mouvement.pickup.texture,  Mouvement.pickup.size, tocolor(255,255,255, 255), Mouvement.endpoint.x, Mouvement.endpoint.y, Mouvement.endpoint.z+1.1)
			end
		end
	end
end
