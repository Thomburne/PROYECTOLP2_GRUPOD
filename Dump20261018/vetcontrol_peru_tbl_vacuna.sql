-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: vetcontrol_peru
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `tbl_vacuna`
--

DROP TABLE IF EXISTS `tbl_vacuna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_vacuna` (
  `id_vacuna` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `especie_objetivo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_vacuna`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_vacuna`
--

LOCK TABLES `tbl_vacuna` WRITE;
/*!40000 ALTER TABLE `tbl_vacuna` DISABLE KEYS */;
INSERT INTO `tbl_vacuna` VALUES
(1,'Nobivac DHPPi + L (Séxtuple Canina)','Perro','Vacuna combinada contra distemper, adenovirus tipo 2, parvovirus, parainfluenza y leptospira',1),
(2,'Vanguard Plus 5/CV-L (Séxtuple)','Perro','Inmunización contra moquillo, hepatitis, parvovirus, parainfluenza, coronavirus y leptospira',1),
(3,'Canigen SHA2PPi/LR','Perro','Vacuna polivalente más rabia para refuerzo anual en perros adultos',1),
(4,'Nobivac DHPPi (Quíntuple Canina)','Perro','Vacuna liofilizada contra distemper, hepatitis infecciosa, parvovirosis y parainfluenza',1),
(5,'Recombitek C6/CV','Perro','Vacuna recombinante contra distemper, adenovirus, parvovirus, coronavirus y leptospira',1),
(6,'Nobivac Puppy DP','Perro','Primera vacuna para cachorros contra parvovirus canino y distemper',1),
(7,'Nobivac KC (Tos de las perreras)','Perro','Vacuna intranasal contra Bordetella bronchiseptica y virus de parainfluenza canina',1),
(8,'Bronchi-Shield Oral','Perro','Vacuna de administración oral para prevención de traqueobronquitis infecciosa canina',1),
(9,'Nobivac Rabies','Perro','Vacuna inactivada contra el virus de la rabia de larga duración',1),
(10,'Defensor 3 (Antirrábica)','Perro','Vacuna antirrábica inactivada para caninos y felinos a partir de los 3 meses',1),
(11,'Felocell 3 (Triple Felina)','Gato','Vacuna contra rinotraqueítis viral felina, calicivirus y panleucopenia',1),
(12,'Felocell 4 (Cuádruple Felina)','Gato','Protección contra rinotraqueítis, calicivirus, panleucopenia y Chlamydia psittaci',1),
(13,'Nobivac Tricat Trio','Gato','Vacuna viva atenuada contra calicivirus, herpesvirus tipo 1 y panleucopenia felina',1),
(14,'Leucogen (Leucemia Felina)','Gato','Vacuna recombinante purificada contra el virus de la leucemia felina (FeLV)',1),
(15,'Purevax FeLV','Gato','Vacuna vectorizada sin adyuvante contra la leucemia viral felina',1),
(16,'Rabisin (Antirrábica Felina/Canina)','Gato','Vacuna antirrábica inactivada con glicoproteína altamente purificada',1),
(17,'Eurican DHPPI2-L','Perro','Vacuna multivalente canina para esquema primario y refuerzo anual',1),
(18,'Nobivac Lepto','Perro','Bacterina inactivada bivalente contra Leptospira canicola e icterohaemorrhagiae',1),
(19,'Parvigen','Perro','Vacuna monovalente de alto título contra parvovirus canino',1),
(20,'Fel-O-Vax Lv-K IV','Gato','Vacuna inactivada combinada contra complejo respiratorio felino y leucemia',1);
/*!40000 ALTER TABLE `tbl_vacuna` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-16 07:45:12
