--[[
	Gameplay - Interaction
]]

Interaction = {}
Interaction.i = {
	["vehicle"] = {
		["enter"] = {
			"Enter in the vehicle",
			"vehicleEnter"
		},
		['blow'] = {
			"Blow the vehicle",
			"blowVehicle"
		}
	}
}
Interaction.isShowing = false;
Interaction.openingPosition = {}
Interaction.buttons = {}
Interaction.lastElement = nil;



--[[
			[function] Interaction.init()
	
			* Initialise les interactions *
	
			Return: nil
]]
function Interaction.init()
	outputChatBox("Interaction");
	addEventHandler("onClientClick", getRootElement(), Interaction.onClick);
	addEventHandler("onClientRender", getRootElement(), Interaction.render);
end


--[[
			[function] Interaction.onClick(button, state, x, y, wX, wY, wZ, element)
	
			* Quand l'utilisateur clique *
	
			Return: nil
]]
function Interaction.onClick(button, state, x, y, wX, wY, wZ, element)
	if (button == "left") and (state == "down")then
		if element then
			if Interaction.getInteractionsCount() == 0 then
				Interaction.setOpeningPosition(x, y);
				Interaction.getInteractions(getElementType(element), element);
			else
				for i, v in pairs(Interaction.buttons)do
					if v.x then
						if (x >= v.x and x <= v.x + v.width) and (y >= v.y and y <= v.y+v.height)then
							_G["Interaction"][v.func](element);
							Interaction.isShowing = false;
						else
							Interaction.buttons = {};
							Interaction.isShowing = false;
						end
					end
				end
			end
		else
			for i, v in pairs(Interaction.buttons)do
				if v.x then
					if (x >= v.x and x <= v.x + v.width) and (y >= v.y and y <= v.y+v.height)then
						_G["Interaction"][v.func](Interaction.getLastElement());
						Interaction.isShowing = false;
					else
						Interaction.buttons = {};
					end
				else
					Interaction.isShowing = false;
				end
			end
		end
	end
end


--[[
			[function] Interaction.getInteractions(string elementType, element elementSource)
	
			* Affiche les interactions possible avec cet element *
	
			Return: nil
]]
function Interaction.getInteractions(elementType, elementSource)
	Interaction.buttons = {};
	if Interaction.i[elementType] then
		for i, v in pairs(Interaction.i[elementType])do
			local t = {}
			t.content = v[1];
			t.func = v[2];
			table.insert(Interaction.buttons, 0,t);
			Interaction.isShowing = true;
			Interaction.lastElement = elementSource;
		end
	end
end

--[[
			[function] Interaction.getLastElement()
	
			* Returns the last element clicked *
	
			Return: element
]]
function Interaction.getLastElement()
	if Interaction.lastElement then
		return Interaction.lastElement;
	else
		return false;
	end
end

--[[
			[function] Interaction.getInteractionsCount()
	
			* Return the count of interactions *
	
			Return: int
]]
function Interaction.getInteractionsCount()
	local k = 0;
	for i, v in pairs(Interaction.buttons)do
		if v.x then
			k = k+1;
		end
	end
	return k;
end

--[[
			[function] Interaction.setOpeningPosition(x, y)
	
			* set the opening interaction position *
	
			Return: nil
]]
function Interaction.setOpeningPosition(x, y)
	if x and y then
		Interaction.openingPosition.x = x;
		Interaction.openingPosition.y = y-(0.05*screenY);
	end
end

--[[
			[function] Interaction.vehicleEnter(element elementSource)
	
			* Fait entrer un joueur dans un vehicle *
	
			Return: nil
]]
function Interaction.vehicleEnter(element)
	if element then
		triggerServerEvent("Interaction.vehicleEnter", getLocalPlayer(), element);
	end
end

--[[
			[function] Interaction.render()
	
			* Render *
	
			Return: nil
]]
function Interaction.render()
	-- hover
	if isCursorShowing() then
		local x, y = getCursorPosition();
		x, y = x*screenX, y*screenY;
		for i, v in pairs(Interaction.buttons)do
			if v.x then
				if (x >= v.x and x <= v.x + v.width) and (y >= v.y and y <= v.y+v.height)then
					v.color = tocolor(20,130,200,255);
				else
					v.color = tocolor(0,109,180,255);
				end
			end
		end
	end

	-- 
	if Interaction.isShowing then
		local nbr = 0;
		for i, v in pairs(Interaction.buttons)do
			nbr = nbr+1;
			v.x = Interaction.openingPosition.x;
			v.y = Interaction.openingPosition.y+(nbr * 0.05*screenY)+(nbr*5);
			v.width = (0.15*screenX);
			v.height = (0.05*screenY);
			dxDrawRectangle(v.x, v.y, v.width, v.height, v.color);
			dxDrawText(v.content, v.x+ 10, v.y, v.x+ v.width-10, v.y + v.height, tocolor(255,255,255,255), 1, "default", "left", "center");
		end
	end

end