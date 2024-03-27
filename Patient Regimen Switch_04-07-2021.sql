-- =============================================
-- Modified date: 04/07/2021
-- Description: Query to select Patient who switched Regimen
-- =============================================
SET @startdate = '2000-10-01';
SET @enddate = '2021-07-02';
SET @row_number = 0;SET @row_number1 = 0;SET @row_number2 = 0;SET @row_number3 = 0;SET @row_number4 = 0;
-- =====================================================
-- Create function for concept_id
-- ===============================================
DELIMITER $$


DROP FUNCTION IF EXISTS `get_concept_name`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_concept_name`(conceptid INT) RETURNS TEXT CHARSET latin1 
READS SQL DATA
DETERMINISTIC
BEGIN
	RETURN (SELECT NAME FROM  concept_name  WHERE concept_id = conceptid AND locale = 'en' AND locale_preferred = 1 LIMIT 1);
	
	
    END$$
    
DELIMITER ;



SELECT "CIHP" AS "IP",
   (SELECT `state_province`  FROM  `location` WHERE `location_id` = 8 LIMIT 1) AS State,
   (SELECT `city_village`  FROM  `location` WHERE `location_id` = 8 LIMIT 1) LGA,
      (SELECT `address2`  FROM  `location` WHERE `location_id` = 8 LIMIT 1) City,
   (SELECT property_value FROM global_property WHERE property = 'facility_datim_code' LIMIT 1) Datim_Code,
   (SELECT `name`  FROM  `location` WHERE `location_id` = 8 LIMIT 1) FacilityName,
PatientUniqueID.identifier AS PatientUniqueID,HospNo.identifier AS HospitalNo, Bioinfo.Gender,Bioinfo.birthdate,Bioinfo.CurrentAge, Bioinfo.family_name AS Surname,Bioinfo.given_name AS FirstName,PhoneNo.PhoneNumber,Address.Address,
pharmacy.value_numeric AS DaysOfARVRefill,pharmacy.CurrentARTStatus28Days_Pharmacy,
pharmacy.CurrentARTStatus90Days_Pharmacy,MainTb2.Regimen AS Previous_Regimen,

DATE_FORMAT(MainTb2.encounter_datetime,'%Y-%m-%d')  AS PreviousRegimenStartDate,MainTb1.Regimen AS SwitchedRegimen,
DATE_FORMAT(MainTb1.encounter_datetime,'%Y-%m-%d')  AS RegimenSwitchDate,pharmacy.CurrentRegimen,pharmacy.Regimen AS CurrentRegimen_AsAtToday,DATE_FORMAT(pharmacy.Pharm_VisitLastDate,'%Y-%m-%d') AS CurrentRegimenLatestVisitDate ,
CASE WHEN MainTb1.Regimen = pharmacy.Regimen THEN 'PatientStillOnSwitchedRegimen' WHEN MainTb1.Regimen <> pharmacy.Regimen THEN 'Check_If_Actually SwitchedAgain_To_CurrentRegimen_Or_Entry_Error' ELSE NULL END AS 'Switched_Validation(SwitchedRegimen_vs_CurrentRegimen)'
 
 
FROM 

(SELECT person_id FROM person) AS person
LEFT JOIN

(SELECT Table1.patient_id,Table1.encounter_datetime,Table1.Regimen
FROM
(
SELECT @row_number :=CASE WHEN @patient_id = Tb2.patient_id THEN @row_number + 1 ELSE 1 END AS num, @patient_id := Tb2.patient_id AS patient_id,
Tb2.encounter_datetime,Tb2.CurrentRegimen,Tb2.Regimen
FROM
(
SELECT @row_number1 :=CASE WHEN @patient_id = Lpickup.patient_id THEN @row_number + 1 ELSE 1 END AS num, @patient_id := Lpickup.patient_id AS patient_id,
Lpickup.encounter_datetime,CurrentRegimen.CurrentRegimen,Regimen.Regimen


  FROM
  (       
SELECT B.identifier ,A.patient_id,A.encounter_datetime,A.encounter_id  FROM encounter AS A,patient_identifier AS B WHERE A.encounter_type = 13 AND A.voided = 0 AND B.voided = 0 AND B.identifier_type= 4  AND A.patient_id = B.patient_id
  ) AS Lpickup
  
     LEFT JOIN    
         (
SELECT DISTINCT B.person_id,B.concept_id, B.obs_datetime,B.encounter_id,B.value_numeric,B.obs_group_id
FROM obs AS A, obs AS B WHERE A.concept_id = 162240 AND B.concept_id = 159368 AND A.person_id = B.person_id AND A.voided = 0 AND B.voided = 0 AND A.obs_id = B.obs_group_id AND B.value_numeric IS NOT NULL AND A.encounter_id = B.encounter_id
) AS MedDuration

ON Lpickup.patient_id = MedDuration.person_id   AND Lpickup.encounter_id = MedDuration.encounter_id


LEFT JOIN        
        
 (SELECT person_id,encounter_id, CASE WHEN concept_id = 165708 THEN get_concept_name(value_coded) END AS CurrentRegimen
FROM obs WHERE concept_id = 165708 ) AS CurrentRegimen
ON LPickup.patient_id = CurrentRegimen.person_id AND LPickup.encounter_id = CurrentRegimen.encounter_id
LEFT JOIN
(SELECT person_id,encounter_id, 
CASE WHEN concept_id IN (164506,164513,165702,164507,164514,165703) THEN get_concept_name(value_coded) END AS Regimen
FROM obs WHERE concept_id IN (164506,164513,165702,164507,164514,165703) ) AS Regimen
ON LPickup.patient_id = Regimen.person_id AND LPickup.encounter_id = Regimen.encounter_id

GROUP BY Regimen.Regimen,Lpickup.patient_id
ORDER BY Lpickup.patient_id,Lpickup.encounter_datetime
) AS Tb2
  ORDER BY Tb2.patient_id,Tb2.encounter_datetime DESC
) AS Table1
WHERE Table1.num = 1) AS MainTb1
ON person.`person_id` = MainTb1.patient_id
LEFT JOIN

(SELECT Table2.patient_id,Table2.encounter_datetime,Table2.Regimen
FROM
(
SELECT @row_number2 :=CASE WHEN @patient_id = Tb2.patient_id THEN @row_number + 1 ELSE 1 END AS num, @patient_id := Tb2.patient_id AS patient_id,
Tb2.encounter_datetime,Tb2.CurrentRegimen,Tb2.Regimen
FROM
(
SELECT @row_number3 :=CASE WHEN @patient_id = Lpickup.patient_id THEN @row_number + 1 ELSE 1 END AS num, @patient_id := Lpickup.patient_id AS patient_id,
Lpickup.encounter_datetime,CurrentRegimen.CurrentRegimen,Regimen.Regimen


  FROM
  (       
SELECT B.identifier ,A.patient_id,A.encounter_datetime,A.encounter_id  FROM encounter AS A,patient_identifier AS B WHERE A.encounter_type = 13 AND A.voided = 0 AND B.voided = 0 AND B.identifier_type= 4  AND A.patient_id = B.patient_id
  ) AS Lpickup
  
     LEFT JOIN    
         (
SELECT DISTINCT B.person_id,B.concept_id, B.obs_datetime,B.encounter_id,B.value_numeric,B.obs_group_id
FROM obs AS A, obs AS B WHERE A.concept_id = 162240 AND B.concept_id = 159368 AND A.person_id = B.person_id AND A.voided = 0 AND B.voided = 0 AND A.obs_id = B.obs_group_id AND B.value_numeric IS NOT NULL AND A.encounter_id = B.encounter_id
) AS MedDuration

ON Lpickup.patient_id = MedDuration.person_id   AND Lpickup.encounter_id = MedDuration.encounter_id


LEFT JOIN        
        
 (SELECT person_id,encounter_id, CASE WHEN concept_id = 165708 THEN get_concept_name(value_coded) END AS CurrentRegimen
FROM obs WHERE concept_id = 165708 ) AS CurrentRegimen
ON LPickup.patient_id = CurrentRegimen.person_id AND LPickup.encounter_id = CurrentRegimen.encounter_id
LEFT JOIN
(SELECT person_id,encounter_id, 
CASE WHEN concept_id IN (164506,164513,165702,164507,164514,165703) THEN get_concept_name(value_coded) END AS Regimen
FROM obs WHERE concept_id IN (164506,164513,165702,164507,164514,165703) ) AS Regimen
ON LPickup.patient_id = Regimen.person_id AND LPickup.encounter_id = Regimen.encounter_id

GROUP BY Regimen.Regimen,Lpickup.patient_id
ORDER BY Lpickup.patient_id,Lpickup.encounter_datetime
) AS Tb2
  ORDER BY Tb2.patient_id,Tb2.encounter_datetime DESC
) AS Table2
WHERE Table2.num = 2) AS MainTb2
ON MainTb2.patient_id = MainTb1.patient_id

-- Pharmacy Form Details
LEFT JOIN
(       
        SELECT DISTINCT LastPickup.patient_id,
LastPickup.encounter_datetime AS Pharm_VisitLastDate,LastPickup.CurrentRegimen,LastPickup.Regimen,
LastPickup.value_numeric,IF(DATE_ADD(DATE_ADD(LastPickup.encounter_datetime, INTERVAL LastPickup.value_numeric DAY) ,INTERVAL (28) DAY) >= DATE_FORMAT(CURDATE(),'%Y-%m-%d 23:59:59') ,'Active','Inactive') AS CurrentARTStatus28Days_Pharmacy,
IF(DATE_ADD(DATE_ADD(LastPickup.encounter_datetime, INTERVAL LastPickup.value_numeric DAY) ,INTERVAL (90) DAY) >= DATE_FORMAT(CURDATE(),'%Y-%m-%d 23:59:59') ,'Active','Inactive') AS CurrentARTStatus90Days_Pharmacy
 
        
         FROM
        (      
  SELECT  @row_number4 :=CASE WHEN @patient_id = Tb2.patient_id THEN @row_number + 1 ELSE 1 END AS num, @patient_id := Tb2.patient_id AS patient_id,
Tb2.encounter_datetime,Tb2.CurrentRegimen,Tb2.Regimen,
Tb2.value_numeric,
Tb2.value_numeric1
 
  FROM
  (
 SELECT 
Lpickup.patient_id,Lpickup.encounter_datetime,CurrentRegimen.CurrentRegimen,Regimen.Regimen,
MedDuration.value_numeric,(MedDuration.value_numeric + 29) AS value_numeric1

  FROM
  (       
SELECT B.identifier ,A.patient_id,A.encounter_datetime,A.encounter_id  FROM encounter AS A,patient_identifier AS B WHERE A.encounter_type = 13 AND A.voided = 0 AND B.voided = 0 AND B.identifier_type= 4  AND A.patient_id = B.patient_id
  ) AS Lpickup
  
     LEFT JOIN    
         (
SELECT DISTINCT B.person_id,B.concept_id, B.obs_datetime,B.encounter_id,B.value_numeric,B.obs_group_id
FROM obs AS A, obs AS B WHERE A.concept_id = 162240 AND B.concept_id = 159368 AND A.person_id = B.person_id AND A.voided = 0 AND B.voided = 0 AND A.obs_id = B.obs_group_id AND B.value_numeric IS NOT NULL AND A.encounter_id = B.encounter_id
) AS MedDuration

ON Lpickup.patient_id = MedDuration.person_id   AND Lpickup.encounter_id = MedDuration.encounter_id


LEFT JOIN        
        
 (SELECT person_id,encounter_id, CASE WHEN concept_id = 165708 THEN get_concept_name(value_coded) END AS CurrentRegimen
FROM obs WHERE concept_id = 165708 ) AS CurrentRegimen
ON LPickup.patient_id = CurrentRegimen.person_id AND LPickup.encounter_id = CurrentRegimen.encounter_id
LEFT JOIN
(SELECT person_id,encounter_id, 
CASE WHEN concept_id IN (164506,164513,165702,164507,164514,165703) THEN get_concept_name(value_coded) END AS Regimen
FROM obs WHERE concept_id IN (164506,164513,165702,164507,164514,165703) ) AS Regimen
ON LPickup.patient_id = Regimen.person_id AND LPickup.encounter_id = Regimen.encounter_id


WHERE LPickup.encounter_datetime <= DATE_FORMAT(NOW(),'%Y-%m-%d 23:59:59')
) AS Tb2
  ORDER BY Tb2.patient_id,Tb2.encounter_datetime DESC
 ) AS LastPickup WHERE LastPickup.num = 1 
 GROUP BY LastPickup.patient_id
) AS Pharmacy
ON MainTb1.`patient_id` = Pharmacy.patient_id

-- ===============================
-- Personal History (Biographical) Information
-- =================================
LEFT JOIN
(SELECT DISTINCT A.person_id,A.birthdate, CASE WHEN A.gender = 'F' THEN 'Female' WHEN A.gender = 'M' THEN 'Male' ELSE NULL END AS Gender,FLOOR(DATEDIFF(CURDATE(), A.birthdate) / 365.25) AS CurrentAge,B.given_name, B.family_name FROM person AS A
JOIN person_name AS B USING (person_id) WHERE A.voided = 0 AND B.voided = 0 ) AS BioInfo
ON BioInfo.person_id = MainTb1.`patient_id`
LEFT JOIN
(SELECT DISTINCT patient_id, identifier FROM patient_identifier WHERE identifier_type = 4 AND voided = 0) AS PatientUniqueID
ON MainTb1.`patient_id` = PatientUniqueID.patient_id
LEFT JOIN
(SELECT DISTINCT patient_id, identifier FROM patient_identifier WHERE identifier_type = 5 AND voided = 0) AS HospNo
ON MainTb1.`patient_id` = HospNo.patient_id
LEFT JOIN
(SELECT  person_id, VALUE AS PhoneNumber FROM `person_attribute` WHERE person_attribute_type_id = 8  GROUP BY person_id) AS PhoneNo
ON MainTb1.`patient_id` = PhoneNo.person_id  
LEFT JOIN
(SELECT a.person_id, CONCAT(a.address1, ' ,', a.address2, ' ,', a.city_village, ' ,', a.state_province) AS 'Address' FROM `person_address` AS a GROUP BY a.person_id ) AS Address
ON MainTb1.`patient_id` = Address.person_id


WHERE MainTb2.encounter_datetime IS NOT NULL AND MainTb1.encounter_datetime BETWEEN DATE_FORMAT(@startdate,'%Y-%m-%d 00:00:00') AND DATE_FORMAT(@enddate,'%Y-%m-%d 23:59:59')
GROUP BY person.`person_id`;