/*Last editted for FY20 Q4*/
SET @ValidVLDate1 := '2021-01-01';
SET @ValidVLDate2 := '2021-12-31';
SET @ValidVLDate3 := '2021-07-01';


#------------------------- Summary for VL Eligibility --------------------------------------------#
SELECT `State`, `LGA`, `Facility`, 
COALESCE(SUM(
                `Current Status (28 Days)` LIKE 'Active')) AS 'Tx_Curr',

COALESCE(SUM(
            (`ART Start Date` <= @ValidVLDate3 )
                AND `Current Status (28 Days)` LIKE 'Active')) AS 'EligibleForVL',
COALESCE(SUM(
            (`ART Start Date` <= @ValidVLDate3 )
                AND `Current Status (28 Days)` LIKE 'Active' AND 
                ((`Date Of Current Viral Load` BETWEEN @ValidVLDate1 AND @ValidVLDate2)))) AS 'VLsampletakenandsenttoPCRLab(b)',
    COALESCE(SUM(
            (`ART Start Date` <= @ValidVLDate3 )
                AND `Current Status (28 Days)` LIKE 'Active' AND `Current Viral Load` LIKE '%_%' AND `Date Of Current Viral Load` BETWEEN  @ValidVLDate1 AND @ValidVLDate2
                )) AS 'VL results received and entered into patients folders/EMR (c )',
 '' AS 'VL Coverage (%) (c/a)*100',
 /*COALESCE(SUM(
            (`ART Start Date` <= @ValidVLDate3)
                AND `Current Status (28 Days)` LIKE 'Active' AND 
                ((`Date Of Current Viral Load` IS NULL OR `Date Of Current Viral Load` NOT BETWEEN @ValidVLDate1 AND @ValidVLDate2) AND (`Last_VL_Sample_Date`BETWEEN @ValidVLDate1 AND @ValidVLDate2) ))) AS 'VL eligible sample collected but awaiting results ',
    COALESCE(SUM(
            (`ARTStartDate` <= @ValidVLDate3 )
                AND `CurrentARTStatus_28Days` LIKE 'Active' AND ((CurrentVL IS NULL OR DateOfCurrentVL < @ValidVLDate1) AND (`Last_VL_Sample_Date` IS NULL OR `Last_VL_Sample_Date` < @ValidVLDate1)))) AS 'VL eligible  samples not yet taken ',*/
    COALESCE(SUM(
            (`ART Start Date` <= @ValidVLDate3 )
                AND `Current Status (28 Days)` LIKE 'Active' AND `Current Viral Load` < 1000 
		AND `Date Of Current Viral Load` BETWEEN @ValidVLDate1 AND @ValidVLDate2)) AS 'No. VL Suppressed'
                FROM
ndr
GROUP BY `Facility` ORDER BY LGA, `Facility`;

SELECT SurgeCommand, LGA, FacilityName, PepID, HospitalNo, Sex, LastPickupDate, `DaysOfARVRefill`, CurrentARTStatus_28Days, CurrentAge,
Surname,FirstName,`Phone_No` FROM `linelist` WHERE
 (ARTStartDate <= @ValidVLDate3 )
                AND `CurrentARTStatus_28Days` LIKE 'Active' AND (CurrentVL IS NULL OR DateOfCurrentVL < @ValidVLDate1);
                
                
                SELECT * FROM `linelist` WHERE ARTStartDate < @ValidVLDate3
                AND `CurrentARTStatus_28Days` LIKE 'Active' AND ((CurrentVL IS NULL OR DateOfCurrentVL < @ValidVLDate1) AND (`Last_VL_Sample_Date` IS NULL OR `Last_VL_Sample_Date` < @ValidVLDate1));