
SET @FacilityName :=(SELECT `property_value`FROM `global_property`WHERE `property`= 'Facility_Name');
SET @DATIMCode :=(SELECT `property_value`FROM `global_property`WHERE `property`= 'facility_datim_code');
SET @SurgeCommand :=(SELECT SurgeCommand FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value`FROM `global_property`
WHERE `property`= 'facility_datim_code'));
SET @LGA :=(SELECT LGA FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value`FROM `global_property`
WHERE `property`= 'facility_datim_code'));
SET @State :=(SELECT State FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value`FROM `global_property`
WHERE `property`= 'facility_datim_code'));

DROP TABLE IF EXISTS Drug_Accumulation;
CREATE TEMPORARY TABLE Drug_Accumulation AS
SELECT * FROM (
SELECT a.patient_id, g.`identifier` PEPID, LastPickupDate,  a.Occ,
b.DaysOfARVRefill, (a.LastPickupDate + INTERVAL (b.DaysOfARVRefill) DAY) AS NextAppmt
FROM (SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occ, @prev_val := e.patient_id AS patient_id, 
e.`encounter_datetime` LastPickupDate, e.`encounter_id`
FROM `encounter` e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE e.`encounter_type` = 13 AND e.`form_id` = 27 AND e.`voided` = 0 AND e.encounter_datetime  >= '2019-10-01%' 
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
WHERE a.Occ BETWEEN 1 AND 17) a GROUP BY patient_id, PEPID, LastPickupDate;
DROP TABLE IF EXISTS Drug_Accumulation1;CREATE TEMPORARY TABLE Drug_Accumulation1 AS SELECT * FROM Drug_Accumulation WHERE occ=1;
DROP TABLE IF EXISTS Drug_Accumulation2;CREATE TEMPORARY TABLE Drug_Accumulation2 AS SELECT * FROM Drug_Accumulation WHERE occ=2;
DROP TABLE IF EXISTS Drug_Accumulation3;CREATE TEMPORARY TABLE Drug_Accumulation3 AS SELECT * FROM Drug_Accumulation WHERE occ=3;
DROP TABLE IF EXISTS Drug_Accumulation4;CREATE TEMPORARY TABLE Drug_Accumulation4 AS SELECT * FROM Drug_Accumulation WHERE occ=4;
DROP TABLE IF EXISTS Drug_Accumulation5;CREATE TEMPORARY TABLE Drug_Accumulation5 AS SELECT * FROM Drug_Accumulation WHERE occ=5;
DROP TABLE IF EXISTS Drug_Accumulation6;CREATE TEMPORARY TABLE Drug_Accumulation6 AS SELECT * FROM Drug_Accumulation WHERE occ=6;
DROP TABLE IF EXISTS Drug_Accumulation7;CREATE TEMPORARY TABLE Drug_Accumulation7 AS SELECT * FROM Drug_Accumulation WHERE occ=7;
DROP TABLE IF EXISTS Drug_Accumulation8;CREATE TEMPORARY TABLE Drug_Accumulation8 AS SELECT * FROM Drug_Accumulation WHERE occ=8;
DROP TABLE IF EXISTS Drug_Accumulation9;CREATE TEMPORARY TABLE Drug_Accumulation9 AS SELECT * FROM Drug_Accumulation WHERE occ=9;
DROP TABLE IF EXISTS Drug_Accumulation10;CREATE TEMPORARY TABLE Drug_Accumulation10 AS SELECT * FROM Drug_Accumulation WHERE occ=10;
DROP TABLE IF EXISTS Drug_Accumulation11;CREATE TEMPORARY TABLE Drug_Accumulation11 AS SELECT * FROM Drug_Accumulation WHERE occ=11;
DROP TABLE IF EXISTS Drug_Accumulation12;CREATE TEMPORARY TABLE Drug_Accumulation12 AS SELECT * FROM Drug_Accumulation WHERE occ=12;
DROP TABLE IF EXISTS Drug_Accumulation13;CREATE TEMPORARY TABLE Drug_Accumulation13 AS SELECT * FROM Drug_Accumulation WHERE occ=13;
DROP TABLE IF EXISTS Drug_Accumulation14;CREATE TEMPORARY TABLE Drug_Accumulation14 AS SELECT * FROM Drug_Accumulation WHERE occ=14;
DROP TABLE IF EXISTS Drug_Accumulation15;CREATE TEMPORARY TABLE Drug_Accumulation15 AS SELECT * FROM Drug_Accumulation WHERE occ=15;
DROP TABLE IF EXISTS Drug_Accumulation16;CREATE TEMPORARY TABLE Drug_Accumulation16 AS SELECT * FROM Drug_Accumulation WHERE occ=16;
DROP TABLE IF EXISTS Drug_Accumulation17;CREATE TEMPORARY TABLE Drug_Accumulation17 AS SELECT * FROM Drug_Accumulation WHERE occ=17;

SELECT 'CIHP' IP, @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName, 
CONCAT( a.PEPID, "-", @DATIMCode) Pepid_datim, a.patient_id, a.PEPID, 
a.LastPickupDate 1_LastPickupDate, a.DaysOfARVRefill 1_DaysOfARVRefill, a.NextAppmt 1_NextAppmt,
b.LastPickupDate 2_LastPickupDate, b.DaysOfARVRefill 2_DaysOfARVRefill, b.NextAppmt 2_NextAppmt,
c.LastPickupDate 3_LastPickupDate, c.DaysOfARVRefill 3_DaysOfARVRefill, c.NextAppmt 3_NextAppmt,
d.LastPickupDate 4_LastPickupDate, d.DaysOfARVRefill 4_DaysOfARVRefill, d.NextAppmt 4_NextAppmt,
e.LastPickupDate 5_LastPickupDate, e.DaysOfARVRefill 5_DaysOfARVRefill, e.NextAppmt 5_NextAppmt,
f.LastPickupDate 6_LastPickupDate, f.DaysOfARVRefill 6_DaysOfARVRefill, f.NextAppmt 6_NextAppmt,
g.LastPickupDate 7_LastPickupDate, g.DaysOfARVRefill 7_DaysOfARVRefill, g.NextAppmt 7_NextAppmt,
h.LastPickupDate 8_LastPickupDate, h.DaysOfARVRefill 8_DaysOfARVRefill, h.NextAppmt 8_NextAppmt,
i.LastPickupDate 9_LastPickupDate, i.DaysOfARVRefill 9_DaysOfARVRefill, i.NextAppmt 9_NextAppmt,
j.LastPickupDate 10_LastPickupDate, j.DaysOfARVRefill 10_DaysOfARVRefill, j.NextAppmt 10_NextAppmt,
k.LastPickupDate 11_LastPickupDate, k.DaysOfARVRefill 11_DaysOfARVRefill, k.NextAppmt 11_NextAppmt,
l.LastPickupDate 12_LastPickupDate, l.DaysOfARVRefill 12_DaysOfARVRefill, l.NextAppmt 12_NextAppmt,
m.LastPickupDate 13_LastPickupDate, m.DaysOfARVRefill 13_DaysOfARVRefill, m.NextAppmt 13_NextAppmt,
n.LastPickupDate 14_LastPickupDate, n.DaysOfARVRefill 14_DaysOfARVRefill, n.NextAppmt 14_NextAppmt,
o.LastPickupDate 15_LastPickupDate, o.DaysOfARVRefill 15_DaysOfARVRefill, o.NextAppmt 15_NextAppmt,
p.LastPickupDate 16_LastPickupDate, p.DaysOfARVRefill 16_DaysOfARVRefill, p.NextAppmt 16_NextAppmt,
q.LastPickupDate 17_LastPickupDate, q.DaysOfARVRefill 17_DaysOfARVRefill, q.NextAppmt 17_NextAppmt
FROM Drug_Accumulation1 a
LEFT JOIN Drug_Accumulation2 b ON b.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation3 c ON c.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation4 d ON d.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation5 e ON e.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation6 f ON f.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation7 g ON g.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation8 h ON h.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation9 i ON i.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation10 j ON j.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation11 k ON k.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation12 l ON l.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation13 m ON m.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation14 n ON n.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation15 o ON o.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation16 p ON p.patient_id=a.patient_id
LEFT JOIN Drug_Accumulation17 q ON q.patient_id=a.patient_id;