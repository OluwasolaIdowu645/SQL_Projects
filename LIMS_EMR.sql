 SET @FacilityName :=
(SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'Facility_Name');
SET @DATIMCode :=
(SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code');
SET @SurgeCommand :=
(SELECT
  SurgeCommand
FROM
  CIHP_ListOfFacility
WHERE Datim_Code = (SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code'));
SET @LGA :=
(SELECT
  LGA
FROM
  CIHP_ListOfFacility
WHERE Datim_Code = (SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code'));
SET @State :=
(SELECT
  State
FROM
  CIHP_ListOfFacility
WHERE Datim_Code = (SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code'));

SELECT 'CIHP' IP, @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName, a.`Manifest_id`, a.`Sample_Collected_Date`, a.`Date_Sample_sent`, a.`Sample_Status`,
a.`sample_id`, c.`patient_id`, p1.identifier PEPID, b.`Date_Sample_Receieved_at_PCRlab`, b.`Assay_Date`, b.`Date_Result_Dispatched`
FROM `lims_manifest_samples` a
LEFT JOIN `lims_manifest_result` b ON a.`sample_id` = b.`sample_id`
LEFT JOIN `encounter` c ON a.`encounter_id` = c.`encounter_id`
LEFT JOIN `patient_identifier` p1 ON c.`patient_id` = p1.`patient_id` AND p1.`identifier_type` = 4 AND p1.`preferred` = 1
WHERE A.`Sample_Collected_Date` >= '2022-01-01'
ORDER BY a.`sample_collected_date` DESC;


CALL LIMS_EMR_Daily_Report;