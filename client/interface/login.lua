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
Login.elements.emailInput.x = Login.elements.circle.x + 0.2*screenX;
Login.elements.emailInput.y = 0.68*screenY;
Login.elements.emailInput.alpha = 255;
Login.elements.emailInput.content = "Hello world";
Login.elements.emailText = {}
Login.elements.emailText.x = Login.elements.circle.x + 0.2*screenX;
Login.elements.emailText.y = 0.63*screenY;
Login.elements.emailText.alpha = 255;
Login.elements.passwordInput = {}
Login.elements.passwordInput.x = Login.elements.circle.x + 0.2*screenX;
Login.elements.passwordInput.y = 0.8*screenY;
Login.elements.passwordInput.alpha = 255;
Login.elements.passwordInput.content = "*********";
Login.elements.passwordText = {}
Login.elements.passwordText.x = Login.elements.circle.x + 0.2*screenX;
Login.elements.passwordText.y = 0.75*screenY;
Login.elements.passwordText.alpha = 255;
Login.elements.button = {}
Login.elements.button.x = Login.elements.emailInput.x + 0.3*screenX+10;
Login.elements.button.y = 0.68*screenY;
Login.elements.button.w = 0.15*screenX;
Login.elements.button.h = 50;
Login.elements.button.alpha = 255;
Login.elements.button.options = {}


Login.rendering = true;

--[[
			[function] Login.init()
	
			* Initialise l'interface de connexion *
	
			Return: nill
]]
function Login.init()
	showCursor(true);
	addEventHandler("onClientRender", getRootElement(), Login.render);
end

--[[
			[function] Login.render()
	
			* Render *
	
]]

function Login.render()
	if Login.rendering then

		-- background
		dxDrawRectangle(Login.elements.background.x, Login.elements.background.y, screenX, 0.18*screenX, tocolor(0,109,180,Login.elements.background.alpha));
		--circle
		dxDrawImage(Login.elements.circle.x, Login.elements.circle.y, 0.18*screenX, 0.18*screenX, "client/files/ui-circle.png", 0,0,0,tocolor(255,255,255, Login.elements.circle.alpha));
		dxDrawImage(Login.elements.circle.x+10, Login.elements.circle.y+10, 0.18*screenX-20, 0.18*screenX-20, "client/files/sample.png", 0,0,0,tocolor(255,255,255,Login.elements.circle.alpha));
		-- input
		dxDrawText("Adresse email:", Login.elements.emailText.x, Login.elements.emailText.y, 0.3*screenX, 0.03*screenX, tocolor(255,255,255,Login.elements.emailText.alpha), 1.4);
		UI.input(Login.elements.emailInput.x, Login.elements.emailInput.y, 0.3*screenX, 0.03*screenX, Login.elements.emailInput.content, true, Login.elements.emailInput.alpha);

		-- input
		dxDrawText("Mot de passe:", Login.elements.passwordText.x, Login.elements.passwordText.y, 0.3*screenX, 0.03*screenX, tocolor(255,255,255,Login.elements.passwordText.alpha), 1.4);
		UI.input(Login.elements.passwordInput.x, Login.elements.passwordInput.y, 0.3*screenX, 0.03*screenX, Login.elements.passwordInput.content, true, Login.elements.passwordInput.alpha);

		UI.normalButton(Login.elements.button.x, Login.elements.button.y, Login.elements.button.w, Login.elements.button.h, "Log-in", Login.elements.button.alpha, Login.elements.button.options);
		dxDrawText("Register at www.thesimsmta.com", Login.elements.button.x, Login.elements.button.y+Login.elements.button.h+10, Login.elements.button.x+Login.elements.button.w, (Login.elements.button.y+Login.elements.button.h+10)*2, tocolor(255,255,255,255));
	end
end