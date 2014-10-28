--[[
	Server - Login
]]


Login = {}

--[[
			[function] Login.callBack(result)
	
			* Callback  *
	
			Return: nil
]]
function Login.callBack(result, player)
	if(result ~= "ERROR")then
		if(result['error'])then
			Login.doError(result['error'], player);
		else
			if(result['success'] == "ok")then
				outputChatBox(result['data']['password']);
			else
				Login.doError("Auth. server problem", player)
			end
		end
	else
		Login.doError("Couldn't access the auth. server", player);
	end
end

--[[
			[function] Login.doLogin(email, password)
	
			* Connecte l'utilisateur *
	
			Return: nil
]]
function Login.doLogin(email, password)
	if email and password then
		callRemote("http://127.0.0.1/perso/thesimsmta/api/getUserInformations", Login.callBack, client, email, password);
	else
		return false;
	end
end

--[[
			[function] Login.doError(string message, element player)
	
			* Affiche une erreur *
	
			Return: nil
]]
function Login.doError(message, player)
	if message and player then
		triggerClientEvent(player, "Login.doError", player, message);
	else
		return false;
	end
end


--[[
	Event Handlers
]]
addEvent("Login.doLogin", true);
addEventHandler("Login.doLogin", getRootElement(), Login.doLogin);