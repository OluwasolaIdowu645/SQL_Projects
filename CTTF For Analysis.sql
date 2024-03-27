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

DROP TABLE IF EXISTS CTTF;
CREATE TEMPORARY TABLE CTTF AS
SELECT @row_no := IF(@prev_val = patient_id, @row_no + 1, 1) AS Occ, @prev_val := patient_id AS patient_id, `encounter_id`,`encounter_datetime` 
FROM encounter,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE `encounter_type` = 15 AND voided=0 ORDER BY patient_id, `encounter_datetime` DESC;


SELECT 'CIHP' IP, @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName, CONCAT(b.identifier, "-", @DATIMCode) Pepid_datim,
b.identifier Pepid, a.Occ, a.patient_id, a.encounter_id, DATE_FORMAT(a.`encounter_datetime`, "%Y-%m-%d")encounter_datetime, c.Reason_for_Defaulting1, DATE_FORMAT(c.obs_datetime, "%Y-%m-%d")obs_datetime
FROM CTTF a
LEFT JOIN `patient_identifier` b ON a.`patient_id` = b.`patient_id` AND b.`identifier_type`=4 AND `voided`=0
LEFT JOIN (SELECT o.`person_id`, ConceptName(o.`value_coded`) AS 'Reason_for_Defaulting1', o.`obs_datetime`, o.`encounter_id`, o.`obs_group_id` FROM obs o WHERE concept_id = 165467 AND o.voided=0 GROUP BY encounter_id) c 
ON a.`encounter_id`=c.`encounter_id`;