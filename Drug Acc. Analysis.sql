SELECT `State`, `SurgeCommand`, `LGA`, `FacilityName`, 
COALESCE(SUM(`Pepid_datim` LIKE '%' AND `FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30')) AS 'Total_Client_Eligible',
COALESCE(SUM((`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30') AND(`Actual_Next_Date_of_Appointment` BETWEEN '2023-04-01' AND '2023-06-30'))) AS 'Total_Client_within_FY23Q3',
COALESCE((SUM(`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30' AND `Actual_Next_Date_of_Appointment` BETWEEN '2023-04-01' AND '2023-06-30')/SUM(`Pepid_datim` LIKE '%' AND `FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30'))*100)AS'%_Clients_within_FY23Q3',
COALESCE(SUM((`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30') AND (`Actual_Next_Date_of_Appointment` >'2023-06-30'))) AS 'Total_Laterthan_FY23Q3',
COALESCE((SUM(`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30' AND`Actual_Next_Date_of_Appointment` > '2023-06-30')/SUM(`Pepid_datim` LIKE '%' AND `FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30'))*100)AS '%_Clients_within_FY23Q3',
COALESCE(SUM((`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30') AND (`Actual_Next_Date_of_Appointment` <'2023-04-01'))) AS 'Total_Before_FY23Q3',
"",
COALESCE(SUM((`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30') AND `Actual_Next_Date_of_Appointment` >'2023-06-30' AND `Interval_Actual_Next_Date_of_Appointment` <=14)) AS '<= 14 Days',
COALESCE(SUM((`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30') AND `Actual_Next_Date_of_Appointment` >'2023-06-30' AND `Interval_Actual_Next_Date_of_Appointment` BETWEEN 15 AND 30)) AS '15-30 Days',
COALESCE(SUM((`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30') AND `Actual_Next_Date_of_Appointment` >'2023-06-30' AND `Interval_Actual_Next_Date_of_Appointment` BETWEEN 31 AND 90)) AS '31-90 Days',
COALESCE(SUM((`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30') AND `Actual_Next_Date_of_Appointment` >'2023-06-30' AND `Interval_Actual_Next_Date_of_Appointment` > 90)) AS '> 90 Days',


COALESCE(SUM(`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30' AND `Actual_Nxt_Appt_Last` BETWEEN '2023-04-01' AND '2023-06-30')) AS 'LastV_Total_Client_within_FY23Q3',
COALESCE((SUM(`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30' AND `Actual_Nxt_Appt_Last` BETWEEN '2023-04-01' AND '2023-06-30')/SUM(`Pepid_datim` LIKE '%' AND `FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30'))*100)AS'LastV_%_Clients_within_FY23Q3',
COALESCE(SUM(`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30' AND `Actual_Nxt_Appt_Last` >'2023-06-30')) AS 'LastV_Total_Laterthan_FY23Q3',
COALESCE((SUM(`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30' AND `Actual_Nxt_Appt_Last` > '2023-06-30')/SUM(`Pepid_datim` LIKE '%' AND `FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30'))*100)AS 'LastV_%_Clients_within_FY23Q3',
COALESCE(SUM((`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30') AND `Actual_Nxt_Appt_Last` >'2023-06-30' AND `Interval_Actual_Nxt_Appt_Last` <=14)) AS '<= 14 Days',
COALESCE(SUM((`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30') AND `Actual_Nxt_Appt_Last` >'2023-06-30' AND `Interval_Actual_Nxt_Appt_Last` BETWEEN 15 AND 30)) AS '15-30 Days',
COALESCE(SUM((`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30') AND `Actual_Nxt_Appt_Last` >'2023-06-30' AND `Interval_Actual_Nxt_Appt_Last` BETWEEN 31 AND 90)) AS '31-90 Days',
COALESCE(SUM((`FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30') AND `Actual_Nxt_Appt_Last` >'2023-06-30' AND `Interval_Actual_Nxt_Appt_Last` > 90)) AS '> 90 Days',
COALESCE(SUM((`Current_LastPickUp` BETWEEN '2023-04-01' AND '2023-06-30'))) AS 'All_Pikup_within_FY23Q3',
COALESCE(SUM(`Pepid_datim` LIKE '%' AND `FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30' AND `Current_LastPickUp` BETWEEN '2023-04-01' AND '2023-06-30')) AS 'Eligible_PickUp',
COALESCE(SUM(`Pepid_datim` LIKE '%' AND `FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30' AND `Current_LastPickUp` < '2023-04-01' AND `Actual_Nxt_Appt_Last` >'2023-06-30')) AS 'Actually_Not_Eligible_Not_Pickup',
COALESCE(SUM(`Pepid_datim` LIKE '%' AND `FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30' AND `Current_LastPickUp` < '2023-04-01' AND `Actual_Nxt_Appt_Last` <'2023-06-30')) AS 'Actually_Eligible_Not_Pickup',
COALESCE(SUM(`Pepid_datim` LIKE '%' AND `NextAppmt_From_FY23Q2` BETWEEN '2023-04-01' AND '2023-06-30')) AS 'XXX'
FROM `Drug_Acc`
WHERE `Status` LIKE '%ctive%'
GROUP BY `FacilityName`,Pepid_datim ORDER BY LGA, `FacilityName`;

SELECT * FROM `drug_acc` WHERE `Pepid_datim` LIKE '%' AND `FY23Q2_31_March` BETWEEN '2023-04-01' AND '2023-06-30' AND `FacilityName` LIKE '%alim%' AND `Status` LIKE '%ctiv%';