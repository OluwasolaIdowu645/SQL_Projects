#Edit Variable
SET @FY := 'FY23';


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



#Please don't touch
SET @yr1 = 
CASE WHEN @FY = 'FY21' THEN '2020'
WHEN @FY = 'FY22' THEN '2021' 
WHEN @FY = 'FY23' THEN '2022' 
WHEN @FY = 'FY24' THEN '2023' 
ELSE '0000' END;
SET @yr2 = 
CASE WHEN @FY = 'FY21' THEN '2021'
WHEN @FY = 'FY22' THEN '2022' 
WHEN @FY = 'FY23' THEN '2023' 
WHEN @FY = 'FY24' THEN '2024' 
ELSE '0000' END;
#Please don't touch
SET @Q1a = CASE WHEN @FY LIKE 'FY%' THEN CONCAT(@yr1,'-10-01') ELSE '0000-00-00' END;
SET @Q1b = CASE WHEN @FY LIKE 'FY%' THEN CONCAT(@yr1,'-12-31') ELSE '0000-00-00' END;
SET @Q2a = CASE WHEN @FY LIKE 'FY%' THEN CONCAT(@yr2,'-01-01') ELSE '0000-00-00' END;
SET @Q2b = CASE WHEN @FY LIKE 'FY%' THEN CONCAT(@yr2,'-03-31') ELSE '0000-00-00' END;
SET @Q3a = CASE WHEN @FY LIKE 'FY%' THEN CONCAT(@yr2,'-04-01') ELSE '0000-00-00' END;
SET @Q3b = CASE WHEN @FY LIKE 'FY%' THEN CONCAT(@yr2,'-06-30') ELSE '0000-00-00' END;
SET @Q4a = CASE WHEN @FY LIKE 'FY%' THEN CONCAT(@yr2,'-07-01') ELSE '0000-00-00' END;
SET @Q4b = CASE WHEN @FY LIKE 'FY%' THEN CONCAT(@yr2,'-09-30') ELSE '0000-00-00' END;

#select @q2a;
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
WHERE o.`concept_id` = 159599 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0 AND o.`value_datetime` BETWEEN @Q1a AND @Q4b;

DROP TABLE IF EXISTS Weight_at_Start;
CREATE TEMPORARY TABLE Weight_at_Start AS
SELECT o.`person_id`, o.`value_numeric` AS Weight_at_Start
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` = 165582 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0 AND e.`encounter_datetime` BETWEEN @Q1a AND @Q4b;

DROP TABLE IF EXISTS All_WeightQ1;
CREATE TEMPORARY TABLE All_WeightQ1 AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
 o.obs_datetime AS Visit_Date, o.value_numeric AS Weight
FROM `obs` o,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.concept_id = 5089 AND o.`voided` = 0 AND o.`obs_datetime` BETWEEN @Q1a AND @Q1b
ORDER BY o.person_id, o.`obs_datetime` DESC;

DROP TABLE IF EXISTS All_WeightQ2;
CREATE TEMPORARY TABLE All_WeightQ2 AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
 o.obs_datetime AS Visit_Date, o.value_numeric AS Weight
FROM `obs` o,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.concept_id = 5089 AND o.`voided` = 0 AND o.`obs_datetime` BETWEEN @Q2a AND @Q2b
ORDER BY o.person_id, o.`obs_datetime` DESC;

DROP TABLE IF EXISTS All_WeightQ3;
CREATE TEMPORARY TABLE All_WeightQ3 AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
 o.obs_datetime AS Visit_Date, o.value_numeric AS Weight
FROM `obs` o,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.concept_id = 5089 AND o.`voided` = 0 AND o.`obs_datetime` BETWEEN @Q3a AND @Q3b
ORDER BY o.person_id, o.`obs_datetime` DESC;

DROP TABLE IF EXISTS All_WeightQ4;
CREATE TEMPORARY TABLE All_WeightQ4 AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
 o.obs_datetime AS Visit_Date, o.value_numeric AS Weight
FROM `obs` o,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.concept_id = 5089 AND o.`voided` = 0 AND o.`obs_datetime` BETWEEN @Q4a AND @Q4b
ORDER BY o.person_id, o.`obs_datetime` DESC;

DROP TABLE IF EXISTS All_HeightQ1;
CREATE TEMPORARY TABLE All_HeightQ1 AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
 o.obs_datetime AS Visit_Date, o.value_numeric AS Height
FROM `obs` o,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.concept_id = 5090 AND o.`voided` = 0 AND o.`obs_datetime` BETWEEN @Q1a AND @Q1b
ORDER BY o.person_id, o.`obs_datetime` DESC;

DROP TABLE IF EXISTS All_HeightQ2;
CREATE TEMPORARY TABLE All_HeightQ2 AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
 o.obs_datetime AS Visit_Date, o.value_numeric AS Height
FROM `obs` o,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.concept_id = 5090 AND o.`voided` = 0 AND o.`obs_datetime` BETWEEN @Q2a AND @Q2b
ORDER BY o.person_id, o.`obs_datetime` DESC;

DROP TABLE IF EXISTS All_HeightQ3;
CREATE TEMPORARY TABLE All_HeightQ3 AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
 o.obs_datetime AS Visit_Date, o.value_numeric AS Height
FROM `obs` o,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.concept_id = 5090 AND o.`voided` = 0 AND o.`obs_datetime` BETWEEN @Q3a AND @Q3b
ORDER BY o.person_id, o.`obs_datetime` DESC;

DROP TABLE IF EXISTS All_HeightQ4;
CREATE TEMPORARY TABLE All_HeightQ4 AS
SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
 o.obs_datetime AS Visit_Date, o.value_numeric AS Height
FROM `obs` o,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.concept_id = 5090 AND o.`voided` = 0 AND o.`obs_datetime` BETWEEN @Q4a AND @Q4b
ORDER BY o.person_id, o.`obs_datetime` DESC;

SELECT @State State, @LGA LGA, @FacilityName FacilityName, @DATIMCode, a.`patient_id`, a.`identifier` PEPID, 
DATE_FORMAT(b1.birthdate, "%Y-%m-%d") Birthdate,
b1.gender SEX, b.Education 'Educational level', d.Occu_Status 'Occupation', u.value_text Next_of_kin, s.value_text NOK_Phone_no,
h.`city_village` 'LGA of residence', h.`state_province` 'State of Residence' , DATE_FORMAT(i.encounter_datetime, "%Y-%m-%d") 'Date of enrolment into care', DATE_FORMAT(j.ARTStartDate, "%Y-%m-%d") 'Date of ART initiation',
DATE_FORMAT(k.Visit_Date, "%Y-%m-%d") 'Q1_Visit_Date(W)', ROUND(k.Weight, 1) 'Q1_Weight(kg)', DATE_FORMAT(o.Visit_Date, "%Y-%m-%d") 'Q1_Visit_Date(H)', ROUND(o.Height, 1) 'Q1_Height(cm)', ROUND((k.Weight / o.Height / o.Height)*10000, 1) Q1_BMI,
DATE_FORMAT(l.Visit_Date, "%Y-%m-%d") 'Q2_Visit_Date(W)', ROUND(l.Weight, 1) 'Q2_Weight(kg)', DATE_FORMAT(p.Visit_Date, "%Y-%m-%d") 'Q2_Visit_Date(H)', ROUND(p.Height, 1) 'Q2_Height(cm)', ROUND((l.Weight / p.Height / p.Height)*10000, 1) Q2_BMI,
DATE_FORMAT(m.Visit_Date, "%Y-%m-%d") 'Q3_Visit_Date(W)', ROUND(m.Weight, 1) 'Q3_Weight(kg)', DATE_FORMAT(q.Visit_Date, "%Y-%m-%d") 'Q3_Visit_Date(H)', ROUND(q.Height, 1) 'Q3_Height(cm)', ROUND((m.Weight / q.Height / q.Height)*10000, 1) Q3_BMI,
DATE_FORMAT(n.Visit_Date, "%Y-%m-%d") 'Q4_Visit_Date(W)', ROUND(n.Weight, 1) 'Q4_Weight(kg)', DATE_FORMAT(r.Visit_Date, "%Y-%m-%d") 'Q4_Visit_Date(H)', ROUND(r.Height, 1) 'Q4_Height(cm)', ROUND((n.Weight / r.Height / r.Height)*10000, 1) Q4_BMI,
c.Marrital 'Marital status', f2.`family_name` Surname, f2.`given_name` FirstName, CAST(d2.`value` AS CHAR(50)) Phone_No

FROM `patient_identifier` a  
LEFT JOIN (SELECT person_id,`gender`, birthdate FROM `person` p WHERE  p.`voided`=0) b1 ON a.`patient_id`=b1.person_id
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`) Education FROM `OBS` o WHERE  `concept_id`=1712 AND o.`voided`=0) b ON a.`patient_id`=b.person_id
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`) Marrital FROM `OBS` o WHERE  `concept_id`=1054 AND o.`voided`=0) c ON a.`patient_id`=c.person_id
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`)Occu_Status FROM `OBS` o WHERE  `concept_id`=1542 AND o.`voided`=0) d ON a.`patient_id`=d.person_id
LEFT JOIN (SELECT person_id,o.`value_datetime` DateConfirmed FROM `OBS` o WHERE  `concept_id`=160554 AND o.`voided`=0) e ON a.`patient_id`=e.person_id 
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`)Entry FROM `OBS` o WHERE  `concept_id`=160540 AND o.`voided`=0) f ON a.`patient_id`=f.person_id
LEFT JOIN `person_name` f2 ON a.`patient_id`=f2.`person_id` AND f2.`voided`=0
LEFT JOIN (SELECT person_id,`city_village`, `state_province` FROM `person_address` o WHERE o.`voided`=0) h ON a.`patient_id`=h.person_id
LEFT JOIN (SELECT `patient_id`,`encounter_datetime`, `encounter_id` FROM `encounter` o WHERE o.`voided`=0) i ON a.`patient_id`=i.patient_id
LEFT JOIN CIHP_ARTStartDate j ON a.`patient_id`=j.person_id 
LEFT JOIN `person_attribute` d2 ON a.`patient_id`=d2.`person_id` AND d2.`voided`=0
LEFT JOIN (SELECT person_id,Visit_Date, Weight FROM All_WeightQ1 WHERE Occurrence = 1) k ON a.`patient_id`=k.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Weight FROM All_WeightQ2 WHERE Occurrence = 1) l ON a.`patient_id`=l.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Weight FROM All_WeightQ3 WHERE Occurrence = 1) m ON a.`patient_id`=m.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Weight FROM All_WeightQ4 WHERE Occurrence = 1) n ON a.`patient_id`=n.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Height FROM All_HeightQ1 WHERE Occurrence = 1) o ON a.`patient_id`=o.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Height FROM All_HeightQ2 WHERE Occurrence = 1) p ON a.`patient_id`=p.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Height FROM All_HeightQ3 WHERE Occurrence = 1) q ON a.`patient_id`=q.person_id
LEFT JOIN (SELECT person_id,Visit_Date, Height FROM All_HeightQ4 WHERE Occurrence = 1) r ON a.`patient_id`=r.person_id

LEFT JOIN (SELECT o.`person_id`, o.`value_text` FROM `obs` o LEFT JOIN `encounter` e ON e.`encounter_id`=o.`encounter_id` 
WHERE o.`concept_id`=162729 AND e.`encounter_type`=14 AND  o.`voided`=0) u ON a.`patient_id`=u.person_id
LEFT JOIN (SELECT o.`person_id`, o.`value_text` FROM `obs` o LEFT JOIN `encounter` e ON e.`encounter_id`=o.`encounter_id` 
WHERE o.`concept_id`=159635 AND e.`encounter_type`=14 AND  o.`voided`=0) s ON a.`patient_id`=s.person_id
#LEFT JOIN Med_duratn e5 ON a.`patient_id`=e5.person_id
WHERE a.`identifier_type`=4 AND a.`voided`=0 AND i.`encounter_datetime` BETWEEN @Q1a AND @Q4b GROUP BY a.`patient_id`;

