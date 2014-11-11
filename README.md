The Sims MTA
==========

The Sims MTA is a Multi Theft Auto gamemode inspired by the Electronic Arts game The Sims 3.
The purpose of that is to offer a new game experience on MTA.
More informations below or in the forum topic: http://forum.mtasa.com/viewtopic.php?f=108&t=63188

Preview:<br />
Before starting the script, edit the file client/main.lua and make sure, in the function Client.join, there is only "Downloading.init();"<br />

#### How to set-up ?
<br />
To run this gamemode, you need a web server (XAMPP, EasyPHP, ...) with an MySQL database.<br />
Download the website files (www.github.com/WilliamDASILVA/thesimsmta-site) and past it on your web folder.<br />
Import the SQL database in PHPMyAdmin (https://github.com/WilliamDASILVA/thesimsmta-site/blob/master/database.sql).<br />
Make sure to edit the SQL log-in informations on core/model.php<br />
<br />
Import the gamemode files and the worldgen on <b>[gamemodes]/[sims]/sims</b> & <b>[gamemodes]/[sims]/worldgen</b> on your server.<br />
Add those resources as Admin, so they can use the function callRemote.<br />
<code>
  &lt;object name="resource.sims"&gt;&lt;/object&gt;
  &lt;object name="resource.worldgen"&gt;&lt;/object&gt;
</code>
<br />
Edit the calling URL for the both resources to your web server:<br />
<ul>
  <li><b>Sims</b> - sims/server/login.lua, you change the line 45, the URL(http://127.0.0.1/perso/thesimsmta/api/getUserInformations) to your URL (http://host/thesimsmta/api/getUserInformations)</li>
  <li>
    <b>Worldgen</b> - You do the same thing on worldgen/server/town.lua line 18
  </li>
</ul>

Once that is done, you can start the worldgen resource, then the sims resource. Just make sure that your webserver is running.
Connect to the game using those ids:<br />
Email: test@test.com<br />
Password: test<br />

Any questions about the installation, ask on <a href="http://forum.mtasa.com/viewtopic.php?f=108&t=63188">this topic</a> or contact me.

===========
Licence: GNU GPL v3
