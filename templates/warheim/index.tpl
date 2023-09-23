<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- TemplateBeginEditable name="doctitle" -->
<title>{$title}</title>
<link rel="stylesheet" href="{$path}/templates/warheim/warheim.css" type="text/css" />
<!-- TemplateEndEditable -->
<!-- TemplateBeginEditable name="head" -->
<!-- TemplateEndEditable -->
{$head}
<!--[if IE]>
<style type="text/css"> 
/* place css fixes for all versions of IE in this conditional comment */
.thrColElsHdr #sidebar1, .thrColElsHdr #sidebar2 { padding-top: 30px; }
.thrColElsHdr #mainContent { zoom: 1; padding-top: 15px; }
/* the above proprietary zoom property gives IE the hasLayout it needs to avoid several bugs */
</style>
<![endif]--></head>

<body class="thrColElsHdr">

<div class="style1" id="container">
  <div id="sidebar1">
<div id="sidebar11">
<div id="sidebar12"><div id="loginimage"></div><form action="{$path}index.php/account/login.ide" method="post">
    <input type="text" name="name" value="Login" class="inputlogin" />
    <input type="password" name="pass" value="Password" class="inputlogin2" />
    <div id="loginsign"><table width="161" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="82"><div align="right">
          <input type="submit" class="login" value="" />
        </div></td>
        <td width="79"><a href="{$path}/index.php/account/create"><img src="{$path}templates/warheim/images/signupbutton.png" width="79" height="28" border="0" /></a></td>
      </tr>
      <tr>
        <td height="27">&nbsp;</td>
        <td class="style1"><div align="right"><a href="{$path}index.php/account/lost">Lost Account?</a></div></td>
      </tr>
    </table></div>
</form>
</div></div>
<div id="sidebar13"></div>
<div id="sidebar14">
  <div align="center">
    <table width="147" border="0" cellpadding="0" cellspacing="0">
      <tr>
       
      </tr>
      <tr>
      
      </tr>
      <tr>
        
      </tr>
      <tr>
        
      </tr>
      <tr>
       
      </tr>
      <tr>
        
      </tr>
      <tr>
        
      </tr>
      <tr>
        
      </tr>
    </table>
    </div>
</div>
  <!-- end #sidebar1 --></div>
  <div id="header">
    <h1>&nbsp;</h1>
    <div id="navhome"><a href="{$path}"><img src="{$path}templates/warheim/images/navhome.png" onmouseover="this.src='{$path}templates/warheim/images/bhome.png'" onmouseout="this.src='{$path}templates/warheim/images/navhome.png'" width="55" height="33" border="0" /></a></div>
    <div id="navaccount"><a href="{$path}/index.php/account/"><img src="{$path}templates/warheim/images/navaccount.png" onmouseover="this.src='{$path}templates/warheim/images/baccount.png'" onmouseout="this.src='{$path}templates/warheim/images/navaccount.png'" width="55" height="33" border="0" /></a></div>
    <div id="navnews"><a href="{$path}"><img src="{$path}templates/warheim/images/navnews.png" onmouseover="this.src='{$path}templates/warheim/images/bnews.png'" onmouseout="this.src='{$path}templates/warheim/images/navnews.png'" width="55" height="33" border="0" /></a></div>
    <div id="navguilds"><a href="{$path}/index.php/p/v/personagens"><img src="{$path}templates/warheim/images/navguilds.png" onmouseover="this.src='{$path}templates/warheim/images/bpersonagens.png'" onmouseout="this.src='{$path}templates/warheim/images/navguilds.png'" width="85" height="33" border="0" /></a></div>
    <div id="navforum"><a href="{$path}/index.php/forum"><img src="{$path}templates/warheim/images/navforum.png" onmouseover="this.src='{$path}templates/warheim/images/bdownload.png'" onmouseout="this.src='{$path}templates/warheim/images/navforum.png'" width="85" height="33" border="0" /></a></div>
    <div id="navshop"><a href="{$path}/index.php/p/v/gifts"><img src="{$path}templates/warheim/images/navshop.png" onmouseover="this.src='{$path}templates/warheim/images/bshop.png'" onmouseout="this.src='{$path}templates/warheim/images/navshop.png'" width="55" height="33" border="0" /></a></div>
  <!-- end #header --></div>
  <div id="sidebar2">
    <div id="sidebar22"><div id="top10" width="218" height="37" border="0"><div id="sidebar221">{include_php file='templates\warheim\topplayer.php'}</div></div></div>
    <div id="sidebar23">
      <div align="center"><img src="{$path}templates/warheim/images/sidebarstatus.png" />
        {foreach from=$worlds key=id item=world}{if $serverOnline[$id]}
        <table width="147" border="0" cellpadding="2" cellspacing="4">
          <tr>
            <td><div class="stylestatus">Server Status:</div></td>
            <td><div class="stylestatus2">Online</div></td>
          </tr>
          <tr>
            <td><div class="stylestatus">Players Online:</div></td>
            <td><div class="stylestatus2">{$serverPlayers[$id]}</div></td>
          </tr>
          <tr>
            <td><div class="stylestatus">Uptime:</div></td>
            <td><div class="stylestatus2">{$serverUptime[$id]}</div></td>
          </tr>
        </table>
        {else}
        <table width="147" border="0" cellpadding="2" cellspacing="4">
          <tr>
            <td><div class="stylestatus">Server Status:</div></td>
            <td><div class="stylestatus2">Offline</div></td>
          </tr>
          <tr>
            <td><div class="stylestatus">Players Online:</div></td>
            <td><div class="stylestatus2">---</div></td>
          </tr>
          <tr>
            <td><div class="stylestatus">Uptime:</div></td>
            <td><div class="stylestatus2">---</div></td>
          </tr>
        </table>
        {/if}{/foreach}
        </div>
      <div id="sidebar24">
      <div align="center"><p><img src="{$path}templates/warheim/images/sidebarsearch.png" width="218" height="37" /><p><form action="{$path}index.php/character/view" method="post">
        <input type="text" name="name" value="Digite aqui..." onfocus="this.value = ''" onblur="if(this.value == ''){ this.value = 'Digite aqui...'; }" class="inputsearch" /><br />
        <input type="submit" class="searchbutton" value="" />
        </form>
      </div>
      </div>
    </div>
	
	<div id="sidebara2">
	 <div align="center"><p><img src="{$path}templates/warheim/images/mainmenu.png" width="218" height="37" /></div></div>
	 
	 <div id="sidebari2">
	  <tr>
        <td><a href="{$path}"><img src="{$path}templates/warheim/images/menugallery.png" width="200" height="37" border="0" /></a></td>
      </tr>
	 </div>
	 
		 <div id="sidebari3">
	  <tr>
        <td><a href="{$path}/index.php/account/"><img src="{$path}templates/warheim/images/menuaccount.png" width="200" height="37" border="0" /></a></td>
      </tr>
	 </div> 
	 
	 		 <div id="sidebari4">
	  <tr>
        <td><a href="{$path}/index.php/p/v/premium"><img src="{$path}templates/warheim/images/menupremium.png" width="200" height="37" border="0" /></a></td>
      </tr>
	 </div> 
	 
	 	 		 <div id="sidebari5">
	  <tr>
        <td><a href="{$path}/index.php/p/v/personagens"><img src="{$path}templates/warheim/images/menucharacters.png" width="200" height="37" border="0" /></a></td>
      </tr>
	 </div> 
	 
	 <div id="sidebari6">
	  <tr>
        <td><a href="{$path}/index.php/p/v/tasksystem"><img src="{$path}templates/warheim/images/menutask.png" width="200" height="37" border="0" /></a></td>
      </tr>
	 </div> 
	 
	 
	 	<div id="sidebara3">
	 <div align="center"><p><img src="{$path}templates/warheim/images/gameplay.png" width="218" height="37" /></div></div>
	 
	 	 <div id="sidebari7">
	  <tr>
        <td><a href="{$path}/index.php/p/v/mapa"><img src="{$path}templates/warheim/images/menumap.png" width="200" height="37" border="0" /></a></td>
      </tr>
	 </div> 
	 
	 	 	<div id="sidebara4">
	 <div align="center"><p><img src="{$path}templates/warheim/images/systems.png" width="218" height="37" /></div></div>
	 
	 	 	 <div id="sidebari8">
	  <tr>
        <td><a href="{$path}/index.php/p/v/gallery"><img src="{$path}templates/warheim/images/menupasse.png" width="200" height="37" border="0" /></a></td>
      </tr>
	 </div> 
	 
	 	 	 	 <div id="sidebari9">
	  <tr>
        <td><a href="{$path}/index.php/p/v/gallery"><img src="{$path}templates/warheim/images/menuwar.png" width="200" height="37" border="0" /></a></td>
      </tr>
	 </div> 
	 
	 	 	 	 <div id="sidebari10">
	  <tr>
        <td><a href="{$path}/index.php/p/v/gallery"><img src="{$path}templates/warheim/images/menucrafting.png" width="200" height="37" border="0" /></a></td>
      </tr>
	 </div> 

	 	 	 	 <div id="sidebari11">
	  <tr>
        <td><a href="{$path}/index.php/p/v/gallery"><img src="{$path}templates/warheim/images/menuautolooting.png" width="200" height="37" border="0" /></a></td>
      </tr>
	 </div> 

	 	 	 	 <div id="sidebari12">
	  <tr>
        <td><a href="{$path}/index.php/p/v/gallery"><img src="{$path}templates/warheim/images/menuenchanting.png" width="200" height="37" border="0" /></a></td>
      </tr>
	 </div> 	 
	 
  <!-- end #sidebar2 --></div>
  <div id="mainContent"><div class="stylemain" div id="mainContent2"><div id="vt_content">{$main}
    <!-- end #mainContent --></div></div></div>
    <div id="footermain" align="center">
      <div class="stylefooter" id="copyright" align="center">Copyright © 2021 NTO FUN 2.0.<br />
        Designed and Coded by <a href="otland.net/members/reichsleiter">Knepper.</a><br />
      All Rights Reserved.<p>Page rendered in: {$renderTime} {$admin}</div>
  </div>
	<!-- This clearing element should immediately follow the #mainContent div in order to force the #container div to contain all child floats --><br class="clearfloat" />
  <!-- end #footer --></div>
<!-- end #container --></div>
</body>
</html>
