<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="distribution" content="Global" />
		<meta name="author" content="Vean" />
		<meta name="robots" content="index,follow" />
		<meta name="description" content="Site Description." />
		<meta name="keywords" content="ots, open tibia server, ..." />
		{$head}
		<title>.:: NTO FUN ::.</title>
		<link rel="stylesheet" type="text/css" href="{$path}/templates/naruto/main.css" />
		<link href="{$path}/templates/naruto/favicon.png" rel="shortcut icon" />
	</head>
	<!--Google-->
	<script type="text/javascript">

	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', 'UA-15249041-2']);
	  _gaq.push(['_trackPageview']);

	  (function() {
	    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();

	</script>
	<body>
		<div id="vt_page">
			<div id="vt_header"></div>
			<div id="vt_container">
				<div id="vt_menu">
					<div id="vt_news_menu">
<center>
						<div class="header"></div></center>
						<ul>
							<li><a href="{$path}">Novidades</a></li>
						

						</ul>
					</div>
					<div id="vt_account_menu"><center>
						<div class="serv"></div></center>
						<ul>
							{if $logged == 1}
							<li><a href="{$path}/index.php/account/">Minha Conta</a></li>
							<li><a href="{$path}/index.php/p/v/pagseguro">Premium Points</a></li>
							<li><a href="{$path}/index.php/p/v/vantagensp">Vantagens Premium</a></li>
							<li><a href="{$path}/index.php/p/v/donationpaypal">Doação Paypal</a></li>
							<li><a href="{$path}/index.php/p/v/nubank">Doação TED</a></li>
							{else}
							<li><a href="{$path}/index.php/account/login">Premium Points</a></li>
							<li><a href="{$path}/index.php/p/v/vantagensp">Vantagens Premium</a></li>
							<li><a href="{$path}/index.php/account/login">Doação Paypal</a></li>
							<li><a href="{$path}/index.php/account/login">Doação TED</a></li>
							<li><a href="{$path}/index.php/account/create">Criar Conta</a></li>
							<li><a href="{$path}/index.php/account/login">Login</a></li>
							{/if}
						</ul>
					</div>
					<div id="vt_community_menu">
						<div class="comu"></div>
						<ul>
							<li><a href="{$path}/index.php/character/view">Procurar Personagem</a></li>
							<li><a href="{$path}/index.php/p/v/temporadatwo">Temporada 2</a></li>
							<li><a href="{$path}/index.php/guilds">Guilds</a></li>
							<li><a href="{$path}/index.php/p/v/fragers">Top fraggers</a></li>	
							<li><a href="{$path}/index.php/video">Videos</a></li>	
							<li><a href="{$path}/index.php/houses/main">Casas</a></li>	
							<li><a href="{$path}/index.php/p/v/deaths">Ultimas Mortes</a></li>						
							<li><a href="{$path}/index.php/highscores">Ranking</a></li>	
		                 	<li><a href="{$path}/index.php/character/online">Online</a></li>

						</ul>
					</div>
					<div class="info"></div>
					<ul>
							<li><a href="{$path}/index.php/p/v/personagens">Personagens</a></li>
					       <li><a href="{$path}/index.php/p/v/mapa">Mapa</a></li>
							<li><a href="{$path}/index.php/p/v/gallery">Passe de Batalha</a></li>
							<li><a href="{$path}/index.php/p/v/bans">Banidos NTO</a></li>
							<li><a href="{$path}/index.php/p/v/guildwars">War System</a></li>
							<li><a href="{$path}/index.php/p/v/hokagesystem">Hokage System</a></li>
							<li><a href="{$path}/index.php/p/v/tasksystem">Task System</a></li>
							</ul>
					</div>
				<div id="vt_content">
					{$main}
				</div>
				<div id="vt_panel">
					<div class="top">
						<div class="bot">
							<div id="vt_panel_buttons">
					<a href="https://linktr.ee/NTOFUN" class="button">
									 <span></span>
								</a>
								
								<a href="{$path}/index.php/p/v/gifts" class="button2"></a>
							<div class="vt_panel_module"><center>
								<div class="header">Server Status</div></centeR>
								{foreach from=$worlds key=id item=world}
								<div>
									<b>Servidor:</b> {$world} <br />
									<b>Status:</b>  
									{if $serverOnline[$id]}
										<span style="color: green;font-weight: bold;">Online</span><br />
										<b>Uptime:</b> {$serverUptime[$id]} <br />
										<b>Players:</b> {$serverPlayers[$id]}/{$serverMax[$id]}<br /><br />
									{else}
										<span style="color: red;font-weight: bold;">Offline</span>
									{/if}
								</div>

<center>
<div class="header">REDES SOCIAIS</div>
<a href="https://www.facebook.com/Naruto-Fun-Online-110397687358306">
<img src="{$path}/templates/naruto/images/facebook.png" alt="" /></a></li></a>
<a href="https://discord.gg/MJYeqee">
<img src="{$path}/templates/naruto/images/discordd.png" alt="" /></a></li></a>
</center>
<div>
{$poll} <br />
</div> 
								{/foreach}
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="vt_footer">
				<div class="column first">
				</div>
				<div class="column second">
					<p>2020 - NTO Fun			<p><small>Página Renderizada em: {$renderTime} {$admin}</small></p>
				</div>
				<div class="column third">

				</div>
			</div>
		</div>
	</body>
</html>