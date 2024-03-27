SELECT a.`patient_id`, CAST(a.`identifier` AS CHAR(8)) PEPID, b.Firstname, b.Surname, IF(c.patient_Id IS NOT NULL, 'Captured', NULL) PBS_Status
FROM `patient_identifier` a
LEFT JOIN (SELECT `person_id`, `given_name` Firstname, `family_name` Surname FROM `person_name`
WHERE `voided`=0) b ON a.`patient_id`=b.person_id
LEFT JOIN (SELECT `patient_Id` FROM `biometricinfo` GROUP BY patient_Id) c 
ON a.`patient_id`=c.patient_id
WHERE `identifier_type` = 4 AND `voided`=0;


162730 NEXT of kin details
164943 NEXT Of Kin Relationship
164946 NEXT Of Kin Phone Number
162729 NEXT of kin NAME
166462 NEXT of kin contact;


SELECT a.`patient_id`,b.Next_of_kin_Name, c.Next_Of_Kin_Relationship, d.Next_of_kin_Phone_No, e.KP_Type  FROM `encounter` a
LEFT JOIN (SELECT `person_id`, `value_text` Next_of_kin_Name FROM obs WHERE `concept_id` = 162729 AND `voided`=0) b ON a.`patient_id`=b.person_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) Next_Of_Kin_Relationship FROM obs WHERE `concept_id` = 164943 AND `voided`=0) c ON a.`patient_id`=c.person_id
LEFT JOIN (SELECT `person_id`, `value_text` Next_of_kin_Phone_No FROM obs WHERE `concept_id` = 159635 AND `voided`=0)d ON a.`patient_id`=d.person_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) KP_Type,value_coded FROM obs WHERE `concept_id` = 166369 AND `voided`=0) e ON a.`patient_id`=e.person_id
WHERE a.`encounter_type`=14 AND a.`form_id`=23 AND a.`voided`=0;