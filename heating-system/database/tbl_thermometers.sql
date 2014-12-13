CREATE TABLE `thermometers` (
  `serialId` bigint(20) unsigned NOT NULL,
  `friendlyName` varchar(45) COLLATE utf8_polish_ci DEFAULT NULL,
  PRIMARY KEY (`serialId`),
  UNIQUE KEY `name_UNIQUE` (`friendlyName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
