-- =============================================
-- Author: VEGHER EMMANUEL
-- Create date: 25/08/2020
-- Description: Query to Migrate HTS Results into NMRS
-- =============================================


DROP TABLE IF EXISTS push_hts;
CREATE TABLE push_hts (NO VARCHAR(50),ClientCode VARCHAR(250),family_name VARCHAR(250),given_name VARCHAR(250),gender VARCHAR(250),PhoneNumber VARCHAR(250),address VARCHAR(250),State VARCHAR(250),LGA VARCHAR(250),Country VARCHAR(250),Test_Date DATETIME,Screening_Test_Result VARCHAR(250),CurrentAge VARCHAR(250),FirstTimeVisit VARCHAR(250),KindOfHTS VARCHAR(250),Setting VARCHAR(250),Referred_From VARCHAR(250),MaritalStatus VARCHAR(250),IndexClientID VARCHAR(250),IndexType VARCHAR(250));


SET SQL_MODE='ALLOW_INVALID_DATES';
SET FOREIGN_KEY_CHECKS = 0;


LOAD DATA LOCAL INFILE 'C:\\import\\push_hts.csv' 
INTO TABLE openmrs.push_hts
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(NO,ClientCode,family_name,given_name,gender,PhoneNumber,address,State,LGA,Country,Test_Date,Screening_Test_Result,CurrentAge,FirstTimeVisit,KindOfHTS,Setting,Referred_From,MaritalStatus,IndexClientID,IndexType);


SET SQL_MODE='ALLOW_INVALID_DATES';
SET FOREIGN_KEY_CHECKS = 0;

-- Create Person in Person Table from the Excel Sheet
INSERT INTO person(gender,birthdate,birthdate_estimated,creator,date_created,voided,void_reason,UUID)
SELECT Gender,DATE_FORMAT(DATE_SUB(test_date,INTERVAL currentAge YEAR ),'%Y-%m-%d'),1,1,DATE_FORMAT(NOW(),'%Y-%m-%d'),0,NO,UUID() FROM push_hts WHERE Screening_Test_Result LIKE 'Negative%';


SET FOREIGN_KEY_CHECKS = 1;
UPDATE person SET gender = 'M' WHERE gender = 'm';
UPDATE person SET gender = 'F' WHERE gender = 'f';
SET FOREIGN_KEY_CHECKS = 1;

-- Import Addresses
INSERT INTO person_address(person_id,preferred,address1,city_village,state_province,country,creator,date_created,voided,UUID)
SELECT A.person_id,1,B.address,B.LGA,B.State,B.Country,1,NOW(),0,UUID()
FROM person AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No` AND B.address <> '';

-- Import Phone numbers
INSERT INTO person_attribute(person_id,VALUE,person_attribute_type_id,creator,date_created,voided,UUID)
SELECT A.person_id,B.PhoneNumber,8,1,NOW(),0,UUID()
FROM person AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No` AND B.PhoneNumber <> '';

-- Import Clients Names
INSERT INTO person_name(preferred,person_id,given_name,family_name,creator,date_created,voided,UUID)
SELECT 1,A.person_id,B.given_name,B.family_name,1,NOW(),0,UUID()
FROM person AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`;

-- Import Clients In patients Table
INSERT INTO patient(patient_id,creator,date_created,voided,allergy_status)
SELECT A.person_id,1,NOW(),0,'Unknown'
FROM person AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`;

-- Import Unique Identifiers(Client Code, OpenMRS ID)
INSERT INTO patient_identifier(patient_id,identifier,identifier_type,preferred,location_id,creator,date_created,voided,UUID)
SELECT A.person_id,B.ClientCode,3,1,8,1,NOW(),0,UUID()
FROM person AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`

UNION ALL

SELECT A.person_id,B.ClientCode,8,1,8,1,NOW(),0,UUID()
FROM person AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`;

-- Import Clients Into HTS Testing Service Programs
INSERT INTO patient_program(patient_id,program_id,date_enrolled,creator,date_created,voided,UUID)
SELECT A.person_id,4,B.Test_Date,1,NOW(),0,UUID()
FROM person AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`

UNION ALL

SELECT A.person_id,1,B.Test_Date,1,NOW(),0,UUID()
FROM person AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`
;

-- Create Visit Dates For Clients
INSERT INTO visit(patient_id,visit_type_id,date_started,date_stopped,location_id,creator,date_created,voided,void_reason,UUID)
SELECT A.person_id,1,B.Test_Date,B.Test_Date,8,1,B.Test_Date,0,A.void_reason,UUID()
FROM person AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`;

-- Create Encounter For Client_Intake form
INSERT INTO encounter(encounter_type,patient_id,location_id,form_id,encounter_datetime,creator,date_created,voided,void_reason,visit_id,UUID)
SELECT 20,patient_id,8,10,date_started,1,date_started,0,void_reason,visit_id, UUID() FROM visit  WHERE void_reason > 0;



-- Create Observations for Client Intake Form
INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,166136,A.encounter_id,A.encounter_datetime,8,CASE WHEN B.KindOfHTS LIKE 'Voluntary%' THEN 159940 WHEN B.KindOfHTS LIKE 'PITC%'THEN 164163 ELSE NULL END,1,A.encounter_datetime,0,UUID() FROM encounter AS A,
push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No` AND B.KindOfHTS <> '';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,1054,encounter_id,encounter_datetime,8,135704,1,encounter_datetime,0,UUID()
FROM encounter AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`AND B.`MaritalStatus` LIKE '%Single%';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,1054,encounter_id,encounter_datetime,8,5555,1,encounter_datetime,0,UUID()
FROM encounter AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`AND B.`MaritalStatus` LIKE '%Married%';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,1054,encounter_id,encounter_datetime,8,1059,1,encounter_datetime,0,UUID()
FROM encounter AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`AND B.`MaritalStatus` LIKE '%Widow%';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,1054,encounter_id,encounter_datetime,8,1058,1,encounter_datetime,0,UUID()
FROM encounter AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`AND B.`MaritalStatus` LIKE '%Divorce%';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,1054,encounter_id,encounter_datetime,8,1060,1,encounter_datetime,0,UUID()
FROM encounter AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`AND B.`MaritalStatus` LIKE '%Co-Habiting%';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,165794,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID()
FROM encounter AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No` AND  B.`IndexClientID` <> '';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,165798,encounter_id,encounter_datetime,8,CASE WHEN B.IndexType LIKE '%Sexual%' THEN 165797 WHEN B.IndexType LIKE '%Biological%' THEN 165796 WHEN B.IndexType LIKE '%Social%' THEN 165795 ELSE NULL END,1,encounter_datetime,0,UUID()
FROM encounter AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No` AND  B.`IndexClientID` <> '';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_text,creator,date_created,voided,UUID)
SELECT A.patient_id,165859,encounter_id,encounter_datetime,8,B.`IndexClientID`,1,encounter_datetime,0,UUID()
FROM encounter AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No` AND  B.`IndexClientID` <> '';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,165839,A.encounter_id,A.encounter_datetime,8,CASE WHEN B.Setting LIKE 'VCT%' THEN 160539 WHEN B.Setting LIKE 'TB%'THEN 160529
WHEN B.Setting LIKE 'STI%'THEN 160546 WHEN B.Setting LIKE 'FP%'THEN 5271 WHEN B.Setting LIKE 'OPD%'THEN 160542 WHEN B.Setting LIKE 'Ward%'THEN 161629
WHEN B.Setting LIKE 'Outreach Program%'THEN 160545 WHEN B.Setting LIKE 'Standalone HTS%'THEN 165838 WHEN B.Setting LIKE 'Community ART%'THEN 166135
 WHEN B.Setting LIKE 'Other%'THEN 5622 ELSE NULL END,1,A.encounter_datetime,0,UUID() FROM encounter AS A,
push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No` AND B.Setting <> '';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,165790,A.encounter_id,A.encounter_datetime,8,CASE WHEN B.FirstTimeVisit LIKE 'Yes%' THEN 1065 WHEN B.FirstTimeVisit LIKE 'No%'THEN 1066 ELSE NULL END,1,A.encounter_datetime,0,UUID() FROM encounter AS A,
push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No` AND B.FirstTimeVisit <> '';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165793,encounter_id,encounter_datetime,8,165793,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,165480,A.encounter_id,A.encounter_datetime,8,CASE WHEN B.Referred_From LIKE 'Self%' THEN 978 WHEN B.Referred_From LIKE 'TB%'THEN 160529
WHEN B.Referred_From LIKE 'STI%'THEN 160546 WHEN B.Referred_From LIKE 'FP%'THEN 5271 WHEN B.Referred_From LIKE 'OPD%'THEN 160542 WHEN B.Referred_From LIKE 'Ward%'THEN 161629
WHEN B.Referred_From LIKE 'Outreach Program%'THEN 160545 WHEN B.Referred_From LIKE 'Standalone HTS%'THEN 165838 WHEN B.Referred_From LIKE 'Community ART%'THEN 166135
 WHEN B.Referred_From LIKE 'Other%'THEN 5622 WHEN B.Referred_From LIKE 'Blood Bank%'THEN 165788 ELSE NULL END,1,A.encounter_datetime,0,UUID() FROM encounter AS A,
push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No` AND B.Referred_From <> '';

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165799,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,165800,A.encounter_id,A.encounter_datetime,8,CASE WHEN B.CurrentAge < 19 THEN 1066 WHEN B.CurrentAge > 18 THEN 1065 END ,1,A.encounter_datetime,0,UUID() FROM encounter AS A, push_hts AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`void_reason` = B.`No`;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,1063,encounter_id,encounter_datetime,8,2,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165801,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,159218,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165802,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165803,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165804,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,164809,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165884,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165806,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,1710,encounter_id,encounter_datetime,8,1,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165840,encounter_id,encounter_datetime,8,1229,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_datetime,creator,date_created,voided,UUID)
SELECT patient_id,165844,encounter_id,encounter_datetime,8,encounter_datetime,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165843,encounter_id,encounter_datetime,8,664,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;


INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165818,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165819,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,164848,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,159382,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_datetime,creator,date_created,voided,UUID)
SELECT patient_id,166242,encounter_id,encounter_datetime,8,encounter_datetime,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;


UPDATE encounter SET void_reason = NULL WHERE void_reason > 0;
 
 -- Risk Stratification Tool(Adults)
INSERT INTO encounter(encounter_type,patient_id,location_id,form_id,encounter_datetime,creator,date_created,voided,void_reason,visit_id,UUID)
SELECT 33,A.patient_id,8,70,A.date_started,1,A.date_started,0,A.void_reason,A.visit_id, UUID() FROM visit AS A,push_hts AS B  WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND B.CurrentAge > 14 AND A.`void_reason` = B.`No`;


INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166168,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166169,encounter_id,encounter_datetime,8,664,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_datetime,creator,date_created,voided,UUID)
SELECT patient_id,164400,encounter_id,encounter_datetime,8,DATE_ADD(encounter_datetime, INTERVAL -3 MONTH),1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166175,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166170,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166171,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165998,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166172,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166173,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166174,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,164401,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,164848,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;



-- ----------------------------------------------------------------------------------------
UPDATE encounter SET void_reason = NULL WHERE void_reason > 0;

-- Risk Stratification Tool Peadiatrics
INSERT INTO encounter(encounter_type,patient_id,location_id,form_id,encounter_datetime,creator,date_created,voided,void_reason,visit_id,UUID)
SELECT 34,A.patient_id,8,72,A.date_started,1,A.date_started,0,A.void_reason,A.visit_id, UUID() FROM visit AS A,push_hts AS B  WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND B.CurrentAge < 15 AND A.`void_reason` = B.`No`;


INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166161,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166162,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166163,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166164,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166165,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166166,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166167,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,164401,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,164848,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;


SET sql_mode='';
SET GLOBAL sql_mode='';
SET FOREIGN_KEY_CHECKS = 1;

UPDATE encounter SET void_reason = NULL WHERE void_reason > 0;
UPDATE visit SET void_reason = NULL WHERE void_reason > 0;
UPDATE person SET void_reason = NULL WHERE void_reason > 0;




-- =============================================
-- Next script creates Client intake form for existing postive clients that was updated without client intake form
-- ==============================================

-- Fix to display visits saved but not displaying on the visit tab

SET SQL_MODE='ALLOW_INVALID_DATES';
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO visit (patient_id,visit_type_id,date_started,date_stopped,location_id,creator,date_created,voided,UUID,indication_concept_id)

SELECT patient_id,1,encounter_datetime,encounter_datetime,8,1,encounter_datetime,0,UUID(),encounter_id FROM encounter
WHERE visit_id IS NULL AND voided = 0 ;

UPDATE encounter t1
JOIN (SELECT visit_id,patient_id,indication_concept_id FROM visit WHERE indication_concept_id IS NOT NULL) t2
ON t1.patient_id = t2.patient_id AND t1.encounter_id = t2.indication_concept_id
SET t1.visit_id = t2.visit_id ;

UPDATE visit SET indication_concept_id = NULL WHERE indication_concept_id IS NOT NULL;

SET sql_mode= '';
SET GLOBAL sql_mode = '';
SET FOREIGN_KEY_CHECKS = 1;

-- Import Unique Identifiers(Client Code, OpenMRS ID)
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO patient_identifier(patient_id,identifier,identifier_type,preferred,location_id,creator,date_created,voided,UUID)
SELECT HIVEnrollment.patient_id,Identifier.Identifier,8,1,8,1,NOW(),0,UUID()
FROM
(SELECT A.patient_id, A.encounter_datetime, A.encounter_id ,A.`visit_id`,B.`concept_id`,B.`value_datetime` FROM encounter AS A, obs AS B
WHERE A.`encounter_type` = 14 AND A.`voided` = 0 AND A.`encounter_id` = B.encounter_id AND B.concept_id = 160554 AND B.voided = 0 AND A.`patient_id` = B.person_id) AS HIVEnrollment

LEFT JOIN
(SELECT patient_id,identifier FROM patient_identifier WHERE identifier_type = 4) AS Identifier
ON Identifier.patient_id = HIVEnrollment.patient_id

LEFT JOIN 

(SELECT patient_id, encounter_datetime, encounter_id ,`visit_id`,encounter_type FROM encounter WHERE (encounter_type = 2 OR encounter_type = 20) AND voided = 0) AS ClientIntake
ON HIVEnrollment.patient_id = ClientIntake.patient_id

LEFT JOIN

 (SELECT A.patient_id, A.encounter_datetime, A.encounter_id ,A.`visit_id`,B.`concept_id`,B.`value_coded` FROM encounter AS A, obs AS B
WHERE A.`encounter_type` = 14 AND A.`voided` = 0 AND A.`encounter_id` = B.encounter_id AND B.concept_id = 160540 AND B.voided = 0 AND A.`patient_id` = B.person_id) AS CareEntryPoint
ON HIVEnrollment.patient_id = CareEntryPoint.patient_id


WHERE  CareEntryPoint.value_coded NOT IN (160563) AND ClientIntake.patient_id IS NULL;

-- Import Clients Into HTS Testing Service Programs
INSERT INTO patient_program(patient_id,program_id,date_enrolled,creator,date_created,voided,UUID)
SELECT HIVEnrollment.patient_id,4,HIVEnrollment.encounter_datetime,1,NOW(),0, UUID()
FROM
(SELECT A.patient_id, A.encounter_datetime, A.encounter_id ,A.`visit_id`,B.`concept_id`,B.`value_datetime` FROM encounter AS A, obs AS B
WHERE A.`encounter_type` = 14 AND A.`voided` = 0 AND A.`encounter_id` = B.encounter_id AND B.concept_id = 160554 AND B.voided = 0 AND A.`patient_id` = B.person_id) AS HIVEnrollment

LEFT JOIN 

(SELECT patient_id, encounter_datetime, encounter_id ,`visit_id` FROM encounter WHERE (encounter_type = 2 OR encounter_type = 20)  AND voided = 0) AS ClientIntake
ON HIVEnrollment.patient_id = ClientIntake.patient_id

WHERE ClientIntake.patient_id IS NULL;

-- Create Encounter for ClientIntake Form

SET @rownr=0;
-- Create Encounter For Client_Intake form
INSERT INTO encounter(encounter_type,patient_id,location_id,form_id,encounter_datetime,creator,date_created,voided,void_reason,visit_id,UUID)
SELECT 2,HIVEnrollment.patient_id,8,10,HIVEnrollment.encounter_datetime,1,HIVEnrollment.encounter_datetime,0,@rownr:=@rownr+1,HIVEnrollment.visit_id, UUID()
FROM
(SELECT A.patient_id, A.encounter_datetime, A.encounter_id ,A.`visit_id`,B.`concept_id`,B.`value_datetime` FROM encounter AS A, obs AS B
WHERE A.`encounter_type` = 14 AND A.`voided` = 0 AND A.`encounter_id` = B.encounter_id AND B.concept_id = 160554 AND B.voided = 0 AND A.`patient_id` = B.person_id) AS HIVEnrollment

LEFT JOIN 

(SELECT patient_id, encounter_datetime, encounter_id ,`visit_id` FROM encounter WHERE encounter_type = 2 AND voided = 0) AS ClientIntake
ON HIVEnrollment.patient_id = ClientIntake.patient_id

WHERE ClientIntake.patient_id IS NULL;


-- Create Observations for Client Intake Form
INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,166136,encounter_id,encounter_datetime,8,159940,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165839,encounter_id,encounter_datetime,8,160539,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165790,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165793,encounter_id,encounter_datetime,8,165793,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165480,encounter_id,encounter_datetime,8,978,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165799,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT A.patient_id,165800,A.encounter_id,A.encounter_datetime,8,CASE WHEN FLOOR(DATEDIFF(CURDATE(), B.birthdate) / 365.25) < 19 THEN 1066 WHEN FLOOR(DATEDIFF(CURDATE(), B.birthdate) / 365.25) > 18 THEN 1065 END ,1,A.encounter_datetime,0,UUID() FROM encounter AS A, person AS B WHERE A.void_reason > 0 AND A.void_reason IS NOT NULL AND A.`patient_id` = B.`person_id`;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,1063,encounter_id,encounter_datetime,8,2,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165801,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,159218,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165802,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165803,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165804,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,164809,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165884,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165806,encounter_id,encounter_datetime,8,1066,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,1710,encounter_id,encounter_datetime,8,1,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165840,encounter_id,encounter_datetime,8,1228,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165841,encounter_id,encounter_datetime,8,1228,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165842,encounter_id,encounter_datetime,8,1228,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_datetime,creator,date_created,voided,UUID)
SELECT patient_id,165844,encounter_id,encounter_datetime,8,encounter_datetime,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_datetime,creator,date_created,voided,UUID)
SELECT patient_id,165845,encounter_id,encounter_datetime,8,encounter_datetime,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_datetime,creator,date_created,voided,UUID)
SELECT patient_id,165846,encounter_id,encounter_datetime,8,encounter_datetime,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165843,encounter_id,encounter_datetime,8,703,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;


INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165820,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165818,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,165819,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,164848,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT patient_id,159382,encounter_id,encounter_datetime,8,1065,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_datetime,creator,date_created,voided,UUID)
SELECT patient_id,166242,encounter_id,encounter_datetime,8,encounter_datetime,1,encounter_datetime,0,UUID() FROM encounter WHERE void_reason > 0;

SET sql_mode='';
SET GLOBAL sql_mode='';
SET FOREIGN_KEY_CHECKS = 1;

UPDATE encounter SET void_reason = NULL WHERE void_reason > 0;
UPDATE visit SET void_reason = NULL WHERE void_reason > 0;
UPDATE person SET void_reason = NULL WHERE void_reason > 0;


-- Next set updates Patient Notification Services

-- ===================================================================
SET FOREIGN_KEY_CHECKS = 0;

UPDATE encounter SET void_reason = NULL WHERE void_reason > 0;
UPDATE visit SET void_reason = NULL WHERE void_reason > 0;
UPDATE person SET void_reason = NULL WHERE void_reason > 0;
UPDATE obs SET comments = NULL WHERE comments > 0;

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,comments,creator,date_created,voided,void_reason,UUID)
SELECT HTSDetails.`patient_id`,165858,ClientIntake.encounter_id,ClientIntake.encounter_datetime,8,NULL,HTSDetails.No,1,ClientIntake.encounter_datetime,0,HTSDetails.PhoneNumber,UUID() 
FROM
(SELECT DISTINCT B.`patient_id`,A.NO,A.ClientCode,A.family_name,A.given_name,A.gender,A.PhoneNumber,A.address,A.State,A.Country,A.Test_Date,A.Screening_Test_Result,A.CurrentAge,A.FirstTimeVisit,A.MaritalStatus,A.IndexClientID,A.IndexType
FROM push_hts AS A,patient_identifier AS B WHERE A.`IndexClientID` = B.`identifier` AND B.`identifier_type` = 4 AND A.`IndexClientID` <> '' ) AS HTSDetails

LEFT JOIN

(SELECT DISTINCT patient_id,encounter_id,encounter_datetime FROM encounter WHERE (encounter_type = 2 OR encounter_type = 20)) AS ClientIntake
ON HTSDetails.patient_id = ClientIntake.Patient_id;

-- ================================
INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,obs_group_id,value_text,creator,date_created,UUID)
SELECT HTSDetails.patient_id,166022,PartnerElication.encounter_id, PartnerElication.obs_datetime,8,PartnerElication.obs_id,HTSDetails.PhoneNumber,1,NOW(),UUID() FROM 
(SELECT B.`patient_id`,A.NO,A.ClientCode,A.family_name,A.given_name,A.gender,A.PhoneNumber,A.address,A.State,A.Country,A.Test_Date,A.Screening_Test_Result,A.CurrentAge,A.FirstTimeVisit,A.MaritalStatus,A.IndexClientID,A.IndexType
FROM push_hts AS A,patient_identifier AS B WHERE A.`IndexClientID` = B.`identifier` AND B.`identifier_type` = 4 AND A.`IndexClientID` IS NOT NULL ) AS HTSDetails

INNER JOIN 

(SELECT obs_id,person_id,encounter_id,obs_datetime,comments FROM obs WHERE comments IS NOT NULL AND comments > 0) AS PartnerElication

ON HTSDetails.patient_id = PartnerElication.person_id AND HTSDetails.`NO` = PartnerElication.`comments`  WHERE HTSDetails.PhoneNumber <> '';

-- ==============================================================

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,obs_group_id,value_text,creator,date_created,UUID)
SELECT HTSDetails.patient_id,166022,PartnerElication.encounter_id, PartnerElication.obs_datetime,8,PartnerElication.obs_id,HTSDetails.PhoneNumber,1,NOW(),UUID() FROM 
(SELECT B.`patient_id`,A.NO,A.ClientCode,A.family_name,A.given_name,A.gender,A.PhoneNumber,A.address,A.State,A.Country,A.Test_Date,A.Screening_Test_Result,A.CurrentAge,A.FirstTimeVisit,A.MaritalStatus,A.IndexClientID,A.IndexType
FROM push_hts AS A,patient_identifier AS B WHERE A.`IndexClientID` = B.`identifier` AND B.`identifier_type` = 4 AND A.`IndexClientID` <> '' ) AS HTSDetails

LEFT JOIN 

(SELECT obs_id,person_id,encounter_id,obs_datetime,comments FROM obs WHERE comments <> '' AND comments > 0) AS PartnerElication

ON HTSDetails.patient_id = PartnerElication.person_id AND HTSDetails.`NO` = PartnerElication.`comments` WHERE HTSDetails.PhoneNumber <> '';

-- ==============================================================

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,obs_group_id,value_coded,creator,date_created,UUID)
SELECT HTSDetails.patient_id,165798,PartnerElication.encounter_id, PartnerElication.obs_datetime,8,PartnerElication.obs_id,
CASE WHEN HTSDetails.IndexType LIKE '%sexual%'THEN 165797 WHEN HTSDetails.IndexType LIKE '%Biological%'THEN 165796 WHEN HTSDetails.IndexType LIKE '%social%'THEN 165795 ELSE NULL END, 1,NOW(),UUID() FROM 
(SELECT B.`patient_id`,A.NO,A.ClientCode,A.family_name,A.given_name,A.gender,A.PhoneNumber,A.address,A.State,A.Country,A.Test_Date,A.Screening_Test_Result,A.CurrentAge,A.FirstTimeVisit,A.MaritalStatus,A.IndexClientID,A.IndexType
FROM push_hts AS A,patient_identifier AS B WHERE A.`IndexClientID` = B.`identifier` AND B.`identifier_type` = 4 AND A.`IndexClientID` <> '' ) AS HTSDetails

LEFT JOIN 

(SELECT obs_id,person_id,encounter_id,obs_datetime,comments FROM obs WHERE comments <> '' AND comments > 0) AS PartnerElication

ON HTSDetails.patient_id = PartnerElication.person_id AND HTSDetails.`NO` = PartnerElication.`comments` WHERE HTSDetails.IndexType <> '';


-- ==============================================================

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,obs_group_id,value_text,creator,date_created,UUID)
SELECT HTSDetails.patient_id,161135,PartnerElication.encounter_id, PartnerElication.obs_datetime,8,PartnerElication.obs_id,CONCAT(HTSDetails.family_name,' ',HTSDetails.given_name),1,NOW(),UUID() FROM 
(SELECT B.`patient_id`,A.NO,A.ClientCode,A.family_name,A.given_name,A.gender,A.PhoneNumber,A.address,A.State,A.Country,A.Test_Date,A.Screening_Test_Result,A.CurrentAge,A.FirstTimeVisit,A.MaritalStatus,A.IndexClientID,A.IndexType
FROM push_hts AS A,patient_identifier AS B WHERE A.`IndexClientID` = B.`identifier` AND B.`identifier_type` = 4 AND A.`IndexClientID` <> '' ) AS HTSDetails

LEFT JOIN 

(SELECT obs_id,person_id,encounter_id,obs_datetime, comments FROM obs WHERE comments <> '' AND comments > 0) AS PartnerElication

ON HTSDetails.patient_id = PartnerElication.person_id AND HTSDetails.`NO` = PartnerElication.`comments` WHERE HTSDetails.family_name <> '';

-- ==============================================================

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,obs_group_id,value_coded,creator,date_created,UUID)
SELECT HTSDetails.patient_id,165857,PartnerElication.encounter_id, PartnerElication.obs_datetime,8,PartnerElication.obs_id,
CASE WHEN HTSDetails.gender LIKE '%M%'THEN 165184 WHEN HTSDetails.gender LIKE '%F%'THEN 165185 ELSE NULL END, 1,NOW(),UUID() FROM 
(SELECT B.`patient_id`,A.NO,A.ClientCode,A.family_name,A.given_name,A.gender,A.PhoneNumber,A.address,A.State,A.Country,A.Test_Date,A.Screening_Test_Result,A.CurrentAge,A.FirstTimeVisit,A.MaritalStatus,A.IndexClientID,A.IndexType
FROM push_hts AS A,patient_identifier AS B WHERE A.`IndexClientID` = B.`identifier` AND B.`identifier_type` = 4 AND A.`IndexClientID` <> '' ) AS HTSDetails

LEFT JOIN 

(SELECT obs_id,person_id,encounter_id,obs_datetime,comments FROM obs WHERE comments <> '' AND comments > 0) AS PartnerElication

ON HTSDetails.patient_id = PartnerElication.person_id AND HTSDetails.`NO` = PartnerElication.`comments` WHERE HTSDetails.gender <> '';

-- ==============================================================

INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,obs_group_id,value_text,creator,date_created,UUID)
SELECT HTSDetails.patient_id,166021,PartnerElication.encounter_id, PartnerElication.obs_datetime,8,PartnerElication.obs_id,HTSDetails.address,1,NOW(),UUID() FROM 
(SELECT B.`patient_id`,A.NO,A.ClientCode,A.family_name,A.given_name,A.gender,A.PhoneNumber,A.address,A.State,A.Country,A.Test_Date,A.Screening_Test_Result,A.CurrentAge,A.FirstTimeVisit,A.MaritalStatus,A.IndexClientID,A.IndexType
FROM push_hts AS A,patient_identifier AS B WHERE A.`IndexClientID` = B.`identifier` AND B.`identifier_type` = 4 AND A.`IndexClientID` <> '' ) AS HTSDetails

LEFT JOIN 

(SELECT obs_id,person_id,encounter_id,obs_datetime, comments FROM obs WHERE comments <> '' AND comments > 0) AS PartnerElication

ON HTSDetails.patient_id = PartnerElication.person_id AND HTSDetails.`NO` = PartnerElication.`comments` WHERE HTSDetails.address <> '';

-- ==============================================================

-- Insert Date to Missing "Index Elication Consent" in Client Intake Form for Patners Elicited
  SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)
SELECT DISTINCT ClientIntake.patient_id,164800,ClientIntake.encounter_id,ClientIntake.encounter_datetime,8,1065,1,ClientIntake.encounter_datetime,0,UUID()
   FROM
     
 (SELECT patient_id,encounter_id,encounter_datetime  FROM encounter  WHERE (encounter_type = 2 OR encounter_type = 20) AND voided = 0 )  AS ClientIntake
        LEFT JOIN
  (SELECT person_id,obs_id,encounter_id FROM obs WHERE concept_id = 165858 AND voided = 0) AS PartnerElicit
  ON ClientIntake.patient_id = PartnerElicit.person_id AND ClientIntake.encounter_id = PartnerElicit.encounter_id 
   LEFT JOIN      
 (SELECT person_id,encounter_id,value_coded FROM obs WHERE concept_id = 164800 ) AS IndexElicitationConsent
  ON ClientIntake.patient_id = IndexElicitationConsent.person_id AND ClientIntake.encounter_id = IndexElicitationConsent.encounter_id 
  WHERE IndexElicitationConsent.person_id IS NULL AND PartnerElicit.person_id IS NOT NULL;
    SET FOREIGN_KEY_CHECKS = 1;
    
    
  -- Insert Date to Missing "Partner Address" in Client Intake Form for Patners Elicited
  SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO obs(person_id,concept_id,encounter_id,obs_group_id,obs_datetime,location_id,value_text,creator,date_created,voided,UUID)
SELECT DISTINCT ClientIntake.patient_id,166021,ClientIntake.encounter_id,PartnerElicit.obs_id,ClientIntake.encounter_datetime,8,(SELECT CONCAT(address2,',',city_village,',',state_province) FROM location WHERE location_id = 8),1,ClientIntake.encounter_datetime,0,UUID()
   FROM
     
 (SELECT DISTINCT patient_id,encounter_id,encounter_datetime  FROM encounter  WHERE (encounter_type = 2 OR encounter_type = 20) AND voided = 0 )  AS ClientIntake
        LEFT JOIN
  (SELECT DISTINCT person_id,obs_id,encounter_id FROM obs WHERE concept_id = 165858 AND voided = 0) AS PartnerElicit
  ON ClientIntake.patient_id = PartnerElicit.person_id AND ClientIntake.encounter_id = PartnerElicit.encounter_id 
   LEFT JOIN      
 (SELECT DISTINCT person_id,encounter_id,value_text,obs_group_id FROM obs WHERE concept_id = 166021 ) AS PartnerAddress
  ON PartnerElicit.person_id = PartnerAddress.person_id AND PartnerElicit.encounter_id = PartnerAddress.encounter_id AND PartnerAddress.obs_group_id = PartnerElicit.obs_id
  WHERE PartnerAddress.person_id IS NULL AND PartnerElicit.person_id IS NOT NULL;
    SET FOREIGN_KEY_CHECKS = 1;   
    
  -- Insert Date to Missing "Partner Number" in Client Intake Form for Patners Elicited
  SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO obs(person_id,concept_id,encounter_id,obs_group_id,obs_datetime,location_id,value_text,creator,date_created,voided,UUID)
SELECT DISTINCT ClientIntake.patient_id,166022,ClientIntake.encounter_id,PartnerElicit.obs_id,ClientIntake.encounter_datetime,8,CASE WHEN PhoneNumber.value IS NOT NULL THEN PhoneNumber.value ELSE '00000000000' END ,1,ClientIntake.encounter_datetime,0,UUID()
   FROM
 
 (SELECT DISTINCT patient_id,encounter_id,encounter_datetime  FROM encounter  WHERE (encounter_type = 2 OR encounter_type = 20) AND voided = 0 )  AS ClientIntake
        LEFT JOIN
  (SELECT DISTINCT person_id,obs_id,encounter_id FROM obs WHERE concept_id = 165858 AND voided = 0) AS PartnerElicit
  ON ClientIntake.patient_id = PartnerElicit.person_id AND ClientIntake.encounter_id = PartnerElicit.encounter_id 
  LEFT JOIN
  (SELECT person_id,VALUE FROM person_attribute WHERE person_attribute_type_id = 8 AND VALUE <> 'NULL') AS PhoneNumber
  ON PhoneNumber.person_id = ClientIntake.patient_id
   LEFT JOIN      
 (SELECT DISTINCT person_id,encounter_id,value_text,obs_group_id FROM obs WHERE concept_id = 166022 ) AS PartnerNumber
  ON PartnerElicit.person_id = PartnerNumber.person_id AND PartnerElicit.encounter_id = PartnerNumber.encounter_id AND PartnerNumber.obs_group_id = PartnerElicit.obs_id
  WHERE PartnerNumber.person_id IS NULL AND PartnerElicit.person_id IS NOT NULL;
    SET FOREIGN_KEY_CHECKS = 1;  

 -- Insert Yes/No to Missing "Informed Consent" in Client Intake Form
  SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO obs(person_id,concept_id,encounter_id,obs_datetime,location_id,value_coded,creator,date_created,voided,UUID)

SELECT DISTINCT ClientIntake.patient_id,1710,ClientIntake.encounter_id,ClientIntake.encounter_datetime,8,1,1,ClientIntake.encounter_datetime,0,UUID()
   FROM
 (SELECT B.identifier ,A.patient_id,A.encounter_datetime,A.encounter_id  FROM encounter AS A,patient_identifier AS B WHERE A.encounter_type = 2 AND A.voided = 0 AND B.voided = 0 AND B.identifier_type= 8  AND A.patient_id = B.patient_id )  AS ClientIntake
        LEFT JOIN
  (SELECT person_id,obs_id,concept_id,encounter_id,obs_datetime, value_coded FROM obs WHERE concept_id = 1710 AND voided = 0) AS InfoConsent
  ON ClientIntake.patient_id = InfoConsent.person_id AND ClientIntake.encounter_id = InfoConsent.encounter_id 
WHERE InfoConsent.value_coded IS NULL ;
SET FOREIGN_KEY_CHECKS = 1;


DROP TABLE IF EXISTS push_hts;

UPDATE encounter SET void_reason = NULL WHERE void_reason > 0;
UPDATE visit SET void_reason = NULL WHERE void_reason > 0;
UPDATE person SET void_reason = NULL WHERE void_reason > 0;
UPDATE obs SET comments = NULL WHERE comments > 0;
SET FOREIGN_KEY_CHECKS = 0;


s