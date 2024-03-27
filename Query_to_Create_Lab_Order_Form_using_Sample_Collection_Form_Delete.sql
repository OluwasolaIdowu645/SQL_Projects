-- =============================================
-- Author: CIHP
-- Modified date: 09/08/2021
-- Description:Query to Create Lab Order Form using Sample Collection Form & Delete Sample collectionForm
-- =============================================
-- =======================================================================
-- Query To Create Lab order form with only Sample collection Filled For clients with only Sample collection Form
-- ========================================================================


SET SQL_MODE='ALLOW_INVALID_DATES';
SET FOREIGN_KEY_CHECKS = 1;

-- Create the encounter for the Lab order form for empty sample collection using the sample collection of  sample collection form

UPDATE encounter SET void_reason = NULL WHERE void_reason = 'encounter';

INSERT INTO encounter (encounter_type,patient_id,location_id,form_id,encounter_datetime,creator,date_created,voided,visit_id,UUID,void_reason)
SELECT 11,A.patient_id,8,21,A.value_datetime,1,A.value_datetime,0,A.visit_id,UUID(),'encounter' 
FROM 
(SELECT Tb1.patient_id,Tb1.`value_datetime`, Tb1.`visit_id` FROM
(SELECT A.patient_id,B.`value_datetime`,A.`encounter_id` , A.`visit_id` FROM encounter AS A, obs AS B WHERE encounter_type = 31
AND A.`encounter_id` = B.`encounter_id` AND A.`patient_id` = B.`person_id` AND B.`concept_id` = 159951) AS Tb1

INNER JOIN

(SELECT * FROM visit) AS Tb2
ON Tb1.patient_id = Tb2.patient_id AND  Tb1.visit_id = Tb2.visit_id) AS A
LEFT JOIN
(SELECT A.patient_id, B.`value_datetime`  FROM encounter AS A, obs AS B WHERE encounter_type = 11
AND A.`encounter_id` = B.`encounter_id` AND A.`patient_id` = B.`person_id` AND B.`concept_id` = 159951) AS B
ON A.patient_id = B.patient_id AND A.value_datetime = B.value_datetime
WHERE A.value_datetime IS NOT NULL AND B.value_datetime IS NULL;
SET FOREIGN_KEY_CHECKS = 1;
-- -------------------------------------------------------------------------------
-- Select all the observations and inserts in the Obs Table
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165765,encounter_id,encounter_datetime,8,2,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason = 'encounter';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_text,creator,date_created,voided,UUID)
SELECT A.patient_id,165715,A.encounter_id,A.encounter_datetime,8,B.identifier,1,A.encounter_datetime,0,UUID() FROM encounter AS A, patient_identifier AS B WHERE 
A.patient_id = B.patient_id AND A.voided = 0 AND B.voided = 0 AND B.identifier_type = 4 AND A.void_reason = 'encounter';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,162476,encounter_id,encounter_datetime,8,1000,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason = 'encounter';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,164980,encounter_id,encounter_datetime,8,161236,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason = 'encounter';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_datetime,creator,date_created,voided,UUID)
SELECT patient_id,159951,encounter_id,encounter_datetime,8,encounter_datetime,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason = 'encounter';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_datetime,creator,date_created,voided,UUID)
SELECT patient_id,164989,encounter_id,encounter_datetime,8,encounter_datetime,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason = 'encounter';

UPDATE encounter SET void_reason = NULL WHERE void_reason = 'encounter';

SET sql_mode='';
SET GLOBAL sql_mode='';
SET FOREIGN_KEY_CHECKS = 1;


-- =============================================
-- Void Sample Collection that Have Laboratory Filled
SET FOREIGN_KEY_CHECKS = 0;
UPDATE
  encounter AS encount
  INNER JOIN (
SELECT A.patient_id,A.`value_datetime`, A.`visit_id` ,A.SampleColct_EncouterID
FROM 
(SELECT Tb1.patient_id,Tb1.`value_datetime`, Tb1.`visit_id` ,Tb1.SampleColct_EncouterID FROM
(SELECT A.patient_id,A.encounter_id AS SampleColct_EncouterID,B.encounter_id AS SampleColct_OBSencouterID,B.`value_datetime`,A.`encounter_id` , A.`visit_id` FROM encounter AS A, obs AS B WHERE encounter_type = 31
AND A.`encounter_id` = B.`encounter_id` AND A.`patient_id` = B.`person_id` AND B.`concept_id` = 159951) AS Tb1

INNER JOIN

(SELECT * FROM visit) AS Tb2
ON Tb1.patient_id = Tb2.patient_id AND  Tb1.visit_id = Tb2.visit_id) AS A
LEFT JOIN
(SELECT A.patient_id, B.`value_datetime`  FROM encounter AS A, obs AS B WHERE encounter_type = 11
AND A.`encounter_id` = B.`encounter_id` AND A.`patient_id` = B.`person_id` AND B.`concept_id` = 159951) AS B
ON A.patient_id = B.patient_id AND A.value_datetime = B.value_datetime
WHERE A.value_datetime IS NOT NULL AND B.value_datetime IS NOT NULL) 

AS eencount ON  encount.`patient_id`= eencount.`patient_id` AND eencount.SampleColct_EncouterID = encount.encounter_id
SET encount.voided = 3;
SET FOREIGN_KEY_CHECKS = 1;

-- ========================================
-- Void Sample Collection observations that Have Laboratory Filled
SET FOREIGN_KEY_CHECKS = 0;
UPDATE
  obs AS obs1
  INNER JOIN (
SELECT VoidedEncounter.patient_id, VoidedEncounter.encounter_id ,obss.person_id,obss.concept_id FROM
(SELECT patient_id, encounter_id FROM encounter WHERE encounter_type = 31 AND voided = 3) AS VoidedEncounter
INNER JOIN
(SELECT person_id,concept_id, encounter_id FROM obs ) AS obss
ON VoidedEncounter.patient_id = obss.`person_id` AND VoidedEncounter.encounter_id = obss.encounter_id
) AS obs2
ON obs2.patient_id = obs1.`person_id` AND  obs2.encounter_id = obs1.encounter_id
SET obs1.voided = 3;
SET FOREIGN_KEY_CHECKS = 1;

-- ===========================
-- Delete encounters and observation with voided = 3  

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM encounter WHERE voided = 3;
DELETE FROM obs WHERE voided = 3;
SET FOREIGN_KEY_CHECKS = 1;

