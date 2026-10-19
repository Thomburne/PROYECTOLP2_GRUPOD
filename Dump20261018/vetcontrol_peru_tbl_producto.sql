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
-- Table structure for table `tbl_producto`
--

DROP TABLE IF EXISTS `tbl_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_producto` (
  `id_producto` bigint NOT NULL AUTO_INCREMENT,
  `codigo` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` enum('VACUNA','MEDICAMENTO','HIGIENE','ACCESORIO','OTRO') COLLATE utf8mb4_unicode_ci NOT NULL,
  `unidad_medida` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'UNIDAD',
  `stock_actual` decimal(12,2) NOT NULL DEFAULT '0.00',
  `stock_minimo` decimal(12,2) NOT NULL DEFAULT '0.00',
  `precio_venta` decimal(12,2) NOT NULL DEFAULT '0.00',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `codigo` (`codigo`),
  CONSTRAINT `ck_producto_valores` CHECK (((`stock_actual` >= 0) and (`stock_minimo` >= 0) and (`precio_venta` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_producto`
--

LOCK TABLES `tbl_producto` WRITE;
/*!40000 ALTER TABLE `tbl_producto` DISABLE KEYS */;
INSERT INTO `tbl_producto` VALUES
(1,'MED-001','Bravecto 10-20 kg Tableta Masticable','MEDICAMENTO','CAJA',18.00,5.00,145.00,1),
(2,'MED-002','NexGard Spectra 7.5-15 kg','MEDICAMENTO','CAJA',24.00,6.00,78.00,1),
(3,'MED-003','Simparica 5-10 kg Tableta','MEDICAMENTO','UNIDAD',30.00,8.00,52.00,1),
(4,'MED-004','Pipeta Revolution Plus Gatos 2.5-5 kg','MEDICAMENTO','UNIDAD',22.00,5.00,65.00,1),
(5,'MED-005','Antiparasitario Drontal Plus Saborizado','MEDICAMENTO','TABLETA',65.00,15.00,12.00,1),
(6,'MED-006','Limpiador Ótico Otiflex C 100 ml','MEDICAMENTO','FRASCO',14.00,4.00,48.00,1),
(7,'MED-007','Suplemento Hemolitan Pet Gotas 60 ml','MEDICAMENTO','FRASCO',16.00,4.00,42.00,1),
(8,'MED-008','Meloxicam 2 mg Antiinflamatorio Vet','MEDICAMENTO','BLISTER',28.00,6.00,25.00,1),
(9,'HIG-001','Shampoo Clorhexidina 4% Medifarma Vet 250 ml','HIGIENE','FRASCO',20.00,5.00,45.00,1),
(10,'HIG-002','Shampoo Hipoalergénico Avena y Aloe 300 ml','HIGIENE','FRASCO',25.00,5.00,38.00,1),
(11,'HIG-003','Espuma de Baño en Seco para Gatos 200 ml','HIGIENE','FRASCO',15.00,4.00,32.00,1),
(12,'HIG-004','Arena Sanitaria Aglutinante para Gatos 10 kg','HIGIENE','BOLSA',19.00,6.00,40.00,1),
(13,'HIG-005','Colonia Canina Fragancia Bebé 120 ml','HIGIENE','FRASCO',22.00,5.00,24.00,1),
(14,'ACC-001','Collar Isabelino Transparente Talla M','ACCESORIO','UNIDAD',32.00,8.00,22.00,1),
(15,'ACC-002','Faja Postoperatoria Algodón Talla S','ACCESORIO','UNIDAD',26.00,6.00,28.00,1),
(16,'ACC-003','Pechera Acolchada Regulable con Correa','ACCESORIO','UNIDAD',14.00,4.00,45.00,1),
(17,'ACC-004','Cepillo Carda Removedor de Subpelo','ACCESORIO','UNIDAD',18.00,4.00,30.00,1),
(18,'ACC-005','Plato Doble Acero Inoxidable Antideslizante','ACCESORIO','UNIDAD',12.00,3.00,35.00,1),
(19,'VAC-001','Dosis Vacuna Séxtuple Nobivac DHPPi+L','VACUNA','DOSIS',40.00,10.00,55.00,1),
(20,'VAC-002','Dosis Vacuna Triple Felina Felocell 3','VACUNA','DOSIS',35.00,10.00,60.00,1),
(21,'VAC-003','Dosis Vacuna Antirrábica Nobivac Rabies','VACUNA','DOSIS',50.00,12.00,35.00,1),
(22,'VAC-004','Dosis Vacuna KC Intranasal','VACUNA','DOSIS',24.00,6.00,60.00,1),
(23,'OTR-001','Pasta de Malta Felina Control Bolas de Pelo 100 g','OTRO','TUBO',17.00,4.00,36.00,1),
(24,'OTR-002','Alimento Húmedo de Recuperación Lata 156 g','OTRO','LATA',36.00,10.00,18.00,1);
/*!40000 ALTER TABLE `tbl_producto` ENABLE KEYS */;
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
