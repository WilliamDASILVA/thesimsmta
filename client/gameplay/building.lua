--[[
	Gameplay - Building
]]

Building = {}
Building.initiated = false;
Building.areas = {}
Building.currentArea = {}
Building.currentArea.objects = {}

Building.filesToDownload = {
	"models/wall_01.col",
	"models/wall_02.col",
	"models/wall_03.col",
	"models/wall_04.col",
	"models/wall_05.col",
	"models/wall_01.dff",
	"models/wall_02.dff",
	"models/wall_03.dff",
	"models/wall_04.dff",
	"models/wall_05.dff",
	"models/walls_texture.txd"
}

addCommandHandler("building",
	function()
		outputChatBox("TEST?"..tostring(Building.initiated))
		if Building.initiated == false then
			Building.starting();
		else
			Building.quit();
		end
	end);

--[[
			[function] Building.init()
	
			* Init the building system *
	
			Return: nil
]]
function Building.init()
	outputChatBox("BUILDING INIT");
	-- download models
	Downloading.request(Building.filesToDownload);

	-- remplacing models
	local models = {
		[2529] = "wall_01",
		[2530] = "wall_02",
		[2531] = "wall_03",
		[2532] = "wall_04",
		[2533] = "wall_05",
	}

	-- Textures
	txd = engineLoadTXD ( "client/files/models/walls_texture.txd" )
	for i, v in pairs(models)do
		if i and v then
			engineImportTXD ( txd, i )
		end
	end

	-- Models
	for i, v in pairs(models)do
		if i and v then
			col_floors = engineLoadCOL ( "client/files/models/"..v..".col" )
			dff_floors = engineLoadDFF ( "client/files/models/"..v..".dff", i )
			engineReplaceCOL ( col_floors, i )
			engineReplaceModel ( dff_floors, i )
		end
	end

	-- calling the worldgen
	local areas = call(getResourceFromName("worldgen"), "getBuildingAreas");
	Building.areas = areas;

end

function Building.starting()
	outputChatBox("BUILDING STARTED");
	-- disable moving, interactions
	Mouvement.quit();
	Interaction.quit();
	Building.initiated = true;

	local x, y, z = getElementPosition(getLocalPlayer());
	for i, v in ipairs(Building.areas)do
		if getDistanceBetweenPoints3D(v.x, v.y, v.z, x, y, z) <= 15 then
			Building.start(v);
		end
	end

	addEventHandler("onClientRender", getRootElement(), Building.render);
	addEventHandler("onClientClick", getRootElement(), Building.onClick);
end

--[[
			[function] Building.quit()
	
			* Quit the building system *
	
			Return: nil
]]
function Building.quit()
	Building.initiated = false;
	outputChatBox("Quit building");
	Mouvement.init();
	Interaction.init();

	removeEventHandler("onClientRender", getRootElement(), Building.render);
	removeEventHandler("onClientClick", getRootElement(), Building.onClick);
end

--[[
			[function] Building.start(v)
	
			* Start a building for an specific area *
	
			Return: nil
]]
function Building.start(v)
	if v then
		Building.currentArea = v;
	end
end

--[[
			[function] Building.onClick()
	
			* On Click *
	
			Return: nil
]]
Building.initial = {}
Building.final = {}
function Building.onClick(button, press, x, y, wX, wY, wZ, element)
	if(button == "left" and press == "down")then
		Building.initial.x, Building.initial.y, Building.initial.z = wX, wY, wZ;
	elseif(button == "left" and press == "up")then
		Building.final.x, Building.final.y, Building.final.z = wX, wY, wZ;
	end
end


--[[
			[function] Building.render()
	
			* Render *
	
			Return: nil
]]
function Building.render()
	--for x=0,Building.currentArea.width
	if Building.initial.x and Building.final.x then
		dxDrawLine3D(Building.initial.x, Building.initial.y, Building.initial.z+1, Building.final.x, Building.final.y, Building.final.z+1, tocolor(255,255,255,255), 5);
	end

	for i=0,15 do
		dxDrawLine3D((Building.currentArea.x-7.5)+i, (Building.currentArea.y-7.5), 1.8, (Building.currentArea.x-7.5)+i, (Building.currentArea.y+7.5), 1.8, tocolor(255,0,0,180), 3);
	end
	for k=0,15 do
		dxDrawLine3D((Building.currentArea.x-7.5), (Building.currentArea.y-7.5)+k, 1.8, (Building.currentArea.x+7.5), (Building.currentArea.y-7.5)+k, 1.8, tocolor(255,0,0,180), 3);
	end
end



--[[
	Event Handlers
]]
