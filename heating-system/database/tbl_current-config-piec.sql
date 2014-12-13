CREATE TABLE `current-config-piec` (
  `idconfig` int(11) NOT NULL AUTO_INCREMENT,
  `piec.U0.temp` decimal(4,2) NOT NULL,
  `piec.U1.podajnik` int(11) NOT NULL,
  `piec.U1.opoznienie` int(11) NOT NULL,
  `piec.U2.wentylator` int(11) NOT NULL,
  `piec.U2.opoznienie` int(11) NOT NULL,
  `piec.dlugosc.cyklu` int(11) NOT NULL,
  PRIMARY KEY (`idconfig`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
