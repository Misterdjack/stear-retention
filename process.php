<?php

    $to = "darrenjack79@yahoo.com"; 
    $from = $_REQUEST['email']; 
    $name = $_REQUEST['name']; 
    $headers = "From: $from"; 
    $subject = "You have a request for more information on your STEAR site"; 

    $fields = array(); 
    $fields{"icon_first"} = "icon_first"; 
    $fields{"icon_last"} = "icon_last"; 
    $fields{"email"} = "email"; 
    $fields{"phone"} = "phone"; 
    $fields{"message"} = "message";

    $body = "Here is what was sent:\n\n"; foreach($fields as $a => $b){   $body .= sprintf("%20s: %s\n",$b,$_REQUEST[$a]); }

    $send = mail($to, $subject, $body, $headers);

?>