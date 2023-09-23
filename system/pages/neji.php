<html>
    <head>
        <meta charset='utf-8'>
		<script type="text/javascript" src="https://server1.ntobrasil.com.br/public/js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="https://localhost//public/js/angular.min.js"></script>
    </head>
    <header>
        <center><h1 style="color: #ffba00; font-size: 40px; font-weight: bold" id="nomePersonagem">Neji</h1></center>
		<center>
		<h2 style="display:inline;color: #ffba00; font-size: 20px; font-weight: bold">VIDA & MANA/LVL :</h2>
		<h1 id="vida" style="display:inline;color: #ffba00; font-size: 20px; font-weight: bold"></h1>
		<h2 style="display:inline;color: #ffba00; font-size: 20px; font-weight: bold"> 380 / 380 </h2>
		<h1 id="mana" style="display:inline;color: #ffba00; font-size: 20px; font-weight: bold"></h1>
		<br>
		<h3 id="mana" style="display:inline;color: #0077ff; font-size: 20px; font-weight: bold"></h3>
		<h3 style="display:inline;color: #0077ff; font-size: 20px; font-weight: bold">Classe: Damage</h3>
		</br>
		</center>
    </header>
    <body>
    <div ng-app="myTable" ng-controller="tableCtrl">
    <center>
		<br>
        <img src="http://i.imgur.com/lFYewXS.png">
		<br>
		<br>
		<div style="display: inline-block; position: relative">
			<div style="padding:0px; margin: 0px; display: inline-block" ng-repeat="outfit in outfits">
				<div style="padding:10px">
					<img style="transform: scale(1)" align="center" src='/templates/naruto/personagens/neji.png'
				</div>
				<div style="font-weight: bold; padding: 5px 10px 0px 10px">
					
				</div>
			</div>
		</div>
    </center>
	<br>
    <center>
        <img src="http://i.imgur.com/QhkpcsS.png">
		<br><br>
            <table style="width:100%"  border="1px solid #666">
                <tr background-color="#04202b">
                    <th>Jutsu</th>    
                    <th>Nivel</th>    
                    <th>Ninjutsu</th>    
                    <th>Chakra</th>    
                    <th>Target</th>    
                    <th>Descrição</th>    
                </tr>
				<tr ng-repeat="spell in spells | orderBy:'lvl'">
                    <td> Hakke rokujuuyonshou </td>
                    <td> 75 </td>
                    <td> 60 </td>
                    <td> 3000 </td>
                    <td> sim </td>
                    <td>  </td>
                </tr>
				<tr ng-repeat="spell in spells | orderBy:'lvl'">
                    <td> Kaiten </td>
                    <td> 100 </td>
                    <td> 80 </td>
                    <td> 1000 </td>
                    <td> não </td>
                    <td> </td>
                </tr>
				<tr ng-repeat="spell in spells | orderBy:'lvl'">
                    <td> Hakke Hyakunijuuhachishou </td>
                    <td> 150 </td>
                    <td> 70 </td>
                    <td> 3500 </td>
                    <td> sim </td>
                    <td> </td>
                </tr>
				<tr ng-repeat="spell in spells | orderBy:'lvl'">
                    <td> Juukenhou Hakke </td>
                    <td> 200 </td>
                    <td> 100 </td>
                    <td> 4000 </td>
                    <td> sim </td>
                    <td> </td>
                </tr>
				<tr ng-repeat="spell in spells | orderBy:'lvl'">
                    <td> Byakugan </td>
                    <td> 200 </td>
                    <td> 100 </td>
                    <td> 10000 </td>
                    <td> não </td>
                    <td> Buff </td>
                </tr>
				<tr ng-repeat="spell in spells | orderBy:'lvl'">
                    <td> Juuken Ryuu </td>
                    <td> 250 </td>
                    <td> 110 </td>
                    <td> 4500 </td>
                    <td> sim </td>
                    <td> </td>
                </tr>
				<tr ng-repeat="spell in spells | orderBy:'lvl'">
                    <td> Hakke Hasangeki </td>
                    <td> 300 </td>
                    <td> 120 </td>
                    <td> 5000 </td>
                    <td> sim </td>
                    <td> </td>
                </tr>
				<tr ng-repeat="spell in spells | orderBy:'lvl'">
                    <td> Jukenpo Ichigekishin </td>
                    <td> 400 </td>
                    <td> 130 </td>
                    <td> 6000 </td>
                    <td> sim </td>
                    <td> </td>
                </tr>
				<tr ng-repeat="spell in spells | orderBy:'lvl'">
                    <td> byakugan max </td>
                    <td> 400 </td>
                    <td> 100 </td>
                    <td> 10000 </td>
                    <td> não </td>
                    <td> Buff </td>
                </tr>
				
            </table>
			<br><br>	
			<img src="http://i.imgur.com/i66o1Wk.png">
			<br>	
			<table style="width:100%"  border="1px solid #666">
                <tr background-color="#04202b">
                    <th>Jutsu</th>    
                    <th>Nivel</th>    
                    <th>Ninjutsu</th>    
                    <th>Chakra</th>    
                    <th>Target</th>    
                    <th>Descrição</th>     
                </tr>
				<br>	
                <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Skip </td>
                    <td> 1 </td>
                    <td> 0 </td>
                    <td> 10 </td>
                    <td> não </td>
                    <td> Jutsu para subir buracos. </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Powerdown </td>
                    <td> 1 </td>
                    <td> 0 </td>
                    <td> 10 </td>
                    <td> não </td>
                    <td> Jutsu para subir ninjutsu. </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Light </td>
                    <td> 1 </td>
                    <td> 0 </td>
                    <td> 10 </td>
                    <td> não </td>
                    <td> Jutsu para iluminar. </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Regeneration </td>
                    <td> 10 </td>
                    <td> 0 </td>
                    <td> 180 </td>
                    <td> não </td>
                    <td>  </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Chakra Feet </td>
                    <td> 10 </td>
                    <td> 0 </td>
                    <td> 200 </td>
                    <td> não </td>
                    <td>  </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Chakra Rest </td>
                    <td> 10 </td>
                    <td> 0 </td>
                    <td> 0 </td>
                    <td> não </td>
                    <td> Jutsu para curar mana. </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Throw Shuriken </td>
                    <td> 10 </td>
                    <td> 0 </td>
                    <td> 50 </td>
                    <td> sim </td>
                    <td>  </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Throw Kunai </td>
                    <td> 10 </td>
                    <td> 0 </td>
                    <td> 50 </td>
                    <td> sim </td>
                    <td>  </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Sense </td>
                    <td> 10 </td>
                    <td> 0 </td>
                    <td> 100 </td>
                    <td> não </td>
                    <td> Rastrear jogador. </td>
                </tr>	
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Jump </td>
                    <td> 15 </td>
                    <td> 0 </td>
                    <td> 100 </td>
                    <td> não </td>
                    <td> Jutsu para subir paredes. </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Kai </td>
                    <td> 20 </td>
                    <td> 0 </td>
                    <td> 100 </td>
                    <td> não </td>
                    <td> Jutsu para remover clones e criaturas. </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Chakra Defense </td>
                    <td> 20 </td>
                    <td> 0 </td>
                    <td> 500 </td>
                    <td> não </td>
                    <td> Jutsu que usa seu chakra como vida. </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Defense Kai </td>
                    <td> 20 </td>
                    <td> 0 </td>
                    <td> 500 </td>
                    <td> não </td>
                    <td> Jutsu que remove o efeito de chakra defense. </td>
                </tr>
				<tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Kunai Explosion </td>
                    <td> 50 </td>
                    <td> 0 </td>
                    <td> 1500 </td>
                    <td> sim </td>
                    <td> </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Fowado </td>
                    <td> 100 </td>
                    <td> 50 </td>
                    <td> 1500 </td>
                    <td> não </td>
                    <td> Jutsu para mudar alvo de criaturas para o jogador. </td>
                </tr>				
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Kawarimi no Jutsu Defensive </td>
                    <td> 150 </td>
                    <td> 100 </td>
                    <td> 1000 </td>
                    <td> não </td>
                    <td> Jutsu para se esquivar do inimigo. </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Big Regeneration </td>
                    <td> 150 </td>
                    <td> 0 </td>
                    <td> 500 </td>
                    <td> não </td>
                    <td>  </td>
                </tr>
				 <tr ng-repeat="defaultspell in defaultspells | orderBy:'lvl'">
                    <td> Concentrate Chakra Feet </td>
                    <td> 150 </td>
                    <td> 0 </td>
                    <td> 500 </td>
                    <td> não </td>
                    <td>  </td>
                </tr>				
            </table>
    </div>
    </center>
	<script type="text/javascript" src="https://localhost//public/js/mytable.js"></script>
	<script type="text/javascript" src="https://localhost//public/js/tableCtrl.js"></script>
    <style>
	
h1 {
  font-size: 72px;
  background: -webkit-linear-gradient(#ffba00, #ff9000);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  -webkit-text-stroke-width: 1px;
  -webkit-text-stroke-color: black;
}	

h2 {
  font-size: 72px;
  background: -webkit-linear-gradient(#ffba00, #ff9000);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  -webkit-text-stroke-width: 1px;
  -webkit-text-stroke-color: black;
}	

table {
  border-collapse: collapse;
  width: 50em;

}
thead {
  background: #ccc url(http://www.devfuria.com.br/html-css/tabelas/bar.gif) repeat-x left center;
  border-top: 1px solid #a5a5a5;
  border-bottom: 1px solid #a5a5a5;
}
thead tr:hover {
  background-color: transparent;
  color: inherit;
}
        
tr:nth-child(even) {
    background-color: #bcd8fc;
}
th {
  background-color: #7cb5ff;
  font-size: 12px;

}
th, td {
  padding: 0.1em 1em;
    text-align: center;
}
    </style>
    </body>  