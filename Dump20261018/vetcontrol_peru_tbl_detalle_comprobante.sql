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
-- Table structure for table `tbl_detalle_comprobante`
--

DROP TABLE IF EXISTS `tbl_detalle_comprobante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_detalle_comprobante` (
  `id_detalle` bigint NOT NULL AUTO_INCREMENT,
  `id_comprobante` bigint NOT NULL,
  `id_atencion` bigint DEFAULT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` decimal(10,2) NOT NULL DEFAULT '1.00',
  `precio_unitario` decimal(12,2) NOT NULL,
  `importe` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  UNIQUE KEY `id_atencion` (`id_atencion`),
  KEY `fk_detalle_comprobante` (`id_comprobante`),
  CONSTRAINT `fk_detalle_atencion` FOREIGN KEY (`id_atencion`) REFERENCES `tbl_atencion` (`id_atencion`),
  CONSTRAINT `fk_detalle_comprobante` FOREIGN KEY (`id_comprobante`) REFERENCES `tbl_comprobante` (`id_comprobante`),
  CONSTRAINT `ck_detalle_importes` CHECK (((`cantidad` > 0) and (`precio_unitario` >= 0) and (`importe` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detalle_comprobante`
--

LOCK TABLES `tbl_detalle_comprobante` WRITE;
/*!40000 ALTER TABLE `tbl_detalle_comprobante` DISABLE KEYS */;
INSERT INTO `tbl_detalle_comprobante` VALUES
(1,1,1,'Baño y corte de raza (Grooming) - Mascota: Toby',1.00,65.00,65.00),
(2,2,2,'Baño felino especializado - Mascota: Luna',1.00,45.00,45.00),
(3,3,3,'Baño básico raza mediana y grande - Mascota: Max',1.00,50.00,50.00),
(4,4,4,'Baño y corte de raza (Grooming) - Mascota: Kiara',1.00,65.00,65.00),
(5,5,5,'Consulta médica veterinaria general - Mascota: Michi',1.00,40.00,40.00),
(6,6,6,'Baño medicado dermatológico - Mascota: Rocky',1.00,55.00,55.00),
(7,7,7,'Baño y corte de raza (Grooming) - Mascota: Pelusa',1.00,65.00,65.00),
(8,8,8,'Consulta médica veterinaria general - Mascota: Simba',1.00,40.00,40.00),
(9,9,9,'Consulta dermatológica y raspado - Mascota: Canela',1.00,60.00,60.00),
(10,10,10,'Deslanado profundo y baño - Mascota: Balto',1.00,75.00,75.00),
(11,11,11,'Baño felino especializado - Mascota: Nala',1.00,45.00,45.00),
(12,12,12,'Baño medicado dermatológico - Mascota: Coco',1.00,55.00,55.00),
(13,13,13,'Baño antipulgas y garrapatas - Mascota: Manchas',1.00,45.00,45.00),
(14,14,14,'Baño básico raza pequeña - Mascota: Princesa',1.00,35.00,35.00),
(15,15,15,'Consulta médica veterinaria general - Mascota: Copito',1.00,40.00,40.00),
(16,16,16,'Baño básico raza mediana y grande - Mascota: Bruno',1.00,50.00,50.00),
(17,17,17,'Baño básico raza pequeña - Mascota: Chispas',1.00,35.00,35.00),
(18,18,18,'Desparasitación interna y externa - Mascota: Milo',1.00,35.00,35.00),
(19,19,19,'Consulta dermatológica y raspado - Mascota: Lola',1.00,60.00,60.00),
(20,20,20,'Baño básico raza mediana y grande - Mascota: Duque',1.00,50.00,50.00),
(21,21,60,'Esterilización canina hasta 10 kg - Mascota: Motita',1.00,180.00,180.00),
(22,22,21,'Vacunación Séxtuple Canina - Mascota: Toby',1.00,55.00,55.00);
/*!40000 ALTER TABLE `tbl_detalle_comprobante` ENABLE KEYS */;
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
