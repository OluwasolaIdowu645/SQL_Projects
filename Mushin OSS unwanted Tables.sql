DROP TABLE IF EXISTS 
`adult`,
`art_commencement`,
`chunking_history`,
`clinical`,
`clinical_map`,
`event_records`,
`event_records_offset_marker`,
`event_records_queue`,
`failed_events`,
`markers`,
`pharm_question`,
`pharm_reference`,
`pharmacy_map`,
`pharmrank1`,
`pharmrank2`,
`regimen_drug_mappings`,
`sync_audit_message`,
`sync_merge_conflict`,
`sync_parent_object_hashcode`,
`temp_last_regimen_data`,
`temp_last_viral_load_data`,
`temp_testing_data`,
`test_order`;

SET FOREIGN_KEY_CHECKS = 1;
DELETE FROM obs
WHERE encounter_id IN (
528347,
528348,
528349,
528350,
528351,
528352,
528353,
528354,
528355,
528356);



(SELECT o.encounter_id FROM obs o
WHERE o.encounter_id NOT IN (SELECT e.encounter_id FROM encounter e)
GROUP BY o.encounter_id
);


SELECT o.`encounter_id` FROM`obs`o
LEFT JOIN`encounter`e ON o.`encounter_id`=e.`encounter_id`
WHERE e.`encounter_id` IS NULL GROUP BY o.`encounter_id`;


