DELIMITER $$
DROP FUNCTION IF EXISTS `ConceptName`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ConceptName`(conceptid INT) 
RETURNS TEXT CHARSET latin1 READS SQL DATA DETERMINISTIC BEGIN RETURN 
(SELECT NAME FROM  concept_name  WHERE concept_id = conceptid 
AND locale = 'en' AND locale_preferred = 1 LIMIT 1);END$$ 
DELIMITER ;
DELIMITER $$

USE `openmrs`$$

DROP PROCEDURE IF EXISTS `CIHP_LineList`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CIHP_LineList`()
BEGIN
SET @ValidVLDate1 := (@Reporting_Date) - INTERVAL (SELECT DAYOFYEAR(CONCAT(YEAR(@Reporting_Date),'-12-31'))) DAY;
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
(39, "Kaduna", "BirninGwari", "Birnin Gwari", "z7cRKbwx8L7"),
(40, "Kaduna", "BirninGwari", "Birnin Gwari", "m4mw3TJxbJy"),
(41, "Kaduna", "KadunaNorth", "Kaduna North", "aQTk0pRk6eY"),
(42, "Kaduna", "KadunaNorth", "Kaduna North", "ZD8SEdhkeTQ"),
(43, "Kaduna", "KadunaNorth", "Kaduna North", "HWkSjwMUDvc"),
(44, "Kaduna", "KadunaNorth", "Kaduna North", "dwAvWQFlxx2"),
(45, "Kaduna", "KadunaNorth", "Kaduna North", "rWfabrVIqeg"),
(46, "Kaduna", "KadunaNorth", "Kaduna North", "JDudfxSTSrO"),
(47, "Kaduna", "KadunaNorth", "Kaduna North", "QwrkbFl3Uvj"),
(48, "Kaduna", "KadunaNorth", "Kaduna North", "R8c34xK5kp3"),
(49, "Kaduna", "KadunaNorth", "Kaduna North", "RT0mIfaaDxi"),
(50, "Kaduna", "KadunaNorth", "Kaduna North", "U42lUlqw14s"),
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
(62, "Kaduna", "Igabi", "Ikara", "lWqv0RHnPh9"),
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
(86, "Kaduna", "KadunaSouth", "Kaduna South", "QaeAxjVVGmA"),
(87, "Kaduna", "KadunaSouth", "Kaduna South", "gZeeGIFJ9KY"),
(88, "Kaduna", "KadunaSouth", "Kaduna South", "mX4PekSaaS2"),
(89, "Kaduna", "KadunaSouth", "Kaduna South", "T0cw021kccu"),
(90, "Kaduna", "KadunaSouth", "Kaduna South", "IzbxBJjD6IG"),
(91, "Kaduna", "KadunaSouth", "Kaduna South", "xoXTB4clfGL"),
(92, "Kaduna", "KadunaSouth", "Kaduna South", "Px8Q10LldkO"),
(93, "Kaduna", "KadunaSouth", "Kaduna South", "HF37VJr8eoZ"),
(94, "Kaduna", "KadunaSouth", "Kaduna South", "uq98eMvdS5R"),
(95, "Kaduna", "KadunaSouth", "Kaduna South", "pt20jaMEKHx"),
(96, "Kaduna", "KadunaSouth", "Kaduna South", "yfPEukzMBhy"),
(97, "Kaduna", "Makarfi", "Makarfi", "QuiAPHqPxwY"),
(98, "Kaduna", "Makarfi", "Makarfi", "oPl04jv6omI"),
(99, "Kaduna", "SabonGari", "Sabon Gari", "n81KW6HQJ9Q"),
(100, "Kaduna", "SabonGari", "Sabon Gari", "nDa1uUKmVhb"),
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
(112, "Kaduna", "ZangonKataf", "Zangon Kataf", "uYxACgpJgI9"),
(113, "Kaduna", "ZangonKataf", "Zangon Kataf", "jHjDEUVD87x"),
(114, "Kaduna", "ZangonKataf", "Zangon Kataf", "KPafVFs3f9a"),
(115, "Kaduna", "ZangonKataf", "Zangon Kataf", "LRJl5ilFu2M"),
(116, "Kogi", "Ajaokuta", "Ajaokuta", "xJy5KJJn8gz"),
(117, "Kogi", "Lokoja", "Ajaokuta", "CzwWiALrME8"),
(118, "Kogi", "IgalamelaOdolu", "Igalamela Odolu", "spxEj5Dlg70"),
(119, "Kogi", "Bassa", "Bassa", "merMznnVwIA"),
(120, "Kogi", "Anyigba", "Bassa", "LVbNrbnD8x5"),
(121, "Kogi", "Anyigba", "Omala", "PRHYgNR5CUO"),
(122, "Kogi", "Omala", "Omala", "deDUnu6PVkl"),
(123, "Kogi", "Idah", "Idah", "xwBUYtnRhqv"),
(124, "Kogi", "Anyigba", "Idah", "PawBgipJAZe"),
(125, "Kogi", "Okene", "Adavi", "x8VGMgpn35c"),
(126, "Kogi", "Okene", "Adavi", "MruZ0YOqYQV"),
(127, "Kogi", "Adavi", "Adavi", "WK5gDvZgOD6"),
(128, "Kogi", "YagbaWest", "Yagba West", "yCGhXibQavi"),
(129, "Kogi", "YagbaWest", "Yagba West", "BvUDTXGnj8s"),
(130, "Kogi", "Okene", "Ijumu", "XKAVCLKlMPZ"),
(131, "Kogi", "Ijumu", "Ijumu", "JdodeJT1030"),
(132, "Kogi", "Kabba/Bunu", "Kabba/Bunu", "LRXpCvMxrYU"),
(133, "Kogi", "Okene", "Kabba/Bunu", "EOO49s5EOt4"),
(134, "Kogi", "Okene", "Kabba/Bunu", "CGwIyxDpwT8"),
(135, "Kogi", "Anyigba", "Ofu", "aMZiWfMiJd9"),
(136, "Kogi", "Anyigba", "Ofu", "mf9bRBuufwN"),
(137, "Kogi", "Ofu", "Ofu", "MvoR4rmtllj"),
(138, "Kogi", "Kogi", "Kogi", "XKv4TrYPA47"),
(139, "Kogi", "Lokoja", "Kogi", "KzgNOUrEB8m"),
(140, "Kogi", "Okene", "Okehi", "YxjPfHv2bdg"),
(141, "Kogi", "Okehi", "Okehi", "ROj1N52eCYd"),
(142, "Kogi", "Dekina", "Dekina", "OQ5fZjjCoDR"),
(143, "Kogi", "Anyigba", "Dekina", "nlLwNEPKFnR"),
(144, "Kogi", "Anyigba", "Dekina", "Qiq81djsOyv"),
(145, "Kogi", "Anyigba", "Dekina", "p8ukk5eOdZA"),
(146, "Kogi", "Anyigba", "Dekina", "jUzZE9zzYYf"),
(147, "Kogi", "Anyigba", "Dekina", "ki7kLIEcJ0r"),
(148, "Kogi", "Anyigba", "Dekina", "KkDXS9Qv3oE"),
(149, "Kogi", "Anyigba", "Dekina", "riZZbajMMKD"),
(150, "Kogi", "Okene", "Okene", "CLVU561R6tp"),
(151, "Kogi", "Okene", "Okene", "sKytXCdZsh5"),
(152, "Kogi", "Okene", "Okene", "WKSMZvuda1v"),
(153, "Kogi", "Ankpa", "Ankpa", "elrdVlVn0kp"),
(154, "Kogi", "Ankpa", "Ankpa", "logPshzwZGg"),
(155, "Kogi", "Ankpa", "Ankpa", "mJgQrfBTx3f"),
(156, "Kogi", "Ankpa", "Ankpa", "Et6wjYLz9Sj"),
(157, "Kogi", "Okene", "Ogori/Magongo", "H7M8CLeCiXD"),
(158, "Kogi", "Ogori/Magongo", "Ogori/Magongo", "cMvadwiBado"),
(159, "Kogi", "Amkpa", "Olamaboro", "h9drujCcifQ"),
(160, "Kogi", "Olamaboro", "Olamaboro", "Re4VU7MrOUM"),
(161, "Kogi", "Lokoja", "Lokoja", "D4zacvYxq0b"),
(162, "Kogi", "Lokoja", "Lokoja", "KsNbhiCMPvu"),
(163, "Kogi", "Lokoja", "Lokoja", "Aq2CeR3h187"),
(164, "Kogi", "Lokoja", "Lokoja", "gkOIcMHnyHM"),
(165, "Kogi", "MopaMuro", "Mopa Muro", "CdZWAGT8Qes"),
(166, "Kogi", "Ibaji", "Ibaji", "cNr80ZanaDp"),
(167, "Kogi", "YagbaEast", "Yagba East", "wYSTfYinFO7"),
(168, "Lagos", "ibeju-lekki", "ibeju-lekki", "ISi4PDO97U5"),
(169, "Lagos", "Ibeju-lekki_Eti-Osa", "ibeju-lekki", "KmKzDT9YmmR"),
(170, "Lagos", "Ibeju-lekki_Eti-Osa", "Eti Osa", "K4fl4VyS1Qp"),
(171, "Lagos", "Ibeju-lekki_Eti-Osa", "Eti Osa", "W8ZrdhS5bgo"),
(172, "Lagos", "Ibeju-lekki_Eti-Osa", "Eti Osa", "NCrwoKufAu9"),
(173, "Lagos", "Ibeju-lekki_Eti-Osa", "Eti Osa", "AfLGN7kmKaK"),
(174, "Lagos", "Ibeju-lekki_Eti-Osa", "Eti Osa", "BPvnX1MlAAl"),
(175, "Lagos", "Ibeju-lekki_Eti-Osa", "Eti Osa", "UEetB08FZNc"),
(176, "Lagos", "Ibeju-lekki_Eti-Osa", "Eti Osa", "lwmRYQg2xSI"),
(177, "Lagos", "EtiOsa", "Eti Osa", "VHITI10xoZc"),
(178, "Lagos", "Epe", "Epe", "uzCT1lOZhL5"),
(179, "Lagos", "Epe", "Epe", "hqT0jwt1zsL"),
(180, "Lagos", "Epe", "Epe", "smKEPkP7G0O"),
(181, "Lagos", "Epe", "Epe", "wblyUihZxEk"),
(182, "Lagos", "ifako-ijaiye", "ifako-ijaiye", "sSg7pUov51f"),
(183, "Lagos", "Ifako_Alimosho", "ifako-ijaiye", "WNZk7unzn4x"),
(184, "Lagos", "Ifako_Alimosho", "ifako-ijaiye", "CtKYcZmtnBQ"),
(185, "Lagos", "Ifako_Alimosho", "ifako-ijaiye", "OWOckBlm9Du"),
(186, "Lagos", "Ifako_Alimosho", "ifako-ijaiye", "W7hscr3wKtm"),
(187, "Lagos", "Ifako_Alimosho", "ifako-ijaiye", "VIgbUF6H4ma"),
(188, "Lagos", "Alimosho_Amuwo", "Amuwo-Odofin", "V9F0fejCYiz"),
(189, "Lagos", "Alimosho_Amuwo", "Amuwo-Odofin", "wsaK58gH5tH"),
(190, "Lagos", "Alimosho_Amuwo", "Amuwo-Odofin", "brE1SYIkAqX"),
(191, "Lagos", "Alimosho_Amuwo", "Amuwo-Odofin", "Ho8HeGPzmwk"),
(192, "Lagos", "Amuwo-Odofin", "Amuwo-Odofin", "HOJVVYgS5vV"),
(193, "Lagos", "Ikeja", "Ikeja", "u8skYaLV6QF"),
(194, "Lagos", "Mushin_Ikeja", "Ikeja", "y5TzOvctmba"),
(195, "Lagos", "Mushin_Ikeja", "Ikeja", "zkYOojlUFww"),
(196, "Lagos", "Mushin_Ikeja", "Ikeja", "ptxAOdQ5Tp8"),
(197, "Lagos", "Alimosho_Amuwo", "Alimosho", "RD3JhCrIpQg"),
(198, "Lagos", "Ifako_Alimosho", "Alimosho", "D8fXWtqwMAU"),
(199, "Lagos", "Alimosho_Amuwo", "Alimosho", "tscvxzvaPHe"),
(200, "Lagos", "Alimosho_Amuwo", "Alimosho", "dsYsl8bXYX0"),
(201, "Lagos", "Alimosho_Amuwo", "Alimosho", "Mq45WIHMbhI"),
(202, "Lagos", "Alimosho_Amuwo", "Alimosho", "jMnxdoXrX0B"),
(203, "Lagos", "Alimosho_Amuwo", "Alimosho", "LNguEy0vjvR"),
(204, "Lagos", "Alimosho_Amuwo", "Alimosho", "R3X9MttmeAb"),
(205, "Lagos", "Ifako_Alimosho", "Alimosho", "iJX8pwklfN3"),
(206, "Lagos", "Ifako_Alimosho", "Alimosho", "owB333UT2qz"),
(207, "Lagos", "Alimosho", "Alimosho", "AUIjfqeZEFH"),
(208, "Lagos", "Oshodi_Isolo", "Oshodi-Isolo", "lJkmYJB9kHr"),
(209, "Lagos", "Oshodi_Isolo", "Oshodi-Isolo", "BODWX46tM9Y"),
(210, "Lagos", "Oshodi_Isolo", "Oshodi-Isolo", "CHqAwjTU2Jc"),
(211, "Lagos", "Oshodi_Isolo", "Oshodi-Isolo", "gFlvov8GYAp"),
(212, "Lagos", "Mushin_Ikeja", "Mushin", "WlXQVJSBvrn"),
(213, "Lagos", "Mushin_Ikeja", "Mushin", "bjExvCDZVsB"),
(214, "Lagos", "Mushin_Ikeja", "Mushin", "LZC72BhBZBd"),
(215, "Lagos", "Mushin_Ikeja", "Mushin", "a9EDyKYjIlc"),
(216, "Lagos", "Mushin_Ikeja", "Mushin", "PdTC8ihrFRQ"),
(217, "Lagos", "Mushin_Ikeja", "Mushin", "qEW4Bhjh7Lv");

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
SET SESSION sql_mode = '';
DROP TABLE IF EXISTS Biometrics_Captured;
CREATE TEMPORARY TABLE Biometrics_Captured AS
SELECT `patient_Id`, `date_created` Date_Captured FROM `biometricinfo` GROUP BY `patient_Id`;
 
DROP TABLE IF EXISTS CIHP_Patient;
CREATE TEMPORARY TABLE CIHP_Patient AS
SELECT a.`patient_id`, b.`identifier` Pepid, c.`birthdate` DOB, c.`gender` Sex, c.`dead`, c.`death_date`,
d.`value` Phone_No, e.`address2`, e.`address1`, e.`city_village`, e.`state_province`,
f.`family_name` Surname, f.`given_name` FirstName, g.`Date_Captured` AS Biometrics, en.`encounter_datetime`
FROM `patient` a 
LEFT JOIN `patient_identifier` b ON a.`patient_id` = b.`patient_id`
LEFT JOIN `person` c ON a.`patient_id`=c.`person_id`
LEFT JOIN `person_attribute` d ON a.`patient_id`=d.`person_id` AND d.`voided`=0
LEFT JOIN `person_address` e ON a.`patient_id`=e.`person_id` AND e.`voided`=0
LEFT JOIN `person_name` f ON a.`patient_id`=f.`person_id`
LEFT JOIN `encounter` en ON a.`patient_id`=en.`patient_id`
LEFT JOIN Biometrics_Captured g ON a.`patient_id`=g.`patient_id`
WHERE en.`encounter_type` = 14 AND en.`encounter_datetime` <= @Reporting_Date AND en.`voided`=0 
AND a.`voided`=0 AND b.`identifier_type` = 4
GROUP BY a.`patient_id`;
SET SESSION sql_mode = '';
DROP TABLE IF EXISTS CIHP_Hop;
CREATE TEMPORARY TABLE CIHP_Hop AS
SELECT a.`patient_id`, a.`identifier` HospitalNo
FROM `patient_identifier` a
WHERE a.`voided`=0 AND a.`identifier_type` = 5
GROUP BY a.`patient_id`;
DROP TABLE IF EXISTS CIHP_ARTStartDate;
CREATE TEMPORARY TABLE CIHP_ARTStartDate AS
SELECT o.`person_id`, o.`value_datetime` AS ARTStartDate
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` = 159599 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0 AND o.`value_datetime` <= @Reporting_Date;
/*First CurrentRegimenLine*/
DROP TABLE IF EXISTS CIHP_1st_RegimenLine;
CREATE TEMPORARY TABLE CIHP_1st_RegimenLine AS
SELECT o.`person_id`, o.`concept_id`, o.`obs_datetime`, o.`value_coded`,ConceptName(o.`value_coded`) RegLineAtStart  FROM `obs` o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
WHERE e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`concept_id` = 165708 AND o.`voided` = 0
GROUP BY o.`person_id`, o.`obs_datetime`;
/*First ARV_Medication*/
DROP TABLE IF EXISTS CIHP_1st_ARV_Medication;
CREATE TEMPORARY TABLE CIHP_1st_ARV_Medication AS
SELECT o.`person_id`, o.`concept_id`, o.`obs_datetime`, o.`value_coded`, ConceptName(o.`value_coded`) ARTRegAtStart  FROM `obs` o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
WHERE e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`concept_id` IN (164506, 164507, 164513, 164514, 165702, 165703) AND o.`voided` = 0 
GROUP BY o.`person_id`, o.`obs_datetime`;
/*SELECT o.`person_id`, o.`concept_id`, c.`name`, o.`obs_datetime` VisitDate, o.`value_coded`, c2.`name`, o.`value_datetime`, o.`value_coded_name_id`, o.`value_numeric`
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
left join `concept_name` c on o.`concept_id`=c.`concept_id` AND c.locale = 'en' AND c.locale_preferred = 1 
LEFT JOIN `concept_name` c2 ON o.`value_coded`=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1 
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 
AND o.`voided` = 0;*/
/*Last Medication_duration*/

/*----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS CIHP_PharmDetails;
CREATE TEMPORARY TABLE CIHP_PharmDetails AS
SELECT a.patient_id, a. LastPickupDate, a.`encounter_id`, b.DaysOfARVRefill, c.Pill_Balance, d.Next_Pickup_Date, e.CurrentARTReg, n.CurrentRegLine, /*g.ARV_Drug_Strength,
h.OI_Drug_CTX, j.CTX_Strength, i.OI_Drug_INH, k.INH_Strength, l.DSD_Model, m.DDD_Fac_Disp,*/ o.PregStatus
FROM (SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, 
e.`encounter_datetime` LastPickupDate, e.`encounter_id`
FROM `encounter` e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND e.`voided` = 0 AND e.`encounter_datetime` <= @Reporting_Date 
ORDER BY e.patient_id, e.`encounter_datetime` DESC) a
#ART Refill Duration
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, o.`value_numeric` DaysOfARVRefill FROM `obs` o WHERE o.concept_id = 159368 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id = 162240 AND `voided` = 0) GROUP BY o.encounter_id) b ON a.encounter_id = b.encounter_id 
#Pill Balance Field
LEFT JOIN (SELECT person_id, CAST(`value_text` AS UNSIGNED) Pill_Balance, encounter_id FROM obs WHERE concept_id = 166406 AND `voided` = 0) c ON c.encounter_id=a.encounter_id
#Pharm Next Pickup
LEFT JOIN (SELECT person_id, `value_datetime` Next_Pickup_Date, encounter_id FROM obs WHERE concept_id = 5096 AND `voided` = 0) d ON d.encounter_id=a.encounter_id
/*Last ARV_Medication*/
LEFT JOIN (SELECT o.encounter_id, o.`value_coded`, ConceptName(o.`value_coded`) CurrentARTReg FROM `obs` o 
WHERE `concept_id` IN (164506, 164507, 164513, 164514, 165702, 165703) AND o.`voided` = 0 AND obs_group_id IS NULL) e ON e.encounter_id=a.encounter_id
/*Last CurrentRegimenLine*/
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_datetime`, ConceptName(o.`value_coded`) CurrentRegLine  FROM `obs` o
WHERE o.`concept_id` = 165708 AND o.`voided` = 0) f ON f.encounter_id=a.encounter_id
/*#ARV Drug Strength
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_id`, GROUP_CONCAT(DISTINCT ConceptName(o.`value_coded`) SEPARATOR '-') ARV_Drug_Strength FROM `obs` o
WHERE o.concept_id = 165725 AND o.`voided` = 0 AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id = 162240 AND `voided` = 0) 
GROUP BY o.`encounter_id`) g ON g.encounter_id=a.encounter_id
#OI Drug CTX
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, ConceptName(o.`value_coded`) OI_Drug_CTX FROM `obs` o WHERE o.concept_id = 165727 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id = 165726 AND `voided` = 0) AND ConceptName(o.`value_coded`) LIKE 'CTX%') h ON h.encounter_id=a.encounter_id
#OI Drug INH
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, ConceptName(o.`value_coded`) OI_Drug_INH FROM `obs` o WHERE o.concept_id = 165727 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id = 165726 AND `voided` = 0 AND ConceptName(o.`value_coded`) LIKE 'IS%')) i ON i.encounter_id=a.encounter_id
#OI Drug Strength CTX
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, ConceptName(o.`value_coded`) CTX_Strength FROM `obs` o WHERE o.concept_id = 165725 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_group_id FROM obs WHERE value_coded = 165257 AND `voided` = 0))j ON j.encounter_id=a.encounter_id
#OI Drug Strength INH
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, ConceptName(o.`value_coded`) INH_Strength FROM `obs` o WHERE o.concept_id = 165725 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_group_id FROM obs WHERE value_coded = 1679 AND `voided` = 0))k ON k.encounter_id=a.encounter_id
#Differentiated Service Delivery Model 166148
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_group_id`,  ConceptName(o.`value_coded`) DSD_Model
FROM `obs` o WHERE o.`concept_id` = 166148 AND o.`voided` = 0) l ON l.encounter_id=a.encounter_id
#Facility Dispensing (166276) or DDD
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_group_id`,  ConceptName(o.`value_coded`) DDD_Fac_Disp
FROM `obs` o WHERE o.`concept_id` IN (166276, 166363) AND o.`voided` = 0) m ON m.encounter_id=a.encounter_id
/*Last CurrentRegimenLine*/
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_datetime`, o.`value_coded`, ConceptName(o.`value_coded`) CurrentRegLine  FROM `obs` o 
WHERE o.`concept_id` = 165708 AND o.`voided` = 0) n ON n.encounter_id=a.encounter_id
/*CIHP_PregStatus*/
LEFT JOIN (SELECT o.person_id, p.`gender`, o.encounter_id, ConceptName(o.`value_coded`) PregStatus FROM `obs` o 
LEFT JOIN `person` p ON p.`person_id`=o.`person_id` AND p.`voided`=0
WHERE o.`concept_id` = 165050 AND o.`voided` = 0 AND p.gender = 'F') o ON o.encounter_id=a.encounter_id
WHERE a.Occ = 1;

/*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*CIHP_ViralLoad_Data*/
DROP TABLE IF EXISTS CIHP_ViralLoad_Data;CREATE TEMPORARY TABLE CIHP_ViralLoad_Data AS
SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occurrence, @prev_val := e.patient_id AS person_id, p2.`identifier` Pepid,
e.`encounter_datetime` DateOfCurrentVL, o.`value_numeric` CurrentVL, Date_Result_Received
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1
LEFT JOIN (SELECT DISTINCT person_id, encounter_id, value_datetime AS Date_Result_Received FROM obs WHERE concept_id = 165987 AND voided=0)
AS d ON  o.person_id=d.person_id AND o.`encounter_id`=d.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` = 856 AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 AND e.`encounter_datetime` <= @Reporting_Date
ORDER BY e.patient_id, e.`encounter_datetime` DESC;
DROP TABLE IF EXISTS VL_Search;
CREATE TEMPORARY TABLE VL_Search AS
SELECT * FROM CIHP_ViralLoad_Data WHERE Occurrence = 1 AND DateOfCurrentVL <= @Reporting_Date;
/*CIHP_VL_Indication*/
DROP TABLE IF EXISTS CIHP_VL_Indication;
CREATE TEMPORARY TABLE CIHP_VL_Indication AS
SELECT o.`person_id`, a.pepid, o.`concept_id`, o.`obs_datetime`, o.`value_coded`, ConceptName(o.`value_coded`) ViralLoadIndication  FROM `obs` o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN VL_Search a ON o.`person_id`=a.`person_id` AND o.`obs_datetime`=a.DateOfCurrentVL
WHERE e.`encounter_type` = 11 AND e.`form_id` = 21 AND o.`concept_id` = 164980 AND o.`voided` = 0 AND  o.`person_id`= a.`person_id`
GROUP BY o.`person_id`, o.`obs_datetime`;
/*CIHP_Transfer_In*/
DROP TABLE IF EXISTS CIHP_Transfer_In;
CREATE TEMPORARY TABLE CIHP_Transfer_In AS
SELECT * FROM (SELECT o.`person_id`, o.`concept_id`, o.`obs_datetime`, o.`value_coded`, ConceptName(o.`value_coded`) TI  FROM `obs` o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
WHERE e.`encounter_type` = 14 AND e.`form_id` = 23 AND o.`concept_id` = 160540 AND o.`voided` = 0  AND o.`obs_datetime` <= @Reporting_Date 
GROUP BY o.`person_id`, o.`obs_datetime`) a WHERE a.TI LIKE 'Trans%';
/*Create Latest Weight
DROP TABLE IF EXISTS Last_Weight;
CREATE TEMPORARY TABLE Last_Weight AS
SELECT o.person_id, o.obs_datetime AS Visit_Date, o.value_numeric AS Weight
FROM obs o WHERE o.concept_id = 5089 AND o.obs_datetime = 
(SELECT MAX(o2.obs_datetime) FROM obs o2 WHERE o.person_id=o2.person_id AND o2.concept_id = 5089 and o2.obs_datetime <= @Reporting_Date) GROUP BY o.person_id;*/
DROP TABLE IF EXISTS All_Weight;
CREATE TEMPORARY TABLE All_Weight AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id, p2.`identifier` Pepid,
 o.obs_datetime AS Visit_Date, o.value_numeric AS Weight
FROM `obs` o 
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.concept_id = 5089 AND p2.`identifier_type`=4  AND o.`voided` = 0 AND o.`obs_datetime` <= @Reporting_Date
ORDER BY o.person_id, o.`obs_datetime` DESC;
DROP TABLE IF EXISTS Last_Weight;
CREATE TEMPORARY TABLE Last_Weight AS
SELECT * FROM All_Weight WHERE Occurrence = 1 AND Visit_Date <= @Reporting_Date;
SET SESSION sql_mode = '';
/*DROP TABLE IF EXISTS All_ARVs;
CREATE TEMPORARY TABLE All_ARVs AS
SELECT
  o.`person_id`,
  p.`identifier` PepID,
  o.`obs_datetime` AS Visit_Date,
  o.`value_coded`,
  IF (o.`value_coded` = c2.`concept_id`, c2.name, '') AS Value_Name,
  GROUP_CONCAT(DISTINCT o.value_coded SEPARATOR ', ') AS All_values
FROM
  `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
  LEFT JOIN `concept_name` c2 ON c2.`concept_id`=o.`value_coded` AND c2.locale = 'en' AND c2.locale_preferred = 1 LEFT JOIN `patient_identifier` p
    ON o.`person_id` = p.`patient_id` AND p.`identifier_type` = 4 AND p.`preferred` = 1
  WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND o.`concept_id` = 165724 GROUP BY o.`person_id`, o.`obs_datetime`;*/
#DROP TABLE IF EXISTS First_TLD;
#CREATE TEMPORARY TABLE First_TLD AS
 # SELECT person_id, Pepid, MIN(Visit_Date) AS First_TLD_Date, All_values  
 # FROM All_ARVs WHERE All_Values IN ('165681') OR All_Values IN ('165631') OR All_Values LIKE '%161364, 165631%' OR All_Values LIKE '%165631, 161364%' GROUP BY person_id;
  
/* Sample Collection ***Old lines***
DROP TABLE IF EXISTS CIHP_VL_SampleCol;
CREATE TEMPORARY TABLE CIHP_VL_SampleCol AS
SELECT o.`person_id`, o.`obs_datetime` VisitDate, o.`value_datetime` Sample_Date, o.`Date_Created`, 'Sample Collection' AS 'Entry Type' FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` LEFT JOIN `patient_identifier` p ON o.`person_id`=p.`patient_id` 
WHERE o.concept_id = 159951 AND e.`form_id`=67 AND p.`identifier_type`=4 AND o.`value_datetime` BETWEEN @ValidVLDate1 AND @Reporting_Date;*/
/* Sample Collection */	
/* To discontinue line 411 to 421 */
/*DROP TABLE IF EXISTS CIHP_All_VL_SampleCol;
CREATE TEMPORARY TABLE CIHP_All_VL_SampleCol AS
/*SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id, p2.`identifier` Pepid,
o.`obs_datetime` Sample_Date
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.concept_id = 159951 AND e.`form_id`=67 AND p2.`identifier_type`=4  AND o.`voided` = 0 AND o.`obs_datetime` <= @Reporting_Date
ORDER BY o.person_id, o.`obs_datetime` DESC;
DROP TABLE IF EXISTS CIHP_VL_SampleCol;
CREATE TEMPORARY TABLE CIHP_VL_SampleCol AS
SELECT * FROM CIHP_All_VL_SampleCol WHERE Occurrence = 1 AND Sample_Date <= @Reporting_Date;*/
/* New update for the most recent Sample Collect Date from Lab Order and Result Form*/
DROP TABLE IF EXISTS CIHP_VL_SampleCol1;
CREATE TEMPORARY TABLE CIHP_VL_SampleCol1 AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
person_id test, o.encounter_id, `obs_datetime`, value_datetime AS Last_VL_Sample_Date FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE concept_id = 159951 AND o.voided=0 AND e.`encounter_type` = 11 AND e.`form_id` = 21 AND o.`obs_datetime` <= @Reporting_Date
ORDER BY o.person_id, o.`obs_datetime` DESC;
DROP TABLE IF EXISTS CIHP_VL_SampleCol;
CREATE TEMPORARY TABLE CIHP_VL_SampleCol AS
SELECT * FROM CIHP_VL_SampleCol1 WHERE Occurrence = 1;
/*Update End 17th August 2021*/
/* New update for the most recent Sample Collect Date from Lab Order and Result Form*/
/*CIHP_ART_List*/
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
DROP TABLE IF EXISTS CIHP_ART_List;
CREATE TEMPORARY TABLE CIHP_ART_List AS
SELECT a.`patient_id`, f.ARTStartDate, a.LastPickupDate, a.DaysOfARVRefill, e.RegLineAtStart, b.ARTRegAtStart, 
a.CurrentRegLine, a.CurrentARTReg, a.PregStatus, h.CurrentVL, h.DateOfCurrentVL, h.Date_Result_Received, i.ViralLoadIndication, m.Last_VL_Sample_Date, j.TI, 
(a.LastPickupDate + INTERVAL (a.DaysOfARVRefill) DAY) AS NextAppmt, k.Weight, k.Visit_Date, a.Pill_Balance, a.Next_Pickup_Date/*,
a.ARV_Drug_Strength, a.OI_Drug_CTX, a.CTX_Strength, a.OI_Drug_INH, a.INH_Strength, a.DSD_Model, a.DDD_Fac_Disp*/
FROM CIHP_PharmDetails a 
LEFT JOIN  CIHP_1st_ARV_Medication b ON a.patient_id=b.person_id
LEFT JOIN CIHP_1st_RegimenLine e ON a.patient_id=e.person_id
LEFT JOIN CIHP_ARTStartDate f ON a.patient_id=f.person_id
LEFT JOIN VL_Search h ON a.patient_id=h.person_id
LEFT JOIN CIHP_VL_Indication i ON a.patient_id=i.person_id
LEFT JOIN CIHP_Transfer_In j ON a.patient_id=j.person_id
LEFT JOIN Last_Weight k ON a.patient_id=k.person_id
LEFT JOIN CIHP_VL_SampleCol m ON a.patient_id=m.person_id;
SET SESSION sql_mode = '';
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
 #Updated 31/12/2022
DROP TABLE IF EXISTS Cihp_Client_Tracking;
CREATE TEMPORARY TABLE Cihp_Client_Tracking AS
SELECT a.*, b.`Reason FOR Tracking`, c.Partner_full_name, d.Address_of_Tx_supporter, e.Contact_phone_No, f.Date_of_Last_Actual, g.Date_Missed_Scheduled_App,
ContAttempt_Date1, i.who_attempted_contact1, j.Mode_of_Communication1, k.Person_Contacted1, l.Reason_for_Defaulting1, m.Reason_for_Termination, n.Date_of_Termination,
o.Previous_ARV_exposure, p.Referred_for, q.Date_Returned, r.Date_LTFU, s.Reason_LTFU, t.LTFU, u.Name_oF_Tracker, v.Tracker_Sig_Date, w.Facility_Transferred_To FROM
(SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occurrence, @prev_val := e.patient_id AS person_id, e.`encounter_datetime` obs_datetime, e.encounter_id 
FROM `encounter` e, #LEFT JOIN obs o ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE  e.`encounter_type` = 15 AND e.`form_id` = 13  AND e.`voided` = 0 AND e.`encounter_datetime` <= @Reporting_Date ORDER BY e.patient_id, e.`encounter_datetime` DESC) a
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason FOR Tracking', `obs_datetime`, o.encounter_id FROM obs o WHERE o.concept_id = 165460  AND o.voided=0) b
ON a.person_id=b.person_id AND a.encounter_id=b.encounter_id
LEFT JOIN (SELECT `person_id`, `value_text` AS 'Partner_full_name', `obs_datetime`, o.encounter_id FROM obs o WHERE concept_id = 161135 AND o.voided=0) c 
ON a.person_id=c.person_id AND a.encounter_id=c.encounter_id
LEFT JOIN (SELECT `person_id`, `value_text` AS 'Address_of_Tx_supporter', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 160641 AND o.voided=0) d
ON a.person_id=d.person_id AND a.encounter_id=d.encounter_id
LEFT JOIN (SELECT `person_id`, `value_text` AS 'Contact_phone_No', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 159635 AND o.voided=0) e
ON a.person_id=e.person_id AND a.encounter_id=e.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_of_Last_Actual', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165461 AND o.voided=0) f
ON a.person_id=f.person_id AND a.encounter_id=f.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_Missed_Scheduled_App', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165778 AND o.voided=0) g
ON a.person_id=g.person_id AND a.encounter_id=g.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'ContAttempt_Date1', MAX(`obs_datetime`) AS obs_datetime, o.`encounter_id` FROM obs o
WHERE concept_id = 165463 AND o.voided = 0 AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime) h
ON a.person_id=h.person_id AND a.encounter_id=h.encounter_id
LEFT JOIN (SELECT `person_id`, `value_text` AS 'who_attempted_contact1', MAX(`obs_datetime`) AS obs_datetime, o.`encounter_id` FROM obs o 
WHERE concept_id = 165464 AND o.voided = 0 AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime) i
ON a.person_id=i.person_id AND a.encounter_id=i.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Mode_of_Communication1', MAX(`obs_datetime`) AS obs_datetime,  o.`encounter_id` FROM obs o
WHERE concept_id = 165465 AND o.voided = 0 AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime) j
ON a.person_id=j.person_id AND a.encounter_id=j.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Person_Contacted1', MAX(`obs_datetime`) AS obs_datetime, o.`encounter_id` FROM obs o 
WHERE concept_id = 165466 AND o.voided=0 AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime) k
ON a.person_id=k.person_id AND a.encounter_id=k.encounter_id
LEFT JOIN(SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_for_Defaulting1', MAX(`obs_datetime`) AS obs_datetime, o.`encounter_id` FROM obs o 
WHERE concept_id = 165467 AND o.voided=0 AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime) l
ON a.person_id=l.person_id AND a.encounter_id=l.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_for_Termination', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165470 AND o.voided=0) m
ON a.person_id=m.person_id AND a.encounter_id=m.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_of_Termination', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165469 AND o.voided=0) n
ON a.person_id=m.person_id AND a.encounter_id=n.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Previous_ARV_exposure', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165586 AND o.voided=0) o
ON  a.person_id=m.person_id AND a.encounter_id=o.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Referred_for', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165776 AND o.voided=0) p
ON  a.person_id=m.person_id AND a.encounter_id=p.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_Returned', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165775 AND o.voided=0) q
ON  a.person_id=q.person_id AND a.encounter_id=q.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_LTFU', `obs_datetime`,  o.`encounter_id` FROM obs o WHERE concept_id = 166152 AND o.voided=0) r
ON  a.person_id=m.person_id AND a.encounter_id=r.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_LTFU', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 166157 AND o.voided=0) s
ON  a.person_id=m.person_id AND a.encounter_id=s.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'LTFU', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 5240 AND o.voided=0) t
ON  a.person_id=m.person_id AND a.encounter_id=t.encounter_id
LEFT JOIN (SELECT `person_id`, `value_text` AS 'Name_oF_Tracker', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165459 AND o.voided=0) u
ON  a.person_id=m.person_id AND a.encounter_id=u.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Tracker_Sig_Date', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165777 AND o.voided=0) v
ON  a.person_id=m.person_id AND a.encounter_id=v.encounter_id
LEFT JOIN (SELECT `person_id`, `value_text` AS 'Facility_Transferred_To', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 159495 AND o.voided=0) w
ON  a.person_id=m.person_id AND a.encounter_id=w.encounter_id
WHERE a.Occurrence=1;
SET SESSION sql_mode = '';
DROP TABLE IF EXISTS All_IPT;
CREATE TEMPORARY TABLE All_IPT AS
  SELECT `person_id`, MAX(`obs_datetime`) obs_datetime FROM obs o 
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE e.`encounter_type` = 23 AND e.`form_id` = 53 AND o.`voided`= 0 AND o.`obs_datetime` <= @Reporting_Date
  GROUP BY person_id;
DROP TABLE IF EXISTS Eligible_For_IPT;
CREATE TEMPORARY TABLE Eligible_For_IPT AS
  SELECT `person_id`, `value_coded` AS 'Eligible_For_IPT', `obs_datetime` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165986 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0;
DROP TABLE IF EXISTS Date_IPT_start;
CREATE TEMPORARY TABLE Date_IPT_start AS
  SELECT `person_id`, `value_datetime` AS 'Date_IPT_start', `obs_datetime` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165994 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0;
DROP TABLE IF EXISTS Outcome_of_IPT;
CREATE TEMPORARY TABLE Outcome_of_IPT AS
  SELECT `person_id`, `value_coded` AS 'Outcome_of_IPT', `obs_datetime` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166007 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0;
DROP TABLE IF EXISTS Date_of_Outcome;
CREATE TEMPORARY TABLE Date_of_Outcome AS
  SELECT `person_id`, `value_datetime` AS 'Date_of_Outcome', `obs_datetime` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166008 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0;
DROP TABLE IF EXISTS Sputum_AFB_TB;
CREATE TEMPORARY TABLE Sputum_AFB_TB AS
  SELECT `person_id`, IF(`value_coded` = 1, 'Sputum_AFB_TB', 'No') AS 'Sputum_AFB_TB', `obs_datetime` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166141 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0;
DROP TABLE IF EXISTS GeneXpert_TB;
CREATE TEMPORARY TABLE GeneXpert_TB AS
  SELECT `person_id`, IF(`value_coded` = 1, 'GeneXpert_TB', 'No') AS 'GeneXpert_TB', `obs_datetime` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166142 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0;
DROP TABLE IF EXISTS Chest_Xray_TB;
CREATE TEMPORARY TABLE Chest_Xray_TB AS  
  SELECT `person_id`, IF(`value_coded` = 1, 'Chest_Xray_TB', 'No') AS 'Chest_Xray_TB', `obs_datetime` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166143 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0;
DROP TABLE IF EXISTS Culture_TB;
CREATE TEMPORARY TABLE Culture_TB AS  
  SELECT `person_id`, IF(`value_coded` = 1, 'Culture_TB', 'No') AS 'Culture_TB', `obs_datetime` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166144 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0;
DROP TABLE IF EXISTS Sputum_AFB_Result;
CREATE TEMPORARY TABLE Sputum_AFB_Result AS 
  SELECT `person_id`, value_coded AS 'Sputum_AFB_Result', `obs_datetime` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165968 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0;
DROP TABLE IF EXISTS GeneXpert_Result;
CREATE TEMPORARY TABLE GeneXpert_Result AS 
  SELECT `person_id`, value_coded AS 'GeneXpert_Result', `obs_datetime` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165975 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0;
DROP TABLE IF EXISTS Chest_Xray_Result;
CREATE TEMPORARY TABLE Chest_Xray_Result AS
  SELECT `person_id`, value_coded AS 'Chest_Xray_Result', `obs_datetime` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165972 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0;
DROP TABLE IF EXISTS Culture_Result;
CREATE TEMPORARY TABLE Culture_Result AS
  SELECT `person_id`, value_coded AS 'Culture_Result', `obs_datetime` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165969 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0;
  
DROP TABLE IF EXISTS All_TB_Investigation;
CREATE TEMPORARY TABLE All_TB_Investigation AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id, p2.`identifier` Pepid,
o.`obs_datetime`
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` IN (166141, 166142, 166143, 166144)  AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided` = 0 AND o.`obs_datetime` <= @Reporting_Date
ORDER BY o.person_id, o.`obs_datetime` DESC; 
DROP TABLE IF EXISTS Last_All_TB_Investig;
CREATE TEMPORARY TABLE Last_All_TB_Investig AS
SELECT a.Occurrence, a.person_id, a.Pepid, a.obs_datetime Date_TB_Investig,  f.Sputum_AFB_TB, c4.name Sputum_AFB_Result,
g.GeneXpert_TB, c5.name GeneXpert_Result, h.Chest_Xray_TB, c6.name Chest_Xray_Result, i.Culture_TB, c7.name Culture_Result
FROM All_TB_Investigation a 
LEFT JOIN Sputum_AFB_TB f ON a.person_id=f.person_id AND a.obs_datetime=f.obs_datetime 
LEFT JOIN GeneXpert_TB g ON a.person_id=g.person_id  AND a.obs_datetime=g.obs_datetime 
LEFT JOIN Chest_Xray_TB h ON a.person_id=h.person_id  AND a.obs_datetime=h.obs_datetime 
LEFT JOIN Culture_TB i ON a.person_id=i.person_id  AND a.obs_datetime=i.obs_datetime 
LEFT JOIN Sputum_AFB_Result j ON a.person_id=j.person_id  AND a.obs_datetime=j.obs_datetime 
LEFT JOIN GeneXpert_Result k ON a.person_id=k.person_id AND a.obs_datetime=k.obs_datetime 
LEFT JOIN Chest_Xray_Result l ON a.person_id=l.person_id  AND a.obs_datetime=l.obs_datetime 
LEFT JOIN Culture_Result m ON a.person_id=m.person_id  AND a.obs_datetime=m.obs_datetime 
LEFT JOIN `patient_identifier` p1 ON a.`person_id` = p1.`patient_id` AND p1.`identifier_type` = 4
LEFT JOIN `concept_name` c4 ON j.Sputum_AFB_Result=c4.`concept_id` AND c4.locale = 'en' AND c4.locale_preferred = 1
LEFT JOIN `concept_name` c5 ON k.GeneXpert_Result=c5.`concept_id` AND c5.locale = 'en' AND c5.locale_preferred = 1
LEFT JOIN `concept_name` c6 ON l.Chest_Xray_Result=c6.`concept_id` AND c6.locale = 'en' AND c6.locale_preferred = 1
LEFT JOIN `concept_name` c7 ON m.Culture_Result=c7.`concept_id` AND c7.locale = 'en' AND c7.locale_preferred = 1
WHERE a.Occurrence =1;
  
  
  
DROP TABLE IF EXISTS Cihp_IPT_TB;
CREATE TEMPORARY TABLE Cihp_IPT_TB AS
SELECT a.person_id, p1.`identifier` AS PepID, c2.`name` AS Eligible_For_IPT, c.Date_IPT_start, c3.`name` AS Outcome_of_IPT, e.Date_of_Outcome, 
CONCAT_WS( ', ',f.Sputum_AFB_TB, f.GeneXpert_TB, f.Chest_Xray_TB, f.Culture_TB) AS TB_Investigations, 
CONCAT_WS( ', ', f.Sputum_AFB_Result, f.GeneXpert_Result, f.Chest_Xray_Result, f.Culture_Result) AS Investig_Result,
IF(CONCAT_WS(', ',f.Sputum_AFB_TB, f.GeneXpert_TB, f.Chest_Xray_TB, f.Culture_TB) IS NULL OR CONCAT_WS(', ',f.Sputum_AFB_TB, f.GeneXpert_TB, f.Chest_Xray_TB, f.Culture_TB) != '', f.Date_TB_Investig, '') Date_TB_Investig
FROM All_IPT a
LEFT JOIN Eligible_For_IPT b ON a.person_id=b.person_id AND a.obs_datetime=b.obs_datetime
LEFT JOIN Date_IPT_start c ON a.person_id=c.person_id AND a.obs_datetime=c.obs_datetime
LEFT JOIN Outcome_of_IPT d ON a.person_id=d.person_id AND a.obs_datetime=d.obs_datetime
LEFT JOIN Date_of_Outcome e ON a.person_id=e.person_id AND a.obs_datetime=e.obs_datetime
LEFT JOIN `concept_name` c2 ON b.Eligible_For_IPT=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1
LEFT JOIN `concept_name` c3 ON d.Outcome_of_IPT=c3.`concept_id` AND c3.locale = 'en' AND c3.locale_preferred = 1
LEFT JOIN Last_All_TB_Investig f ON a.person_id=f.person_id
LEFT JOIN `patient_identifier` p1 ON a.`person_id` = p1.`patient_id` AND p1.`identifier_type` = 4 AND p1.`preferred` = 1
GROUP BY a.person_id, a.obs_datetime  ORDER BY a.obs_datetime DESC;

DROP TABLE IF EXISTS CIHP_EAC_Data;CREATE TEMPORARY TABLE CIHP_EAC_Data AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
o.`obs_datetime`, e.`encounter_datetime`, o.`concept_id`,o.`encounter_id`, o.`value_coded`,
IF(o.`concept_id`=166097, get_concept_name(o.`value_coded`), NULL) EAC_Session_Type, a.EAC_ARV_Plan FROM `obs` o
LEFT JOIN `encounter` e ON o.`person_id`=e.`patient_id` AND o.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT DISTINCT `person_id`, `obs_datetime`, `encounter_id`, IF(`concept_id`=165771, get_concept_name(`value_coded`), NULL) EAC_ARV_Plan FROM obs WHERE `concept_id`=165771) AS a 
ON a.`person_id`=o.`person_id` AND a.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id`=166097 AND e.`encounter_type`=32 AND e.`encounter_datetime`<= @Reporting_Date ORDER BY o.person_id, o.`obs_datetime` DESC;
DROP TABLE IF EXISTS CIHP_EAC_Data2;CREATE TEMPORARY TABLE CIHP_EAC_Data2 AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
o.`obs_datetime`, e.`encounter_datetime`, o.`concept_id`,o.`encounter_id`, o.`value_coded`,
IF(o.`concept_id`=166097, get_concept_name(o.`value_coded`), NULL) EAC_Session_Type, a.EAC_ARV_Plan FROM `obs` o
LEFT JOIN `encounter` e ON o.`person_id`=e.`patient_id` AND o.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT DISTINCT `person_id`, `obs_datetime`, `encounter_id`, IF(`concept_id`=165771, get_concept_name(`value_coded`), NULL) EAC_ARV_Plan FROM obs WHERE `concept_id`=165771) AS a 
ON a.`person_id`=o.`person_id` AND a.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id`=166097 AND e.`encounter_type`=32 AND e.`encounter_datetime`<= @Reporting_Date ORDER BY o.person_id, o.`obs_datetime` ASC;
DROP TABLE IF EXISTS VL_Before_EAC;CREATE TEMPORARY TABLE VL_Before_EAC AS
SELECT a.person_id, MAX(a.DateOfCurrentVL)DateOfCurrentVL FROM CIHP_ViralLoad_Data a LEFT JOIN CIHP_EAC_Data2 b ON a.person_id=b.person_id
WHERE a.DateOfCurrentVL < b.encounter_datetime AND a.CurrentVL>50 AND b.Occurrence=1 GROUP BY a.person_id;
DROP TABLE IF EXISTS VL_After_EAC;CREATE TEMPORARY TABLE VL_After_EAC AS
SELECT a.person_id, MIN(a.DateOfCurrentVL)DateOfCurrentVL FROM CIHP_ViralLoad_Data a LEFT JOIN CIHP_EAC_Data b ON a.person_id=b.person_id
WHERE a.DateOfCurrentVL > b.encounter_datetime AND b.Occurrence=1 GROUP BY a.person_id;
DROP TABLE IF EXISTS CIHP_EAC_FullData1;CREATE TEMPORARY TABLE CIHP_EAC_FullData1 AS
SELECT a.person_id, a.`obs_datetime`, a.`encounter_datetime`, a.`value_coded`,
a.EAC_Session_Type, a.EAC_ARV_Plan, b.DateOfCurrentVL, c.DateOfCurrentVL Date_VL_Before_EAC, c.CurrentVL VL_Before_EAC FROM CIHP_EAC_Data a 
LEFT JOIN VL_Before_EAC b ON a.person_id=b.person_id
LEFT JOIN CIHP_ViralLoad_Data c ON b.person_id=c.person_id AND b.DateOfCurrentVL=c.DateOfCurrentVL
WHERE a.Occurrence=1;
DROP TABLE IF EXISTS CIHP_EAC_FullData;CREATE TEMPORARY TABLE CIHP_EAC_FullData AS
SELECT a.person_id, a.`obs_datetime`, a.`encounter_datetime` Last_EAC_Session_Date, a.`value_coded`,
a.EAC_Session_Type, a.EAC_ARV_Plan, a.DateOfCurrentVL, a.Date_VL_Before_EAC, a.VL_Before_EAC, c.DateOfCurrentVL Date_VL_After_EAC,
c.CurrentVL VL_After_EAC FROM CIHP_EAC_FullData1 a 
LEFT JOIN VL_After_EAC b ON a.person_id=b.person_id
LEFT JOIN CIHP_ViralLoad_Data c ON b.person_id=c.person_id AND b.DateOfCurrentVL=c.DateOfCurrentVL;
SELECT 'CIHP' IP, @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName, /*a.`patient_id`,*/CONCAT(a.Pepid, "-", @DATIMCode) Pepid_datim, a.`patient_id`,
a.Pepid, b.HospitalNo, IF((a.sex = 'F'), 'Female', 'Male') Sex, a.`encounter_datetime` Date_Enrolled,
TIMESTAMPDIFF(YEAR, a.DOB, c.ARTStartDate) AS AgeAtStartofART,
TIMESTAMPDIFF(MONTH, a.DOB, c.ARTStartDate) AS AgeAtStart_InMonth, TIMESTAMPDIFF(YEAR, a.DOB, @Reporting_Date) AS CurrentAge,
c.ARTStartDate, c.LastPickupDate, c.NextAppmt, c.DaysOfARVRefill, c.RegLineAtStart, c.ARTRegAtStart, 
c.CurrentRegLine, c.CurrentARTReg,/* c.ARV_Drug_Strength, c.OI_Drug_CTX, c.CTX_Strength, c.OI_Drug_INH, 
c.INH_Strength, c.DSD_Model, c.DDD_Fac_Disp,*/
c.PregStatus, c.CurrentVL, c.DateOfCurrentVL, c.ViralLoadIndication, c.Date_Result_Received, c.Last_VL_Sample_Date,
h.Initial_CD4_Date,h.initial_CD4, i.Last_CD4_Date,i.Last_CD4,
CASE 
WHEN (FLOOR((TO_DAYS(@Reporting_Date) - TO_DAYS(c.NextAppmt))) <= 28) AND (d.Date_of_Termination IS NULL OR d.Date_of_Termination='')
THEN 'Active'
WHEN d.Reason_for_Termination = 'Discontinued Care' AND d.Reason_for_Defaulting1 != 'Transferred out'
THEN 'Stopped'
WHEN d.Reason_for_Termination = 'Discontinued Care' AND (d.Reason_for_Defaulting1 IS NULL OR d.Reason_for_Defaulting1 ='')
THEN 'Stopped'
WHEN (d.Reason_for_Termination = 'Transferred out' OR d.Reason_for_Defaulting1 = 'Transferred out')
THEN 'Transferred Out'
WHEN ((a.`death_date` <= @Reporting_Date AND a.`dead` = 1) OR d.Reason_for_Termination = 'Death' OR d.Reason_for_Defaulting1 = 'Death')
THEN 'Dead'
ELSE 'In-Active'
END AS CurrentARTStatus_28Days,
#CASE WHEN (FLOOR((TO_DAYS(@Reporting_Date) - TO_DAYS(c.NextAppmt))) <= 90)
#THEN 'Active'
#ELSE 'In-Active'
#END AS CurrentARTStatus_90Days,
FLOOR((TO_DAYS(@Reporting_Date) - TO_DAYS(c.NextAppmt))) AS DaysInterval,
c.TI, a.DOB, a.Surname, a.FirstName,
a.Phone_No, CONCAT_WS(', ', a.`address2`,  a.`address1`, a.`city_village`, a.`state_province`)Address,
c.Pill_Balance, c.Next_Pickup_Date, @DATIMCode DATIMCode, TIMESTAMPDIFF(MONTH, c.ARTStartDate, @Reporting_Date) AS MonthOnART,
c.Weight Last_Weight, c.Visit_Date Last_Weight_Date, /*c.First_TLD_Date,*/ a.Biometrics AS Biometrics_Captured,
e.Eligible_For_IPT, e.Date_IPT_start, e.Outcome_of_IPT, e.Date_of_Outcome, j.Last_Clinic_Visit_Date, j.Systolic_BP, j.Diastolic_BP, j.Next_Clinical_Appt_Date,
g.Last_TB_Screening_Date, g.Last_TB_Screening_Status, e.TB_Investigations, e.Investig_Result, e.Date_TB_Investig,  d.`Reason for Tracking` AS `Reason_for_Tracking`, d.obs_datetime AS Tracking_Date,
  d.Reason_for_Defaulting1, IF(d.Reason_for_Termination IS NULL AND d.Date_of_Termination IS NULL AND d.Date_Returned IS NOT NULL, "Returned to Care",
d.Reason_for_Termination)Reason_for_Termination, IF(d.Reason_for_Termination IS NULL AND d.Date_of_Termination IS NULL 
AND d.Date_Returned IS NOT NULL, d.Date_Returned, d.Date_of_Termination)Date_of_Termination, d.Facility_Transferred_To, f.Last_EAC_Session_Date,
  f.EAC_Session_Type, f.EAC_ARV_Plan, f.Date_VL_Before_EAC, f.VL_Before_EAC, f.Date_VL_After_EAC, f.VL_After_EAC, 
  CONCAT(LEFT(UUID(), 4),RIGHT(YEAR(@Reporting_Date), 2),"-" , LEFT(UUID(), 5),LPAD(MONTH(@Reporting_Date), 2, '0'),"-", LEFT(UUID(), 3), LPAD(DAY(@Reporting_Date), 2, '0')) List_Parameters 
FROM `CIHP_Patient` a 
LEFT JOIN CIHP_Hop b ON a.`patient_id`=b.`patient_id`
LEFT JOIN CIHP_ART_List c ON a.`patient_id`=c.`patient_id`
LEFT JOIN Cihp_Client_Tracking d ON a.`patient_id`=d.`person_id`
LEFT JOIN Cihp_IPT_TB e ON a.pepid=e.pepid 
LEFT JOIN CIHP_EAC_FullData f ON a.patient_id=f.person_id 
/* New update for the most recent Sample Collect Date from Lab Order and Result Form*/
LEFT JOIN (SELECT a.person_id, a.Last_TB_Screening_Date,a.Last_TB_Screening_Status FROM
(SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id, 
o.`obs_datetime` Last_TB_Screening_Date,ConceptName(o.`value_coded`) Last_TB_Screening_Status
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` =1659  AND e.`encounter_type` = 12 AND e.`form_id` = 14  AND o.`voided` = 0 AND o.`obs_datetime` <= @Reporting_Date
ORDER BY o.person_id, o.`obs_datetime` DESC)a WHERE a.Occurrence=1) g ON a.patient_id=g.person_id 
LEFT JOIN (SELECT a.person_id, a.Initial_CD4_Date,a.initial_CD4 FROM
(SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id, 
o.`obs_datetime` Initial_CD4_Date,o.`value_numeric` initial_CD4
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` =5497  AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 AND o.`obs_datetime` <= @Reporting_Date
ORDER BY o.person_id, o.`obs_datetime` ASC)a WHERE a.Occurrence=1) h ON a.patient_id=h.person_id
LEFT JOIN (SELECT a.person_id, a.Last_CD4_Date,a.Last_CD4 FROM
(SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id, 
o.`obs_datetime` Last_CD4_Date,o.`value_numeric` Last_CD4
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` =5497  AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 AND o.`obs_datetime` <= @Reporting_Date
ORDER BY o.person_id, o.`obs_datetime` DESC)a WHERE a.Occurrence=1) i ON a.patient_id=i.person_id
LEFT JOIN (SELECT a.`patient_id`, a.`encounter_datetime` Last_Clinic_Visit_Date, b.Systolic_BP, c.Diastolic_BP, d.Next_Clinical_Appt_Date, a.encounter_id FROM 
(SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, e.`encounter_datetime`, e.`encounter_id`
FROM `encounter` e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE e.`encounter_type` = 12 AND e.`form_id` = 14 AND e.`voided` = 0 AND e.`encounter_datetime` <= @Reporting_Date 
ORDER BY e.patient_id, e.`encounter_datetime` DESC) a 
LEFT JOIN (SELECT person_id, `value_numeric` Systolic_BP, encounter_id FROM obs WHERE `concept_id`=5085 AND `voided` = 0) b ON a.patient_id=b.person_id AND a.encounter_id=b.encounter_id
LEFT JOIN (SELECT person_id, `value_numeric` Diastolic_BP, encounter_id FROM obs WHERE `concept_id`=5086 AND `voided` = 0) c ON a.patient_id=c.person_id AND a.encounter_id=c.encounter_id
LEFT JOIN (SELECT person_id, `value_datetime` Next_Clinical_Appt_Date, encounter_id FROM obs WHERE `concept_id`=5096 AND `voided` = 0) d ON a.patient_id=c.person_id AND a.encounter_id=d.encounter_id
WHERE a.Occ=1) j ON a.patient_id=j.patient_id
/*Update End 30th August 2021*/
GROUP BY a.Pepid ORDER BY a.Pepid;
	END$$

DELIMITER ;