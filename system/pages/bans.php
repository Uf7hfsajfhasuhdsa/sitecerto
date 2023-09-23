<?php 

# Banishments Script 
# Version: 1.0 
# Author: Archez 
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */ 

require('config.php'); 

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */ 

$ots = POT::getInstance(); 
$ots->connect(POT::DB_MYSQL, connection()); 
$a = $ots->getDBHandle(); 

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */ 

# Number of bans to show 
$archez['limit'] = '15'; 

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */ 

$reason = array('Offensive Name', 'Invalid Name Format', 'Unsuitable Name', 'Name Inciting Rule Violation', 'Offensive Statement', 'Spamming', 'Illegal Advertising', 'Off-Topic Public Statement', 'Non-English Public Statement', 'Inciting Rule Violation', 'Bug Abuse', 'Game Weakness Abuse', 'Using Unofficial Software to Play', 'Hacking', 'Multi-Clienting', 'Account Trading or Sharing', 'Threatening Gamemaster', 'Pretending to Have Influence on Rule Enforcer', 'False Report to Gamemaster', 'Destructive Behaviour', 'Excessive Unjustified Player Killing', 'Invalid Payment', 'Spoiling Auction'); 

$data = $a->query('SELECT * FROM `bans`, `players` WHERE `players`.`account_id` = `bans`.`value` AND `bans`.`type` = 3 AND `bans`.`active` = 1 ORDER BY `bans`.`added` DESC LIMIT '.$archez['limit']); 
echo'<div class="bar">Banned Players</div><br />';
echo '<table border="0" width="100%"> 
<tr><td width="5%"><b>#</b></td><td width="25%"><b>Player</b></td><td width="30%"><b>Reason</b></td><td width="25%"><b>Imposed by</b></td><td width="15%"><b>Expires on</b></td></tr>'; 

$count = 0; 
foreach($data as $ban) { 

$count++; 

$player = $a->query('SELECT * FROM `players` WHERE `account_id` = '.$ban['value'].'')->fetch(); 
$staff = $a->query('SELECT * FROM `players` WHERE `id` = '.$ban['admin_id'].'')->fetch(); 

if($ban['admin_id'] == 0) { 
$staff['name'] = '<span style="font-size:10px;color:#e87300;">AUTOMATIC</span>'; 
} else { $staff['name'] = '<a href="'.WEBSITE.'/index2.php/character/view/'.strtolower($staff['name']).'">'.$staff['name'].'</a>'; 
} 

if($ban['expires'] == '-1') { 
$expires = '<span style="font-size:10px;color:#e80000;">PERMANENT</span>'; 
} else { 
$expires = '<span style="font-size:10px;">'.strtoupper(date('dS/F/Y', $ban['expires'])).'</span>'; 
} 

echo '<tr class="highlight"><td>'.$count.'</td><td><a href="'.WEBSITE.'/index2.php/character/view/'.strtolower($player['name']).'">'.$player['name'].'</a></td><td>'.$reason[$ban['reason']].'</td><td>'.$staff['name'].'</td><td>'.$expires.'</td></tr>'; 
} 

echo '</table>'; 

?>