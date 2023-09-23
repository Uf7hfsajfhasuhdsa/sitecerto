<?php /* Smarty version 3.0rc1, created on 2012-09-30 19:20:23
         compiled from "templates/worgen\index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1330950688d67940230-42906123%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '87d9496489d6340df58c358e6295ed67914f79e2' => 
    array (
      0 => 'templates/worgen\\index.tpl',
      1 => 1349029220,
    ),
  ),
  'nocache_hash' => '1330950688d67940230-42906123',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="distribution" content="Global" />
		<meta name="author" content="Vean" />
		<meta name="robots" content="index,follow" />
		<meta name="description" content="Site Description." />
		<meta name="keywords" content="ots, open tibia server, ..." />
		<?php echo $_smarty_tpl->getVariable('head')->value;?>

		<title><?php echo $_smarty_tpl->getVariable('title')->value;?>
</title>
		<link rel="stylesheet" type="text/css" href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/templates/worgen/main.css" />
	</head>
	<body>
		<div id="vt_page">
			<div id="vt_header"></div>
			<div id="vt_container">
				<div id="vt_menu">
					<div id="vt_news_menu">
						<div class="header">News</div>
						<ul>
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
">Latest News</a></li>
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/bugtracker">Bug Tracker</a></li>
						</ul>
					</div>
					<div id="vt_account_menu">
						<div class="header">Account</div>
						<ul>
							<?php if ($_smarty_tpl->getVariable('logged')->value==1){?>
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/account/">Manage Account</a></li>
							<?php }else{ ?>
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/account/create">Create Account</a></li>
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/account/login">Login</a></li>
							<?php }?>
						</ul>
					</div>
					<div id="vt_community_menu">
						<div class="header">Community</div>
						<ul>
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/forum">Forum</a></li>	
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/character/view">Characters</a></li>
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/guilds">Guilds</a></li>
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/p/v/fragers">Top fraggers</a></li>	
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/video">Videos</a></li>	
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/houses/main">Houses</a></li>	
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/p/v/deaths">Latest Deaths</a></li>	
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/p/v/gallery">Gallery</a></li>	
							<li><a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/profile/community">Community</a></li>
						</ul>
					</div>
				</div>
				<div id="vt_content">
					<?php echo $_smarty_tpl->getVariable('main')->value;?>

				</div>
				<div id="vt_panel">
					<div class="top">
						<div class="bot">
							<div id="vt_panel_buttons">
								<a href="" class="button">
									Download Client
									<span>Official Worgen game client</span>
								</a>
								<a href="" class="button">
									SMS Shop
									<span>If you need something special</span>
								</a>
								<a href="" class="button">
									Server Forum
									<span>Lead discussions about server life</span>
								</a>
							</div>
							<div class="vt_panel_module">
								<div class="header">Server Status</div>
								<?php  $_smarty_tpl->tpl_vars['world'] = new Smarty_Variable;
 $_smarty_tpl->tpl_vars['id'] = new Smarty_Variable;
 $_from = $_smarty_tpl->getVariable('worlds')->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
if (count($_from) > 0){
    foreach ($_from as $_smarty_tpl->tpl_vars['world']->key => $_smarty_tpl->tpl_vars['world']->value){
 $_smarty_tpl->tpl_vars['id']->value = $_smarty_tpl->tpl_vars['world']->key;
?>
								<div>
									<b>World:</b> <?php echo $_smarty_tpl->getVariable('world')->value;?>
 <br />
									<b>Status:</b>  
									<?php if ($_smarty_tpl->getVariable('serverOnline')->value[$_smarty_tpl->getVariable('id')->value]){?>
										<span style="color: green;font-weight: bold;">Online</span><br />
										<b>Uptime:</b> <?php echo $_smarty_tpl->getVariable('serverUptime')->value[$_smarty_tpl->getVariable('id')->value];?>
 <br />
										<b>Players:</b> <?php echo $_smarty_tpl->getVariable('serverPlayers')->value[$_smarty_tpl->getVariable('id')->value];?>
/<?php echo $_smarty_tpl->getVariable('serverMax')->value[$_smarty_tpl->getVariable('id')->value];?>
<br /><br />
									<?php }else{ ?>
										<span style="color: red;font-weight: bold;">Offline</span>
									<?php }?>
								</div>
								<?php }} ?>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="vt_footer">
				<div class="column first">
					<a href=""><img src="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/templates/worgen/images/authornote.png" alt="Designed by Vean" /></a>
				</div>
				<div class="column second">
					<p>Copyrights &copy; 2010 by Worgen. <a href="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/index.php/credits">Credits</a>.</p>
					<p><small>Page rendered in: <?php echo $_smarty_tpl->getVariable('renderTime')->value;?>
 <?php echo $_smarty_tpl->getVariable('admin')->value;?>
</small></p>
				</div>
				<div class="column third">
					<a href=""><img src="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/templates/worgen/images/html_valid.png" alt="HTML Valid" /></a>
					<a href=""><img src="<?php echo $_smarty_tpl->getVariable('path')->value;?>
/templates/worgen/images/css_valid.png" alt="CSS Valid" /></a>
				</div>
			</div>
		</div>
	</body>
</html>