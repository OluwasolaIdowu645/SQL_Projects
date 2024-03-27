SET @Reporting_Date := "2022-10-31";

/* New update for the most recent Sample Collect Date from Lab Order and Result Form*/
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
SELECT 'CIHP' IP, @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName, CONCAT(p2.identifier, "-", @DATIMCode) Pepid_datim,
p2.identifier Pepid, a.person_id, /*a.concept_id, a.encounter_id,*/ a.Sample_Collection_Date, b.Indication_for_AHD, IF(g.CD4_LFA_Result="LessThan200", "<200", ">200") CD4_LFA_Result, 
d.TB_LF_LAM_Result, d.Date_TB_LF_LAM_Result_Received, e.Serology_For_CrAg_Result, e.Date_Serology_For_CrAg_Result_Received, 
f.CSF_For_CrAg_Result, f.Date_CSF_For_CrAg_Result_Received FROM 
(SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
person_id test, concept_id, o.encounter_id, `obs_datetime`, e.`encounter_datetime` AS Sample_Collection_Date FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE concept_id IN (167079, 167080, 166697, 167089, 167081, 167082, 167093, 167094) AND o.voided=0 AND e.`encounter_type` = 11 
AND e.`form_id` = 21 AND o.`obs_datetime` <= @Reporting_Date
GROUP BY person_id, obs_datetime ORDER BY o.person_id, o.`obs_datetime` DESC) a
LEFT JOIN (SELECT person_id, ConceptName(`value_coded`)  Indication_for_AHD, encounter_id FROM obs WHERE concept_id = 167079 AND voided=0) b 
ON a.person_id = b.person_id AND a.encounter_id = b.encounter_id
LEFT JOIN (SELECT person_id, `obs_datetime` Date_TB_LF_LAM_Result_Received, ConceptName(`value_coded`)  TB_LF_LAM_Result, encounter_id 
FROM obs WHERE concept_id = 166697 AND voided=0) d ON a.person_id = b.person_id AND a.encounter_id = d.encounter_id
LEFT JOIN (SELECT person_id, `obs_datetime` Date_Serology_For_CrAg_Result_Received, ConceptName(`value_coded`) Serology_For_CrAg_Result, encounter_id 
FROM obs WHERE concept_id = 167090 AND voided=0) e ON a.person_id = b.person_id AND a.encounter_id = e.encounter_id
LEFT JOIN (SELECT person_id, `obs_datetime` Date_CSF_For_CrAg_Result_Received, ConceptName(`value_coded`) CSF_For_CrAg_Result, encounter_id 
FROM obs WHERE concept_id = 167082 AND voided=0) f ON a.person_id = b.person_id AND a.encounter_id = f.encounter_id
LEFT JOIN `patient_identifier` p2 ON a.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4
LEFT JOIN (SELECT person_id, `obs_datetime` Date_CD4_LFA_Result_Received, ConceptName(`value_coded`) CD4_LFA_Result, encounter_id 
FROM obs WHERE concept_id = 167088 AND voided=0) g ON a.person_id = b.person_id AND a.encounter_id = g.encounter_id
WHERE a.Occurrence = 1;