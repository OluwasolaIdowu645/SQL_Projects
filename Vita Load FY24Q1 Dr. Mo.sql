SELECT `State`, `SurgeCommand`, `LGA`, `FacilityName`, 
COALESCE(SUM(`Pepid_datim` LIKE '%')) AS 'Total on Initial VL Elig List',
COALESCE(SUM((`VL ACTIVE STATUS` = "Active"))) AS 'Total Active as @ 30th Sept.',
COALESCE(SUM(`VL ACTIVE STATUS` = "Active" AND `VL LSD` BETWEEN '2023-07-01' AND '2023-09-30')) AS 'Total Bled from Active',
'' AS "%Active Bled",
COALESCE(SUM(`VL ACTIVE STATUS` = "In-Active")) AS 'Total In-Active as @ 30th Sept',
COALESCE(SUM(`VL ACTIVE STATUS` = "In-Active" AND `VL LSD` BETWEEN '2023-07-01' AND '2023-09-30')) AS 'Total Bled from In-Active',
'' AS "%In-Active Bled",
COALESCE(SUM(`VL ACTIVE STATUS` IN ("Dead", "Stopped", "Transferred Out"))) AS 'Total DTS as @ 30th Sept',
COALESCE(SUM(`VL ACTIVE STATUS` IN ("Dead", "Stopped", "Transferred Out") AND `VL LSD` BETWEEN '2023-07-01' AND '2023-09-30')) AS 'Total Bled from DTS',
'' AS "%DTS Bled",
COALESCE(SUM(`VL ACTIVE STATUS` IN ("#N/A"))) AS 'Total Not Found as @ 30th Sept',
COALESCE(SUM(`VL ACTIVE STATUS` IN ("#N/A") AND `VL LSD` BETWEEN '2023-07-01' AND '2023-09-30')) AS 'Total Bled from Not Found',
'' AS "%Not Found Bled"
FROM `state vl eligible` GROUP BY `FacilityName` ORDER BY LGA, `FacilityName`;


SELECT `State`, `SurgeCommand`, `LGA`, `FacilityName`, 
COALESCE(SUM(`Pepid_datim` LIKE '%' AND `CurrentARTStatus_28Days` = "Active")) AS 'Tx_Curr',
COALESCE(SUM(`Pepid_datim` LIKE '%' AND `CurrentARTStatus_28Days` = "Active" AND `Sex`="Male" AND `CurrentAge` < 18)) AS 'Male <18',
COALESCE(SUM(`Pepid_datim` LIKE '%' AND `CurrentARTStatus_28Days` = "Active" AND `Sex`="Male" AND `CurrentAge` >= 18)) AS 'Male >=18',
COALESCE(SUM(`Pepid_datim` LIKE '%' AND `CurrentARTStatus_28Days` = "Active" AND `Sex`="Female" AND `CurrentAge` < 18)) AS 'Female <18',
COALESCE(SUM(`Pepid_datim` LIKE '%' AND `CurrentARTStatus_28Days` = "Active" AND `Sex`="Female" AND `CurrentAge` >= 18)) AS 'Female >=18'
FROM `linelist_dr_emma` GROUP BY `FacilityName` ORDER BY LGA, `FacilityName`;

/*
update `30th_september_2023` a
join `linelist_dr_emma` b on a.`Pepid_datim`=b.`Pepid_datim`
set a.`VL_Eligible_IDs` = b.`Pepid_datim`
where a.`Pepid_datim`=b.`Pepid_datim`;*/

SELECT `State`, `SurgeCommand`, `LGA`, `FacilityName`, 
COALESCE(SUM(`Last_VL_Sample_Date` BETWEEN '2023-07-01' AND '2023-09-30')) AS 'Total VL Sample taken in FY23 Q4',
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%')) AS 'Total Client VL Eligible (4 Clients not existing)',
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' AND `Last_VL_Sample_Date` BETWEEN '2023-07-01' AND '2023-09-30')) AS 'Total VL Sample Taken from Eligibility list',
COALESCE(SUM(`VL_Eligible_IDs` IS NULL AND `Last_VL_Sample_Date` BETWEEN '2023-07-01' AND '2023-09-30')) AS 'Total VL Sample Taken Outside Eligibility list',
'' AS "%Not Found Bled"
FROM `30th_september_2023` GROUP BY `FacilityName` ORDER BY LGA, `FacilityName`;


SELECT `State`, `SurgeCommand`, `LGA`, `FacilityName`, 
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%')) AS 'Total Client VL Eligible',
COALESCE(SUM(`Last_VL_Sample_Date` BETWEEN '2023-10-01' AND '2023-12-30')) AS 'Total VL Sample taken in FY23 Q4',
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' AND `Last_VL_Sample_Date` BETWEEN '2023-10-01' AND '2023-12-30')) AS 'Total VL Sample Taken from Eligibility list',
COALESCE(SUM(`VL_Eligible_IDs` IS NULL AND `Last_VL_Sample_Date` BETWEEN '2023-10-01' AND '2023-12-30')) AS 'Total VL Sample Taken Outside Eligibility list',
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' AND `CurrentARTStatus_28Days` = 'In-Active')) AS 'Total Inactive VL Eligible Client',
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' AND `CurrentARTStatus_28Days` = 'In-Active' AND `Last_VL_Sample_Date` BETWEEN '2023-10-01' AND '2023-12-30')) AS 'Total Inactive VL Eligible Client Bled',
'' AS "%Not Found Bled"
FROM `FY24Q1` GROUP BY `FacilityName` ORDER BY LGA, `FacilityName`;



SELECT `State`, `SurgeCommand`, `LGA`, `FacilityName`, 
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%')) AS 'Total Client VL Eligible (1 Pepid Change in LASUTH)',

COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' and `Last_VL_Sample_Date` BETWEEN '2023-07-01' AND '2023-09-30')) AS 'Total VL Sample taken in FY23 Q4 on VL_Elig. List',
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' AND `DateOfCurrentVL` BETWEEN '2023-01-01' AND '2023-09-30')) AS 'Total Valid VL Result in FY23 Q4 on VL_Elig. List',
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' AND `CurrentARTStatus_28Days` = 'Dead')) AS 'Total Dead in FY23 Q4 on VL_Elig. List',
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' AND `CurrentARTStatus_28Days` = 'Stopped')) AS 'Total Stopped in FY23 Q4 on VL_Elig. List',
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' AND `CurrentARTStatus_28Days` = 'Transferred Out')) AS 'Total T.O in FY23 Q4 on VL_Elig. List',
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' AND `ARTStartDate` >= '2023-07-01')) AS 'Total Lessthan 6 month on ART in FY23 Q4 on VL_Elig. List',
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' AND `CurrentARTStatus_28Days` = 'In-Active')) AS 'Total In-Active on VL_Elig. List as @ 30th Sept.',
'' AS 'Break',
COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' AND `CurrentARTStatus_28Days` = 'Active')) AS 'Total Active on VL_Elig. List as @ 30th Sept.',

COALESCE(SUM(`VL_Eligible_IDs` LIKE '%' AND `CurrentARTStatus_28Days` = 'Active' AND (`Last_VL_Sample_Date` < '2023-07-01' OR Last_VL_Sample_Date IS NULL) 
AND (`DateOfCurrentVL` < '2023-01-01' or DateOfCurrentVL is null AND `ARTStartDate` < '2023-07-01'))) AS 'Total Actual VL Eligible'

FROM `30th_september_2023` GROUP BY `FacilityName` ORDER BY LGA, `FacilityName`;


select * from `30th_september_2023` where `VL_Eligible_IDs` LIKE '%' AND `CurrentARTStatus_28Days` = 'Active' AND (`Last_VL_Sample_Date` < '2023-07-01' OR Last_VL_Sample_Date IS NULL) 
AND (`DateOfCurrentVL` NOT BETWEEN '2023-01-01' AND '2023-09-30' OR DateOfCurrentVL IS NULL AND `ARTStartDate` < '2023-07-01');




SELECT `State`, `SurgeCommand`, `LGA`, `FacilityName`, 
COALESCE(SUM(`Pepid_datim` LIKE '%' AND `CurrentARTStatus_28Days` = 'Active' AND (`Last_VL_Sample_Date` < '2023-07-01' OR Last_VL_Sample_Date IS NULL) 
AND (`DateOfCurrentVL` < '2023-01-01' OR DateOfCurrentVL IS NULL AND `ARTStartDate` <= '2023-06-30'))) AS 'Total Actual VL Eligible'
FROM `30th_september_2023` GROUP BY `FacilityName` ORDER BY LGA, `FacilityName`;

select * from `30th_september_2023` where `Pepid_datim` LIKE '%' AND `CurrentARTStatus_28Days` = 'Active' AND (`Last_VL_Sample_Date` < '2023-07-01' OR Last_VL_Sample_Date IS NULL) 
AND (`DateOfCurrentVL` < '2023-01-01' OR DateOfCurrentVL IS NULL) AND `ARTStartDate` <= '2023-06-30';



SELECT `State`, `SurgeCommand`, `LGA`, `FacilityName`,
COALESCE(SUM(`New VL Elig from 30th Sept` LIKE '%')) as 'Total VL Elig', 
COALESCE(SUM(`New VL Elig from 30th Sept` LIKE '%' and `Last_VL_Sample_Date` between '2023-10-01' and '2023-12-31')) AS 'Total Bled', 
COALESCE(SUM(`New VL Elig from 30th Sept` LIKE '%' AND `CurrentARTStatus_28Days` = 'Active')) AS 'Total Active from VL Elig. as @ 6th',
COALESCE(SUM(`New VL Elig from 30th Sept` LIKE '%' AND `CurrentARTStatus_28Days` = 'Active' AND `Last_VL_Sample_Date` BETWEEN '2023-10-01' AND '2023-12-31')) AS 'Total Active bled from VL Elig. as @ 6th',
COALESCE(SUM(`New VL Elig from 30th Sept` LIKE '%' AND `CurrentARTStatus_28Days` = 'In-Active')) AS 'Total In-Active from VL Elig. as @ 6th',
COALESCE(SUM(`New VL Elig from 30th Sept` LIKE '%' AND `CurrentARTStatus_28Days` = 'Stopped')) AS 'Total Stopped from VL Elig. as @ 6th',
COALESCE(SUM(`New VL Elig from 30th Sept` LIKE '%' AND `CurrentARTStatus_28Days` = 'Dead')) AS 'Total Dead from VL Elig. as @ 6th',
COALESCE(SUM(`New VL Elig from 30th Sept` LIKE '%' AND `CurrentARTStatus_28Days` = 'Transferred Out')) AS 'Total T.O from VL Elig. as @ 6th',

COALESCE(SUM(`Pepid_datim` LIKE '%' AND `FY23Q4` IN ('In-Active', 'Stopped', 'Transferred Out') AND `CurrentARTStatus_28Days` = 'Active' AND (`Last_VL_Sample_Date` < '2023-07-01' OR Last_VL_Sample_Date IS NULL) 
AND (`DateOfCurrentVL` < '2023-01-01' OR DateOfCurrentVL IS NULL AND `ARTStartDate` <= '2023-06-30') and `datediff_mysql`<=28)) AS 'Total RTT < 28 days from VL Elig. as @ 6th',

COALESCE(SUM(`Pepid_datim` LIKE '%' AND `FY23Q4` IN ('In-Active', 'Stopped', 'Transferred Out') AND `CurrentARTStatus_28Days` = 'Active' AND (`Last_VL_Sample_Date` < '2023-07-01' OR Last_VL_Sample_Date IS NULL) 
AND (`DateOfCurrentVL` < '2023-01-01' OR DateOfCurrentVL IS NULL AND `ARTStartDate` <= '2023-06-30') AND `datediff_mysql` > 28)) AS 'Total RTT < 28 days from VL Elig. as @ 6th',

COALESCE(SUM(`Pepid_datim` LIKE '%' AND `FY23Q4` IN ('In-Active', 'Stopped', 'Transferred Out') AND `CurrentARTStatus_28Days` = 'Active' 
AND (`Last_VL_Sample_Date` between '2023-10-01' and '2023-12-31'))) AS 'Total RTT Bled',

COALESCE(SUM(`Pepid_datim` LIKE '%' AND `FY23Q4` in ('In-Active', 'Stopped', 'Transferred Out') AND `CurrentARTStatus_28Days` = 'Active' and (`Last_VL_Sample_Date` <= '2023-06-31' OR Last_VL_Sample_Date IS NULL) 
AND (`DateOfCurrentVL` <= '2022-12-31' OR DateOfCurrentVL IS NULL AND `ARTStartDate` <= '2023-06-31'))) AS 'Total RTT from VL Elig. as @ 6th'
FROM `fy24q1` GROUP BY `FacilityName` ORDER BY LGA, `FacilityName`;


SELECT * FROM `fy24q1` WHERE `Pepid_datim` LIKE '%' AND `FY23Q4` IN ('In-Active', 'Stopped', 'Transferred Out') AND `CurrentARTStatus_28Days` = 'Active' 
AND (`Last_VL_Sample_Date` BETWEEN '2023-10-01' AND '2023-12-31');

SELECT * FROM `fy24q1` WHERE `New VL Elig from 30th Sept` LIKE '%' AND `CurrentARTStatus_28Days` = 'Active';

SELECT * FROM `fy24q1` WHERE `Pepid_datim` LIKE '%' AND `FY23Q4` IN ('In-Active', 'Stopped', 'Transferred Out') AND `CurrentARTStatus_28Days` = 'Active' AND (`Last_VL_Sample_Date` < '2023-07-01' OR Last_VL_Sample_Date IS NULL) 
AND (`DateOfCurrentVL` < '2023-01-01' OR DateOfCurrentVL IS NULL AND `ARTStartDate` <= '2023-06-30') AND `datediff_mysql`<=28;