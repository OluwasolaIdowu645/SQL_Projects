/*SELECT a.`patient_Id`, p2.`identifier`, MAX(a.date_created)Initail_Date_Capture, COUNT(a.patient_id) AS Initail_Capture_Fingers, MAX(b.`recapture_count`) Recapture_Count, 
MAX(b.`date_created`) Date_Last_Recaptured FROM biometricinfo a
LEFT JOIN `patient_identifier` p2 ON a.`patient_Id` = p2.`patient_id` AND p2.`identifier_type` = 4
left join `biometricverificationinfo` b on a.`patient_Id` = b.`patient_id`
GROUP BY a.`patient_Id`;*/

DELIMITER $$
DROP FUNCTION IF EXISTS `EncounterName`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `EncounterName`(EncounterType INT) 
RETURNS TEXT CHARSET latin1 READS SQL DATA DETERMINISTIC BEGIN RETURN 
(SELECT NAME FROM  encounter_type  WHERE encounter_type_id = EncounterType 
 LIMIT 1);END$$ 
DELIMITER ;

DROP TABLE IF EXISTS biometricinfo_;
CREATE TEMPORARY TABLE biometricinfo_ AS
SELECT `patient_Id`, `date_created` Initial_Date_Captured, IF (`fingerPosition` IS NOT NULL, CONCAT('Initial_', `fingerPosition`), NULL) `fingerPosition`,
`imageQuality` FROM `biometricinfo`;

  
DROP TABLE IF EXISTS Ini_pbs;
CREATE TEMPORARY TABLE Ini_pbs AS
SELECT
  `patient_Id`, Initial_Date_Captured,
  MAX(CASE WHEN `fingerPosition` = 'Initial_RightThumb' THEN  `imageQuality` END) AS `Initial_RightThumb`,
  MAX(CASE WHEN `fingerPosition` = 'Initial_RightIndex' THEN  `imageQuality` END) AS `Initial_RightIndex`,
  MAX(CASE WHEN `fingerPosition` = 'Initial_RightMiddle' THEN  `imageQuality` END) AS `Initial_RightMiddle`,
  MAX(CASE WHEN `fingerPosition` = 'Initial_RightWedding' THEN  `imageQuality` END) AS `Initial_RightWedding`,
  MAX(CASE WHEN `fingerPosition` = 'Initial_RightSmall' THEN  `imageQuality` END) AS `Initial_RightSmall`,
  MAX(CASE WHEN `fingerPosition` = 'Initial_LeftThumb' THEN  `imageQuality` END) AS `Initial_LeftThumb`, 
  MAX(CASE WHEN `fingerPosition` = 'Initial_leftIndex' THEN  `imageQuality` END) AS `Initial_leftIndex`,
  MAX(CASE WHEN `fingerPosition` = 'Initial_leftMiddle' THEN  `imageQuality` END) AS `Initial_leftMiddle`,
  MAX(CASE WHEN `fingerPosition` = 'Initial_leftWedding' THEN  `imageQuality` END) AS `Initial_leftWedding`,
  MAX(CASE WHEN `fingerPosition` = 'Initial_leftSmall' THEN  `imageQuality` END) AS `Initial_leftSmall`
FROM
  `biometricinfo_`
GROUP BY
  `patient_Id`; 
  

DROP TABLE IF EXISTS _pbs;
CREATE TEMPORARY TABLE _pbs AS
SELECT `recapture_count`,`date_created`Date_Recapture,`patient_Id`, 
  MAX(CASE WHEN `fingerPosition` = 'RightThumb' THEN  `imageQuality` END) AS `RightThumb`,
  MAX(CASE WHEN `fingerPosition` = 'RightIndex' THEN  `imageQuality` END) AS `RightIndex`,
  MAX(CASE WHEN `fingerPosition` = 'RightMiddle' THEN  `imageQuality` END) AS `RightMiddle`,
  MAX(CASE WHEN `fingerPosition` = 'RightWedding' THEN  `imageQuality` END) AS `RightWedding`,
  MAX(CASE WHEN `fingerPosition` = 'RightSmall' THEN  `imageQuality` END) AS `RightSmall`,
  MAX(CASE WHEN `fingerPosition` = 'LeftThumb' THEN  `imageQuality` END) AS `LeftThumb`, 
  MAX(CASE WHEN `fingerPosition` = 'leftIndex' THEN  `imageQuality` END) AS `leftIndex`,
  MAX(CASE WHEN `fingerPosition` = 'leftMiddle' THEN  `imageQuality` END) AS `leftMiddle`,
  MAX(CASE WHEN `fingerPosition` = 'leftWedding' THEN  `imageQuality` END) AS `leftWedding`,
  MAX(CASE WHEN `fingerPosition` = 'leftSmall' THEN  `imageQuality` END) AS `leftSmall`
FROM `biometricverificationinfo` GROUP BY `patient_Id` ;


/*
SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT('MAX(CASE WHEN fingerPosition = ''', fingerPosition, ''' THEN imageQuality END) AS `', fingerPosition, '`')
  ) INTO @sql
FROM
  `biometricinfo_`;*/ 
/*  
SET @sql = CONCAT('SELECT Initial_Date_Captured,patient_Id, ', @sql, ' FROM biometricinfo_ GROUP BY patient_Id');
DROP TABLE IF EXISTS Ini_pbs;
SET @createtemptable = CONCAT('CREATE TEMPORARY TABLE Ini_pbs AS ', @sql);
PREPARE stmt FROM @createtemptable;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

#Recapture table
SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT('MAX(CASE WHEN `fingerPosition` = ''', `fingerPosition`, ''' THEN `imageQuality` END) AS `', `fingerPosition`, '`')
  ) INTO @sql
FROM
  `biometricverificationinfo`;

SET @sql = CONCAT('SELECT `recapture_count`,`date_created`Date_Recapture,`patient_Id`, ', @sql, ' FROM `biometricverificationinfo` GROUP BY `patient_Id`');
DROP TABLE IF EXISTS _pbs;
SET @createtemptable1 = CONCAT('CREATE TEMPORARY TABLE _pbs AS ', @sql);
PREPARE stmt FROM @createtemptable1;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
#SELECT * FROM _pbs;*/

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
SELECT 'CIHP' IP, @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName,
@DATIMCode DATIM_Code, CONCAT(p1.identifier, "-", @DATIMCode) Pepid_datim,

a.patient_Id,
p1.identifier PEPID,
a.Initial_Date_Captured,
d.No_Initial_Finger_Captured,
b.Date_Recapture,
e.No_Recaptured_Finger,
IFNULL(b.recapture_count,0) Recapture_Count,
c.Last_Visit_Date,
c.Last_Encounter,

ROUND((((IFNULL(a.Initial_LeftThumb,0)/IFNULL(b.LeftThumb,0))*100)+
((IFNULL(a.Initial_LeftIndex,0)/IFNULL(b.LeftIndex,0))*100)+
((IFNULL(a.Initial_LeftMiddle,0)/IFNULL(b.LeftMiddle,0))*100)+
((IFNULL(a.Initial_LeftWedding,0)/IFNULL(b.LeftWedding,0))*100)+
((IFNULL(a.Initial_LeftSmall,0)/IFNULL(b.LeftSmall,0))*100)+

((IFNULL(a.Initial_RightThumb,0)/IFNULL(b.RightThumb,0))*100)+
((IFNULL(a.Initial_RightIndex,0)/IFNULL(b.RightIndex,0))*100)+
((IFNULL(a.Initial_RightMiddle,0)/IFNULL(b.RightMiddle,0))*100)+
((IFNULL(a.Initial_RightWedding,0)/IFNULL(b.RightWedding,0))*100)+
((IFNULL(a.Initial_RightSmall,0)/IFNULL(b.RightSmall,0))*100))/10,0) 'Total_%_PBS_Quality',


ROUND((a.Initial_LeftThumb/b.LeftThumb)*100,0) 'L_Thumb_Quality(%)',
ROUND((a.Initial_LeftIndex/b.LeftIndex)*100,0) 'L_Index_Quality(%)',
ROUND((a.Initial_LeftMiddle/b.LeftMiddle)*100,0) 'L_Middle_Quality(%)',
ROUND((a.Initial_LeftWedding/b.LeftWedding)*100,0) 'L_Wedding_Quality(%)',
ROUND((a.Initial_LeftSmall/b.LeftSmall)*100,0) 'L_Small_Quality(%)',

ROUND((a.Initial_RightThumb/b.RightThumb)*100,0) 'R_Thumb_Quality(%)',
ROUND((a.Initial_RightIndex/b.RightIndex)*100,0) 'R_Index_Quality(%)',
ROUND((a.Initial_RightMiddle/b.RightMiddle)*100,0) 'R_Middle_Quality(%)',
ROUND((a.Initial_RightWedding/b.RightWedding)*100,0) 'R_Wedding_Quality(%)',
ROUND((a.Initial_RightSmall/b.RightSmall)*100,0) 'R_Small_Quality(%)',

a.Initial_LeftThumb,
a.Initial_LeftIndex,
a.Initial_LeftMiddle,
a.Initial_LeftWedding,
a.Initial_LeftSmall,
a.Initial_RightThumb,
a.Initial_RightIndex,
a.Initial_RightMiddle,
a.Initial_RightWedding,
a.Initial_RightSmall,
#b.patient_Id,
b.LeftIndex,
b.LeftMiddle,
b.LeftSmall,
b.LeftThumb,
b.LeftWedding,
b.RightIndex,
b.RightMiddle,
b.RightSmall,
b.RightThumb,
b.RightWedding

FROM Ini_pbs a
LEFT JOIN _pbs b ON a.patient_Id=b.patient_Id
LEFT JOIN `patient_identifier` p1 ON a.`patient_id` = p1.`patient_id` AND p1.`identifier_type` = 4 AND p1.`voided` = 0
LEFT JOIN (SELECT * FROM(SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, 
e.`encounter_datetime` Last_Visit_Date, EncounterName(`encounter_type`) Last_Encounter
FROM `encounter` e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y WHERE e.`voided` = 0
ORDER BY e.patient_id, e.`encounter_datetime` DESC)a WHERE occ=1) c ON a.patient_Id=c.patient_Id
LEFT JOIN (SELECT `patient_Id`, COUNT(`patient_Id`)No_Initial_Finger_Captured FROM `biometricinfo` GROUP BY patient_Id) d ON a.patient_Id=d.patient_Id
LEFT JOIN (SELECT `patient_Id`, COUNT(`patient_Id`) No_Recaptured_Finger FROM `biometricverificationinfo` GROUP BY patient_Id) e ON a.patient_Id=e.patient_Id
WHERE p1.`identifier_type` = 4 AND p1.`voided` = 0;