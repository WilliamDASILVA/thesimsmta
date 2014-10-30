--[[
	Client - Misc
]]

Misc = {}

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

addCommandHandler("pos",
function()
	local x,y,z = getElementPosition(getLocalPlayer())
	outputChatBox(x..","..y..","..z);
end)