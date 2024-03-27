/*Total HIV Enrollment Form*/
SELECT `encounter_id`, `patient_id`, `encounter_datetime` FROM `encounter` WHERE `encounter_type`=14 AND voided=0;


/*KP Question Answered*/
SELECT person_id, obs_datetime, obs_id, ConceptName(value_coded),`encounter_id`,value_coded  FROM obs WHERE `encounter_id` IN (SELECT `encounter_id` 
FROM `encounter` WHERE `encounter_type`=14 AND voided=0) AND concept_id=166284 AND voided=0;

/*KP Type Specified*/
SELECT identifier PEPID, o.person_id, o.obs_datetime, ConceptName(o.value_coded), o.`obs_id` FROM obs o
LEFT JOIN `patient_identifier` p2 ON o.`person_id` = p2.`patient_id` AND p2.`identifier_type` = 4 AND p2.`preferred` = 1
WHERE `encounter_id` IN (SELECT `encounter_id` FROM `encounter` WHERE `encounter_type`=14) 
AND concept_id=166369 AND o.voided=0 GROUP BY o.`person_id`;

/*KP Question Answered Sample*/
SELECT * FROM obs WHERE obs_id=4963190;

/*KP Type Specified Sample*/
SELECT * FROM obs WHERE obs_id=4977352;

SELECT * FROM obs WHERE ;

SET FOREIGN_KEY_CHECKS=0;
DELETE FROM `encounter` WHERE `encounter_id` IN (311659, 313008, 339711, 349885, 373418);
DELETE FROM `obs` WHERE `encounter_id` IN (311659, 313008, 339711, 349885, 373418);
SET FOREIGN_KEY_CHECKS=1;

INSERT INTO `openmrs`.`obs`(`person_id`,`concept_id`,`encounter_id`,`obs_datetime`,`location_id`,`value_coded`,`creator`,`date_created`,`voided`,`uuid`) VALUES 
/*(51, 166284, 187, '2017-10-24', 10, 1, 1, CURDATE(), 0, UUID);*/
(51, 166369, 187, '2017-10-24', 10, 166285, 1, CURDATE(), 0, UUID());



UPDATE obs
SET `voided` = 1
WHERE `obs_id` IN "2069163, 
2068894, 
2145960, 
2146443, 
2149069, 
2150888, 
2152877, 
2165649, 
2165667, 
2165700, 
2165686, 
2165694, 
2166064, 
2166073, 
2179721, 
2071480, 
2071857, 
2073634, 
2074322, 
2074361, 
2074576, 
2075499, 
2076109, 
2076356, 
2086374, 
2087648, 
2088192, 
2088254, 
2095467, 
2095310, 
2097696, 
2097695, 
2096091, 
2098236, 
2105526, 
2097414, 
2110184, 
2107677, 
2118221, 
2118271, 
2118288, 
2119672, 
2120915, 
2127767, 
2130635, 
2130644, 
2136090, 
2145926, 
2145927, 
2145929, 
2145928, 
2145931, 
2145933, 
2145936, 
2145942, 
2145930, 
1570488, 
2118349, 
1629524, 
1727684, 
1727657, 
2064539"
