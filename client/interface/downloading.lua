--[[
	Interface - Downloading

	Description: Quand l'utilisateur doit télécharger les fichiers necessaire
	au gamemode	
]]

Downloading = {}
Downloading.files = {
	"check.png",
	"check_no.png",
	"check_ok.png",
	"lights.png",
	"logo.png",
	"button_left_bottom.png",
	"button_left_middle.png",
	"button_left_top.png",
	"button_middle_bottom.png",
	"button_middle_middle.png",
	"button_middle_top.png",
	"button_right_bottom.png",
	"button_right_middle.png",
	"button_right_top.png",
	"camera_cursor.png",
	"progress-back-center.png",
	"progress-back-left.png",
	"progress-back-right.png",
	"progress-center.png",
	"progress-left.png",
	"progress-right.png",
	"ui-alu.png",
	"ui-button.png",
	"rectangle-bottom-left.png",
	"rectangle-bottom-right.png",
	"rectangle-top-left.png",
	"rectangle-top-right.png"
}

Downloading.noFiles = {}
Downloading.counting = 0;
Downloading.progression = 0;

Downloading.elements = {}
Downloading.elements.logo = {}
Downloading.elements.logo.alpha = 255;
Downloading.elements.progress = {}
Downloading.elements.progress.alpha = 255;
Downloading.elements.box = {}
Downloading.elements.box.alpha = 255;
Downloading.elements.light = {}
Downloading.elements.light.rotation = 0;
Downloading.elements.text = {}
Downloading.elements.text.content = "Veuillez attendre la fin du téléchargement...";


--[[
			[function] Downloading.init()
	
			* Initialise l'interface *
	
			Return: nill
]]
function Downloading.init()
	Downloading.doDownload();

	fadeCamera(true);
	setCameraMatrix(-2705,1367,68,-2662,1518,84);
	setWeather(14);
	setTimer(setTime, 1000, 0, 20, 0);
	setPlayerHudComponentVisible ("all", false);

	addEventHandler("onClientRender", getRootElement(), Downloading.render);
end

--[[
			[function] Downloading.end()
	
			* Fin du téléchargement *
	
			Return: nill
]]
function Downloading.quit()
	removeEventHandler("onClientRender", getRootElement(), Downloading.render);
end


function Downloading.doDownload()
	for i, v in pairs(Downloading.files)do
		if fileExists("client/files/"..v) == false then
			table.insert(Downloading.noFiles, v);
		end
	end
	if(#Downloading.noFiles == 0)then
		Downloading.progression = 100;
		Downloading.finish();
	else
		triggerServerEvent("Downloading.getFiles", getResourceRootElement(),  Downloading.noFiles);
	end
end

--[[
			[function] Downloading.request(filename)
	
			* Télécharger un fichier spécific *
	
			Return: nill
]]
function Downloading.request(fileName)
	if filename then
		if fileExists("client/files/"..fileName) == false then
			local file = {"client/files/"..fileName};
			triggerServerEvent("Downloading.getFiles", getResourceRootElement(), file);
		end
	end
end

--[[
			[function] Downloading.getFileContent(fileContent, fileName)
	
			* Crée le fichier *
	
			Return: nill
]]
function Downloading.getFileContent(fileContent, fileName)
	if fileContent and fileName then
		local file = fileCreate("client/files/"..fileName);
		if file then
			fileWrite(file, fileContent);
			fileClose(file);

			-- Fichié téléchargé
			Downloading.counting = Downloading.counting +1;
			Downloading.progression = math.floor((Downloading.counting * 100)/(#Downloading.noFiles));
			if(Downloading.progression == 100)then
				Downloading.finish();
			end
				
		else
			outputChatBox("Failled to create the file.");
		end
	else
		return false;
	end
end

--[[
			[function] Downloading.finish()
	
			* Met fin a la fenetre de telechargement *
	
			Return: nill
]]
function Downloading.finish()
	if Downloading.progression == 100 then
		Downloading.text = "Téléchargement terminé.";


	else
		return false;
	end
end

--[[
			[function] Downloading.render()
	
			* Render *
	
]]
function Downloading.render()
	if screenX and screenY then
		-- light
		if(Downloading.elements.light.rotation >= 360)then
			Downloading.elements.light.rotation = 0;
		else	
			Downloading.elements.light.rotation = Downloading.elements.light.rotation+1
		end
		dxDrawImage(0.5*screenX-(0.452*screenX/2), 0*screenY, 0.452*screenX, 0.452*screenY, "client/files/lights.png", Downloading.elements.light.rotation,0,0, tocolor(255,255,255,Downloading.elements.logo.alpha));

		-- logo
		dxDrawImage(0.5*screenX-(0.352*screenX/2), 0.05*screenY, 0.352*screenX, 0.26*screenX, "client/files/logo.png", 0,0,0, tocolor(255,255,255,255));

		-- box
		UI.radiusRectangle(0.5*screenX-(0.7*screenX/2), 0.7*screenY, 0.7*screenX, 0.15*screenX, Downloading.elements.box.alpha);
		-- bar
		UI.progressBar(0.5*screenX-(0.68*screenX/2), 0.8*screenY, 0.68*screenX, 0.06*screenX, Downloading.progression, Downloading.elements.progress.alpha);
		-- text
		dxDrawText(Downloading.elements.text.content, 0.5*screenX-(0.66*screenX/2), 0.73*screenY, 0,0, tocolor(255,255,255,255), 1.5);


	end
end

--[[
	Event Handlers
]]
addEvent("Downloading.getFileContent", true);
addEventHandler("Downloading.getFileContent", getRootElement(), Downloading.getFileContent);