DROP TABLE IF EXISTS All_IPT;
CREATE TEMPORARY TABLE All_IPT AS
SELECT * FROM (
  SELECT @row_no := IF(@prev_val = e.`patient_id` , @row_no + 1, 1) AS Occurrence, @prev_val := e.`patient_id` AS person_id,
  e.`encounter_id`, a.Eligible_For_IPT, (e.`encounter_datetime`) obs_datetime,o.`value_datetime` AS 'Date_IPT_start',b.Outcome_of_IPT, c.Date_of_Outcome
   FROM encounter e
  LEFT JOIN `obs` o ON o.`encounter_id`=e.`encounter_id`
  LEFT JOIN  (SELECT o.`person_id`, ConceptName(o.`value_coded`) AS 'Eligible_For_IPT', `obs_datetime`,e.encounter_id FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165986 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0
  AND e.`encounter_datetime` <= @Reporting_Date) a ON a.`encounter_id`=e.`encounter_id`
  LEFT JOIN (SELECT o.`person_id`, ConceptName(o.`value_coded`) AS 'Outcome_of_IPT', o.`obs_datetime`,e.encounter_id FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE o.concept_id = 166007 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0
   AND e.`encounter_datetime` <= @Reporting_Date) b ON b.`encounter_id`=e.`encounter_id`
  LEFT JOIN (SELECT o.`person_id`, o.`value_datetime` AS 'Date_of_Outcome', o.`obs_datetime`,e.encounter_id FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE o.concept_id = 166008 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0
   AND e.`encounter_datetime` <= @Reporting_Date) c ON c.`encounter_id`=e.`encounter_id`,
   (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
  WHERE o.concept_id = 165994 AND e.`encounter_type` = 23
  AND e.`form_id` = 53 AND o.`voided`= 0 AND e.`encounter_datetime` <= @Reporting_Date
  ORDER BY e.patient_id,e.`encounter_datetime` DESC) a WHERE a.Occurrence = 1;
  
  
  
  SELECT a.person_id, a.Last_TB_Screening_Date,a.Last_TB_Screening_Status FROM
(SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id, e.`encounter_datetime`,
o.`obs_datetime` Last_TB_Screening_Date,ConceptName(o.`value_coded`) Last_TB_Screening_Status
FROM `obs` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
WHERE o.`concept_id` =1659  AND e.`encounter_type` = 12 AND e.`form_id` = 14  AND o.`voided` = 0 AND o.`obs_datetime` <= @Reporting_Date
ORDER BY o.person_id, o.`obs_datetime` DESC)a 
LEFT JOIN 
WHERE a.Occurrence=1

g.Last_TB_Screening_Date, g.Last_TB_Screening_Status,
 e.TB_Investigations, e.Investig_Result, e.Date_TB_Investig
   
    LM-17-0017
DROP TABLE IF EXISTS Cihp_IPT_TB;
CREATE TEMPORARY TABLE Cihp_IPT_TB AS
SELECT a.person_id, p1.`identifier` AS PepID, c2.`name` AS Eligible_For_IPT, c.Date_IPT_start, c3.`name` AS Outcome_of_IPT, e.Date_of_Outcome, 
CONCAT_WS( ', ',f.Sputum_AFB_TB, f.GeneXpert_TB, f.Chest_Xray_TB, f.Culture_TB) AS TB_Investigations, 
CONCAT_WS( ', ', f.Sputum_AFB_Result, f.GeneXpert_Result, f.Chest_Xray_Result, f.Culture_Result) AS Investig_Result,
IF(CONCAT_WS(', ',f.Sputum_AFB_TB, f.GeneXpert_TB, f.Chest_Xray_TB, f.Culture_TB) IS NULL OR CONCAT_WS(', ',f.Sputum_AFB_TB, f.GeneXpert_TB, f.Chest_Xray_TB, f.Culture_TB) != '', f.Date_TB_Investig, '') Date_TB_Investig
FROM All_IPT a
LEFT JOIN Eligible_For_IPT b ON a.person_id=b.person_id AND a.obs_datetime=b.obs_datetime
LEFT JOIN Date_IPT_start c ON a.person_id=c.person_id AND a.obs_datetime=c.obs_datetime
LEFT JOIN Outcome_of_IPT d ON a.person_id=d.person_id AND a.obs_datetime=d.obs_datetime
LEFT JOIN Date_of_Outcome e ON a.person_id=e.person_id AND a.obs_datetime=e.obs_datetime
LEFT JOIN `concept_name` c2 ON b.Eligible_For_IPT=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1
LEFT JOIN `concept_name` c3 ON d.Outcome_of_IPT=c3.`concept_id` AND c3.locale = 'en' AND c3.locale_preferred = 1
LEFT JOIN Last_All_TB_Investig f ON a.person_id=f.person_id
LEFT JOIN `patient_identifier` p1 ON a.`person_id` = p1.`patient_id` AND p1.`identifier_type` = 4 AND p1.`preferred` = 1
GROUP BY a.person_id, a.obs_datetime  ORDER BY a.obs_datetime DESC;


SELECT a.Occurrence, a.patient_id, a.encounter_id, a.encounter_datetime Date_TB_Investig, b.Sputum_AFB_TB, c.GeneXpert_TB, d.Chest_Xray_TB, e.Culture_TB, f.Sputum_AFB_Result,
g.GeneXpert_Result, h.Chest_Xray_Result, i.Culture_Result FROM
(SELECT @row_no := IF(@prev_val = e.`patient_id` , @row_no + 1, 1) AS Occurrence, @prev_val := e.`patient_id` AS patient_id,
 e.`encounter_id`, e.`encounter_datetime`
  FROM encounter e, (SELECT @row_no := 0) X, (SELECT @prev_val := '') Y 
  WHERE e.`encounter_type` = 23
  AND e.`form_id` = 53 AND e.`voided`= 0 AND e.`encounter_datetime` <= @Reporting_Date) a
  LEFT JOIN (SELECT `person_id`, IF(`value_coded` = 1, 'Sputum_AFB_TB', 'No') AS 'Sputum_AFB_TB', o.`encounter_id`  FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166141 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) b
  ON a.patient_id=b.person_id AND a.encounter_id=b.encounter_id
  LEFT JOIN (SELECT `person_id`, IF(`value_coded` = 1, 'GeneXpert_TB', 'No') AS 'GeneXpert_TB', o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166142 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) c
  ON a.patient_id=c.person_id AND a.encounter_id=c.encounter_id
  LEFT JOIN (SELECT `person_id`, IF(`value_coded` = 1, 'Chest_Xray_TB', 'No') AS 'Chest_Xray_TB', o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166143 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) d
ON a.patient_id=d.person_id AND a.encounter_id=d.encounter_id
LEFT JOIN (SELECT `person_id`, IF(`value_coded` = 1, 'Culture_TB', 'No') AS 'Culture_TB', o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166144 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) e
ON a.patient_id=e.person_id AND a.encounter_id=e.encounter_id
LEFT JOIN ( SELECT `person_id`, ConceptName(value_coded) AS 'Sputum_AFB_Result',  o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165968 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) f
ON a.patient_id=f.person_id AND a.encounter_id=f.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(value_coded) AS 'GeneXpert_Result', o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165975 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) g
ON a.patient_id=g.person_id AND a.encounter_id=g.encounter_id  
LEFT JOIN (  SELECT `person_id`, ConceptName(value_coded) AS 'Chest_Xray_Result', o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165972 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) h
  ON a.patient_id=h.person_id AND a.encounter_id=h.encounter_id 
  LEFT JOIN(SELECT `person_id`, ConceptName(value_coded) AS 'Culture_Result', o.`encounter_id` FROM obs o
  LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165969 AND e.`encounter_type` = 23 AND e.`form_id` = 53  AND o.`voided`= 0) i
  ON a.patient_id=i.person_id AND a.encounter_id=i.encounter_id
  WHERE a.Occurrence =1 ;
   
   