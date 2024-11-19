-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: trafficviolation
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS driver;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE driver (
  DriverID int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  LicenseNumber varchar(50) DEFAULT NULL,
  Address varchar(255) DEFAULT NULL,
  PhoneNumber varchar(15) DEFAULT NULL,
  PRIMARY KEY (DriverID),
  UNIQUE KEY LicenseNumber (LicenseNumber)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver`
--

LOCK TABLES driver WRITE;
/*!40000 ALTER TABLE driver DISABLE KEYS */;
INSERT INTO driver VALUES (1,'James Bond','1039066','23456-00100','0714346678'),(2,'Joseph Kamau','1067893','45568-00100','0783456783'),(3,'Kevin','1027345','54567-00100','0765765790'),(4,'Matthew Smith','1057656','23767-00100','0760765456');
/*!40000 ALTER TABLE driver ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER AfterDriverDelete AFTER DELETE ON driver FOR EACH ROW BEGIN
    INSERT INTO DriverDeletionLog (DeletedDriverID, DeletionDate)
    VALUES (OLD.DriverID, NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `driverdeletionlog`
--

DROP TABLE IF EXISTS driverdeletionlog;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE driverdeletionlog (
  LogID int NOT NULL AUTO_INCREMENT,
  DeletedDriverID int DEFAULT NULL,
  DeletionDate datetime DEFAULT NULL,
  PRIMARY KEY (LogID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driverdeletionlog`
--

LOCK TABLES driverdeletionlog WRITE;
/*!40000 ALTER TABLE driverdeletionlog DISABLE KEYS */;
/*!40000 ALTER TABLE driverdeletionlog ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `officer`
--

DROP TABLE IF EXISTS officer;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE officer (
  OfficerID int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  BadgeNumber varchar(50) DEFAULT NULL,
  Station varchar(100) DEFAULT NULL,
  PRIMARY KEY (OfficerID),
  UNIQUE KEY BadgeNumber (BadgeNumber)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `officer`
--

LOCK TABLES officer WRITE;
/*!40000 ALTER TABLE officer DISABLE KEYS */;
INSERT INTO officer VALUES (1,'Officer Joe Mwangi','B12345','Langata Station'),(2,'Officer Jimmy Omondi','B45432','CBD Station'),(3,'Officer Omar Zidan','D56562','Kilimani Station'),(4,'Officer Elvis Kamau','C45678','Kangemi Station');
/*!40000 ALTER TABLE officer ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trafficviolation`
--

DROP TABLE IF EXISTS trafficviolation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE trafficviolation (
  ViolationID int NOT NULL,
  ViolationType varchar(100) DEFAULT NULL,
  ViolationDate date DEFAULT NULL,
  Location varchar(255) DEFAULT NULL,
  FineAmount decimal(10,2) DEFAULT NULL,
  DriverID int DEFAULT NULL,
  VehicleID int DEFAULT NULL,
  PRIMARY KEY (ViolationID),
  KEY DriverID (DriverID),
  KEY VehicleID (VehicleID),
  CONSTRAINT trafficviolation_ibfk_1 FOREIGN KEY (DriverID) REFERENCES driver (DriverID),
  CONSTRAINT trafficviolation_ibfk_2 FOREIGN KEY (VehicleID) REFERENCES vehicle (VehicleID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trafficviolation`
--

LOCK TABLES trafficviolation WRITE;
/*!40000 ALTER TABLE trafficviolation DISABLE KEYS */;
INSERT INTO trafficviolation VALUES (1,'Running a Red Light','2024-10-20','Kenyatta Ave',250.00,1,1),(2,'Speeding','2024-09-11','Kenyatta Ave',500.00,1,2),(3,'Speeding','2024-09-01','Langata Road',100.00,2,3),(4,'Careless overtaking','2024-11-17','Ngong Road',100.00,3,4),(5,'Break Checking','2024-08-07','Likoni Road',200.00,4,5);
/*!40000 ALTER TABLE trafficviolation ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER AfterTrafficViolationInsert AFTER INSERT ON trafficviolation FOR EACH ROW BEGIN
    DECLARE p_OfficerID INT DEFAULT 1;  
    INSERT INTO ViolationReport (ViolationID, OfficerID, IssuedDate)
    VALUES (NEW.ViolationID, p_OfficerID, NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER BeforeViolationUpdate BEFORE UPDATE ON trafficviolation FOR EACH ROW BEGIN
    IF NEW.ViolationType != OLD.ViolationType THEN
        SET NEW.FineAmount = CASE
            WHEN NEW.ViolationType = 'Speeding' THEN 100.00
            WHEN NEW.ViolationType = 'Running a Red Light' THEN 200.00
            ELSE 50.00
        END;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS vehicle;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE vehicle (
  VehicleID int NOT NULL,
  LicensePlate varchar(15) DEFAULT NULL,
  Make varchar(50) DEFAULT NULL,
  Model varchar(50) DEFAULT NULL,
  `Year` int DEFAULT NULL,
  OwnerID int DEFAULT NULL,
  PRIMARY KEY (VehicleID),
  UNIQUE KEY LicensePlate (LicensePlate),
  KEY OwnerID (OwnerID),
  CONSTRAINT vehicle_ibfk_1 FOREIGN KEY (OwnerID) REFERENCES driver (DriverID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES vehicle WRITE;
/*!40000 ALTER TABLE vehicle DISABLE KEYS */;
INSERT INTO vehicle VALUES (1,'KCF123','Toyota','Corolla',2019,1),(2,'KBT047','Subaru','Forester',2016,1),(3,'KDA567','Mazda','Demio',2019,2),(4,'KBW043','Subaru','Impreza',2017,3),(5,'KCR896','Toyota','Mark X',2019,4);
/*!40000 ALTER TABLE vehicle ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `violationreport`
--

DROP TABLE IF EXISTS violationreport;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE violationreport (
  ReportID int NOT NULL,
  ViolationID int DEFAULT NULL,
  OfficerID int DEFAULT NULL,
  IssuedDate date DEFAULT NULL,
  PRIMARY KEY (ReportID),
  KEY ViolationID (ViolationID),
  KEY OfficerID (OfficerID),
  CONSTRAINT violationreport_ibfk_1 FOREIGN KEY (ViolationID) REFERENCES trafficviolation (ViolationID),
  CONSTRAINT violationreport_ibfk_2 FOREIGN KEY (OfficerID) REFERENCES officer (OfficerID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `violationreport`
--

LOCK TABLES violationreport WRITE;
/*!40000 ALTER TABLE violationreport DISABLE KEYS */;
INSERT INTO violationreport VALUES (1,1,1,'2024-10-20'),(2,2,1,'2024-09-12'),(3,3,2,'2024-09-02'),(4,4,3,'2024-11-17'),(5,5,4,'2024-08-08');
/*!40000 ALTER TABLE violationreport ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'trafficviolation'
--
/*!50003 DROP PROCEDURE IF EXISTS AddDriver */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE AddDriver(
    IN p_Name VARCHAR(100),
    IN p_LicenseNumber VARCHAR(50),
    IN p_Address VARCHAR(255),
    IN p_PhoneNumber VARCHAR(15)
)
BEGIN
    INSERT INTO Driver (Name, LicenseNumber, Address, PhoneNumber)
    VALUES (p_Name, p_LicenseNumber, p_Address, p_PhoneNumber);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS GetDriverViolations */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE GetDriverViolations(
    IN p_DriverID INT
)
BEGIN
    SELECT * FROM TrafficViolation
    WHERE DriverID = p_DriverID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS UpdateViolationFine */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=root@localhost PROCEDURE UpdateViolationFine(
    IN p_ViolationID INT,
    IN p_FineAmount DECIMAL(10, 2)
)
BEGIN
    UPDATE TrafficViolation
    SET FineAmount = p_FineAmount
    WHERE ViolationID = p_ViolationID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-19 11:02:03
