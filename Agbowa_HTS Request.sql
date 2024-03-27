
 SET @FacilityName :=
(SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'Facility_Name');
SET @DATIMCode :=
(SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code');
SET @SurgeCommand :=
(SELECT
  SurgeCommand
FROM
  CIHP_ListOfFacility
WHERE Datim_Code = (SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code'));
SET @LGA :=
(SELECT
  LGA
FROM
  CIHP_ListOfFacility
WHERE Datim_Code = (SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code'));
SET @State :=
(SELECT
  State
FROM
  CIHP_ListOfFacility
WHERE Datim_Code = (SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code')); SET @FacilityName :=
(SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'Facility_Name');
SET @DATIMCode :=
(SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code');
SET @SurgeCommand :=
(SELECT
  SurgeCommand
FROM
  CIHP_ListOfFacility
WHERE Datim_Code = (SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code'));
SET @LGA :=
(SELECT
  LGA
FROM
  CIHP_ListOfFacility
WHERE Datim_Code = (SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code'));
SET @State :=
(SELECT
  State
FROM
  CIHP_ListOfFacility
WHERE Datim_Code = (SELECT
  `property_value`
FROM
  `global_property`
WHERE `property`= 'facility_datim_code'));
SET @startdate = (@Reporting_Date) - INTERVAL (SELECT DAYOFYEAR(CONCAT(YEAR(@Reporting_Date),'-12-31'))) DAY;
#SET GLOBAL innodb_buffer_pool_size=302653184;
SET @row_number = 0;SET @row_number1 = 0;SET @row_number2 = 0;SET @row_number3 = 0;SET @row_number4 = 0;SET @row_number5 = 0;SET @row_number6 = 0;


SELECT DISTINCT "CIHP" AS "IP",
   @State AS State,
   @SurgeCommand SurgeCommand,
   @LGA LGA,
      (SELECT `address2`  FROM  `location` WHERE `location_id` = 8 LIMIT 1) City,
   @Datim_Code Datim_Code,
   @FacilityName FacilityName,
   CONCAT((SELECT property_value FROM global_property WHERE property = 'facility_datim_code' LIMIT 1),"_",HTS_ClientCode.identifier) Datim_HTS_ClientCode,
   HTS_ClientCode.identifier AS HTS_ClientCode,PEPFAR_Number.identifier AS PEPFAR_Number_IfOnART,BioInfo.birthdate,BioInfo.gender AS Sex,BioInfo.CurrentAge,BioInfo.given_name,BioInfo.family_name,
PhoneNo.PhoneNumber,ClientCode.encounter_datetime AS VisitDate,
CASE WHEN HIVScreeningTestDate.HIVScreeningTestDate=ClientCode.encounter_datetime THEN 'Test Date Validated'
WHEN HIVScreeningTestDate.HIVScreeningTestDate!=ClientCode.encounter_datetime THEN 'Visit & Test Date Mismatch'
WHEN HIVScreeningTestDate.HIVScreeningTestDate IS NULL THEN 'Test Date Not Specified'
ELSE 'What Happened?'
END AS 'Test_VisitDate_Validation',

CASE WHEN KindOfHTS.KindOfHTS ='Provider-initiated HIV testing and counseling' THEN 'PITC'
WHEN KindOfHTS.KindOfHTS ='Voluntary counseling and testing center' THEN 'VCT' 
WHEN KindOfHTS.KindOfHTS IS NULL THEN 'Kind of HTS not Specified' ELSE KindOfHTS.KindOfHTS END AS KindOfHTS,

/*--------------------------------------------------------------------------------------------------------------------------------------------------*/
ass.Previously_tested_HIV_negative,
ass.Client_Pregnant,
ass.Client_informed_about_HIV_transmission_routes,
ass.Client_informed_about_risk_factors_for_HIV_transmission,
ass.Client_informed_on_preventing_HIV_transmission_methods,
ass.Client_informed_about_possible_test_results,
ass.Informed_consent_for_HIV_testing_given,
ass.Ever_had_sexual_intercourse,
ass.Blood_transfusion,
ass.Unprotected_sexual_intercourse,
ass.Unprotected_sex_with_regular_partner_in_the_last_3months,
ass.STI_in_last_3_months,
ass.More_than_1_sex_partner_during_Last_3_months,

/*--------------------------------------------------------------------------------------------------------------------------------------------------*/

CASE WHEN setting.setting ='Observation ward' THEN 'Ward'
WHEN setting.setting ='Outpatient department' THEN 'OPD' 
WHEN setting.setting ='Voluntary counseling and testing program' THEN 'VCT'
WHEN setting.setting ='Tuberculosis Visit' THEN 'TB'
WHEN setting.setting ='Sexually transmitted infection program/clinic' THEN 'STI'
WHEN setting.setting ='FAMILY PLANNING' THEN 'FP'
WHEN setting.setting ='PMTCT Setting' THEN 'PMTC'
WHEN setting.setting IS NULL THEN 'Setting not Specified' ELSE setting.setting END AS setting,
FirstTimeVisit.FirstTimeVisit,
CASE WHEN TypeOfSession.TypeOfSession ='Individual' THEN TypeOfSession.TypeOfSession
WHEN TypeOfSession.TypeOfSession ='Previously self tested' THEN TypeOfSession.TypeOfSession
WHEN TypeOfSession.TypeOfSession ='Couple testing' THEN TypeOfSession.TypeOfSession
ELSE 'Type_Of_Session_Not_Specified' END AS TypeOfSession,
ReferredFrom.ReferredFrom,MaritalStatus.MaritalStatus,FromIndex.FromIndex,
CASE WHEN FromIndex.FromIndex='Yes' AND IndexClientID.IndexClientID IS NULL THEN
'Specify Index ClientID' WHEN (FromIndex.FromIndex IS NULL OR FromIndex.FromIndex ='No') AND IndexClientID.IndexClientID IS NOT NULL THEN
'Find out if Client is not from specified Index ID'
WHEN FromIndex.FromIndex='Yes' AND (IndexClientID.IndexClientID IS NOT NULL OR IndexClientID.IndexClientID!='') AND (IndexClientID.IndexClientName IS NOT NULL OR IndexClientID.IndexClientName!='')  THEN
'IndexClientID_Matches_UniqueID_ON_NMRS'
WHEN FromIndex.FromIndex='Yes' AND (IndexClientID.IndexClientID IS NOT NULL OR IndexClientID.IndexClientID!='') AND (IndexClientID.IndexClientName IS NULL OR IndexClientID.IndexClientName ='')  THEN
'IndexClientID_Does_Not_Match_UniqueID_ON_NMRS'
 WHEN FromIndex.FromIndex='No' AND (IndexClientID.IndexClientID IS NULL OR IndexClientID.IndexClientID='') THEN
'Validated' ELSE FromIndex.FromIndex END AS 'IndexClientID_Validation',
IndexClientID.IndexClientID,IndexType.IndexType,IndexClientID.IndexClientName,
HIVScreeningTest.HIVScreeningTest,HIVScreeningTestDate.HIVScreeningTestDate AS HIVScreeningTestDate,DATE_FORMAT(HIVConfirmatoryTest.HIVConfirmatoryTest,'%Y-%m-%d') AS HIVConfirmatoryTest,HIVConfirmatoryTestDate.HIVConfirmatoryTestDate,HIV_FinalResult.HIV_FinalResult,
Opt_Out_of_RTRI.Opt_Out_of_RTRI AS 'Opt_Out_of_RTRI?',
CASE WHEN (Opt_Out_of_RTRI.Opt_Out_of_RTRI IS NULL OR Opt_Out_of_RTRI.Opt_Out_of_RTRI = '') AND (HIVRecencyTestName.HIVRecencyTestName IS NOT NULL OR HIVRecencyTestName.HIVRecencyTestName <> '') THEN 'Specify_Consent_For_RecencyTest'
WHEN (Opt_Out_of_RTRI.Opt_Out_of_RTRI IS NOT NULL OR Opt_Out_of_RTRI.Opt_Out_of_RTRI <> '') AND (HIVRecencyTestName.HIVRecencyTestName IS NOT NULL OR HIVRecencyTestName.HIVRecencyTestName <> '') THEN 'Validated' ELSE NULL END AS 'Opt_Out_of_RTRI_Validation',
HIVRecencyTestName.HIVRecencyTestName,
VerifyRecencyNumber.VerifyRecencyNumber,ControlLine.ControlLine,VerificationLine.VerificationLine,LongTermLine.LongTermLine,DATE_FORMAT(HIVRecencyTestDate.HIVRecencyTestDate ,'%Y-%m-%d') AS HIVRecencyTestDate,RecencyInterpretation.RecencyInterpretation,ViralLoadRequest.ViralLoadRequest,DATE_FORMAT(VLSampleCollectionDate.VLSampleCollectionDate,'%Y-%m-%d') AS VLSampleCollectionDate,
PCR_LabNo.PCR_LabNo,SampleType.SampleType,PCR_Laboratory.PCR_Laboratory,HIV_ViralLoad.HIV_ViralLoad,FinalHIVRecencyResult.FinalHIVRecencyResult,NoOfPatnerElicited.NoOfPatnerElicited,
PartnerFullName_1.PartnerFullName_1,IndexRelation_Gender_1.IndexRelation_Gender_1,IndexType_Partner1.IndexType_Partner1,
PartnerFullName_2.PartnerFullName_2,IndexRelation_Gender_2.IndexRelation_Gender_2,IndexType_Partner2.IndexType_Partner2,
PartnerFullName_3.PartnerFullName_3,IndexRelation_Gender_3.IndexRelation_Gender_3,IndexType_Partner3.IndexType_Partner3,
PartnerFullName_4.PartnerFullName_4,IndexRelation_Gender_4.IndexRelation_Gender_4,IndexType_Partner4.IndexType_Partner4,
PartnerFullName_5.PartnerFullName_5,IndexRelation_Gender_5.IndexRelation_Gender_5,IndexType_Partner5.IndexType_Partner5,
PartnerFullName_6.PartnerFullName_6,IndexRelation_Gender_6.IndexRelation_Gender_6,IndexType_Partner6.IndexType_Partner6
FROM

(SELECT  @row_number :=CASE WHEN @patient_id = patient_id THEN @row_number + 1 ELSE 1 END AS num, @patient_id := patient_id AS patient_id,
encounter_datetime,encounter_id ,voided FROM encounter WHERE (encounter_type = 2 OR encounter_type = 20) AND encounter_datetime <= @Reporting_Date AND voided = 0
ORDER BY patient_id ASC, encounter_datetime DESC ) AS ClientCode
 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 166136 THEN ConceptName(value_coded) END  AS KindOfHTS
FROM obs WHERE concept_id = 166136) AS KindOfHTS
ON ClientCode.patient_id = KindOfHTS.person_id AND ClientCode.encounter_id = KindOfHTS.encounter_id AND ClientCode.num = 1

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 165839 THEN ConceptName(value_coded) END  AS setting
FROM obs WHERE concept_id = 165839 ) AS setting
ON ClientCode.patient_id = setting.person_id AND ClientCode.encounter_id = setting.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 165790 THEN ConceptName(value_coded) END AS FirstTimeVisit
FROM obs WHERE concept_id = 165790 ) AS FirstTimeVisit
ON ClientCode.patient_id = FirstTimeVisit.person_id AND ClientCode.encounter_id = FirstTimeVisit.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 165793 THEN ConceptName(value_coded) END AS TypeOfSession
FROM obs WHERE concept_id = 165793 ) AS TypeOfSession
ON ClientCode.patient_id = TypeOfSession.person_id AND ClientCode.encounter_id = TypeOfSession.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 165480 THEN ConceptName(value_coded) END AS ReferredFrom
FROM obs WHERE concept_id = 165480 ) AS ReferredFrom
ON ClientCode.patient_id = ReferredFrom.person_id AND ClientCode.encounter_id = ReferredFrom.encounter_id AND ClientCode.num = 1

LEFT JOIN
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 1054 THEN ConceptName(value_coded) END AS MaritalStatus
FROM obs WHERE concept_id = 1054 ) AS MaritalStatus
ON ClientCode.patient_id = MaritalStatus.person_id AND ClientCode.encounter_id = MaritalStatus.encounter_id AND ClientCode.num = 1
  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 165794 THEN ConceptName(value_coded) END AS FromIndex
FROM obs WHERE concept_id = 165794 ) AS FromIndex
ON ClientCode.patient_id = FromIndex.person_id AND ClientCode.encounter_id = FromIndex.encounter_id AND ClientCode.num = 1
LEFT JOIN

 (
SELECT IndexClientName.person_id,IndexClientName.obs_datetime,IndexClientName.encounter_id, IndexClientName.IndexClientID,identifier.IndexClientName
 FROM
(SELECT person_id,obs_datetime,encounter_id, value_text  AS IndexClientID
FROM obs WHERE concept_id = 165859) AS IndexClientName
INNER JOIN
(SELECT A.patient_id, A.identifier,CONCAT(B.given_name,' ', B.family_name) AS IndexClientName FROM  patient_identifier AS A, person_name AS B
WHERE  A.patient_id = B.`person_id` AND a.identifier_type = 4) AS identifier
ON IndexClientName.IndexClientID = identifier.identifier) AS IndexClientID
ON ClientCode.patient_id = IndexClientID.person_id AND ClientCode.encounter_id = IndexClientID.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 165798 THEN ConceptName(value_coded) END AS IndexType
FROM obs WHERE concept_id = 165798 AND voided=0) AS IndexType
ON ClientCode.patient_id = IndexType.person_id AND ClientCode.encounter_id = IndexType.encounter_id AND ClientCode.num = 1


  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 165840 THEN ConceptName(value_coded) END AS HIVScreeningTest
FROM obs WHERE concept_id = 165840 AND voided=0) AS HIVScreeningTest
ON ClientCode.patient_id = HIVScreeningTest.person_id AND ClientCode.encounter_id = HIVScreeningTest.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,value_datetime AS  HIVScreeningTestDate
FROM obs WHERE concept_id = 165844 AND voided=0) AS HIVScreeningTestDate
ON ClientCode.patient_id = HIVScreeningTestDate.person_id AND ClientCode.encounter_id = HIVScreeningTestDate.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 165841 THEN ConceptName(value_coded) END AS HIVConfirmatoryTest
FROM obs WHERE concept_id = 165841 AND voided=0) AS HIVConfirmatoryTest
ON ClientCode.patient_id = HIVConfirmatoryTest.person_id AND ClientCode.encounter_id = HIVConfirmatoryTest.encounter_id AND ClientCode.num = 1

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,value_datetime AS  HIVConfirmatoryTestDate
FROM obs WHERE concept_id = 165845 AND voided=0) AS HIVConfirmatoryTestDate
ON ClientCode.patient_id = HIVConfirmatoryTestDate.person_id AND ClientCode.encounter_id = HIVConfirmatoryTestDate.encounter_id AND ClientCode.num = 1

  LEFT JOIN        

      
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 165843 THEN ConceptName(value_coded) END AS HIV_FinalResult
FROM obs WHERE concept_id = 165843 AND voided=0) AS HIV_FinalResult
ON ClientCode.patient_id = HIV_FinalResult.person_id AND ClientCode.encounter_id = HIV_FinalResult.encounter_id AND ClientCode.num = 1
  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id, CASE WHEN concept_id = 165805 THEN ConceptName(value_coded) END AS 'Opt_Out_of_RTRI'
FROM obs WHERE concept_id = 165805 AND voided=0) AS Opt_Out_of_RTRI
ON ClientCode.patient_id = Opt_Out_of_RTRI.person_id AND ClientCode.encounter_id = Opt_Out_of_RTRI.encounter_id AND ClientCode.num = 1
  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 166216 THEN ConceptName(value_coded) WHEN concept_id = 165849 THEN value_text ELSE NULL  END AS  HIVRecencyTestName
FROM obs WHERE concept_id IN (166216 ,165849) AND voided =0) AS HIVRecencyTestName
ON ClientCode.patient_id = HIVRecencyTestName.person_id /*AND ClientCode.encounter_id = HIVRecencyTestName.encounter_id AND ClientCode.num = 1*/

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,value_text AS  VerifyRecencyNumber
FROM obs WHERE concept_id = 166210 AND voided =0 ) AS VerifyRecencyNumber
ON ClientCode.patient_id = VerifyRecencyNumber.person_id /*AND ClientCode.encounter_id = VerifyRecencyNumber.encounter_id AND ClientCode.num = 1*/

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 166212 THEN ConceptName(value_coded) END AS  ControlLine
FROM obs WHERE concept_id = 166212 AND voided =0 ) AS ControlLine
ON ClientCode.patient_id = ControlLine.person_id /*AND ClientCode.encounter_id = ControlLine.encounter_id AND ClientCode.num = 1*/

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 166243 THEN ConceptName(value_coded) END  AS  VerificationLine
FROM obs WHERE concept_id = 166243 AND voided =0 ) AS VerificationLine
ON ClientCode.patient_id = VerificationLine.person_id /*AND ClientCode.encounter_id = VerificationLine.encounter_id AND ClientCode.num = 1*/

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id = 166211 THEN ConceptName(value_coded) END AS  LongTermLine
FROM obs WHERE concept_id = 166211 AND voided =0 ) AS LongTermLine
ON ClientCode.patient_id = LongTermLine.person_id /*AND ClientCode.encounter_id = LongTermLine.encounter_id AND ClientCode.num = 1*/


  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,value_datetime AS  HIVRecencyTestDate
FROM obs WHERE concept_id = 165850 AND voided =0 ) AS HIVRecencyTestDate
ON ClientCode.patient_id = HIVRecencyTestDate.person_id /*AND ClientCode.encounter_id = HIVRecencyTestDate.encounter_id AND ClientCode.num = 1*/

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,CASE WHEN concept_id IN (166213,165853) THEN ConceptName(value_coded) END AS  RecencyInterpretation
FROM obs WHERE concept_id IN (166213,165853) AND voided =0) AS RecencyInterpretation
ON ClientCode.patient_id = RecencyInterpretation.person_id /*AND ClientCode.encounter_id = RecencyInterpretation.encounter_id AND ClientCode.num = 1*/

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,
 CASE WHEN concept_id = 166244 THEN ConceptName(value_coded) END AS  ViralLoadRequest
FROM obs o LEFT JOIN encounter e ON e.encounter_id=o.encounter_id WHERE concept_id = 166244 AND o.voided =0 AND (encounter_type = 2 OR encounter_type = 20 OR encounter_type = 39)) AS ViralLoadRequest
ON ClientCode.patient_id = ViralLoadRequest.person_id /*AND ClientCode.encounter_id = ViralLoadRequest.encounter_id AND ClientCode.num = 1*/

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,value_datetime AS  VLSampleCollectionDate
FROM obs o LEFT JOIN encounter e ON e.encounter_id=o.encounter_id WHERE concept_id = 159951 AND o.voided =0 AND (encounter_type = 2 OR encounter_type = 20 OR encounter_type = 39)) AS VLSampleCollectionDate
ON ClientCode.patient_id = VLSampleCollectionDate.person_id /*AND ClientCode.encounter_id = VLSampleCollectionDate.encounter_id AND ClientCode.num = 1*/

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,value_text AS  PCR_LabNo
FROM obs o LEFT JOIN encounter e ON e.encounter_id=o.encounter_id WHERE concept_id = 165715 AND o.voided =0 AND (encounter_type = 2 OR encounter_type = 20 OR encounter_type = 39)) AS PCR_LabNo
ON ClientCode.patient_id = PCR_LabNo.person_id /*AND ClientCode.encounter_id = PCR_LabNo.encounter_id AND ClientCode.num = 1*/

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,CASE WHEN concept_id = 162476 THEN ConceptName(value_coded) END AS  SampleType
FROM obs o LEFT JOIN encounter e ON e.encounter_id=o.encounter_id WHERE concept_id = 162476 AND o.voided =0 AND (encounter_type = 2 OR encounter_type = 20 OR encounter_type = 39)) AS SampleType
ON ClientCode.patient_id = SampleType.person_id /*AND ClientCode.encounter_id = SampleType.encounter_id AND ClientCode.num = 1*/

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,CASE WHEN concept_id = 166233 THEN ConceptName(value_coded) END AS 'PCR_Laboratory'
FROM obs o LEFT JOIN encounter e ON e.encounter_id=o.encounter_id WHERE concept_id = 166233 AND o.voided =0 AND (encounter_type = 2 OR encounter_type = 20 OR encounter_type = 39)) AS PCR_Laboratory
ON ClientCode.patient_id = PCR_Laboratory.person_id /*AND ClientCode.encounter_id = PCR_Laboratory.encounter_id AND ClientCode.num = 1*/


  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,value_numeric AS  HIV_ViralLoad
FROM obs o LEFT JOIN encounter e ON e.encounter_id=o.encounter_id WHERE concept_id = 856 AND o.voided =0 AND (encounter_type = 2 OR encounter_type = 20 OR encounter_type = 39)) AS HIV_ViralLoad
ON ClientCode.patient_id = HIV_ViralLoad.person_id /*AND ClientCode.encounter_id = HIV_ViralLoad.encounter_id AND ClientCode.num = 1*/

  LEFT JOIN        
        
 (SELECT person_id,obs_datetime,CASE WHEN concept_id = 165856 THEN ConceptName(value_coded) END AS FinalHIVRecencyResult
FROM obs o LEFT JOIN encounter e ON e.encounter_id=o.encounter_id WHERE concept_id = 165856 AND o.voided =0 AND (encounter_type = 2 OR encounter_type = 20 OR encounter_type = 39)) AS FinalHIVRecencyResult
ON ClientCode.patient_id = FinalHIVRecencyResult.person_id /*AND ClientCode.encounter_id = FinalHIVRecencyResult.encounter_id AND ClientCode.num = 1*/
LEFT JOIN
(

SELECT person_id,COUNT(obs_id) AS NoOfPatnerElicited,  obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858
GROUP BY person_id,encounter_id) AS NoOfPatnerElicited
ON ClientCode.patient_id = NoOfPatnerElicited.person_id AND ClientCode.num = 1

-- ============================================================================
 -- Partner Elicitation for Partner One
 -- =====================================
LEFT JOIN

 
 ( SELECT PatnerElicitation.person_id,PatnerElicitation.obs_datetime,PatnerElicitation.encounter_id ,PatnerElicitation.obs_id
 FROM 
 ( 
   SELECT DISTINCT @row_number1 :=CASE WHEN @person_id = Tb2.person_id THEN @row_number1 + 1 ELSE 1 END AS num, @person_id := Tb2.person_id AS person_id,
  Tb2.obs_datetime,Tb2.encounter_id ,Tb2.obs_id FROM     
 (SELECT person_id, obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858
) AS Tb2
 ORDER BY Tb2.person_id,Tb2.obs_id ASC
 ) AS PatnerElicitation WHERE PatnerElicitation.num = 1 ) AS PatnerElicitation1
 ON ClientCode.patient_id = PatnerElicitation1.person_id AND ClientCode.encounter_id = PatnerElicitation1.encounter_id AND ClientCode.num = 1
 LEFT JOIN
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165857 THEN ConceptName(value_coded) END AS IndexRelation_Gender_1
FROM obs WHERE concept_id = 165857 ) AS IndexRelation_Gender_1
ON PatnerElicitation1.person_id = IndexRelation_Gender_1.person_id AND PatnerElicitation1.encounter_id = IndexRelation_Gender_1.encounter_id AND PatnerElicitation1.obs_id = IndexRelation_Gender_1.obs_group_id

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165798 THEN ConceptName(value_coded) END AS IndexType_Partner1
FROM obs WHERE concept_id = 165798 ) AS IndexType_Partner1
ON PatnerElicitation1.person_id = IndexType_Partner1.person_id AND PatnerElicitation1.encounter_id = IndexType_Partner1.encounter_id AND PatnerElicitation1.obs_id = IndexType_Partner1.obs_group_id

 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id, value_text AS PartnerFullName_1
FROM obs WHERE concept_id = 161135 ) AS PartnerFullName_1
ON PatnerElicitation1.person_id = PartnerFullName_1.person_id AND PatnerElicitation1.encounter_id = PartnerFullName_1.encounter_id AND PatnerElicitation1.obs_id = PartnerFullName_1.obs_group_id
    
-- ============================================================================
 -- Partner Elicitation for Partner Two
 -- =====================================
LEFT JOIN

 ( SELECT PatnerElicitation.person_id,PatnerElicitation.obs_datetime,PatnerElicitation.encounter_id ,PatnerElicitation.obs_id
 FROM 
 ( 
   SELECT DISTINCT @row_number2 :=CASE WHEN @person_id = Tb2.person_id THEN @row_number2 + 1 ELSE 1 END AS num, @person_id := Tb2.person_id AS person_id,
  Tb2.obs_datetime,Tb2.encounter_id ,Tb2.obs_id FROM     
 (SELECT person_id, obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858
) AS Tb2
 ORDER BY Tb2.person_id,Tb2.obs_id ASC
 ) AS PatnerElicitation WHERE PatnerElicitation.num = 2 ) AS PatnerElicitation2
 ON ClientCode.patient_id = PatnerElicitation2.person_id AND ClientCode.encounter_id = PatnerElicitation2.encounter_id AND ClientCode.num = 1
 LEFT JOIN
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165857 THEN ConceptName(value_coded) END AS IndexRelation_Gender_2
FROM obs WHERE concept_id = 165857 ) AS IndexRelation_Gender_2
ON PatnerElicitation2.person_id = IndexRelation_Gender_2.person_id AND PatnerElicitation2.encounter_id = IndexRelation_Gender_2.encounter_id AND PatnerElicitation2.obs_id = IndexRelation_Gender_2.obs_group_id

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165798 THEN ConceptName(value_coded) END AS IndexType_Partner2
FROM obs WHERE concept_id = 165798 ) AS IndexType_Partner2
ON PatnerElicitation2.person_id = IndexType_Partner2.person_id AND PatnerElicitation2.encounter_id = IndexType_Partner2.encounter_id AND PatnerElicitation2.obs_id = IndexType_Partner2.obs_group_id

 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id, value_text AS PartnerFullName_2
FROM obs WHERE concept_id = 161135 ) AS PartnerFullName_2
ON PatnerElicitation2.person_id = PartnerFullName_2.person_id AND PatnerElicitation2.encounter_id = PartnerFullName_2.encounter_id AND PatnerElicitation2.obs_id = PartnerFullName_2.obs_group_id
   

-- ============================================================================
 -- Partner Elicitation for Partner Three
 -- =====================================
LEFT JOIN

  ( SELECT PatnerElicitation.person_id,PatnerElicitation.obs_datetime,PatnerElicitation.encounter_id ,PatnerElicitation.obs_id
 FROM 
 ( 
   SELECT DISTINCT @row_number3 :=CASE WHEN @person_id = Tb2.person_id THEN @row_number3 + 1 ELSE 1 END AS num, @person_id := Tb2.person_id AS person_id,
  Tb2.obs_datetime,Tb2.encounter_id ,Tb2.obs_id FROM     
 (SELECT person_id, obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858
) AS Tb2
 ORDER BY Tb2.person_id,Tb2.obs_id ASC
 ) AS PatnerElicitation WHERE PatnerElicitation.num = 3 ) AS PatnerElicitation3
 ON ClientCode.patient_id = PatnerElicitation3.person_id AND ClientCode.encounter_id = PatnerElicitation3.encounter_id AND ClientCode.num = 1
 LEFT JOIN
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165857 THEN ConceptName(value_coded) END AS IndexRelation_Gender_3
FROM obs WHERE concept_id = 165857 ) AS IndexRelation_Gender_3
ON PatnerElicitation3.person_id = IndexRelation_Gender_3.person_id AND PatnerElicitation3.encounter_id = IndexRelation_Gender_3.encounter_id AND PatnerElicitation3.obs_id = IndexRelation_Gender_3.obs_group_id

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165798 THEN ConceptName(value_coded) END AS IndexType_Partner3
FROM obs WHERE concept_id = 165798 ) AS IndexType_Partner3
ON PatnerElicitation3.person_id = IndexType_Partner3.person_id AND PatnerElicitation3.encounter_id = IndexType_Partner3.encounter_id AND PatnerElicitation3.obs_id = IndexType_Partner3.obs_group_id

 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id, value_text AS PartnerFullName_3
FROM obs WHERE concept_id = 161135 ) AS PartnerFullName_3
ON PatnerElicitation3.person_id = PartnerFullName_3.person_id AND PatnerElicitation3.encounter_id = PartnerFullName_3.encounter_id AND PatnerElicitation3.obs_id = PartnerFullName_3.obs_group_id
 
-- ============================================================================
 -- Partner Elicitation for Partner Four
 -- =====================================
LEFT JOIN

  ( SELECT PatnerElicitation.person_id,PatnerElicitation.obs_datetime,PatnerElicitation.encounter_id ,PatnerElicitation.obs_id
 FROM 
 ( 
   SELECT DISTINCT @row_number4 :=CASE WHEN @person_id = Tb2.person_id THEN @row_number4 + 1 ELSE 1 END AS num, @person_id := Tb2.person_id AS person_id,
  Tb2.obs_datetime,Tb2.encounter_id ,Tb2.obs_id FROM     
 (SELECT person_id, obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858
) AS Tb2
 ORDER BY Tb2.person_id,Tb2.obs_id ASC
 ) AS PatnerElicitation WHERE PatnerElicitation.num = 4) AS PatnerElicitation4
 ON ClientCode.patient_id = PatnerElicitation4.person_id AND ClientCode.encounter_id = PatnerElicitation4.encounter_id AND ClientCode.num = 1
 LEFT JOIN
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165857 THEN ConceptName(value_coded) END AS IndexRelation_Gender_4
FROM obs WHERE concept_id = 165857 ) AS IndexRelation_Gender_4
ON PatnerElicitation4.person_id = IndexRelation_Gender_4.person_id AND PatnerElicitation4.encounter_id = IndexRelation_Gender_4.encounter_id AND PatnerElicitation4.obs_id = IndexRelation_Gender_4.obs_group_id

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165798 THEN ConceptName(value_coded) END AS IndexType_Partner4
FROM obs WHERE concept_id = 165798 ) AS IndexType_Partner4
ON PatnerElicitation4.person_id = IndexType_Partner4.person_id AND PatnerElicitation4.encounter_id = IndexType_Partner4.encounter_id AND PatnerElicitation4.obs_id = IndexType_Partner4.obs_group_id

 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id, value_text AS PartnerFullName_4
FROM obs WHERE concept_id = 161135 ) AS PartnerFullName_4
ON PatnerElicitation4.person_id = PartnerFullName_4.person_id AND PatnerElicitation4.encounter_id = PartnerFullName_4.encounter_id AND PatnerElicitation4.obs_id = PartnerFullName_4.obs_group_id


-- ============================================================================
 -- Partner Elicitation for Partner Five
 -- =====================================
LEFT JOIN

  ( SELECT PatnerElicitation.person_id,PatnerElicitation.obs_datetime,PatnerElicitation.encounter_id ,PatnerElicitation.obs_id
 FROM 
 ( 
   SELECT DISTINCT @row_number5 :=CASE WHEN @person_id = Tb2.person_id THEN @row_number5 + 1 ELSE 1 END AS num, @person_id := Tb2.person_id AS person_id,
  Tb2.obs_datetime,Tb2.encounter_id ,Tb2.obs_id FROM     
 (SELECT person_id, obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858
) AS Tb2
 ORDER BY Tb2.person_id,Tb2.obs_id ASC
 ) AS PatnerElicitation WHERE PatnerElicitation.num = 5) AS PatnerElicitation5
 ON ClientCode.patient_id = PatnerElicitation5.person_id AND ClientCode.encounter_id = PatnerElicitation5.encounter_id AND ClientCode.num = 1
 LEFT JOIN
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165857 THEN ConceptName(value_coded) END AS IndexRelation_Gender_5
FROM obs WHERE concept_id = 165857 ) AS IndexRelation_Gender_5
ON PatnerElicitation5.person_id = IndexRelation_Gender_5.person_id AND PatnerElicitation5.encounter_id = IndexRelation_Gender_5.encounter_id AND PatnerElicitation5.obs_id = IndexRelation_Gender_5.obs_group_id

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165798 THEN ConceptName(value_coded) END AS IndexType_Partner5
FROM obs WHERE concept_id = 165798 ) AS IndexType_Partner5
ON PatnerElicitation5.person_id = IndexType_Partner5.person_id AND PatnerElicitation5.encounter_id = IndexType_Partner5.encounter_id AND PatnerElicitation5.obs_id = IndexType_Partner5.obs_group_id

 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id, value_text AS PartnerFullName_5
FROM obs WHERE concept_id = 161135 ) AS PartnerFullName_5
ON PatnerElicitation5.person_id = PartnerFullName_5.person_id AND PatnerElicitation5.encounter_id = PartnerFullName_5.encounter_id AND PatnerElicitation5.obs_id = PartnerFullName_5.obs_group_id
 

-- ============================================================================
 -- Partner Elicitation for Partner six
 -- =====================================
LEFT JOIN


 (
 SELECT PatnerElicitation.person_id,PatnerElicitation.obs_datetime,PatnerElicitation.encounter_id ,PatnerElicitation.obs_id
 FROM 
 ( 
   SELECT DISTINCT @row_number6 :=CASE WHEN @person_id = Tb2.person_id THEN @row_number6 + 1 ELSE 1 END AS num, @person_id := Tb2.person_id AS person_id,
  Tb2.obs_datetime,Tb2.encounter_id ,Tb2.obs_id FROM     
 (SELECT person_id, obs_datetime,encounter_id, obs_id
FROM obs WHERE concept_id = 165858
) AS Tb2
 ORDER BY Tb2.person_id,Tb2.obs_id ASC
 ) AS PatnerElicitation WHERE PatnerElicitation.num = 6) AS PatnerElicitation6
 ON ClientCode.patient_id = PatnerElicitation6.person_id AND ClientCode.encounter_id = PatnerElicitation6.encounter_id AND ClientCode.num = 1
 LEFT JOIN
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165857 THEN ConceptName(value_coded) END AS IndexRelation_Gender_6
FROM obs WHERE concept_id = 165857 ) AS IndexRelation_Gender_6
ON PatnerElicitation6.person_id = IndexRelation_Gender_6.person_id AND PatnerElicitation6.encounter_id = IndexRelation_Gender_6.encounter_id AND PatnerElicitation6.obs_id = IndexRelation_Gender_6.obs_group_id

LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id ,CASE WHEN concept_id = 165798 THEN ConceptName(value_coded) END AS IndexType_Partner6
FROM obs WHERE concept_id = 165798 ) AS IndexType_Partner6
ON PatnerElicitation6.person_id = IndexType_Partner6.person_id AND PatnerElicitation6.encounter_id = IndexType_Partner6.encounter_id AND PatnerElicitation6.obs_id = IndexType_Partner6.obs_group_id

 LEFT JOIN        
        
 (SELECT person_id,obs_datetime,encounter_id,obs_group_id, value_text AS PartnerFullName_6
FROM obs WHERE concept_id = 161135 ) AS PartnerFullName_6
ON PatnerElicitation6.person_id = PartnerFullName_6.person_id AND PatnerElicitation6.encounter_id = PartnerFullName_6.encounter_id AND PatnerElicitation6.obs_id = PartnerFullName_6.obs_group_id
  
-- Knowledge Assesment & HIV Risk Assesment by Shola

LEFT JOIN
(SELECT e.`patient_id`,MAX(e.`encounter_id`), ConceptName(a.`value_coded`)Previously_tested_HIV_negative,
CASE 
WHEN b.`value_coded`= 2 THEN "No"
WHEN b.`value_coded`= 1 THEN "Yes"
ELSE NULL END AS Client_Pregnant, #b.`value_coded` Client_Pregnant,
ConceptName(c.`value_coded`)Client_informed_about_HIV_transmission_routes, ConceptName(d.`value_coded`)Client_informed_about_risk_factors_for_HIV_transmission,
ConceptName(f.`value_coded`)Client_informed_on_preventing_HIV_transmission_methods, ConceptName(g.`value_coded`)Client_informed_about_possible_test_results,
ConceptName(h.`value_coded`)Informed_consent_for_HIV_testing_given, ConceptName(i.`value_coded`)Ever_had_sexual_intercourse,
CASE
WHEN j.`value_coded` = 2 THEN "No"
WHEN j.`value_coded` = 1 THEN "Yes"
ELSE NULL END AS Blood_transfusion, ConceptName(k.`value_coded`)Unprotected_sexual_intercourse,
ConceptName(l.`value_coded`)Unprotected_sex_with_regular_partner_in_the_last_3months, ConceptName(m.`value_coded`)STI_in_last_3_months,
ConceptName(n.`value_coded`)More_than_1_sex_partner_during_Last_3_months
FROM `encounter` e 
#Previously tested HIV negative
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 165799 AND voided=0) a ON e.`encounter_id`=a.`encounter_id`
#Client Pregnant
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 1434 AND voided=0) b ON e.`encounter_id`=b.`encounter_id`
#Client_informed_about_HIV_transmission_routes
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 165801 AND voided=0) c ON e.`encounter_id`=c.`encounter_id`
#Client informed about risk factors for HIV transmission	
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 165802 AND voided=0) d ON e.`encounter_id`=d.`encounter_id`
#Client informed on preventing HIV transmission methods (165804)
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 165804 AND voided=0) f ON e.`encounter_id`=f.`encounter_id`
#Client informed about possible test results (165884)
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 165884 AND voided=0) g ON e.`encounter_id`=g.`encounter_id`
# Informed consent for HIV testing given (165805)
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 165805 AND voided=0) h ON e.`encounter_id`=h.`encounter_id`
# Ever had sexual intercourse (165800)
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 165800 AND voided=0) i ON e.`encounter_id`=i.`encounter_id`
# Blood transfusion (1063)
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 1063 AND voided=0) j ON e.`encounter_id`=j.`encounter_id`
# Unprotected sexual intercourse (159218)
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 159218 AND voided=0) k ON e.`encounter_id`=k.`encounter_id`
#Unprotected sex WITH regular partner IN the LAST 3months (165803)
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 165803 AND voided=0) l ON e.`encounter_id`=l.`encounter_id`
#STI IN LAST 3 months (164809)
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 164809 AND voided=0) m ON e.`encounter_id`=m.`encounter_id`
#More THAN 1 sex partner during LAST 3 months (165806)
LEFT JOIN (SELECT `encounter_id`, `value_coded` FROM `obs` o WHERE `concept_id`= 165806 AND voided=0) n ON e.`encounter_id`=n.`encounter_id`
WHERE e.`encounter_type` = 20 AND e.`form_id` = 10 AND e.voided=0 GROUP BY e.`patient_id`)ass ON ClientCode.patient_id  = ass.patient_id
 
 
-- =======================================
-- Join Biographical Information
-- =================================
LEFT JOIN
(SELECT DISTINCT A.person_id,A.birthdate, CASE WHEN A.gender = 'F' THEN 'Female' WHEN A.gender = 'M' THEN 'Male' ELSE NULL END AS Gender,FLOOR(DATEDIFF(CURDATE(), A.birthdate) / 365.25) AS CurrentAge,B.given_name, B.family_name FROM person AS A
JOIN person_name AS B USING (person_id) WHERE A.voided = 0 AND B.voided = 0 ) AS BioInfo
ON ClientCode.patient_id  = BioInfo.person_id

LEFT JOIN
(SELECT DISTINCT person_id, VALUE AS PhoneNumber FROM `person_attribute` WHERE person_attribute_type_id = 8 AND voided = 0) AS PhoneNo
ON ClientCode.patient_id = PhoneNo.person_id

LEFT JOIN 
(SELECT patient_id, identifier FROM patient_identifier WHERE identifier_type = 4)AS PEPFAR_Number
ON ClientCode.patient_id = PEPFAR_Number.patient_id
LEFT JOIN 
(SELECT patient_id, identifier FROM patient_identifier WHERE identifier_type = 8)AS HTS_ClientCode
ON ClientCode.patient_id = HTS_ClientCode.patient_id
WHERE ClientCode.num = 1 AND ClientCode.voided = 0
GROUP BY ClientCode.patient_id;