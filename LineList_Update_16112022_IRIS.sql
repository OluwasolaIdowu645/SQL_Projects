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
(1, 'Gombe', 'Akko', 'Akko', 'rzkxVHjL1p5'),
(2, 'Gombe', 'Akko', 'Akko', 'nzQr4fbA7Ir'),
(3, 'Gombe', 'Billiri', 'Billiri', 'jV7IcQgCsXD'),
(4, 'Gombe', 'Gombe', 'Gombe', 'mO8FSgHsz3O'),
(5, 'Gombe', 'Kwami', 'Kwami', 'I3r9UA4xbfo'),
(6, 'Gombe', 'Shongom', 'Shongom', 'ajaROCGp7D4'),
(7, 'Kaduna', 'Kaduna North', 'Kaduna North', 'RT0mIfaaDxi'),
(8, 'Kaduna', 'Igabi', 'Igabi', 'lWqv0RHnPh9'),
(9, 'Kaduna', 'Ikara', 'Ikara', 'WwqQZjVN29z'),
(10, 'Kaduna', 'Kaduna South', 'Kaduna South', 'HF37VJr8eoZ'),
(11, 'Kaduna', 'Kaduna South', 'Kaduna South', 'Px8Q10LldkO'),
(12, 'Kaduna', 'Zangon Kataf', 'Zangon Kataf', 'KPafVFs3f9a'),
(13, 'Kaduna', 'Zaria', 'Zaria', 'xCzRV3Bjzfc'),
(14, 'Lagos', 'Epe', 'Epe', 'hqT0jwt1zsL'),
(15, 'Lagos', 'Epe', 'Epe', 'smKEPkP7G0O'),
(16, 'Lagos', 'Epe', 'Epe', 'wblyUihZxEk'),
(17, 'Lagos', 'Oshodi_Isolo', 'Oshodi_Isolo', 'CHqAwjTU2Jc'),
(18, 'Lagos', 'Oshodi_Isolo', 'Oshodi_Isolo', 'gFlvov8GYAp'),
(19, 'Lagos', 'Oshodi_Isolo', 'Oshodi_Isolo', 'BODWX46tM9Y;'),
(20, 'Gombe', 'Akko', 'Akko', 'bW4cbw8Kloh'),
(21, 'Gombe', 'Balanga', 'Balanga', 'yAtYirMpXuz'),
(22, 'Gombe', 'Balanga', 'Balanga', 'LzmgjtL87kh'),
(23, 'Gombe', 'Billiri', 'Billiri', 'ItQqTK4vrzT'),
(24, 'Gombe', 'Dukku', 'Dukku', 'X8smKtvqUob'),
(25, 'Gombe', 'Funakaye', 'Funakaye', 'XNy0j3RUrI6'),
(26, 'Gombe', 'Funakaye', 'Funakaye', 't0ulFJivm9P'),
(27, 'Gombe', 'Gombe', 'Gombe', 'kQSAihTQQep'),
(28, 'Gombe', 'Gombe', 'Gombe', 'hX8Nrf3AEz7'),
(29, 'Gombe', 'Gombe', 'Gombe', 'Lx9SQTEgXS3'),
(30, 'Gombe', 'Gombe', 'Gombe', 'jRNyO3ImWmI'),
(31, 'Gombe', 'Gombe', 'Gombe', 'UeAxwJmzoPH'),
(32, 'Gombe', 'Kaltungo', 'Kaltungo', 'KLEiRw5efPW'),
(33, 'Gombe', 'Kaltungo', 'Kaltungo', 'CnFTZ4Yu5A8'),
(34, 'Gombe', 'Nafada', 'Nafada', 'gO6hDzeSBgl'),
(35, 'Gombe', 'Shongom', 'Shongom', 'vaP8U6qfGIa'),
(36, 'Gombe', 'Yamaltu/Deba', 'Yamaltu/Deba', 'HwC7f1qYg2o'),
(37, 'Gombe', 'Yamaltu/Deba', 'Yamaltu/Deba', 'P9815pFCx4Y'),
(38, 'Kaduna', 'Birnin Gwari', 'Birnin Gwari', 'm4mw3TJxbJy'),
(39, 'Kaduna', 'Chikun', 'Chikun', 'J4Ec3FWnH6Q'),
(40, 'Kaduna', 'Chikun', 'Chikun', 'yXnTcKW3nuk'),
(41, 'Kaduna', 'Chikun', 'Chikun', 'i6Rcojd7d9S'),
(42, 'Kaduna', 'Chikun', 'Chikun', 'Os1iE6RNSnx'),
(43, 'Kaduna', 'Giwa', 'Giwa', 'fiC3mpkjajt'),
(44, 'Kaduna', 'Giwa', 'Giwa', 'ebLQTZgsfgz'),
(45, 'Kaduna', 'Igabi', 'Igabi', 'P2CO8dS7XTK'),
(46, 'Kaduna', 'Igabi', 'Igabi', 'yjpPIoeNQLj'),
(47, 'Kaduna', 'Jaba', 'Jaba', 'b54iXGWcmCB'),
(48, 'Kaduna', 'Jema\a', 'Jema\a', 'yR3KYnURaLT'),
(49, 'Kaduna', 'Jema\a', 'Jema\a', 'GPe3nnQbHA6'),
(50, 'Kaduna', 'Kachia', 'Kachia', 'WdArBhoOacf'),
(51, 'Kaduna', 'Kachia', 'Kachia', 'vuo72rgedTZ'),
(52, 'Kaduna', 'Kachia', 'Kachia', 'bSDq2EfthjS'),
(53, 'Kaduna', 'Kaduna North', 'Kaduna North', 'aQTk0pRk6eY'),
(54, 'Kaduna', 'Kaduna North', 'Kaduna North', 'ZD8SEdhkeTQ'),
(55, 'Kaduna', 'Kaduna North', 'Kaduna North', 'HWkSjwMUDvc'),
(56, 'Kaduna', 'Kaduna North', 'Kaduna North', 'dwAvWQFlxx2'),
(57, 'Kaduna', 'Kaduna North', 'Kaduna North', 'rWfabrVIqeg'),
(58, 'Kaduna', 'Kaduna North', 'Kaduna North', 'JDudfxSTSrO'),
(59, 'Kaduna', 'Kaduna North', 'Kaduna North', 'QwrkbFl3Uvj'),
(60, 'Kaduna', 'Kaduna South', 'Kaduna South', 'gZeeGIFJ9KY'),
(61, 'Kaduna', 'Kaduna South', 'Kaduna South', 'mX4PekSaaS2'),
(62, 'Kaduna', 'Kaduna South', 'Kaduna South', 'T0cw021kccu'),
(63, 'Kaduna', 'Kaduna South', 'Kaduna South', 'IzbxBJjD6IG'),
(64, 'Kaduna', 'Kaduna South', 'Kaduna South', 'xoXTB4clfGL'),
(65, 'Kaduna', 'Kaduna South', 'Kaduna South', 'uq98eMvdS5R'),
(66, 'Kaduna', 'Kaduna South', 'Kaduna South', 'pt20jaMEKHx'),
(67, 'Kaduna', 'Kaduna South', 'Kaduna South', 'yfPEukzMBhy'),
(68, 'Kaduna', 'Kagarko', 'Kagarko', 'A5a1HEarbxU'),
(69, 'Kaduna', 'Kajuru', 'Kajuru', 'mMBatyNbrv0'),
(70, 'Kaduna', 'Kaura', 'Kaura', 'NOFJMZXfbFx'),
(71, 'Kaduna', 'Kaura', 'Kaura', 'VYk8FuLG2G1'),
(72, 'Kaduna', 'Kaura', 'Kaura', 'aGArDGnLt5O'),
(73, 'Kaduna', 'Kauru', 'Kauru', 'GRhndXkuvmD'),
(74, 'Kaduna', 'Kubau', 'Kubau', 'PoIQpdF8RTG'),
(75, 'Kaduna', 'Kudan', 'Kudan', 'XRzMMtgxpMU'),
(76, 'Kaduna', 'Lere', 'Lere', 'XCixcBgl6uz'),
(77, 'Kaduna', 'Makarfi', 'Makarfi', 'QuiAPHqPxwY'),
(78, 'Kaduna', 'Sabon Gari', 'Sabon Gari', 'nDa1uUKmVhb'),
(79, 'Kaduna', 'Sanga', 'Sanga', 'CXY35SPtbPf'),
(80, 'Kaduna', 'Soba', 'Soba', 'fEZq6XgTLT2'),
(81, 'Kaduna', 'Zangon Kataf', 'Zangon Kataf', 'uYxACgpJgI9'),
(82, 'Kaduna', 'Zangon Kataf', 'Zangon Kataf', 'jHjDEUVD87x'),
(83, 'Kaduna', 'Zaria', 'Zaria', 'V0IswqM1byH'),
(84, 'Kaduna', 'Zaria', 'Zaria', 'lLdc7dRUqzs'),
(85, 'Kaduna', 'Zaria', 'Zaria', 'LOJ8j4vLoJZ'),
(86, 'Lagos', 'Alimosho_Amuwo', 'Alimosho', 'Mq45WIHMbhI'),
(87, 'Lagos', 'Alimosho_Amuwo', 'Alimosho', 'jMnxdoXrX0B'),
(88, 'Lagos', 'Alimosho_Amuwo', 'Alimosho', 'LNguEy0vjvR'),
(89, 'Lagos', 'Alimosho_Amuwo', 'Alimosho', 'RD3JhCrIpQg'),
(90, 'Lagos', 'Ifako_Alimosho', 'Alimosho', 'D8fXWtqwMAU'),
(91, 'Lagos', 'Alimosho_Amuwo', 'Alimosho', 'R3X9MttmeAb'),
(92, 'Lagos', 'Ifako_Alimosho', 'Alimosho', 'iJX8pwklfN3'),
(93, 'Lagos', 'Alimosho_Amuwo', 'Alimosho', 'tscvxzvaPHe'),
(94, 'Lagos', 'Ifako_Alimosho', 'Alimosho', 'owB333UT2qz'),
(95, 'Lagos', 'Alimosho_Amuwo', 'Alimosho', 'dsYsl8bXYX0'),
(96, 'Lagos', 'Alimosho_Amuwo', 'Amuwo Odofin', 'V9F0fejCYiz'),
(97, 'Lagos', 'Alimosho_Amuwo', 'Amuwo Odofin', 'Ho8HeGPzmwk'),
(98, 'Lagos', 'Alimosho_Amuwo', 'Amuwo Odofin', 'brE1SYIkAqX'),
(99, 'Lagos', 'Alimosho_Amuwo', 'Amuwo Odofin', 'wsaK58gH5tH'),
(100, 'Lagos', 'Ibeju-lekki_Eti-Osa', 'Eti Osa', 'AfLGN7kmKaK'),
(101, 'Lagos', 'Ibeju-lekki_Eti-Osa', 'Eti Osa', 'NCrwoKufAu9'),
(102, 'Lagos', 'Ibeju-lekki_Eti-Osa', 'Eti Osa', 'BPvnX1MlAAl'),
(103, 'Lagos', 'Ibeju-lekki_Eti-Osa', 'Eti Osa', 'K4fl4VyS1Qp'),
(104, 'Lagos', 'Ibeju-lekki_Eti-Osa', 'Eti Osa', 'W8ZrdhS5bgo'),
(105, 'Lagos', 'Ibeju-lekki_Eti-Osa', 'Eti Osa', 'UEetB08FZNc'),
(106, 'Lagos', 'Ibeju-lekki_Eti-Osa', 'Eti Osa', 'lwmRYQg2xSI'),
(107, 'Lagos', 'Ibeju-lekki_Eti-Osa', 'ibeju-lekki', 'KmKzDT9YmmR'),
(108, 'Lagos', 'Ifako_Alimosho', 'ifako-ijaiye', 'WNZk7unzn4x'),
(109, 'Lagos', 'Ifako_Alimosho', 'ifako-ijaiye', 'CtKYcZmtnBQ'),
(110, 'Lagos', 'Ifako_Alimosho', 'ifako-ijaiye', 'OWOckBlm9Du'),
(111, 'Lagos', 'Ifako_Alimosho', 'ifako-ijaiye', 'W7hscr3wKtm'),
(112, 'Lagos', 'Ifako_Alimosho', 'ifako-ijaiye', 'VIgbUF6H4ma'),
(113, 'Lagos', 'Mushin_Ikeja', 'Ikeja', 'y5TzOvctmba'),
(114, 'Lagos', 'Mushin_Ikeja', 'Ikeja', 'zkYOojlUFww'),
(115, 'Lagos', 'Mushin_Ikeja', 'Ikeja', 'ptxAOdQ5Tp8'),
(116, 'Lagos', 'Mushin_Ikeja', 'Mushin', 'PdTC8ihrFRQ'),
(117, 'Lagos', 'Mushin_Ikeja', 'Mushin', 'a9EDyKYjIlc'),
(118, 'Lagos', 'Mushin_Ikeja', 'Mushin', 'WlXQVJSBvrn'),
(119, 'Lagos', 'Mushin_Ikeja', 'Mushin', 'bjExvCDZVsB'),
(120, 'Lagos', 'Mushin_Ikeja', 'Mushin', 'qEW4Bhjh7Lv'),
(121, 'Lagos', 'Mushin_Ikeja', 'Mushin', 'LZC72BhBZBd'),
(122, 'Kogi', 'Okene', 'Adavi', 'MruZ0YOqYQV'),
(123, 'Kogi', 'Okene', 'Adavi', 'x8VGMgpn35c'),
(124, 'Kogi', 'Lokoja', 'Ajaokuta', 'CzwWiALrME8'),
(125, 'Kogi', 'Ankpa', 'Ankpa', 'mJgQrfBTx3f'),
(126, 'Kogi', 'Ankpa', 'Ankpa', 'elrdVlVn0kp'),
(127, 'Kogi', 'Ankpa', 'Ankpa', 'Et6wjYLz9Sj'),
(128, 'Kogi', 'Anyigba ', 'Bassa', 'LVbNrbnD8x5'),
(129, 'Kogi', 'Anyigba ', 'Dekina', 'p8ukk5eOdZA'),
(130, 'Kogi', 'Anyigba ', 'Dekina', 'KkDXS9Qv3oE'),
(131, 'Kogi', 'Anyigba ', 'Dekina', 'nlLwNEPKFnR'),
(132, 'Kogi', 'Anyigba ', 'Dekina', 'jUzZE9zzYYf'),
(133, 'Kogi', 'Anyigba ', 'Dekina', 'Qiq81djsOyv'),
(134, 'Kogi', 'Anyigba ', 'Dekina', 'ki7kLIEcJ0r'),
(135, 'Kogi', 'Anyigba ', 'Dekina', 'riZZbajMMKD'),
(136, 'Kogi', 'Anyigba ', 'Idah', 'PawBgipJAZe'),
(137, 'Kogi', 'Okene', 'Ijumu', 'XKAVCLKlMPZ'),
(138, 'Kogi', 'Okene', 'Kabba/Bunu', 'CGwIyxDpwT8'),
(139, 'Kogi', 'Okene', 'Kabba/Bunu', 'EOO49s5EOt4'),
(140, 'Kogi', 'Lokoja', 'Kogi', 'KzgNOUrEB8m'),
(141, 'Kogi', 'Lokoja', 'Lokoja', 'AQ4CeR3h187'),
(142, 'Kogi', 'Lokoja', 'Lokoja', 'gkOIcMHnyHM'),
(143, 'Kogi', 'Lokoja', 'Lokoja', 'KsNbhiCMPvu'),
(144, 'Kogi', 'Anyigba ', 'Ofu', 'aMZiWfMiJd9'),
(145, 'Kogi', 'Anyigba ', 'Ofu', 'mf9bRBuufwN'),
(146, 'Kogi', 'Okene', 'Ogori Magogo', 'H7M8CLeCiXD'),
(147, 'Kogi', 'Okene', 'Okehi', 'YxjPfHv2bdg'),
(148, 'Kogi', 'Okene', 'Okene', 'sKytXCdZsh5'),
(149, 'Kogi', 'Okene', 'Okene', 'CLVU561R6tp'),
(150, 'Kogi', 'Amkpa', 'Olamaboro', 'h9drujCcifQ'),
(151, 'Kogi', 'Anyigba ', 'Omala', 'PRHYgNR5CUO'),
(152, 'Kogi', 'Okene', 'Yagba West', 'yCGhXibQavi');

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
SELECT o.`person_id`, o.`concept_id`, o.`obs_datetime`, o.`value_coded`,c2.`name` RegLineAtStart  FROM `obs` o 
LEFT JOIN `concept_name` c2 ON o.`value_coded`=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
WHERE e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`concept_id` = 165708 AND o.`voided` = 0
GROUP BY o.`person_id`, o.`obs_datetime`;
/*First ARV_Medication*/
DROP TABLE IF EXISTS CIHP_1st_ARV_Medication;
CREATE TEMPORARY TABLE CIHP_1st_ARV_Medication AS
SELECT o.`person_id`, o.`concept_id`, o.`obs_datetime`, o.`value_coded`, c2.`name` ARTRegAtStart  FROM `obs` o 
LEFT JOIN `concept_name` c2 ON o.`value_coded`=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1
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
DROP TABLE IF EXISTS CIHP_PharmOcc;
CREATE TEMPORARY TABLE CIHP_PharmOcc AS
SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, e.`encounter_datetime`, e.`encounter_id`
FROM `encounter` e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND e.`voided` = 0 AND e.`encounter_datetime` <= @Reporting_Date 
ORDER BY e.patient_id, e.`encounter_datetime` DESC;
SET SESSION sql_mode = '';
DROP TABLE IF EXISTS CIHP_Med_duratn;
CREATE TEMPORARY TABLE CIHP_Med_duratn AS
SELECT o.`person_id`, e.`encounter_id`, e.`encounter_datetime` LastPickupDate, o.`obs_group_id`, o.`value_numeric` DaysOfARVRefill, f.Pill_Balance, b.Next_Pickup_Date,
a.`obs_id` FROM `obs` o 
LEFT JOIN `CIHP_PharmOcc` e ON o.`encounter_id`=e.`encounter_id` AND  o.`encounter_id` = e.`encounter_id`
LEFT JOIN (SELECT o2.`obs_id` FROM `obs` o2 WHERE o2.concept_id = 162240 AND o2.`voided` = 0) a ON a.obs_id = o.obs_group_id
LEFT JOIN (SELECT person_id, CAST(`value_text` AS UNSIGNED) Pill_Balance, encounter_id FROM obs WHERE concept_id = 166406) f ON f.encounter_id=e.encounter_id
LEFT JOIN (SELECT person_id, `value_datetime` Next_Pickup_Date, encounter_id FROM obs WHERE concept_id = 5096) b ON b.encounter_id=e.encounter_id
WHERE  e.Occ = 1 AND o.`concept_id` = 159368 AND o.`voided` = 0;
DROP TABLE IF EXISTS CIHP_Med_duration;
CREATE TEMPORARY TABLE CIHP_Med_duration AS
SELECT * FROM CIHP_Med_duratn WHERE obs_id IS NOT NULL GROUP BY person_id, encounter_id, LastPickupDate;
/*Last ARV_Medication*/
SET SESSION sql_mode = '';
DROP TABLE IF EXISTS CIHP_ARV_Medication;
CREATE TEMPORARY TABLE CIHP_ARV_Medication AS
SELECT o.`obs_id`, o.`person_id`, o.`concept_id`, e.`encounter_datetime`, o.`value_coded`, 
GROUP_CONCAT(DISTINCT o.`value_coded` SEPARATOR ', ') nmrs_inconsistency2,c2.`name` CurrentARTReg, 
GROUP_CONCAT(DISTINCT c2.`name` SEPARATOR ', ') nmrs_inconsistency FROM `obs` o 
LEFT JOIN `concept_name` c2 ON o.`value_coded`=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1
LEFT JOIN `CIHP_PharmOcc` e ON o.`encounter_id`=e.`encounter_id`
WHERE e.Occ = 1 AND o.`concept_id` IN (164506, 164507, 164513, 164514, 165702, 165703) AND o.`voided` = 0 
GROUP BY o.`person_id`, o.`obs_datetime`;
/*Last CurrentRegimenLine*/
DROP TABLE IF EXISTS CIHP_CurrentRegimenLine;
CREATE TEMPORARY TABLE CIHP_CurrentRegimenLine AS
SELECT o.`person_id`, o.`concept_id`, o.`obs_datetime`, o.`value_coded`, GROUP_CONCAT(DISTINCT c2.`name` SEPARATOR ', ') CurrentRegLine  FROM `obs` o 
LEFT JOIN `concept_name` c2 ON o.`value_coded`=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND o.`concept_id` = 165708 AND o.`voided` = 0 
AND o.`obs_datetime` = (SELECT MAX(o2.obs_datetime) FROM obs o2 WHERE o.person_id=o2.person_id AND o2.concept_id = 165708 
AND o2.`obs_datetime` <= @Reporting_Date) GROUP BY o.`person_id`, o.`obs_datetime`;
SET SESSION sql_mode = '';
/*CIHP_PregStatus*/
DROP TABLE IF EXISTS CIHP_PregStatus_Occur;
CREATE TEMPORARY TABLE CIHP_PregStatus_Occur AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id, p2.`identifier` Pepid,
p.`gender`, o.`concept_id`, o.`obs_datetime`, o.`value_coded`, c2.`name` PregStatus  FROM `obs` o 
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1
LEFT JOIN `concept_name` c2 ON o.`value_coded`=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `person` p ON p.`person_id`=o.`person_id` AND p.`voided`=0,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE e.`encounter_type` = 12 AND e.`form_id` = 14 AND o.`concept_id` = 165050 AND o.`voided` = 0 
ORDER BY o.person_id, o.`obs_datetime` DESC;
DROP TABLE IF EXISTS CIHP_PregStatus;
CREATE TEMPORARY TABLE CIHP_PregStatus AS
SELECT * FROM CIHP_PregStatus_Occur WHERE Occurrence = 1 AND gender = 'F';
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
SELECT o.`person_id`, a.pepid, o.`concept_id`, o.`obs_datetime`, o.`value_coded`, GROUP_CONCAT(DISTINCT c2.`name` SEPARATOR ', ') ViralLoadIndication  FROM `obs` o 
LEFT JOIN `concept_name` c2 ON o.`value_coded`=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN VL_Search a ON o.`person_id`=a.`person_id` AND o.`obs_datetime`=a.DateOfCurrentVL
WHERE e.`encounter_type` = 11 AND e.`form_id` = 21 AND o.`concept_id` = 164980 AND o.`voided` = 0 AND  o.`person_id`= a.`person_id`
GROUP BY o.`person_id`, o.`obs_datetime`;
/*CIHP_Transfer_In*/
DROP TABLE IF EXISTS CIHP_Transfer_In;
CREATE TEMPORARY TABLE CIHP_Transfer_In AS
SELECT o.`person_id`, o.`concept_id`, o.`obs_datetime`, o.`value_coded`, GROUP_CONCAT(DISTINCT c2.`name` SEPARATOR ', ') TI  FROM `obs` o 
LEFT JOIN `concept_name` c2 ON o.`value_coded`=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
WHERE e.`encounter_type` = 14 AND e.`form_id` = 23 AND o.`concept_id` = 160540 AND o.`voided` = 0  AND o.`obs_datetime` <= @Reporting_Date AND c2.`concept_id`=160563
AND o.`obs_datetime` = (SELECT MAX(o2.obs_datetime) FROM obs o2 WHERE o.person_id=o2.person_id AND o2.concept_id = 160540) GROUP BY o.`person_id`, o.`obs_datetime`;
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
DROP TABLE IF EXISTS All_ARVs;
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
  WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND o.`concept_id` = 165724 GROUP BY o.`person_id`, o.`obs_datetime`;
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
DROP TABLE IF EXISTS CIHP_ART_List;
CREATE TABLE CIHP_ART_List AS
SELECT a.`person_id`, f.ARTStartDate, a.LastPickupDate, a.DaysOfARVRefill, e.RegLineAtStart, b.ARTRegAtStart, 
d.CurrentRegLine, c.CurrentARTReg, g.PregStatus, h.CurrentVL, h.DateOfCurrentVL, h.Date_Result_Received, i.ViralLoadIndication, m.Last_VL_Sample_Date, j.TI, 
(a.LastPickupDate + INTERVAL (a.DaysOfARVRefill) DAY) AS NextAppmt, k.Weight, k.Visit_Date, a.Pill_Balance, a.Next_Pickup_Date#,l.First_TLD_Date
FROM CIHP_Med_duration a 
LEFT JOIN  CIHP_1st_ARV_Medication b ON a.person_id=b.person_id
LEFT JOIN CIHP_ARV_Medication c ON a.person_id=c.person_id
LEFT JOIN CIHP_CurrentRegimenLine d ON a.person_id=d.person_id
LEFT JOIN CIHP_1st_RegimenLine e ON a.person_id=e.person_id
LEFT JOIN CIHP_ARTStartDate f ON a.person_id=f.person_id
LEFT JOIN CIHP_PregStatus g ON a.person_id=g.person_id
LEFT JOIN VL_Search h ON a.person_id=h.person_id
LEFT JOIN CIHP_VL_Indication i ON a.person_id=i.person_id
LEFT JOIN CIHP_Transfer_In j ON a.person_id=j.person_id
LEFT JOIN Last_Weight k ON a.person_id=k.person_id
#LEFT JOIN First_TLD l ON a.person_id=l.person_id
LEFT JOIN CIHP_VL_SampleCol m ON a.person_id=m.person_id;
SET SESSION sql_mode = '';
DROP TABLE IF EXISTS Reason_FOR_Tracking;
CREATE TEMPORARY TABLE Reason_FOR_Tracking AS
SELECT `person_id`, `value_coded` AS 'Reason FOR Tracking', `obs_datetime` FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165460 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS Partner_full_name;
CREATE TEMPORARY TABLE Partner_full_name AS
SELECT `person_id`, `value_text` AS 'Partner_full_name', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 161135 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS Address_of_Tx_supporter;
CREATE TEMPORARY TABLE Address_of_Tx_supporter AS
SELECT `person_id`, `value_text` AS 'Address_of_Tx_supporter', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 160641 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS Contact_phone_No;
CREATE TEMPORARY TABLE Contact_phone_No AS
SELECT `person_id`, `value_text` AS 'Contact_phone_No', `obs_datetime` FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 159635 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS Date_of_Last_Actual;
CREATE TEMPORARY TABLE Date_of_Last_Actual AS
SELECT `person_id`, `value_datetime` AS 'Date_of_Last_Actual', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165461 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS Date_Missed_Scheduled_App;
CREATE TEMPORARY TABLE Date_Missed_Scheduled_App AS
SELECT `person_id`, `value_datetime` AS 'Date_Missed_Scheduled_App', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165778 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
/* Attempt to Contact Section */
DROP TABLE IF EXISTS ContAttempt_Date1;
CREATE TEMPORARY TABLE ContAttempt_Date1 AS
SELECT `person_id`, `value_datetime` AS 'ContAttempt_Date1', MAX(`obs_datetime`) AS obs_datetime FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165463 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime;
DROP TABLE IF EXISTS who_attempted_contact1;
CREATE TEMPORARY TABLE who_attempted_contact1 AS
SELECT `person_id`, `value_text` AS 'who_attempted_contact1', MAX(`obs_datetime`) AS obs_datetime FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165464 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime;  
DROP TABLE IF EXISTS Mode_of_Communication1;
CREATE TEMPORARY TABLE Mode_of_Communication1 AS
SELECT `person_id`, `value_coded` AS 'Mode_of_Communication1', MAX(`obs_datetime`) AS obs_datetime FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165465 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime; 
DROP TABLE IF EXISTS Person_Contacted1;
CREATE TEMPORARY TABLE Person_Contacted1 AS
SELECT `person_id`, `value_coded` AS 'Person_Contacted1', MAX(`obs_datetime`) AS obs_datetime FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165466 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime; 
DROP TABLE IF EXISTS Reason_for_Defaulting1;
CREATE TEMPORARY TABLE Reason_for_Defaulting1 AS
SELECT `person_id`, `value_coded` AS 'Reason_for_Defaulting1', MAX(`obs_datetime`) AS obs_datetime FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165467 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime; 
/* Termination Section */
DROP TABLE IF EXISTS Reason_for_Termination;
CREATE TEMPORARY TABLE Reason_for_Termination AS 
SELECT `person_id`, `value_coded` AS 'Reason_for_Termination', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165470 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS Date_of_Termination;
CREATE TEMPORARY TABLE Date_of_Termination AS 
SELECT `person_id`, `value_datetime` AS 'Date_of_Termination', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165469 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS Patiet_Terminated;
CREATE TEMPORARY TABLE Patiet_Terminated AS 
SELECT `person_id`, `value_coded` AS 'Previous_ARV_exposure', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165586 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS Referred_for;
CREATE TEMPORARY TABLE Referred_for AS 
SELECT `person_id`, `value_coded` AS 'Referred_for', `obs_datetime` FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165776 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS Date_Returned;
CREATE TEMPORARY TABLE Date_Returned AS 
SELECT `person_id`, `value_datetime` AS 'Date_Returned', `obs_datetime` FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165775 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS Date_LTFU;
CREATE TEMPORARY TABLE Date_LTFU AS 
SELECT `person_id`, `value_datetime` AS 'Date_LTFU', `obs_datetime` FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166152 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS Reason_LTFU;
CREATE TEMPORARY TABLE Reason_LTFU AS
SELECT `person_id`, `value_coded` AS 'Reason_LTFU', `obs_datetime` FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166157 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS LTFU;
CREATE TEMPORARY TABLE LTFU AS
SELECT `person_id`, `value_coded` AS 'LTFU', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 5240 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
/* End Section*/
DROP TABLE IF EXISTS Name_oF_Tracker;
CREATE TEMPORARY TABLE Name_oF_Tracker AS
SELECT `person_id`, `value_text` AS 'Name_oF_Tracker', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165459 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS Tracker_Sig_Date;
CREATE TEMPORARY TABLE Tracker_Sig_Date AS
SELECT `person_id`, `value_datetime` AS 'Tracker_Sig_Date', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165777 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0;
DROP TABLE IF EXISTS All_Tracking;
CREATE TEMPORARY TABLE All_Tracking AS
SELECT o.`person_id`, o.`obs_datetime`, o.encounter_id FROM obs o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE  e.`encounter_type` = 15 AND e.`form_id` = 13  AND o.`voided` = 0 GROUP BY o.`person_id`, o.`obs_datetime`, o.encounter_id;
DROP TABLE IF EXISTS LastTracking;
CREATE TEMPORARY TABLE LastTracking AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
o.`obs_datetime`
FROM `All_Tracking` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
ORDER BY o.person_id, o.`obs_datetime`DESC;
DROP TABLE IF EXISTS Cihp_Client_Tracking;
CREATE TEMPORARY TABLE Cihp_Client_Tracking AS
SELECT a.person_id, p2.`identifier` AS pepid, a.obs_datetime, c2.name AS 'Reason For Tracking',  b.Partner_full_name, c.Address_of_Tx_supporter, d.Contact_phone_No, e.Date_of_Last_Actual, 
f.Date_Missed_Scheduled_App, g.ContAttempt_Date1, h.who_attempted_contact1, 
c3.`name` AS Mode_of_Communication1, c4.`name` AS Person_Contacted1, c5.`name` AS Reason_for_Defaulting1, c12.`name` AS Reason_for_Termination, z.Date_of_Termination, c13.`name` AS 'Patiet_Terminated(Previous_ARV_exposure)', 
c14.`name` AS Referred_for, ac.Date_Returned, ae.Date_LTFU, c15.`name` AS Reason_LTFU, ag.LTFU, Name_oF_Tracker, ai.Tracker_Sig_Date
FROM LastTracking a
LEFT JOIN Partner_full_name b ON a.person_id=b.person_id AND a.obs_datetime=b.obs_datetime 
LEFT JOIN Address_of_Tx_supporter c ON a.person_id=c.person_id AND a.obs_datetime=c.obs_datetime 
LEFT JOIN Contact_phone_No d ON a.person_id=d.person_id AND a.obs_datetime=d.obs_datetime
LEFT JOIN Date_of_Last_Actual e ON a.person_id=e.person_id AND a.obs_datetime=e.obs_datetime
LEFT JOIN Date_Missed_Scheduled_App f ON a.person_id=f.person_id AND a.obs_datetime=f.obs_datetime 
LEFT JOIN ContAttempt_Date1 g ON a.person_id=g.person_id AND a.obs_datetime=g.obs_datetime 
LEFT JOIN who_attempted_contact1 h ON a.person_id=h.person_id AND a.obs_datetime=h.obs_datetime
LEFT JOIN Mode_of_Communication1 i ON a.person_id=i.person_id AND a.obs_datetime=i.obs_datetime
LEFT JOIN Person_Contacted1 j ON a.person_id=j.person_id AND a.obs_datetime=j.obs_datetime 
LEFT JOIN Reason_for_Defaulting1 k ON a.person_id=k.person_id AND a.obs_datetime=k.obs_datetime 
LEFT JOIN Reason_for_Termination w ON a.person_id=w.person_id AND a.obs_datetime=w.obs_datetime
LEFT JOIN Date_of_Termination z ON a.person_id=z.person_id AND a.obs_datetime=z.obs_datetime 
LEFT JOIN Referred_for ab ON a.person_id=ab.person_id AND a.obs_datetime=ab.obs_datetime
LEFT JOIN Date_Returned ac ON a.person_id=ac.person_id AND a.obs_datetime=ac.obs_datetime
LEFT JOIN Patiet_Terminated ad ON a.person_id=ad.person_id AND a.obs_datetime=ad.obs_datetime
LEFT JOIN Date_LTFU ae ON a.person_id=ae.person_id AND a.obs_datetime=ae.obs_datetime 
LEFT JOIN Reason_LTFU af ON a.person_id=af.person_id AND a.obs_datetime=af.obs_datetime
LEFT JOIN LTFU ag ON a.person_id=ag.person_id AND a.obs_datetime=ag.obs_datetime 
LEFT JOIN Name_oF_Tracker ah ON a.person_id=ah.person_id AND a.obs_datetime=ah.obs_datetime
LEFT JOIN Tracker_Sig_Date ai ON a.person_id=ai.person_id AND a.obs_datetime=ai.obs_datetime
LEFT JOIN Reason_FOR_Tracking aj ON a.person_id=aj.person_id AND a.obs_datetime=aj.obs_datetime
LEFT JOIN `concept_name` c2 ON aj.`Reason FOR Tracking`=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1
LEFT JOIN `concept_name` c3 ON i.`Mode_of_Communication1`=c3.`concept_id` AND c3.locale = 'en' AND c3.locale_preferred = 1
LEFT JOIN `concept_name` c4 ON j.`Person_Contacted1`=c4.`concept_id` AND c4.locale = 'en' AND c4.locale_preferred = 1
LEFT JOIN `concept_name` c5 ON k.Reason_for_Defaulting1=c5.`concept_id` AND c5.locale = 'en' AND c5.locale_preferred = 1
LEFT JOIN `concept_name` c12 ON w.Reason_for_Termination=c12.`concept_id` AND c12.locale = 'en' AND c12.locale_preferred = 1
LEFT JOIN `concept_name` c13 ON ad.Previous_ARV_exposure=c13.`concept_id` AND c13.locale = 'en' AND c13.locale_preferred = 1
LEFT JOIN `concept_name` c14 ON ab.Referred_for=c14.`concept_id` AND c14.locale = 'en' AND c14.locale_preferred = 1
LEFT JOIN `concept_name` c15 ON af.Reason_LTFU=c15.`concept_id` AND c15.locale = 'en' AND c15.locale_preferred = 1
LEFT JOIN `patient_identifier` p2 ON a.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1
WHERE a.Occurrence = 1
GROUP BY a.person_id, a.obs_datetime  ORDER BY a.obs_datetime DESC;
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
LEFT JOIN `patient_identifier` p1 ON a.`person_id` = p1.`patient_id` AND p1.`identifier_type` = 4 AND p1.`preferred` = 1
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
a.Pepid, b.HospitalNo, IF((a.sex = 'F'), 'Female', 'Male') Sex, en.`encounter_datetime` Date_Enrolled,
TIMESTAMPDIFF(YEAR, a.DOB, c.ARTStartDate) AS AgeAtStartofART,
TIMESTAMPDIFF(MONTH, a.DOB, c.ARTStartDate) AS AgeAtStart_InMonth, TIMESTAMPDIFF(YEAR, a.DOB, @Reporting_Date) AS CurrentAge,
c.ARTStartDate, c.LastPickupDate, c.NextAppmt, c.DaysOfARVRefill, c.RegLineAtStart, c.ARTRegAtStart, 
c.CurrentRegLine, c.CurrentARTReg, c.PregStatus, c.CurrentVL, c.DateOfCurrentVL, c.ViralLoadIndication, c.Date_Result_Received, c.Last_VL_Sample_Date,
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
AND d.Date_Returned IS NOT NULL, d.Date_Returned, d.Date_of_Termination)Date_of_Termination, f.Last_EAC_Session_Date,
  f.EAC_Session_Type, f.EAC_ARV_Plan, f.Date_VL_Before_EAC, f.VL_Before_EAC, f.Date_VL_After_EAC, f.VL_After_EAC, 
  CONCAT(LEFT(UUID(), 4),RIGHT(YEAR(@Reporting_Date), 2),"-" , LEFT(UUID(), 5),MONTH(@Reporting_Date),"-", LEFT(UUID(), 3), DAY(@Reporting_Date)) List_Parameters 
FROM `CIHP_Patient` a 
LEFT JOIN CIHP_Hop b ON a.`patient_id`=b.`patient_id`
LEFT JOIN CIHP_ART_List c ON a.`patient_id`=c.`person_id`
LEFT JOIN Cihp_Client_Tracking d ON a.pepid=d.pepid
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