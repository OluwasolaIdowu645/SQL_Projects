# IP	State	SurgeCommand	LGA	City	Datim_Code	FacilityName	Datim_HTS_ClientCode	HTS_ClientCode	PEPFAR_Number_IfOnART	birthdate	Sex	Age ≥ 15 (at Test)	given_name	family_name	PhoneNumber	
#VisitDate	Test_VisitDate_Validation	KindOfHTS	setting	HIVScreeningTestDate	HIV_FinalResult (Positive)	Opt_Out_of_RTRI?	Opt_Out_of_RTRI_Validation	HIVRecencyTestName	Recency Number	ControlLine	
# VerificationLine	LongTermLine	HIVRecencyTestDate	RecencyInterpretation	ViralLoadRequest	VLSampleCollectionDate	PCR_LabNo	SampleType	PCR_Laboratory	HIV_ViralLoad	FinalHIVRecencyResult

#HIV Recency Test Date (165850) - Setting (165839) - HIV Screening Test Date (165844) -  Informed consent for HIV testing given(Opt_out) (165805), Recency Test Name (166216), Verify Recency Number (166210), Control line (166212), Viral load request (166244)
# Verification Line (166243), Specimen collection date (159951), PCR Lab Sample No. (165715), Specimen sources (162476)	Answers:, PCR LABORATORY (166233), HIV VIRAL LOAD (856), Final Recency Result (166214)	

SET @Reporting_Date := '2024-03-20';
SELECT * FROM obs WHERE concept_id = 166210 AND voided = 0;

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

SELECT 'CHIP' AS IP, @State State, @SurgeCommand SurgeCommand, @LGA LGA, 'CITY', @DATIMCode DATIMCode,  @FacilityName FacilityName, e.`patient_id`, CONCAT(a.identifier,"-",@DATIMCode )Datim_HTS_ClientCode, a.identifier HTS_ClientCode,
b.identifier PEPFAR_Number_IfOnART, c.`birthdate`, c.`gender` Sex, IF((DATE_FORMAT(FROM_DAYS(DATEDIFF(e.`encounter_datetime`, c.`birthdate`)), '%Y') + 0) >= 15, 'Yes', 'No') AS 'Age ≥ 15 (at Test)?',
d.Given_name, d.`Family_name`, f.value PhoneNumber, e.`encounter_datetime` VisitDate, IF(g.`value_datetime`= e.`encounter_datetime`, 'Equal', 'Not Equal') Test_VisitDate_Validation, ConceptName(h.`value_coded`) KindOfHTS,
ConceptName(i.`value_coded`) Setting, j.`value_datetime` HIVScreeningTestDate, ConceptName(k.`value_coded`) 'Opt_Out_of_RTRI?', ConceptName(l.`value_coded`) HIVRecencyTestName, m.value_text 'Recency Number', ConceptName(n.`value_coded`)ControlLine,
ConceptName(o.`value_coded`) VerificationLine, ConceptName(p.`value_coded`) LongTermLine, q.`value_datetime` HIVRecencyTestDate, ConceptName(r.`value_coded`)RecencyInterpretation, ConceptName(s.`value_coded`)ViralLoadRequest, 
t.value_datetime VLSampleCollectionDate, u.`value_text` PCR_LabNo, ConceptName(v.`value_coded`) SampleType, ConceptName(w.`value_coded`) PCR_Laboratory, z.`value_numeric` HIV_ViralLoad, ConceptName(aa.`value_coded`)FinalHIVRecencyResult


FROM `encounter` e
LEFT JOIN (SELECT `patient_id`, `identifier` FROM `patient_identifier` WHERE `identifier_type`=8 AND `voided` = 0) a ON a.patient_id=e.`patient_id`
LEFT JOIN (SELECT `patient_id`, `identifier` FROM `patient_identifier` WHERE `identifier_type`=4 AND `voided` = 0) b ON b.patient_id=e.`patient_id`
LEFT JOIN (SELECT `person_id`, `Birthdate`, `gender` FROM `person` WHERE `voided` = 0) c ON c.person_id=e.`patient_id`
LEFT JOIN (SELECT `person_id`, `given_name`, `family_name` FROM `person_name` WHERE `voided` = 0) d ON d.person_id=e.`patient_id`
LEFT JOIN (SELECT `person_id`, `value` FROM `person_attribute` WHERE `voided` = 0) f ON f.person_id=e.`patient_id`
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_datetime` FROM `obs` WHERE `concept_id`=165850 AND `voided` = 0) g ON g.person_id=e.`patient_id` AND g.`encounter_id`=e.`encounter_id`
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_coded` FROM `obs` WHERE `concept_id`=166136 AND `voided` = 0) h ON h.person_id=e.`patient_id` AND h.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_coded` FROM `obs` WHERE `concept_id`=165839 AND `voided` = 0) i ON i.person_id=e.`patient_id` AND i.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_datetime` FROM `obs` WHERE `concept_id`=165844 AND `voided` = 0) j ON j.person_id=e.`patient_id` AND j.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_coded` FROM `obs` WHERE `concept_id`=165805 AND `voided` = 0) k ON k.person_id=e.`patient_id` AND k.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_coded` FROM `obs` WHERE `concept_id`=166216 AND `voided` = 0) l ON l.person_id=e.`patient_id` AND l.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_text` FROM `obs` WHERE `concept_id`=166210 AND `voided` = 0) m ON m.person_id=e.`patient_id` AND m.`encounter_id`=e.`encounter_id`
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_coded` FROM `obs` WHERE `concept_id`=166212 AND `voided` = 0) n ON n.person_id=e.`patient_id` AND n.`encounter_id`=e.`encounter_id`
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_coded` FROM `obs` WHERE `concept_id`=166243 AND `voided` = 0) o ON o.person_id=e.`patient_id` AND o.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_coded` FROM `obs` WHERE `concept_id`=166211 AND `voided` = 0) p ON p.person_id=e.`patient_id` AND p.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_datetime` FROM `obs` WHERE `concept_id`=165850 AND `voided` = 0) q ON q.person_id=e.`patient_id` AND q.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_coded` FROM `obs` WHERE `concept_id`=166213 AND `voided` = 0) r ON r.person_id=e.`patient_id` AND r.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_coded` FROM `obs` WHERE `concept_id`=166244 AND `voided` = 0) s ON s.person_id=e.`patient_id` AND s.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_datetime` FROM `obs` WHERE `concept_id`=159951 AND `voided` = 0) t ON t.person_id=e.`patient_id` AND t.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_text` FROM `obs` WHERE `concept_id`=165715 AND `voided` = 0) u ON u.person_id=e.`patient_id` AND u.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_coded` FROM `obs` WHERE `concept_id`=162476 AND `voided` = 0) v ON v.person_id=e.`patient_id` AND v.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_coded` FROM `obs` WHERE `concept_id`=166233 AND `voided` = 0) w ON w.person_id=e.`patient_id` AND w.`encounter_id`=e.`encounter_id`
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_numeric` FROM `obs` WHERE `concept_id`=856 AND `voided` = 0) z ON z.person_id=e.`patient_id` AND z.`encounter_id`=e.`encounter_id` 
LEFT JOIN (SELECT `person_id`, `encounter_id`, `value_coded` FROM `obs` WHERE `concept_id`=166214 AND `voided` = 0) aa ON aa.person_id=e.`patient_id` AND aa.`encounter_id`=e.`encounter_id` 
WHERE e.`encounter_type` = 20 AND e.form_id = 10 AND e.`voided` = 0 AND e.`encounter_datetime` <= @Reporting_Date AND
(ConceptName(k.`value_coded`)='Yes' OR ConceptName(l.`value_coded`) LIKE '%' OR m.value_text LIKE '%' OR  ConceptName(n.`value_coded`) LIKE '%' OR  ConceptName(o.`value_coded`) LIKE '%' OR  ConceptName(p.`value_coded`) LIKE '%' 
OR q.`value_datetime` LIKE '%' OR  ConceptName(r.`value_coded`) LIKE '%') GROUP BY e.`patient_id`