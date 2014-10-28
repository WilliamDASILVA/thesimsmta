--[[
	Interface - UI

	Description: Tous les elements servant a créer les interfaces
]]

UI = {}


--[[
			[function] UI.progressBar(x, y, width, height, pourcentage)
	
			* Crée une progressBar *
	
			Return: nill
]]

function UI.progressBar(x, y, width, height, pourcentage, alpha)
	if x and y and width and height and pourcentage then

		-- background left
		dxDrawImage(x, y, 24, height, "client/files/progress-back-left.png", 0,0,0,tocolor(255,255,255,alpha));
		-- background middle
		dxDrawRectangle(x+24, y, width-48, height, tocolor(0,86,142, alpha));
		-- background right
		dxDrawImage((x+24)+(width-48), y, 24, height, "client/files/progress-back-right.png", 0,0,0,tocolor(255,255,255,alpha));

		-- left
		dxDrawImage(x+2, y+2, 24, height-4, "client/files/progress-left.png", 0,0,0, tocolor(255,255,255,alpha));
		-- middle
		dxDrawImage((x+2)+(24), y+2, ((width-48-4)*pourcentage)/100, height-4, "client/files/progress-center.png", 0,0,0,tocolor(255,255,255, alpha));
		-- right
		dxDrawImage(x+24+(((width-48)*pourcentage)/100)-2, y+2, 24, height-4, "client/files/progress-right.png", 0,0,0, tocolor(255,255,255,alpha));


		



	end
end

--[[
			[function] UI.radiusRectangle(x, y, width, height)
	
			* Dessine un rectangle avec des bords ronds *
	
			Return: nill
]]
function UI.radiusRectangle(x, y, width, height, alpha)
	if x and y and width and height then
		-- top left
		dxDrawImage(x, y, 15, 15, "client/files/rectangle-top-left.png", 0,0,0, tocolor(255,255,255,alpha));
		-- top middle
		dxDrawRectangle(x+15, y, width-30, 15, tocolor(0,100,165, alpha));
		-- top right
		dxDrawImage((x+15)+(width-30), y, 15, 15, "client/files/rectangle-top-right.png", 0,0,0, tocolor(255,255,255,alpha));
		-- middle left
		dxDrawRectangle(x, y+15, width, height-30, tocolor(0,100,165,alpha));
		-- bottom left
		dxDrawImage(x, (y+15)+(height-30), 15,15, "client/files/rectangle-bottom-left.png", 0,0,0, tocolor(255,255,255,alpha));
		-- bottom middle
		dxDrawRectangle(x+15, (y+15)+(height-30), width-30, 15, tocolor(0,100,165,alpha));
		-- bottom right
		dxDrawImage((x+15)+(width-30), (y+15)+(height-30), 15, 15, "client/files/rectangle-bottom-right.png", 0,0,0,tocolor(255,255,255,alpha));
	end
end

--[[
			[function] UI.input(x, y, width, height, text, check)
	
			* Dessine un input *
	
			Return: nill
]]
function UI.input(x, y, width, height, text, alpha, options)
	if x and y and width and height and text then

		-- background
		dxDrawRectangle(x, y, width, height, tocolor(237,237,237,alpha));
		-- text
		dxDrawText(text, x+10, y, (x+10)+width, y+height, tocolor(0,109,180, alpha), 1.2, "arial", "left", "center");

		-- options
		if options then
			if options['focus'] then
				dxDrawRectangle(x, y, 5, height, tocolor(150,200,50, alpha));
			elseif options['check'] == true then
				check_image = "check_ok.png";
			elseif options['check'] == false then
				check_image = "check_no.png";
			end
		end

		if check_image then
			dxDrawImage((x+width)-(height-10)-5, y+5, (height-10), height-10, "client/files/"..check_image, 0,0,0,tocolor(255,255,255,alpha));
		end

	end
end

--[[
			[function] UI.normalButton(x, y, width, height, text, alpha, options)
	
			* Dessine un bouton normal *
	
			Return: nill
]]
function UI.normalButton(x, y, width, height, text, alpha, options)
	if x and y and width and height and text then

		local r, g, b = 220,220,220;
		if options then
			if options['hover'] then
				r, g, b = 255,255,255
			end
		end

		-- top left
		dxDrawImage(x, y, 15,15, "client/files/button_left_top.png", 0,0,0, tocolor(r,g,b, alpha));
		-- top middle
		dxDrawImage(x+15, y, width-30, 15, "client/files/button_middle_top.png", 0,0,0,tocolor(r,g,b, alpha));
		-- top right
		dxDrawImage(x+15+(width-30), y, 15,15, "client/files/button_right_top.png", 0,0,0,tocolor(r,g,b,alpha));
		-- left middle
		dxDrawImage(x, y+15, 15, height-30, "client/files/button_left_middle.png", 0,0,0,tocolor(r,g,b, alpha));
		-- middle
		dxDrawImage(x+15, y+15, width-30, height-30, "client/files/button_middle_middle.png", 0,0,0, tocolor(r,g,b,alpha));
		-- right middle
		dxDrawImage(x+15+(width-30), y+15, 15, height-30, "client/files/button_right_middle.png", 0,0,0, tocolor(r,g,b, alpha));
		-- bottom left
		dxDrawImage(x, y+15+(height-30), 15, 15, "client/files/button_left_bottom.png", 0,0,0, tocolor(r,g,b,alpha));
		-- bottom middle
		dxDrawImage(x+15, y+15+(height-30), width-30, 15, "client/files/button_middle_bottom.png", 0,0,0, tocolor(r,g,b, alpha));
		-- bottom right
		dxDrawImage(x+15+(width-30), y+15+(height-30), 15,15, "client/files/button_right_bottom.png", 0,0,0, tocolor(r,g,b, alpha));

		-- text
		dxDrawText(text, x+15, y+15, (x+15+width-30), (y+15+height-30), tocolor(255,255,255,alpha), 1.2, "default","center", "center", true);

	end
end