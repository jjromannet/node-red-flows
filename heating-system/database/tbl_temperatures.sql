CREATE TABLE `temperatures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sensorId` bigint(20) unsigned DEFAULT NULL,
  `value` decimal(10,2) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_serial_timestamp` (`sensorId`,`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=250593 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
