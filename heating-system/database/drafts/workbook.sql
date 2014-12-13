SELECT * FROM `node-red`.temperatures ORDER BY timestamp dESC LIMIT 100

SELECT 

INSERT INTO temperatures (sensorId, value) SELECT 2882303761590343700, 21.5  UNION ALL SELECT 2882303761545187000, 21.687 

SELECT * FROM thermometers LEFT JOIN temperatures 

SELECT * FROM `node-red`.temperatures WHERE id > 0 ORDER BY id LIMIT 100 LIMIT 100

insert into `current-config-TrybPracyPieca` (id, start, stop, obecnyStan) VALUES (1, 55.00, 60.00, 0)
`current-config-TrybPracyPieca`

SELECT avg(te.value), cctpp.id, start, stop, obecnyStan 
	FROM 
		`current-config-TrybPracyPieca`  cctpp
	CROSS JOIN 
		thermometers  th
	INNER JOIN 
		temperatures  te
	ON th.serialId = te.sensorId
WHERE th.friendlyName = 'Piec-kociol'
AND te.timestamp > addtime(NOW(), -500)   
GROUP BY cctpp.id, start, stop, obecnyStan

SELECT * FROM thermometers  th
	LEFT JOIN temperatures  te
	ON th.serialId = te.sensorId
LIMIT 10 



SELECT  
	c.*,   
	te.value as 'odczyt.value',  
	te.timestamp as 'odczyt.timestamp'  
FROM  
	`node-red`.`current-config-piec` c  
	CROSS JOIN 	 
		`node-red`.`temperatures` te 
	INNER JOIN `node-red`.`thermometers` th 
		ON te.sensorId = th.serialId 
 WHERE  
	 th.friendlyName = 'Piec-kociol' 
	and 
 te.timestamp > addtime(NOW(), -500)   
	ORDER BY te.timestamp DESC 
LIMIT 1 


UPDATE `current-config-TrybPracyPieca`  SET obecnyStan = 0 WHERE id = 1

SELECT * FROM `current-config-piec` 
SELECT * FROM `current-config-TrybPracyPieca`

SELECT 
	`piec.U0.temp` as `piecZadana`, 
	`piec.U1.podajnik` as `A`, 
	`piec.U1.opoznienie` as `B`, 
	`piec.U2.wentylator` as `C`, 
	`piec.U2.opoznienie` as `D`, 
	`piec.dlugosc.cyklu` as `E`
 FROM `current-config-piec` 


SELECT `current-config-piec-v2`.`idconfig`,
    `current-config-piec-v2`.`stdTempZadana` as `piecZadana`,
    `current-config-piec-v2`.`stdTempZadzialania` as `piecZadzialanie`,
    `current-config-piec-v2`.`stdGrzaniePodawanie` as `grzaniePodawanie`,
    `current-config-piec-v2`.`stdGrzaniePrzerwa` as `grzaniePrzerwa`,
    `current-config-piec-v2`.`stdPodtrzymaniePodawanie` as `podtrzymaniePodawanie`,
    `current-config-piec-v2`.`stdPodtrzymaniePrzerwa` as `podtrzymaniePrzerwa`
FROM `node-red`.`current-config-piec-v2`;


INSERT INTO `current-status-piec` (id, obecnyStan, podajnik) VALUES (1,'grzanie',0)

SELECT obecnyStan, podajnik FROM `current-status-piec` 


SELECT `current-config-piec-v2`.`idconfig`,
    `current-config-piec-v2`.`stdTempZadana` as `piecZadana`,
    `current-config-piec-v2`.`stdTempZadzialania` as `piecZadzialanie`,
    `current-config-piec-v2`.`stdGrzaniePodawanie` as `grzaniePodawanie`,
    `current-config-piec-v2`.`stdGrzaniePrzerwa` as `grzaniePrzerwa`,
    `current-config-piec-v2`.`stdPodtrzymaniePodawanie` as `podtrzymaniePodawanie`,
    `current-config-piec-v2`.`stdPodtrzymaniePrzerwa` as `podtrzymaniePrzerwa`
FROM `node-red`.`current-config-piec-v2`;


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
	,avg(tempCO.`value`) as `tempCO`
	,avg(tempCWO.`value`) as `tempCWO`
	,avg(tempPowietrza.`value`) as `tempPowietrza`
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

GROUP BY thTempCO.friendlyName
SELECT CAST(28.528889 AS DECIMAL(5,2))


SELECT avg(value), friendlyName FROM thermometers th
	LEFT JOIN temperatures te
ON th.serialId = te.sensorId
WHERE th.friendlyName = 'CO'
AND te.`timestamp` > DATE_ADD(now(),INTERVAL -5 MINUTE)
GROUP BY friendlyName

ORDER BY timestamp DESC
SELECT DATE_ADD(now(),INTERVAL 5 MINUTE)

SELECT * FROM  thermometers
WHERE `timestamp` > DATE_ADD(now(),INTERVAL -5 MINUTE)



SELECT  
	c.*,   
	te.value as 'odczyt.value',  
	te.timestamp as 'odczyt.timestamp'  
FROM  
	`node-red`.`current-config-piec` c  
	CROSS JOIN 	 
		`node-red`.`temperatures` te 
	INNER JOIN `node-red`.`thermometers` th 
		ON te.sensorId = th.serialId 
 WHERE  
	 th.friendlyName = 'Piec-kociol' 
	and 
 te.timestamp > addtime(NOW(), -500)   
	ORDER BY te.timestamp DESC 
LIMIT 1 



SELECT avg(te.value) as `value`, cctpp.id, start, stop, obecnyStan 
	FROM 
		`current-config-TrybPracyPieca` cctpp 
	CROSS JOIN 
		thermometers  th 
	INNER JOIN 
		temperatures  te 
	ON th.serialId = te.sensorId
WHERE th.friendlyName = 'Piec-kociol'
AND te.timestamp > addtime(NOW(), -500)   
GROUP BY cctpp.id, start, stop, obecnyStan



SELECT 
  csp.`obecnyStan` as `trybPieca`
  ,ccpv2.`stdTempZadana` as `piecZadana`
  ,ccpv2.`stdTempZadzialania` as `piecZadzialanie`
  ,CAST(avg(tempCO.`value`) AS DECIMAL(5,2)) as `tempKociol`
FROM 
	`node-red`.`current-state-piec` csp
	CROSS JOIN `node-red`.`current-config-piec-v2` ccpv2
	CROSS JOIN thermometers thTempCO
		LEFT JOIN temperatures tempCO
			ON thTempCO.serialId = tempCO.sensorId
WHERE 
	thTempCO.friendlyName = 'CO'
	AND tempCO.`timestamp` > DATE_ADD(now(),INTERVAL -5 MINUTE)


SELECT 
 csp.`obecnyStan` as `trybPieca`
 ,ccpv2.`stdTempZadana` as `piecZadana`
 ,ccpv2.`stdTempZadzialania` as `piecZadzialanie`
 ,CAST(avg(tempCO.`value`) AS DECIMAL(5,2)) as `tempKociol`
FROM 
	`node-red`.`current-state-piec` csp
	CROSS JOIN `node-red`.`current-config-piec-v2` ccpv2
	CROSS JOIN thermometers thTempCO
		LEFT JOIN temperatures tempCO
			ON thTempCO.serialId = tempCO.sensorId
WHERE 
	thTempCO.friendlyName = CO
	AND tempCO.`timestamp` > DATE_ADD(now(),INTERVAL -5 MINUTE)
select * from `current-state-piec` 
UPDATE `current-state-piec` set obecnyStan = 'podtrzymanie' WHERE id = 1


DROP TABLE `current-state-piec`;

CREATE TABLE `current-state-piec` (
  `id` int(11) NOT NULL,
  `obecnyStan` varchar(12) NOT NULL,
  `zasobnik` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

INSERT INTO `current-state-piec` (id, obecnyStan, zasobnik) VALUES (1,'podtrzymanie',0)


SELECT * FROM `current-state-piec`

SELECT * FROM `current-config-piec-v2`

SELECT * FROM `current-config-boiler`





CREATE TABLE `current-config-boiler` (
  `idconfig` int(11) NOT NULL AUTO_INCREMENT,
  `tempZadana` decimal(4,2) NOT NULL,
  `tempZadzialania` decimal(4,2) NOT NULL,
  PRIMARY KEY (`idconfig`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
INSERT INTO `current-config-boiler` (`tempZadana`, `tempZadzialania`) VALUE (60.0, 55.0)


CREATE TABLE `current-config-ogrzewanie` (
  `idconfig` int(11) NOT NULL AUTO_INCREMENT,
  `tempZadana` decimal(4,2) NOT NULL,
  `tempZadzialania` decimal(4,2) NOT NULL,
  `minimalneZalaczenie` int(11) NOT NULL,
  PRIMARY KEY (`idconfig`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

INSERT INTO `current-config-ogrzewanie` (`tempZadana`, `tempZadzialania`, `minimalneZalaczenie`) VALUES (40.0, 35.0, 120)








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
	,cco.`tempZadana` as `ogrzewanieZadana`
	,cco.`tempZadzialania` as `ogrzewanieZadzialania`
	,cco.`minimalneZalaczenie` as `ogrzewanieMinimalneZalaczenie`
	,ccb.`tempZadana` as `boilerZadana`
	,ccb.`tempZadzialania` as `boilzerZadzialania`
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

	CROSS JOIN `current-config-ogrzewanie` cco
	CROSS JOIN `current-config-boiler` ccb

WHERE 
	thTempCO.friendlyName = 'CO'
	AND tempCO.`timestamp` > DATE_ADD(now(),INTERVAL -5 MINUTE)
	AND thTempCWO.friendlyName = 'Piec-kociol'
	AND tempCWO.`timestamp` > DATE_ADD(now(),INTERVAL -5 MINUTE)
	AND thTempPowietrza.friendlyName = 'Pokoj'
	AND tempPowietrza.`timestamp` > DATE_ADD(now(),INTERVAL -5 MINUTE)
	
	
	SELECT * FROM `node-red`.`current-config-piec` c 
INSERT INTO `node-red`.`current-config-piec`
(
`piec.U0.temp`,
`piec.U1.podajnik`,
`piec.U1.opoznienie`,
`piec.U2.wentylator`,
`piec.U2.opoznienie`)
VALUES
(
65,
7,
2,
9,
1);

SELECT 
	c.*,  
	te.value as 'odczyt.value', 
	te.timestamp as 'odczyt.timestamp' 
FROM 
	`node-red`.`current-config-piec` c 
	CROSS JOIN 	
		`node-red`.`temperatures` te
	INNER JOIN `node-red`.`thermometers` th
		ON te.sensorId = th.serialId
 WHERE 
	 th.friendlyName = 'Piec-kociol'
	and
 te.timestamp > addtime(NOW(), -500)  
	ORDER BY te.timestamp DESC
LIMIT 1

SELECT * FROM thermometers th INNER JOIN temperatures te
	ON te.sensorId = th.serialId
	
	
	
	
	
	SELECT  
	c.*,   
	te.value as 'odczyt.value',  
	te.timestamp as 'odczyt.timestamp'  
FROM  
	`node-red`.`current-config-piec` c  
	CROSS JOIN 	 
		`node-red`.`temperatures` te 
	INNER JOIN `node-red`.`thermometers` th 
		ON te.sensorId = th.serialId 
 WHERE  
	 th.friendlyName = 'Piec-kociol' 
	and 
 te.timestamp > addtime(NOW(), -500)  
	ORDER BY te.timestamp DESC 
LIMIT 1 


SELECT * FROM `current-config-piec`

UPDATE `current-config-piec` SET 
`piec.dlugosc.cyklu` = 34 WHERE idconfig = 1


# idconfig, piec.U0.temp, piec.U1.podajnik, piec.U1.opoznienie, piec.U2.wentylator, piec.U2.opoznienie, piec.dlugosc.cyklu
, 65.00, 7, 2, 9, 1, 0


EXPLAIN
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

CREATE UNIQUE INDEX ix_serial_timestamp ON temperatures (sensorId, timestamp)

DESCRIBE temperatures
show table status from `node-red`

	