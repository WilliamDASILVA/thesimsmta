--[[
	Interface - Login

	Description: Interface de connexion au serveur
]]


Login = {}

Login.elements = {}
Login.elements.circle = {}
Login.elements.circle.x = 0.3*screenX;
Login.elements.circle.y = 0.6*screenY;
Login.elements.circle.alpha = 255;
Login.elements.background = {}
Login.elements.background.x = Login.elements.circle.x+(0.18*screenX/2);
Login.elements.background.y = 0.6*screenY;
Login.elements.background.alpha = 255;
Login.elements.emailInput = {}
Login.elements.emailInput.x = Login.elements.background.x + 0.28*Login.elements.background.x;
Login.elements.emailInput.y = Login.elements.background.y + 0.1*Login.elements.background.y;
Login.elements.emailInput.width = 0.3*screenX;
Login.elements.emailInput.height = 0.03*screenX;
Login.elements.emailInput.alpha = 255;
Login.elements.emailInput.content = "test@test.com";
Login.elements.emailInput.options = {}
Login.elements.emailText = {}
Login.elements.emailText.x = Login.elements.background.x + 0.28*Login.elements.background.x;
Login.elements.emailText.y = Login.elements.background.y + 0.03*Login.elements.background.y;
Login.elements.emailText.alpha = 255;
Login.elements.passwordInput = {}
Login.elements.passwordInput.x = Login.elements.background.x + 0.28*Login.elements.background.x;
Login.elements.passwordInput.y = Login.elements.background.y + 0.3*Login.elements.background.y;
Login.elements.passwordInput.width = 0.3*screenX;
Login.elements.passwordInput.height = 0.03*screenX;
Login.elements.passwordInput.alpha = 255;
Login.elements.passwordInput.content = "";
Login.elements.passwordInput.value = "test";
Login.elements.passwordInput.masked = true;
Login.elements.passwordInput.options = {}
Login.elements.passwordText = {}
Login.elements.passwordText.x = Login.elements.background.x + 0.28*Login.elements.background.x;
Login.elements.passwordText.y = Login.elements.background.y + 0.23*Login.elements.background.y;
Login.elements.passwordText.alpha = 255;
Login.elements.button = {}
Login.elements.button.x = Login.elements.background.x + 1.1*Login.elements.background.x;
Login.elements.button.y = Login.elements.background.y + 0.1*Login.elements.background.y;
Login.elements.button.w = 0.15*screenX;
Login.elements.button.h = 50;
Login.elements.button.alpha = 255;
Login.elements.button.disabled = false;
Login.elements.button.options = {}
--[[
	ErrorDiv
]]
Login.elements.errorDiv = {}
Login.elements.errorDiv.x = 0.5*screenX;
Login.elements.errorDiv.y = 0.6*screenY;
Login.elements.errorDiv.width = 0.3*screenX;
Login.elements.errorDiv.height = 0.2*screenY;
Login.elements.errorDiv.alpha = 255;
Login.elements.errorDiv.visible = false;
Login.elements.errorDiv.text = "";
--[[
	Loading
]]
Login.elements.loading = {}
Login.elements.loading.x = Login.elements.background.x + 0.5*Login.elements.background.x;
Login.elements.loading.y = Login.elements.background.y + 0.1*Login.elements.background.y;
Login.elements.loading.w = 100;
Login.elements.loading.h = 100;
Login.elements.loading.rotation = 360;
Login.elements.loading.alpha = 255;
Login.elements.loading.enabled = false;

Login.elements.inputs = {}
Login.elements.inputs.email = {}
Login.elements.inputs.email.element = Login.elements.emailInput;
Login.elements.inputs.email.gotFocus = false;
Login.elements.inputs.password = {}
Login.elements.inputs.password.element = Login.elements.passwordInput;
Login.elements.inputs.password.gotFocus = false;

Login.elements.buttons = {}
Login.elements.buttons.login = {}
Login.elements.buttons.login.element = Login.elements.button;
Login.elements.buttons.login.functionToCall = "Login_doLogin";

Login.rendering = true;

--[[
			[function] Login.init()
	
			* Initialise l'interface de connexion *
	
			Return: nill
]]
function Login.init()
	showCursor(true);

	addEventHandler("onClientClick", getRootElement(), Login.click);
	addEventHandler("onClientRender", getRootElement(), Login.render);
	addEventHandler("onClientRender", getRootElement(), Login.mouseHover);
	addEventHandler("onClientCharacter", getRootElement(), Login.onCharacter);
	addEventHandler("onClientKey", getRootElement(), Login.onKey);

end

function Login.quit()
	removeEventHandler("onClientClick", getRootElement(), Login.click);
	removeEventHandler("onClientRender", getRootElement(), Login.render);
	removeEventHandler("onClientRender", getRootElement(), Login.mouseHover);
	removeEventHandler("onClientCharacter", getRootElement(), Login.onCharacter);
	removeEventHandler("onClientKey", getRootElement(), Login.onKey);

	Downloading.quit();

	-- create the town around
	call ( getResourceFromName ( "worldgen" ), "TownInit" )

	Player.init();
	Mouvement.init();
	Interaction.init();
	Camera.init();
	Dashboard.init();
	Cursor.init();

	-- 
end

--[[
			[function] Login.render()
	
			* Render *
	
]]
function Login.render()
	if Login.rendering then

		--[[
			Error div
		]]
		if Login.elements.errorDiv.visible then
			if Login.elements.errorDiv.opening then
				aX, aY = Misc.interpolateBetween(Login.elements.errorDiv.x, Login.elements.errorDiv.y, 0,Login.elements.errorDiv.x, Login.elements.errorDiv.y-0.07*screenX,0, Login.elements.errorDiv.startTick, 2000, "OutBounce");
			else
				aX, aY = Misc.interpolateBetween(Login.elements.errorDiv.x, Login.elements.errorDiv.y-0.07*screenX, 0,Login.elements.errorDiv.x, Login.elements.errorDiv.y,0, Login.elements.errorDiv.startTick, 2000, "OutBounce");
			end

			UI.radiusRectangle(aX, aY, Login.elements.errorDiv.width, Login.elements.errorDiv.height, Login.elements.errorDiv.alpha);
			dxDrawText(Login.elements.errorDiv.text, aX + 0.15*aX, aY + 0.12*aY,0,0, tocolor(255,255,255,255));
			dxDrawImage(aX + 0.05*aX, aY + 0.1*aY, 30,30,"client/files/check_no.png", 0,0,0, tocolor(255,255,255,255));
		end


		--[[
			Login panel
		]]
		-- background
		dxDrawRectangle(Login.elements.background.x, Login.elements.background.y, screenX, 0.18*screenX, tocolor(0,109,180,Login.elements.background.alpha));
		-- input
		dxDrawText("Adresse email:", Login.elements.emailText.x, Login.elements.emailText.y, 0.3*screenX, 0.03*screenX, tocolor(255,255,255,Login.elements.emailText.alpha), 1.4);
		UI.input(Login.elements.emailInput.x, Login.elements.emailInput.y, Login.elements.emailInput.width, Login.elements.emailInput.height, Login.elements.emailInput.content, Login.elements.emailInput.alpha, Login.elements.emailInput.options);

		-- input
		dxDrawText("Mot de passe:", Login.elements.passwordText.x, Login.elements.passwordText.y, 0.3*screenX, 0.03*screenX, tocolor(255,255,255,Login.elements.passwordText.alpha), 1.4);
		UI.input(Login.elements.passwordInput.x, Login.elements.passwordInput.y, 0.3*screenX, 0.03*screenX, Login.elements.passwordInput.content, Login.elements.passwordInput.alpha, Login.elements.passwordInput.options);

		UI.normalButton(Login.elements.button.x, Login.elements.button.y, Login.elements.button.w, Login.elements.button.h, "Connexion", Login.elements.button.alpha, Login.elements.button.options);
		dxDrawText("Register on thesimsmta.com", Login.elements.button.x, Login.elements.button.y+Login.elements.button.h+10, Login.elements.button.x+Login.elements.button.w, (Login.elements.button.y+Login.elements.button.h+10)*2, tocolor(255,255,255,255));

		-- waiting
		if(Login.elements.loading.enabled)then
			local rectAlpha = 150;
			if Login.elements.loading.opening then
				Login.elements.loading.alpha, _ = Misc.interpolateBetween(0,0,0,255,0,0,Login.elements.loading.startTick, 1000, "InQuad");
				rectAlpha, _ = Misc.interpolateBetween(0,0,0,150,0,0,Login.elements.loading.startTick, 1000, "InQuad");
			else
				Login.elements.loading.alpha, _ = Misc.interpolateBetween(255,0,0,0,0,0,Login.elements.loading.startTick, 1000, "InQuad");
				rectAlpha, _ = Misc.interpolateBetween(150,0,0,0,0,0,Login.elements.loading.startTick, 1000, "InQuad");
			end
			dxDrawRectangle(Login.elements.background.x, Login.elements.background.y, screenX, 0.18*screenX, tocolor(0,109,180,rectAlpha));

			if(Login.elements.loading.rotation <= 0)then
				Login.elements.loading.rotation = 360;
			end
			Login.elements.loading.rotation = Login.elements.loading.rotation - 15;
			dxDrawImage(Login.elements.loading.x, Login.elements.loading.y, Login.elements.loading.w, Login.elements.loading.h, "client/files/loading.png", Login.elements.loading.rotation,0,0, tocolor(255,255,255,Login.elements.loading.alpha));
		end

		--circle & avatar
		dxDrawImage(Login.elements.circle.x, Login.elements.circle.y, 0.18*screenX, 0.18*screenX, "client/files/ui-circle.png", 0,0,0,tocolor(255,255,255, Login.elements.circle.alpha));
		dxDrawImage(Login.elements.circle.x+10, Login.elements.circle.y+10, 0.18*screenX-20, 0.18*screenX-20, "client/files/sample.png", 0,0,0,tocolor(255,255,255,Login.elements.circle.alpha));
	end
end

--[[
			[function] Login.mouseHover()
	
			*  *
	
			Return: nill
]]
function Login.mouseHover()
	local cursorX, cursorY, _, _, _  = getCursorPosition();
	cursorX = cursorX*screenX;
	cursorY = cursorY*screenY;
	if(cursorX >= Login.elements.button.x and cursorX <= Login.elements.button.x+Login.elements.button.w and cursorY >= Login.elements.button.y and cursorY <= Login.elements.button.y + Login.elements.button.h)then
		Login.elements.button.options['hover'] = true;
	else
		Login.elements.button.options['hover'] = false;
	end
end

--[[
			[function] Login.click(button, state, x, y)
	
			* Quand l'utilisateur clique sur l'ecran *
	
			Return: nill
]]
function Login.click(button, state, x, y)
	if(button == "left" and state == "up")then
		-- inputs
		for i, v in pairs(Login.elements.inputs)do
			if(x >= v.element.x and x <= v.element.x + v.element.width and y >= v.element.y and y <= v.element.y + v.element.height)then
				v.gotFocus = true;
				v.element.options['focus'] = true;
				guiSetInputEnabled(true);
			else
				v.gotFocus = false;
				v.element.options['focus'] = false;
				
				-- vérifie l'input
				--[[for i, t in pairs(Login.elements.inputs)do
					if t ~= v then
						Login.checkInput(t);
					end
				end]]
			end
		end
		-- buttons
		for i, v in pairs(Login.elements.buttons)do
			if(x >= v.element.x and x <= v.element.x + v.element.w and y >= v.element.y and y <= v.element.y + v.element.h)then
				if not v.element.disabled then
					_G[v.functionToCall]();
					v.element.disabled = true;
				end
			end
		end



		local t = 0;
		for i, v in pairs(Login.elements.inputs)do
			if v.gotFocus then
				t = t+1;
			end
		end
		if t == 0 then
			guiSetInputEnabled(false);
		end
	end
end


--[[
			[function] Login.checkInput(v)
	
			* Vérifie si un input est correct *
	
			Return: true, false
]]
function Login.checkInput(v)
	if v then
		if v.element.content then
			if string.len(v.element.content) >= 5 then
				v.element.options['check'] = true;
			else
				v.element.options['check'] = false;
			end
		end
	else
		return false;
	end
end

--[[
			[function] Login.onCharacter(character)
	
			* Quand l'utilisateur tape quelque chose *
	
			Return: nill
]]
function Login.onCharacter(character)
	if character then
		for i, v in pairs(Login.elements.inputs)do
			if v.gotFocus then
				if(v.element.masked)then
					v.element.content = v.element.content.."*";
					v.element.value  = v.element.value..character;
				else
					v.element.content = v.element.content..character;
				end
			end
		end
	end
end

--[[
			[function] Login.onKey(button, pressOrRelease)
	
			* Quand l'utilisateur tape sur une touche *
	
			Return: nill
]]
Login.backspaceTimer = nil;
Login.backspaceTtimer = nil;
function Login.onKey(button, pressOrRelease)
	for i, v in pairs(Login.elements.inputs)do
		if v.gotFocus then
			if button == "backspace" and pressOrRelease then
				v.element.content = string.sub(v.element.content, 0, string.len(v.element.content)-1);
				if v.element.value then
					v.element.value = string.sub(v.element.value, 0, string.len(v.element.value)-1);
				end
				if Login.backspaceTtimer == nil then
					Login.backspaceTtimer = setTimer(function()
						if getKeyState("backspace") then
							Login.backspaceTimer = setTimer(Login.backspace, 80, 0);
							if Login.backspaceTtimer ~= nil then
								killTimer(Login.backspaceTtimer);
								Login.backspaceTtimer = nil;
							end
						end
					end, 1200, 1);
				end
			end
		end
	end
end

function Login.backspace()
	if getKeyState("backspace") then
		for i, v in pairs(Login.elements.inputs)do
			if v.gotFocus then
				v.element.content = string.sub(v.element.content, 0, string.len(v.element.content)-1);
				if v.element.value then
					v.element.value = string.sub(v.element.value, 0, string.len(v.element.value)-1);
				end
			end
		end
	else
		if Login.backspaceTimer then
			killTimer(Login.backspaceTimer);
			Login.backspaceTimer = nil;
		end
	end
end

--[[
			[function] Login_doLogin()
	
			* Transmet les données au serveur *
	
			Return: nil
]]
function Login_doLogin()
	if Login.elements.emailInput.content and Login.elements.passwordInput.value then
		Login.elements.loading.enabled = true;
		Login.elements.loading.startTick = getTickCount();
		Login.elements.loading.opening = true;
		triggerServerEvent("Login.doLogin", getLocalPlayer(), Login.elements.emailInput.content, Login.elements.passwordInput.value);
	end
end

--[[
			[function] Login.doError(string error)
	
			* Afficher une erreur *
	
			Return: nil
]]
function Login.doError(error)
	if error then
		-- got something
		for i, v in pairs(Login.elements.buttons)do
			if v.element.disabled then
				v.element.disabled = false;
			end
		end
		-- disable loading
		Login.elements.loading.enabled = false;
		Login.elements.loading.startTick = getTickCount();
		Login.elements.loading.opening = false;

		Login.elements.errorDiv.startTick = getTickCount();
		Login.elements.errorDiv.text = error;
		Login.elements.errorDiv.visible = true;
		Login.elements.errorDiv.opening = true;
		setTimer(function()
			Login.elements.errorDiv.opening = false;
			Login.elements.errorDiv.startTick = getTickCount();
		end, 3000,1);
	end
end

--[[
			[function] Login.doSuccess()
	
			* Met fin au panneau de connexion *
	
			Return: nil
]]
function Login.doSuccess()
	-- disable loading
	Login.elements.loading.enabled = false;
	Login.elements.loading.startTick = getTickCount();
	Login.elements.loading.opening = false;

	Login.quit();

end

--[[
	Event Handlers
]]
addEvent("Login.doError", true);
addEvent("Login.doSuccess", true);
addEventHandler("Login.doSuccess", getRootElement(), Login.doSuccess);
addEventHandler("Login.doError", getRootElement(), Login.doError);