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
-- Table structure for table `tbl_vacunacion`
--

DROP TABLE IF EXISTS `tbl_vacunacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_vacunacion` (
  `id_vacunacion` bigint NOT NULL AUTO_INCREMENT,
  `id_atencion` bigint NOT NULL,
  `id_vacuna` bigint NOT NULL,
  `lote` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `laboratorio` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_aplicacion` date NOT NULL,
  `fecha_proxima_dosis` date DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_vacunacion`),
  UNIQUE KEY `id_atencion` (`id_atencion`),
  KEY `fk_vacunacion_vacuna` (`id_vacuna`),
  KEY `idx_vacunacion_proxima` (`fecha_proxima_dosis`),
  CONSTRAINT `fk_vacunacion_atencion` FOREIGN KEY (`id_atencion`) REFERENCES `tbl_atencion` (`id_atencion`),
  CONSTRAINT `fk_vacunacion_vacuna` FOREIGN KEY (`id_vacuna`) REFERENCES `tbl_vacuna` (`id_vacuna`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_vacunacion`
--

LOCK TABLES `tbl_vacunacion` WRITE;
/*!40000 ALTER TABLE `tbl_vacunacion` DISABLE KEYS */;
INSERT INTO `tbl_vacunacion` VALUES
(1,21,1,'A104B22','MSD Salud Animal','2026-10-11','2027-10-11','Aplicada en región interescapular sin molestia'),
(2,22,11,'ZP84920','Zoetis','2026-10-11','2027-10-11','Gata afebril, se colocó sticker en carnet'),
(3,23,9,'NR45109','MSD Salud Animal','2026-10-11','2027-10-11','Certificado antirrábico N° 00412 entregado'),
(4,24,7,'KC77214','MSD Salud Animal','2026-10-11','2027-10-11','Vía intranasal, toleró bien el procedimiento'),
(5,25,13,'TR30918','MSD Salud Animal','2026-10-12','2027-10-12','Sin reacción local tras 15 minutos de observación'),
(6,26,2,'VG66201','Zoetis','2026-10-12','2027-10-12','Refuerzo anual completado, no bañar por 7 días'),
(7,27,10,'DF91823','Zoetis','2026-10-12','2027-10-12','Vacunación antirrábica sin novedad'),
(8,28,14,'LC55402','Virbac','2026-10-12','2027-10-12','Test previo de FeLV/FIV negativo'),
(9,29,4,'NV22819','MSD Salud Animal','2026-10-13','2027-10-13','Control de peso y temperatura conformes'),
(10,30,9,'NR45110','MSD Salud Animal','2026-10-13','2027-10-13','Certificado antirrábico N° 00415 entregado'),
(11,31,11,'ZP84925','Zoetis','2026-10-13','2027-10-13','Se indicó reposo en casa por hoy'),
(12,32,1,'A104B28','MSD Salud Animal','2026-10-13','2027-10-13','Paciente tranquilo, carnet actualizado'),
(13,33,5,'BI90412','Boehringer Ingelheim','2026-10-14','2027-10-14','Sin dolor a la palpación en zona de aplicación'),
(14,34,8,'EL33109','Elanco','2026-10-14','2027-10-14','Administración oral completada para hospedaje'),
(15,35,16,'RB71044','Boehringer Ingelheim','2026-10-14','2027-10-14','Dosis antirrábica felina anual'),
(16,36,2,'VG66208','Zoetis','2026-10-14','2027-10-14','Refuerzo anual al día'),
(17,37,17,'EU48291','Boehringer Ingelheim','2026-10-15','2027-10-15','Aplicada por vía subcutánea en flanco derecho'),
(18,38,12,'FC19284','Zoetis','2026-10-15','2027-10-15','Inmunización felina anual registrada'),
(19,39,10,'DF91830','Zoetis','2026-10-15','2027-10-15','Certificado oficial sellado y firmado'),
(20,40,3,'VB88312','Virbac','2026-10-15','2027-10-15','Esquema anual completo, buena condición general');
/*!40000 ALTER TABLE `tbl_vacunacion` ENABLE KEYS */;
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
