<html><head><style type="text/css">input.recover1 {margin-left: 11px;} input.recover2 {margin-left: 25px;} input.recover3 {margin-left: 18px;}</style></head></html> 
<?php 
require("config.php"); 
$ots = POT::getInstance(); 
$ots->connect(POT::DB_MYSQL, connection()); 
$SQL = $ots->getDBHandle(); 

function generatePassword($length) { 
    $vowels = 'aeiouyAEIOUY'; 
    $consonants = '1234567890bcdfghjkmnpqrstvwxzBCDFGHJKLMNPQRSTVWXZ'; 
  
    $password = ''; 
    $alt = time() % 2; 
    for ($i = 0; $i < $length; $i++) { 
        if ($alt == 1) { 
            $password .= $consonants[(rand() % strlen($consonants))]; 
            $alt = 0; 
        } else { 
            $password .= $vowels[(rand() % strlen($vowels))]; 
            $alt = 1; 
        } 
    } 
    return $password; 
} 

echo '<div class="message"><div class="title">Recover Interface - Account Lost</div></div><br><br>'; 

if(!$_POST) 
    echo '<form action="'.WEBSITE.'/index.php/p/v/recover" method="post"> 
        <small><b>Account Name:</b></small> <input type="password" name="account" class="recover1"/><br /><br> 
         <small><b>Player Name:</b></small> <input type="text" name="player" class="recover2"/><br /><br> 
         <small><b>Recovery Key:</b></small> <input type="text" name="key" class="recover3"/><br /><br> 
        <input type="submit" value="Recover - Create new Password"/><br /> 
        </form>'; 
else { 
    if(empty($_POST['player']) || empty($_POST['key']) || empty($_POST['account'])) 
        echo '<small><b><font color="red">You must fill all the boxes!</font></small></b><br><br> 
        <form action="'.WEBSITE.'/index.php/p/v/recover" method="post"> 
        <small><b>Account Name:</b></small> <input type="password" name="account" class="recover1"/><br /><br> 
         <small><b>Player Name:</b></small> <input type="text" name="player" class="recover2"/><br /><br> 
         <small><b>Recovery Key:</b></small> <input type="text" name="key" class="recover3"/><br /><br> 
        <input type="submit" value="Recover - Create new Password"/><br /> 
        </form>'; 
    else { 
        $check = $SQL->query('SELECT `name`, `key` FROM `accounts` WHERE `id` IN (SELECT `account_id` FROM `players` WHERE `name` LIKE "'.$_POST['player'].'");')->fetch(); 
        if(strtolower($check['name']) == strtolower($_POST['account']) && $check['key'] == $_POST['key']) { 
            $newPassword = generatePassword(8); 
            echo '<small><b><font color="green">Successfully changed password.</font><br> <br>Your new password is: </b></small><b><font color="red">'.$newPassword.'</font></b>'; 
            $SQL->query("UPDATE accounts SET password = '".sha1($newPassword)."' WHERE name LIKE '".$_POST['account']."';");  
        } 
        else 
            echo '<small><b><font color="red">The data you\'ve entered is wrong.</font></small></b><br><br> 
        <form action="'.WEBSITE.'/index.php/p/v/recover" method="post"> 
        <small><b>Account Name:</b></small> <input type="password" name="account" class="recover1"/><br /><br> 
         <small><b>Player Name:</b></small> <input type="text" name="player" class="recover2"/><br /><br> 
         <small><b>Recovery Key:</b></small> <input type="text" name="key" class="recover3"/><br /><br> 
        <input type="submit" value="Recover - Create new Password"/><br /> 
        </form>'; 
        } 
} 
?>