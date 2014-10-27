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

	--[[
		Demarre le theme
	]]
	local theme = playSound("client/files/sounds/theme.ogg", true);


end

--[[
	Events Handlers
]]
addEventHandler("onClientResourceStart", getResourceRootElement(), Client.join);