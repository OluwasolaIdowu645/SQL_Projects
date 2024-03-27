DELIMITER $$
DROP FUNCTION IF EXISTS `ConceptName`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `ConceptName`(conceptid INT) 
RETURNS TEXT CHARSET latin1 READS SQL DATA DETERMINISTIC BEGIN RETURN 
(SELECT NAME FROM  concept_name  WHERE concept_id = conceptid 
AND locale = 'en' AND locale_preferred = 1 LIMIT 1);END$$
DELIMITER ;
DELIMITER $$

USE `openmrs`$$

DROP PROCEDURE IF EXISTS `OTZ_LineList`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OTZ_LineList`()
BEGIN

SET @FacilityName :=(SELECT `property_value`FROM `global_property`WHERE `property`= 'Facility_Name');
SET @DATIMCode :=(SELECT `property_value`FROM `global_property`WHERE `property`= 'facility_datim_code');
SET @SurgeCommand :=(SELECT SurgeCommand FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value`FROM `global_property`
WHERE `property`= 'facility_datim_code'));
SET @LGA :=(SELECT LGA FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value`FROM `global_property`
WHERE `property`= 'facility_datim_code'));
SET @State :=(SELECT State FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value`FROM `global_property`
WHERE `property`= 'facility_datim_code'));



SELECT @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName,
e.`patient_id`, p2.`identifier` Pepid,  e.`encounter_datetime` Visit_Date, a.Date_Enrolled_Into_OTZ, 
d.Full_Disclosure, f.Full_Disclosure_Date, g.Positive_Living, h.Positive_Living_Comp_Date, Treatment_Literacy,
j.Treatment_Literacy_Comp_Date, b.Enrolled_Into_OTZ_Plus, c.Date_Enrolled_Into_OTZ_Plus, k.Adolescents_Participation,
l.Adolescents_Participation_Comp_Date,m.Leadership_Training,n.Leadership_Training_Comp_Date,o.Peer_to_Peer_Mentorship,
p.Peer_to_Peer_Mentorship_Comp_Date,q.Role_of_OTZ_in_95_95_95,r.Role_of_OTZ_in_95_95_95_Comp_Date,s.Transitioned_to_Adult_Clinic,
t.Date_Transitioned_to_Adult_Clinic,u.OTZ_Program_Outcome
FROM `encounter` e 
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), o.`value_datetime` 'Date_Enrolled_Into_OTZ' FROM obs o 
WHERE o.`concept_id` = 166156 AND o.`voided`=0)a ON a.person_id=e.`patient_id` AND a.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), ConceptName(o.`value_coded`) 'Enrolled_Into_OTZ_Plus' FROM obs o 
WHERE o.`concept_id` = 166269 AND o.`voided`=0)b ON b.person_id=e.`patient_id` AND b.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), o.`value_datetime` 'Date_Enrolled_Into_OTZ_Plus' FROM obs o 
WHERE o.`concept_id` = 166350 AND o.`voided`=0)c ON c.person_id=e.`patient_id` AND c.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), ConceptName(o.`value_coded`) 'Full_Disclosure' FROM obs o 
WHERE o.`concept_id` = 166270 AND o.`voided`=0)d ON d.person_id=e.`patient_id` AND d.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), o.`value_datetime` 'Full_Disclosure_Date' FROM obs o 
WHERE o.`concept_id` = 166271 AND o.`voided`=0)f ON f.person_id=e.`patient_id` AND f.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), ConceptName(o.`value_coded`) 'Positive_Living' FROM obs o 
WHERE o.`concept_id` = 166256 AND o.`voided`=0)g ON g.person_id=e.`patient_id` AND g.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), o.`value_datetime` 'Positive_Living_Comp_Date' FROM obs o 
WHERE o.`concept_id` = 166261 AND o.`voided`=0)h ON h.person_id=e.`patient_id` AND h.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), ConceptName(o.`value_coded`) 'Treatment_Literacy' FROM obs o 
WHERE o.`concept_id` = 166257 AND o.`voided`=0)i ON i.person_id=e.`patient_id` AND i.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), o.`value_datetime` 'Treatment_Literacy_Comp_Date' FROM obs o 
WHERE o.`concept_id` = 166262 AND o.`voided`=0)j ON j.person_id=e.`patient_id` AND j.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), ConceptName(o.`value_coded`) 'Adolescents_Participation' FROM obs o 
WHERE o.`concept_id` = 166258 AND o.`voided`=0)k ON k.person_id=e.`patient_id` AND k.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), o.`value_datetime` 'Adolescents_Participation_Comp_Date' FROM obs o 
WHERE o.`concept_id` = 166263 AND o.`voided`=0)l ON l.person_id=e.`patient_id` AND l.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), ConceptName(o.`value_coded`) 'Leadership_Training' FROM obs o 
WHERE o.`concept_id` = 166259 AND o.`voided`=0)m ON m.person_id=e.`patient_id` AND m.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), o.`value_datetime` 'Leadership_Training_Comp_Date' FROM obs o 
WHERE o.`concept_id` = 166264 AND o.`voided`=0)n ON n.person_id=e.`patient_id` AND n.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), ConceptName(o.`value_coded`) 'Peer_to_Peer_Mentorship' FROM obs o 
WHERE o.`concept_id` = 166260 AND o.`voided`=0)o ON o.person_id=e.`patient_id` AND o.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), o.`value_datetime` 'Peer_to_Peer_Mentorship_Comp_Date' FROM obs o 
WHERE o.`concept_id` = 166265 AND o.`voided`=0)p ON p.person_id=e.`patient_id` AND p.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), ConceptName(o.`value_coded`) 'Role_of_OTZ_in_95_95_95' FROM obs o 
WHERE o.`concept_id` = 166255 AND o.`voided`=0)q ON q.person_id=e.`patient_id` AND q.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), o.`value_datetime` 'Role_of_OTZ_in_95_95_95_Comp_Date' FROM obs o 
WHERE o.`concept_id` = 166266 AND o.`voided`=0)r ON r.person_id=e.`patient_id` AND r.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), ConceptName(o.`value_coded`) 'Transitioned_to_Adult_Clinic' FROM obs o 
WHERE o.`concept_id` = 166272 AND o.`voided`=0)s ON s.person_id=e.`patient_id` AND s.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), o.`value_datetime` 'Date_Transitioned_to_Adult_Clinic' FROM obs o 
WHERE o.`concept_id` = 166273 AND o.`voided`=0)t ON t.person_id=e.`patient_id` AND t.encounter_id=e.`encounter_id`
LEFT JOIN (SELECT o.`person_id`, o.`encounter_id`, ConceptName(o.`concept_id`), ConceptName(o.`value_coded`) 'OTZ_Program_Outcome' FROM obs o 
WHERE o.`concept_id` = 166275 AND o.`voided`=0)u ON u.person_id=e.`patient_id` AND u.encounter_id=e.`encounter_id`
LEFT JOIN `patient_identifier` p2 ON e.`patient_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`voided`=0
WHERE e.`encounter_type`=36 AND e.`form_id`=73 GROUP BY e.`patient_id`, e.`encounter_id`;
	END$$

DELIMITER ;

select `obs_id`,`person_id`,`concept_id`,ConceptName(`concept_id`),`encounter_id`,`order_id`,`obs_datetime` from obs where encounter_id=168346;