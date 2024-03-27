DELIMITER $$
DROP FUNCTION IF EXISTS `get_concept_name`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_concept_name`(conceptid INT) RETURNS TEXT CHARSET latin1 
READS SQL DATA
DETERMINISTIC
BEGIN
	RETURN (SELECT NAME FROM  concept_name  WHERE concept_id = conceptid AND locale = 'en' AND locale_preferred = 1 LIMIT 1);		
    END$$
DELIMITER ;


SELECT a.`patient_id`, a.`identifier`, b.Education 'Q103 Level of education', c.Marrital 'Q104 Marital Status ', d.Occu_Status 'Q105 Employment Status ',
'' AS 'Q106 Level of Care', e.DateConfirmed 'Q201 Date diagnosed HIV positive (dd/mm/yyyy)', f.Entry 'Q202 Which HIV testing service delivery modality did client access ',
''AS'Q203 Was HIV diagnosis made in this facility?', ''AS'Q204 If no to Q203, name facility where HIV diagnosis was made?', IF(g.FAC_ART IS NULL, 'Yes','No') 'Q206 If no to Q205, name facility where client was initiated on ART?',
IF(g.FAC_ART IS NULL, (SELECT `property_value` FROM `global_property` WHERE `property`= 'Facility_Name'), g.FAC_ART) 'Q206 If no to Q205, name facility where client was initiated on ART?'
 FROM `patient_identifier` a  
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`) Education FROM `OBS` o WHERE  `concept_id`=1712 AND o.`voided`=0) b ON a.`patient_id`=b.person_id
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`) Marrital FROM `OBS` o WHERE  `concept_id`=1054 AND o.`voided`=0) c ON a.`patient_id`=c.person_id
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`)Occu_Status FROM `OBS` o WHERE  `concept_id`=1542 AND o.`voided`=0) d ON a.`patient_id`=d.person_id
LEFT JOIN (SELECT person_id,o.`value_datetime` DateConfirmed FROM `OBS` o WHERE  `concept_id`=160554 AND o.`voided`=0) e ON a.`patient_id`=e.person_id 
LEFT JOIN (SELECT person_id,`value_coded`, get_concept_name(`value_coded`)Entry FROM `OBS` o WHERE  `concept_id`=160540 AND o.`voided`=0) f ON a.`patient_id`=f.person_id
LEFT JOIN (SELECT person_id,`value_text` FAC_ART FROM `OBS` o WHERE  `concept_id`=160535 AND o.`voided`=0) g ON a.`patient_id`=g.person_id
WHERE a.`identifier_type`=4 AND a.`voided`=0 GROUP BY a.`patient_id`;


