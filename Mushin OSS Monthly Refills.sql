DELIMITER $$
DROP FUNCTION IF EXISTS `ConceptName`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ConceptName`(conceptid INT) 
RETURNS TEXT CHARSET latin1 READS SQL DATA DETERMINISTIC BEGIN RETURN 
(SELECT NAME FROM  concept_name  WHERE concept_id = conceptid 
AND locale = 'en' AND locale_preferred = 1 LIMIT 1);END$$ 
DELIMITER ;


SELECT a.patient_id, p2.`identifier` Pepid, p3.`identifier` Hospital_No, f1.`family_name` Surname, f1.`given_name` FirstName, c1.`gender` Sex, a. LastPickupDate, a.`encounter_id`, b.DaysOfARVRefill, c.Pill_Balance, d.Next_Pickup_Date, e.CurrentARTReg, n.CurrentRegLine /*g.ARV_Drug_Strength,
h.OI_Drug_CTX, j.CTX_Strength, i.OI_Drug_INH, k.INH_Strength, l.DSD_Model, m.DDD_Fac_Disp,*/
FROM (SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, 
e.`encounter_datetime` LastPickupDate, e.`encounter_id`
FROM `encounter` e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND e.`voided` = 0 AND e.`encounter_datetime` BETWEEN "2022-09-01" AND "2022-09-31"
ORDER BY e.patient_id, e.`encounter_datetime` DESC) a
#ART Refill Duration
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, o.`value_numeric` DaysOfARVRefill FROM `obs` o WHERE o.concept_id = 159368 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id = 162240 AND `voided` = 0) GROUP BY o.encounter_id) b ON a.encounter_id = b.encounter_id 
#Pill Balance Field
LEFT JOIN (SELECT person_id, CAST(`value_text` AS UNSIGNED) Pill_Balance, encounter_id FROM obs WHERE concept_id = 166406 AND `voided` = 0) c ON c.encounter_id=a.encounter_id
#Pharm Next Pickup
LEFT JOIN (SELECT person_id, `value_datetime` Next_Pickup_Date, encounter_id FROM obs WHERE concept_id = 5096 AND `voided` = 0) d ON d.encounter_id=a.encounter_id
/*Last ARV_Medication*/
LEFT JOIN (SELECT o.encounter_id, o.`value_coded`, ConceptName(o.`value_coded`) CurrentARTReg FROM `obs` o 
WHERE `concept_id` IN (164506, 164507, 164513, 164514, 165702, 165703) AND o.`voided` = 0 AND obs_group_id IS NULL) e ON e.encounter_id=a.encounter_id
/*Last CurrentRegimenLine*/
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_datetime`, ConceptName(o.`value_coded`) CurrentRegLine  FROM `obs` o
WHERE o.`concept_id` = 165708 AND o.`voided` = 0) f ON f.encounter_id=a.encounter_id
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_datetime`, o.`value_coded`, ConceptName(o.`value_coded`) CurrentRegLine  FROM `obs` o 
WHERE o.`concept_id` = 165708 AND o.`voided` = 0) n ON n.encounter_id=a.encounter_id
LEFT JOIN `patient_identifier` p2 ON a.`patient_id` = p2.`patient_id` AND p2.`identifier_type` = 4
LEFT JOIN `patient_identifier` p3 ON a.`patient_id` = p3.`patient_id` AND p3.`identifier_type` = 5
LEFT JOIN `person_name` f1 ON a.`patient_id`=f1.`person_id` AND f1.`voided`=0
LEFT JOIN `person` c1 ON a.`patient_id`=c1.`person_id` AND c1.`voided`=0
WHERE a.Occ = 1;
