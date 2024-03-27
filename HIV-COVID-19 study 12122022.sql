SET @Study_StartDate := '2018-01-01';

DELIMITER $$
DROP FUNCTION IF EXISTS `get_concept_name`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_concept_name`(conceptid INT) RETURNS TEXT CHARSET latin1 
READS SQL DATA
DETERMINISTIC
BEGIN
	RETURN (SELECT NAME FROM  concept_name  WHERE concept_id = conceptid AND locale = 'en' AND locale_preferred = 1 LIMIT 1);		
    END$$
DELIMITER ;

SET @FacilityName :=(SELECT `property_value` FROM `global_property` WHERE `property`= 'Facility_Name');
SET @DATIMCode :=(SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code');
SET @SurgeCommand := (SELECT SurgeCommand FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code'));
SET @LGA :=(SELECT LGA FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code'));
SET @State :=(SELECT State FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code'));
SET SESSION sql_mode = '';

DROP TABLE IF EXISTS CIHP_ARTStartDate;
CREATE TEMPORARY TABLE CIHP_ARTStartDate AS
SELECT o.`person_id`, o.`value_datetime` AS ARTStartDate
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` = 159599 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0 AND o.`value_datetime` >= @Study_StartDate;

DROP TABLE IF EXISTS CD4_at_Start;
CREATE TEMPORARY TABLE CD4_at_Start AS
SELECT o.`person_id`, o.`value_numeric` AS CD4_at_Start
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` = 164429 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0 AND e.`encounter_datetime` >= @Study_StartDate;

DROP TABLE IF EXISTS 1st_CD4;
CREATE TEMPORARY TABLE 1st_CD4 AS
SELECT  person_id, MIN(e.`encounter_datetime`) 1st_CD4_Date, o.`value_numeric` 1st_CD4
FROM `obs` o LEFT JOIN `encounter` e ON e.`patient_id`=o.`person_id`
WHERE o.`concept_id` = 5497 AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 AND e.`encounter_datetime` >= @Study_StartDate GROUP BY person_id;

DROP TABLE IF EXISTS Last_CD4;
CREATE TEMPORARY TABLE Last_CD4 AS
SELECT  person_id, MAX(e.`encounter_datetime`) Last_CD4_Date, o.`value_numeric` Last_CD4
FROM `obs` o LEFT JOIN `encounter` e ON e.`patient_id`=o.`person_id`
WHERE o.`concept_id` = 5497 AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 AND e.`encounter_datetime` >= @Study_StartDate GROUP BY person_id;

DROP TABLE IF EXISTS CIHP_1st_RegimenLine;
CREATE TEMPORARY TABLE CIHP_1st_RegimenLine AS
SELECT o.`person_id`, get_concept_name(o.`concept_id`) Regimen_Line, o.`obs_datetime`, get_concept_name(o.`value_coded`) Regimen  FROM `obs` o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
WHERE e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`concept_id` IN (164506, 164507, 164513, 164514, 165702, 165703)
 AND o.`voided` = 0 AND e.`encounter_datetime` >= @Study_StartDate
GROUP BY o.`person_id`, o.`obs_datetime`;

DROP TABLE IF EXISTS CurrentRegimenLine;
CREATE TEMPORARY TABLE CurrentRegimenLine AS
SELECT o.`person_id`, get_concept_name(o.`concept_id`) Regimen_line, o.`obs_datetime`, o.`value_coded`, get_concept_name(o.`value_coded`) Regimen, o.encounter_id  FROM `encounter` e
LEFT JOIN  `obs` o ON o.`encounter_id`=e.`encounter_id`
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND o.`concept_id` IN (164506, 164507, 164513, 164514, 165702, 165703) AND o.`voided` = 0 
AND o.`obs_datetime` = (SELECT MAX(o2.obs_datetime) FROM obs o2 WHERE o.person_id=o2.person_id AND o2.concept_id = 165708 
AND o2.`obs_datetime` >= @Study_StartDate) GROUP BY o.`person_id`, o.`obs_datetime`;


DROP TABLE IF EXISTS OI_Prophylaxis;
CREATE TEMPORARY TABLE OI_Prophylaxis AS
SELECT  person_id, e.`encounter_datetime` , o.`value_coded`, 'Planned for OI Prophylaxis' OI
FROM `obs` o LEFT JOIN `encounter` e ON e.`patient_id`=o.`person_id`
WHERE o.`concept_id` = 165352 AND e.`encounter_type` IN (26,24) AND o.`voided` = 0 AND o.`value_coded`=165344 AND e.`encounter_datetime` >= @Study_StartDate GROUP BY person_id;

DROP TABLE IF EXISTS Weight_at_Start;
CREATE TEMPORARY TABLE Weight_at_Start AS
SELECT o.`person_id`, o.`value_numeric` AS Weight_at_Start
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` = 165582 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0 AND e.`encounter_datetime` >= @Study_StartDate;

DROP TABLE IF EXISTS 1st_TB_Investig;
CREATE TEMPORARY TABLE 1st_TB_Investig AS
SELECT * FROM
(SELECT a.Occurrence, a.patient_id, a.encounter_id, a.encounter_datetime Date_TB_Investig, 
CONCAT_WS( ', ', b.Sputum_AFB_TB, c.GeneXpert_TB, d.Chest_Xray_TB, e.Culture_TB) AS TB_Investigations, 
CONCAT_WS( ', ', f.Sputum_AFB_Result, g.GeneXpert_Result, h.Chest_Xray_Result, i.Culture_Result) AS Investig_Result
FROM
(SELECT @row_no := IF(@prev_val = e.`patient_id` , @row_no + 1, 1) AS Occurrence, @prev_val := e.`patient_id` AS patient_id,
 e.`encounter_id`, e.`encounter_datetime`
  FROM encounter e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
  WHERE e.`encounter_type` = 23
  AND e.`form_id` = 53 AND e.`voided`= 0 AND e.`encounter_datetime` >= @Study_StartDate
  ORDER BY e.patient_id,e.`encounter_datetime` ASC) a
  LEFT JOIN (SELECT `person_id`, IF(`value_coded` = 1, 'Sputum_AFB_TB', 'No') AS 'Sputum_AFB_TB', o.`encounter_id`  FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166141 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) b
  ON a.patient_id=b.person_id AND a.encounter_id=b.encounter_id
  LEFT JOIN (SELECT `person_id`, IF(`value_coded` = 1, 'GeneXpert_TB', 'No') AS 'GeneXpert_TB', o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166142 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) c
  ON a.patient_id=c.person_id AND a.encounter_id=c.encounter_id
  LEFT JOIN (SELECT `person_id`, IF(`value_coded` = 1, 'Chest_Xray_TB', 'No') AS 'Chest_Xray_TB', o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166143 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) d
ON a.patient_id=d.person_id AND a.encounter_id=d.encounter_id
LEFT JOIN (SELECT `person_id`, IF(`value_coded` = 1, 'Culture_TB', 'No') AS 'Culture_TB', o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166144 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) e
ON a.patient_id=e.person_id AND a.encounter_id=e.encounter_id
LEFT JOIN ( SELECT `person_id`, ConceptName(value_coded) AS 'Sputum_AFB_Result',  o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165968 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) f
ON a.patient_id=f.person_id AND a.encounter_id=f.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(value_coded) AS 'GeneXpert_Result', o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165975 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) g
ON a.patient_id=g.person_id AND a.encounter_id=g.encounter_id  
LEFT JOIN (  SELECT `person_id`, ConceptName(value_coded) AS 'Chest_Xray_Result', o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165972 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) h
  ON a.patient_id=h.person_id AND a.encounter_id=h.encounter_id 
  LEFT JOIN(SELECT `person_id`, ConceptName(value_coded) AS 'Culture_Result', o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165969 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) i
  ON a.patient_id=i.person_id AND a.encounter_id=i.encounter_id
  WHERE a.Occurrence =1) b WHERE b.TB_Investigations !='';
  

/*CIHP_ViralLoad_Data*/
DROP TABLE IF EXISTS CIHP_ViralLoad_Data18;CREATE TEMPORARY TABLE CIHP_ViralLoad_Data18 AS
SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occurrence, @prev_val := e.patient_id AS person_id, p2.`identifier` Pepid,
e.`encounter_datetime` DateOfCurrentVL, o.`value_numeric` CurrentVL, Date_Result_Received
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1
LEFT JOIN (SELECT DISTINCT person_id, encounter_id, value_datetime AS Date_Result_Received FROM obs WHERE concept_id = 165987 AND voided=0)
AS d ON  o.person_id=d.person_id AND o.`encounter_id`=d.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` = 856 AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 AND e.`encounter_datetime` BETWEEN '2018-01-01' AND '2018-12-31'
ORDER BY e.patient_id, e.`encounter_datetime` DESC;


DROP TABLE IF EXISTS CIHP_ViralLoad_Data19;CREATE TEMPORARY TABLE CIHP_ViralLoad_Data19 AS
SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occurrence, @prev_val := e.patient_id AS person_id, p2.`identifier` Pepid,
e.`encounter_datetime` DateOfCurrentVL, o.`value_numeric` CurrentVL, Date_Result_Received
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1
LEFT JOIN (SELECT DISTINCT person_id, encounter_id, value_datetime AS Date_Result_Received FROM obs WHERE concept_id = 165987 AND voided=0)
AS d ON  o.person_id=d.person_id AND o.`encounter_id`=d.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` = 856 AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 AND e.`encounter_datetime` BETWEEN '2019-01-01' AND '2019-12-31'
ORDER BY e.patient_id, e.`encounter_datetime` DESC;

DROP TABLE IF EXISTS CIHP_ViralLoad_Data20;CREATE TEMPORARY TABLE CIHP_ViralLoad_Data20 AS
SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occurrence, @prev_val := e.patient_id AS person_id, p2.`identifier` Pepid,
e.`encounter_datetime` DateOfCurrentVL, o.`value_numeric` CurrentVL, Date_Result_Received
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1
LEFT JOIN (SELECT DISTINCT person_id, encounter_id, value_datetime AS Date_Result_Received FROM obs WHERE concept_id = 165987 AND voided=0)
AS d ON  o.person_id=d.person_id AND o.`encounter_id`=d.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` = 856 AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 AND e.`encounter_datetime` BETWEEN '2020-01-01' AND '2020-12-31'
ORDER BY e.patient_id, e.`encounter_datetime` DESC;

DROP TABLE IF EXISTS CIHP_ViralLoad_Data21;CREATE TEMPORARY TABLE CIHP_ViralLoad_Data21 AS
SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occurrence, @prev_val := e.patient_id AS person_id, p2.`identifier` Pepid,
e.`encounter_datetime` DateOfCurrentVL, o.`value_numeric` CurrentVL, Date_Result_Received
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1
LEFT JOIN (SELECT DISTINCT person_id, encounter_id, value_datetime AS Date_Result_Received FROM obs WHERE concept_id = 165987 AND voided=0)
AS d ON  o.person_id=d.person_id AND o.`encounter_id`=d.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` = 856 AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 AND e.`encounter_datetime` BETWEEN '2021-01-01' AND '2021-12-31'
ORDER BY e.patient_id, e.`encounter_datetime` DESC;

DROP TABLE IF EXISTS CIHP_ViralLoad_Data22;CREATE TEMPORARY TABLE CIHP_ViralLoad_Data22 AS
SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occurrence, @prev_val := e.patient_id AS person_id, p2.`identifier` Pepid,
e.`encounter_datetime` DateOfCurrentVL, o.`value_numeric` CurrentVL, Date_Result_Received
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1
LEFT JOIN (SELECT DISTINCT person_id, encounter_id, value_datetime AS Date_Result_Received FROM obs WHERE concept_id = 165987 AND voided=0)
AS d ON  o.person_id=d.person_id AND o.`encounter_id`=d.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` = 856 AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 AND e.`encounter_datetime` BETWEEN '2022-01-01' AND '2022-12-31'
ORDER BY e.patient_id, e.`encounter_datetime` DESC;
DROP TABLE IF EXISTS a1;CREATE TEMPORARY TABLE a1 AS
SELECT * FROM CIHP_ViralLoad_Data18 WHERE Occurrence=1;
DROP TABLE IF EXISTS a2;CREATE TEMPORARY TABLE a2 AS 
SELECT * FROM CIHP_ViralLoad_Data18 WHERE Occurrence=2;
DROP TABLE IF EXISTS a3;CREATE TEMPORARY TABLE a3 AS 
SELECT * FROM CIHP_ViralLoad_Data18 WHERE Occurrence=3;
DROP TABLE IF EXISTS b0;CREATE TEMPORARY TABLE b0 AS
SELECT * FROM CIHP_ViralLoad_Data19 WHERE Occurrence=1;
DROP TABLE IF EXISTS b2;CREATE TEMPORARY TABLE b2 AS
SELECT * FROM CIHP_ViralLoad_Data19 WHERE Occurrence=2;
DROP TABLE IF EXISTS b3;CREATE TEMPORARY TABLE b3 AS 
SELECT * FROM CIHP_ViralLoad_Data19 WHERE Occurrence=3;
DROP TABLE IF EXISTS c1;CREATE TEMPORARY TABLE c1 AS
SELECT * FROM CIHP_ViralLoad_Data20 WHERE Occurrence=1;
DROP TABLE IF EXISTS c2;CREATE TEMPORARY TABLE c2 AS
SELECT * FROM CIHP_ViralLoad_Data20 WHERE Occurrence=2;
DROP TABLE IF EXISTS c3;CREATE TEMPORARY TABLE c3 AS
SELECT * FROM CIHP_ViralLoad_Data20 WHERE Occurrence=3;
DROP TABLE IF EXISTS d1;CREATE TEMPORARY TABLE d1 AS
SELECT * FROM CIHP_ViralLoad_Data21 WHERE Occurrence=1;
DROP TABLE IF EXISTS d2;CREATE TEMPORARY TABLE d2 AS 
SELECT * FROM CIHP_ViralLoad_Data21 WHERE Occurrence=2;
DROP TABLE IF EXISTS d3;CREATE TEMPORARY TABLE d3 AS
SELECT * FROM CIHP_ViralLoad_Data21 WHERE Occurrence=3;
DROP TABLE IF EXISTS e1;CREATE TEMPORARY TABLE e1 AS
SELECT * FROM CIHP_ViralLoad_Data22 WHERE Occurrence=1;
DROP TABLE IF EXISTS e2;CREATE TEMPORARY TABLE e2 AS
SELECT * FROM CIHP_ViralLoad_Data22 WHERE Occurrence=2;
DROP TABLE IF EXISTS e3;CREATE TEMPORARY TABLE e3 AS
SELECT * FROM CIHP_ViralLoad_Data22 WHERE Occurrence=3;

/*DROP TABLE IF EXISTS Med_duratn;
CREATE TEMPORARY TABLE Med_duratn AS
SELECT o.`person_id`, e.`encounter_id`, o.`obs_group_id`, o.`value_numeric` DaysOfARVRefill, f.Pill_Balance, b.Next_Pickup_Date,
a.`obs_id` FROM `obs` o 
LEFT JOIN `CurrentRegimenLine` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN (SELECT o2.`obs_id` FROM `obs` o2 WHERE o2.concept_id = 162240 AND o2.`voided` = 0) a ON a.obs_id = o.obs_group_id
LEFT JOIN (SELECT person_id, CAST(`value_text` AS UNSIGNED) Pill_Balance, encounter_id FROM obs WHERE concept_id = 166406) f ON f.encounter_id=e.encounter_id
LEFT JOIN (SELECT person_id, `value_datetime` Next_Pickup_Date, encounter_id FROM obs WHERE concept_id = 5096) b ON b.encounter_id=e.encounter_id
WHERE o.`concept_id` = 159368 AND o.`voided` = 0;*/

SELECT @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName, a.`patient_id`, a.`identifier` PEPID, 
TIMESTAMPDIFF(YEAR, b1.birthdate, CURDATE()) AS Age, TIMESTAMPDIFF(YEAR, b1.birthdate, j.ARTStartDate) Age_at_Start_ART,
b1.gender SEX,  c.Marrital 'Marital status', b.Education 'Educational level', d.Occu_Status 'Occupation', r.value_text Next_of_kin, s.value_text NOK_Phone_no,
h.`city_village` 'LGA of residence', h.`state_province` 'State of Residence' , e.DateConfirmed 'Date of diagnosis ', i.encounter_datetime 'Date of enrolment into care', j.ARTStartDate 'Date of ART initiation',
k.CD4_at_Start AS'CD4 result at ART initiation', l.`1st_CD4` '1st_CD4_Recorded(Lab Form)', 1st_CD4_Date Date_1st_CD4,  Last_CD4 'Last_CD4(Lab Form)', Last_CD4_Date, n.Regimen 'ART regimen at Start of ART',
n.Regimen_line 'ART regimen line at Start of ART',
OI 'Opportunistic infection at start of ART', p.Weight_at_Start 'Weight at start of ART', q.TB_Investigations, q.Investig_Result 'TB screening status at start of ART',
a1.DateOfCurrentVL VL_Date_2018_1, a1.CurrentVL VL_2018_1, a2.DateOfCurrentVL VL_Date_2018_2, a2.CurrentVL VL_2018_2, a3.DateOfCurrentVL VL_Date_2018_3, a3.CurrentVL VL_2018_3, 
b0.DateOfCurrentVL VL_Date_2019_1, b0.CurrentVL VL_2019_1, b2.DateOfCurrentVL VL_Date_2019_2, b2.CurrentVL VL_2019_2, b3.DateOfCurrentVL VL_Date_2019_3, b3.CurrentVL VL_2019_3, 
c1.DateOfCurrentVL VL_Date_2020_1, c1.CurrentVL VL_2020_1, c2.DateOfCurrentVL VL_Date_2020_2, c2.CurrentVL VL_2020_2, c3.DateOfCurrentVL VL_Date_2020_3, c3.CurrentVL VL_2020_3, 
d1.DateOfCurrentVL VL_Date_2021_1, d1.CurrentVL VL_2021_1, d2.DateOfCurrentVL VL_Date_2021_2, d2.CurrentVL VL_2021_2, d3.DateOfCurrentVL VL_Date_2021_3, d3.CurrentVL VL_2021_3,
e1.DateOfCurrentVL VL_ate_2022_1, e1.CurrentVL VL_2022_1, e2.DateOfCurrentVL VL_Date_2022_2, e2.CurrentVL VL_2022_2, e3.DateOfCurrentVL VL_Date_2022_3, e3.CurrentVL VL_2022_3, 
e4.Regimen_line AS 'Current ART regimen type', e4.Regimen Current_Regimen, e4.obs_datetime AS 'Date of last drug pick up', 
CASE
WHEN n.Regimen = e4.Regimen AND n.Regimen_line = e4.Regimen_line THEN 'No Change'
WHEN n.Regimen != e4.Regimen AND n.Regimen_line = e4.Regimen_line THEN 'Drug Substitution' 
WHEN n.Regimen != e4.Regimen AND n.Regimen_line != e4.Regimen_line THEN 'Drug Switch'
ELSE 'Something happned'
END AS 'ART regime change (yes or no)'
#e5.DaysOfARVRefill AS 'Quantity of drugs (in days) dispensed at last drug pick-up scheduled appointment', (e4.obs_datetime + e5.DaysOfARVRefill) AS 'Date of last appointment '
 FROM `patient_identifier` a  
LEFT JOIN (SELECT person_id,`gender`, birthdate FROM `person` p WHERE  p.`voided`=0) b1 ON a.`patient_id`=b1.person_id
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`) Education FROM `OBS` o WHERE  `concept_id`=1712 AND o.`voided`=0) b ON a.`patient_id`=b.person_id
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`) Marrital FROM `OBS` o WHERE  `concept_id`=1054 AND o.`voided`=0) c ON a.`patient_id`=c.person_id
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`)Occu_Status FROM `OBS` o WHERE  `concept_id`=1542 AND o.`voided`=0) d ON a.`patient_id`=d.person_id
LEFT JOIN (SELECT person_id,o.`value_datetime` DateConfirmed FROM `OBS` o WHERE  `concept_id`=160554 AND o.`voided`=0) e ON a.`patient_id`=e.person_id 
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`)Entry FROM `OBS` o WHERE  `concept_id`=160540 AND o.`voided`=0) f ON a.`patient_id`=f.person_id
LEFT JOIN (SELECT person_id,`value_text` FAC_ART FROM `OBS` o WHERE  `concept_id`=160535 AND o.`voided`=0) g ON a.`patient_id`=g.person_id
LEFT JOIN (SELECT person_id,`city_village`, `state_province` FROM `person_address` o WHERE o.`voided`=0) h ON a.`patient_id`=h.person_id
LEFT JOIN (SELECT `patient_id`,`encounter_datetime`, `encounter_id` FROM `encounter` o WHERE o.`voided`=0) i ON a.`patient_id`=i.patient_id
LEFT JOIN CIHP_ARTStartDate j ON a.`patient_id`=j.person_id
LEFT JOIN CD4_at_Start k ON a.`patient_id`=k.person_id
LEFT JOIN 1st_CD4 l ON a.`patient_id`=l.person_id
LEFT JOIN Last_CD4 m ON a.`patient_id`=m.person_id
LEFT JOIN CIHP_1st_RegimenLine n ON a.`patient_id`=n.person_id
LEFT JOIN OI_Prophylaxis o ON a.`patient_id`=o.person_id
LEFT JOIN Weight_at_Start p ON a.`patient_id`=p.person_id
LEFT JOIN 1st_TB_Investig q ON a.`patient_id`=q.patient_id
LEFT JOIN (SELECT o.`person_id`, o.`value_text` FROM `obs` o LEFT JOIN `encounter` e ON e.`encounter_id`=o.`encounter_id` 
WHERE o.`concept_id`=162729 AND e.`encounter_type`=14 AND  o.`voided`=0) r ON a.`patient_id`=r.person_id
LEFT JOIN (SELECT o.`person_id`, o.`value_text` FROM `obs` o LEFT JOIN `encounter` e ON e.`encounter_id`=o.`encounter_id` 
WHERE o.`concept_id`=159635 AND e.`encounter_type`=14 AND  o.`voided`=0) s ON a.`patient_id`=s.person_id
LEFT JOIN a1 ON a.`patient_id`=a1.person_id
LEFT JOIN a2 ON a.`patient_id`=a2.person_id
LEFT JOIN a3 ON a.`patient_id`=a3.person_id

LEFT JOIN b0 ON a.`patient_id`=b0.person_id
LEFT JOIN b2 ON a.`patient_id`=b2.person_id
LEFT JOIN b3 ON a.`patient_id`=b3.person_id

LEFT JOIN c1 ON a.`patient_id`=c1.person_id
LEFT JOIN c2 ON a.`patient_id`=c2.person_id
LEFT JOIN c3 ON a.`patient_id`=c3.person_id

LEFT JOIN d1 ON a.`patient_id`=d1.person_id
LEFT JOIN d2 ON a.`patient_id`=d2.person_id
LEFT JOIN d3 ON a.`patient_id`=d3.person_id

LEFT JOIN e1 ON a.`patient_id`=e1.person_id
LEFT JOIN e2 ON a.`patient_id`=e2.person_id
LEFT JOIN e3 ON a.`patient_id`=e3.person_id
LEFT JOIN CurrentRegimenLine e4 ON a.`patient_id`=e4.person_id
#LEFT JOIN Med_duratn e5 ON a.`patient_id`=e5.person_id
WHERE a.`identifier_type`=4 AND a.`voided`=0 AND i.`encounter_datetime` >= @Study_StartDate GROUP BY a.`patient_id` ;
