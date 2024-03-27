#Search all Visit relating to the ID on the “Visit” table using
SELECT * FROM `visit` WHERE `patient_id` =102;CT107;
SELECT * FROM encounter WHERE patient_id= 102;
SELECT * FROM obs WHERE person_id= 102;
#Trace each “Visit_id” to its encounter using 
SELECT * FROM encounter WHERE visit_id IN (SELECT visit_id FROM `visit` WHERE `patient_id` =1578);

UPDATE `visit` SET `changed_by` = NULL WHERE `changed_by` = 0;
UPDATE `encounter` SET `changed_by` = NULL WHERE `changed_by` = 0;

LAST_INSERT_ID().