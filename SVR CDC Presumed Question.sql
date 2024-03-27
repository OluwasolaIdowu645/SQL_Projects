DELIMITER $$
DROP FUNCTION IF EXISTS `ConceptName`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ConceptName`(conceptid INT) 
RETURNS TEXT CHARSET latin1 READS SQL DATA DETERMINISTIC BEGIN RETURN 
(SELECT NAME FROM  concept_name  WHERE concept_id = conceptid 
AND locale = 'en' AND locale_preferred = 1 LIMIT 1);END$$ 
DELIMITER ;


DROP TABLE IF EXISTS CIHP_listoffacility;
CREATE TABLE IF NOT EXISTS  CIHP_listoffacility (
  `FacilityID` DOUBLE DEFAULT NULL,
  `State` VARCHAR(255) DEFAULT NULL,
  `SurgeCommand` VARCHAR(255) DEFAULT NULL,
  `LGA` VARCHAR(255) DEFAULT NULL,
  `Datim_Code` VARCHAR(255) DEFAULT NULL,
  UNIQUE KEY `myIndex` (`FacilityID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
/*Data for the table `listoffacility` */
INSERT IGNORE INTO CIHP_listoffacility(`FacilityID`,`State`,`SurgeCommand`,`LGA`,`Datim_Code`) VALUES 
(1, "Gombe", "Akko", "Akko", "bW4cbw8Kloh"),
(2, "Gombe", "Akko", "Akko", "nzQr4fbA7Ir"),
(3, "Gombe", "Akko", "Akko", "rzkxVHjL1p5"),
(4, "Gombe", "Akko", "Akko", "hQDiS6TSZdz"),
(5, "Gombe", "Balanga", "Balanga", "MMtwgHXDdXV"),
(6, "Gombe", "Balanga", "Balanga", "yAtYirMpXuz"),
(7, "Gombe", "Balanga", "Balanga", "LzmgjtL87kh"),
(8, "Gombe", "Billiri", "Billiri", "ItQqTK4vrzT"),
(9, "Gombe", "Billiri", "Billiri", "jV7IcQgCsXD"),
(10, "Gombe", "Billiri", "Billiri", "NeOiTtsL5sa"),
(11, "Gombe", "Dukku", "Dukku", "VQgRF8xzLJH"),
(12, "Gombe", "Dukku", "Dukku", "X8smKtvqUob"),
(13, "Gombe", "Funakaye", "Funakaye", "XNy0j3RUrI6"),
(14, "Gombe", "Funakaye", "Funakaye", "t0ulFJivm9P"),
(15, "Gombe", "Funakaye", "Funakaye", "ar43MQufI9v"),
(16, "Gombe", "Gombe", "Gombe", "kQSAihTQQep"),
(17, "Gombe", "Gombe", "Gombe", "hX8Nrf3AEz7"),
(18, "Gombe", "Gombe", "Gombe", "Lx9SQTEgXS3"),
(19, "Gombe", "Gombe", "Gombe", "jRNyO3ImWmI"),
(20, "Gombe", "Gombe", "Gombe", "UeAxwJmzoPH"),
(21, "Gombe", "Gombe", "Gombe", "mO8FSgHsz3O"),
(22, "Gombe", "Gombe", "Gombe", "kbvQ8m0PGSU"),
(23, "Gombe", "Kaltungo", "Kaltungo", "VFdjWHMxQJ7"),
(24, "Gombe", "Kaltungo", "Kaltungo", "KLEiRw5efPW"),
(25, "Gombe", "Kaltungo", "Kaltungo", "CnFTZ4Yu5A8"),
(26, "Gombe", "Kwami", "Kwami", "I3r9UA4xbfo"),
(27, "Gombe", "Kwami", "Kwami", "ipw9D3TRP8p"),
(28, "Gombe", "Nafada", "Nafada", "cxm2xKiIBud"),
(29, "Gombe", "Nafada", "Nafada", "fgDvaz58q64"),
(30, "Gombe", "Nafada", "Nafada", "gO6hDzeSBgl"),
(31, "Gombe", "Shongom", "Shongom", "vaP8U6qfGIa"),
(32, "Gombe", "Shongom", "Shongom", "ajaROCGp7D4"),
(33, "Gombe", "Shongom", "Shongom", "gArfGStpgDM"),
(34, "Gombe", "Yamaltu/Deba", "Yamaltu/Deba", "Dz65VTZfbUd"),
(35, "Gombe", "Yamaltu/Deba", "Yamaltu/Deba", "HwC7f1qYg2o"),
(36, "Gombe", "Yamaltu/Deba", "Yamaltu/Deba", "P9815pFCx4Y"),
(37, "Kaduna", "Kubau", "Kubau", "PoIQpdF8RTG"),
(38, "Kaduna", "Kubau", "Kubau", "k2dAp9r2mRa"),
(39, "Kaduna", "BirninGwari", "BirninGwari", "z7cRKbwx8L7"),
(40, "Kaduna", "BirninGwari", "BirninGwari", "m4mw3TJxbJy"),
(41, "Kaduna", "KadunaNorth", "KadunaNorth", "aQTk0pRk6eY"),
(42, "Kaduna", "KadunaNorth", "KadunaNorth", "ZD8SEdhkeTQ"),
(43, "Kaduna", "KadunaNorth", "KadunaNorth", "HWkSjwMUDvc"),
(44, "Kaduna", "KadunaNorth", "KadunaNorth", "dwAvWQFlxx2"),
(45, "Kaduna", "KadunaNorth", "KadunaNorth", "rWfabrVIqeg"),
(46, "Kaduna", "KadunaNorth", "KadunaNorth", "JDudfxSTSrO"),
(47, "Kaduna", "KadunaNorth", "KadunaNorth", "QwrkbFl3Uvj"),
(48, "Kaduna", "KadunaNorth", "KadunaNorth", "R8c34xK5kp3"),
(49, "Kaduna", "KadunaNorth", "KadunaNorth", "RT0mIfaaDxi"),
(50, "Kaduna", "KadunaNorth", "KadunaNorth", "U42lUlqw14s"),
(51, "Kaduna", "Giwa", "Giwa", "t4pYfQ9Skx4"),
(52, "Kaduna", "Giwa", "Giwa", "fiC3mpkjajt"),
(53, "Kaduna", "Giwa", "Giwa", "ebLQTZgsfgz"),
(54, "Kaduna", "Sanga", "Sanga", "CXY35SPtbPf"),
(55, "Kaduna", "Sanga", "Sanga", "igUyFcgaVHP"),
(56, "Kaduna", "Kudan", "Kudan", "tXeGc4P4bXe"),
(57, "Kaduna", "Kudan", "Kudan", "XRzMMtgxpMU"),
(58, "Kaduna", "Jema'a", "Jema'a", "yR3KYnURaLT"),
(59, "Kaduna", "Jema'a", "Jema'a", "GPe3nnQbHA6"),
(60, "Kaduna", "Jema'a", "Jema'a", "vufh9kqDnPj"),
(61, "Kaduna", "Ikara", "Ikara", "pad3e5xOCdP"),
(62, "Kaduna", "Igabi", "Igabi", "lWqv0RHnPh9"),
(63, "Kaduna", "Kachia", "Kachia", "WdArBhoOacf"),
(64, "Kaduna", "Kachia", "Kachia", "vuo72rgedTZ"),
(65, "Kaduna", "Kachia", "Kachia", "bSDq2EfthjS"),
(66, "Kaduna", "Kachia", "Kachia", "ILwIROK4TTR"),
(67, "Kaduna", "Kagarko", "Kagarko", "A5a1HEarbxU"),
(68, "Kaduna", "Kagarko", "Kagarko", "Bc82bF99cN1"),
(69, "Kaduna", "Chikun", "Chikun", "A279VIsHpTI"),
(70, "Kaduna", "Chikun", "Chikun", "J4Ec3FWnH6Q"),
(71, "Kaduna", "Chikun", "Chikun", "yXnTcKW3nuk"),
(72, "Kaduna", "Chikun", "Chikun", "i6Rcojd7d9S"),
(73, "Kaduna", "Chikun", "Chikun", "Os1iE6RNSnx"),
(74, "Kaduna", "Kajuru", "Kajuru", "mMBatyNbrv0"),
(75, "Kaduna", "Kajuru", "Kajuru", "Vpd9OutI5QE"),
(76, "Kaduna", "Kaura", "Kaura", "tkNy2sER8xX"),
(77, "Kaduna", "Kaura", "Kaura", "NOFJMZXfbFx"),
(78, "Kaduna", "Kaura", "Kaura", "VYk8FuLG2G1"),
(79, "Kaduna", "Kaura", "Kaura", "aGArDGnLt5O"),
(80, "Kaduna", "Kauru", "Kauru", "GRhndXkuvmD"),
(81, "Kaduna", "Kauru", "Kauru", "fk5t7pAg7Cm"),
(82, "Kaduna", "Jaba", "Jaba", "uFaSs80gLIx"),
(83, "Kaduna", "Jaba", "Jaba", "b54iXGWcmCB"),
(84, "Kaduna", "Soba", "Soba", "fEZq6XgTLT2"),
(85, "Kaduna", "Soba", "Soba", "sWKNZPZj231"),
(86, "Kaduna", "KadunaSouth", "KadunaSouth", "QaeAxjVVGmA"),
(87, "Kaduna", "KadunaSouth", "KadunaSouth", "gZeeGIFJ9KY"),
(88, "Kaduna", "KadunaSouth", "KadunaSouth", "mX4PekSaaS2"),
(89, "Kaduna", "KadunaSouth", "KadunaSouth", "T0cw021kccu"),
(90, "Kaduna", "KadunaSouth", "KadunaSouth", "IzbxBJjD6IG"),
(91, "Kaduna", "KadunaSouth", "KadunaSouth", "xoXTB4clfGL"),
(92, "Kaduna", "KadunaSouth", "KadunaSouth", "Px8Q10LldkO"),
(93, "Kaduna", "KadunaSouth", "KadunaSouth", "HF37VJr8eoZ"),
(94, "Kaduna", "KadunaSouth", "KadunaSouth", "uq98eMvdS5R"),
(95, "Kaduna", "KadunaSouth", "KadunaSouth", "pt20jaMEKHx"),
(96, "Kaduna", "KadunaSouth", "KadunaSouth", "yfPEukzMBhy"),
(97, "Kaduna", "Makarfi", "Makarfi", "QuiAPHqPxwY"),
(98, "Kaduna", "Makarfi", "Makarfi", "oPl04jv6omI"),
(99, "Kaduna", "SabonGari", "SabonGari", "n81KW6HQJ9Q"),
(100, "Kaduna", "SabonGari", "SabonGari", "nDa1uUKmVhb"),
(101, "Kaduna", "Lere", "Lere", "XCixcBgl6uz"),
(102, "Kaduna", "Lere", "Lere", "xgIRJYISVOB"),
(103, "Kaduna", "Igabi", "Igabi", "dlxwQg99WoE"),
(104, "Kaduna", "Igabi", "Igabi", "P2CO8dS7XTK"),
(105, "Kaduna", "Igabi", "Igabi", "yjpPIoeNQLj"),
(106, "Kaduna", "Ikara", "Igabi", "WwqQZjVN29z"),
(107, "Kaduna", "Zaria", "Zaria", "xCzRV3Bjzfc"),
(108, "Kaduna", "Zaria", "Zaria", "bKXKmhOnPpK"),
(109, "Kaduna", "Zaria", "Zaria", "LOJ8j4vLoJZ"),
(110, "Kaduna", "Zaria", "Zaria", "V0IswqM1byH"),
(111, "Kaduna", "Zaria", "Zaria", "lLdc7dRUqzs"),
(112, "Kaduna", "ZangonKataf", "ZangonKataf", "uYxACgpJgI9"),
(113, "Kaduna", "ZangonKataf", "ZangonKataf", "jHjDEUVD87x"),
(114, "Kaduna", "ZangonKataf", "ZangonKataf", "KPafVFs3f9a"),
(115, "Kaduna", "ZangonKataf", "ZangonKataf", "LRJl5ilFu2M"),
(116, "Kaduna", "Chikun", "Chikun", "JhSXki2wI3q"),
(117, "Kogi", "Ajaokuta", "Ajaokuta", "xJy5KJJn8gz"),
(118, "Kogi", "Lokoja", "Ajaokuta", "CzwWiALrME8"),
(119, "Kogi", "IgalamelaOdolu", "IgalamelaOdolu", "spxEj5Dlg70"),
(120, "Kogi", "Bassa", "Bassa", "merMznnVwIA"),
(121, "Kogi", "Anyigba", "Bassa", "LVbNrbnD8x5"),
(122, "Kogi", "Anyigba", "Omala", "PRHYgNR5CUO"),
(123, "Kogi", "Omala", "Omala", "deDUnu6PVkl"),
(124, "Kogi", "Idah", "Idah", "xwBUYtnRhqv"),
(125, "Kogi", "Anyigba", "Idah", "PawBgipJAZe"),
(126, "Kogi", "Okene", "Adavi", "x8VGMgpn35c"),
(127, "Kogi", "Okene", "Adavi", "MruZ0YOqYQV"),
(128, "Kogi", "Adavi", "Adavi", "WK5gDvZgOD6"),
(129, "Kogi", "YagbaWest", "YagbaWest", "yCGhXibQavi"),
(130, "Kogi", "YagbaWest", "YagbaWest", "BvUDTXGnj8s"),
(131, "Kogi", "Okene", "Ijumu", "XKAVCLKlMPZ"),
(132, "Kogi", "Ijumu", "Ijumu", "JdodeJT1030"),
(133, "Kogi", "Kabba/Bunu", "Kabba/Bunu", "LRXpCvMxrYU"),
(134, "Kogi", "Okene", "Kabba/Bunu", "EOO49s5EOt4"),
(135, "Kogi", "Okene", "Kabba/Bunu", "CGwIyxDpwT8"),
(136, "Kogi", "Anyigba", "Ofu", "aMZiWfMiJd9"),
(137, "Kogi", "Anyigba", "Ofu", "mf9bRBuufwN"),
(138, "Kogi", "Ofu", "Ofu", "MvoR4rmtllj"),
(139, "Kogi", "Kogi", "Kogi", "XKv4TrYPA47"),
(140, "Kogi", "Lokoja", "Kogi", "KzgNOUrEB8m"),
(141, "Kogi", "Okene", "Okehi", "YxjPfHv2bdg"),
(142, "Kogi", "Okehi", "Okehi", "ROj1N52eCYd"),
(143, "Kogi", "Dekina", "Dekina", "OQ5fZjjCoDR"),
(144, "Kogi", "Anyigba", "Dekina", "nlLwNEPKFnR"),
(145, "Kogi", "Anyigba", "Dekina", "Qiq81djsOyv"),
(146, "Kogi", "Anyigba", "Dekina", "p8ukk5eOdZA"),
(147, "Kogi", "Anyigba", "Dekina", "jUzZE9zzYYf"),
(148, "Kogi", "Anyigba", "Dekina", "ki7kLIEcJ0r"),
(149, "Kogi", "Anyigba", "Dekina", "KkDXS9Qv3oE"),
(150, "Kogi", "Anyigba", "Dekina", "riZZbajMMKD"),
(151, "Kogi", "Okene", "Okene", "CLVU561R6tp"),
(152, "Kogi", "Okene", "Okene", "sKytXCdZsh5"),
(153, "Kogi", "Okene", "Okene", "WKSMZvuda1v"),
(154, "Kogi", "Ankpa", "Ankpa", "elrdVlVn0kp"),
(155, "Kogi", "Ankpa", "Ankpa", "logPshzwZGg"),
(156, "Kogi", "Ankpa", "Ankpa", "mJgQrfBTx3f"),
(157, "Kogi", "Ankpa", "Ankpa", "Et6wjYLz9Sj"),
(158, "Kogi", "Okene", "Ogori/Magongo", "H7M8CLeCiXD"),
(159, "Kogi", "Ogori/Magongo", "Ogori/Magongo", "cMvadwiBado"),
(160, "Kogi", "Amkpa", "Olamaboro", "h9drujCcifQ"),
(161, "Kogi", "Olamaboro", "Olamaboro", "Re4VU7MrOUM"),
(162, "Kogi", "Lokoja", "Lokoja", "D4zacvYxq0b"),
(163, "Kogi", "Lokoja", "Lokoja", "KsNbhiCMPvu"),
(164, "Kogi", "Lokoja", "Lokoja", "Aq2CeR3h187"),
(165, "Kogi", "Lokoja", "Lokoja", "gkOIcMHnyHM"),
(166, "Kogi", "MopaMuro", "MopaMuro", "CdZWAGT8Qes"),
(167, "Kogi", "Ibaji", "Ibaji", "cNr80ZanaDp"),
(168, "Kogi", "YagbaEast", "YagbaEast", "wYSTfYinFO7"),
(169, "Lagos", "ibeju-lekki", "ibeju-lekki", "ISi4PDO97U5"),
(170, "Lagos", "EtiOsa", "EtiOsa", "VHITI10xoZc"),
(171, "Lagos", "Epe", "Epe", "uzCT1lOZhL5"),
(172, "Lagos", "ifako-ijaiye", "ifako-ijaiye", "sSg7pUov51f"),
(173, "Lagos", "Amuwo-Odofin", "Amuwo-Odofin", "HOJVVYgS5vV"),
(174, "Lagos", "Ikeja", "Ikeja", "u8skYaLV6QF"),
(175, "Lagos", "Alimosho", "Alimosho", "AUIjfqeZEFH"),
(176, "Lagos", "Oshodi_Isolo", "Oshodi-Isolo", "lJkmYJB9kHr"),
(177, "Lagos", "Alimosho_Amuwo", "Amuwo Odofin", "V9F0fejCYiz"),
(178, "Lagos", "Alimosho_Amuwo", "Alimosho", "Mq45WIHMbhI"),
(179, "Lagos", "Alimosho_Amuwo", "Alimosho", "jMnxdoXrX0B"),
(180, "Lagos", "Alimosho_Amuwo", "Amuwo Odofin", "Ho8HeGPzmwk"),
(181, "Lagos", "Alimosho_Amuwo", "Alimosho", "LNguEy0vjvR"),
(182, "Lagos", "Alimosho_Amuwo", "Alimosho", "RD3JhCrIpQg"),
(183, "Lagos", "Alimosho_Amuwo", "Amuwo Odofin", "brE1SYIkAqX"),
(184, "Lagos", "Alimosho_Amuwo", "Alimosho", "R3X9MttmeAb"),
(185, "Lagos", "Alimosho_Amuwo", "Alimosho", "tscvxzvaPHe"),
(186, "Lagos", "Alimosho_Amuwo", "Alimosho", "dsYsl8bXYX0"),
(187, "Lagos", "Alimosho_Amuwo", "Amuwo Odofin", "wsaK58gH5tH"),
(188, "Lagos", "Epe_Ibeju-Lekki", "Epe", "wblyUihZxEk"),
(189, "Lagos", "Epe_Ibeju-Lekki", "Epe", "smKEPkP7G0O"),
(190, "Lagos", "Epe_Ibeju-Lekki", "Epe", "hqT0jwt1zsL"),
(191, "Lagos", "Epe_Ibeju-Lekki", "ibeju-lekki", "KmKzDT9YmmR"),
(192, "Lagos", "Eti-Osa", "Eti Osa", "AfLGN7kmKaK"),
(193, "Lagos", "Eti-Osa", "Eti Osa", "NCrwoKufAu9"),
(194, "Lagos", "Eti-Osa", "Eti Osa", "BPvnX1MlAAl"),
(195, "Lagos", "Eti-Osa", "Eti Osa", "K4fl4VyS1Qp"),
(196, "Lagos", "Eti-Osa", "Eti Osa", "W8ZrdhS5bgo"),
(197, "Lagos", "Eti-Osa", "Eti Osa", "UEetB08FZNc"),
(198, "Lagos", "Eti-Osa", "Eti Osa", "lwmRYQg2xSI"),
(199, "Lagos", "Ifako_Ikeja", "ifako-ijaiye", "WNZk7unzn4x"),
(200, "Lagos", "Ifako_Ikeja", "ifako-ijaiye", "CtKYcZmtnBQ"),
(201, "Lagos", "Ifako_Ikeja", "Alimosho", "D8fXWtqwMAU"),
(202, "Lagos", "Ifako_Ikeja", "ifako-ijaiye", "OWOckBlm9Du"),
(203, "Lagos", "Ifako_Ikeja", "ifako-ijaiye", "W7hscr3wKtm"),
(204, "Lagos", "Ifako_Ikeja", "Alimosho", "iJX8pwklfN3"),
(205, "Lagos", "Ifako_Ikeja", "Ikeja", "y5TzOvctmba"),
(206, "Lagos", "Ifako_Ikeja", "ifako-ijaiye", "VIgbUF6H4ma"),
(207, "Lagos", "Ifako_Ikeja", "Alimosho", "owB333UT2qz"),
(208, "Lagos", "Ifako_Ikeja", "Ikeja", "zkYOojlUFww"),
(209, "Lagos", "Ifako_Ikeja", "Ikeja", "ptxAOdQ5Tp8"),
(210, "Lagos", "Mushin_Isolo", "Mushin", "PdTC8ihrFRQ"),
(211, "Lagos", "Mushin_Isolo", "Mushin", "a9EDyKYjIlc"),
(212, "Lagos", "Mushin_Isolo", "Oshodi_Isolo", "CHqAwjTU2Jc"),
(213, "Lagos", "Mushin_Isolo", "Oshodi_Isolo", "BODWX46tM9Y"),
(214, "Lagos", "Mushin_Isolo", "Mushin", "WlXQVJSBvrn"),
(215, "Lagos", "Mushin_Isolo", "Mushin", "bjExvCDZVsB"),
(216, "Lagos", "Mushin_Isolo", "Mushin", "qEW4Bhjh7Lv"),
(217, "Lagos", "Mushin_Isolo", "Mushin", "LZC72BhBZBd"),
(218, "Lagos", "Mushin_Isolo", "Oshodi_Isolo", "gFlvov8GYAp");


/*Update End 14th July 2021*/
 SET @FacilityName :=
(SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'Facility_Name');
SET @DATIMCode :=
(SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code');
SET @SurgeCommand :=
(SELECT
  SurgeCommand
FROM
  CIHP_ListOfFacility
WHERE Datim_Code = (SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code'));
SET @LGA :=
(SELECT
  LGA
FROM
  CIHP_ListOfFacility
WHERE Datim_Code = (SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code'));
SET @State :=
(SELECT
  State
FROM
  CIHP_ListOfFacility
WHERE Datim_Code = (SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code'));


#SELECT IP, State State, SurgeCommand, LGA, DATIMCode, FacilityName, MAX(a.Occ) Pickup_Count, patient_id, Pepid, GROUP_CONCAT(' ', PickupDate) PickupDate, 
#GROUP_CONCAT(' ', DaysOfARVRefill)DaysOfARVRefill FROM (
SELECT * FROM(
SELECT 'CIHP' IP, @State State, @SurgeCommand SurgeCommand, @LGA LGA, @DATIMCode DATIMCode, @FacilityName FacilityName, a.Occ, a.patient_id, p2.`identifier` Pepid, a.PickupDate, 
a.`encounter_id`, b.DaysOfARVRefill
FROM (SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, 
e.`encounter_datetime` PickupDate, e.`encounter_id`
FROM `encounter` e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND e.`voided` = 0 AND e.`encounter_datetime` >= '2019-10-01' 
ORDER BY e.patient_id, e.`encounter_datetime` DESC) a
#ART Refill Duration
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, o.`value_numeric` DaysOfARVRefill FROM `obs` o WHERE o.concept_id = 159368 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id = 162240 AND `voided` = 0) GROUP BY o.encounter_id) b ON a.encounter_id = b.encounter_id 

#Pharm Next Pickup
#LEFT JOIN (SELECT person_id, `value_datetime` Next_Pickup_Date, encounter_id FROM obs WHERE concept_id = 5096 AND `voided` = 0) d ON d.encounter_id=a.encounter_id
/*Last ARV_Medication*/
#LEFT JOIN (SELECT o.encounter_id, o.`value_coded`, ConceptName(o.`value_coded`) CurrentARTReg FROM `obs` o 
#WHERE `concept_id` IN (164506, 164507, 164513, 164514, 165702, 165703) AND o.`voided` = 0 AND obs_group_id IS NULL) e ON e.encounter_id=a.encounter_id
/*Last CurrentRegimenLine*/
#LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_datetime`, ConceptName(o.`value_coded`) CurrentRegLine  FROM `obs` o
#WHERE o.`concept_id` = 165708 AND o.`voided` = 0) f ON f.encounter_id=a.encounter_id
#LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_datetime`, o.`value_coded`, ConceptName(o.`value_coded`) CurrentRegLine  FROM `obs` o 
#WHERE o.`concept_id` = 165708 AND o.`voided` = 0) n ON n.encounter_id=a.encounter_id
/*CIHP_PregStatus*/
#LEFT JOIN (SELECT o.person_id, p.`gender`, o.encounter_id, ConceptName(o.`value_coded`) PregStatus FROM `obs` o 
#LEFT JOIN `person` p ON p.`person_id`=o.`person_id` AND p.`voided`=0
#WHERE o.`concept_id` = 165050 AND o.`voided` = 0 AND p.gender = 'F') o ON o.encounter_id=a.encounter_id LV-18-0001
LEFT JOIN `patient_identifier` p2 ON a.`patient_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`voided`=0) a GROUP BY a.patient_id, Pepid, PickupDate ORDER BY patient_id, Occ, Pepid;
#) a GROUP BY a.patient_id, Pepid;




#Cihp_Client_Tracking
SELECT 'CIHP' IP, @State State, @SurgeCommand SurgeCommand, @LGA LGA, @DATIMCode DATIMCode, @FacilityName FacilityName, 
a.*, b.`Reason FOR Tracking`, m.Reason_for_Termination, n.Date_of_Termination, q.Date_Returned, r.Date_LTFU, s.Reason_LTFU, t.LTFU FROM
(SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occurrence, @prev_val := e.patient_id AS person_id, e.`encounter_datetime` obs_datetime, e.encounter_id 
FROM `encounter` e, #LEFT JOIN obs o ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE  e.`encounter_type` = 15 AND e.`form_id` = 13  AND e.`voided` = 0 AND e.`encounter_datetime` >= '2019-10-01' ORDER BY e.patient_id, e.`encounter_datetime` DESC) a
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason FOR Tracking', `obs_datetime`, o.encounter_id FROM obs o WHERE o.concept_id = 165460  AND o.voided=0) b
ON a.person_id=b.person_id AND a.encounter_id=b.encounter_id
LEFT JOIN(SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_for_Defaulting1', MAX(`obs_datetime`) AS obs_datetime, o.`encounter_id` FROM obs o 
WHERE concept_id = 165467 AND o.voided=0 AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime) l
ON a.person_id=l.person_id AND a.encounter_id=l.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_for_Termination', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165470 AND o.voided=0) m
ON a.person_id=m.person_id AND a.encounter_id=m.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_of_Termination', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165469 AND o.voided=0) n
ON a.person_id=m.person_id AND a.encounter_id=n.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_Returned', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165775 AND o.voided=0) q
ON  a.person_id=q.person_id AND a.encounter_id=q.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_LTFU', `obs_datetime`,  o.`encounter_id` FROM obs o WHERE concept_id = 166152 AND o.voided=0) r
ON  a.person_id=m.person_id AND a.encounter_id=r.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_LTFU', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 166157 AND o.voided=0) s
ON  a.person_id=m.person_id AND a.encounter_id=s.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'LTFU', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 5240 AND o.voided=0) t
ON  a.person_id=m.person_id AND a.encounter_id=t.encounter_id;

