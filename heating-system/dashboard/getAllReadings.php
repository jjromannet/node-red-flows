<?php
include 'configs.php';
$mysqli = new mysqli($dbConfig['host'],$dbConfig['user'],$dbConfig['pass'],$dbConfig['db']);
if($mysqli->connect_error)
{
    echo("$mysqli->connect_errno: $mysqli->connect_error");
}else{
	$sqlThermometers = "select * from thermometers";

	$result = $mysqli->query($sqlThermometers);
	$thermometers = array();
	while ($row = $result->fetch_array()){
		$thermometers[] = $row['friendlyName'];
	}
	$res = "{";
	$color = 1;
	$mainSpace = '';
	foreach($thermometers as $therm){
	//AND `timestamp` > DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)
		$sqlQuery = "select th.friendlyName, CAST(avg(`value`) AS DECIMAL(5,2)) as temp, FLOOR(`timestamp`/500) *500 as date, 
		UNIX_TIMESTAMP( FLOOR(`timestamp`/500) *500 )* 1000 as uTime
		from `temperatures` te INNER JOIN `thermometers` th ON te.sensorId = th.serialId
		WHERE th.friendlyName = '" . $therm . "'
		". ($_GET['limit'] == '7days' ? " AND `timestamp` > DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) " : "") ."
		GROUP BY FLOOR(`timestamp`/500), th.friendlyName
		ORDER BY date";

		$result = $mysqli->query($sqlQuery);
		$space = "";
		
		$res1 = '"'.$therm.'": {"label":"'.$therm.'", "color":'.$color.', "data":[';
				while ($row = $result->fetch_array())
				{
					//foreach ($row as $r)
					{
						//$res1 .= $space . '{"label":"'. $row['friendlyName'] .'", "date":"'. $row['date'] .'","temp":"'. $row['temp'] .'"}';
						$res1 .=  ($space . "[". $row['uTime'] .",".$row['temp']."]");
						$space = ",";
					}
				}
		$res1 .= "]}";
		$color += 1;
		$res .= $mainSpace;
		$res .= $res1;
		$mainSpace = ',';
	}
	$res .= "}";


header('Content-Type: application/json');
echo $res;
?><?}
$mysqli->close();
?>