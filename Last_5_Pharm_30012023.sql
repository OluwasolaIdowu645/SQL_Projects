
DROP TABLE IF EXISTS Drug_Accumulation;
CREATE TEMPORARY TABLE Drug_Accumulation AS
SELECT * FROM (
SELECT a.Occ, a.patient_id, g.`identifier` PEPID, LastPickupDate, b.DaysOfARVRefill, (a.LastPickupDate + INTERVAL (b.DaysOfARVRefill) DAY) AS NextAppmt
FROM (SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, 
e.`encounter_datetime` LastPickupDate, e.`encounter_id`
FROM `encounter` e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND e.`voided` = 0 AND e.encounter_datetime < '2023-01-01 00:00:00.000000'
ORDER BY e.patient_id, e.`encounter_datetime` DESC) a
#ART Refill Duration
LEFT JOIN (SELECT o.`person_id`, o.encounter_id, o.`obs_id`, o.`value_numeric` DaysOfARVRefill FROM `obs` o WHERE o.concept_id = 159368 AND o.`voided` = 0
AND obs_group_id IN (SELECT obs_id FROM obs WHERE concept_id = 162240 AND `voided` = 0) GROUP BY o.encounter_id) b ON a.encounter_id = b.encounter_id 
#Pharm Next Pickup
LEFT JOIN (SELECT person_id, `value_datetime` Next_Pickup_Date, encounter_id FROM obs WHERE concept_id = 5096 AND `voided` = 0) d ON d.encounter_id=a.encounter_id
/*Last ARV_Medication*/
LEFT JOIN (SELECT o.encounter_id, o.`value_coded`, ConceptName(o.`value_coded`) CurrentARTReg FROM `obs` o 
WHERE `concept_id` IN (164506, 164507, 164513, 164514, 165702, 165703) AND o.`voided` = 0 AND obs_group_id IS NULL) e ON e.encounter_id=a.encounter_id
/*Last CurrentRegimenLine*/
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_datetime`, ConceptName(o.`value_coded`) CurrentRegLine  FROM `obs` o
WHERE o.`concept_id` = 165708 AND o.`voided` = 0) f ON f.encounter_id=a.encounter_id
/*Last CurrentRegimenLine*/
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, o.`obs_datetime`, o.`value_coded`, ConceptName(o.`value_coded`) CurrentRegLine  FROM `obs` o 
WHERE o.`concept_id` = 165708 AND o.`voided` = 0) n ON n.encounter_id=a.encounter_id
LEFT JOIN `patient_identifier` g ON a.`patient_id` = g.`patient_id` AND g.`voided`=0 AND g.`identifier_type` = 4
WHERE a.Occ BETWEEN 1 AND 5) a GROUP BY patient_id, PEPID, LastPickupDate;
DROP TABLE IF EXISTS Drug_Accumulation1;CREATE TEMPORARY TABLE Drug_Accumulation1 AS SELECT * FROM Drug_Accumulation WHERE occ=1;
DROP TABLE IF EXISTS Drug_Accumulation2;CREATE TEMPORARY TABLE Drug_Accumulation2 AS SELECT * FROM Drug_Accumulation WHERE occ=2;
DROP TABLE IF EXISTS Drug_Accumulation3;CREATE TEMPORARY TABLE Drug_Accumulation3 AS SELECT * FROM Drug_Accumulation WHERE occ=3;
DROP TABLE IF EXISTS Drug_Accumulation4;CREATE TEMPORARY TABLE Drug_Accumulation4 AS SELECT * FROM Drug_Accumulation WHERE occ=4;
DROP TABLE IF EXISTS Drug_Accumulation5;CREATE TEMPORARY TABLE Drug_Accumulation5 AS SELECT * FROM Drug_Accumulation WHERE occ=5;
SELECT (SELECT `property_value`FROM`global_property`WHERE `property`= 'Facility_Name') FacilityName, 
(SELECT`property_value`FROM`global_property`WHERE `property`= 'facility_datim_code')AS DatimCode,
CONCAT(a.pepid,'-',(SELECT`property_value`FROM`global_property`WHERE `property`= 'facility_datim_code'))Pepid_Datim, a.patient_id, a.PEPID, a.LastPickupDate 1_LastPickupDate, a.DaysOfARVRefill 1_DaysOfARVRefill, a.NextAppmt 1_NextAppmt,
b.LastPickupDate 2_LastPickupDate, b.DaysOfARVRefill 2_DaysOfARVRefill, b.NextAppmt 2_NextAppmt,
c.LastPickupDate 3_LastPickupDate, c.DaysOfARVRefill 3_DaysOfARVRefill, c.NextAppmt 3_NextAppmt,
d.LastPickupDate 4_LastPickupDate, d.DaysOfARVRefill 4_DaysOfARVRefill, d.NextAppmt 4_NextAppmt,
e.LastPickupDate 5_LastPickupDate, e.DaysOfARVRefill 5_DaysOfARVRefill, e.NextAppmt 5_NextAppmt#, datediff(e.NextAppmt,d.LastPickupDate)ddd
FROM Drug_Accumulation1 a
LEFT JOIN Drug_Accumulation2 b ON b.pepid=a.pepid
LEFT JOIN Drug_Accumulation3 c ON c.pepid=a.pepid
LEFT JOIN Drug_Accumulation4 d ON d.pepid=a.pepid
LEFT JOIN Drug_Accumulation5 e ON e.pepid=a.pepid;


