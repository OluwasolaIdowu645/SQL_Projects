SELECT * FROM `patient_identifier` WHERE `identifier`='IHSD/OSS/AKP/0170';

SELECT * FROM encounter WHERE patient_id=8469;
SELECT * FROM encounter WHERE patient_id=10211;

SELECT * FROM C WHERE patient_id IN (10198, 10200);

SELECT * FROM `patient_identifier` WHERE identifier IN ("IHSD/OSS/AKP/0071", 
"IHSD/OSS/AKP/9158", 
"IHSD/OSS/AKP/0068", 
"IHSD/OSS/AKP/0058", 
"IHSD/OSS/AKP/0166", 
"IHSD/OSS/AKP/166", 
"IHSD/OSS/AKP/1097", 
"IHSD/OSS/AKP/0167", 
"IHSD/OSS/AKP/1113", 
"IHSD/OSS/AKP/1093", 
"IHSD/OSS/AKP/1108", 
"IHSD/OSS/AKP/1115", 
"IHSD/OSS/AKP/1390", 
"IHSD/OSS/AKP/137", 
"IHSD/OSS/AKP/119", 
"IHSD/OSS/AKP/131", 
"IHSD/OSS/AKP/105", 
"IHSD/OSS/AKP/138", 
"IHSD/OSS/AKP/113", 
"IHSD/OSS/AKP/132", 
"IHSD/OSS/AKP/120", 
"IHSD/OSS/AKP/139", 
"IHSD/OSS/AKP/106", 
"IHSD/OSS/AKP/114", 
"IHSD/OSS/AKP/107", 
"IHSD/OSS/AKP/140", 
"IHSD/OSS/AKP/121", 
"IHSD/OSS/AKP/133", 
"IHSD/OSS/AKP/142", 
"IHSD/OSS/AKP/125", 
"IHSD/OSS/AKP/141", 
"IHSD/OSS/AKP/115", 
"IHSD/OSS/AKP/134", 
"IHSD/OSS/AKP/122", 
"IHSD/OSS/AKP/101", 
"IHSD/OSS/AKP/123", 
"IHSD/OSS/AKP/108", 
"IHSD/OSS/AKP/135", 
"IHSD/OSS/AKP/116", 
"IHSD/OSS/AKP/102", 
"IHSD/OSS/AKP/143", 
"IHSD/OSS/AKP/136", 
"IHSD/OSS/AKP/124", 
"IHSD/OSS/AKP/117", 
"IHSD/OSS/AKP/127", 
"IHSD/OSS/AKP/103", 
"IHSD/OSS/AKP/144", 
"IHSD/OSS/AKP/157", 
"IHSD/OSS/AKP/0152", 
"IHSD/OSS/AKP/0153", 
"IHSD/OSS/AKP/0154", 
"IHSD/OSS/AKP/0155", 
"IHSD/OSS/AKP/0156", 
"IHSD/OSS/AKP/0157", 
"IHSD/OSS/AKP/0159", 
"IHSD/OSS/AKP/0160", 
"IHSD/OSS/AKP/0161", 
"IHSD/OSS/AKP/0162", 
"IHSD/OSS/AKP/0163", 
"IHSD/OSS/AKP/0164", 
"IHSD/OSS/AKP/0165", 
"IHSD/OSS/AKP/0067", 
"IHSD/OSS/AKP/0112", 
"IHSD/OSS/AKP/0012", 
"IHSD/OSS/AKP/0019", 
"IHSD/OSS/AKP/1273", 
"IHSD/OSS/AKP/0027", 
"IHSD/OSS/AKP/0016", 
"IHSD/OSS/AKP/0096", 
"IHSD/OSS/AKP/0095", 
"IHSD/OSS/AKP/2022", 
"IHSD/OSS/AKP/0099", 
"IHSD/OSS/AKP/0012", 
"IHSD/OSS/AKP/0019", 
"IHSD/OSS/AKP/1272", 
"IHSD/OSS/AKP/0027", 
"IHSD/OSS/AKP/0001", 
"IHSD/OSS/AKP/0016", 
"IHSD/OSS/AKP/0028", 
"IHSD/OSS/AKP/0003", 
"IHSD/OSS/AKP/0030", 
"IHSD/OSS/AKP/0009", 
"IHSD/OSS/AKP/0010", 
"IHSD/OSS/AKP/0046", 
"IHSD/OSS/AKP/0048", 
"IHSD/OSS/AKP/0013", 
"IHSD/OSS/AKP/0099", 
"IHSD/OSS/AKP/0098");
SELECT * FROM visi10198;
SELECT * FROM encounter WHEREt WHERE patient_id= patient_id=10198 GROUP BY visit_id;

SELECT * FROM `patient_program` WHERE patient_id IN (10198, 10200);


SELECT * FROM `patient_identifier` WHERE patient_id=8469; #IHSD/OSS/AKP/0073
SELECT * FROM `patient_identifier` WHERE patient_id=10198; #IHSD/OSS/AKP/0170
SELECT * FROM `patient_identifier` WHERE patient_id=10200; #IHSD/OSS/AKP/0171
#IHSD/OSS/AKP/0001 - 7796 - 06/04/2021 - 108YC
#IHSD/OSS/AKP/0003 - 7797

#worked
#IHSD/OSS/AKP/0002 - 7804
SELECT * FROM `patient_identifier` WHERE `patient_id` IN (7804, 7796, 7797);


SELECT `patient_identifier_id`, `patient_id`, `identifier`, `identifier_type`, COUNT(`identifier_type`) FROM `patient_identifier` GROUP BY `patient_id`,`identifier_type`;

SELECT COUNT(`patient_id`) FROM `visit` WHERE `voided`=0;
SELECT COUNT(DISTINCT `patient_id`) FROM `encounter` WHERE `voided`=0;

"visit_id"
"40517"
"44214"
"47610"
"48602"
"50660"
"53745";
SELECT * FROM `encounter_provider` WHERE `voided`=0;
SELECT `encounter_id` FROM `encounter` WHERE `voided`=0 AND `patient_id`=10198;
SELECT * FROM `encounter_provider` WHERE `voided`=0 AND `encounter_id` IN (
"109283",
"109284",
"109285",
"109286",
"109287",
"109288",
"109963",
"118249",
"118250",
"126120",
"126121",
"131754",
"133925",
"133926",
"142058",
"142059");
UPDATE `encounter_provider`
SET `provider_id` =1
WHERE `provider_id` !=1;

SELECT `identifier`, COUNT(`identifier`) FROM `patient_identifier` WHERE `voided`=0 GROUP BY `identifier`, `identifier_type`;
SELECT `patient_identifier_id`,`patient_id`,`identifier`,`identifier_type`, COUNT(`identifier_type`)
 FROM `patient_identifier` WHERE `voided`=1 GROUP BY `identifier_type`;