<!-- 
     #####################################################
    #SkillPix Gold Injection for ModernAAC, by Cybermaster#
     #####################################################
-->  

<!-- Progress bar widget, by Matthew Harvey (matt at smallish.com) --> 
<!-- Licensed under a Creative Commons Attribution-Share Alike 2.5 
License (http://creativecommons.org/licenses/by-sa/2.5/) -->
<style type="text/css"> 
    div.smallish-progress-wrapper 
    { 
        /* Don't change the following lines. */ 
        position: relative; 
    }
    div.smallish-progress-bar 
    { 
        /* Don't change the following lines. */ 
        position: absolute; 
        top: 0; 
        left: 0; 
        height: 100%; 
    } 
    div.smallish-progress-text 
    { 
        text-align: center; 
        position: relative; 
        font-weight: bold;
        text-shadow: 0 0 0.2em #FFFAFA, 0 0 0.2em #FFFAFA, 0 0 0.2em #FFFAFA;        
    } 
    div.skill-progress {
        border: 1px solid #ccc; 
        width: 38px; 
        background: #FFFAFA;
        margin: 0px auto -1px auto;
    }    
</style>  

<!-- Progress bar widget, by Matthew Harvey (matt at smallish.com) --> 
<!-- Licensed under a Creative Commons Attribution-Share Alike 2.5 
License (http://creativecommons.org/licenses/by-sa/2.5/) --> 
<script type="text/javascript"> 
    function drawProgressBar(color, width, percent, amount) 
    { 
        var pixels = width * (percent / 100);
        document.write('<div class="smallish-progress-wrapper" style="width: ' + width + 'px">'); 
        document.write('<div class="smallish-progress-bar" style="width: ' + pixels + 'px; background-color: ' + color + ';"></div>'); 
        document.write('<div class="smallish-progress-text" style="width: ' + width + 'px">' + amount + '</div>'); 
        document.write('</div>'); 
    } 
</script> 

<?php
    if (!defined('BASEPATH')) exit('No direct script access allowed');
    $player = $GLOBALS['player'];
    $GLOBALS['SQL'] = POT::getInstance()->getDBHandle();
    $DIR = '../../../injections/character_view/askills/';
    //Load vocations.xml
    $GLOBALS['XML'] = simplexml_load_file('/ntofun/data/XML/vocations.xml');

    //BG-COLORS
    $BG1 = '#F5F5F5'; //WhiteSmoke 
    $BG2 = '#E6E6FA'; //Lavender
    $BG3 = '#FFF8DC'; //Cornsilk
    $GLOBALS['base'] = array(50,50,50,50,30,100,20);            
    $bars = array('DEB887','ADFF2F','E9967A','D8BFD8','00FF7F','40E0D0','87CEEB');

    $skill = array
    (
        0 => array('Level','The level of a character is perhaps the single most important characteristic. As a rule, characters grow in power whenever their level increases, so the level is a good indicator of a character\'s overall strength. To advance in level characters must collect experience points. Whenever they have amassed enough points they will advance to the next level automatically.'),
        1 => array('Mag.Lv.','The magic level is similar to regular weapon skills in that it directly influences the power of a character\'s spells. Thus, a druid with a high magic level will restore more hit points when casting a healing spell than a druid of comparable experience who has a lower magic level. This way it is even possible for a low-level spellcaster to cast spells that are more powerful than those of some high-level characters.'),
        2 => array('Fist','This skill determines your character\'s ability to fight with bare hands. Needless to say, characters do not cause much damage when fighting unarmed, even if they have a considerable fist fighting skill.'),
        3 => array('Club','This is a weapon skill. It covers blunt weapons such as clubs, maces, staffs and hammers.'),
        4 => array('Sword','Another weapon skill. This skill is needed to use any kind of edged weapons, from puny knives to mighty giant swords.'),
        5 => array('Axe','Similar to other weapon skills, your character will need the corresponding skill to successfully wield any kinds of axe, from hatchets to the legendary Stonecutter Axe. Also, this skill covers pole weapons such as halberds and lances.'),
        6 => array('Dist.','This weapon skill covers all distance weapons. This includes thrown weapons such as stones and spears as well as bows and crossbows.'),
        7 => array('Shield','Shielding is the ability to successfully block enemy attacks with a shield. Of course, characters need to hold shields in their hands in order to use this skill. Note that it is not possible to block more than 2 opponents at a time.'),
        8 => array('Fishing','Fishing differs from other skills in that you must actively use it every single time you try to catch a fish. To use this skill characters need a fishing rod and some worms in their inventory. Worms can be found in some monsters or can be bought at shops that also sell fishing rods. Equipped with the fishing gear, you will have to find a place close to a river or some other body of water that contains fish. Once you have found a suitable place all you need to do is to use  the fishing rod on the water. Do not worry if you do not catch a fish immediately - your chance to catch one will increase with your fishing skill.')
    );
        
    function getTries($player_id, $skill_id) 
    {
        global $SQL;
        $result = $SQL->query('SELECT `count` FROM `player_skills` WHERE `player_id` = '.$player_id.' AND `skillid` = '.$skill_id.' LIMIT 1;')->fetch();
        return $result[0];
    }

    function getExperiencePercent($level, $exp) 
    {    
        $lv = $level-1;$eX = (((50*$lv*$lv*$lv)-(150*$lv*$lv)+(400*$lv))/3);
        $eXx = (((50*$level*$level*$level)-(150*$level*$level)+(400*$level))/3);
        return floor((($exp-$eX)/($eXx-$eX)*100));
    }

    function getManaSpentPercentage($level, $spent, $vocation, $promotion) 
    {    
        global $XML;
        $array = array();
        foreach($XML->vocation as $key=>$value){$array[] = $value['manamultiplier'];}
        $formula = floor(($spent/1600*pow($array,($level+1)-1))*100);
        return $formula > 99 ? 99 : $formula;
    }

    function getSkillTriesPercentage($skill, $level, $tries, $voc, $promotion) 
    {
        global $XML;
        global $base;
        $array = array();    
        foreach($XML->vocation as $vocation)
        {
            $tmp = array();
            foreach($vocation->skill->attributes() as $val)
            {
                $tmp[] = $val;
            }
            $array[] = $tmp;
        }
        $formula = floor(($tries/($base[$skill]*pow($array[$vocation+($promotion*4)][$skill],($level+1)-11))*100));
        return $formula > 99 ? 99 : $formula;
    }
        
    echo'<div class="message"><div class="title">SKILLS</div><div class="content"><center>
        <table align="center" width="80% border="0" cellpadding="4" cellspacing="0" class="houses_list_box">
        <tr align="center" bgcolor="'.$BG1.'">';
        
    //Skills Pics and Descriptions
    foreach($skill as $key=>$value){echo'<td><img src="'.$DIR.$key.'.gif" title="'.$value[1].'"/></td>';}

    //Skills Names
    echo '<tr align="center" bgcolor="'.$BG2.'">';
    foreach($skill as $key=>$value){echo'<td>'.$value[0].'</td>';}
    echo'</tr>';

    //Skills Stripes
    $a = 100;
    $b = getExperiencePercent($player->getLevel(),$player->getExperience());
    $c = $a-$b;
    echo'<tr bgcolor="'.$BG3.'">';
    echo'<td><div class="skill-progress" title="Needs '.$c.'% to level up.">
            <script type="text/javascript">drawProgressBar("#FFD700",38,'.$b.','.$player->getLevel().');</script>
        </div>
        </td>';

    $b = getManaSpentPercentage($player->getMagLevel(),$player->getManaSpent(), $player->getVocation(), $player->getPromotion());
    $c = $a-$b;
    echo'<td><div class="skill-progress" title="Needs '.$c.'% to level up.">
            <script type="text/javascript">drawProgressBar("#1E90FF",38,'.$b.','.$player->getMagLevel().');</script>
        </div></td>';
            
    foreach($bars as $key=>$value)
    {
        $b = getSkillTriesPercentage($key,$player->getSkill($key),getTries($player->getId(),$key),$player->getVocation(), $player->getPromotion());
        $c = $a-$b;
        echo'<td>';
        echo'
        
        <div class="skill-progress" title="Needs '.$c.'% to level up.">
            <script type="text/javascript">drawProgressBar("#'.$value.'",38,'.$b.','.$player->getSkill($key).');</script>
        </div>';
        echo'</td>';
    }
    echo'</tr></table></center></div></div>';
?>