SET @Study_StartDate := '2020-10-01';
SET @Study_EndDate := '2021-09-30';






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
WHERE o.`concept_id` = 159599 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0 AND o.`value_datetime` BETWEEN @Study_StartDate AND @Study_EndDate;

DROP TABLE IF EXISTS Weight_at_Start;
CREATE TEMPORARY TABLE Weight_at_Start AS
SELECT o.`person_id`, o.`value_numeric` AS Weight_at_Start
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` = 165582 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0 AND e.`encounter_datetime` BETWEEN @Study_StartDate AND @Study_EndDate;

DROP TABLE IF EXISTS All_Weight;
CREATE TABLE All_Weight AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
 o.obs_datetime AS Visit_Date, o.value_numeric AS Weight
FROM `obs` o,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.concept_id = 5089 AND o.`voided` = 0 AND o.`obs_datetime` BETWEEN @Study_StartDate AND @Study_EndDate
ORDER BY o.person_id, o.`obs_datetime` DESC;

SELECT @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName, a.`patient_id`, a.`identifier` PEPID, 
TIMESTAMPDIFF(YEAR, b1.birthdate, @Study_EndDate) AS Age,
b1.gender SEX,  c.Marrital 'Marital status', b.Education 'Educational level', d.Occu_Status 'Occupation', r.value_text Next_of_kin, s.value_text NOK_Phone_no,
h.`city_village` 'LGA of residence', h.`state_province` 'State of Residence' , i.encounter_datetime 'Date of enrolment into care', j.ARTStartDate 'Date of ART initiation',
k.Visit_Date Last_Visit_Date, k.Weight Last_Weight,
l.Visit_Date Last2_Visit_Date, l.Weight Last2_Weight,
m.Visit_Date Last3_Visit_Date, m.Weight Last3_Weight,
n.Visit_Date Last4_Visit_Date, n.Weight Last4_Weight,
o.Visit_Date Last5_Visit_Date, o.Weight Last5_Weight,
p.Visit_Date Last6_Visit_Date, p.Weight Last6_Weight,
q.Visit_Date Last7_Visit_Date, q.Weight Last7_Weight

FROM `patient_identifier` a  
LEFT JOIN (SELECT person_id,`gender`, birthdate FROM `person` p WHERE  p.`voided`=0) b1 ON a.`patient_id`=b1.person_id
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`) Education FROM `OBS` o WHERE  `concept_id`=1712 AND o.`voided`=0) b ON a.`patient_id`=b.person_id
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`) Marrital FROM `OBS` o WHERE  `concept_id`=1054 AND o.`voided`=0) c ON a.`patient_id`=c.person_id
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`)Occu_Status FROM `OBS` o WHERE  `concept_id`=1542 AND o.`voided`=0) d ON a.`patient_id`=d.person_id
LEFT JOIN (SELECT person_id,o.`value_datetime` DateConfirmed FROM `OBS` o WHERE  `concept_id`=160554 AND o.`voided`=0) e ON a.`patient_id`=e.person_id 
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`)Entry FROM `OBS` o WHERE  `concept_id`=160540 AND o.`voided`=0) f ON a.`patient_id`=f.person_id
LEFT JOIN (SELECT person_id,`city_village`, `state_province` FROM `person_address` o WHERE o.`voided`=0) h ON a.`patient_id`=h.person_id
LEFT JOIN (SELECT `patient_id`,`encounter_datetime`, `encounter_id` FROM `encounter` o WHERE o.`voided`=0) i ON a.`patient_id`=i.patient_id
LEFT JOIN CIHP_ARTStartDate j ON a.`patient_id`=j.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Weight FROM All_Weight WHERE Occurrence = 1) k ON a.`patient_id`=k.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Weight FROM All_Weight WHERE Occurrence = 2) l ON a.`patient_id`=l.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Weight FROM All_Weight WHERE Occurrence = 3) m ON a.`patient_id`=m.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Weight FROM All_Weight WHERE Occurrence = 4) n ON a.`patient_id`=n.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Weight FROM All_Weight WHERE Occurrence = 5) o ON a.`patient_id`=o.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Weight FROM All_Weight WHERE Occurrence = 6) p ON a.`patient_id`=p.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Weight FROM All_Weight WHERE Occurrence = 7) q ON a.`patient_id`=q.person_id

LEFT JOIN (SELECT o.`person_id`, o.`value_text` FROM `obs` o LEFT JOIN `encounter` e ON e.`encounter_id`=o.`encounter_id` 
WHERE o.`concept_id`=162729 AND e.`encounter_type`=14 AND  o.`voided`=0) r ON a.`patient_id`=r.person_id
LEFT JOIN (SELECT o.`person_id`, o.`value_text` FROM `obs` o LEFT JOIN `encounter` e ON e.`encounter_id`=o.`encounter_id` 
WHERE o.`concept_id`=159635 AND e.`encounter_type`=14 AND  o.`voided`=0) s ON a.`patient_id`=s.person_id
#LEFT JOIN Med_duratn e5 ON a.`patient_id`=e5.person_id
WHERE a.`identifier_type`=4 AND a.`voided`=0 AND i.`encounter_datetime` BETWEEN @Study_StartDate AND @Study_EndDate GROUP BY a.`patient_id`;
DROP TABLE All_Weight;
