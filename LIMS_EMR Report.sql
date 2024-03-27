SELECT State, SurgeCommand, LGA, FacilityName, 
COALESCE(SUM(PEPID LIKE '%')) AS 'Sample_Successfully_Sent_Via_LIMS_EMR',
COALESCE(SUM(Sample_Status ='AVAILABLE')) AS 'Result_Available_Via_LIMS_EMR',
COALESCE(SUM(`Date_Sample_Receieved_at_PCRlab` LIKE '%00' OR `Assay_Date` LIKE '%2021%')) AS 'Data_Integrity_Issues'

FROM (SELECT `IP`,`State`,`SurgeCommand`,`LGA`,`FacilityName`,`Manifest_id`,`Sample_Collected_Date`,`Date_Sample_sent`,`Sample_Status`,
`sample_id`,`patient_id`,`PEPID`,`Date_Sample_Receieved_at_PCRlab`,`Assay_Date`,`Date_Result_Dispatched` FROM `LIMS_EMR`
GROUP BY `PEPID`,`Sample_Collected_Date`) a 
GROUP BY FacilityName ORDER BY LGA, FacilityName;



SELECT State, SurgeCommand, LGA, FacilityName, 
COALESCE(SUM(PEPID LIKE '%')) AS 'Total_Sample_Collection_on_NMRS',
COALESCE(SUM(PEPID LIKE '%' AND `DateOfCurrentVL` LIKE '%2022%')) AS 'Total_Result_on_NMRS'
FROM `linelist` 
WHERE `Last_VL_Sample_Date` BETWEEN '2022-01-01' AND '2022-03-17'
GROUP BY FacilityName ORDER BY LGA, FacilityName;

SELECT a.State, a.SurgeCommand, a.LGA, a.FacilityName, a.Total_Sample_Collection_on_NMRS, b.Sample_Successfully_Sent_Via_LIMS_EMR, a.Total_Result_on_NMRS, 
(a.Total_Sample_Collection_on_NMRS-a.Total_Result_on_NMRS) 'Samples_Without_Result',
 (a.Total_Result_on_NMRS-b.Result_Available_Via_LIMS_EMR)'Result_Manually_Entered',
 b.Result_Available_Via_LIMS_EMR, b.Data_Integrity_Issues
   FROM(
SELECT State, SurgeCommand, LGA, FacilityName, 
COALESCE(SUM(PEPID LIKE '%')) AS 'Total_Sample_Collection_on_NMRS',
COALESCE(SUM(PEPID LIKE '%' AND `DateOfCurrentVL` LIKE '%2022%')) AS 'Total_Result_on_NMRS'
FROM `linelist` 
WHERE `Last_VL_Sample_Date` BETWEEN '2022-01-01' AND '2022-03-17'
GROUP BY FacilityName ORDER BY LGA, FacilityName) a
LEFT JOIN (SELECT State, SurgeCommand, LGA, FacilityName, 
COALESCE(SUM(PEPID LIKE '%')) AS 'Sample_Successfully_Sent_Via_LIMS_EMR',
COALESCE(SUM(Sample_Status ='AVAILABLE')) AS 'Result_Available_Via_LIMS_EMR',
COALESCE(SUM((`Date_Sample_Receieved_at_PCRlab` IS NULL AND `Assay_Date` IS NOT NULL AND `Date_Result_Dispatched` IS NOT NULL)
 OR `Assay_Date` LIKE '%2021%')) AS 'Data_Integrity_Issues'

FROM (SELECT `IP`,`State`,`SurgeCommand`,`LGA`,`FacilityName`,`Manifest_id`,`Sample_Collected_Date`,`Date_Sample_sent`,`Sample_Status`,
`sample_id`,`patient_id`,`PEPID`,`Date_Sample_Receieved_at_PCRlab`,`Assay_Date`,`Date_Result_Dispatched` FROM `LIMS_EMR`
GROUP BY `PEPID`,`Sample_Collected_Date`) a 
GROUP BY FacilityName ORDER BY LGA, FacilityName) b ON a.FacilityName=b.FacilityName;