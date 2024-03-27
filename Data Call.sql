SET @@GLOBAL.sql_mode ="";
SET @Reporting_Date = CURDATE();
DELIMITER $$
DROP FUNCTION IF EXISTS `ConceptName`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ConceptName`(conceptid INT) 
RETURNS TEXT CHARSET latin1 READS SQL DATA DETERMINISTIC BEGIN RETURN 
(SELECT NAME FROM  concept_name  WHERE concept_id = conceptid 
AND locale = 'en' AND locale_preferred = 1 LIMIT 1);END$$ 
DELIMITER ;


SET @FacilityName :=(SELECT `property_value`FROM `global_property`WHERE `property`= 'Facility_Name');
SET @DATIMCode :=(SELECT `property_value`FROM `global_property`WHERE `property`= 'facility_datim_code');
SET @SurgeCommand :=(SELECT SurgeCommand FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value`FROM `global_property`
WHERE `property`= 'facility_datim_code'));
SET @LGA :=(SELECT LGA FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value`FROM `global_property`
WHERE `property`= 'facility_datim_code'));
SET @State :=(SELECT State FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value`FROM `global_property`
WHERE `property`= 'facility_datim_code'));

SELECT 'CIHP' IP, @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName,@DATIMCode DATIMCode, a.person_id, f.pepid PEPID,
TIMESTAMPDIFF(YEAR, f.DOB, b.value_datetime) AS AgeAtStartofART,  f.DOB, TIMESTAMPDIFF(YEAR, f.DOB, a.Date_of_Termination) AS CurrentAge, a.Date_of_Termination,
f.Sex, g.Educational_status, h.Marital_status, i.Occupation, f.city_village LGA_of_residence, f.state_province State_of_residence,
o.encounter_datetime Date_of_enrollment, b.value_datetime Date_of_ART_initiation, c.RegLine_drug_at_initiation, d.ART_Reg_drug_at_initiation,
e.Weight_at_ART_initiation, j.CD4_at_ART_initiation, j.Date_of_Initial_CD4_count, k.1st_Lab_CD4_Count, k.1st_Lab_CD4_Date, l.Last_VL Last_Viral_Load, 
l.Last_VL_Date,
m.ICE_WHO_Staging, n.Last_TB_Test_Date, n.TB_Status_Type_of_Test, n.TB_Status_Test_Result,
Date_LastPickup_within_24_month,
Last_Date_Pickup_within_24_month,
Last_Drug_Duration_within_24_month,
Last_NextAppmt_Date_within_24_month,
2nd_Date_Last_Pickup_within_24_month,
2nd_Last_Date_Pickup_within_24_month,
2nd_Last_Drug_Duration_within_24_month,
2nd_Last_NextAppmt_Date_within_24_month,
3rd_Date_Last_Pickup_within_24_month,
3rd_Last_Date_Pickup_within_24_month,
3rd_Last_Drug_Duration_within_24_month,
3rd_Last_NextAppmt_Date_within_24_month,
4th_Date_Last_Pickup_within_24_month,
4th_Last_Date_Pickup_within_24_month,
4th_Last_Drug_Duration_within_24_month,
4th_Last_NextAppmt_Date_within_24_month,
5th_Date_Last_Pickup_within_24_month,
5th_Last_Date_Pickup_within_24_month,
5th_Last_Drug_Duration_within_24_month,
5th_Last_NextAppmt_Date_within_24_month,
6th_Date_Last_Pickup_within_24_month,
6th_Last_Date_Pickup_within_24_month,
6th_Last_Drug_Duration_within_24_month,
6th_Last_NextAppmt_Date_within_24_month,
7th_Date_Last_Pickup_within_24_month,
7th_Last_Date_Pickup_within_24_month,
7th_Last_Drug_Duration_within_24_month,
7th_Last_NextAppmt_Date_within_24_month,
8th_Date_Last_Pickup_within_24_month,
8th_Last_Date_Pickup_within_24_month,
8th_Last_Drug_Duration_within_24_month,
8th_Last_NextAppmt_Date_within_24_month,
9th_Date_Last_Pickup_within_24_month,
9th_Last_Date_Pickup_within_24_month,
9th_Last_Drug_Duration_within_24_month,
9th_Last_NextAppmt_Date_within_24_month,
10th_Date_Last_Pickup_within_24_month,
10th_Last_Date_Pickup_within_24_month,
410th_Last_Drug_Duration_within_24_month,
10th_Last_NextAppmt_Date_within_24_month,
11th_Date_Last_Pickup_within_24_month,
11th_Last_Date_Pickup_within_24_month,
11th_Last_Drug_Duration_within_24_month,
11th_Last_NextAppmt_Date_within_24_month

FROM
(SELECT a.`person_id`, a.Reason_for_Termination, a.`obs_datetime`, a.`encounter_id`, b.Date_of_Termination, DATE_SUB(b.Date_of_Termination, INTERVAL 24 MONTH) 24_Month_Ago
FROM(SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_for_Termination', `obs_datetime`, o.`encounter_id` FROM obs o 
WHERE concept_id = 165470 AND value_coded =165889 AND o.voided=0) a
LEFT JOIN (SELECT  `value_datetime` AS 'Date_of_Termination', o.`encounter_id` FROM obs o 
WHERE concept_id = 165469 AND o.voided=0) b ON a.encounter_id=b.encounter_id) a
#Enrolment
LEFT JOIN (SELECT e.`patient_id`, e.`encounter_datetime` FROM `encounter` e 
WHERE e.`encounter_type` = 14 AND e.`form_id` = 23 AND e.`voided` = 0 GROUP BY e.`patient_id`) o  ON  a.person_id = o.patient_id
#ART Initiation
LEFT JOIN (SELECT o.`person_id`, o.`value_datetime`
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` = 159599 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0) b ON  a.person_id = b.person_id
#Regline at Initiation
LEFT JOIN (SELECT o.`person_id`, ConceptName(o.`value_coded`) RegLine_drug_at_initiation 
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` = 165708 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0) c ON  a.person_id = c.person_id
#ERT Reg at Initiation
LEFT JOIN (SELECT o.`person_id`, ConceptName(o.`value_coded`) ART_Reg_drug_at_initiation 
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` IN (164506,164513,165702,164507,164514,165703)  AND e.`encounter_type` = 25 
AND e.`form_id` = 56 AND o.`voided`=0) d ON  a.person_id = d.person_id
#Weight at Initiation
LEFT JOIN (SELECT o.`person_id`, o.`value_numeric` Weight_at_ART_initiation 
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` = 165582 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0) e ON  a.person_id = e.person_id

#Patient Bio
LEFT JOIN(
SELECT a.`patient_id`, b.`identifier` Pepid, c.`birthdate` DOB, c.`gender` Sex, c.`dead`, c.`death_date`,
d.`value` Phone_No, e.`address2`, e.`address1`, e.`city_village`, e.`state_province`,
f.`family_name` Surname, f.`given_name` FirstName, en.`encounter_datetime`
FROM `patient` a 
LEFT JOIN `patient_identifier` b ON a.`patient_id` = b.`patient_id`
LEFT JOIN `person` c ON a.`patient_id`=c.`person_id`
LEFT JOIN `person_attribute` d ON a.`patient_id`=d.`person_id` AND d.`voided`=0
LEFT JOIN `person_address` e ON a.`patient_id`=e.`person_id` AND e.`voided`=0
LEFT JOIN `person_name` f ON a.`patient_id`=f.`person_id`
LEFT JOIN `encounter` en ON a.`patient_id`=en.`patient_id`
WHERE en.`encounter_type` = 14 AND en.`voided`=0 
AND a.`voided`=0 AND b.`identifier_type` = 4
GROUP BY a.`patient_id`) f ON a.person_id = f.patient_id
#Educational Status
LEFT JOIN
(SELECT e.`patient_id`,ConceptName(o.`value_coded`) Educational_status   FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
WHERE o.`concept_id` = 1712 AND e.`encounter_type` = 14 AND e.`form_id` = 23 AND o.`voided` = 0) g ON  a.person_id = g.patient_id
#Marital Status
LEFT JOIN
(SELECT e.`patient_id`,ConceptName(o.`value_coded`) Marital_status   FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
WHERE o.`concept_id` = 1054 AND e.`encounter_type` = 14 AND e.`form_id` = 23 AND o.`voided` = 0) h ON  a.person_id = h.patient_id
#Occupation 
LEFT JOIN
(SELECT e.`patient_id`,ConceptName(o.`value_coded`) Occupation   FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
WHERE o.`concept_id` = 1542 AND e.`encounter_type` = 14 AND e.`form_id` = 23 AND o.`voided` = 0) i ON  a.person_id = i.patient_id
#CD4 at Initiation
LEFT JOIN (SELECT o.`person_id`, o.`value_numeric` CD4_at_ART_initiation, e.`encounter_datetime` Date_of_Initial_CD4_count 
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` = 164429 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0) j ON  a.person_id = j.person_id
#1st Lab CD4 Count
LEFT JOIN (SELECT * FROM (SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id,
o.`person_id`, o.`value_numeric` 1st_Lab_CD4_Count, e.`encounter_datetime` 1st_Lab_CD4_Date 
FROM `obs` o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE o.`concept_id` = 5497 AND e.`encounter_type` = 11 AND e.`form_id` = 21 AND o.`voided`=0
ORDER BY o.person_id, e.`encounter_datetime` DESC)a WHERE a.occ=1) k ON  a.person_id = k.person_id
#Last Lab VL
LEFT JOIN (SELECT o.`person_id`, o.`value_numeric` Last_VL, MAX(e.`encounter_datetime`) Last_VL_Date
FROM `obs` o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
WHERE o.`concept_id` = 856 AND e.`encounter_type` = 11 AND e.`form_id` = 21 AND o.`voided`=0 GROUP BY o.`person_id`) l ON  a.person_id = l.person_id
#WHO Staging - ICE Form
LEFT JOIN (SELECT o.person_id, o.`obs_datetime` Date_WHO_Staging, ConceptName(o.`value_coded`) ICE_WHO_Staging
FROM obs o
LEFT JOIN `encounter` e ON o.`person_id`=e.`patient_id`
WHERE o.concept_id = 5356 AND o.voided=0 AND (e.`encounter_type`=26 OR e.`encounter_type`=24)) m ON a.person_id = m.person_id
#TB Status at Initiation
LEFT JOIN (SELECT o.`person_id`, a.Last_TB_Test_Date, o.`encounter_id`, GROUP_CONCAT(DISTINCT ConceptName(o.`concept_id`) SEPARATOR ', ')TB_Status_Type_of_Test, 
GROUP_CONCAT(DISTINCT ConceptName(o.`value_coded`) SEPARATOR ', ')TB_Status_Test_Result,o.`value_datetime`
 FROM (SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, 
e.`encounter_datetime` Last_TB_Test_Date, e.`encounter_id`
FROM `encounter` e,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE e.`encounter_type` = 23 AND e.`voided` = 0 
ORDER BY e.patient_id, e.`encounter_datetime` DESC) a 
LEFT JOIN `obs` o ON o.`encounter_id`=a.`encounter_id`
WHERE a.occ=1 AND o.concept_id IN (165975,165968,165972,165969) AND o.`voided`=0 AND o.`voided`=0 GROUP BY `person_id`) n ON  a.person_id = n.person_id

LEFT JOIN
(
SELECT patient_id,
MAX(CASE WHEN Occ = 1 THEN LastPickupDate ELSE 0 END) AS Date_LastPickup_within_24_month,
MAX(CASE WHEN Occ = 1 THEN CurrentARTReg ELSE NULL END) AS Last_Date_Pickup_within_24_month,
MAX(CASE WHEN Occ = 1 THEN DaysOfARVRefill ELSE NULL END) AS Last_Drug_Duration_within_24_month,
MAX(CASE WHEN Occ = 1 THEN NextAppmt ELSE 0 END) AS Last_NextAppmt_Date_within_24_month,
MAX(CASE WHEN Occ = 2 THEN LastPickupDate ELSE 0 END) AS 2nd_Date_Last_Pickup_within_24_month,
MAX(CASE WHEN Occ = 2 THEN CurrentARTReg ELSE NULL END) AS 2nd_Last_Date_Pickup_within_24_month,
MAX(CASE WHEN Occ = 2 THEN DaysOfARVRefill ELSE NULL END) AS 2nd_Last_Drug_Duration_within_24_month,
MAX(CASE WHEN Occ = 2 THEN NextAppmt ELSE 0 END) AS 2nd_Last_NextAppmt_Date_within_24_month,
MAX(CASE WHEN Occ = 3 THEN LastPickupDate ELSE 0 END) AS 3rd_Date_Last_Pickup_within_24_month,
MAX(CASE WHEN Occ = 3 THEN CurrentARTReg ELSE NULL END) AS 3rd_Last_Date_Pickup_within_24_month,
MAX(CASE WHEN Occ = 3 THEN DaysOfARVRefill ELSE NULL END) AS 3rd_Last_Drug_Duration_within_24_month,
MAX(CASE WHEN Occ = 3 THEN NextAppmt ELSE 0 END) AS 3rd_Last_NextAppmt_Date_within_24_month,
MAX(CASE WHEN Occ = 4 THEN LastPickupDate ELSE 0 END) AS 4th_Date_Last_Pickup_within_24_month,
MAX(CASE WHEN Occ = 4 THEN CurrentARTReg ELSE NULL END) AS 4th_Last_Date_Pickup_within_24_month,
MAX(CASE WHEN Occ = 4 THEN DaysOfARVRefill ELSE NULL END) AS 4th_Last_Drug_Duration_within_24_month,
MAX(CASE WHEN Occ = 4 THEN NextAppmt ELSE 0 END) AS 4th_Last_NextAppmt_Date_within_24_month,
MAX(CASE WHEN Occ = 5 THEN LastPickupDate ELSE 0 END) AS 5th_Date_Last_Pickup_within_24_month,
MAX(CASE WHEN Occ = 5 THEN CurrentARTReg ELSE NULL END) AS 5th_Last_Date_Pickup_within_24_month,
MAX(CASE WHEN Occ = 5 THEN DaysOfARVRefill ELSE NULL END) AS 5th_Last_Drug_Duration_within_24_month,
MAX(CASE WHEN Occ = 5 THEN NextAppmt ELSE 0 END) AS 5th_Last_NextAppmt_Date_within_24_month,
MAX(CASE WHEN Occ = 6 THEN LastPickupDate ELSE 0 END) AS 6th_Date_Last_Pickup_within_24_month,
MAX(CASE WHEN Occ = 6 THEN CurrentARTReg ELSE NULL END) AS 6th_Last_Date_Pickup_within_24_month,
MAX(CASE WHEN Occ = 6 THEN DaysOfARVRefill ELSE NULL END) AS 6th_Last_Drug_Duration_within_24_month,
MAX(CASE WHEN Occ = 6 THEN NextAppmt ELSE 0 END) AS 6th_Last_NextAppmt_Date_within_24_month,
MAX(CASE WHEN Occ = 7 THEN LastPickupDate ELSE 0 END) AS 7th_Date_Last_Pickup_within_24_month,
MAX(CASE WHEN Occ = 7 THEN CurrentARTReg ELSE NULL END) AS 7th_Last_Date_Pickup_within_24_month,
MAX(CASE WHEN Occ = 7 THEN DaysOfARVRefill ELSE NULL END) AS 7th_Last_Drug_Duration_within_24_month,
MAX(CASE WHEN Occ = 7 THEN NextAppmt ELSE 0 END) AS 7th_Last_NextAppmt_Date_within_24_month,
MAX(CASE WHEN Occ = 8 THEN LastPickupDate ELSE 0 END) AS 8th_Date_Last_Pickup_within_24_month,
MAX(CASE WHEN Occ = 8 THEN CurrentARTReg ELSE NULL END) AS 8th_Last_Date_Pickup_within_24_month,
MAX(CASE WHEN Occ = 8 THEN DaysOfARVRefill ELSE NULL END) AS 8th_Last_Drug_Duration_within_24_month,
MAX(CASE WHEN Occ = 8 THEN NextAppmt ELSE 0 END) AS 8th_Last_NextAppmt_Date_within_24_month,
MAX(CASE WHEN Occ = 9 THEN LastPickupDate ELSE 0 END) AS 9th_Date_Last_Pickup_within_24_month,
MAX(CASE WHEN Occ = 9 THEN CurrentARTReg ELSE NULL END) AS 9th_Last_Date_Pickup_within_24_month,
MAX(CASE WHEN Occ = 9 THEN DaysOfARVRefill ELSE NULL END) AS 9th_Last_Drug_Duration_within_24_month,
MAX(CASE WHEN Occ = 9 THEN NextAppmt ELSE 0 END) AS 9th_Last_NextAppmt_Date_within_24_month,
MAX(CASE WHEN Occ = 10 THEN LastPickupDate ELSE 0 END) AS 10th_Date_Last_Pickup_within_24_month,
MAX(CASE WHEN Occ = 10 THEN CurrentARTReg ELSE NULL END) AS 10th_Last_Date_Pickup_within_24_month,
MAX(CASE WHEN Occ = 10 THEN DaysOfARVRefill ELSE NULL END) AS 410th_Last_Drug_Duration_within_24_month,
MAX(CASE WHEN Occ = 10 THEN NextAppmt ELSE 0 END) AS 10th_Last_NextAppmt_Date_within_24_month,
MAX(CASE WHEN Occ = 11 THEN LastPickupDate ELSE 0 END) AS 11th_Date_Last_Pickup_within_24_month,
MAX(CASE WHEN Occ = 11 THEN CurrentARTReg ELSE NULL END) AS 11th_Last_Date_Pickup_within_24_month,
MAX(CASE WHEN Occ = 11 THEN DaysOfARVRefill ELSE NULL END) AS 11th_Last_Drug_Duration_within_24_month,
MAX(CASE WHEN Occ = 11 THEN NextAppmt ELSE 0 END) AS 11th_Last_NextAppmt_Date_within_24_month
FROM

(SELECT * FROM (
SELECT a.patient_id, g.`identifier` PEPID, LastPickupDate,  a.Occ,
b.DaysOfARVRefill, (a.LastPickupDate + INTERVAL (b.DaysOfARVRefill) DAY) AS NextAppmt, e.CurrentARTReg, c.Date_of_Termination,
PERIOD_DIFF(DATE_FORMAT(c.Date_of_Termination, '%Y%m'), DATE_FORMAT(a.LastPickupDate, '%Y%m')) AS months
FROM (SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, 
e.`encounter_datetime` LastPickupDate, e.`encounter_id`
FROM `encounter` e,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND e.`voided` = 0 
ORDER BY e.patient_id, e.`encounter_datetime` DESC) a
#ART Refill Duration
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, o.`value_numeric` DaysOfARVRefill FROM `obs` o WHERE o.concept_id = 159368 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id = 162240 AND `voided` = 0) GROUP BY o.encounter_id) b ON a.encounter_id = b.encounter_id 
#Pharm Next Pickup
#LEFT JOIN (SELECT person_id, `value_datetime` Next_Pickup_Date, encounter_id FROM obs WHERE concept_id = 5096 AND `voided` = 0) d ON d.encounter_id=a.encounter_id
/*Last ARV_Medication*/
LEFT JOIN (SELECT o.encounter_id, o.`value_coded`, ConceptName(o.`value_coded`) CurrentARTReg FROM `obs` o 
WHERE `concept_id` IN (164506, 164507, 164513, 164514, 165702, 165703) AND o.`voided` = 0 AND obs_group_id IS NULL) e ON e.encounter_id=a.encounter_id

LEFT JOIN `patient_identifier` g ON a.`patient_id` = g.`patient_id` AND g.`voided`=0 AND g.`identifier_type` = 4

LEFT JOIN (SELECT a.`person_id`, a.Reason_for_Termination, b.Date_of_Termination, DATE_SUB(b.Date_of_Termination, INTERVAL 24 MONTH) Last_24_Month_Ago
FROM(SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_for_Termination', `obs_datetime`, o.`encounter_id` FROM obs o 
WHERE concept_id = 165470 AND value_coded =165889 AND o.voided=0) a
LEFT JOIN (SELECT  `value_datetime` AS 'Date_of_Termination', o.`encounter_id` FROM obs o 
WHERE concept_id = 165469 AND o.voided=0) b ON a.encounter_id=b.encounter_id) c ON a.patient_id=c.person_id

WHERE a.Occ BETWEEN 1 AND 15 AND a.`LastPickupDate` <= c.Date_of_Termination) a 
WHERE a.months <= 24
GROUP BY patient_id, PEPID, LastPickupDate) a GROUP BY patient_id) p ON a.person_id = p.patient_id

GROUP BY a.person_id

