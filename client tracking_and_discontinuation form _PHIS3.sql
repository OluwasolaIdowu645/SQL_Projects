SET @startDate:='2023-07-01';
SET @endDate:='2023-12-30';

SELECT

nigeria_datimcode_mapping.state_name as `State`,
nigeria_datimcode_mapping.lga_name as `LGA`,
gp2.property_value as `Facilty Name`,
gp1.property_value as `DATIM Code`,
pid2.identifier as  `Hospital No`,
pid1.identifier as `Patient ID`, 

DATE_FORMAT(encounter.encounter_datetime, '%e %M %Y') as `Date of Tracking`,
MAX(IF(obs.concept_id=165460,cn1.name, null)) as `Reason for Tracking`,
-- MAX(IF(obs.concept_id=161135,obs.value_text, null)) as `Guardian / Treatment Partner's Name`,
-- MAX(IF(obs.concept_id=160641,obs.value_text, null)) as `Guardian / Treatment Partner's Contact Address`,
-- MAX(IF(obs.concept_id=159635,obs.value_text, null)) as `Guardian / Treatment Partner's Phone Number`,
MAX(IF(obs.concept_id=165461,obs.value_datetime, null)) as `Date of Last Actual Contact/ Appointment`,
MAX(IF(obs.concept_id=165778,obs.value_datetime, null)) as `Date of Missed Scheduled Appointment`,
MAX(IF(obs.concept_id=167221,cn1.name, null)) as `Client Verification`,
MAX(IF(obs.concept_id=167222,cn1.name, null)) as `Indication for Client Verification`,
MAX(IF(obs.concept_id=165586,cn1.name, null)) as `Patient Care in Facility Discontinued`,
MAX(IF(obs.concept_id=165469,obs.value_datetime, null)) as `Date of Discontinuation`,
MAX(IF(obs.concept_id=165470,cn1.name, null)) as `Reason for Discontinuation`,
MAX(IF(obs.concept_id=159495,obs.value_text, null)) as `Facility transferred to`,
MAX(IF(obs.concept_id=165460,cn1.name, null)) as `Reason for Tracking`,
MAX(IF(obs.concept_id=165889,cn1.name, null)) as `Cause of Death`,
MAX(IF(obs.concept_id=166349,cn1.name, null)) as `VA Cause of Death`,
MAX(IF(obs.concept_id=166348,cn1.name, null)) as `Adult Causes`,
MAX(IF(obs.concept_id=166347,cn1.name, null)) as `Child Causes`,
MAX(IF(obs.concept_id=165915,obs.value_text, null)) as `Other cause of death`,
MAX(IF(obs.concept_id=165916,cn1.name, null)) as `Reason to Discontinue Care`,
MAX(IF(obs.concept_id=165917,obs.value_text, null)) as `Discontinue Care other specify`,
MAX(IF(obs.concept_id=166152,obs.value_datetime, null)) as `Date of Lost to follow up`,
MAX(IF(obs.concept_id=166157,cn1.name, null)) as `Reason for Lost to follow up`,
MAX(IF(obs.concept_id=167149,obs.value_text, null)) as `Reason for Lost to follow up_Other`




FROM encounter
LEFT JOIN obs on(encounter.encounter_id=obs.encounter_id and obs.voided=0 and encounter.voided=0 and encounter.form_id=13)
LEFT JOIN patient on(patient.patient_id=encounter.patient_id and encounter.voided=0 and patient.voided=0 and encounter.form_id=13)
 
LEFT JOIN concept_name cn1 on(obs.value_coded=cn1.concept_id and cn1.locale='en' and cn1.locale_preferred=1)
 
LEFT JOIN patient_identifier pid1 on(pid1.patient_id=patient.patient_id and patient.voided=0 and pid1.identifier_type=4 and pid1.voided=0)
LEFT JOIN patient_identifier pid2 on(pid2.patient_id=patient.patient_id and patient.voided=0 and pid2.identifier_type=5 and pid2.voided=0)
LEFT JOIN global_property gp1 on(gp1.property='facility_datim_code')
LEFT JOIN global_property gp2 on(gp2.property='Facility_Name')
LEFT JOIN nigeria_datimcode_mapping on(gp1.property_value=nigeria_datimcode_mapping.datim_code)
 
where encounter.voided=0 and encounter.form_id=13 and encounter.encounter_datetime BETWEEN @startDate AND @endDate
GROUP BY encounter.encounter_id
ORDER BY encounter.patient_id, encounter.encounter_datetime ASC;
