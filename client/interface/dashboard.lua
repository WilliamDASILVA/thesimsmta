--[[
	Interface - Dashboard
]]

Dashboard = {}
Dashboard.elements = {}

Dashboard.elements.panel = {}
Dashboard.elements.panel.x = 0.05*screenX;
Dashboard.elements.panel.y = screenY-0.18*screenX;
Dashboard.elements.panel.width = screenX-(0.05*screenX);
Dashboard.elements.panel.height = 0.15*screenX;

Dashboard.elements.homeBtn = {};
Dashboard.elements.homeBtn.x = Dashboard.elements.panel.x + (0*Dashboard.elements.panel.width);
Dashboard.elements.homeBtn.y = Dashboard.elements.panel.y + (0*Dashboard.elements.panel.height);
Dashboard.elements.homeBtn.width = 0.055*Dashboard.elements.panel.width;

Dashboard.elements.homeBtn = {};
Dashboard.elements.homeBtn.x = Dashboard.elements.panel.x + (0*Dashboard.elements.panel.width);
Dashboard.elements.homeBtn.y = Dashboard.elements.panel.y + (0*Dashboard.elements.panel.height);
Dashboard.elements.homeBtn.width = 0.055*Dashboard.elements.panel.width;
Dashboard.elements.homeBtn.type = "round";
Dashboard.elements.homeBtn.options = {
	['border'] = true,
	['border_size'] = 3
}

Dashboard.elements.worldBtn = {};
Dashboard.elements.worldBtn.x = Dashboard.elements.panel.x + (-0.01*Dashboard.elements.panel.width);
Dashboard.elements.worldBtn.y = Dashboard.elements.panel.y + (0.4*Dashboard.elements.panel.height);
Dashboard.elements.worldBtn.width = 0.04*Dashboard.elements.panel.width;
Dashboard.elements.worldBtn.type = "round";
Dashboard.elements.worldBtn.options = {
	['border'] = true,
	['border_size'] = 3
}

Dashboard.elements.moreBtn = {};
Dashboard.elements.moreBtn.x = Dashboard.elements.panel.x + (-0.01*Dashboard.elements.panel.width);
Dashboard.elements.moreBtn.y = Dashboard.elements.panel.y + (0.4*Dashboard.elements.panel.height);
Dashboard.elements.moreBtn.width = 0.04*Dashboard.elements.panel.width;
Dashboard.elements.moreBtn.type = "round";
Dashboard.elements.moreBtn.options = {
	['border'] = true,
	['border_size'] = 3
}

-- buttons
Dashboard.buttons = {
	Dashboard.elements.worldBtn,
	Dashboard.elements.moreBtn,
	Dashboard.elements.homeBtn,
}

--[[
			[function] Dashboard.init()
	
			* Init the dashboard *
	
			Return: nil
]]
function Dashboard.init()

	-- events
	addEventHandler("onClientClick", getRootElement(), Dashboard.onClick);
	addEventHandler("onClientRender", getRootElement(), Dashboard.render);
end

--[[
			[function] Dashboard.quit()
	
			* Destroy the dashboard *
	
			Return: nil
]]
function Dashboard.quit()
	removeEventHandler("onClientRender", getRootElement(), Dashboard.render);
end


--[[
			[function] Dashboard.onClick(button, state, x, y, wX, wY, wZ, element)
	
			* When the player click *
	
			Return: nil
]]
function Dashboard.onClick(button, state, x, y, wX, wY, wZ, element)
	if(button == "left" and state == "up")then

	end
end

--[[
			[function] Dashboard.render()
	
			* Render *
	
			Return: nil
]]
function Dashboard.render()
	-- hover
	local x, y = getCursorPosition()
	x, y = x*screenX, y*screenY;

	for i, btn in ipairs(Dashboard.buttons)do
		if btn.type == "round" then
			local centerX, centerY = btn.x + (btn.width/2), btn.y + (btn.width/2);
			local distance = getDistanceBetweenPoints2D(x, y, centerX, centerY);
			if distance <= (btn.width/2) then
				btn.options['hover'] = true;
			else
				btn.options['hover'] = false;
			end
		end
	end
	

	dxDrawImage(Dashboard.elements.panel.x, Dashboard.elements.panel.y, 0.15*screenX, 0.15*screenX, "client/files/ui-circle.png");
	dxDrawRectangle(Dashboard.elements.panel.x+(0.15*screenX/2), Dashboard.elements.panel.y, screenX, 0.15*screenX, tocolor(0,109,180,255));

	-- me
	UI.roundButton(Dashboard.elements.homeBtn.x, Dashboard.elements.homeBtn.y, Dashboard.elements.homeBtn.width, "client/files/icons/players.png", 255, Dashboard.elements.homeBtn.options)
	-- world
	UI.roundButton(Dashboard.elements.worldBtn.x, Dashboard.elements.worldBtn.y, Dashboard.elements.worldBtn.width, "client/files/icons/world.png", 255, Dashboard.elements.worldBtn.options)
	-- more
	UI.roundButton(Dashboard.elements.worldBtn.x, Dashboard.elements.worldBtn.y, Dashboard.elements.worldBtn.width, "client/files/icons/world.png", 255, Dashboard.elements.worldBtn.options)

end