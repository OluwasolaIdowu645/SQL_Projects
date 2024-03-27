#Search all Visit relating to the ID on the “Visit” table using
SELECT * FROM `visit` WHERE `patient_id` =1578;

#Trace each “Visit_id” to its encounter using 
SELECT * FROM encounter WHERE visit_id IN (SELECT visit_id FROM `visit` WHERE `patient_id` =1578);

#Streamline query using the identified Visit_id from step 4 with 
SELECT `encounter_id`, `patient_id`, `encounter_type`,`form_id`, `encounter_datetime`,`visit_id` FROM `encounter` WHERE `visit_id` =47414;

#The “Visit” table was queried while relating to the “Encounter” table using the query below
DROP TABLE IF EXISTS affected_Id;
CREATE TEMPORARY TABLE affected_Id AS
SELECT e.`patient_id` Share_PID, e.`visit_id`, b.`patient_id` Orignal_PID, 
b.`date_started` VisitDate, e.`encounter_datetime`, e.`encounter_id`, p.`identifier` FROM visit b 
LEFT JOIN  `encounter` e ON e.`visit_id`=b.`visit_id` 
LEFT JOIN `patient_identifier` p ON b.`patient_id`=p.`patient_id` AND p.`voided`=0 AND p.`identifier_type`=4
WHERE b.`patient_id`!=e.`patient_id`;


#Identifying all observation associated with the displaced and muddled Patient_IDs
SELECT `obs_id`, `person_id`, `encounter_id` FROM `obs` WHERE `person_id` IN (SELECT e.`patient_id` FROM visit b 
LEFT JOIN  `encounter` e ON e.`visit_id`=b.`visit_id` 
WHERE b.`patient_id`!=e.`patient_id`) AND `encounter_id` IN (SELECT e.`encounter_id` FROM visit b 
LEFT JOIN  `encounter` e ON e.`visit_id`=b.`visit_id` 
WHERE b.`patient_id`!=e.`patient_id`);


SET FOREIGN_KEY_CHECKS = 0; 
#Delete all observations of muddled Patient_IDs from the obs table
DELETE obs FROM `obs`
LEFT JOIN affected_Id a ON a.Share_PID=obs.`person_id` AND a.encounter_id=obs.`encounter_id`
WHERE a.Share_PID=obs.`person_id` AND a.encounter_id=obs.`encounter_id`;

#Delete all Encounter of muddled Patient_IDs from the Encounter table
DELETE `encounter` FROM `encounter`
LEFT JOIN affected_Id a ON a.Share_PID=encounter.`patient_id` AND a.encounter_id=encounter.`encounter_id`
WHERE a.Share_PID=encounter.`patient_id` AND a.encounter_id=encounter.`encounter_id`;



SELECT `obs_id` FROM `obs` WHERE `person_id` IN (SELECT e.`patient_id` FROM visit b 
LEFT JOIN  `encounter` e ON e.`visit_id`=b.`visit_id` 
WHERE b.`patient_id`!=e.`patient_id`;

SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 1;



