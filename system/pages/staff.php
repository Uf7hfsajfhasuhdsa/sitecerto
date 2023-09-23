<?PHP
 /* * * * * * * * * * * * * * * * * * * * * * * * * *  
* Improved Support List                              *
* Adapted for Modern AAC by Cybermaster               *
* Original from AchTung                                *
* Credits to Gesior(Standard Version)                   *
* Credits to Zonet(Improved the PHP script with css part)*
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
require("config.php");
$ots = POT::getInstance();
$ots->connect(POT::DB_MYSQL, connection());
$SQL = $ots->getDBHandle();

//IMPORTANT!! SET SERVER DIR HERE \/
$config['site']['server_path'] = "C:\Users\Leonardo\Desktop\Servidor NTORevenge";

if($groups = simplexml_load_file($config['site']['server_path'].'/data/XML/groups.xml') or die('<strong>Could not load groups!</strong>')) 
    foreach($groups->group as $g)   
        $groupList[(int)$g['id']] = $g['name']; 
        $list = $SQL->query("SELECT `name`, `online`, `group_id`, `world_id` FROM `players` WHERE `group_id` > 1 ORDER BY `group_id` DESC");
        $showed_players = 0;
        echo'<div class="bar"><center>Support in game</center></div><br/><br/><br/>';
        $headline = '<table class="houses_list_box" border="0" cellspacing="0" cellpadding="4" width="100%">
        <tr class="bar"><td class="house_title" width="30%"><strong>Grupo</strong>    </td>
        <td class="house_title" width="35%"><strong>Nome</strong></td>
        <td class="house_title" width="15%"><strong>Status</strong></td>
        <td class="house_title" width="20%"><strong>Mundo</strong></td>'; 
        
        $group_id = 0;
        foreach($list as $gm)
        {
            if($group_id != (int)$gm['group_id']) 
                { 
                    if($group_id != 0) 
                        echo'</table><br />'; 
                        echo $headline; 
                        $group_id = (int)$gm['group_id']; 
                } 
            echo'<tr class="over"><td>'.$groupList[(int)$gm['group_id']].'</td><td><a class="link" href="'.WEBSITE.'/index.php/character/view/'.$gm['name'].'">'.$gm['name'].'</a></td><td><font color="'.($gm['online'] == 0 ? 'red">Offline' : 'green">Online').'</font></td><td>'.$config['worlds'][$gm['world_id']].'</td></tr>'; 
        } 
    echo'</table>'; 
?>    
<style type="text/css"> 
        tr.over:hover { 
        background-color: #FAFAD2; 
        }
        .link {text-decoration: none;font-weight:bold;color:black;}
        .more {    display: none;}
</style>