CREATE TABLE `current-state-piec` (
  `id` int(11) NOT NULL,
  `obecnyStan` varchar(12) COLLATE utf8_polish_ci NOT NULL,
  `zasobnik` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;
