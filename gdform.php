<?php
	$request_method = $_SERVER["REQUEST_METHOD"];
	if($request_method == "GET")
	{
		$query_vars = $_GET;
	} 
	elseif ($request_method == "POST")
	{
		$query_vars = $_POST;
	}

	reset($query_vars);
	$t = date("U");
	$file = $_SERVER['DOCUMENT_ROOT'] . "\ssfm\gdform_" . $t;
	$fp = fopen($file,"w");

	while (list ($key, $val) = each ($query_vars)) 
	{
		fputs($fp,"<GDFORM_VARIABLE NAME=$key START>\r\n"); 
		fputs($fp,"$val\r\n");
		fputs($fp,"<GDFORM_VARIABLE NAME=$key END>\r\n");
		if ($key == "redirect") 
		{ 
			$landing_page = $val;
		}
	}

	fclose($fp);
	
	if ($landing_page != "")
	{
		header("Location: http://".$_SERVER["HTTP_HOST"]."/$landing_page");
	} 
	else 
	{
		header("Location: http://".$_SERVER["HTTP_HOST"]."/");
	}
?>