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
-- Table structure for table `tbl_servicio`
--

DROP TABLE IF EXISTS `tbl_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_servicio` (
  `id_servicio` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` enum('BANIO','VACUNACION','ESTERILIZACION','CONSULTA','OTRO') COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio_referencial` decimal(10,2) NOT NULL DEFAULT '0.00',
  `duracion_minutos` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_servicio`),
  CONSTRAINT `ck_servicio_duracion` CHECK (((`duracion_minutos` is null) or (`duracion_minutos` > 0))),
  CONSTRAINT `ck_servicio_precio` CHECK ((`precio_referencial` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_servicio`
--

LOCK TABLES `tbl_servicio` WRITE;
/*!40000 ALTER TABLE `tbl_servicio` DISABLE KEYS */;
INSERT INTO `tbl_servicio` VALUES
(1,'Baño básico raza pequeña','BANIO','Baño con shampoo neutro, secado, limpieza de oídos y corte de uñas para mascotas de hasta 10 kg',35.00,60,1),
(2,'Vacunación Séxtuple Canina','VACUNACION','Inmunización contra parvovirus, distemper, hepatitis, parainfluenza, coronavirus y leptospira',55.00,30,1),
(3,'Esterilización canina hasta 10 kg','ESTERILIZACION','Ovariohisterectomía para hembras pequeñas con evaluación física previa y analgesia',180.00,120,1),
(4,'Baño básico raza mediana y grande','BANIO','Baño completo, deslanado ligero, limpieza de glándulas anales y secado para perros mayores a 10 kg',50.00,75,1),
(5,'Baño medicado dermatológico','BANIO','Baño terapéutico con clorhexidina al 4% o ketoconazol para mascotas con dermatitis o alergias',55.00,60,1),
(6,'Baño y corte de raza (Grooming)','BANIO','Servicio integral de peluquería canina según estándar de raza, corte higiénico y perfumado',65.00,90,1),
(7,'Baño antipulgas y garrapatas','BANIO','Baño sanitario con producto ectoparasiticida para control inmediato de pulgas y garrapatas',45.00,60,1),
(8,'Baño felino especializado','BANIO','Higiene para gatos con manejo libre de estrés, agua tibia, corte de puntas de uñas y limpieza ótica',45.00,50,1),
(9,'Deslanado profundo y baño','BANIO','Retiro de subpelo muerto en razas de doble manto (Husky, Golden, Pastor) más baño completo',75.00,100,1),
(10,'Vacunación Quíntuple Canina','VACUNACION','Refuerzo contra distemper, adenovirus, parvovirus, parainfluenza y leptospira',50.00,25,1),
(11,'Vacunación Antirrábica','VACUNACION','Aplicación de vacuna antirrábica anual con entrega de certificado oficial de vacunación',35.00,20,1),
(12,'Vacunación KC (Tos de las perreras)','VACUNACION','Vacuna intranasal u oral contra Bordetella bronchiseptica y parainfluenza canina',60.00,20,1),
(13,'Vacunación Triple Felina','VACUNACION','Protección contra rinotraqueítis viral felina, calicivirus y panleucopenia',60.00,25,1),
(14,'Vacunación Leucemia Felina (FeLV)','VACUNACION','Inmunización preventiva contra el virus de la leucemia felina previa prueba negativa',75.00,30,1),
(15,'Vacunación Puppy DP (Cachorros)','VACUNACION','Primera dosis para cachorros a partir de las 6 semanas contra parvovirus y distemper',45.00,25,1),
(16,'Esterilización felina (Gata)','ESTERILIZACION','Ovariohisterectomía felina por abordaje mínimo con medicación intraoperatoria incluida',140.00,90,1),
(17,'Castración felina (Gato)','ESTERILIZACION','Orquiectomía felina bajo sedación segura y rápida recuperación ambulatoria',90.00,60,1),
(18,'Esterilización canina mayor a 10 kg','ESTERILIZACION','Ovariohisterectomía para perras medianas y grandes con monitoreo multiparámetro',240.00,150,1),
(19,'Castración canina','ESTERILIZACION','Orquiectomía cerrada para perros machos con manejo del dolor postoperatorio',150.00,90,1),
(20,'Consulta médica veterinaria general','CONSULTA','Evaluación clínica completa, control de peso, temperatura, auscultación y prescripción médica',40.00,30,1),
(21,'Consulta dermatológica y raspado','CONSULTA','Evaluación especializada de piel y pelaje con tricograma o citología básica',60.00,40,1),
(22,'Control postoperatorio y retiro de puntos','CONSULTA','Revisión de herida quirúrgica, desinfección y retiro de suturas',25.00,20,1),
(23,'Desparasitación interna y externa','OTRO','Aplicación de antiparasitario oral de amplio espectro según peso más control externo',35.00,20,1);
/*!40000 ALTER TABLE `tbl_servicio` ENABLE KEYS */;
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
