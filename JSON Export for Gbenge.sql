-- in production remove limit 10 and add contrian to pick eligibele for recapture and cature only. and posible target exact location 

USE openmrs;
SET SESSION group_concat_max_len = 10000;
SELECT DISTINCT
    pn.family_name AS familyName,
    pn.given_name AS givenName,
    pn.middle_name AS middleName,
    p.gender AS gender,
    p.birthdate AS birthdate,
	IFNULL(
		(SELECT VALUE FROM person_attribute AS pt WHERE pt.person_attribute_type_id = 8 AND pt.person_id = pi.patient_id LIMIT 1),
        0
	) AS telephone,
	-- (select value from person_attribute as pt where pt.person_attribute_type_id = 8 and pt.person_id = pi.patient_id limit 1) as telephone,
    pa.address1 AS address1,
    pa.address2 AS address2,
    pa.city_village AS cityVillage,
    pa.state_province AS state,
    pa.postal_code AS postal_code,
    p.uuid AS patientUuid,
    (SELECT identifier FROM patient_identifier AS pi2 WHERE pi2.identifier_type = 4 AND pi2.patient_id = pi.patient_id LIMIT 1) AS art_number,
    (SELECT identifier FROM patient_identifier AS pi2 WHERE pi2.identifier_type = 5 AND pi2.patient_id = pi.patient_id LIMIT 1) AS hospital_number,
    pi.patient_id,
    (SELECT CONCAT('[',
    GROUP_CONCAT( 
    -- JSON name must corespond to PatientBiometricContract  class SerializedName
     CONCAT(
     '{patient_Id:"', bio.patient_id, 
     '", imageWidth:"', bio.imageWidth, 
     '", imageHeight:"', bio.imageHeight, 
     '", imageDPI:"', bio.imageDPI, 
     '", imageQuality:"', bio.imageQuality, 
     '", fingerPositions:"', bio.fingerPosition, 
     '", serialNumber:"', bio.serialNumber, 
     '", model:"', bio.model, 
     '", manufacturer:"', bio.manufacturer, 
     '", template:"', LEFT(IFNULL(bio.new_template,bio.template),1068), 
    -- ,'creator',bio.creator,
     -- 'date_created',bio.date_created
    -- ,'template',IFNULL(bio.new_template,bio.template) 
     '"}')
      
     SEPARATOR ', '   )  , ']')  AS b  FROM biometricinfo bio  WHERE bio.patient_Id = "100" group by bio.patient_id
        ) AS base_pbs 
    
FROM patient_identifier AS PI
RIGHT JOIN person AS p ON p.person_id = pi.patient_id
RIGHT JOIN person_name AS pn ON pn.person_id = pi.patient_id
RIGHT JOIN person_address AS pa ON pa.person_id = pi.patient_id
RIGHT JOIN visit AS vt ON p.person_id = vt.patient_id
WHERE (identifier_type=4 OR identifier_type=5) AND p.voided = 0 AND pi.patient_id  IN(SELECT bo.patient_id FROM biometricinfo AS bo)
ORDER BY vt.date_created DESC LIMIT 10;

 