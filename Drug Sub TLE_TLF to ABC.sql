  SELECT 'Lagos', `SurgeCommand`, LGA, FacilityName, 
COALESCE(SUM(`FY21Q4_CurrentARTReg` IN ('ABC-3TC-EFV', 'ABC-3TC-DTG') AND 
  (`FY20Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q4_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV')))) AS 'Total_Substitution(ABC)',
  COALESCE(SUM(`CurrentARTStatus_28Days`='Active' AND `FY21Q4_CurrentARTReg` IN ('ABC-3TC-EFV', 'ABC-3TC-DTG') AND 
  (`FY20Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q4_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV')))) Active,
  COALESCE(SUM(`CurrentARTStatus_28Days`='In-Active' AND `FY21Q4_CurrentARTReg` IN ('ABC-3TC-EFV', 'ABC-3TC-DTG') AND 
  (`FY20Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q4_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV')))) 'In-Active',
  COALESCE(SUM(`CurrentARTStatus_28Days`='Dead' AND `FY21Q4_CurrentARTReg` IN ('ABC-3TC-EFV', 'ABC-3TC-DTG') AND 
  (`FY20Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q4_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV')))) Dead,
  COALESCE(SUM(`CurrentARTStatus_28Days`='Transferred Out' AND `FY21Q4_CurrentARTReg` IN ('ABC-3TC-EFV', 'ABC-3TC-DTG') AND 
  (`FY20Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q4_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV')))) 'Transferred Out',
  COALESCE(SUM(`CurrentARTStatus_28Days`='Stopped' AND `FY21Q4_CurrentARTReg` IN ('ABC-3TC-EFV', 'ABC-3TC-DTG') AND 
  (`FY20Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q4_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV')))) Stopped
FROM Kidney_Drug_Sub 
GROUP BY FacilityName ORDER BY LGA, FacilityName;

SELECT
  `IP`,
  `State`,
  `SurgeCommand`,
  `LGA`,
  `FacilityName`,
  `Pepid_datim`,
  `patient_id`,
  `Pepid`,
  `HospitalNo`,
  `Sex`,
  `AgeAtStartofART`,
  `AgeAtStart_InMonth`,
  `ARTStartDate`,
  `DaysOfARVRefill`,
  `RegLineAtStart`,
  `ARTRegAtStart`,
  `CurrentRegLine`,
  `FY20Q1_LastPickupDate`,
  `FY20Q1_CurrentARTReg`,
  `FY20Q2_LastPickupDate`,
  `FY20Q2_CurrentARTReg`,
  `FY20Q3_LastPickupDate`,
  `FY20Q3_CurrentARTReg`,
  `FY20Q4_LastPickupDate`,
  `FY20Q4_CurrentARTReg`,
  `FY21Q1_LastPickupDate`,
  `FY21Q1_CurrentARTReg`,
  `FY21Q2_LastPickupDate`,
  `FY21Q2_CurrentARTReg`,
  `FY21Q3_LastPickupDate`,
  `FY21Q3_CurrentARTReg`,
  `FY21Q4_LastPickupDate`,
  `FY21Q4_CurrentARTReg`, `CurrentARTStatus_28Days`
  

FROM
  `report`.`Kidney_Drug_Sub`
WHERE `FY21Q4_CurrentARTReg` IN ('ABC-3TC-EFV', 'ABC-3TC-DTG') AND 

  (`FY20Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY20Q4_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q1_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q2_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV') OR
  `FY21Q3_CurrentARTReg` IN ('TDF-3TC-DTG', 'TDF-3TC-EFV'));
  

