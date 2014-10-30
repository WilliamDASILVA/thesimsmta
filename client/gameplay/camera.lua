--[[
	Gameplay - Camera
]]

Camera = {}
Camera.isLocked = true;
Camera.moveSencivity = 200; -- 1 = OMFG; 100 = Normal
Camera.position = {}
Camera.zoom = {}
Camera.zoom.size = 1;
Camera.cursor = {}
Camera.vector = {}

--[[
			[function] Camera.init()
	
			* Initialise la camera *
	
			Return: nil
]]
function Camera.init()
	showCursor(true);
	fadeCamera(true);

	-- init camera pos
	local x, y, z = getElementPosition(getLocalPlayer());
	Camera.setPosition(x, y, z);

	addEventHandler("onClientClick", getRootElement(), Camera.onClick);
	addEventHandler("onClientKey", getRootElement(), Camera.onZoom);
	addEventHandler("onClientPreRender", getRootElement(), Camera.preRender)
	addEventHandler("onClientRender", getRootElement(), Camera.onMouse);

end

--[[
			[function] Camera.onClick()
	
			* Quand l'utilisateur clique *
	
			Return: nil
]]
function Camera.onClick(button, state, x, y, wX, wY, wZ, element)
	if(button == "right" and state == "down")then
		if element == getLocalPlayer() then
			Camera.isLocked = true;
		end
	end
end

--[[
			[function] Camera.onMouse()
	
			* Detecte les colisions en bord de fenetre *
	
			Return: nil
]]
function Camera.onMouse()
	Camera.cursor.x, Camera.cursor.y = getCursorPosition();
	Camera.cursor.x, Camera.cursor.y = Camera.cursor.x*screenX, Camera.cursor.y*screenY;
	if not Camera.isLocked then
		if getKeyState("mouse3") then

			Camera.vector.x = Camera.cursor.lastX - Camera.cursor.x;
			Camera.vector.y = Camera.cursor.lastY - Camera.cursor.y;
			Camera.vector.dist = math.sqrt((Camera.cursor.lastX - Camera.cursor.x)^2 + (Camera.cursor.lastY - Camera.cursor.y)^2);

			Camera.position.x = Camera.position.x + (Camera.vector.x/Camera.moveSencivity);
			Camera.position.y = Camera.position.y - (Camera.vector.x/Camera.moveSencivity);

			Camera.position.y = Camera.position.y - (Camera.vector.y/Camera.moveSencivity);
			Camera.position.x = Camera.position.x - (Camera.vector.y/Camera.moveSencivity);
			Camera.lookAtX, Camera.lookAtY, Camera.lookAtZ = Camera.position.x-10, Camera.position.y-10, Camera.position.z-10
			

		else
			if not isMTAWindowActive() then
				if(Camera.cursor.x >= 0) and (Camera.cursor.x <= 10)then
					-- move left
					Camera.position.x = Camera.position.x + 0.5;
					Camera.position.y = Camera.position.y - 0.5;
				elseif(Camera.cursor.x >= screenX-10) and (Camera.cursor.x <= screenX)then
					-- move right
					Camera.position.x = Camera.position.x - 0.5;
					Camera.position.y = Camera.position.y + 0.5;
				elseif(Camera.cursor.y >= 0) and (Camera.cursor.y <= 10)then
					-- move top
					Camera.position.y = Camera.position.y - 0.5;
					Camera.position.x = Camera.position.x - 0.5;
				elseif(Camera.cursor.y >= screenY-10) and (Camera.cursor.y <= screenY)then
					-- move bottom
					Camera.position.y = Camera.position.y + 0.5;
					Camera.position.x = Camera.position.x + 0.5;
				end
				Camera.lookAtX, Camera.lookAtY, Camera.lookAtZ = Camera.position.x-10, Camera.position.y-10, Camera.position.z-10
			end
		end
	end
end

--[[
			[function] Camera.onZoom(zooming)
	
			* Quand l'utilisateur zoom *
	
			Return: nil
]]
function Camera.onZoom(button, press)
	if (button == "mouse_wheel_down") and press then
		if not (Camera.zoom.size >= 10) then
			Camera.zoom.size = Camera.zoom.size + 0.5;
		end
	elseif (button == "mouse_wheel_up") and press then
		if not (Camera.zoom.size <= 1) then
			Camera.zoom.size = Camera.zoom.size - 0.5;
		end
	elseif(button == "mouse3") and press then
		Camera.isLocked = false;
		Camera.cursor.lastX = Camera.cursor.x;
		Camera.cursor.lastY = Camera.cursor.y;
	else

	end
end


--[[
			[function] Camera.setPosition(x, y, z)
	
			* Met la camera a un endroit donnée *
	
			Return: nil
]]
function Camera.setPosition(x, y, z)
	if x and y and z then
		Camera.position.x = x+Camera.zoom.size;
		Camera.position.y = y+Camera.zoom.size;
		Camera.position.z = z+Camera.zoom.size;
		Camera.lookAtX, Camera.lookAtY, Camera.lookAtZ = Camera.position.x-10, Camera.position.y-10, Camera.position.z-10
	end
end


--[[
			[function] Camera.render()
	
			* Render *
	
			Return: nil
]]
function Camera.preRender()

	--[[ debug
	dxDrawText("CamX:"..math.floor(Camera.position.x), screenX-150, 0, 0,0);
	dxDrawText("CamY:"..math.floor(Camera.position.y), screenX-150, 10, 0,0);
	dxDrawText("CamZ:"..math.floor(Camera.position.z), screenX-150, 20, 0,0);
	dxDrawText("CamLX:"..math.floor(Camera.lookAtX), screenX-150, 30, 0,0);
	dxDrawText("CamLY:"..math.floor(Camera.lookAtY), screenX-150, 40, 0,0);
	dxDrawText("CamLZ:"..math.floor(Camera.lookAtZ), screenX-150, 50, 0,0);]]

	-- camera calculs
	if Camera.isLocked then
		-- camera on the player
		local playerX, playerY, playerZ = getElementPosition(getLocalPlayer())
		Camera.setPosition(playerX, playerY, playerZ)

		setCameraMatrix(Camera.position.x+Camera.zoom.size, Camera.position.y+Camera.zoom.size, Camera.position.z+Camera.zoom.size, Camera.lookAtX+Camera.zoom.size, Camera.lookAtY+Camera.zoom.size, Camera.lookAtZ+Camera.zoom.size, 0,0)
	else
		setCameraMatrix(Camera.position.x+Camera.zoom.size, Camera.position.y+Camera.zoom.size, Camera.position.z+Camera.zoom.size, Camera.lookAtX+Camera.zoom.size, Camera.lookAtY+Camera.zoom.size, Camera.lookAtZ+Camera.zoom.size, 0,0)
	end

	if getKeyState("mouse3") then
		if Camera.cursor.lastX then
			setCursorAlpha(0);
			dxDrawImage(Camera.cursor.lastX-20, Camera.cursor.lastY-20, 40, 40, "client/files/camera-startpoint.png", 0,0,0, tocolor(255,255,255,255));
			if Camera.vector.dist and Camera.vector.dist >= 20 then
				dxDrawImage(Camera.cursor.x-40, Camera.cursor.y-20, 80, 40, "client/files/camera-endpoint.png", Misc.findRotation(Camera.cursor.x, Camera.cursor.y, Camera.cursor.lastX, Camera.cursor.lastY), 0,0, tocolor(255,255,255,255));
			end
		end
	else
		setCursorAlpha(255);
	end
end

--[[
	Event Handlers
]]
