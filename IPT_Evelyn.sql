SET @IPT_Reporting_Date := '2021-03-31';
SET @IPTStartDate := DATE(DATE(@IPT_Reporting_Date -INTERVAL 12 MONTH)+INTERVAL 1 DAY);
DROP TABLE IF EXISTS _IPT;
CREATE TEMPORARY TABLE _IPT AS
SELECT patient_id, e.`encounter_datetime`, e.`encounter_id`, o.`value_datetime`, O.OBS_ID FROM encounter e
LEFT JOIN `obs` o ON o.`person_id`=e.`patient_id` AND o.`encounter_id`=e.`encounter_id`
WHERE o.concept_id = 165994 AND e.`encounter_type` = 23
AND e.`form_id` = 53 AND o.`voided`= 0 AND e.`encounter_datetime` BETWEEN @IPTStartDate AND @IPT_Reporting_Date
GROUP BY patient_id, e.`encounter_datetime`,o.`value_datetime`;
DROP TABLE IF EXISTS Outcome_of_IPT;
CREATE TEMPORARY TABLE Outcome_of_IPT AS
SELECT o.`person_id`, ConceptName(o.`value_coded`) AS 'Outcome_of_IPT', o.`obs_datetime`,o.encounter_id FROM _IPT e
LEFT JOIN obs o ON o.`encounter_id`=e.`encounter_id` WHERE o.concept_id = 166007 AND o.`voided`= 0;
DROP TABLE IF EXISTS Date_of_Outcome;
CREATE TEMPORARY TABLE Date_of_Outcome AS 
SELECT o.`person_id`, o.`value_datetime` AS 'Date_of_Outcome', o.`obs_datetime`,o.encounter_id FROM _IPT e
LEFT JOIN obs o ON o.`encounter_id`=e.`encounter_id` WHERE o.concept_id = 166008 AND o.`voided`= 0;
SET SESSION sql_mode = '';
DROP TABLE IF EXISTS Combine_TB;
CREATE TEMPORARY TABLE Combine_TB AS
SELECT a.patient_id, a.encounter_datetime, a.encounter_id, a.value_datetime Date_IPT_start, b.Outcome_of_IPT, Date_of_Outcome
FROM _IPT a
LEFT JOIN Outcome_of_IPT b ON a.patient_id=b.person_id AND a.encounter_id=b.encounter_id
LEFT JOIN Date_of_Outcome c ON a.patient_id=c.person_id AND a.encounter_id=c.encounter_id;
SET SESSION sql_mode = '';
DROP TABLE IF EXISTS Combine_TB2;
CREATE TEMPORARY TABLE Combine_TB2 AS
SELECT b.`identifier` PEPID, e.patient_id, COUNT(e.patient_id) No_of_IPT_Entry, e.encounter_datetime,
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-04-%' THEN a.Date_IPT_start ELSE NULL END) AS '2020-04',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-04-%' THEN a.Outcome_of_IPT ELSE NULL END) AS '2020-04_Outcome_of_IPT',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-04-%' THEN a.Date_of_Outcome ELSE NULL END) AS '2020-04_Date_of_Outcome',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-05-%' THEN a.Date_IPT_start ELSE NULL END) AS '2020-05',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-05-%' THEN a.Outcome_of_IPT ELSE NULL END) AS '2020-05_Outcome_of_IPT',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-05-%' THEN a.Date_of_Outcome ELSE NULL END) AS '2020-05_Date_of_Outcome',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-06-%' THEN a.Date_IPT_start ELSE NULL END) AS '2020-06',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-06-%' THEN a.Outcome_of_IPT ELSE NULL END) AS '2020-06_Outcome_of_IPT',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-06-%' THEN a.Date_of_Outcome ELSE NULL END) AS '2020-06_Date_of_Outcome',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-07-%' THEN a.Date_IPT_start ELSE NULL END) AS '2020-07',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-07-%' THEN a.Outcome_of_IPT ELSE NULL END) AS '2020-07_Outcome_of_IPT',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-07-%' THEN a.Date_of_Outcome ELSE NULL END) AS '2020-07_Date_of_Outcome',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-08-%' THEN a.Date_IPT_start ELSE NULL END) AS '2020-08',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-08-%' THEN a.Outcome_of_IPT ELSE NULL END) AS '2020-08_Outcome_of_IPT',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-08-%' THEN a.Date_of_Outcome ELSE NULL END) AS '2020-08_Date_of_Outcome',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-09-%' THEN a.Date_IPT_start ELSE NULL END) AS '2020-09',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-09-%' THEN a.Outcome_of_IPT ELSE NULL END) AS '2020-09_Outcome_of_IPT',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-09-%' THEN a.Date_of_Outcome ELSE NULL END) AS '2020-09_Date_of_Outcome',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-10-%' THEN a.Date_IPT_start ELSE NULL END) AS '2020-10',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-10-%' THEN a.Outcome_of_IPT ELSE NULL END) AS '2020-10_Outcome_of_IPT',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-10-%' THEN a.Date_of_Outcome ELSE NULL END) AS '2020-10_Date_of_Outcome',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-11-%' THEN a.Date_IPT_start ELSE NULL END) AS '2020-11',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-11-%' THEN a.Outcome_of_IPT ELSE NULL END) AS '2020-11_Outcome_of_IPT',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-11-%' THEN a.Date_of_Outcome ELSE NULL END) AS '2020-11_Date_of_Outcome',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-12-%' THEN a.Date_IPT_start ELSE NULL END) AS '2020-12',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-12-%' THEN a.Outcome_of_IPT ELSE NULL END) AS '2020-12_Outcome_of_IPT',
MAX(CASE WHEN a.Date_IPT_start LIKE '2020-12-%' THEN a.Date_of_Outcome ELSE NULL END) AS '2020-12_Date_of_Outcome',
MAX(CASE WHEN a.Date_IPT_start LIKE '2021-01-%' THEN a.Date_IPT_start ELSE NULL END) AS '2021-01',
MAX(CASE WHEN a.Date_IPT_start LIKE '2021-01-%' THEN a.Outcome_of_IPT ELSE NULL END) AS '2021-01_Outcome_of_IPT',
MAX(CASE WHEN a.Date_IPT_start LIKE '2021-01-%' THEN a.Date_of_Outcome ELSE NULL END) AS '2021-01_Date_of_Outcome',
MAX(CASE WHEN a.Date_IPT_start LIKE '2021-02-%' THEN a.Date_IPT_start ELSE NULL END) AS '2021-02',
MAX(CASE WHEN a.Date_IPT_start LIKE '2021-02-%' THEN a.Outcome_of_IPT ELSE NULL END) AS '2021-02_Outcome_of_IPT',
MAX(CASE WHEN a.Date_IPT_start LIKE '2021-02-%' THEN a.Date_of_Outcome ELSE NULL END) AS '2021-02_Date_of_Outcome',
MAX(CASE WHEN a.Date_IPT_start LIKE '2021-03-%' THEN a.Date_IPT_start ELSE NULL END) AS '2021-03',
MAX(CASE WHEN a.Date_IPT_start LIKE '2021-03-%' THEN a.Outcome_of_IPT ELSE NULL END) AS '2021-03_Outcome_of_IPT',
MAX(CASE WHEN a.Date_IPT_start LIKE '2021-03-%' THEN a.Date_of_Outcome ELSE NULL END) AS '2021-03_Date_of_Outcome'
FROM _IPT e
LEFT JOIN Combine_TB a ON a.patient_id=e.patient_id
LEFT JOIN `patient_identifier` b ON a.`patient_id` = b.`patient_id` AND `identifier_type`=4 AND `voided`=0
GROUP BY a.patient_id,e.`encounter_id`;
SELECT * FROM Combine_TB2 GROUP BY patient_id;