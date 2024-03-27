SET @FacilityName :=(SELECT `property_value` FROM `global_property` WHERE `property`= 'Facility_Name'); SET @DATIMCode :=(SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code');
SET @SurgeCommand :=(SELECT SurgeCommand FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code'));
SET @LGA :=(SELECT LGA FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code'));
SET @State :=(SELECT State FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code'));
SELECT @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName,PEPID, Person_id, 
MAX(CASE WHEN Occurrence=1 THEN Visit_Date ELSE NULL END) AS Last_BP_Visit_Date,
MAX(CASE WHEN Occurrence=1 THEN Systolic_blood_pressure ELSE NULL END) AS Last_Systolic_blood_pressure,
MAX(CASE WHEN Occurrence=1 THEN Diastolic_blood_pressure ELSE NULL END) AS Last_Diastolic_blood_pressure,
MAX(CASE WHEN Occurrence=2 THEN Visit_Date ELSE NULL END) AS 2nd_Last_BP_Visit_Date,
MAX(CASE WHEN Occurrence=2 THEN Systolic_blood_pressure ELSE NULL END) AS 2nd_Last_Systolic_blood_pressure,
MAX(CASE WHEN Occurrence=2 THEN Diastolic_blood_pressure ELSE NULL END) AS 2nd_Last_Diastolic_blood_pressure,
MAX(CASE WHEN Occurrence=3 THEN Visit_Date ELSE NULL END) AS 3rd_Last_BP_Visit_Date,
MAX(CASE WHEN Occurrence=3 THEN Systolic_blood_pressure ELSE NULL END) AS 3rd_Last_Systolic_blood_pressure,
MAX(CASE WHEN Occurrence=3 THEN Diastolic_blood_pressure ELSE NULL END) AS 3rd_Last_Diastolic_blood_pressure,
MAX(CASE WHEN Occurrence=4 THEN Visit_Date ELSE NULL END) AS 4th_Last_BP_Visit_Date,
MAX(CASE WHEN Occurrence=4 THEN Systolic_blood_pressure ELSE NULL END) AS 4th_Last_Systolic_blood_pressure,
MAX(CASE WHEN Occurrence=4 THEN Diastolic_blood_pressure ELSE NULL END) AS 4th_Last_Diastolic_blood_pressure,
MAX(CASE WHEN Occurrence=5 THEN Visit_Date ELSE NULL END) AS 5th_Last_BP_Visit_Date,
MAX(CASE WHEN Occurrence=5 THEN Systolic_blood_pressure ELSE NULL END) AS 5th_Last_Systolic_blood_pressure,
MAX(CASE WHEN Occurrence=5 THEN Diastolic_blood_pressure ELSE NULL END) AS 5th_Last_Diastolic_blood_pressure
FROM(
SELECT a.Occurrence, a.PEPID, a.Person_id, a.encounter_datetime Visit_Date, a.Systolic_blood_pressure, b.Diastolic_blood_pressure
FROM (SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
e.`encounter_datetime`, o.`value_numeric`  Systolic_blood_pressure , e.encounter_id, p2.identifier PEPID
FROM `encounter` e LEFT JOIN `obs` o ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE  o.`concept_id` = 5085 AND e.`encounter_type` = 12 AND e.`form_id` = 14  AND o.`voided` = 0
ORDER BY o.person_id, o.`obs_datetime` DESC) a
LEFT JOIN (SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
e.`encounter_datetime`, o.`value_numeric`  Diastolic_blood_pressure, e.encounter_id
FROM `encounter` e LEFT JOIN `obs` o ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE  o.`concept_id` = 5086 AND e.`encounter_type` = 12 AND e.`form_id` = 14  AND o.`voided` = 0
ORDER BY o.person_id, o.`obs_datetime` DESC) b ON a.Person_id=b.Person_id AND a.encounter_id=b.encounter_id
WHERE a.Occurrence <=5) a GROUP BY PEPID;
