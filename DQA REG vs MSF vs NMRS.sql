SELECT 'Number of clients tested HIV negative and documented in HTS reg'AS'',
COALESCE(SUM(`VisitDate` LIKE '2021-07%' AND `HIV_FinalResult`='Negative')) AS 'Jul-21',
COALESCE(SUM(`VisitDate` LIKE '2021-08%' AND `HIV_FinalResult`='Negative')) AS 'Aug-21',
COALESCE(SUM(`VisitDate` LIKE '2021-09%' AND `HIV_FinalResult`='Negative')) AS 'Sep-21'
FROM `dqa_hts`
UNION ALL
SELECT 'Number of clients tested HIV positive and documented in HTS reg(New +ve only)'AS'',
COALESCE(SUM(`VisitDate` LIKE '2021-07%' AND `HIV_FinalResult`='Positive')) AS 'Jul-21',
COALESCE(SUM(`VisitDate` LIKE '2021-08%' AND `HIV_FinalResult`='Positive')) AS 'Aug-21',
COALESCE(SUM(`VisitDate` LIKE '2021-09%' AND `HIV_FinalResult`='Positive')) AS 'Sep-21'
FROM `dqa_hts`
UNION ALL
SELECT 'Number of index cases offered index testing services (including adherence settings)'AS'',
COALESCE(SUM(`VisitDate` LIKE '2021-07%' AND `FromIndex` ='Yes')) AS 'Jul-21',
COALESCE(SUM(`VisitDate` LIKE '2021-08%' AND `FromIndex` ='Yes')) AS 'Aug-21',
COALESCE(SUM(`VisitDate` LIKE '2021-09%' AND `FromIndex` ='Yes')) AS 'Sep-21'
FROM `dqa_hts`
UNION ALL
SELECT 'Number of index cases that accepted index testing services'AS'',
COALESCE(SUM(`VisitDate` LIKE '2021-07%' AND `FromIndex` ='Yes')) AS 'Jul-21',
COALESCE(SUM(`VisitDate` LIKE '2021-08%' AND `FromIndex` ='Yes')) AS 'Aug-21',
COALESCE(SUM(`VisitDate` LIKE '2021-09%' AND `FromIndex` ='Yes')) AS 'Sep-21'
FROM `dqa_hts`
UNION ALL
SELECT 'Number of contacts & boilogical children tested (POS+)'AS'',
COALESCE(SUM(`VisitDate` LIKE '2021-07%' AND `FromIndex` ='Yes' AND `HIV_FinalResult`='Positive')) AS 'Jul-21',
COALESCE(SUM(`VisitDate` LIKE '2021-08%' AND `FromIndex` ='Yes' AND `HIV_FinalResult`='Positive')) AS 'Aug-21',
COALESCE(SUM(`VisitDate` LIKE '2021-09%' AND `FromIndex` ='Yes' AND `HIV_FinalResult`='Positive')) AS 'Sep-21'
FROM `dqa_hts`
UNION ALL
SELECT 'Number of contacts & biological children tested (NEG)'AS'',
COALESCE(SUM(`VisitDate` LIKE '2021-07%' AND `FromIndex` ='Yes' AND `HIV_FinalResult`='Negative')) AS 'Jul-21',
COALESCE(SUM(`VisitDate` LIKE '2021-08%' AND `FromIndex` ='Yes' AND `HIV_FinalResult`='Negative')) AS 'Aug-21',
COALESCE(SUM(`VisitDate` LIKE '2021-09%' AND `FromIndex` ='Yes' AND `HIV_FinalResult`='Negative')) AS 'Sep-21'
FROM `dqa_hts`
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL 
SELECT 'Number of  pregnant women tested for HIV (excluding known pos)'AS'',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-07%' AND (`Previously_Known_HIV_Status` ='No' OR `Previously_Known_HIV_Status` IS NULL))) AS 'Jul-21',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-08%' AND (`Previously_Known_HIV_Status` ='No' OR `Previously_Known_HIV_Status` IS NULL))) AS 'Aug-21',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-09%' AND (`Previously_Known_HIV_Status` ='No' OR `Previously_Known_HIV_Status` IS NULL))) AS 'Sep-21'
FROM `dqa_pmtct`
UNION ALL
SELECT 'Number of  pregnant women were newly tested HIV positive)'AS'',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-07%' AND `ResultOfHIVTest`='Positive' AND (`Previously_Known_HIV_Status` ='No' OR `Previously_Known_HIV_Status` IS NULL))) AS 'Jul-21',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-08%' AND `ResultOfHIVTest`='Positive' AND (`Previously_Known_HIV_Status` ='No' OR `Previously_Known_HIV_Status` IS NULL))) AS 'Aug-21',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-09%' AND `ResultOfHIVTest`='Positive' AND (`Previously_Known_HIV_Status` ='No' OR `Previously_Known_HIV_Status` IS NULL))) AS 'Sep-21'
FROM `dqa_pmtct`
UNION ALL
SELECT 'Number of  pregnant women were newly tested HIV Negative)'AS'',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-07%' AND `ResultOfHIVTest`='Negative' AND (`Previously_Known_HIV_Status` ='No' OR `Previously_Known_HIV_Status` IS NULL))) AS 'Jul-21',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-08%' AND `ResultOfHIVTest`='Negative' AND (`Previously_Known_HIV_Status` ='No' OR `Previously_Known_HIV_Status` IS NULL))) AS 'Aug-21',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-09%' AND `ResultOfHIVTest`='Negative' AND (`Previously_Known_HIV_Status` ='No' OR `Previously_Known_HIV_Status` IS NULL))) AS 'Sep-21'
FROM `dqa_pmtct` 
UNION ALL
SELECT 'Number of  pregnant women with previoulsy Known HIV-positive status)'AS'',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-07%' AND `ResultOfHIVTest`='positive' AND (`Previously_Known_HIV_Status` ='Yes'))) AS 'Jul-21',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-08%' AND `ResultOfHIVTest`='positive' AND (`Previously_Known_HIV_Status` ='Yes' ))) AS 'Aug-21',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-09%' AND `ResultOfHIVTest`='positive' AND (`Previously_Known_HIV_Status` ='Yes' ))) AS 'Sep-21'
FROM `dqa_pmtct`
UNION ALL
SELECT'','','',''
UNION ALL
SELECT 'Number of  HIV-positive pregnant women who were (Already) on ART/ARV at ANC to reduce the risk of mother-to-child-transmission'AS'',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-07%' AND `PEPFAR_Number(IfOnART)` IS NOT NULL)) AS 'Jul-21',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-08%' AND `PEPFAR_Number(IfOnART)` IS NOT NULL)) AS 'Aug-21',
COALESCE(SUM(`PMTCT_HTS_Date` LIKE '2021-09%' AND `PEPFAR_Number(IfOnART)` IS NOT NULL)) AS 'Sep-21'
FROM `dqa_pmtct`
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL
SELECT'','','',''
UNION ALL
SELECT 'Number of adult and children were commenced  on ART)'AS'',
COALESCE(SUM(`ARTStartDate` LIKE '2021-07%')) AS 'Jul-21',
COALESCE(SUM(`ARTStartDate` LIKE '2021-08%')) AS 'Aug-21',
COALESCE(SUM(`ARTStartDate` LIKE '2021-09%')) AS 'Sep-21'
FROM `dqa_linelist`;
 
  
/*TB PREV and TX TB*/
SELECT 'Number of  ART patients started IPT 'AS'',
COALESCE(SUM(`Date_IPT_start` LIKE '2020-10%')) AS 'Oct-20',
COALESCE(SUM(`Date_IPT_start` LIKE '2020-11%')) AS 'Nov-20',
COALESCE(SUM(`Date_IPT_start` LIKE '2020-12%')) AS 'Dec-20',
COALESCE(SUM(`Date_IPT_start` LIKE '2021-01%')) AS 'Jan-21',
COALESCE(SUM(`Date_IPT_start` LIKE '2021-02%')) AS 'Feb-21',
COALESCE(SUM(`Date_IPT_start` LIKE '2021-03%')) AS 'March-21'
FROM `dqa_linelist`
UNION ALL
SELECT'','','','','','',''
UNION ALL
SELECT 'Number of  ART patients started and completed IPT 6-months post-IPT commencement'AS'',
COALESCE(SUM(`Date_of_Outcome` LIKE '2021-04%' AND `Outcome_of_IPT`='IPT Completed')) AS 'April-21',
COALESCE(SUM(`Date_of_Outcome` LIKE '2021-05%' AND `Outcome_of_IPT`='IPT Completed')) AS 'May-21',
COALESCE(SUM(`Date_of_Outcome` LIKE '2021-06%' AND `Outcome_of_IPT`='IPT Completed')) AS 'Jun-21',
COALESCE(SUM(`Date_of_Outcome` LIKE '2021-07%' AND `Outcome_of_IPT`='IPT Completed')) AS 'Jul-21',
COALESCE(SUM(`Date_of_Outcome` LIKE '2021-08%' AND `Outcome_of_IPT`='IPT Completed')) AS 'Aug-21',
COALESCE(SUM(`Date_of_Outcome` LIKE '2021-09%' AND `Outcome_of_IPT`='IPT Completed')) AS 'Sep-21'
FROM `dqa_linelist`
UNION ALL
SELECT 'Number of People in HIV care with sign and symptoms of TB (Presumptive TB ) 'AS'',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-04%' AND `Last_TB_Screening_Status`='Disease suspected')) AS 'April-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-05%' AND `Last_TB_Screening_Status`='Disease suspected')) AS 'May-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-06%' AND `Last_TB_Screening_Status`='Disease suspected')) AS 'Jun-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-07%' AND `Last_TB_Screening_Status`='Disease suspected')) AS 'Jul-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-08%' AND `Last_TB_Screening_Status`='Disease suspected')) AS 'Aug-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-09%' AND `Last_TB_Screening_Status`='Disease suspected')) AS 'Sep-21'
FROM `dqa_linelist`
UNION ALL
SELECT 'Number of presumptive TB cases evaluated for TB 'AS'',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-04%' AND `Last_TB_Screening_Status`='Disease suspected' AND `TB_Investigations` IS NOT NULL)) AS 'April-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-05%' AND `Last_TB_Screening_Status`='Disease suspected' AND `TB_Investigations` IS NOT NULL)) AS 'May-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-06%' AND `Last_TB_Screening_Status`='Disease suspected' AND `TB_Investigations` IS NOT NULL)) AS 'Jun-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-07%' AND `Last_TB_Screening_Status`='Disease suspected' AND `TB_Investigations` IS NOT NULL)) AS 'Jul-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-08%' AND `Last_TB_Screening_Status`='Disease suspected' AND `TB_Investigations` IS NOT NULL)) AS 'Aug-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-09%' AND `Last_TB_Screening_Status`='Disease suspected' AND `TB_Investigations` IS NOT NULL)) AS 'Sep-21'
FROM `dqa_linelist`
UNION ALL
SELECT 'Number diagnosed with activeTB'AS'',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-04%' AND `Last_TB_Screening_Status`='Disease suspected' AND `Investig_Result` IN ('MTB Detected, Suggestive', 'MTB Detected'))) AS 'April-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-05%' AND `Last_TB_Screening_Status`='Disease suspected' AND `Investig_Result` IN ('MTB Detected, Suggestive', 'MTB Detected'))) AS 'May-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-06%' AND `Last_TB_Screening_Status`='Disease suspected' AND `Investig_Result` IN ('MTB Detected, Suggestive', 'MTB Detected'))) AS 'Jun-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-07%' AND `Last_TB_Screening_Status`='Disease suspected' AND `Investig_Result` IN ('MTB Detected, Suggestive', 'MTB Detected'))) AS 'Jul-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-08%' AND `Last_TB_Screening_Status`='Disease suspected' AND `Investig_Result` IN ('MTB Detected, Suggestive', 'MTB Detected'))) AS 'Aug-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-09%' AND `Last_TB_Screening_Status`='Disease suspected' AND `Investig_Result` IN ('MTB Detected, Suggestive', 'MTB Detected'))) AS 'Sep-21'
FROM `dqa_linelist`
UNION ALL
SELECT 'Number of People in HIV care with sign and symptoms of TB (Presumptive TB ) 'AS'',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-04%' AND `Last_TB_Screening_Status`='On treatment for disease')) AS 'April-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-05%' AND `Last_TB_Screening_Status`='On treatment for disease')) AS 'May-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-06%' AND `Last_TB_Screening_Status`='On treatment for disease')) AS 'Jun-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-07%' AND `Last_TB_Screening_Status`='On treatment for disease')) AS 'Jul-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-08%' AND `Last_TB_Screening_Status`='On treatment for disease')) AS 'Aug-21',
COALESCE(SUM(`Last_TB_Screening_Date` LIKE '2021-09%' AND `Last_TB_Screening_Status`='On treatment for disease')) AS 'Sep-21'
FROM `dqa_linelist`
