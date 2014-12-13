
SELECT `current-config-piec-v2`.`idconfig`,
    `current-config-piec-v2`.`stdTempZadana` as `piecZadana`,
    `current-config-piec-v2`.`stdTempZadzialania` as `piecZadzialanie`,
    `current-config-piec-v2`.`stdGrzaniePodawanie` as `grzaniePodawanie`,
    `current-config-piec-v2`.`stdGrzaniePrzerwa` as `grzaniePrzerwa`,
    `current-config-piec-v2`.`stdPodtrzymaniePodawanie` as `podtrzymaniePodawanie`,
    `current-config-piec-v2`.`stdPodtrzymaniePrzerwa` as `podtrzymaniePrzerwa`
FROM `node-red`.`current-config-piec-v2`;

INSERT INTO `node-red`.`current-config-piec-v2`
(
`stdTempZadana`,
`stdTempZadzialania`,
`stdGrzaniePodawanie`,
`stdGrzaniePrzerwa`,
`stdPodtrzymaniePodawanie`,
`stdPodtrzymaniePrzerwa`,
`advGrzaniePodawanieOpoznienie`,
`advGrzanieWentylatorOpoznienie`,
`advGrzanieWentylatorDelta`,
`advPodtrzymaniePodawanieOpoznienie`,
`advPodtrzymanieWentylatorOpoznienie`,
`advPodtrzymanieWentylatorDelta`,
`zasobnikMax`
)
VALUES
(
60.00,
55.00,
5,
20,
3,
40,
0,
0,
0,
0,
0,
0,
1000);

	
DROP TABLE `current-config-piec-v2`
CREATE TABLE `current-config-piec-v2` (
  `idconfig` int(11) NOT NULL AUTO_INCREMENT,
  `stdTempZadana` decimal(4,2) NOT NULL,
  `stdTempZadzialania` decimal(4,2) NOT NULL,
  `stdGrzaniePodawanie` int(11) NOT NULL,
  `stdGrzaniePrzerwa` int(11) NOT NULL,
  `stdPodtrzymaniePodawanie` int(11) NOT NULL,
  `stdPodtrzymaniePrzerwa` int(11) NOT NULL,
  `advGrzaniePodawanieOpoznienie` int(11) NOT NULL,
  `advGrzanieWentylatorOpoznienie` int(11) NOT NULL,
  `advGrzanieWentylatorDelta` int(11) NOT NULL,
  `advPodtrzymaniePodawanieOpoznienie` int(11) NOT NULL,
  `advPodtrzymanieWentylatorOpoznienie` int(11) NOT NULL,
  `advPodtrzymanieWentylatorDelta` int(11) NOT NULL,
  `zasobnikMax` int(11) NOT NULL,
  PRIMARY KEY (`idconfig`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

DROP TABLE `current-state-piec`

CREATE TABLE `current-state-piec` (
  `id` int(11) NOT NULL,
  `obecnyStan` varchar(12) NOT NULL,
  `zasobnik` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
INSERT INTO `current-state-piec` (id, obecnyStan, zasobnik) VALUES (1,'podtrzymanie',0)


SELECT 
	csp.`obecnyStan` as `trybPieca`
	,csp.`zasobnik` as `zasobnik`
	,ccpv2.`zasobnikMax` as `zasobnikMax`
    ,ccpv2.`stdTempZadana` as `piecZadana`
    ,ccpv2.`stdTempZadzialania` as `piecZadzialanie`
    ,ccpv2.`stdGrzaniePodawanie` as `grzaniePodawanie`
    ,ccpv2.`stdGrzaniePrzerwa` as `grzaniePrzerwa`
    ,ccpv2.`stdPodtrzymaniePodawanie` as `podtrzymaniePodawanie`
    ,ccpv2.`stdPodtrzymaniePrzerwa` as `podtrzymaniePrzerwa`
FROM 
	`node-red`.`current-state-piec` csp
	CROSS JOIN `node-red`.`current-config-piec-v2` ccpv2

var tempZadana 		= msg.payload['ustawienie']['tempZadana'];
var tempZadzialania = msg.payload['ustawienie']['tempZadzialania'];

var grzaniePodawanie= msg.payload['ustawienie']['grzaniePodawanie'];
var grzaniePrzerwa 	= msg.payload['ustawienie']['grzaniePrzerwa'];

var podtrzymaniePodawanie	=	msg.payload['ustawienie']['podtrzymaniePodawanie'];
var podtrzymaniePrzerwa		=	msg.payload['ustawienie']['podtrzymaniePrzerwa'];

UPDATE 
	`node-red`.`current-config-piec-v2` 
SET 
	`stdTempZadana` = 
	,`stdTempZadzialania` = 
	,`stdGrzaniePodawanie` = 
	,`stdGrzaniePrzerwa` = 
	,`stdPodtrzymaniePodawanie` = 
	,`stdPodtrzymaniePrzerwa` =

	
SELECT 
	csp.`obecnyStan` as `trybPieca`
	,csp.`zasobnik` as `zasobnik`
	,ccpv2.`zasobnikMax` as `zasobnikMax`
    ,ccpv2.`stdTempZadana` as `piecZadana`
    ,ccpv2.`stdTempZadzialania` as `piecZadzialanie`
    ,ccpv2.`stdGrzaniePodawanie` as `grzaniePodawanie`
    ,ccpv2.`stdGrzaniePrzerwa` as `grzaniePrzerwa`
    ,ccpv2.`stdPodtrzymaniePodawanie` as `podtrzymaniePodawanie`
    ,ccpv2.`stdPodtrzymaniePrzerwa` as `podtrzymaniePrzerwa`
	,CAST(avg(tempCO.`value`) AS DECIMAL(5,2)) as `tempCO`
	,CAST(avg(tempCWO.`value`) AS DECIMAL(5,2)) as `tempCWO`
	,CAST(avg(tempPowietrza.`value`) AS DECIMAL(5,2)) as `tempPowietrza`
FROM 
	`node-red`.`current-state-piec` csp
	CROSS JOIN `node-red`.`current-config-piec-v2` ccpv2
	CROSS JOIN thermometers thTempCO
		LEFT JOIN temperatures tempCO
			ON thTempCO.serialId = tempCO.sensorId
	
	CROSS JOIN thermometers thTempCWO	
		LEFT JOIN temperatures tempCWO
			ON thTempCWO.serialId = tempCWO.sensorId

	CROSS JOIN thermometers thTempPowietrza	
		LEFT JOIN temperatures tempPowietrza
			ON thTempPowietrza.serialId = tempPowietrza.sensorId

WHERE 
	thTempCO.friendlyName = 'CO'
	AND tempCO.`timestamp` > DATE_ADD(now(),INTERVAL -5 MINUTE)
	AND thTempCWO.friendlyName = 'Piec-kociol'
	AND tempCWO.`timestamp` > DATE_ADD(now(),INTERVAL -5 MINUTE)
	AND thTempPowietrza.friendlyName = 'Pokoj'
	AND tempPowietrza.`timestamp` > DATE_ADD(now(),INTERVAL -5 MINUTE)