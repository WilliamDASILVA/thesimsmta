--[[
	Client - Misc
]]

Misc = {}
Misc.dot = dxCreateTexture(1,1);

--[[
			[function] Misc.interpolateBetween()
	
			*  *
	
			Return: x, y
]]
function Misc.interpolateBetween(startX, startY, startZ, finalX, finalY, finalZ, startTime, animationDuration, animationType)
	if startX and startY and finalX and finalY then
		local now = getTickCount()
	    local endTime = startTime + animationDuration
	    local elapsedTime = now - startTime
	    local duration = endTime - startTime
	    local progress = elapsedTime / duration
		local aX, aY, aZ = interpolateBetween (startX, startY, startZ, finalX, finalY, finalZ, progress, animationType);

		return aX, aY, aZ;
	end
end

--[[
			[function] Misc.findRotation(x1, y1, x2, y2)
	
			* Trouve la rotation entre deux points *
	
			Return: float
]]
function Misc.findRotation(x1, y1, x2, y2)
 	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end;
		return t;
end

--[[
			[function] Misc.dxDrawRectangle3D(float x, float y, float z, float width, float height, int color, float rotation, float faceTowardX, float faceTowardY, float faceTowardZ)
	
			* Dessine un rectangle en 3D *
	
			Return: nil
]]
function Misc.dxDrawRectangle3D(x, y, z, width, height, color, rotation, ...)
    local lx, ly, lz = x+width, y+height, z
	dxDrawMaterialLine3D(x,y,z, lx, ly, lz, Misc.dot, height, tocolor(255,255,255,255), ...)
end

--[[
			[function] Misc.dxCreateRectangle(width, height, color)
	
			* Crée une texture de forme rectangulaire *
	
			Return: texture
]]
function Misc.dxCreateRectangle(width, height, r, g, b, a)
	if width and height  then
		local texture = dxCreateTexture(width, height);
		local pixels = dxGetTexturePixels (texture)
		for i = 0,width-1 do
			for j=0,height-1 do
				dxSetPixelColor(pixels, j, i, r, g, b, a);
			end;
		end;
		dxSetTexturePixels(texture, pixels);

		return texture;
	else
		return false;
	end
end

addCommandHandler("pos",
function()
	local x,y,z = getElementPosition(getLocalPlayer())
	outputChatBox(x..","..y..","..z);
end)