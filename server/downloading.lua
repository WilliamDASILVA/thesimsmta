

--[[
			[function] Downloading.getFiles(fileList)
	
			* Retourne les fichiers au client *
	
			Return: nill
]]
Downloading = {}

function Downloading.getFiles(fileList, functionToCall)
	for i, v in pairs(fileList)do
		if fileExists("client/files/"..v) == true then
			local file = fileOpen("client/files/"..v);
			local fileContent = fileRead(file, fileGetSize(file));
			fileClose(file);

			triggerClientEvent(client, "Downloading.getFileContent", client, fileContent, v, functionToCall);

		else
			outputChatBox("FILE NO EXIST", getRootElement());
		end
	end
end

--[[
	Event Handlers
]]
addEvent("Downloading.getFiles", true);
addEventHandler("Downloading.getFiles", getRootElement(), Downloading.getFiles);