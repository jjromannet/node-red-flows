CREATE TABLE `current-config-ogrzewanie` (
  `idconfig` int(11) NOT NULL AUTO_INCREMENT,
  `tempZadana` decimal(4,2) NOT NULL,
  `tempZadzialania` decimal(4,2) NOT NULL,
  `minimalneZalaczenie` int(11) NOT NULL,
  PRIMARY KEY (`idconfig`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
