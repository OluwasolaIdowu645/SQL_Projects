SET @FacilityName :=(SELECT `property_value` FROM `global_property` WHERE `property`= 'Facility_Name');
SET @DATIMCode :=(SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code');
SET @SurgeCommand := (SELECT SurgeCommand FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code'));
SET @LGA :=(SELECT LGA FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code'));
SET @State :=(SELECT State FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code'));
SELECT @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName, @DATIMCode, CONCAT(@DATIMCode,"_",p1.`identifier`)Pepid_datim, p1.`identifier` PEPID,
a.patient_id, a. LastPickupDate, a.`encounter_id`, b.DaysOfARVRefill, c.Pill_Balance, d.Next_Pickup_Date, e.CurrentARTReg, n.CurrentRegLine, g.ARV_Drug_Strength,
h.OI_Drug_CTX, j.CTX_Strength, i.OI_Drug_INH, k.INH_Strength, l.DSD_Model, m.DDD_Fac_Disp, o.PregStatus
FROM (SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, 
e.`encounter_datetime` LastPickupDate, e.`encounter_id`
FROM `encounter` e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND e.`voided` = 0 AND e.`encounter_datetime` <= @Reporting_Date 
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
#ARV Drug Strength
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_id`, GROUP_CONCAT(DISTINCT ConceptName(o.`value_coded`) SEPARATOR '-') ARV_Drug_Strength FROM `obs` o
WHERE o.concept_id = 165725 AND o.`voided` = 0 AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id = 162240 AND `voided` = 0) 
GROUP BY o.`encounter_id`) g ON g.encounter_id=a.encounter_id
#OI Drug CTX
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, ConceptName(o.`value_coded`) OI_Drug_CTX FROM `obs` o WHERE o.concept_id = 165727 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id = 165726 AND `voided` = 0) AND ConceptName(o.`value_coded`) LIKE 'CTX%') h ON h.encounter_id=a.encounter_id
#OI Drug INH
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, ConceptName(o.`value_coded`) OI_Drug_INH FROM `obs` o WHERE o.concept_id = 165727 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id = 165726 AND `voided` = 0 AND ConceptName(o.`value_coded`) LIKE 'IS%')) i ON i.encounter_id=a.encounter_id
#OI Drug Strength CTX
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, ConceptName(o.`value_coded`) CTX_Strength FROM `obs` o WHERE o.concept_id = 165725 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_group_id FROM obs WHERE value_coded = 165257 AND `voided` = 0))j ON j.encounter_id=a.encounter_id
#OI Drug Strength INH
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, ConceptName(o.`value_coded`) INH_Strength FROM `obs` o WHERE o.concept_id = 165725 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_group_id FROM obs WHERE value_coded = 1679 AND `voided` = 0))k ON k.encounter_id=a.encounter_id
#Differentiated Service Delivery Model 166148
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_group_id`,  ConceptName(o.`value_coded`) DSD_Model
FROM `obs` o WHERE o.`concept_id` = 166148 AND o.`voided` = 0) l ON l.encounter_id=a.encounter_id
#Facility Dispensing (166276) or DDD
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_group_id`,  ConceptName(o.`value_coded`) DDD_Fac_Disp
FROM `obs` o WHERE o.`concept_id` IN (166276, 166363) AND o.`voided` = 0) m ON m.encounter_id=a.encounter_id
/*Last CurrentRegimenLine*/
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_datetime`, o.`value_coded`, ConceptName(o.`value_coded`) CurrentRegLine  FROM `obs` o 
WHERE o.`concept_id` = 165708 AND o.`voided` = 0) n ON n.encounter_id=a.encounter_id
/*CIHP_PregStatus*/
LEFT JOIN (SELECT o.person_id, p.`gender`, o.encounter_id, ConceptName(o.`value_coded`) PregStatus FROM `obs` o 
LEFT JOIN `person` p ON p.`person_id`=o.`person_id` AND p.`voided`=0
WHERE o.`concept_id` = 165050 AND o.`voided` = 0 AND p.gender = 'F') o ON o.encounter_id=a.encounter_id
LEFT JOIN `patient_identifier` p1 ON a.`patient_id` = p1.`patient_id` AND p1.`identifier_type` = 4
WHERE a.Occ = 1;


  
  
SELECT o.`person_id`, ConceptName(o.`value_coded`) First_TLD,  MIN(`obs_datetime`) Date_of_First_TLD FROM obs o
LEFT JOIN  `encounter` e ON e.`patient_id`=o.`person_id`
WHERE `value_coded` =165681 AND e.`encounter_type` = 13 AND e.`form_id` = 27 
AND o.`voided` = 0 AND e.`encounter_datetime` <= @Reporting_Date GROUP BY `person_id`;



SELECT * FROM `obs` o
LEFT JOIN (SELECT o.`person_id`, ConceptName(o.`value_coded`) First_TLD,  MIN(`obs_datetime`) Date_of_First_TLD FROM obs o
LEFT JOIN  `encounter` e ON e.`patient_id`=o.`person_id`
WHERE `value_coded` =165681 AND e.`encounter_type` = 13 AND e.`form_id` = 27 
AND o.`voided` = 0 AND e.`encounter_datetime` <= @Reporting_Date GROUP BY `person_id`) a ON o.person_id=a.person_id
LEFT JOIN `encounter` e ON e.`encounter_id`=o.`encounter_id`
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND e.`voided` = 0 AND o.`obs_datetime` < a.Date_of_First_TLD
GROUP BY e.`patient_id`;



SET @Reporting_Date = '2023-02-01';
  