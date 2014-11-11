--[[
	Interface - Dashboard Functions
]]

DashboardFunctions = {}


--[[
			[function] DashboardFunctions.doZoom()
	
			* Do a zoom *
	
			Return: nil
]]
function DashboardFunctions.doZoom()
	Camera.doZoom();
end

--[[
			[function] DashboardFunctions.doDezoom()
	
			* Do a dezoom *
	
			Return: nil
]]
function DashboardFunctions.doDezoom()
	Camera.doDezoom();
end

--[[
			[function] DashboardFunctions.doRotationLeft()
	
			* Do a camera rotation to the left *
	
			Return: nil
]]
function DashboardFunctions.doRotationLeft()
	--Camera.doRotation("left");
end

--[[
			[function] DashboardFunctions.doRotationRight()
	
			* Do a camera rotation to the right *
	
			Return: nil
]]
function DashboardFunctions.doRotationRight()
	--Camera.doRotation("right");
end

--[[
			[function] DashboardFunctions.focusPlayer()
	
			* Focus the camera on a the player *
	
			Return: nil
]]
function DashboardFunctions.focusPlayer()
	Camera.setFocusOnPlayer();
end