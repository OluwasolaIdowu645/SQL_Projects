SELECT * FROM obs WHERE concept_id=159495;

DROP TABLE IF EXISTS Reason_FOR_Tracking;
CREATE TEMPORARY TABLE Reason_FOR_Tracking AS
SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason FOR Tracking', `obs_datetime` FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165460 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS Partner_full_name;
CREATE TEMPORARY TABLE Partner_full_name AS
SELECT `person_id`, `value_text` AS 'Partner_full_name', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 161135 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS Address_of_Tx_supporter;
CREATE TEMPORARY TABLE Address_of_Tx_supporter AS
SELECT `person_id`, `value_text` AS 'Address_of_Tx_supporter', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 160641 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS Contact_phone_No;
CREATE TEMPORARY TABLE Contact_phone_No AS
SELECT `person_id`, `value_text` AS 'Contact_phone_No', `obs_datetime` FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 159635 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS Date_of_Last_Actual;
CREATE TEMPORARY TABLE Date_of_Last_Actual AS
SELECT `person_id`, `value_datetime` AS 'Date_of_Last_Actual', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165461 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS Date_Missed_Scheduled_App;
CREATE TEMPORARY TABLE Date_Missed_Scheduled_App AS
SELECT `person_id`, `value_datetime` AS 'Date_Missed_Scheduled_App', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165778 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
/* Attempt to Contact Section */
DROP TABLE IF EXISTS ContAttempt_Date1;
CREATE TEMPORARY TABLE ContAttempt_Date1 AS
SELECT `person_id`, `value_datetime` AS 'ContAttempt_Date1', MAX(`obs_datetime`) AS obs_datetime FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165463 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided AND e.`encounter_datetime` <= @Reporting_Date AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime;
DROP TABLE IF EXISTS who_attempted_contact1;
CREATE TEMPORARY TABLE who_attempted_contact1 AS
SELECT `person_id`, `value_text` AS 'who_attempted_contact1', MAX(`obs_datetime`) AS obs_datetime FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165464 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided AND e.`encounter_datetime` <= @Reporting_Date AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime;  
DROP TABLE IF EXISTS Mode_of_Communication1;
CREATE TEMPORARY TABLE Mode_of_Communication1 AS
SELECT `person_id`, ConceptName(`value_coded`) AS 'Mode_of_Communication1', MAX(`obs_datetime`) AS obs_datetime FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165465 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided AND e.`encounter_datetime` <= @Reporting_Date AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime; 
DROP TABLE IF EXISTS Person_Contacted1;
CREATE TEMPORARY TABLE Person_Contacted1 AS
SELECT `person_id`, ConceptName(`value_coded`) AS 'Person_Contacted1', MAX(`obs_datetime`) AS obs_datetime FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165466 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided AND e.`encounter_datetime` <= @Reporting_Date AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime; 
DROP TABLE IF EXISTS Reason_for_Defaulting1;
CREATE TEMPORARY TABLE Reason_for_Defaulting1 AS
SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_for_Defaulting1', MAX(`obs_datetime`) AS obs_datetime FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165467 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided AND e.`encounter_datetime` <= @Reporting_Date AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime; 
/* Termination Section */
DROP TABLE IF EXISTS Reason_for_Termination;
CREATE TEMPORARY TABLE Reason_for_Termination AS 
SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_for_Termination', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165470 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS Date_of_Termination;
CREATE TEMPORARY TABLE Date_of_Termination AS 
SELECT `person_id`, `value_datetime` AS 'Date_of_Termination', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165469 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS Patiet_Terminated;
CREATE TEMPORARY TABLE Patiet_Terminated AS 
SELECT `person_id`, ConceptName(`value_coded`) AS 'Previous_ARV_exposure', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165586 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS Referred_for;
CREATE TEMPORARY TABLE Referred_for AS 
SELECT `person_id`, ConceptName(`value_coded`) AS 'Referred_for', `obs_datetime` FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165776 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS Date_Returned;
CREATE TEMPORARY TABLE Date_Returned AS 
SELECT `person_id`, `value_datetime` AS 'Date_Returned', `obs_datetime` FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165775 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS Date_LTFU;
CREATE TEMPORARY TABLE Date_LTFU AS 
SELECT `person_id`, `value_datetime` AS 'Date_LTFU', `obs_datetime` FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166152 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS Reason_LTFU;
CREATE TEMPORARY TABLE Reason_LTFU AS
SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_LTFU', `obs_datetime` FROM obs o
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 166157 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS LTFU;
CREATE TEMPORARY TABLE LTFU AS
SELECT `person_id`, ConceptName(`value_coded`) AS 'LTFU', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 5240 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
/* End Section*/
DROP TABLE IF EXISTS Name_oF_Tracker;
CREATE TEMPORARY TABLE Name_oF_Tracker AS
SELECT `person_id`, `value_text` AS 'Name_oF_Tracker', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165459 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;
DROP TABLE IF EXISTS Tracker_Sig_Date;
CREATE TEMPORARY TABLE Tracker_Sig_Date AS
SELECT `person_id`, `value_datetime` AS 'Tracker_Sig_Date', `obs_datetime` FROM obs o 
LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id` WHERE concept_id = 165777 AND e.`encounter_type` = 15 AND e.`form_id` = 13 AND o.voided=0 AND e.`encounter_datetime` <= @Reporting_Date;

DROP TABLE IF EXISTS All_Tracking;
CREATE TEMPORARY TABLE All_Tracking AS

SELECT a.*, b.`Reason FOR Tracking`, c.Partner_full_name, d.Address_of_Tx_supporter, e.Contact_phone_No, f.Date_of_Last_Actual, g.Date_Missed_Scheduled_App,
ContAttempt_Date1, i.who_attempted_contact1, j.Mode_of_Communication1, k.Person_Contacted1, l.Reason_for_Defaulting1, m.Reason_for_Termination, n.Date_of_Termination FROM
(SELECT @row_no := IF(@prev_val = e.patient_id , @row_no + 1, 1) AS Occurrence, @prev_val := e.patient_id AS person_id, e.`encounter_datetime` obs_datetime, e.encounter_id 
FROM `encounter` e, #LEFT JOIN obs o ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE  e.`encounter_type` = 15 AND e.`form_id` = 13  AND e.`voided` = 0 AND e.`encounter_datetime` <= @Reporting_Date ORDER BY e.patient_id, e.`encounter_datetime` DESC) a
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason FOR Tracking', `obs_datetime`, o.encounter_id FROM obs o WHERE o.concept_id = 165460  AND o.voided=0) b
ON a.person_id=b.person_id AND a.encounter_id=b.encounter_id
LEFT JOIN (SELECT `person_id`, `value_text` AS 'Partner_full_name', `obs_datetime`, o.encounter_id FROM obs o WHERE concept_id = 161135 AND o.voided=0) c 
ON a.person_id=c.person_id AND a.encounter_id=c.encounter_id
LEFT JOIN (SELECT `person_id`, `value_text` AS 'Address_of_Tx_supporter', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 160641 AND o.voided=0) d
ON a.person_id=d.person_id AND a.encounter_id=d.encounter_id
LEFT JOIN (SELECT `person_id`, `value_text` AS 'Contact_phone_No', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 159635 AND o.voided=0) e
ON a.person_id=e.person_id AND a.encounter_id=e.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_of_Last_Actual', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165461 AND o.voided=0) f
ON a.person_id=f.person_id AND a.encounter_id=f.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_Missed_Scheduled_App', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165778 AND o.voided=0) g
ON a.person_id=g.person_id AND a.encounter_id=g.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'ContAttempt_Date1', MAX(`obs_datetime`) AS obs_datetime, o.`encounter_id` FROM obs o
WHERE concept_id = 165463 AND o.voided = 0 AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime) h
ON a.person_id=h.person_id AND a.encounter_id=h.encounter_id
LEFT JOIN (SELECT `person_id`, `value_text` AS 'who_attempted_contact1', MAX(`obs_datetime`) AS obs_datetime, o.`encounter_id` FROM obs o 
WHERE concept_id = 165464 AND o.voided = 0 AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime) i
ON a.person_id=i.person_id AND a.encounter_id=i.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Mode_of_Communication1', MAX(`obs_datetime`) AS obs_datetime,  o.`encounter_id` FROM obs o
WHERE concept_id = 165465 AND o.voided = 0 AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime) j
ON a.person_id=j.person_id AND a.encounter_id=j.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Person_Contacted1', MAX(`obs_datetime`) AS obs_datetime, o.`encounter_id` FROM obs o 
WHERE concept_id = 165466 AND o.voided=0 AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime) k
ON a.person_id=k.person_id AND a.encounter_id=k.encounter_id
LEFT JOIN(SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_for_Defaulting1', MAX(`obs_datetime`) AS obs_datetime, o.`encounter_id` FROM obs o 
WHERE concept_id = 165467 AND o.voided=0 AND `obs_group_id` IS NOT NULL GROUP BY person_id, obs_datetime) l
ON a.person_id=l.person_id AND a.encounter_id=l.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_for_Termination', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165470 AND o.voided=0) m
ON a.person_id=m.person_id AND a.encounter_id=m.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_of_Termination', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165469 AND o.voided=0) n
ON a.person_id=m.person_id AND a.encounter_id=n.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Previous_ARV_exposure', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165586 AND o.voided=0) o
ON  a.person_id=m.person_id AND a.encounter_id=o.encounter_id

WHERE a.Occurrence=1;


DROP TABLE IF EXISTS LastTracking;
CREATE TEMPORARY TABLE LastTracking AS

SELECT @row_no := IF(@prev_val = o.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := o.person_id AS person_id,
o.`obs_datetime`
FROM `All_Tracking` o LEFT JOIN `encounter` e ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
ORDER BY o.person_id, o.`obs_datetime`DESC;
DROP TABLE IF EXISTS Cihp_Client_Tracking;
CREATE TEMPORARY TABLE Cihp_Client_Tracking AS
SELECT a.person_id, p2.`identifier` AS pepid, a.obs_datetime, c2.name AS 'Reason For Tracking',  b.Partner_full_name, 
c.Address_of_Tx_supporter, d.Contact_phone_No, e.Date_of_Last_Actual, 
f.Date_Missed_Scheduled_App, g.ContAttempt_Date1, h.who_attempted_contact1, 
c3.`name` AS Mode_of_Communication1, c4.`name` AS Person_Contacted1, c5.`name` AS Reason_for_Defaulting1, c12.`name` AS Reason_for_Termination, z.Date_of_Termination, c13.`name` AS 'Patiet_Terminated(Previous_ARV_exposure)', 
c14.`name` AS Referred_for, ac.Date_Returned, ae.Date_LTFU, c15.`name` AS Reason_LTFU, ag.LTFU, Name_oF_Tracker, ai.Tracker_Sig_Date
FROM LastTracking a
LEFT JOIN Partner_full_name b ON a.person_id=b.person_id AND a.obs_datetime=b.obs_datetime 
LEFT JOIN Address_of_Tx_supporter c ON a.person_id=c.person_id AND a.obs_datetime=c.obs_datetime 
LEFT JOIN Contact_phone_No d ON a.person_id=d.person_id AND a.obs_datetime=d.obs_datetime
LEFT JOIN Date_of_Last_Actual e ON a.person_id=e.person_id AND a.obs_datetime=e.obs_datetime
LEFT JOIN Date_Missed_Scheduled_App f ON a.person_id=f.person_id AND a.obs_datetime=f.obs_datetime 
LEFT JOIN ContAttempt_Date1 g ON a.person_id=g.person_id AND a.obs_datetime=g.obs_datetime 
LEFT JOIN who_attempted_contact1 h ON a.person_id=h.person_id AND a.obs_datetime=h.obs_datetime
LEFT JOIN Mode_of_Communication1 i ON a.person_id=i.person_id AND a.obs_datetime=i.obs_datetime
LEFT JOIN Person_Contacted1 j ON a.person_id=j.person_id AND a.obs_datetime=j.obs_datetime 
LEFT JOIN Reason_for_Defaulting1 k ON a.person_id=k.person_id AND a.obs_datetime=k.obs_datetime 
LEFT JOIN Reason_for_Termination w ON a.person_id=w.person_id AND a.obs_datetime=w.obs_datetime
LEFT JOIN Date_of_Termination z ON a.person_id=z.person_id AND a.obs_datetime=z.obs_datetime 
LEFT JOIN Referred_for ab ON a.person_id=ab.person_id AND a.obs_datetime=ab.obs_datetime
LEFT JOIN Date_Returned ac ON a.person_id=ac.person_id AND a.obs_datetime=ac.obs_datetime
LEFT JOIN Patiet_Terminated ad ON a.person_id=ad.person_id AND a.obs_datetime=ad.obs_datetime
LEFT JOIN Date_LTFU ae ON a.person_id=ae.person_id AND a.obs_datetime=ae.obs_datetime 
LEFT JOIN Reason_LTFU af ON a.person_id=af.person_id AND a.obs_datetime=af.obs_datetime
LEFT JOIN LTFU ag ON a.person_id=ag.person_id AND a.obs_datetime=ag.obs_datetime 
LEFT JOIN Name_oF_Tracker ah ON a.person_id=ah.person_id AND a.obs_datetime=ah.obs_datetime
LEFT JOIN Tracker_Sig_Date ai ON a.person_id=ai.person_id AND a.obs_datetime=ai.obs_datetime
LEFT JOIN Reason_FOR_Tracking aj ON a.person_id=aj.person_id AND a.obs_datetime=aj.obs_datetime
LEFT JOIN `concept_name` c2 ON aj.`Reason FOR Tracking`=c2.`concept_id` AND c2.locale = 'en' AND c2.locale_preferred = 1
LEFT JOIN `concept_name` c3 ON i.`Mode_of_Communication1`=c3.`concept_id` AND c3.locale = 'en' AND c3.locale_preferred = 1
LEFT JOIN `concept_name` c4 ON j.`Person_Contacted1`=c4.`concept_id` AND c4.locale = 'en' AND c4.locale_preferred = 1
LEFT JOIN `concept_name` c5 ON k.Reason_for_Defaulting1=c5.`concept_id` AND c5.locale = 'en' AND c5.locale_preferred = 1
LEFT JOIN `concept_name` c12 ON w.Reason_for_Termination=c12.`concept_id` AND c12.locale = 'en' AND c12.locale_preferred = 1
LEFT JOIN `concept_name` c13 ON ad.Previous_ARV_exposure=c13.`concept_id` AND c13.locale = 'en' AND c13.locale_preferred = 1
LEFT JOIN `concept_name` c14 ON ab.Referred_for=c14.`concept_id` AND c14.locale = 'en' AND c14.locale_preferred = 1
LEFT JOIN `concept_name` c15 ON af.Reason_LTFU=c15.`concept_id` AND c15.locale = 'en' AND c15.locale_preferred = 1
LEFT JOIN `patient_identifier` p2 ON a.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1
WHERE a.Occurrence = 1
GROUP BY a.person_id, a.obs_datetime  ORDER BY a.obs_datetime DESC;
