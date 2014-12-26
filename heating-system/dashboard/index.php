<?php
include 'configs.php';
$mysqli = new mysqli($dbConfig['host'],$dbConfig['user'],$dbConfig['pass'],$dbConfig['db']);
if($mysqli->connect_error)
{
    echo("$mysqli->connect_errno: $mysqli->connect_error");
}else{
$sql = "select th.friendlyName, round(avg(`value`)) as temp, FLOOR(`timestamp`/500) *500 as date, 
UNIX_TIMESTAMP( FLOOR(`timestamp`/500) *500 )* 1000 as uTime
from `temperatures` te INNER JOIN `thermometers` th ON te.sensorId = th.serialId
WHERE `timestamp` > DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)
GROUP BY FLOOR(`timestamp`/500), th.friendlyName";

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
	AND `timestamp` > DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)
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
?><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Flot Examples: Time Axes </title>
	<link href="flot/examples/examples.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="../../excanvas.min.js"></script><![endif]-->
	<script language="javascript" type="text/javascript" src="flot/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.time.js"></script>
	<script language="javascript" type="text/javascript" src="flot/jquery.flot.selection.js"></script>
	
	<script type="text/javascript">
	$(function() {
	var limit = '7days';
	var refreshFunction = function(){
		$.ajax({
			url: 'getAllReadings_v2.0.php?limit='+limit,
			success: function(data){
				plotAccordingToChoices({}, data)
			}
		});
	};
	
	$('.refreshChart').click(refreshFunction);
	
	window.setInterval(	refreshFunction, 5*60000);
		
		
		var datasets = <?=$res?>;
		var choiceContainer = $("#choices");
		$.each(datasets, function(key, val) {
			choiceContainer.append("<br/><input type='checkbox' name='" + key +
				"' checked='checked' id='id" + key + "'></input>" +
				"<label for='id" + key + "'>"
				+ val.label + "</label>");
		});

		$("#whole").click(function () {
			plotAccordingToChoices();
		});
		
		choiceContainer.find("input").click(plotAccordingToChoices);

		function plotAccordingToChoices(event, providedData) {
			if(typeof providedData !== "undefined"){
				datasets = providedData;
			}
			var data = [];

			choiceContainer.find("input:checked").each(function () {
				var key = $(this).attr("name");
				if (key && datasets[key]) {
					data.push(datasets[key]);
				}
			});
			var options = {
				xaxis: {
					mode: "time"
				},
				selection: {
					mode: "x"
				},
				legend: {
					position: "nw"
				}
			};
		
			if (data.length > 0) {
				var plot = $.plot("#placeholder", data, options);
				
				var overview = $.plot("#overview", data, {
					series: {
						lines: {
							show: true,
							lineWidth: 1
						},
						shadowSize: 0
					},
					xaxis: {
						ticks: [],
						mode: "time"
					},
					yaxis: {
						ticks: [],
						min: 0,
						autoscaleMargin: 0.1
					},
					selection: {
						mode: "x"
					},
					legend: {
						show:false
					}
				});

				// now connect the two

				$("#placeholder").bind("plotselected", function (event, ranges) {

					// do the zooming
					$.each(plot.getXAxes(), function(_, axis) {
						var opts = axis.options;
						opts.min = ranges.xaxis.from;
						opts.max = ranges.xaxis.to;
					});
					plot.setupGrid();
					plot.draw();
					plot.clearSelection();

					// don't fire event on the overview to prevent eternal loop

					overview.setSelection(ranges, true);
				});

				$("#overview").bind("plotselected", function (event, ranges) {
					plot.setSelection(ranges);
				});
			}
		}

		plotAccordingToChoices();
		
		// Add the Flot version string to the footer

		$("#footer").prepend("Flot " + $.plot.version + " &ndash; ");
	});
	</script>
</head>
<body>

	<div id="header">
		<h2>Temperatura <span id="okres">ostatnie 7 dni</span></h2>
	</div>

	<div id="content">

		<div class="demo-container">
			<div id="placeholder" class="demo-placeholder"></div>
		</div>
		<div class="demo-container" style="height:150px;">
			<div id="overview" class="demo-placeholder"></div>
		</div>
		<div id="choices"></div>
		<a href="#" class="refreshChart">Refresh Chart</a>
		<p><button id="whole">Reset Zoom</button></p>
		<hr/>
		<p><button id="last7">Ostatnie 7 dni</button></p>
		<p><button id="entire">Od początku</button></p>
	</div>
</body>
</html><?}
$mysqli->close();
?>