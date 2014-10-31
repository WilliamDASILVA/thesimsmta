--[[
	Client - Main

	Description: Fichier principal appelé par le client,
	permet de gérer le client-side
]]

Client = {}
screenX, screenY = guiGetScreenSize();

--[[
			[function] Client.join()
	
			* Appelé lorsque l'utilisateur rejoins le jeu *
	
			Return: nill
]]
function Client.join()
	--[[
		Demarre le téléchargement des fichiers necessaires
	]]
	Downloading.init();
	--Login.init();
	--Camera.init();
	--Mouvement.init();
	--Interaction.init();
	--Player.init();

	--[[
		Demarre le theme
	]]
	--local theme = playSound("client/files/sounds/theme.ogg", true);
	--setSoundVolume(theme, 0.5);


end

--[[
	Events Handlers
]]
addEventHandler("onClientResourceStart", getResourceRootElement(), Client.join);