SET @Reporting_Date='2022-02-23';
CALL `CIHP_LineList`;



DELIMITER $$
DROP FUNCTION IF EXISTS `Operatn_Type`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `Operatn_Type`(Op_id INT) 
RETURNS TEXT CHARSET latin1 READS SQL DATA DETERMINISTIC BEGIN RETURN 
(SELECT NAME FROM  `inv_stock_operation_type`  WHERE `stock_operation_type_id` = Op_id 
LIMIT 1);END$$ 
DELIMITER ;

DELIMITER $$
DROP FUNCTION IF EXISTS `Item_Name`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `Item_Name`(ItemId INT) 
RETURNS TEXT CHARSET latin1 READS SQL DATA DETERMINISTIC BEGIN RETURN 
(SELECT NAME FROM  `inv_item`  WHERE `item_id` = ItemId 
LIMIT 1);END$$ 
DELIMITER ;

DELIMITER $$
DROP FUNCTION IF EXISTS `Depart_name`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `Depart_name`(DepartmentId INT) 
RETURNS TEXT CHARSET latin1 READS SQL DATA DETERMINISTIC BEGIN RETURN 
(SELECT NAME FROM  `inv_department`  WHERE `department_id` = DepartmentId 
LIMIT 1);END$$ 
DELIMITER ;

DELIMITER $$
DROP FUNCTION IF EXISTS `Institution_Namez` $$
CREATE DEFINER=`root`@`localhost` FUNCTION `Depart_name`(DepartmentId INT) 
RETURNS TEXT CHARSET latin1 READS SQL DATA DETERMINISTIC BEGIN RETURN 
(SELECT NAME FROM  `inv_institution`  WHERE `department_id` = DepartmentId 
LIMIT 1);END$$ 
DELIMITER ;
 
 
 
 SELECT `consumption_id`, `item_id`,Item_Name(`item_id`)Item, Depart_name(department_id)Department, `quantity`, `consumption_date`, `batch_number` FROM `inv_consumption`;
 
 
  SELECT `stock_operation_id`,`operation_type_id`,Operatn_Type(`operation_type_id`),`status`,`name`,`description`,`operation_number`,`source_id`,`destination_id`, 
  `creator`,`date_created`,`changed_by`,`date_changed`,`retired`,`retired_by`,`date_retired`,`retire_reason`,`uuid`,
  `operation_date`,`institution_id`,`patient_id`,`department_id`,Depart_name(department_id),`operation_order`,`cancel_reason`,`adjustment_kind`,`disposed_type`,
  `commodity_source`,`commodity_type`,`data_system` FROM `inv_stock_operation`;