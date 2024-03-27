SELECT FacilityName, LGA,`SurgeCommand`,
COALESCE (ROUND(SUM(
            `ARTStartDate` BETWEEN '2020-11-01' AND '2021-04-30')/6),0) AS 'Average Tx_New IN LAST 6 months',

    /*COALESCE(SUM(
            `ARTStartDate` BETWEEN '2020-05-01' AND '2021-04-30')) AS 'Average Tx_New IN LAST 6 months',*/
    COALESCE(SUM(
            `CurrentARTStatus_28Days` ='Active')) AS 'Tx_Curr', 
    COALESCE(SUM(
            `CurrentARTStatus_28Days` ='Active' AND `Biometrics_Captured` = 'Yes')) AS 'PBS among Tx_Curr',
             (COALESCE(SUM(
            `CurrentARTStatus_28Days` ='Active' AND `Biometrics_Captured` = 'Yes'))/
	     COALESCE(SUM(
            `CurrentARTStatus_28Days` ='Active'))) AS '% PBS coverage',
    '' AS 'Number of functional scanners in use',   
    '' AS 'Name PBS Focal Person'                                                                                         
 FROM `linelist` GROUP BY `FacilityName` ORDER BY LGA, `FacilityName`;
 
 
 
 Average Tx_New IN LAST 6 months	Tx_Curr	PBS among Tx_Curr	% PBS coverage	'Number of functional scanners in use	
 Name PBS Focal Person	Comment (number of non-functional scanners, other challenges etc)
