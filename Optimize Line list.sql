DELIMITER $$
CREATE TRIGGER after_insert_encounter
AFTER INSERT ON `encounter`
FOR EACH ROW
BEGIN
    IF (SELECT `encounter_type` FROM `encounter` WHERE encounter_id = (SELECT MAX(`encounter_id`)FROM `encounter`) LIMIT 1) = 13 THEN
        -- Update column B in table B where the ID matches
        UPDATE `cihp_linelist`
        SET `LastPickupDate` = GetEncounterDate()
        WHERE `patient_id` = `GetLastInsertedID`(); 
    END IF;
END;
$$
DELIMITER ;


DELIMITER $$
DROP FUNCTION IF EXISTS `GetEncounterID`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetEncounterID`() 
RETURNS INT READS SQL DATA DETERMINISTIC 
BEGIN
   DECLARE oll_encounterID INT;
(SELECT MAX(`encounter_id`) INTO oll_encounterID FROM `encounter` WHERE `voided` = 0 LIMIT 1);

RETURN oll_encounterID;
END$$ 
DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS `GetLastInsertedID`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetLastInsertedID`() 
RETURNS INT READS SQL DATA DETERMINISTIC 
BEGIN
   DECLARE oll_id INT;
(SELECT `patient_id` INTO oll_id FROM  `encounter`  WHERE encounter_id= GetEncounterID LIMIT 1);

RETURN oll_id;
END$$ 
DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS `GetEncounterDate`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetEncounterDate`() 
RETURNS DATETIME READS SQL DATA DETERMINISTIC 
BEGIN
   DECLARE oll_lastDate DATETIME;
(SELECT `encounter_datetime` INTO oll_lastDate FROM  `encounter`  WHERE `patient_id` = GetLastInsertedID() AND `voided` = 0 LIMIT 1);

RETURN oll_lastDate;
END$$ 
DELIMITER ;




DELIMITER $$



SELECT `patient_id` FROM `encounter` WHERE `encounter_id`=(SELECT LAST_INSERT_ID());
(SELECT `encounter_type` FROM `encounter` WHERE encounter_id = (SELECT MAX(`encounter_id`)FROM `encounter`) LIMIT 1);


SELECT GetEncounterDate();