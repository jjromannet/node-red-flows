<?php
header('Content-Type: application/json');
include 'configs.php';
$mysqli = new mysqli($dbConfig['host'],$dbConfig['user'],$dbConfig['pass'],$dbConfig['db']);
if($mysqli->connect_error)
{
    echo("$mysqli->connect_errno: $mysqli->connect_error");
}else{
if($_GET['action']=="GETMAX"){
	$sql = "SELECT MAX(id) FROM `temperatures`";
	$result = $mysqli->query($sql);
	$resp = "";
	while ($row = $result->fetch_array(MYSQLI_NUM)){
		$resp = $row[0];
	}
	echo "{\"resp\": \"$resp\"}";
}else if($_GET['action']=="UPLOADDATA"){
	$postdata = print_r($_POST, true);
	$postdata .= $HTTP_RAW_POST_DATA ;
	$firstLineEnds = strpos($HTTP_RAW_POST_DATA, "\n");
	$signature = substr ( $HTTP_RAW_POST_DATA , 0 , $firstLineEnds);
	$sql = substr ( $HTTP_RAW_POST_DATA , $firstLineEnds+1, 10240); // limit input to limit hash collisions possibilities
	$authorised = false;
	$serverSideSignature = hash ( 'sha256' , $sql);
	if($serverSideSignature == $signature){
		$result = $mysqli->query($sql);
		$authorised = true;
	}
	
	$fp = fopen("synced{$config['randomLogFileSuffix']}.txt", "a+");
	fputs($fp, time()."\r\n".$postdata."\r\n"."signature valid: ".($authorised ? "true" : "false" )."\r\n\r\n");
	fclose($fp);
	
}

}
$mysqli->close();
?>