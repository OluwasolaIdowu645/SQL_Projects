SELECT q.PEPID, a.patient_id, a. LastPickupDate, b.DaysOfARVRefill, e.CurrentARTReg, n.CurrentRegLine, o.Base_Capture_Date, p.Recapture_Date, p.`Recapture_count`
FROM (SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, 
e.`encounter_datetime` LastPickupDate, e.`encounter_id`
FROM `encounter` e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND e.`voided` = 0 AND e.`encounter_datetime` <= CURDATE() 
ORDER BY e.patient_id, e.`encounter_datetime` DESC) a
#ART Refill Duration
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, o.`value_numeric` DaysOfARVRefill FROM `obs` o WHERE o.concept_id = 159368 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id = 162240 AND `voided` = 0) GROUP BY o.encounter_id) b ON a.encounter_id = b.encounter_id 
#Pill Balance Field
LEFT JOIN (SELECT person_id, CAST(`value_text` AS UNSIGNED) Pill_Balance, encounter_id FROM obs WHERE concept_id = 166406 AND `voided` = 0) c ON c.encounter_id=a.encounter_id
/*Last ARV_Medication*/
LEFT JOIN (SELECT o.encounter_id, o.`value_coded`, ConceptName(o.`value_coded`) CurrentARTReg FROM `obs` o 
WHERE `concept_id` IN (164506, 164507, 164513, 164514, 165702, 165703) AND o.`voided` = 0 AND obs_group_id IS NULL) e ON e.encounter_id=a.encounter_id
/*Last CurrentRegimenLine*/
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_datetime`, o.`value_coded`, ConceptName(o.`value_coded`) CurrentRegLine  FROM `obs` o 
WHERE o.`concept_id` = 165708 AND o.`voided` = 0) n ON n.encounter_id=a.encounter_id 
LEFT JOIN (SELECT `patient_Id`, `date_created` Base_Capture_Date FROM `biometricinfo` GROUP BY `patient_Id`) o ON a.patient_Id=o.patient_Id
LEFT JOIN (SELECT `patient_Id`, `date_created` Recapture_Date,`Recapture_count` FROM `biometricverificationinfo` GROUP BY `patient_Id`)p ON a.patient_Id=p.patient_Id
 LEFT JOIN (SELECT `patient_Id`, `identifier` PEPID FROM `patient_identifier` WHERE `identifier_type`=4 AND `voided`=0) q ON p.patient_Id=q.patient_Id

WHERE a.Occ = 1;


