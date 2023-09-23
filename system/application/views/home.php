<?php 
require("config.php");
$ide = new IDE;
try { $ide->loadInjections("home"); }catch(Exception $e) { error($e->getMessage());}

echo "<div id='tickers'>"; 
    $this->load->helper('text'); 
    ?> 
    <script type="text/javascript"> 
    $(document).ready(function() {  
        $(".tickerButton").each(function() {  
            $(this).click(function() { 
                if ($(this).html() == "-") 
                    $(this).html("+") 
                else 
                    $(this).html("-") 
                $(this).parent().find("span").each(function() { 
                    $(this).toggle(); 
                }); 
            }); 
        }); 
    }); 
    </script> 
    <?php 
    foreach($tickers['news'] as $value) { 
        echo '<div style="border: 1px black dotted; padding: 3px 3px 3px 3px; margin-bottom: 3px;"><a href="#" class="tickerButton">+</a>'.date('d M Y',$value['date']).', <span>'.word_limiter($value['text'], $config['newsTickerWords']).'</span><span style="display: none">'.$value['text'].'</span></div>'; 
        // 
    } 
    echo "</div><br/>";

foreach($news['news'] as $value) {
	echo "<div class='news'>";
	echo "<div class='newsTitle'>".$value['title']."</div>";
	echo "<div class='newsBody'>".$value['body']."</div>";	
	echo "<div class='newsFooter'>";	
	if($config['facebook']) {
		echo "<iframe src='http://www.facebook.com/widgets/like.php?href=".WEBSITE."/index.php/home/view/".$value['id']."' scrolling='no' frameborder='0'style='border: none; width: 400px; height: 24px;'></iframe><br/>";
	}
	echo "Posted on: ".UNIX_TimeStamp($value['time'])." </div>";
	echo "<div class='viewComments'><a href='".WEBSITE."/index.php/home/view/".$value['id']."'>View comments</a></div>";
	echo "</div>";
}
echo "<div class='readArchive'><a href='".WEBSITE."/index.php/home/archive'>Go to archive posts</a></div>";
?>