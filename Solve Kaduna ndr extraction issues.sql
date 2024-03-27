SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `ndr_message_logs`;

CREATE TABLE `ndr_message_logs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `exportId` INT(11) NOT NULL,
  `message` TEXT,
  `batchNumber` TEXT NOT NULL,
  `patientIdentifier` TEXT,
  `fileName` TEXT,
  `dateCreated` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `export_log` (`exportId`),
  CONSTRAINT `export_log` FOREIGN KEY (`exportId`) REFERENCES `nigeriaemr_ndr_batch_export` (`nigeriaemr_ndr_batch_export_id`)
) ENGINE=INNODB AUTO_INCREMENT=3784 DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `nigeriaemr_ndr_batch_export`;

CREATE TABLE `nigeriaemr_ndr_batch_export` (
  `nigeriaemr_ndr_batch_export_id` INT(11) NOT NULL AUTO_INCREMENT,
  `owner` INT(11) DEFAULT NULL,
  `total_number_of_patients` INT(11) DEFAULT NULL,
  `total_number_of_patients_processed` INT(11) DEFAULT '0',
  `date_started` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_export_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(250) DEFAULT NULL,
  `name` VARCHAR(100) DEFAULT NULL,
  `path` VARCHAR(250) DEFAULT NULL,
  `report_folder` VARCHAR(255) DEFAULT NULL,
  `context_path` VARCHAR(255) DEFAULT NULL,
  `date_ended` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `voided` BIT(1) DEFAULT NULL,
  `error_path` VARCHAR(250) DEFAULT NULL,
  `error_list` VARCHAR(250) DEFAULT NULL,
  `automatic` BIT(1) DEFAULT NULL,
  `ndr_batch_ids` LONGTEXT,
  `errorLogsPulled` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`nigeriaemr_ndr_batch_export_id`)
) ENGINE=INNODB AUTO_INCREMENT=663 DEFAULT CHARSET=latin1;
SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=1;
SET FOREIGN_KEY_CHECKS=1;

