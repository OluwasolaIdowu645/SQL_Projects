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




SELECT a.`patient_id`, 
b.`identifier` "PATIENT ART NUMBER", 
g.`identifier` "PATIENT HOSPITAL NUMBER", 
g.`identifier` "PATIENT ANC NUMBER",
f.`given_name` "FIRST NAME OF PATIENT",
"" AS "MIDDLE NAME OF PATIENT",
f.`family_name` "LAST NAME OF PATIENT",
@FacilityName "FACILITY NAME",
@State "STATE",
@LGA "FACILITY LGA",
"CIHP" AS "IP NAME",
c.`birthdate` "DATE OF BIRTH (YYYY/MM/DD)", 
c.`gender` "GENDER", 
d.`value` "PHONE NUMBER 1", 
"" AS "PHONE NUMBER 2",
"" AS "PHONE NUMBER 3",
CONCAT(e.`address2`, ", ", e.`address1`, ", ", e.`city_village`, ", ", e.`state_province`) "HOME ADDRESS"

FROM `patient` a 
LEFT JOIN `patient_identifier` b ON a.`patient_id` = b.`patient_id` AND  b.`voided`=0 AND b.`identifier_type`=4
LEFT JOIN `person` c ON a.`patient_id`=c.`person_id`
LEFT JOIN `person_attribute` d ON a.`patient_id`=d.`person_id` AND d.`voided`=0
LEFT JOIN `person_address` e ON a.`patient_id`=e.`person_id` AND e.`voided`=0
LEFT JOIN `person_name` f ON a.`patient_id`=f.`person_id`
LEFT JOIN `patient_identifier` g ON a.`patient_id` = g.`patient_id` AND  g.`voided`=0 AND g.`identifier_type`=5
LEFT JOIN `patient_identifier` h ON a.`patient_id` = h.`patient_id` AND  h.`voided`=0 AND h.`identifier_type`=6
AND a.`voided`=0 AND b.`identifier_type` = 4;

