SELECT e.`patient_id`, e.`encounter_datetime` Testing_Date, p.`identifier` Client_Code, 
e.`date_created`, LEFT(pn.`family_name`,5) Surname, pn.`given_name` First_Name
FROM `encounter` e
LEFT JOIN patient_identifier p ON e.`patient_id`= p.`patient_id` AND p.identifier_type=8 AND p.`voided`=0
LEFT JOIN `person_name` pn ON e.`patient_id`=pn.`person_id` AND pn.`voided`=0
WHERE e.`encounter_type`=20 AND e.`voided`=0 AND e.`date_created` >= '2023-10-10%';