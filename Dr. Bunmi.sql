SELECT 'Lagos', LGA, FacilityName, 
COALESCE(SUM(
             CurrentARTStatus_28Days LIKE 'Active')) AS 'TX_CURR 09/06/2021',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'In-Active' AND `FY21Q3_CurrentARTStatus_28Days` LIKE 'In-Active' AND
            `FY21Q2_CurrentARTStatus_28Days` LIKE 'In-Active' AND `FY21Q1_CurrentARTStatus_28Days` LIKE 'Active')) AS 'Inactive since SAPR',
COALESCE(SUM(
             `q2_DaysOfARVRefill` <180 AND CurrentARTStatus_28Days LIKE 'Active' AND `DaysOfARVRefill` = 180)) AS 'Client initiated on MMD 6 Q3',            
COALESCE(ROUND(SUM(
             (`ARTStartDate` BETWEEN '2020-07-01' AND '2021-06-30')/4))) AS 'Average Quarterly TX New/facility( estimates)', 
COALESCE(ROUND(SUM(
             (`NextAppmt` BETWEEN '2021-07-01' AND '2021-09-30')/4))) AS 'Q4 appointment'                         

FROM `drbunmi` WHERE `HospitalNo` NOT LIKE '%EH%' OR `HospitalNo` NOT LIKE '%TE%' OR `HospitalNo` NOT LIKE '%GW%' OR
 `HospitalNo` NOT LIKE '%HR%' OR `HospitalNo` NOT LIKE '%FP%' OR `HospitalNo` NOT LIKE '%CH%' OR `HospitalNo` NOT LIKE '%MH%'
GROUP BY FacilityName ORDER BY LGA, FacilityName;


SELECT 'Lagos', LGA, FacilityName, 
COALESCE(SUM(
             CurrentARTStatus_28Days LIKE 'Active')) AS 'TX_CURR 09/06/2021',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'In-Active' AND `FY21Q3_CurrentARTStatus_28Days` LIKE 'In-Active' AND
            `FY21Q2_CurrentARTStatus_28Days` LIKE 'In-Active' AND `FY21Q1_CurrentARTStatus_28Days` LIKE 'Active')) AS 'Inactive since SAPR',
COALESCE(SUM(
             `q2_DaysOfARVRefill` <180 AND CurrentARTStatus_28Days LIKE 'Active' AND `DaysOfARVRefill` = 180)) AS 'Client initiated on MMD 6 Q3',            
COALESCE(ROUND(SUM(
             (`ARTStartDate` BETWEEN '2020-07-01' AND '2021-06-30')/4))) AS 'Average Quarterly TX New/facility( estimates)', 
COALESCE(ROUND(SUM(
             (`NextAppmt` BETWEEN '2021-07-01' AND '2021-09-30')/4))) AS 'Q4 appointment'              

FROM `drbunmi` WHERE `CurrentAge` >19 AND (`HospitalNo` NOT LIKE '%EH%' OR `HospitalNo` NOT LIKE '%TE%' OR `HospitalNo` NOT LIKE '%GW%' OR
 `HospitalNo` NOT LIKE '%HR%' OR `HospitalNo` NOT LIKE '%FP%' OR `HospitalNo` NOT LIKE '%CH%' OR `HospitalNo` NOT LIKE '%MH%')
GROUP BY FacilityName ORDER BY LGA, FacilityName;