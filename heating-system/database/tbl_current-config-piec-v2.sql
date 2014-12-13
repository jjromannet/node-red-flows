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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
