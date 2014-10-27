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
		dxDrawRectangle(x+15, y, width-30, 15, tocolor(0,100,165, 255));
		-- top right
		dxDrawImage((x+15)+(width-30), y, 15, 15, "client/files/rectangle-top-right.png", 0,0,0, tocolor(255,255,255,alpha));
		-- middle left
		dxDrawRectangle(x, y+15, width, height-30, tocolor(0,100,165,255));
		-- bottom left
		dxDrawImage(x, (y+15)+(height-30), 15,15, "client/files/rectangle-bottom-left.png", 0,0,0, tocolor(255,255,255,alpha));
		-- bottom middle
		dxDrawRectangle(x+15, (y+15)+(height-30), width-30, 15, tocolor(0,100,165,255));
		-- bottom right
		dxDrawImage((x+15)+(width-30), (y+15)+(height-30), 15, 15, "client/files/rectangle-bottom-right.png", 0,0,0,tocolor(255,255,255,alpha));
	end
end