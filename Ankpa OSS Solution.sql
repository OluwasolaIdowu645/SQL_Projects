SELECT `patient_id`, `identifier` FROM `patient_identifier` WHERE `identifier` IN
("CT174", 
"CT149", 
" CT107", 
"CT244", 
"TI258", 
"CT216", 
"CT237"
);

UPDATE `visit` 
SET `changed_by` = NULL WHERE
`changed_by` = 0; 
UPDATE `encounter` 
SET `changed_by` = NULL WHERE
`changed_by` = 0;

AND `patient_id` IN ("7796", 
"7797", 
"7820", 
"7819", 
"7818", 
"7811", 
"7808", 
"7814", 
"7815", 
"7912", 
"7925", 
"7929", 
"8135", 
"8133", 
"8333", 
"8343", 
"8342", 
"8338", 
"8337", 
"8483", 
"8600", 
"8601", 
"8603", 
"8604", 
"8605", 
"8606", 
"8607", 
"8608", 
"8610", 
"8611", 
"8612", 
"8613", 
"8833", 
"8834", 
"8835", 
"8853");