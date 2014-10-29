--[[
	Gameplay - Camera
]]

Camera = {}
Camera.isLocked = true;
Camera.moveSencivity = 150; -- 0 = OMFG; 100 = Normal
Camera.position = {}
Camera.zoom = {}
Camera.zoom.size = 8;
Camera.cursor = {}

--[[
			[function] Camera.init()
	
			* Initialise la camera *
	
			Return: nil
]]
function Camera.init()
	showCursor(true);
	fadeCamera(true);

	addEventHandler("onClientClick", getRootElement(), Camera.onClick);
	addEventHandler("onClientKey", getRootElement(), Camera.onZoom);
	addEventHandler("onClientPreRender", getRootElement(), Camera.preRender)
	addEventHandler("onClientRender", getRootElement(), Camera.onMouse);

	-- init camera pos
	Camera.position.x, Camera.position.y, Camera.position.z = getElementPosition(getLocalPlayer());
	Camera.playerX, Camera.playerY, Camera.playerZ = getElementPosition(getLocalPlayer());
	Camera.lookAtX, Camera.lookAtY, Camera.lookAtZ = Camera.position.x, Camera.position.y, Camera.position.z;
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
		outputChatBox(getElementType(element));
	end
end

--[[
			[function] Camera.onMouse()
	
			* Detecte les colisions en bord de fenetre *
	
			Return: nil
]]
function Camera.onMouse()
	if not Camera.isLocked then
		if getKeyState("mouse3") then
			local cursorX, cursorY = getCursorPosition();
			cursorX, cursorY = cursorX*screenX, cursorY*screenY;

			local vector = {};
			vector.x = Camera.cursor.lastX - cursorX;
			vector.y = Camera.cursor.lastY - cursorY;
			outputChatBox(vector.x.."-"..vector.y);
			vector.dist = math.sqrt((Camera.cursor.lastX - cursorX)^2 + (Camera.cursor.lastY - cursorY));

			Camera.position.x = Camera.position.x - (vector.x/Camera.moveSencivity);
			Camera.position.y = Camera.position.y - (vector.y/Camera.moveSencivity);
			

			--[[if(cursorX*screenX >= 0) and (cursorX*screenX <= 10)then
				-- move left
				outputChatBox("Move left");
			elseif(cursorX*screenX >= screenX-10) and (cursorX*screenX <= screenX)then
				-- move right
				outputChatBox("Move right");
			elseif(cursorY*screenY >= 0) and (cursorY*screenY <= 10)then
				-- move top
				outputChatBox("Move top");
			elseif(cursorY*screenY >= screenY-10) and (cursorY*screenY <= screenY)then
				-- move bottom
				outputChatBox("Move bot");
			end]]
		else

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
		if not (Camera.zoom.size <= 3) then
			Camera.zoom.size = Camera.zoom.size - 0.5;
		end
	elseif(button == "mouse3") and press then
		local x, y = getCursorPosition();
		Camera.isLocked = false;
		Camera.cursor.lastX = x*screenX;
		Camera.cursor.lastY = y*screenY;
	else

	end
end


--[[
			[function] Camera.render()
	
			* Render *
	
			Return: nil
]]
function Camera.preRender()
	-- player position

	-- camera calculs
	if Camera.isLocked then
		-- camera on the player
		Camera.position.x = Camera.playerX+Camera.zoom.size;
		Camera.position.y = Camera.playerY+Camera.zoom.size;
		Camera.position.z = Camera.playerZ+Camera.zoom.size;

	end

	setCameraMatrix(Camera.position.x, Camera.position.y, Camera.position.z, Camera.lookAtX, Camera.lookAtY, Camera.lookAtZ, 0,0)

	if Camera.cursor.lastX then
		dxDrawRectangle(Camera.cursor.lastX, Camera.cursor.lastY, 10,10, tocolor(255,255,255,255));
	end
end


--[[
	Event Handlers
]]
