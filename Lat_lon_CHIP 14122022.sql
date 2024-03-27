SET @FacilityName :=(SELECT `property_value` FROM `global_property` WHERE `property`= 'Facility_Name');
SET @DATIMCode :=(SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code');
SET @SurgeCommand := (SELECT SurgeCommand FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code'));
SET @LGA :=(SELECT LGA FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code'));
SET @State :=(SELECT State FROM CIHP_ListOfFacility WHERE Datim_Code = (SELECT `property_value` FROM `global_property` WHERE `property`= 'facility_datim_code'));
SET SESSION sql_mode = '';

SELECT @State State, @SurgeCommand SurgeCommand, @LGA LGA, @FacilityName FacilityName, @DATIMCode, a.`patient_id`, d.identifier Client_Code,
c.`identifier` PEPID, b.identifier Hospital_Number, e.`latitude`, e.`longitude`, e.`address1`, e.`address2`, e.`city_village`, e.`state_province`,
e.`postal_code`, e.`country`, f.`value` Phone_No
FROM `patient_identifier` a
LEFT JOIN (SELECT patient_id, identifier FROM patient_identifier WHERE identifier_type = 5) b ON a.patient_id=b.patient_id
LEFT JOIN (SELECT patient_id, identifier FROM patient_identifier WHERE identifier_type = 4) c ON a.patient_id=c.patient_id
LEFT JOIN (SELECT patient_id, identifier FROM patient_identifier WHERE identifier_type = 8) d ON a.patient_id=d.patient_id
LEFT JOIN `person_address` e ON a.patient_id=e.person_id AND e.`preferred`=1 AND e.`voided`=0
LEFT JOIN `person_attribute` f ON a.patient_id=f.person_id AND f.`voided`=0
GROUP BY a.`patient_id`;