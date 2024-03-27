DELIMITER $$
DROP FUNCTION IF EXISTS `ConceptName`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ConceptName`(conceptid INT) 
RETURNS TEXT CHARSET latin1 READS SQL DATA DETERMINISTIC BEGIN RETURN 
(SELECT NAME FROM  concept_name  WHERE concept_id = conceptid 
AND locale = 'en' AND locale_preferred = 1 LIMIT 1);END$$ 
DELIMITER ;


SELECT a.Person_id, p2.`identifier` Pepid, a.Verifivation_Date, a.Client_Verification, z.Indication_for_Client_Verification, b.`Reason FOR Tracking`, c.Partner_full_name, d.Address_of_Tx_supporter, e.Contact_phone_No, f.Date_of_Last_Actual, g.Date_Missed_Scheduled_App,
ContAttempt_Date1, i.who_attempted_contact1, j.Mode_of_Communication1, k.Person_Contacted1, l.Reason_for_Defaulting1, m.Reason_for_Termination, n.Date_of_Termination,
o.Previous_ARV_exposure, p.Referred_for, q.Date_Returned, r.Date_LTFU, s.Reason_LTFU, t.LTFU, u.Name_oF_Tracker, v.Tracker_Sig_Date, w.Facility_Transferred_To FROM
(SELECT @row_no := IF(@prev_val = a.person_id , @row_no + 1, 1) AS Occurrence, @prev_val := a.person_id AS person_id, e.`encounter_datetime` Verifivation_Date, e.encounter_id, ConceptName(`value_coded`) Client_Verification
FROM obs a LEFT JOIN `encounter` e ON a.person_id=e.patient_id, #LEFT JOIN obs o ON o.`encounter_id`=e.`encounter_id`,
(SELECT @row_no := 0) X, (SELECT @prev_val := '') Y
WHERE  e.`encounter_type` = 15 AND e.`form_id` = 13  AND e.`voided` = 0 AND concept_id=167221 AND a.`voided` = 0
AND e.`encounter_datetime` <= CURDATE() ORDER BY e.patient_id, e.`encounter_datetime` DESC) a 
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) Indication_for_Client_Verification, `encounter_id` FROM obs WHERE concept_id=167222 AND voided=0) z ON a.person_id=z.person_id AND a.encounter_id=z.encounter_id
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
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Referred_for', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165776 AND o.voided=0) p
ON  a.person_id=m.person_id AND a.encounter_id=p.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_Returned', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165775 AND o.voided=0) q
ON  a.person_id=q.person_id AND a.encounter_id=q.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Date_LTFU', `obs_datetime`,  o.`encounter_id` FROM obs o WHERE concept_id = 166152 AND o.voided=0) r
ON  a.person_id=m.person_id AND a.encounter_id=r.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'Reason_LTFU', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 166157 AND o.voided=0) s
ON  a.person_id=m.person_id AND a.encounter_id=s.encounter_id
LEFT JOIN (SELECT `person_id`, ConceptName(`value_coded`) AS 'LTFU', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 5240 AND o.voided=0) t
ON  a.person_id=m.person_id AND a.encounter_id=t.encounter_id
LEFT JOIN (SELECT `person_id`, `value_text` AS 'Name_oF_Tracker', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165459 AND o.voided=0) u
ON  a.person_id=m.person_id AND a.encounter_id=u.encounter_id
LEFT JOIN (SELECT `person_id`, `value_datetime` AS 'Tracker_Sig_Date', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 165777 AND o.voided=0) v
ON  a.person_id=m.person_id AND a.encounter_id=v.encounter_id
LEFT JOIN (SELECT `person_id`, `value_text` AS 'Facility_Transferred_To', `obs_datetime`, o.`encounter_id` FROM obs o WHERE concept_id = 159495 AND o.voided=0) w
ON  a.person_id=m.person_id AND a.encounter_id=w.encounter_id
LEFT JOIN `patient_identifier` p2 ON a.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4
WHERE a.Occurrence=1 GROUP BY a.Person_id, p2.`identifier`, a.Client_Verification;

SELECT * FROM obs WHERE person_id=258
 AND concept_id=167221;

SELECT * FROM
(SELECT `patient_id`, `date_created`, GROUP_CONCAT(`match_status`) 'Status', GROUP_CONCAT(`brstatus_recapturecount`) FROM `biometricverificationinfo_match_trail` GROUP BY `patient_id`) a WHERE 'Status' NOT LIKE '%NoMatch%';
