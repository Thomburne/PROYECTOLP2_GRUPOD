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
-- Table structure for table `tbl_movimiento_inventario`
--

DROP TABLE IF EXISTS `tbl_movimiento_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_movimiento_inventario` (
  `id_movimiento` bigint NOT NULL AUTO_INCREMENT,
  `id_producto` bigint NOT NULL,
  `id_usuario` bigint DEFAULT NULL,
  `tipo` enum('ENTRADA','SALIDA','AJUSTE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` decimal(12,2) NOT NULL,
  `fecha_movimiento` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `motivo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_movimiento`),
  KEY `fk_movimiento_producto` (`id_producto`),
  KEY `fk_movimiento_usuario` (`id_usuario`),
  KEY `idx_movimiento_fecha` (`fecha_movimiento`),
  CONSTRAINT `fk_movimiento_producto` FOREIGN KEY (`id_producto`) REFERENCES `tbl_producto` (`id_producto`),
  CONSTRAINT `fk_movimiento_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_usuario` (`id_usuario`),
  CONSTRAINT `ck_movimiento_cantidad` CHECK ((`cantidad` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_movimiento_inventario`
--

LOCK TABLES `tbl_movimiento_inventario` WRITE;
/*!40000 ALTER TABLE `tbl_movimiento_inventario` DISABLE KEYS */;
INSERT INTO `tbl_movimiento_inventario` VALUES
(1,1,1,'ENTRADA',12.00,'2026-09-25 09:15:00','Compra según Factura F001-04821 Distribuidora VetPerú'),
(2,2,1,'ENTRADA',15.00,'2026-09-25 09:20:00','Compra según Factura F001-04821 Distribuidora VetPerú'),
(3,5,1,'ENTRADA',50.00,'2026-09-26 10:00:00','Reposición mensual de antiparasitarios internos'),
(4,9,20,'ENTRADA',20.00,'2026-09-27 11:30:00','Ingreso de lote de shampoos medicados Factura F002-1190'),
(5,14,16,'ENTRADA',25.00,'2026-09-28 15:10:00','Reposición de collares isabelinos para área de cirugía'),
(6,15,16,'ENTRADA',20.00,'2026-09-28 15:15:00','Ingreso de fajas postoperatorias tallas S y M'),
(7,19,1,'ENTRADA',30.00,'2026-09-30 08:45:00','Recepción en cadena de frío de vacunas séxtuples'),
(8,20,1,'ENTRADA',25.00,'2026-09-30 08:50:00','Recepción en cadena de frío de vacunas triple felina'),
(9,21,1,'ENTRADA',40.00,'2026-09-30 08:55:00','Recepción de lote de vacunas antirrábicas'),
(10,10,2,'SALIDA',1.00,'2026-10-01 10:00:00','Insumo utilizado en área de grooming'),
(11,6,4,'SALIDA',1.00,'2026-10-02 09:50:00','Dispensado para limpieza ótica en consultorio 1'),
(12,23,6,'SALIDA',1.00,'2026-10-03 10:15:00','Venta en recepción junto con consulta felina'),
(13,9,7,'SALIDA',1.00,'2026-10-03 12:10:00','Uso en baño medicado dermatológico'),
(14,14,10,'SALIDA',1.00,'2026-10-05 10:25:00','Entregado a paciente con otitis para evitar rascado'),
(15,17,11,'SALIDA',1.00,'2026-10-05 13:20:00','Venta en petshop a propietario de Husky'),
(16,3,14,'SALIDA',1.00,'2026-10-07 09:45:00','Aplicado tras baño antipulgas'),
(17,5,5,'SALIDA',1.00,'2026-10-09 10:45:00','Administrado en desparasitación trimestral'),
(18,19,2,'SALIDA',6.00,'2026-10-12 18:00:00','Descargo de dosis aplicadas durante la jornada'),
(19,20,3,'SALIDA',4.00,'2026-10-13 18:00:00','Descargo de vacunas felinas aplicadas en consultorio'),
(20,21,4,'SALIDA',5.00,'2026-10-14 18:00:00','Descargo de vacunas antirrábicas de la semana'),
(21,12,17,'AJUSTE',1.00,'2026-10-15 09:30:00','Baja de 1 bolsa por rotura de empaque en almacén'),
(22,24,20,'ENTRADA',24.00,'2026-10-15 16:00:00','Ingreso de latas de alimento húmedo de recuperación');
/*!40000 ALTER TABLE `tbl_movimiento_inventario` ENABLE KEYS */;
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
