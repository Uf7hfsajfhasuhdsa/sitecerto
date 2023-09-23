        <div class='message'>
        <div class='title'>War System</div>
        <div class='content'>
<?php
require("config.php");
$light = '#EBF8FF';
$dark = '#070707';
{
echo '
<div>
<table width="100%">
<tr><td align="center" id="centralizado"><font size="5" color="black">Comandos War System:</td></tr>
<tr>
<td align="center">
<table width="98%">
<tr>
<td><font size="2" color="red">/war invite, nome da guild, quantidade de kills, quantidade de money.</font><font size="2">  - exemplo: /war invite, FunGuild, 100, 100000</font></td>
</tr>
<tr>
<td><font size="2" color="red">/war accept</font><font size="2">  - aceita convite da war ex: /war accept, FunGuild.</font></td>
</tr>
<tr>
<td><font size="2" color="red">/war reject</font><font size="2">  - rejeita convite da war ex: /war reject, FunGuild.</font></td>
</tr>
<tr>
<td><font size="2" color="red">/war cancel</font><font size="2">  - cancela uma war em andamento ex: /war cancel, FunGuild</font></td>
</tr>
<tr>
<td><font size="2" color="red">/war end</font><font size="2">  - força o final da war ex: /war end, FunGuild.</font></td>
</tr>
<tr>
<td><font size="2" color="red">/balance</font><font size="2">  - mostra a quantidade de money.</font></td>
</tr>
</table>
</td>
</tr>
</table>
</div>
';
}
?>
</div></div>