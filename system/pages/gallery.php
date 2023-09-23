<script src="<?php echo WEBSITE;?>/public/js/ea.js" type="text/javascript"></script>
<script src="<?php echo WEBSITE;?>/public/js/slide.js" type="text/javascript"></script>
<style>

/*preload classes*/
.svw {width: 50px; height: 20px; background: #fff;}
.svw ul {position: relative; left: -999em;}

/*core classes*/
.stripViewer { 
position: relative;
overflow: hidden; 
border: 1px groove silver;  
padding: 1px;
overflow: hidden;
margin: 0 0 1px 0;
}
.stripViewer ul { /* this is your UL of images */
margin: 0;
padding: 0;
position: relative;
left: 0;
top: 0;
width: 1%;
list-style-type: none;
}
.stripViewer ul li { 
float:left;
}
.stripTransmitter {
overflow: auto;
width: 1%;
}
.stripTransmitter ul {
margin: 0;
padding: 0;
position: relative;
list-style-type: none;
}
.stripTransmitter ul li{
width: 20px;
float:left;
margin: 0 1px 1px 0;
}
.stripTransmitter a{
font: bold 10px Verdana, Arial;
text-align: center;
line-height: 22px;
background-color: #CCCCCC;
color: #fff;
text-decoration: none;
display: block;
}
.stripTransmitter a:hover, a.current{
background: #fff;
color: #ff0000;
}

/*tooltips formatting*/
.tooltip
{
padding: 0.5em;
background: #fff;
color: #000;
border: 5px solid #dedede;
}
</style>
<script type="text/javascript">
	$(window).bind("load", function() {
	$("div#mygalone").slideView()
});
</script>
<?php 
	$files = @glob("public/gallery/*.{png,jpg,bmp}", GLOB_BRACE);
	if(empty($files)) 
		alert("There are no pictures in the gallery.");
	else {
?>

<div>
<table width="100%">
<tr><td align="center" id="centralizado"><font size="5" color="black">~Passe de Batalha~</td></tr>
<tr><td align="center" id="centralizado"><font size="2" color="blue">\*Temporada 1*/</td></tr>
<tr>
<td align="center">
<table width="98%">
<tr><td align="center" id="centralizado"><font size="5" color="green">O que é o Passe de Batalha?</td></tr>
<tr>
<td><font size="2">*O Passe de Batalha é uma forma de atualizar o jogo a cada temporada.</font></td>
</tr>
<tr>
<td><font size="2">*Atualmente temos apenas uma categoria "ouro", que no caso apenas fazendo doação para obtê-la.</font></td>
</tr>
<tr><td align="center" id="centralizado"><font size="5" color="green">Qual a finalidade do Passe?</td></tr>
<tr>
<td><font size="2">*Nosso Passe de Batalha será composto por 40 escalões, a cada escalão upado você irá receber uma recompensa.</font></td>
</tr>
<tr><td align="center" id="centralizado"><font size="5" color="green">E como faço para upar 1 escalão?</td></tr>
<tr>
<td><font size="2">*Simples, no 2º andar do templo de Konoha, tem uma sala para quem tem acesso ao Passe, lá ficará o NPC de tasks.</font></td>
</tr>
<td><font size="2">*Você poderá fazer 1 task por dia, as tasks podem variar de WOLF até WHITE ZETSU, você terá 2 opções para escolher, dentre elas apenas 1 poderá ser escolhida.</font></td>
<tr>
<td><font size="2">*Ao terminar a task, irá retornar ao NPC e resgatar sua recompensa, basta usar o item "Star Up" que irá upar 1 escalão!</font></td>
<tr>
<tr><td align="center" id="centralizado"><font size="5" color="green">E quais são as recompensas?</td></tr>
<td><font size="2">*Você terá acesso ao um baú que fornecerá 30 Golds por dia.</font></td>
</tr>
<td><font size="2">*As recompensas do Passe de Batalha, está nas imagens a seguir!</font></td>
<tr>
</tr>
</table>
</td>
</tr>
</table>
</div>
<div id="mygalone" class="svw">
	<ul>
		<?php 
			foreach($files as $file) {
				echo '<li><img width="540" src="'.WEBSITE.'/'.$file.'"/></li>';
			}
		?>
	</ul>
</div>
<table width="100%">
<tr><td align="center" id="centralizado"><font size="3" color="black">Para melhor visualização de Recompensa, abra a imagem em uma nova guia!</td></tr>
<tr>
<td align="center">
<table width="98%">
<tr>
<tr>
<tr><td align="center" id="centralizado"><font size="4" color="green">Porque as recompensas começa no escalão 11?</td></tr>
</tr>
<tr>
<td><font size="2">*Quando você cria um personagem, ele ja vem com Passe no escalão 10, por tanto as recompensas começa no escalão 11 em diante.</font></td>
</tr>
</tr>
<tr><td align="center" id="centralizado"><font size="4" color="green">Como faço para usar/remover a skin?</td></tr>
</tr>
<tr>
<td><font size="2">*Lembrando, cada skin tem seu personagem específico.</font></td>
</tr>
<tr>
<td><font size="2">*Você simplesmente pode dar use no item, automaticamente a skin ficara salva em seu personagem, para tirar a skin basta usar o comando 'reverter'.</font></td>
</tr>
<tr>
<td><font size="2">*Após remover a skin, para adicionar ela novamente, basta você adquirir o item 'Armazenador de Skin' no NPC(Electronic Engineer) e dar use.</font></td>
</tr>
</table>
</td>
</tr>
</table>
<?php 
	}
?>
