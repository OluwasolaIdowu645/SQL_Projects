
SET @FacilityName :=(SELECT  `property_value`FROM  `global_property`WHERE `property`= 'Facility_Name');
SET @DATIMCode :=(SELECT  `property_value`FROM  `global_property`WHERE `property`= 'facility_datim_code');
SET @SurgeCommand :=(SELECT  SurgeCommand FROM  CIHP_ListOfFacility WHERE Datim_Code = (SELECT  `property_value`FROM  `global_property`WHERE `property`= 'facility_datim_code'));
SET @LGA :=(SELECT  LGA FROM  CIHP_ListOfFacility WHERE Datim_Code = (SELECT  `property_value`FROM  `global_property`WHERE `property`= 'facility_datim_code'));
SET @State :=(SELECT  State FROM  CIHP_ListOfFacility WHERE Datim_Code = (SELECT  `property_value`FROM  `global_property`
WHERE `property`= 'facility_datim_code'));
DROP TABLE IF EXISTS CIHP_ARTStartDate1;
CREATE TEMPORARY TABLE CIHP_ARTStartDate1 AS
SELECT o.`person_id`, o.`value_datetime` AS ARTStartDate
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` = 159599 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0;

DROP TABLE IF EXISTS CIHP_PharmOcc1;
CREATE TEMPORARY TABLE CIHP_PharmOcc1 AS SELECT * FROM
(SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, e.`encounter_datetime`, e.`encounter_id`
FROM `encounter` e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND e.`voided` = 0
ORDER BY e.patient_id, e.`encounter_datetime` ASC)a WHERE a.Occ=1 ;

DROP TABLE IF EXISTS CIHP_ARV_Medication1;
CREATE TEMPORARY TABLE CIHP_ARV_Medication1 AS
SELECT o.`obs_id`, o.`person_id`, o.`concept_id`, e.`encounter_datetime`, o.`value_coded`, 
GROUP_CONCAT(DISTINCT o.`value_coded` SEPARATOR ', ') nmrs_inconsistency2,c2.`name` CurrentARTReg, 
GROUP_CONCAT(DISTINCT c2.`name` SEPARATOR ', ') nmrs_inconsistency FROM `obs` o 
LEFT JOIN `concept_name` c2 ON o.`value_coded`=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1
LEFT JOIN `CIHP_PharmOcc1` e ON o.`encounter_id`=e.`encounter_id`
WHERE e.Occ = 1 AND o.`concept_id` IN (164506, 164507, 164513, 164514, 165702, 165703) AND o.`voided` = 0 
GROUP BY o.`person_id`, o.`obs_datetime`;

DROP TABLE IF EXISTS CIHP_Med_duratn1;
CREATE TEMPORARY TABLE CIHP_Med_duratn1 AS
SELECT o.`person_id`, e.`encounter_id`, e.`encounter_datetime` LastPickupDate, o.`obs_group_id`, o.`value_numeric` DaysOfARVRefill, a.`obs_id` FROM `obs` o 
LEFT JOIN `CIHP_PharmOcc1` e ON o.`encounter_id`=e.`encounter_id` AND  o.`encounter_id` = e.`encounter_id`
LEFT JOIN (SELECT o2.`obs_id` FROM `obs` o2 WHERE o2.concept_id = 162240 AND o2.`voided` = 0) a ON a.obs_id = o.obs_group_id
WHERE  e.Occ = 1 AND o.`concept_id` = 159368 AND o.`voided` = 0;

SELECT @FacilityName FacilityName, @DATIMCode DATIMCode, @SurgeCommand SurgeCommand,@LGA LGA, @State State, p.`patient_id`, p.`identifier` PEPID, a.ARTStartDate, 
b.encounter_datetime 'First_ART_Date(Pharmacy)', d.CurrentARTReg 'First_ART_Reg(Pharmacy)', c.DaysOfARVRefill
FROM `patient_identifier` p 
LEFT JOIN CIHP_ARTStartDate1 a ON p.`patient_id`=a.person_id
LEFT JOIN CIHP_PharmOcc1 b ON p.`patient_id`=b.patient_id
LEFT JOIN CIHP_Med_duratn1 c ON p.`patient_id`=c.person_id
LEFT JOIN CIHP_ARV_Medication1 d ON p.`patient_id`=c.person_id
WHERE p.`identifier_type`=4 AND p.`voided`=0 GROUP BY p.`patient_id`;