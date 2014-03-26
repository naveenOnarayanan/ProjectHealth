SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Hospital_Main` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Hospital_Main` ;

-- -----------------------------------------------------
-- Table `Hospital_Main`.`Drugs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital_Main`.`Drugs` (
  `DIN` INT NOT NULL,
  `TradeName` VARCHAR(128) DEFAULT "",
  `Description` TEXT NULL,
  PRIMARY KEY (`DIN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital_Main`.`Patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital_Main`.`Patients` (
  `UserID` VARCHAR(16) NOT NULL,
  `FirstName` VARCHAR(32) DEFAULT "",
  `LastName` VARCHAR(64) DEFAULT "",
  `Address` VARCHAR(64) DEFAULT "",
  `City` VARCHAR(32) DEFAULT "",
  `Province` VARCHAR(2) NULL,
  `Country` VARCHAR(32) NULL,
  `PostalCode` VARCHAR(7) DEFAULT "",
  `PhoneNumber` VARCHAR(12) DEFAULT "",
  `Email` VARCHAR(256) DEFAULT "",
  `HealthCardNumber` VARCHAR(15) DEFAULT "",
  `SIN` VARCHAR(11) DEFAULT "",
  `Visits` INT(16) DEFAULT 0,
  `DefaultDoctorID` VARCHAR(16) NULL,
  `HealthStatus` TEXT NULL,
  `PrimaryContactNo` VARCHAR(12) DEFAULT "",
  `Transfered` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital_Main`.`Prescriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital_Main`.`Prescriptions` (
  `VisitID` INT NOT NULL,
  `DIN` INT NOT NULL,
  `Quantity` INT NULL,
  `Refills` INT(8) NULL,
  `Dosage` TEXT NULL,
  `Expiry` DATETIME NULL,
  PRIMARY KEY (`VisitID`, `DIN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital_Main`.`ScheduledOperations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital_Main`.`ScheduledOperations` (
  `VisitID` INT NOT NULL,
  `OperationDateTime` DATETIME NOT NULL,
  `OperationName` VARCHAR(64) DEFAULT "",
  `DoctorID` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`VisitID`, `OperationDateTime`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital_Main`.`Operations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital_Main`.`Operations` (
  `Name` VARCHAR(64) NOT NULL,
  `Description` TEXT NULL,
  `EstTime` TIME NULL,
  `ReqJobTitle` VARCHAR(64) DEFAULT "",
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital_Main`.`Visitation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital_Main`.`Visitation` (
  `RecordID` INT NOT NULL AUTO_INCREMENT,
  `VisitID` INT NULL,
  `PatientID` VARCHAR(16) NOT NULL,
  `DoctorID` VARCHAR(16) NOT NULL,
  `Symptoms` TEXT NULL,
  `Diagnosis` TEXT NULL,
  `Type` VARCHAR(32) NULL DEFAULT "",
  `Length` TIME NULL,
  `Comments` TEXT NULL,
  `DateTime` DATETIME NULL,
  `Timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `ApptComplete` TINYINT(1) NULL DEFAULT 0,
  `Cancelled` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`RecordID`))
ENGINE = InnoDB;

DROP TRIGGER IF EXISTS BeforeInsertVisit;
delimiter $$
CREATE TRIGGER BeforeInsertVisit BEFORE INSERT ON `Hospital_Main`.`Visitation`
FOR EACH ROW BEGIN
	IF (NEW.VisitID IS NULL) THEN
		SET NEW.VisitID = (SELECT MAX(VisitID) FROM `Hospital_Main`.`Visitation`) + 1;
		IF (NEW.VisitID IS NULL) THEN
			SET NEW.VisitID = 1;
		END IF;
		IF (NEW.Diagnosis IS NULL OR NEW.Comments = "null") THEN
			SET NEW.Diagnosis = "";
		END IF;
		IF (NEW.Type IS NULL OR NEW.Type = "null") THEN
			SET NEW.Type = "";
		END IF;
		IF (NEW.Comments IS NULL OR NEW.Comments = "null") THEN
			SET NEW.Comments = "";
		END IF;
		IF (NEW.ApptComplete = TRUE) THEN
			UPDATE `Hospital_Main`.`Patients`
			SET Visits = Visits + 1
			WHERE NEW.PatientID = `Hospital_Main`.`Patients`.UserID;
		END IF;
	ELSE
		IF (NEW.ApptComplete = TRUE AND (SELECT MAX(V1.ApptComplete) 
								FROM Visitation AS V1 
								WHERE V1.VisitID = NEW.VisitID
								AND V1.Timestamp = (SELECT MAX(V2.Timestamp) 
													FROM Visitation V2 
													WHERE V2.VisitID = NEW.VisitID)) = 0) THEN
			UPDATE `Hospital_Main`.`Patients`
			SET Visits = Visits + 1
			WHERE NEW.PatientID = `Hospital_Main`.`Patients`.UserID;
		END IF;
	END IF;
	
END;$$

-- -----------------------------------------------------
-- Table `Hospital_Main`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital_Main`.`Staff` (
  `UserID` VARCHAR(16) NOT NULL,
  `FirstName` VARCHAR(32) NULL DEFAULT "",
  `LastName` VARCHAR(64) NULL DEFAULT "",
  `ManagingDoctorID` VARCHAR(16) NULL,
  `JobTitle` VARCHAR(64) NULL,
  `CurrentlyEmployed` TINYINT(1) NOT NULL DEFAULT TRUE,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital_Main`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital_Main`.`Users` (
  `UserID` VARCHAR(16) NOT NULL,
  `Password` VARCHAR(64) NOT NULL,
  `Role` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`userID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital_Main`.`DoctorPatientPerm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital_Main`.`DoctorPatientPerm` (
  `PatientID` VARCHAR(16) NOT NULL,
  `DoctorID` VARCHAR(16) NOT NULL,
  `SecDoctorID` VARCHAR(16) NOT NULL,
  `Expiry` DATE NULL,
  PRIMARY KEY (`PatientID`,`DoctorID`,`SecDoctorID`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Hospital_Main`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital_Main`.`Country` (
  `Code` VARCHAR(3) NOT NULL,
  `Name` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`Code`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Hospital_Main`.`Province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital_Main`.`Province` (
  `Code` VARCHAR(2) NOT NULL,
  `Name` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`Code`))
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
