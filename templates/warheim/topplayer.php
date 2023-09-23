<?php
// Configuration
$maxGroupValue = 2;        // Maximum group id, players with higher group id than this won't be shown
$playersShowLimit = 5;    // How much positions should be shown
// -------------
include('config.php');

$ci =& get_instance();
$ci->load->database();

$loadPlayers = $ci->db->query("SELECT `name`, `group_id`, `world_id`, `level`, `vocation` FROM `players` WHERE `group_id` <= ".$maxGroupValue." ORDER BY `level` DESC LIMIT ".$playersShowLimit."");
?>
<div id="vt_modtopserverplayers">

    <table cellspacing="0" cellpadding="3" border="0" width="100%">
        <?php
        $counter = 1;
        foreach($loadPlayers->result() as $player):
        ?>
            <tr>
                <td width="19">

                <div class="number"><strong><?php echo $counter; ?>.</strong></div>
                </td>
                <td>                
                <?php echo $player->vocation; ?>
                </td>
                <td>
                <a href="<?php echo WEBSITE; ?>/index.php/character/view/<?php echo $player->name; ?>"><strong><?php echo $player->name; ?></strong></a><br />
                </td>
                <td>
                </td>
                <td>
                    <?php echo $player->level; ?> 
                </td>

            </tr>
        <?php
        $counter++;
        endforeach;
        ?>
        
    </table>
</div>