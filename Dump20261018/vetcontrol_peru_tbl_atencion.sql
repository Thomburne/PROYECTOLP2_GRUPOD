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
-- Table structure for table `tbl_atencion`
--

DROP TABLE IF EXISTS `tbl_atencion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_atencion` (
  `id_atencion` bigint NOT NULL AUTO_INCREMENT,
  `id_cita` bigint DEFAULT NULL,
  `id_mascota` bigint NOT NULL,
  `id_servicio` bigint NOT NULL,
  `id_usuario` bigint DEFAULT NULL,
  `fecha_atencion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `descripcion` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio_cobrado` decimal(10,2) NOT NULL,
  `estado` enum('EN_PROCESO','FINALIZADA','CANCELADA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EN_PROCESO',
  PRIMARY KEY (`id_atencion`),
  UNIQUE KEY `id_cita` (`id_cita`),
  KEY `fk_atencion_mascota` (`id_mascota`),
  KEY `fk_atencion_servicio` (`id_servicio`),
  KEY `fk_atencion_usuario` (`id_usuario`),
  KEY `idx_atencion_fecha` (`fecha_atencion`),
  CONSTRAINT `fk_atencion_cita` FOREIGN KEY (`id_cita`) REFERENCES `tbl_cita` (`id_cita`),
  CONSTRAINT `fk_atencion_mascota` FOREIGN KEY (`id_mascota`) REFERENCES `tbl_mascota` (`id_mascota`),
  CONSTRAINT `fk_atencion_servicio` FOREIGN KEY (`id_servicio`) REFERENCES `tbl_servicio` (`id_servicio`),
  CONSTRAINT `fk_atencion_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_usuario` (`id_usuario`),
  CONSTRAINT `ck_atencion_precio` CHECK ((`precio_cobrado` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_atencion`
--

LOCK TABLES `tbl_atencion` WRITE;
/*!40000 ALTER TABLE `tbl_atencion` DISABLE KEYS */;
INSERT INTO `tbl_atencion` VALUES
(1,1,1,6,2,'2026-10-01 09:30:00','Se realizó baño con shampoo hipoalergénico de avena, corte estilo schnauzer, limpieza de oídos y corte de uñas.',65.00,'FINALIZADA'),
(2,2,2,8,3,'2026-10-01 11:00:00','Baño felino con espuma tibia, secado con toalla y secadora silenciosa, recorte de puntas de garras.',45.00,'FINALIZADA'),
(3,3,3,4,4,'2026-10-02 09:00:00','Baño completo para raza grande, limpieza de conducto auditivo y cepillado general.',50.00,'FINALIZADA'),
(4,4,4,6,5,'2026-10-02 10:30:00','Baño completo y recorte higiénico despejando zona periocular y almohadillas plantares.',65.00,'FINALIZADA'),
(5,5,5,20,6,'2026-10-03 09:30:00','Evaluación física general: T° 38.5°C, FC 128 lpm, mucosas rosadas. Condición corporal 3/5.',40.00,'FINALIZADA'),
(6,6,6,5,7,'2026-10-03 11:30:00','Baño terapéutico con clorhexidina al 4% dejando actuar 10 minutos en pliegues cutáneos.',55.00,'FINALIZADA'),
(7,7,7,6,8,'2026-10-04 09:00:00','Desenredado de orejas, baño con acondicionador y corte estilo osito con tijera.',65.00,'FINALIZADA'),
(8,8,8,20,9,'2026-10-04 10:45:00','Auscultación pulmonar limpia, T° 38.6°C. Rinitis leve estacional, se indicó limpieza nasal con suero fisiológico.',40.00,'FINALIZADA'),
(9,9,9,21,10,'2026-10-05 09:30:00','Otoscopía: eritema y secreción ceruminosa en oído derecho. Lavado ótico e inicio de gotas tópicas.',60.00,'FINALIZADA'),
(10,10,10,9,11,'2026-10-05 11:30:00','Cepillado profundo con deslanador retirando abundante pelo muerto, seguido de baño y secado con turbina.',75.00,'FINALIZADA'),
(11,11,11,8,12,'2026-10-06 09:30:00','Baño especial para pelo largo con acondicionador desenredante y limpieza de lagrimales.',45.00,'FINALIZADA'),
(12,12,12,5,13,'2026-10-06 11:00:00','Baño medicado dermatológico y desinfección cuidadosa de arrugas nasales.',55.00,'FINALIZADA'),
(13,13,13,7,14,'2026-10-07 09:00:00','Baño sanitario ectoparasiticida más aplicación de pipeta antipulgas en el lomo.',45.00,'FINALIZADA'),
(14,14,14,1,15,'2026-10-07 10:30:00','Baño básico con agua tibia, vaciado de glándulas perianales y corte de uñas.',35.00,'FINALIZADA'),
(15,15,15,20,2,'2026-10-08 09:30:00','Palpación abdominal sin dolor, T° 38.4°C. Tricobezoares leves, se indicó malta felina oral.',40.00,'FINALIZADA'),
(16,16,16,4,3,'2026-10-08 11:30:00','Baño de mantenimiento, limpieza de pabellones auriculares y cepillado de manto dorado.',50.00,'FINALIZADA'),
(17,17,17,1,4,'2026-10-09 09:00:00','Baño básico, corte de uñas y limpieza de oídos sin complicaciones.',35.00,'FINALIZADA'),
(18,18,18,23,5,'2026-10-09 10:30:00','Control de peso (3.80 kg) y administración oral de tableta antiparasitaria de amplio espectro.',35.00,'FINALIZADA'),
(19,19,19,21,6,'2026-10-10 09:30:00','Evaluación dermatológica: dermatitis alérgica en región inguinal. Se recetó shampoo medicado y dieta hipoalergénica.',60.00,'FINALIZADA'),
(20,20,20,4,7,'2026-10-10 11:30:00','Baño completo, cepillado de subpelo y revisión general de piel y almohadillas.',50.00,'FINALIZADA'),
(21,21,1,2,2,'2026-10-11 09:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Refuerzo anual de vacuna séxtuple aplicada por vía subcutánea sin reacción adversa.',55.00,'FINALIZADA'),
(22,22,2,13,3,'2026-10-11 10:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Refuerzo anual de vacuna triple felina aplicada por vía subcutánea sin reacción adversa.',60.00,'FINALIZADA'),
(23,23,3,11,4,'2026-10-11 11:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Vacunación antirrábica anual aplicada por vía subcutánea sin reacción adversa.',35.00,'FINALIZADA'),
(24,24,4,12,5,'2026-10-11 12:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Aplicación de vacuna KC contra tos de las perreras aplicada por vía subcutánea sin reacción adversa.',60.00,'FINALIZADA'),
(25,25,5,13,6,'2026-10-12 09:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Vacuna triple felina anual aplicada por vía subcutánea sin reacción adversa.',60.00,'FINALIZADA'),
(26,26,6,2,7,'2026-10-12 10:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Vacuna séxtuple anual aplicada por vía subcutánea sin reacción adversa.',55.00,'FINALIZADA'),
(27,27,7,11,8,'2026-10-12 11:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Vacuna antirrábica de control anual aplicada por vía subcutánea sin reacción adversa.',35.00,'FINALIZADA'),
(28,28,8,14,9,'2026-10-12 12:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Dosis anual contra leucemia felina aplicada por vía subcutánea sin reacción adversa.',75.00,'FINALIZADA'),
(29,29,9,10,10,'2026-10-13 09:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Refuerzo de vacuna quíntuple canina aplicada por vía subcutánea sin reacción adversa.',50.00,'FINALIZADA'),
(30,30,10,11,11,'2026-10-13 10:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Vacuna antirrábica anual aplicada por vía subcutánea sin reacción adversa.',35.00,'FINALIZADA'),
(31,31,11,13,12,'2026-10-13 11:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Refuerzo triple felina aplicada por vía subcutánea sin reacción adversa.',60.00,'FINALIZADA'),
(32,32,12,2,13,'2026-10-13 12:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Vacuna séxtuple anual aplicada por vía subcutánea sin reacción adversa.',55.00,'FINALIZADA'),
(33,33,13,2,14,'2026-10-14 09:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Vacunación séxtuple y control general aplicada por vía subcutánea sin reacción adversa.',55.00,'FINALIZADA'),
(34,34,14,12,15,'2026-10-14 10:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Vacuna contra tos de las perreras (KC) aplicada por vía subcutánea sin reacción adversa.',60.00,'FINALIZADA'),
(35,35,15,11,2,'2026-10-14 11:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Vacuna antirrábica felina aplicada por vía subcutánea sin reacción adversa.',35.00,'FINALIZADA'),
(36,36,16,2,3,'2026-10-14 12:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Refuerzo anual séxtuple aplicada por vía subcutánea sin reacción adversa.',55.00,'FINALIZADA'),
(37,37,17,10,4,'2026-10-15 09:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Vacuna quíntuple anual aplicada por vía subcutánea sin reacción adversa.',50.00,'FINALIZADA'),
(38,38,18,13,5,'2026-10-15 10:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Primera vacuna triple felina anual aplicada por vía subcutánea sin reacción adversa.',60.00,'FINALIZADA'),
(39,39,19,11,6,'2026-10-15 11:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Vacunación antirrábica anual aplicada por vía subcutánea sin reacción adversa.',35.00,'FINALIZADA'),
(40,40,20,2,7,'2026-10-15 12:00:00','Evaluación pre-vacunal conforme (afebril, mucosas rosadas). Refuerzo séxtuple canina aplicada por vía subcutánea sin reacción adversa.',55.00,'FINALIZADA'),
(41,41,1,19,2,'2026-09-10 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: cirugía de castración programada. Recuperación favorable.',150.00,'FINALIZADA'),
(42,42,2,16,3,'2026-09-11 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: esterilización felina programada. Recuperación favorable.',140.00,'FINALIZADA'),
(43,43,3,19,4,'2026-09-12 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: castración canina. Recuperación favorable.',150.00,'FINALIZADA'),
(44,44,4,3,5,'2026-09-14 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: esterilización canina raza pequeña. Recuperación favorable.',180.00,'FINALIZADA'),
(45,45,5,17,6,'2026-09-15 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: castración de gato macho. Recuperación favorable.',90.00,'FINALIZADA'),
(46,46,6,19,7,'2026-09-16 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: castración preventiva. Recuperación favorable.',150.00,'FINALIZADA'),
(47,47,7,3,8,'2026-09-17 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: cirugía de esterilización canina. Recuperación favorable.',180.00,'FINALIZADA'),
(48,48,8,17,9,'2026-09-18 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: castración felina. Recuperación favorable.',90.00,'FINALIZADA'),
(49,49,9,18,10,'2026-09-19 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: esterilización canina mediana. Recuperación favorable.',240.00,'FINALIZADA'),
(50,50,10,19,11,'2026-09-21 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: castración canina programada. Recuperación favorable.',150.00,'FINALIZADA'),
(51,51,11,16,12,'2026-09-22 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: esterilización de gata persa. Recuperación favorable.',140.00,'FINALIZADA'),
(52,52,12,19,13,'2026-09-23 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: castración con anestesia inhalatoria. Recuperación favorable.',150.00,'FINALIZADA'),
(53,53,13,19,14,'2026-09-24 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: castración de perro adoptado. Recuperación favorable.',150.00,'FINALIZADA'),
(54,54,14,3,15,'2026-09-25 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: esterilización canina laparoscópica/mínima incisión. Recuperación favorable.',180.00,'FINALIZADA'),
(55,55,15,17,2,'2026-09-26 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: castración felina ambulatoria. Recuperación favorable.',90.00,'FINALIZADA'),
(56,56,16,19,3,'2026-09-27 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: castración de perro adulto. Recuperación favorable.',150.00,'FINALIZADA'),
(57,57,17,19,4,'2026-09-28 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: castración por marcaje de territorio. Recuperación favorable.',150.00,'FINALIZADA'),
(58,58,18,17,5,'2026-09-29 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: castración felina joven. Recuperación favorable.',90.00,'FINALIZADA'),
(59,59,19,18,6,'2026-09-30 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: esterilización canina programada. Recuperación favorable.',240.00,'FINALIZADA'),
(60,60,21,3,7,'2026-10-01 08:30:00','Procedimiento quirúrgico realizado bajo protocolo anestésico seguro: esterilización campaña albergue. Recuperación favorable.',180.00,'FINALIZADA');
/*!40000 ALTER TABLE `tbl_atencion` ENABLE KEYS */;
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
