        <div class='message'>
        <div class='title'>Tasks System</div>
        <div class='content'>
<?php
require("config.php");
$light = '#EBF8FF';
$dark = '#070707';
{
echo '
<div>
<table width="100%">
<tr><td align="center" id="centralizado"><font size="5" color="black">Tasks (!task):</td></tr>
<tr>
<td align="center">
<table width="98%">
<tr>
<tr><td align="center" id="centralizado"><font size="2" color="black">Pode conter alterações não especificadas nessa página.</td></tr>
</tr>
<tr><td align="center" id="centralizado"><font size="3" color="black">Nome / Quantidade / Rewards.</td></tr>
</tr>
<td><font size="2" color="red">Wolf [50]</font><font size="2"> = points = 2, exp = 20000, money = 20000.
</tr>
<tr>
<td><font size="2" color="red">Chunnin [50]</font><font size="2">  = points = 2, exp = 25000, money = 30000.</font></td>
</tr>
<tr>
<td><font size="2" color="red">Naruto [60]</font><font size="2">  = points = 2, exp = 30000, money = 30000.</font></td>
</tr>
<tr>
<td><font size="2" color="red">Gaara [80]</font><font size="2">  = points = 2, reward = 100 Sand Shurikens, exp = 40000, money = 30000.</font></td>
</tr>
<tr>
<td><font size="2" color="red">Orochimaru Snake [80]</font><font size="2">  = points = 2, exp = 50000, money = 40000.</font></td>
</tr>
<tr>
<td><font size="2" color="red">Jounnin [120]</font><font size="2">  = points = 2, exp = 10000, money = 5000.</font></td>
</tr>
<td><font size="2" color="red">Haku [130]</font><font size="2">  = points = 2, exp = 12000, money = 7000.</font></td>
</tr>
<td><font size="2" color="red">Jiroubo [135]</font><font size="2">  = points = 2, exp = 8000, money = 8000.</font></td>
</tr>
<td><font size="2" color="red">Tayuya [150]</font><font size="2">  = points = 2, exp = 12000, money = 8200.</font></td>
</tr>
<td><font size="2" color="red">Gamaken [200]</font><font size="2">  = points = 3, exp = 8000, money = 8500.</font></td>
</tr>
<td><font size="2" color="red">Shinobi Star [200]</font><font size="2">  = points = 3, exp = 9000, money = 9000.</font></td>
</tr>
<td><font size="2" color="red">Anbu [200]</font><font size="2">  = points = 3, exp = 20000, money = 15000.</font></td>
</tr>
<td><font size="2" color="red">Shinobi Of The Blades [400]</font><font size="2">  = points = 3, exp = 25000, money = 11000.</font></td>
</tr>
<td><font size="2" color="red">Red Shaolin [400]</font><font size="2">  = points = 3, exp = 20000, money = 32000.</font></td>
</tr>
<td><font size="2" color="red">Black Shinobi [400]</font><font size="2">  = points = 3, exp = 22000, money = 15000.</font></td>
</tr>
<td><font size="2" color="red">Black Anbu [600]</font><font size="2">  = points = 3, reward = 1 Stamina Refil, 50 Soldado Phills, 50 Big Shurikens, exp = 25000, money = 18000.</font></td>
</tr>
<td><font size="2" color="red">Unknow Akatsuki [750]</font><font size="2">  = points = 4, reward = 1 Akatsuki Hat, 50 Soldado Phills, exp = 28000, money = 26000.</font></td>
</tr>
<td><font size="2" color="red">Manda [700]</font><font size="2">  = points = 3, reward = 1 Orochimaru Boots, exp = 30000, money = 35000.</font></td>
</tr>
<td><font size="2" color="red">Perfect Anbu [1000]</font><font size="2">  = points = 3, reward = 1 Orochimaru Boots, exp = 30000, money = 35000.</font></td>
</tr>
<td><font size="2" color="red">Lider Guard [1000]</font><font size="2">  = points = 7, reward = 1 Anbu Mask #2, 300 Soldado Phills, exp = 30000, money = 35000.</font></td>
</tr>
<td><font size="2" color="red">Kyodaijya [1200]</font><font size="2">  = points = 8, reward = 1 Unknow Boots, exp = 66600, money = 66000.</font></td>
</tr>
<tr><td align="center" id="centralizado"><font size="5" color="black">Tasks Boss (!missao):</td></tr>
<tr>
<tr><td align="center" id="centralizado"><font size="2" color="black">Pode conter alterações não especificadas nessa página.</td></tr>
</tr>
<tr><td align="center" id="centralizado"><font size="3" color="black">Nome / Rewards.</td></tr>
</tr>
<td><font size="2" color="red">Sasori Boss</font><font size="2"> = exp = 750000, premios = Akatsuki Coat.
</tr>
<td><font size="2" color="red">Deidara Boss</font><font size="2"> = exp = 750000, premios = Gaara Coat, Vital Boots.
</tr>
<td><font size="2" color="red">Kisame Boss</font><font size="2"> = exp = 750000, premios = Akatsuki Coat, Shark Absorb Sword.
</tr>
<td><font size="2" color="red">Itachi Boss</font><font size="2"> = exp = 750000, premios = Akatsuki Coat, Itachi Gloves.
</tr>
<td><font size="2" color="red">Hidan Boss</font><font size="2"> = exp = 750000, premios = Third Scythe, 100 Golds.
</tr>
<td><font size="2" color="red">Kakuzu Boss</font><font size="2"> = exp = 750000, premios = Chakra Eletric Katana, Kage Boots.
</tr>
<td><font size="2" color="red">Orochimaru Akatsuki Boss</font><font size="2"> = exp = 750000, premios = Akatsuki Coat, Subordinate Belt.
</tr>
<td><font size="2" color="red">Ultimate Pain Boss</font><font size="2"> = exp = 800000, premios = Akatsuki Legs, Hokage Coat.
</tr>
<td><font size="2" color="red">Kimimaro Boss</font><font size="2"> = exp = 150000, premios = 75 Golds, Kimimaro Column, 50 Big Shurikens.
</tr>
<td><font size="2" color="red">Zabuza Boss</font><font size="2"> = exp = 30000, premios = Zabuza Sword.
</tr>
<td><font size="2" color="red">Gaara Boss</font><font size="2"> = exp = 100000, premios = Gaara Legs, 20 Golds.
</tr>
<td><font size="2" color="red">Kabuto Boss</font><font size="2"> = exp = 400000, premios = Speed Boots, 20 Golds, Orochimaru Tunic.
</tr>
<td><font size="2" color="red">Kiba Boss</font><font size="2"> = exp = 30000, premios = Kiba Tunic, TaiJutsu Glove.
</tr>
<td><font size="2" color="red">Neji Boss</font><font size="2"> = exp = 30000, premios = Hyuuga Shirt, 50 Dollares.
</tr>
<td><font size="2" color="red">Sasuke Boss</font><font size="2"> = exp = 70000, premios = Sasuke Legrobe, Sasuke Ultimate Shirt, 80 Golds, Chakra Eletric Katana.
</tr>
<td><font size="2" color="red">Tobirama Boss</font><font size="2"> = exp = 500000, premios = Nidaime Armor, 50 Golds.
</tr>
<td><font size="2" color="red">Orochimaru Boss</font><font size="2"> = exp = 80000, premios = Orochimaru Tunic.
</tr>
<td><font size="2" color="red">Kakashi Boss</font><font size="2"> = exp = 80000, premios = Kakashi Mask, 100 Elite Shurikens.
</tr>
<td><font size="2" color="red">Jiraya Boss</font><font size="2"> = exp = 150000, premios = Absorved Chakra Taijutsu.
</tr>
<td><font size="2" color="red">Raikage Boss</font><font size="2"> = exp = 800000, premios = Kage Gloves, 200 Golds.
</tr>
<td><font size="2" color="red">Naruto Boss</font><font size="2"> = exp = 70000, premios = Ultimate Glove.
</tr>
<td><font size="2" color="red">Half Gaara Boss</font><font size="2"> = exp = 30000, premios = Anbu Armor.
</tr>
<td><font size="2" color="red">Kazekage Boss</font><font size="2"> = exp = 150000, premios = Kazekage Coat.
</tr>
<td><font size="2" color="red">Sasuke Akatsuki Boss</font><font size="2"> = exp = 750000, premios = Akatsuki Coat, Double Sasuke Sword.
</tr>
<td><font size="2" color="red">Killer Bee Boss</font><font size="2"> = exp = 750000, premios = Sealed Sword, Nidaime Protector.</font></td>
</tr>
<td><font size="2" color="red">Tenten Boss</font><font size="2"> = exp = 150000, premios = Kunai Explosion, 50 Golds.</font></td>
</tr>
<tr><td align="center" id="centralizado"><font size="2" color="Green">Atualizado 08/09/20.</td></tr>
</tr>
</table>
<tr>
</td>
</tr>
</table>
</div>
';
}
?>
</div></div>