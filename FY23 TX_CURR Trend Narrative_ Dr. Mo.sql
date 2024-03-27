
SELECT `State`, `SurgeCommand`, `LGA`, `FacilityName`,
COALESCE(SUM(`FY23Q3` = 'Active')) AS 'FY23Q3_Tx_Curr', 
COALESCE(SUM(`CurrentARTStatus_28Days` = 'Active')) AS 'FY23Q4_Tx_Curr',
COALESCE(SUM(`FY23Q3` = 'Active' AND `CurrentARTStatus_28Days` IN ('In-Active', 'Stopped', 'Transferred Out', 'Dead', 'In-Active'))) AS 'TX_ML_Q4 FY23',
COALESCE(SUM(`FY23Q3` = 'Active' AND `CurrentARTStatus_28Days` = 'Stopped')) AS 'Stopped Treatment',
COALESCE(SUM(`FY23Q3` = 'Active' AND `CurrentARTStatus_28Days` = 'Transferred Out')) AS 'Transferred Out',
COALESCE(SUM(`FY23Q3` = 'Active' AND `CurrentARTStatus_28Days` = 'Dead')) AS 'Dead',
COALESCE(SUM(`FY23Q3` = 'Active' AND `CurrentARTStatus_28Days` = 'In-Active')) AS 'IIT Q3 FY23 (LTFU)',
COALESCE(SUM(`CurrentARTStatus_28Days` = 'Active') - SUM(`FY23Q3` = 'Active')) AS 'TX_NET NEW',
COALESCE(SUM(`FY23Q3` = 'Active') + SUM(`CurrentARTStatus_28Days` = 'Active' AND `FY23Q3` IN ('In-Active', 'Stopped', 'Transferred Out'))+SUM(`CurrentARTStatus_28Days` = 'Active' AND `FY23Q3` IS NULL)) AS 'Expected TX_CURR',
COALESCE(SUM(`CurrentARTStatus_28Days` = 'In-Active' AND `FY23Q3`='Active' AND `Biometrics_Captured` IS NOT NULL)) AS 'Inactive Base Captured',
COALESCE(SUM(`CurrentARTStatus_28Days` = 'In-Active' AND `FY23Q3`='Active' AND `Recapture_Count` IS NOT NULL)) AS 'Inactive Recaptured'
FROM `fy23_tx_curr_trend_narrative` GROUP BY `SurgeCommand`,`LGA`,`FacilityName`;





UPDATE `fy23_tx_curr_trend_narrative`
SET `FY23Q3` = NULL
WHERE `FY23Q3` = '#N/A';

SET @startDate:='2019-10-01';
SET @endDate:='2022-09-30';

SELECT

nigeria_datimcode_mapping.state_name AS `State`,
nigeria_datimcode_mapping.lga_name AS `LGA`,
gp2.property_value AS `Facilty`,
gp1.property_value AS `DATIM Code`,
pid2.identifier AS  `Hospital No`,
pid1.identifier AS `Patient ID`, 

MAX(IF(obs.concept_id=165715,obs.value_text, NULL)) AS `Sample ID.`,
MAX(IF(obs.concept_id=162476,cn1.name, NULL)) AS `Sample Type`,
MAX(IF(obs.concept_id=164980,cn1.name, NULL)) AS `Indication for Viral Load`,
DATE_FORMAT(MAX(IF(obs.concept_id=159951,obs.value_datetime, NULL)),'%d-%b-%Y') AS `Sample collection date`,
DATE_FORMAT(MAX(IF(obs.concept_id=165988,obs.value_datetime, NULL)),'%d-%b-%Y') AS `Date sample sent to PCR Lab`,
DATE_FORMAT(MAX(IF(obs.concept_id=165716,obs.value_datetime, NULL)),'%d-%b-%Y') AS `Date sample received at PCR Lab`,
DATE_FORMAT(MAX(IF(obs.concept_id=165989,obs.value_datetime, NULL)),'%d-%b-%Y') AS `Date result was sent from PCR Lab`,
DATE_FORMAT(MAX(IF(obs.concept_id=165987,obs.value_datetime, NULL)),'%d-%b-%Y') AS `Date result was received at the facility`,
DATE_FORMAT(MAX(IF(obs.concept_id=166424,obs.value_datetime, NULL)),'%d-%b-%Y') AS `Assay Date`,
DATE_FORMAT(MAX(IF(obs.concept_id=166423,obs.value_datetime, NULL)),'%d-%b-%Y') AS `Result Date`,
DATE_FORMAT(MAX(IF(obs.concept_id=166425,obs.value_datetime, NULL)),'%d-%b-%Y') AS `Approval Date`,
MAX(IF(obs.concept_id=166422,cn1.name, NULL)) AS `Alphanumeric Viral Load Result`,
MAX(IF(obs.concept_id=856,obs.value_numeric, NULL)) AS `Viral Load test result`

FROM encounter
LEFT JOIN obs ON(encounter.encounter_id=obs.encounter_id AND obs.voided=0 AND encounter.voided=0 AND encounter.form_id=21)
LEFT JOIN patient ON(patient.patient_id=encounter.patient_id AND encounter.voided=0 AND patient.voided=0 AND encounter.form_id=21)
 
LEFT JOIN concept_name cn1 ON(obs.value_coded=cn1.concept_id AND cn1.locale='en' AND cn1.locale_preferred=1)
 
LEFT JOIN patient_identifier pid1 ON(pid1.patient_id=patient.patient_id AND patient.voided=0 AND pid1.identifier_type=4 AND pid1.voided=0)
LEFT JOIN patient_identifier pid2 ON(pid2.patient_id=patient.patient_id AND patient.voided=0 AND pid2.identifier_type=5 AND pid2.voided=0)
LEFT JOIN global_property gp1 ON(gp1.property='facility_datim_code')
LEFT JOIN global_property gp2 ON(gp2.property='Facility_Name')
LEFT JOIN nigeria_datimcode_mapping ON(gp1.property_value=nigeria_datimcode_mapping.datim_code)
 
WHERE encounter.voided=0 AND encounter.form_id=21 AND encounter.encounter_datetime BETWEEN @startDate AND @endDate
GROUP BY encounter.patient_id, encounter.encounter_id
HAVING(MAX(IF(obs.concept_id=856,obs.value_numeric, NULL))) IS NOT NULL
ORDER BY encounter.patient_id, encounter.encounter_datetime ASC;
