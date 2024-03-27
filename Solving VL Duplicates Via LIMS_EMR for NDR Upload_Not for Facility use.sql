
SELECT o.`obs_id`,o.`person_id`,`ConceptName`(o.`concept_id`) AS Concept_Name,o.`encounter_id`,e.`encounter_datetime`,o.`obs_datetime`,o.`value_numeric`,
@row_no := IF(@prev_val = o.`concept_id`AND @id=o.`person_id`, @row_no + 1, 1) AS Occurrence, @prev_val := o.`concept_id` AS concept_id, @id := o.`person_id`,`value_datetime`
FROM obs o
LEFT JOIN `encounter` e ON o.encounter_id=e.encounter_id,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y, (SELECT @id := '') Z
WHERE e.`encounter_type`=11 AND o.`obs_datetime` >= '2021-04-01' AND o.voided = 0 AND o.`person_id` IN 


(90)



ORDER BY o.person_id,o.`concept_id`, o.`obs_datetime`  DESC;


-------------------------------------------------------------------------------------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS=0;
DELETE FROM obs WHERE obs_id IN (
SELECT obs_id FROM (
SELECT o.`obs_id`,o.`person_id`,`ConceptName`(o.`concept_id`) AS Concept_Name,o.`encounter_id`,e.`encounter_datetime`,o.`obs_datetime`,o.`value_numeric`,
@row_no := IF(@prev_val = o.`concept_id`AND @id=o.`person_id`, @row_no + 1, 1) AS Occurrence, @prev_val := o.`concept_id` AS concept_id, @id := o.`person_id`,`value_datetime`
FROM obs o
LEFT JOIN `encounter` e ON o.encounter_id=e.encounter_id,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y, (SELECT @id := '') Z
WHERE e.`encounter_type`=11 AND o.`obs_datetime` >= '2021-04-01' AND o.voided = 0 AND o.`person_id` IN 


(9)



ORDER BY o.person_id,o.`concept_id`, o.`obs_datetime`  DESC)a WHERE a.Occurrence >1);
SET FOREIGN_KEY_CHECKS=1;