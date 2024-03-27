-- =================================
-- Create ART Commencement Form If Missing
-- =========================================
SET FOREIGN_KEY_CHECKS = 0 ;
UPDATE visit SET void_reason = NULL WHERE void_reason = 'visit';
UPDATE encounter SET void_reason = NULL WHERE void_reason = 'encounter';

SET SQL_MODE='ALLOW_INVALID_DATES';
INSERT INTO visit (patient_id,visit_type_id,date_started,date_stopped,location_id,creator,date_created,voided,UUID,void_reason)
SELECT Tb3.patient_id,1,Tb3.encounter_datetime,Tb3.encounter_datetime,8,1,Tb3.encounter_datetime,0,UUID(),'visit'

FROM
(SELECT patient_id, identifier FROM patient_identifier WHERE identifier_type = 4 AND voided = 0) AS Tb1

LEFT JOIN

(SELECT DISTINCT E.identifier,A.patient_id, A.encounter_datetime AS Care_Card_Visit,DATE_FORMAT(B.value_datetime,'%Y-%m-%d')  AS ARTStartDate 
FROM
(SELECT DISTINCT patient_id, encounter_id,encounter_type,form_id, encounter_datetime FROM encounter WHERE encounter_type = 25 AND voided = 0) AS A
INNER JOIN
(SELECT obs_id, person_id, concept_id, encounter_id,order_id, obs_datetime,location_id, value_datetime FROM obs WHERE concept_id = 159599 AND voided =0) AS B
ON  A.patient_id = B.person_id 
INNER JOIN
(SELECT patient_id, identifier FROM patient_identifier WHERE identifier_type = 4 AND voided =0) AS e
ON A.patient_id = e.patient_id
) AS Tb2
ON Tb1.identifier = Tb2.identifier

LEFT JOIN

(SELECT patient_identifier.identifier,patient_identifier.patient_id , MIN(encounter.encounter_datetime) AS encounter_datetime FROM encounter,patient_identifier WHERE encounter.encounter_type = 13 AND patient_identifier.`identifier_type` = 4 AND encounter.`voided`=0 AND patient_identifier.`voided`=0 AND encounter.`patient_id` = patient_identifier.`patient_id` GROUP BY patient_id) AS Tb3
ON Tb1.identifier = Tb3.identifier
WHERE Tb2.ARTStartDate IS NULL AND (Tb3.encounter_datetime <> '' OR Tb3.encounter_datetime IS NOT NULL);
#---------------- Insert ART Commencement into Encounter ------------------
INSERT INTO encounter (encounter_type,patient_id,location_id,form_id,encounter_datetime,creator,date_created,voided,visit_id,UUID,void_reason)
SELECT 25,patient_id,8,56,date_started,1,date_started,0,visit_id,UUID(),'encounter' FROM visit WHERE void_reason = 'visit';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_datetime,creator,date_created,voided,UUID)
SELECT patient_id,159599,encounter_id,encounter_datetime,8,encounter_datetime,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason = 'encounter';

UPDATE visit SET void_reason = NULL WHERE void_reason = 'visit';
UPDATE encounter SET void_reason = NULL WHERE void_reason = 'encounter';

SET sql_mode='';
SET GLOBAL sql_mode='';
SET FOREIGN_KEY_CHECKS = 1;

-- FIX FOR ART START DATE MISSING IN COMMENCEMENT FORM

-- Create Temporary Table and Populates with the First Drug Pickup
-- -------------------------------------------
DROP TABLE IF EXISTS `ARTStartDate`;
CREATE TEMPORARY TABLE `ARTStartDate` AS
SELECT * FROM (
SELECT @row_number :=CASE WHEN @patient_id = patient_id THEN @row_number + 1 ELSE 1 END AS num, @patient_id := patient_id AS patient_id,
 encounter_datetime,encounter_id FROM encounter WHERE encounter_type = 13 AND voided = 0
ORDER BY patient_id, encounter_datetime ASC) AS Tb1 WHERE Tb1.num = 1;

DROP TABLE IF EXISTS `HIVEnrollment_ARTDate`;
CREATE TEMPORARY TABLE `HIVEnrollment_ARTDate` AS
SELECT HIVEnrollment.patient_id,HIVEnrollment.encounter_id,ART_StartDate.value_datetime ,ART_StartDate.concept_id FROM 

(SELECT patient_id,encounter_datetime,encounter_id ,voided FROM encounter WHERE encounter_type = 14  AND voided = 0) AS HIVEnrollment 
INNER JOIN
(SELECT person_id,encounter_id, value_datetime,concept_id
FROM obs WHERE concept_id = 159599 AND voided =0) AS ART_StartDate
ON HIVEnrollment.patient_id = ART_StartDate.person_id AND HIVEnrollment.encounter_id = ART_StartDate.encounter_id;



 -- Fix to update ART Start Date in ART Commencement Forms that have no ART Date using the documeneted ART Start Date In HIV Enrollment Form
 SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_datetime,creator,date_created,voided,UUID)
SELECT Tb1.patient_id,159599,Tb1.encounter_id,Tb2.value_datetime,8,Tb2.value_datetime,1,Tb2.value_datetime,0,UUID() FROM

(
SELECT A.patient_id, A.encounter_datetime, A.encounter_id,B.person_id, B.value_datetime, B.obs_datetime FROM 
(SELECT patient_id, encounter_datetime, encounter_id FROM encounter WHERE encounter_type = 25) AS A
LEFT JOIN
(SELECT person_id, value_datetime, obs_datetime, encounter_id FROM obs WHERE concept_id = 159599)AS B
ON A.patient_id = B.person_id AND A.encounter_id = B.encounter_id ) AS Tb1

LEFT JOIN

(SELECT * FROM HIVEnrollment_ARTDate) AS Tb2
 ON Tb1.patient_id = Tb2.patient_id 
 WHERE Tb1.value_datetime IS NULL AND Tb2.value_datetime IS NOT NULL;
 SET FOREIGN_KEY_CHECKS = 1;
 
 -- Fix to update ART Start Date in ART Commencement Forms that have no ART Date using the First Pharmacy Pickup
 SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_datetime,creator,date_created,voided,UUID)
SELECT Tb1.patient_id,159599,Tb1.encounter_id,Tb2.encounter_datetime,8,Tb2.encounter_datetime,1,Tb2.encounter_datetime,0,UUID() FROM

(
SELECT A.patient_id, A.encounter_datetime, A.encounter_id,B.person_id, B.value_datetime, B.obs_datetime FROM 
(SELECT patient_id, encounter_datetime, encounter_id FROM encounter WHERE encounter_type = 25) AS A
LEFT JOIN
(SELECT person_id, value_datetime, obs_datetime, encounter_id FROM obs WHERE concept_id = 159599)AS B
ON A.patient_id = B.person_id AND A.encounter_id = B.encounter_id ) AS Tb1

LEFT JOIN

(SELECT * FROM ARTStartDate) AS Tb2
 ON Tb1.patient_id = Tb2.patient_id 
 WHERE Tb1.value_datetime IS NULL AND Tb2.encounter_datetime IS NOT NULL;
 SET FOREIGN_KEY_CHECKS = 1;
 
 