--[[
	Gameplay - Player
]]

Player = {}
Player.prisms = {}

--[[
			[function] Player.init()
	
			* Init *
	
			Return: 
]]
function Player.init()
	-- spawn player
	triggerServerEvent("Player.spawn", getLocalPlayer());


	-- prism
	for i, v in ipairs(getElementsByType("player"))do
		local x, y, z = getElementPosition(v)
		local marker = createMarker(x, y, z, "arrow", 0.3, 0, 255, 0, 255)
		local marker2 = createMarker(x, y, z, "arrow", 0.3, 0, 255, 0, 255)
		setElementDimension(marker,1);
		setElementDimension(marker2,1);
		attachElements(marker, v, 0, 0, 2)
		attachElements(marker2, v, 0, 0, 2.05, 0, 180, 0)
		
		Player.prisms[tostring(v)] = {}
		Player.prisms[tostring(v)].marker1 = marker;
		Player.prisms[tostring(v)].marker2 = marker2;
	end

	addEventHandler("onClientPreRender", getRootElement(), Player.preRender);
end

--[[
			[function] Player.preRender()
	
			* Render *
	
			Return: nil
]]
function Player.preRender()
	
end
