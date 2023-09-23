
<div class='title'><img src="/templates/tibiacomm/layout/headline-warofemperium.gif"/></div>

        <?PHP
require("config.php");
$ots = POT::getInstance();
$ots->connect(POT::DB_MYSQL, connection());
$SQL = $ots->getDBHandle();
echo '<table border="0" cellspacing="1" cellpadding="5" width=100% class="cellspadding">
     <tr class="tableheader">
    <TD align="center"><TR BGCOLOR=#55555><TD><B>What is War of Emperium?</TD>
    </TR>
    </TABLE> 
    <table border="0" cellspacing="1" cellpadding="5" width=100% class="cellspadding">
			<tr class="tablerow"> 
				<TD width="30%"> 
					<center><b>objetivo</b><br />Como participar na Guerra do Emperium</center> 
				</TD> 
				<TD width="70%"> 
					<center>Todos os dias de terca, quinta, sabado e domingo as 5 da tarde (horario do Pacifico), a Guerra do Emperium comecara. O objetivo do evento e capturar o castelo e defende-la ate que o evento e mais (Dura 10 minutos). Qualquer pessoa pode participar neste evento e capturar o castelo enquanto eles estao em uma guilda.</center> 
				</TD> 
			</TR> 
			<tr class="tablerow"> 
				<TD width="30%"> 
					<center><b>Atacando o Castelo</b><br />Como obter energia do castelo.</center> 
				</TD> 
				<TD width="70%"> 
					<center>Para capturar o castelo, voce deve entrar dentro e derrotar os dois pre-emperiums. Uma vez que ambos os cristais sao destruidos, os portais se abrirao para o emperium final. Se sua guilda destroi o emperium final, voce deve defender o castelo ate que o evento tenha terminado.</center> 
				</TD> 
			</TR> 
			<tr class="tablerow">
				<TD width="30%"> 
					<center><b>Castelo de Defesa</b><br />Como posso defender o meu castelo guilds?</center> 
				</TD> 
				<TD width="70%"> 
					<center>Se o evento nao esta ativa, as guilds nao terao acesso ao seu castelo e e seguro contra intrusos. No entanto, durante o evento o seu castelo e vulneravel a ataques. Voce pode defender castelo com guardas ou por cura do seu proprio emperium.</center> 
				</TD> 
			</TR> 
			<tr class="tablerow"> 
				<TD width="30%"> 
					<center><b>O Governador do Castelo</b><br />Quais sao os beneficios de possuir um castelo?</center> 
				</TD> 
				<TD width="70%"> 
					<center>Quando voce controla o castelo, voce tera acesso a algo.</center> 
				</TD> 
			</TR> 
		</TABLE> 
		
		<br /> 
		<table border="0" cellspacing="1" cellpadding="5" width=100% class="cellspadding">
         <tr class="tableheader">
				<TD align="center"> 
					<center>Informacoes adicionais e Comandos</center> 
				</TD> 
			</TR> 
    </TABLE> 
    <table border="0" cellspacing="1" cellpadding="5" width=100% class="cellspadding">
			<tr class="tablerow">  
				<TD width="30%"> 
					<center><b>/woe info</b><br />Anybody</center> 
				</TD> 
				<TD width="70%"> 
					<center>Ver o proprietario atual do Castelo ou quando termina a Segunda Guerra do Emperium.</center>
				</TD> 
			</TR> 
			<tr class="tablerow">  
				<TD width="30%"> 
					<center><b><FONT color=darkred>!recall</b><br />Guild Leader</center> 
				</TD> 
				<TD width="70%"> 
					<center>Se voce estiver no interior do Castelo, voce pode se teleportar todos os membros da guild para voce. Isto tem um escape 5 minutos.</center> 
				</TD> 
			</TR> 
			<tr class="tablerow">  
				<TD width="30%"> 
					<center><b>Castle Banners</b><br />Guild Member</center> 
				</TD> 
				<TD width="70%"> 
					<center>Se voce usar um banner localizado no interior do castelo, voce sera teletransportado para o emperium, independentemente se o pre-emperiums sao quebrados.</center> 
				</TD> 
			</TR> 
			<tr class="tablerow"> 
				<TD width="30%"> 
					<center><b>Guard Lever</b><br />Guild Leader</center> 
				</TD> 
				<TD width="70%"> 
					<center>Se voce usar uma alavanca do localizado perto da emperium principal, voce vai gerar cinco guardas para ajudar a defender a custo de 30000gp.</center> 
				</TD> 
			</TR> 
		</TABLE> 
		
		<br /><br />';


$woe = $SQL->query("
	SELECT w.id AS id, w.time AS time, g.name AS guild, p.name AS name, w.started AS start, w.guild AS guild_id
		FROM woe AS w
	INNER JOIN players AS p
		ON p.id = w.breaker
	INNER JOIN guilds AS g
		ON g.id = w.guild
	ORDER BY id DESC LIMIT 10;	
")->fetchAll();

if(empty($woe)) {
	echo '
	<table border="0" cellspacing="0" cellpadding="5" width="100%" class="cellspadding">
     <tr class="tableheader">
    <TD align="center">Castle Governors</TD>
    </TR>
    <tr class="tablerow">
    <td align="center"><FONT color=red>Nenhuma batalha na WoE ainda Na Even.</td>
    </tr>
    </TABLE>
	';
} 
else 
{
foreach ($woe as $k=>$v) {
	echo "<table border='0' cellspacing='1' cellpadding='5' width=100% class='cellspadding'>
     <tr class='tableheader'>
     <TD><b><center>#</center></b></TD>
     <TD><b><center><FONT color=yellow>Winner Guild</b></TD>
     <TD><b><center><FONT color=yellow>Conquest by</center></b></TD>
     <TD><b><center><FONT color=yellow>Start time</center></b></TD>
     <TD><b><center><FONT color=yellow>Last conquest</center></b></td>
     <tr class='tablerow'>
			<TD>".$v["id"]."</TD>
			<TD><a href='".WEBSITE."/index2.php/guilds/view/".$v["guild_id"]."'>".$v["guild"]."</a></TD>
			<TD>".$v["name"]."</TD>
			<TD>" . date("d/m/y   H:i:s", $v["start"]) . "</TD>
			<TD>" . date("d/m/y   H:i:s", $v["time"]) . "</TD>
		</TR>
		</TABLE>
	";
	}
}

?>
