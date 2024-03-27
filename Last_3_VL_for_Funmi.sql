SET @FacilityName :=(SELECT  `property_value`FROM  `global_property`WHERE `property`= 'Facility_Name');
SET @DATIMCode :=(SELECT  `property_value`FROM  `global_property`WHERE `property`= 'facility_datim_code');
SET @SurgeCommand :=(SELECT  SurgeCommand FROM  CIHP_ListOfFacility WHERE Datim_Code = (SELECT  `property_value`FROM  `global_property`WHERE `property`= 'facility_datim_code'));
SET @LGA :=(SELECT  LGA FROM  CIHP_ListOfFacility WHERE Datim_Code = (SELECT  `property_value`FROM  `global_property`WHERE `property`= 'facility_datim_code'));
SET @State :=(SELECT  State FROM  CIHP_ListOfFacility WHERE Datim_Code = (SELECT  `property_value`FROM  `global_property`
WHERE `property`= 'facility_datim_code'));
SELECT @State State, @FacilityName FacilityName, @DATIMCode DATIMCode, @SurgeCommand SurgeCommand,@LGA LGA, 
a.person_id, a.DateOfCurrentVL Last_VL_Date, a.CurrentVL Last_VL_Result, b.DateOfCurrentVL 2ndLast_VL_Date, b.CurrentVL 2ndLast_VL_Result, 
c.DateOfCurrentVL 3rdLast_VL_Date, c.CurrentVL 3rdLast_VL_Result FROM 
(SELECT * FROM (SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id, p2.`identifier` Pepid,
o.`obs_datetime` DateOfCurrentVL, o.`value_numeric` CurrentVL 
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` = 856 AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 
ORDER BY o.person_id, o.`obs_datetime` DESC) AS a WHERE a.Occurrence = 1) a
LEFT JOIN (SELECT * FROM (SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id, 
o.`obs_datetime` DateOfCurrentVL, o.`value_numeric` CurrentVL 
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` = 856 AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 
ORDER BY o.person_id, o.`obs_datetime` DESC) AS a WHERE a.Occurrence = 2) b ON a.person_id=b.person_id
LEFT JOIN(SELECT * FROM (SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id, 
o.`obs_datetime` DateOfCurrentVL, o.`value_numeric` CurrentVL 
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` = 856 AND e.`encounter_type` = 11 AND e.`form_id` = 21  AND o.`voided` = 0 
ORDER BY o.person_id, o.`obs_datetime` DESC) AS a WHERE a.Occurrence = 3) c ON a.person_id=c.person_id

