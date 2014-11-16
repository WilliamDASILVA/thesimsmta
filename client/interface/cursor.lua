--[[
	Interface - Cursor
]]

Cursor = {}
Cursor.cursors = {
	['normal'] = dxCreateTexture("client/files/cursor/normal.png"),
	['impossible'] = dxCreateTexture("client/files/cursor/impossible.png"),
	['interaction'] = dxCreateTexture("client/files/cursor/interaction.png"),
	['walk'] = dxCreateTexture("client/files/cursor/walk.png")
};
Cursor.currentCursor = "normal";
Cursor.isCursorShowing = true;
Cursor.isCursorUI = false;
Cursor.isFixed = false;

--[[
			[function] Cursor.init()
	
			* Init the cursor *
	
			Return: nil
]]
function Cursor.init()
	showCursor(true);
	setCursorAlpha(0);
	addEventHandler("onClientRender", getRootElement(), Cursor.render);
end

--[[
			[function] Cursor.quit()
	
			* Quit the cursor *
	
			Return: nil
]]
function Cursor.quit()
	removeEventHandler("onClientRender", getRootElement(), Cursor.render);
end

--[[
			[function] Cursor.setCursor(cursorType)
	
			* Set cursor *
	
			Return: nil
]]
function Cursor.setCursor(cursorType)
	if cursorType then
		Cursor.currentCursor = cursorType;
	end
end

--[[
			[function] Cursor.showCursor(show)
	
			* Show cursor or not *
	
			Return: nil
]]
function Cursor.showCursor(show)
	Cursor.isCursorShowing = show;
end

--[[
			[function] Cursor.isOnUI()
	
			* Check if the cursor is on a UI or not *
	
			Return: true, false
]]
function Cursor.isOnUI()
	return Cursor.isCursorUI;
end

--[[
			[function] Cursor.setOnUI(bool)
	
			* Set the cursor on a UI or not *
	
			Return: nil
]]
function Cursor.setOnUI(enabled)
	Cursor.isCursorUI = enabled;

	if enabled then
		Cursor.setCursor("normal");
		Cursor.setFixe(true);
	else
		Cursor.setFixe(false);
	end
end

--[[
			[function] Cursor.setFixe(bool)
	
			* Set if the cursor change automatically or not *
	
			Return: nil
]]
function Cursor.setFixe(bool)
	Cursor.isFixed = bool;
end

--[[
			[function] Cursor.render()
	
			* Render *
	
			Return: nil
]]
function Cursor.render()
	if isCursorShowing() then
		local cursorX, cursorY = getCursorPosition()
		cursorX, cursorY = cursorX*screenX, cursorY*screenY;

		-- checking for elements or other stuff
		if not Cursor.isFixed then
			local w, h = guiGetScreenSize ()
			local tx, ty, tz = getWorldFromScreenPosition (cursorX, cursorY, 50 )
			local px, py, pz = getCameraMatrix()
			hit, x, y, z, elementHit = processLineOfSight ( px, py, pz, tx, ty, tz )
			if hit then
			    if elementHit then
			        if getElementType(elementHit) == "object" and getElementData(elementHit, "type") == "ground" then
			        	Cursor.setCursor("walk");

			        elseif getElementType(elementHit) == "player" then
			        	Cursor.setCursor("interaction");
			        else
			        	Cursor.setCursor("normal");
			        end
			    end
			else
				Cursor.setCursor("impossible");
			end
		end

		-- rendering
		if Cursor.isCursorShowing then
			if cursorX and cursorY then
				local sizeX, sizeY = dxGetMaterialSize(Cursor.cursors[Cursor.currentCursor]);
				dxDrawImage(cursorX, cursorY, sizeX/2, sizeY/2, "client/files/cursor/"..Cursor.currentCursor..".png", 0,0,0, tocolor(255,255,255,255));
			end

		end

	end
end