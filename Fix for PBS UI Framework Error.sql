DROP TABLE IF EXISTS `biometricverificationinfo`;

CREATE TABLE `biometricverificationinfo` (
  `biometricInfo_Id` INT(11) NOT NULL AUTO_INCREMENT,
  `patient_Id` INT(11) NOT NULL,
  `template` TEXT,
  `imageWidth` INT(11) DEFAULT NULL,
  `imageHeight` INT(11) DEFAULT NULL,
  `imageDPI` INT(11) DEFAULT NULL,
  `imageQuality` INT(11) DEFAULT NULL,
  `fingerPosition` VARCHAR(50) DEFAULT NULL,
  `serialNumber` VARCHAR(255) DEFAULT NULL,
  `model` VARCHAR(255) DEFAULT NULL,
  `manufacturer` VARCHAR(255) DEFAULT NULL,
  `creator` INT(11) DEFAULT NULL,
  `date_created` DATETIME DEFAULT NULL,
  `new_template` LONGBLOB,
  `encoded_template` TEXT,
  `hashed` TEXT,
  `recapture_count` INT(11) DEFAULT '1',
  PRIMARY KEY (`biometricInfo_Id`)
) ENGINE=INNODB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
