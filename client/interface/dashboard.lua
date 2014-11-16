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

Dashboard.elements.background = {};
Dashboard.elements.background.x = Dashboard.elements.panel.x + (0.01*Dashboard.elements.panel.width);
Dashboard.elements.background.y = Dashboard.elements.panel.y + (0.05*Dashboard.elements.panel.height);
Dashboard.elements.background.width = 0.18*Dashboard.elements.panel.width;
Dashboard.elements.background.height = 0.9*Dashboard.elements.panel.height;

Dashboard.elements.homeBtn = {};
Dashboard.elements.homeBtn.x = Dashboard.elements.panel.x + (0*Dashboard.elements.panel.width);
Dashboard.elements.homeBtn.y = Dashboard.elements.panel.y + (0*Dashboard.elements.panel.height);
Dashboard.elements.homeBtn.width = 0.055*Dashboard.elements.panel.width;

Dashboard.elements.homeBtn = {};
Dashboard.elements.homeBtn.x = Dashboard.elements.panel.x + (0*Dashboard.elements.panel.width);
Dashboard.elements.homeBtn.y = Dashboard.elements.panel.y + (0*Dashboard.elements.panel.height);
Dashboard.elements.homeBtn.width = 0.055*Dashboard.elements.panel.width;
Dashboard.elements.homeBtn.type = "round";
Dashboard.elements.homeBtn.func = "showHome";
Dashboard.elements.homeBtn.options = {
	['border'] = true,
	['border_size'] = 3
}

Dashboard.elements.worldBtn = {};
Dashboard.elements.worldBtn.x = Dashboard.elements.panel.x + (-0.01*Dashboard.elements.panel.width);
Dashboard.elements.worldBtn.y = Dashboard.elements.panel.y + (0.4*Dashboard.elements.panel.height);
Dashboard.elements.worldBtn.width = 0.04*Dashboard.elements.panel.width;
Dashboard.elements.worldBtn.type = "round";
Dashboard.elements.worldBtn.func = "showWorld";
Dashboard.elements.worldBtn.options = {
	['border'] = true,
	['border_size'] = 3
}

Dashboard.elements.moreBtn = {};
Dashboard.elements.moreBtn.x = Dashboard.elements.panel.x + (0.02*Dashboard.elements.panel.width);
Dashboard.elements.moreBtn.y = Dashboard.elements.panel.y + (0.8*Dashboard.elements.panel.height);
Dashboard.elements.moreBtn.width = 0.03*Dashboard.elements.panel.width;
Dashboard.elements.moreBtn.type = "round";
Dashboard.elements.moreBtn.func = "showMore";
Dashboard.elements.moreBtn.options = {
	['border'] = true,
	['border_size'] = 3
}

-- circle
Dashboard.elements.aluCircle = {};
Dashboard.elements.aluCircle.x = Dashboard.elements.panel.x + (0.05*Dashboard.elements.panel.width);
Dashboard.elements.aluCircle.y = Dashboard.elements.panel.y + (0.12*Dashboard.elements.panel.height);
Dashboard.elements.aluCircle.width = 0.11*Dashboard.elements.panel.width;

Dashboard.elements.rotateLeftBtn = {};
Dashboard.elements.rotateLeftBtn.x = Dashboard.elements.aluCircle.x + (0.08*Dashboard.elements.aluCircle.width);
Dashboard.elements.rotateLeftBtn.y = Dashboard.elements.aluCircle.y + (0.2*Dashboard.elements.aluCircle.width);
Dashboard.elements.rotateLeftBtn.width = 0.25*Dashboard.elements.aluCircle.width;
Dashboard.elements.rotateLeftBtn.height = 0.6*Dashboard.elements.aluCircle.width;
Dashboard.elements.rotateLeftBtn.type = "square";
Dashboard.elements.rotateLeftBtn.func = "doRotationLeft";
Dashboard.elements.rotateLeftBtn.color = 200;

Dashboard.elements.rotateRightBtn = {};
Dashboard.elements.rotateRightBtn.x = Dashboard.elements.aluCircle.x + (0.67*Dashboard.elements.aluCircle.width);
Dashboard.elements.rotateRightBtn.y = Dashboard.elements.aluCircle.y + (0.2*Dashboard.elements.aluCircle.width);
Dashboard.elements.rotateRightBtn.width = 0.25*Dashboard.elements.aluCircle.width;
Dashboard.elements.rotateRightBtn.height = 0.6*Dashboard.elements.aluCircle.width;
Dashboard.elements.rotateRightBtn.type = "square";
Dashboard.elements.rotateRightBtn.func = "doRotationRight";
Dashboard.elements.rotateRightBtn.color = 200;

Dashboard.elements.zoomBtn = {};
Dashboard.elements.zoomBtn.x = Dashboard.elements.aluCircle.x + (0.225*Dashboard.elements.aluCircle.width);
Dashboard.elements.zoomBtn.y = Dashboard.elements.aluCircle.y + (0.065*Dashboard.elements.aluCircle.width);
Dashboard.elements.zoomBtn.width = 0.56*Dashboard.elements.aluCircle.width;
Dashboard.elements.zoomBtn.height = 0.23*Dashboard.elements.aluCircle.width;
Dashboard.elements.zoomBtn.type = "square";
Dashboard.elements.zoomBtn.func = "doZoom";
Dashboard.elements.zoomBtn.color = 200;

Dashboard.elements.dezoomBtn = {};
Dashboard.elements.dezoomBtn.x = Dashboard.elements.aluCircle.x + (0.225*Dashboard.elements.aluCircle.width);
Dashboard.elements.dezoomBtn.y = Dashboard.elements.aluCircle.y + (0.7*Dashboard.elements.aluCircle.width);
Dashboard.elements.dezoomBtn.width = 0.56*Dashboard.elements.aluCircle.width;
Dashboard.elements.dezoomBtn.height = 0.23*Dashboard.elements.aluCircle.width;
Dashboard.elements.dezoomBtn.type = "square";
Dashboard.elements.dezoomBtn.func = "doDezoom";
Dashboard.elements.dezoomBtn.color = 200;

Dashboard.elements.profileImage = {};
Dashboard.elements.profileImage.x = Dashboard.elements.aluCircle.x + (0.3*Dashboard.elements.aluCircle.width);
Dashboard.elements.profileImage.y = Dashboard.elements.aluCircle.y + (0.3*Dashboard.elements.aluCircle.width);
Dashboard.elements.profileImage.width = 0.4*Dashboard.elements.aluCircle.width;
Dashboard.elements.profileImage.type = "round";
Dashboard.elements.profileImage.func = "focusPlayer";

-- buttons
Dashboard.buttons = {
	Dashboard.elements.worldBtn,
	Dashboard.elements.moreBtn,
	Dashboard.elements.homeBtn,
	Dashboard.elements.rotateRightBtn,
	Dashboard.elements.rotateLeftBtn,
	Dashboard.elements.zoomBtn,
	Dashboard.elements.dezoomBtn,
	Dashboard.elements.profileImage,
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
		for i, btn in ipairs(Dashboard.buttons)do
			if btn.type == "round" then
				local centerX, centerY = btn.x + (btn.width/2), btn.y + (btn.width/2);
				local distance = getDistanceBetweenPoints2D(x, y, centerX, centerY);
				if distance <= (btn.width/2) then
					if btn.func then
						_G['DashboardFunctions'][btn.func]();
					end
				end
			elseif btn.type == "square" then
				if (x >= btn.x and x <= btn.x + btn.width) and (y >= btn.y and y <= btn.y + btn.height)then
					if btn.func then
						_G['DashboardFunctions'][btn.func]();
					end
				end
			end
		end
	end
end


--[[
			[function] Dashboard.render()
	
			* Render *
	
			Return: nil
]]
function Dashboard.render()
	-- hover
	if isCursorShowing() then


		local x, y = getCursorPosition()
		x, y = x*screenX, y*screenY;
		local a, b, c, d, e, f, g, h = 0,0,0,0,0,0,0,0;

		for i, btn in ipairs(Dashboard.buttons)do
			if btn.type == "round" then
				local centerX, centerY = btn.x + (btn.width/2), btn.y + (btn.width/2);
				local distance = getDistanceBetweenPoints2D(x, y, centerX, centerY);
				if distance <= (btn.width/2) then
					if btn.options then
						btn.options['hover'] = true;
						Cursor.setCursor("normal");
					end
				else
					if btn.options then
						btn.options['hover'] = false;
					end
				end
			elseif btn.type == "square" then
				if (x >= btn.x and x <= btn.x + btn.width) and (y >= btn.y and y <= btn.y + btn.height)then
					a, b, c, d, e, f, g, h = btn.x, btn.y, btn.x + btn.width, btn.y, btn.x + btn.width, btn.y + btn.height, btn.x, btn.y + btn.height;
					btn.color = 255;
					Cursor.setCursor("normal");
				else
					btn.color = 200;
					
				end
			end
		end
		
	end

	dxDrawImage(Dashboard.elements.panel.x, Dashboard.elements.panel.y, 0.15*screenX, 0.15*screenX, "client/files/ui-circle.png");
	dxDrawRectangle(Dashboard.elements.panel.x+(0.15*screenX/2), Dashboard.elements.panel.y, screenX, 0.15*screenX, tocolor(0,109,180,255));

	dxDrawImage(Dashboard.elements.background.x, Dashboard.elements.background.y, Dashboard.elements.background.width, Dashboard.elements.background.height, "client/files/dashboard_background.png", 0,0,0,tocolor(255,255,255,255));

	dxDrawImage(Dashboard.elements.aluCircle.x, Dashboard.elements.aluCircle.y, Dashboard.elements.aluCircle.width, Dashboard.elements.aluCircle.width, "client/files/ui-alu.png", 0,0,0, tocolor(255,255,255,255));
	-- rotate-left
	dxDrawImage(Dashboard.elements.rotateLeftBtn.x, Dashboard.elements.rotateLeftBtn.y, Dashboard.elements.rotateLeftBtn.width, Dashboard.elements.rotateLeftBtn.height, "client/files/ui-button.png", 0,0,0,tocolor(Dashboard.elements.rotateLeftBtn.color,Dashboard.elements.rotateLeftBtn.color,Dashboard.elements.rotateLeftBtn.color,255));
	dxDrawImage(Dashboard.elements.rotateRightBtn.x, Dashboard.elements.rotateRightBtn.y, Dashboard.elements.rotateRightBtn.width, Dashboard.elements.rotateRightBtn.height, "client/files/ui-button.png", 180,0,0,tocolor(Dashboard.elements.rotateRightBtn.color,Dashboard.elements.rotateRightBtn.color,Dashboard.elements.rotateRightBtn.color,255));
	-- zoom
	dxDrawImage(Dashboard.elements.zoomBtn.x, Dashboard.elements.zoomBtn.y, Dashboard.elements.zoomBtn.width, Dashboard.elements.zoomBtn.height, "client/files/ui-button-rotate.png", 0,0,0,tocolor(Dashboard.elements.zoomBtn.color,Dashboard.elements.zoomBtn.color,Dashboard.elements.zoomBtn.color,255));
	-- dezoom
	dxDrawImage(Dashboard.elements.dezoomBtn.x, Dashboard.elements.dezoomBtn.y, Dashboard.elements.dezoomBtn.width, Dashboard.elements.dezoomBtn.height, "client/files/ui-button-rotate.png", 180,0,0,tocolor(Dashboard.elements.dezoomBtn.color,Dashboard.elements.dezoomBtn.color,Dashboard.elements.dezoomBtn.color,255));

	-- profile image
	dxDrawImage(Dashboard.elements.profileImage.x, Dashboard.elements.profileImage.y, Dashboard.elements.profileImage.width, Dashboard.elements.profileImage.width, "client/files/sample.png", 0,0,0,tocolor(255,255,255,255));

	-- me
	UI.roundButton(Dashboard.elements.homeBtn.x, Dashboard.elements.homeBtn.y, Dashboard.elements.homeBtn.width, "client/files/icons/players.png", 255, Dashboard.elements.homeBtn.options)
	-- world
	UI.roundButton(Dashboard.elements.worldBtn.x, Dashboard.elements.worldBtn.y, Dashboard.elements.worldBtn.width, "client/files/icons/world.png", 255, Dashboard.elements.worldBtn.options)
	-- more
	UI.roundButton(Dashboard.elements.moreBtn.x, Dashboard.elements.moreBtn.y, Dashboard.elements.moreBtn.width, "client/files/icons/more.png", 255, Dashboard.elements.moreBtn.options)



	--[[dxDrawLine(a, b, c, d, tocolor(255,255,255,255), 2)
	dxDrawLine(c, d, e, f, tocolor(255,255,255,255), 2)
	dxDrawLine(e, f, g, h, tocolor(255,255,255,255), 2)
	dxDrawLine(g, h, a, b, tocolor(255,255,255,255), 2)]]
end