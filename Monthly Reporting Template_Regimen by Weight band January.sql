SELECT 'Lagos', LGA, FacilityName, 
COALESCE(SUM(
             CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5)) AS 'Tx_Curr',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'ABC-3TC-LPV/r')) AS 'ABC+3TC+LPV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'ABC-3TC-DTG')) AS 'ABC+3TC+DTG',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'TDF-3TC-DTG')) AS 'TDF+3TC+DTG',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'AZT-3TC-LPV/r')) AS 'AZT+3TC+LPV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'ABC-3TC-AZT')) AS 'ABC+3TC+AZT',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'TDF-3TC-EFV')) AS 'TDF+3TC+EFV',    
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'AZT-3TC-EFV')) AS 'AZT+3TC+EFV',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'ABC-3TC-NVP')) AS 'ABC+3TC+NVP',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'ABC-3TC-EFV')) AS 'ABC+3TC+EFV',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'AZT-3TC-NVP')) AS 'AZT+3TC+NVP',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'ABC-3TC-ATV/r')) AS 'ABC-3TC-ATV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'TDF-3TC-NVP')) AS 'TDF+3TC+NVP',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'TDF-3TC-DRV/r')) AS 'TDF+3TC+DRV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'AZT-3TC-ATV/r')) AS 'AZT+3TC+ATV/r',                                                                                                                                 
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'TDF-3TC-ATV/r')) AS 'TDF+3TC+ATV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'TDF-3TC-LPV/r')) AS 'TDF+3TC+LPV/r',            
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'AZT-TDF-3TC-LPV/r')) AS 'AZT-TDF-3TC-LPV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg NOT IN ('ABC-3TC-LPV/r', 'ABC-3TC-DTG', 'TDF-3TC-DTG', 
            'AZT-3TC-LPV/r', 'ABC-3TC-AZT', 'TDF-3TC-EFV', 'AZT-3TC-EFV', 'ABC-3TC-NVP', 
            'ABC-3TC-EFV', 'AZT-3TC-NVP', 'ABC-3TC-ATV/r', 'TDF-3TC-NVP', 'TDF-3TC-DRV/r', 
            'AZT-3TC-ATV/r', 'TDF-3TC-ATV/r', 'TDF-3TC-LPV/r',  'AZT-TDF-3TC-LPV/r'))) AS 'Others'            
FROM linelist 
GROUP BY FacilityName ORDER BY LGA, FacilityName;



SELECT 'Lagos', LGA, FacilityName, 
COALESCE(SUM(
             CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9)) AS 'Tx_Curr',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'ABC-3TC-LPV/r')) AS 'ABC+3TC+LPV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'ABC-3TC-DTG')) AS 'ABC+3TC+DTG',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'TDF-3TC-DTG')) AS 'TDF+3TC+DTG',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'AZT-3TC-LPV/r')) AS 'AZT+3TC+LPV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'ABC-3TC-AZT')) AS 'ABC+3TC+AZT',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'TDF-3TC-EFV')) AS 'TDF+3TC+EFV',    
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'AZT-3TC-EFV')) AS 'AZT+3TC+EFV',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'ABC-3TC-NVP')) AS 'ABC+3TC+NVP',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'ABC-3TC-EFV')) AS 'ABC+3TC+EFV',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'AZT-3TC-NVP')) AS 'AZT+3TC+NVP',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'ABC-3TC-ATV/r')) AS 'ABC-3TC-ATV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'TDF-3TC-NVP')) AS 'TDF+3TC+NVP',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'TDF-3TC-DRV/r')) AS 'TDF+3TC+DRV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'AZT-3TC-ATV/r')) AS 'AZT+3TC+ATV/r',                                                                                                                                 
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'TDF-3TC-ATV/r')) AS 'TDF+3TC+ATV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'TDF-3TC-LPV/r')) AS 'TDF+3TC+LPV/r',            
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg = 'AZT-TDF-3TC-LPV/r')) AS 'AZT-TDF-3TC-LPV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 6 AND 9
            AND CurrentARTReg NOT IN ('ABC-3TC-LPV/r', 'ABC-3TC-DTG', 'TDF-3TC-DTG', 
            'AZT-3TC-LPV/r', 'ABC-3TC-AZT', 'TDF-3TC-EFV', 'AZT-3TC-EFV', 'ABC-3TC-NVP', 
            'ABC-3TC-EFV', 'AZT-3TC-NVP', 'ABC-3TC-ATV/r', 'TDF-3TC-NVP', 'TDF-3TC-DRV/r', 
            'AZT-3TC-ATV/r', 'TDF-3TC-ATV/r', 'TDF-3TC-LPV/r',  'AZT-TDF-3TC-LPV/r'))) AS 'Others'                 
FROM linelist 
GROUP BY FacilityName ORDER BY LGA, FacilityName;



SELECT 'Lagos', LGA, FacilityName, 
COALESCE(SUM(
             CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14)) AS 'Tx_Curr',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'ABC-3TC-LPV/r')) AS 'ABC+3TC+LPV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'ABC-3TC-DTG')) AS 'ABC+3TC+DTG',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'TDF-3TC-DTG')) AS 'TDF+3TC+DTG',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'AZT-3TC-LPV/r')) AS 'AZT+3TC+LPV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'ABC-3TC-AZT')) AS 'ABC+3TC+AZT',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'TDF-3TC-EFV')) AS 'TDF+3TC+EFV',    
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'AZT-3TC-EFV')) AS 'AZT+3TC+EFV',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'ABC-3TC-NVP')) AS 'ABC+3TC+NVP',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'ABC-3TC-EFV')) AS 'ABC+3TC+EFV',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'AZT-3TC-NVP')) AS 'AZT+3TC+NVP',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'ABC-3TC-ATV/r')) AS 'ABC-3TC-ATV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'TDF-3TC-NVP')) AS 'TDF+3TC+NVP',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'TDF-3TC-DRV/r')) AS 'TDF+3TC+DRV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'AZT-3TC-ATV/r')) AS 'AZT+3TC+ATV/r',                                                                                                                                 
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'TDF-3TC-ATV/r')) AS 'TDF+3TC+ATV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'TDF-3TC-LPV/r')) AS 'TDF+3TC+LPV/r',            
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg = 'AZT-TDF-3TC-LPV/r')) AS 'AZT-TDF-3TC-LPV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 10 AND 14
            AND CurrentARTReg NOT IN ('ABC-3TC-LPV/r', 'ABC-3TC-DTG', 'TDF-3TC-DTG', 
            'AZT-3TC-LPV/r', 'ABC-3TC-AZT', 'TDF-3TC-EFV', 'AZT-3TC-EFV', 'ABC-3TC-NVP', 
            'ABC-3TC-EFV', 'AZT-3TC-NVP', 'ABC-3TC-ATV/r', 'TDF-3TC-NVP', 'TDF-3TC-DRV/r', 
            'AZT-3TC-ATV/r', 'TDF-3TC-ATV/r', 'TDF-3TC-LPV/r',  'AZT-TDF-3TC-LPV/r'))) AS 'Others'                 
FROM linelist 
GROUP BY FacilityName ORDER BY LGA, FacilityName;


SELECT 'Lagos', LGA, FacilityName, 
COALESCE(SUM(
             CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19)) AS 'Tx_Curr',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'ABC-3TC-LPV/r')) AS 'ABC+3TC+LPV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'ABC-3TC-DTG')) AS 'ABC+3TC+DTG',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'TDF-3TC-DTG')) AS 'TDF+3TC+DTG',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'AZT-3TC-LPV/r')) AS 'AZT+3TC+LPV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'ABC-3TC-AZT')) AS 'ABC+3TC+AZT',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'TDF-3TC-EFV')) AS 'TDF+3TC+EFV',    
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'AZT-3TC-EFV')) AS 'AZT+3TC+EFV',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'ABC-3TC-NVP')) AS 'ABC+3TC+NVP',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'ABC-3TC-EFV')) AS 'ABC+3TC+EFV',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'AZT-3TC-NVP')) AS 'AZT+3TC+NVP',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'ABC-3TC-ATV/r')) AS 'ABC-3TC-ATV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'TDF-3TC-NVP')) AS 'TDF+3TC+NVP',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'TDF-3TC-DRV/r')) AS 'TDF+3TC+DRV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'AZT-3TC-ATV/r')) AS 'AZT+3TC+ATV/r',                                                                                                                                 
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'TDF-3TC-ATV/r')) AS 'TDF+3TC+ATV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'TDF-3TC-LPV/r')) AS 'TDF+3TC+LPV/r',            
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg = 'AZT-TDF-3TC-LPV/r')) AS 'AZT-TDF-3TC-LPV/r',
COALESCE(SUM(
            CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 15 AND 19
            AND CurrentARTReg NOT IN ('ABC-3TC-LPV/r', 'ABC-3TC-DTG', 'TDF-3TC-DTG', 
            'AZT-3TC-LPV/r', 'ABC-3TC-AZT', 'TDF-3TC-EFV', 'AZT-3TC-EFV', 'ABC-3TC-NVP', 
            'ABC-3TC-EFV', 'AZT-3TC-NVP', 'ABC-3TC-ATV/r', 'TDF-3TC-NVP', 'TDF-3TC-DRV/r', 
            'AZT-3TC-ATV/r', 'TDF-3TC-ATV/r', 'TDF-3TC-LPV/r',  'AZT-TDF-3TC-LPV/r'))) AS 'Others'                
FROM linelist 
GROUP BY FacilityName ORDER BY LGA, FacilityName;

/*DROP TABLE IF EXISTS all_kg_tables;
CREATE TABLE all_kg_tables AS
select * from 20kg union all SELECT * FROM 20_30kg union all SELECT * FROM 30kg;*/


SELECT 'ABC+3TC+LPV/r' AS 'Drug', COUNT(pepid) AS 'No._on_Regimen', COUNT(`CurrentVL`) AS 'No._Documented_VL', (SELECT COUNT(a.`CurrentVL`) FROM `linelist` a 
WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'ABC-3TC-LPV/r' AND a.`CurrentVL` < 1000) AS 'No._Suppressed' 
FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'ABC-3TC-LPV/r'
UNION ALL
SELECT 'ABC+3TC+DTG' AS 'Drug', COUNT(pepid) AS 'No._on_Regimen', COUNT(`CurrentVL`) AS 'No._Documented_VL', (SELECT COUNT(a.`CurrentVL`) FROM `linelist` a 
WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'ABC-3TC-DTG' AND a.`CurrentVL` < 1000) AS 'No._Suppressed' 
FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'ABC-3TC-DTG'
UNION ALL
SELECT 'TDF+3TC+DTG' AS 'Drug', COUNT(pepid) AS 'No._on_Regimen', COUNT(`CurrentVL`) AS 'No._Documented_VL', (SELECT COUNT(a.`CurrentVL`) FROM `linelist` a 
WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'TDF-3TC-DTG' AND a.`CurrentVL` < 1000) AS 'No._Suppressed' 
FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'TDF-3TC-DTG'
UNION ALL
SELECT 'AZT+3TCLPV/r' AS 'Drug', COUNT(pepid) AS 'No._on_Regimen', COUNT(`CurrentVL`) AS 'No._Documented_VL', (SELECT COUNT(a.`CurrentVL`) FROM `linelist` a 
WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'AZT-3TC-LPV/r' AND a.`CurrentVL` < 1000) AS 'No._Suppressed' 
FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'AZT-3TC-LPV/r'
UNION ALL
SELECT 'ABC+3TC+AZT' AS 'Drug', COUNT(pepid) AS 'No._on_Regimen', COUNT(`CurrentVL`) AS 'No._Documented_VL', (SELECT COUNT(a.`CurrentVL`) FROM `linelist` a 
WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'ABC-3TC-AZT' AND a.`CurrentVL` < 1000) AS 'No._Suppressed' 
FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'ABC-3TC-AZT'
UNION ALL
SELECT 'TDF+3TC+EFV' AS 'Drug', COUNT(pepid) AS 'No._on_Regimen', COUNT(`CurrentVL`) AS 'No._Documented_VL', (SELECT COUNT(a.`CurrentVL`) FROM `linelist` a 
WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'TDF-3TC-EFV' AND a.`CurrentVL` < 1000) AS 'No._Suppressed' 
FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'TDF-3TC-EFV'
UNION ALL
SELECT 'AZT+3TC+EFV' AS 'Drug', COUNT(pepid) AS 'No._on_Regimen', COUNT(`CurrentVL`) AS 'No._Documented_VL', (SELECT COUNT(a.`CurrentVL`) FROM `linelist` a 
WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'AZT-3TC-EFV' AND a.`CurrentVL` < 1000) AS 'No._Suppressed' 
FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'AZT-3TC-EFV'
UNION ALL
SELECT 'ABC+3TC+NVP' AS 'Drug', COUNT(pepid) AS 'No._on_Regimen', COUNT(`CurrentVL`) AS 'No._Documented_VL', (SELECT COUNT(a.`CurrentVL`) FROM `linelist` a 
WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'ABC-3TC-NVP' AND a.`CurrentVL` < 1000) AS 'No._Suppressed' 
FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'ABC-3TC-NVP'
UNION ALL
SELECT 'ABC+3TC+EFV' AS 'Drug', COUNT(pepid) AS 'No._on_Regimen', COUNT(`CurrentVL`) AS 'No._Documented_VL', (SELECT COUNT(a.`CurrentVL`) FROM `linelist` a 
WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'ABC-3TC-EFV' AND a.`CurrentVL` < 1000) AS 'No._Suppressed' 
FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'ABC-3TC-EFV'
UNION ALL
SELECT 'AZT+3TC+NVP' AS 'Drug', COUNT(pepid) AS 'No._on_Regimen', COUNT(`CurrentVL`) AS 'No._Documented_VL', (SELECT COUNT(a.`CurrentVL`) FROM `linelist` a 
WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'AZT-3TC-NVP' AND a.`CurrentVL` < 1000) AS 'No._Suppressed' 
FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg = 'AZT-3TC-NVP'
UNION ALL
SELECT 'Others' AS 'Drug', COUNT(pepid) AS 'No._on_Regimen', COUNT(`CurrentVL`) AS 'No._Documented_VL', (SELECT COUNT(a.`CurrentVL`) FROM `Linelist` a 
WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg IN 
('ABC-3TC-ATV/r', 'TDF-3TC-NVP', 'TDF-3TC-DRV/r', 'AZT-3TC-ATV/r', 'TDF-3TC-ATV/r', 'TDF-3TC-LPV/r', 'AZT-TDF-3TC-LPV/r') AND a.`CurrentVL` < 1000) AS 'No._Suppressed' 
FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 14 AND CurrentARTReg IN 
('ABC-3TC-ATV/r', 'TDF-3TC-NVP', 'TDF-3TC-DRV/r', 'AZT-3TC-ATV/r', 'TDF-3TC-ATV/r', 'TDF-3TC-LPV/r', 'AZT-TDF-3TC-LPV/r');


/*select 'ABC+3TC+LPV/r' as 'Drug', sum(`ABC+3TC+LPV/r`) as 'No._on_Regimen' from all_kg_tables
union all
SELECT 'ABC+3TC+DTG' AS 'Drug', SUM(`ABC+3TC+DTG`) FROM all_kg_tables
UNION ALL
SELECT 'TDF+3TC+DTG' AS 'Drug', SUM(`TDF+3TC+DTG`) FROM all_kg_tables
UNION ALL
SELECT 'AZT+3TC+LPV/r' AS 'Drug', SUM(`AZT+3TC+LPV/r`) FROM all_kg_tables
UNION ALL
SELECT 'ABC+3TC+AZT' AS 'Drug', SUM(`ABC+3TC+AZT`) FROM all_kg_tables
UNION ALL
SELECT 'TDF+3TC+EFV' AS 'Drug', SUM(`TDF+3TC+EFV`) FROM all_kg_tables
UNION ALL
SELECT 'AZT+3TC+EFV' AS 'Drug', SUM(`AZT+3TC+EFV`) FROM all_kg_tables
UNION ALL
SELECT 'ABC+3TC+NVP' AS 'Drug', SUM(`ABC+3TC+NVP`) FROM all_kg_tables
UNION ALL
SELECT 'ABC+3TC+EFV' AS 'Drug', SUM(`ABC+3TC+EFV`) FROM all_kg_tables
UNION ALL
SELECT 'AZT+3TC+NVP' AS 'Drug', SUM(`AZT+3TC+NVP`) FROM all_kg_tables
UNION ALL
SELECT 'Others' AS 'Drug', SUM(`ABC-3TC-ATV/r`)+sum(`TDF+3TC+NVP`)+ 
sum(`TDF+3TC+DRV/r`)+sum(`AZT+3TC+ATV/r`)+sum(`TDF+3TC+ATV/r`)+sum(`TDF+3TC+LPV/r`)
+sum(`AZT-TDF-3TC-LPV/r`) FROM all_kg_tables;



(`ABC-3TC-ATV/r`, `TDF-3TC-NVP`, `TDF-3TC-DRV/r`, `AZT-3TC-ATV/r`, `TDF-3TC-ATV/r`, `TDF-3TC-LPV/r`, `AZT-TDF-3TC-LPV/r`)
 	    


select sum(a.`ABC+3TC+DTG`), sum(b.`ABC+3TC+DTG`) from 20kg a left join 20_30kg b on a.FacilityName=b.FacilityName;*/


SELECT * FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 5
            AND CurrentARTReg = 'TDF-3TC-DTG';
            
SELECT * FROM `linelist` WHERE CurrentARTStatus_28Days LIKE 'Active' AND CurrentAge BETWEEN 0 AND 19
            AND CurrentARTReg NOT IN ('ABC-3TC-LPV/r', 'ABC-3TC-DTG', 'TDF-3TC-DTG', 
            'AZT-3TC-LPV/r', 'ABC-3TC-AZT', 'TDF-3TC-EFV', 'AZT-3TC-EFV', 'ABC-3TC-NVP', 
            'ABC-3TC-EFV', 'AZT-3TC-NVP', 'ABC-3TC-ATV/r', 'TDF-3TC-NVP', 'TDF-3TC-DRV/r', 
            'AZT-3TC-ATV/r', 'TDF-3TC-ATV/r', 'TDF-3TC-LPV/r',  'AZT-TDF-3TC-LPV/r');           