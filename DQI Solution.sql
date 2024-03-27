#Using the same Identifier within a Patient ID
SELECT * FROM (
SELECT `patient_identifier_id`, `patient_id`, `identifier`, `identifier_type`, COUNT(`identifier`) Repeat_Count, GROUP_CONCAT(`identifier_type` SEPARATOR ', ' )
FROM `patient_identifier` WHERE `voided` = 0 GROUP BY `identifier`, `patient_id`) a WHERE Repeat_Count>1;


#Using the same Identifier for multiple Patient ID
SELECT * FROM(
SELECT COUNT(`identifier`) PID_Repeat_Count, GROUP_CONCAT(`patient_id` SEPARATOR ', ')  Affected_ID, `patient_id`,`identifier` FROM (
SELECT `patient_identifier_id`, `patient_id`,`identifier`, `identifier_type`, GROUP_CONCAT(`identifier_type` SEPARATOR ', ')
FROM `patient_identifier` WHERE `voided` = 0 GROUP BY patient_id, `identifier`)a GROUP BY `identifier`)b WHERE PID_Repeat_Count>2;


#ARTStart date > last pickupdate
SELECT p.`patient_id`, p.`identifier`, a.ARTStartDate, b.LastPickupDate, IF(a.ARTStartDate > b.LastPickupDate, "LastPickupDat is earlier than ARTStartDate", NULL) "Status"
FROM `patient_identifier` p 
LEFT JOIN(SELECT o.`person_id`, o.`value_datetime` AS ARTStartDate
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` 
WHERE o.`concept_id` = 159599 AND e.`encounter_type` = 25 AND e.`form_id` = 56 AND o.`voided`=0)a ON p.`patient_id`=a.person_id
LEFT JOIN(SELECT e.patient_id AS patient_id, MAX(e.`encounter_datetime`) LastPickupDate, e.`encounter_id`
FROM `encounter` e
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND e.`voided` = 0 GROUP BY e.patient_id) b ON p.`patient_id`=b.patient_id
WHERE p.`identifier_type`=4 AND p.`voided`=0
