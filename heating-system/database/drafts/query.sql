SELECT * 
FROM thermometers th
LEFT JOIN temperatures te
ON th.`serialId` = te.`sensorId`
WHERE (friendlyName = 'pokojA' OR friendlyName = 'pokojB'

) AND te.timestamp BETWEEN '2014-12-07 00:00:01' AND '2014-12-07 01:59:59' AND te.value > 30
ORDER BY te.timestamp DESC
LIMIT 0,1000
