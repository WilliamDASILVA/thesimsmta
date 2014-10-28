--[[
	Client - Misc
]]

Misc = {}

--[[
			[function] Misc.interpolateBetween()
	
			*  *
	
			Return: x, y
]]
function Misc.interpolateBetween(startX, startY, finalX, finalY, startTime, animationDuration, animationType)
	if startX and startY and finalX and finalY then
		local now = getTickCount()
	    local endTime = startTime + animationDuration
	    local elapsedTime = now - startTime
	    local duration = endTime - startTime
	    local progress = elapsedTime / duration
		local aX, aY = interpolateBetween (startX, startY, 0, finalX, finalY, 0, progress, animationType);

		return aX, aY;
	end
end