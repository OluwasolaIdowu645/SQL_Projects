/*Last editted for FY20 Q4*/
SET @ValidVLDate1 := '2021-01-01';
SET @ValidVLDate2 := '2021-12-31';
SET @ValidVLDate3 := '2021-07-01';


#------------------------- Summary for VL Eligibility --------------------------------------------#
SELECT `SurgeCommand`, `LGA`, FacilityName, 
COALESCE(SUM(
                `CurrentARTStatus_28Days` LIKE 'Active')) AS 'Tx_Curr',

COALESCE(SUM(
            (`ARTStartDate` <= @ValidVLDate3 )
                AND `CurrentARTStatus_28Days` LIKE 'Active')) AS 'EligibleForVL',
COALESCE(SUM(
            (`ARTStartDate` <= @ValidVLDate3 )
                AND `CurrentARTStatus_28Days` LIKE 'Active' AND 
                ((`DateOfCurrentVL` BETWEEN @ValidVLDate1 AND @ValidVLDate2) OR (`Last_VL_Sample_Date`BETWEEN @ValidVLDate1 AND @ValidVLDate2) ))) AS 'VLsampletakenandsenttoPCRLab(b)',
    COALESCE(SUM(
            (`ARTStartDate` <= @ValidVLDate3 )
                AND `CurrentARTStatus_28Days` LIKE 'Active' AND CurrentVL LIKE '%_%' AND `DateOfCurrentVL` BETWEEN  @ValidVLDate1 AND @ValidVLDate2
                )) AS 'VL results received and entered into patients folders/EMR (c )',
 '' AS 'VL Coverage (%) (c/a)*100',
 COALESCE(SUM(
            (`ARTStartDate` <= @ValidVLDate3)
                AND `CurrentARTStatus_28Days` LIKE 'Active' AND 
                ((`DateOfCurrentVL` IS NULL OR DateOfCurrentVL NOT BETWEEN @ValidVLDate1 AND @ValidVLDate2) AND (`Last_VL_Sample_Date`BETWEEN @ValidVLDate1 AND @ValidVLDate2) ))) AS 'VL eligible sample collected but awaiting results ',
    COALESCE(SUM(
            (`ARTStartDate` <= @ValidVLDate3 )
                AND `CurrentARTStatus_28Days` LIKE 'Active' AND ((CurrentVL IS NULL OR DateOfCurrentVL < @ValidVLDate1) AND (`Last_VL_Sample_Date` IS NULL OR `Last_VL_Sample_Date` < @ValidVLDate1)))) AS 'VL eligible  samples not yet taken ',
    COALESCE(SUM(
            (ARTStartDate <= @ValidVLDate3 )
                AND `CurrentARTStatus_28Days` LIKE 'Active' AND CurrentVL < 1000 
		AND DateOfCurrentVL BETWEEN @ValidVLDate1 AND @ValidVLDate2)) AS 'No. VL Suppressed'
                FROM
linelist
GROUP BY FacilityName ORDER BY LGA, FacilityName;

SELECT SurgeCommand, LGA, FacilityName, PepID, HospitalNo, Sex, LastPickupDate, `DaysOfARVRefill`, CurrentARTStatus_28Days, CurrentAge,
Surname,FirstName,`Phone_No` FROM `linelist` WHERE
 (ARTStartDate <= @ValidVLDate3 )
                AND `CurrentARTStatus_28Days` LIKE 'Active' AND (CurrentVL IS NULL OR DateOfCurrentVL < @ValidVLDate1);
                
                
                SELECT * FROM `linelist` WHERE ARTStartDate < @ValidVLDate3
                AND `CurrentARTStatus_28Days` LIKE 'Active' AND ((CurrentVL IS NULL OR DateOfCurrentVL < @ValidVLDate1) AND (`Last_VL_Sample_Date` IS NULL OR `Last_VL_Sample_Date` < @ValidVLDate1));