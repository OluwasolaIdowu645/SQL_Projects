ALTER TABLE `openmrs_mnushinoss`.`obs` ADD COLUMN `status` VARCHAR(16) DEFAULT 'FINAL' 
NOT NULL AFTER `form_namespace_and_path`, ADD COLUMN `interpretation` VARCHAR(32) NULL AFTER `status`; 

ALTER TABLE `openmrs_mnushinoss`.`users` ADD COLUMN `activation_key` VARCHAR(255) 
NULL AFTER `uuid`, ADD COLUMN `email` VARCHAR(255) NULL AFTER `activation_key`; 

ALTER TABLE `openmrs_mnushinoss`.`person` ADD COLUMN `cause_of_death_non_coded` VARCHAR(255) NULL AFTER `birthtime`; 

ALTER TABLE `openmrs_mnushinoss`.`biometricverificationinfo` ADD COLUMN `salt` TEXT NULL AFTER `recapture_count`; 


SET FOREIGN_KEY_CHECKS = 0; 
DELETE FROM 
    biometricinfo; DELETE FROM 
    biometricverificationinfo; DELETE FROM 
    encounter; DELETE FROM 
    encounter_provider; DELETE FROM 
    inv_consumption; DELETE FROM 
    inv_custom_arv_dispensed_item; DELETE FROM 
    inv_custom_pharmacy_dispense_arv; DELETE FROM 
    inv_department; DELETE FROM 
    inv_institution; DELETE FROM 
    inv_item; DELETE FROM 
    inv_item_attribute; DELETE FROM 
    inv_item_attribute_type; DELETE FROM 
    inv_item_code; DELETE FROM 
    inv_item_price; DELETE FROM 
    inv_item_stock; DELETE FROM 
    inv_item_stock_detail; DELETE FROM 
    inv_pharmacy_consumption; DELETE FROM 
    inv_reserved_transaction; DELETE FROM 
    inv_stock_operation; DELETE FROM 
    inv_stock_operation_attribute; DELETE FROM 
    inv_stock_operation_attribute_type; DELETE FROM 
    inv_stock_operation_item; DELETE FROM 
    inv_stock_operation_type; DELETE FROM 
    inv_stockonhand_pharmacy_dispensary; DELETE FROM 
    inv_stockroom; DELETE FROM 
    inv_stockroom_operations; DELETE FROM 
    inv_transaction; DELETE FROM 
    inv_view_item_expiration_by_dept; DELETE FROM 
    inv_view_item_expiration_by_dept_pharm; DELETE FROM 
    inv_view_stockroom_stockonhand; DELETE FROM 
    lims_auth_module; DELETE FROM 
    lims_manifest; DELETE FROM 
    lims_manifest_result; DELETE FROM 
    lims_manifest_samples; DELETE FROM 
    location; DELETE FROM 
    location_attribute; DELETE FROM 
    location_attribute_type; DELETE FROM 
    location_tag; DELETE FROM 
    location_tag_map; DELETE FROM 
    logic_rule_definition; DELETE FROM 
    logic_rule_token; DELETE FROM 
    logic_rule_token_tag; DELETE FROM 
    logic_token_registration; DELETE FROM 
    logic_token_registration_tag; DELETE FROM 
    nigeriaemr_ndr_batch_export; DELETE FROM 
    nigeriaemr_ndr_export; DELETE FROM 
    notification_alert; DELETE FROM 
    notification_alert_recipient; DELETE FROM 
    notification_template; DELETE FROM 
    obs; DELETE FROM 
    obs_view; DELETE FROM 
    order_frequency; DELETE FROM 
    patient; DELETE FROM 
    patient_identifier; DELETE FROM 
    patient_program; DELETE FROM 
    person; DELETE FROM 
    person_address; DELETE FROM 
    person_attribute; DELETE FROM 
    person_attribute_type; DELETE FROM 
    person_name; DELETE FROM 
    program; DELETE FROM 
    temp_all_demographics; DELETE FROM 
    temp_last_regimen_data; DELETE FROM 
    temp_last_viral_load_data; DELETE FROM 
    temp_testing_data; DELETE FROM 
    test_order; DELETE FROM 
    visit;
    DELETE FROM `openmrs`.`users`;
    DELETE FROM `openmrs`.`relationship`;
    DELETE FROM `openmrs`.`user_role`;
    DELETE FROM `openmrs`.`user_property`;




INSERT INTO `openmrs`.biometricinfo SELECT * FROM openmrs_mnushinoss.biometricinfo;
INSERT INTO `openmrs`.biometricverificationinfo SELECT * FROM openmrs_mnushinoss.biometricverificationinfo;
INSERT INTO `openmrs`.encounter SELECT * FROM openmrs_mnushinoss.encounter;
INSERT INTO `openmrs`.encounter_provider SELECT * FROM openmrs_mnushinoss.encounter_provider;
INSERT INTO `openmrs`.inv_consumption SELECT * FROM openmrs_mnushinoss.inv_consumption;
INSERT INTO `openmrs`.inv_custom_arv_dispensed_item SELECT * FROM openmrs_mnushinoss.inv_custom_arv_dispensed_item;
INSERT INTO `openmrs`.inv_custom_pharmacy_dispense_arv SELECT * FROM openmrs_mnushinoss.inv_custom_pharmacy_dispense_arv;
INSERT INTO `openmrs`.inv_department SELECT * FROM openmrs_mnushinoss.inv_department;
INSERT INTO `openmrs`.inv_institution SELECT * FROM openmrs_mnushinoss.inv_institution;
INSERT INTO `openmrs`.inv_item SELECT * FROM openmrs_mnushinoss.inv_item;
INSERT INTO `openmrs`.inv_item_attribute SELECT * FROM openmrs_mnushinoss.inv_item_attribute;
INSERT INTO `openmrs`.inv_item_attribute_type SELECT * FROM openmrs_mnushinoss.inv_item_attribute_type;
INSERT INTO `openmrs`.inv_item_code SELECT * FROM openmrs_mnushinoss.inv_item_code;
INSERT INTO `openmrs`.inv_item_price SELECT * FROM openmrs_mnushinoss.inv_item_price;
INSERT INTO `openmrs`.inv_item_stock SELECT * FROM openmrs_mnushinoss.inv_item_stock;
INSERT INTO `openmrs`.inv_item_stock_detail SELECT * FROM openmrs_mnushinoss.inv_item_stock_detail;
INSERT INTO `openmrs`.inv_pharmacy_consumption SELECT * FROM openmrs_mnushinoss.inv_pharmacy_consumption;
INSERT INTO `openmrs`.inv_reserved_transaction SELECT * FROM openmrs_mnushinoss.inv_reserved_transaction;
INSERT INTO `openmrs`.inv_stock_operation SELECT * FROM openmrs_mnushinoss.inv_stock_operation;
INSERT INTO `openmrs`.inv_stock_operation_attribute SELECT * FROM openmrs_mnushinoss.inv_stock_operation_attribute;
INSERT INTO `openmrs`.inv_stock_operation_attribute_type SELECT * FROM openmrs_mnushinoss.inv_stock_operation_attribute_type;
INSERT INTO `openmrs`.inv_stock_operation_item SELECT * FROM openmrs_mnushinoss.inv_stock_operation_item;
INSERT INTO `openmrs`.inv_stock_operation_type SELECT * FROM openmrs_mnushinoss.inv_stock_operation_type;
INSERT INTO `openmrs`.inv_stockonhand_pharmacy_dispensary SELECT * FROM openmrs_mnushinoss.inv_stockonhand_pharmacy_dispensary;
INSERT INTO `openmrs`.inv_stockroom SELECT * FROM openmrs_mnushinoss.inv_stockroom;
INSERT INTO `openmrs`.inv_stockroom_operations SELECT * FROM openmrs_mnushinoss.inv_stockroom_operations;
INSERT INTO `openmrs`.inv_transaction SELECT * FROM openmrs_mnushinoss.inv_transaction;
INSERT INTO `openmrs`.inv_view_item_expiration_by_dept SELECT * FROM openmrs_mnushinoss.inv_view_item_expiration_by_dept;
INSERT INTO `openmrs`.inv_view_item_expiration_by_dept_pharm SELECT * FROM openmrs_mnushinoss.inv_view_item_expiration_by_dept_pharm;
INSERT INTO `openmrs`.inv_view_stockroom_stockonhand SELECT * FROM openmrs_mnushinoss.inv_view_stockroom_stockonhand;
INSERT INTO `openmrs`.lims_auth_module SELECT * FROM openmrs_mnushinoss.lims_auth_module;
INSERT INTO `openmrs`.lims_manifest SELECT * FROM openmrs_mnushinoss.lims_manifest;
INSERT INTO `openmrs`.lims_manifest_result SELECT * FROM openmrs_mnushinoss.lims_manifest_result;
INSERT INTO `openmrs`.lims_manifest_samples SELECT * FROM openmrs_mnushinoss.lims_manifest_samples;
INSERT INTO `openmrs`.location SELECT * FROM openmrs_mnushinoss.location;
INSERT INTO `openmrs`.location_attribute SELECT * FROM openmrs_mnushinoss.location_attribute;
INSERT INTO `openmrs`.location_attribute_type SELECT * FROM openmrs_mnushinoss.location_attribute_type;
INSERT INTO `openmrs`.location_tag SELECT * FROM openmrs_mnushinoss.location_tag;
INSERT INTO `openmrs`.location_tag_map SELECT * FROM openmrs_mnushinoss.location_tag_map;
INSERT INTO `openmrs`.logic_rule_definition SELECT * FROM openmrs_mnushinoss.logic_rule_definition;
INSERT INTO `openmrs`.logic_rule_token SELECT * FROM openmrs_mnushinoss.logic_rule_token;
INSERT INTO `openmrs`.logic_rule_token_tag SELECT * FROM openmrs_mnushinoss.logic_rule_token_tag;
INSERT INTO `openmrs`.logic_token_registration SELECT * FROM openmrs_mnushinoss.logic_token_registration;
INSERT INTO `openmrs`.logic_token_registration_tag SELECT * FROM openmrs_mnushinoss.logic_token_registration_tag;
INSERT INTO `openmrs`.nigeriaemr_ndr_batch_export SELECT * FROM openmrs_mnushinoss.nigeriaemr_ndr_batch_export;
INSERT INTO `openmrs`.nigeriaemr_ndr_export SELECT * FROM openmrs_mnushinoss.nigeriaemr_ndr_export;
INSERT INTO `openmrs`.notification_alert SELECT * FROM openmrs_mnushinoss.notification_alert;
INSERT INTO `openmrs`.notification_alert_recipient SELECT * FROM openmrs_mnushinoss.notification_alert_recipient;
INSERT INTO `openmrs`.notification_template SELECT * FROM openmrs_mnushinoss.notification_template;

INSERT INTO `openmrs`.obs SELECT * FROM openmrs_mnushinoss.obs;
#INSERT INTO `openmrs`.obs_view SELECT * FROM openmrs_mnushinoss.obs_view;
INSERT INTO `openmrs`.order_frequency SELECT * FROM openmrs_mnushinoss.order_frequency;
INSERT INTO `openmrs`.patient SELECT * FROM openmrs_mnushinoss.patient;
INSERT INTO `openmrs`.patient_identifier SELECT * FROM openmrs_mnushinoss.patient_identifier;
INSERT INTO `openmrs`.patient_program SELECT * FROM openmrs_mnushinoss.patient_program;
INSERT INTO `openmrs`.person SELECT * FROM openmrs_mnushinoss.person;
INSERT INTO `openmrs`.person_address SELECT * FROM openmrs_mnushinoss.person_address;
INSERT INTO `openmrs`.person_attribute SELECT * FROM openmrs_mnushinoss.person_attribute;
INSERT INTO `openmrs`.person_attribute_type SELECT * FROM openmrs_mnushinoss.person_attribute_type;
INSERT INTO `openmrs`.person_name SELECT * FROM openmrs_mnushinoss.person_name;
INSERT INTO `openmrs`.program SELECT * FROM openmrs_mnushinoss.program;
INSERT INTO `openmrs`.relationship SELECT * FROM openmrs_mnushinoss.relationship;
INSERT INTO `openmrs`.temp_all_demographics SELECT * FROM openmrs_mnushinoss.temp_all_demographics;
INSERT INTO `openmrs`.temp_last_regimen_data SELECT * FROM openmrs_mnushinoss.temp_last_regimen_data;
INSERT INTO `openmrs`.temp_last_viral_load_data SELECT * FROM openmrs_mnushinoss.temp_last_viral_load_data;
INSERT INTO `openmrs`.temp_testing_data SELECT * FROM openmrs_mnushinoss.temp_testing_data;
INSERT INTO `openmrs`.test_order SELECT * FROM openmrs_mnushinoss.test_order;
INSERT INTO `openmrs`.visit SELECT * FROM openmrs_mnushinoss.visit;


INSERT INTO `openmrs`.`users` SELECT * FROM openmrs_mnushinoss.users;

INSERT INTO `openmrs`.`user_role` SELECT * FROM openmrs_mnushinoss.user_role;

INSERT INTO `openmrs`.`user_property` SELECT * FROM openmrs_mnushinoss.user_property;

SET FOREIGN_KEY_CHECKS = 1;