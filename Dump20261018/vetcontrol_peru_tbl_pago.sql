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
-- Table structure for table `tbl_pago`
--

DROP TABLE IF EXISTS `tbl_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_pago` (
  `id_pago` bigint NOT NULL AUTO_INCREMENT,
  `id_comprobante` bigint NOT NULL,
  `fecha_pago` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `medio` enum('EFECTIVO','YAPE','PLIN','TARJETA','TRANSFERENCIA') COLLATE utf8mb4_unicode_ci NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `nro_operacion` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observaciones` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_pago`),
  KEY `fk_pago_comprobante` (`id_comprobante`),
  CONSTRAINT `fk_pago_comprobante` FOREIGN KEY (`id_comprobante`) REFERENCES `tbl_comprobante` (`id_comprobante`),
  CONSTRAINT `ck_pago_monto` CHECK ((`monto` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_pago`
--

LOCK TABLES `tbl_pago` WRITE;
/*!40000 ALTER TABLE `tbl_pago` DISABLE KEYS */;
INSERT INTO `tbl_pago` VALUES
(1,1,'2026-10-01 12:35:00','YAPE',65.00,'YAPE-4829103','Pago confirmado por aplicativo Yape'),
(2,2,'2026-10-01 12:35:00','PLIN',45.00,'PLIN-7391824','Transferencia inmediata por Plin'),
(3,3,'2026-10-02 12:35:00','TARJETA',50.00,'POS-008412','Pago con tarjeta Visa débito en POS Niubiz'),
(4,4,'2026-10-02 12:35:00','EFECTIVO',65.00,NULL,'Pago en efectivo en recepción'),
(5,5,'2026-10-03 12:35:00','YAPE',40.00,'YAPE-5192837','Cancelado por Yape al recoger a la mascota'),
(6,6,'2026-10-03 12:35:00','TARJETA',55.00,'POS-008439','Pago con tarjeta Mastercard en caja'),
(7,7,'2026-10-04 12:35:00','PLIN',65.00,'PLIN-8492011','Confirmado en cuenta recepción'),
(8,8,'2026-10-04 12:35:00','EFECTIVO',40.00,NULL,'Efectivo exacto recibido en caja'),
(9,9,'2026-10-05 12:35:00','TRANSFERENCIA',60.00,'BCP-29481023','Transferencia bancaria BCP confirmada'),
(10,10,'2026-10-05 12:35:00','YAPE',75.00,'YAPE-6281940','Pago por Yape verificado'),
(11,11,'2026-10-06 12:35:00','PLIN',45.00,'PLIN-9102834','Pago por Plin verificado'),
(12,12,'2026-10-06 12:35:00','TARJETA',55.00,'POS-008501','Pago con tarjeta Visa en terminal POS'),
(13,13,'2026-10-07 12:35:00','YAPE',45.00,'YAPE-7382915','Cancelado por Yape en recepción'),
(14,14,'2026-10-07 12:35:00','EFECTIVO',35.00,NULL,'Cancelado en efectivo'),
(15,15,'2026-10-08 12:35:00','PLIN',40.00,'PLIN-3829104','Abono por Plin verificado'),
(16,16,'2026-10-08 12:35:00','TARJETA',50.00,'POS-008544','Pago con tarjeta débito'),
(17,17,'2026-10-09 12:35:00','YAPE',35.00,'YAPE-8491026','Pago por Yape sin observaciones'),
(18,18,'2026-10-09 12:35:00','EFECTIVO',35.00,NULL,'Pago al contado en caja'),
(19,19,'2026-10-10 12:35:00','TARJETA',60.00,'POS-008590','Cancelado con tarjeta de crédito'),
(20,20,'2026-10-10 12:35:00','TRANSFERENCIA',50.00,'IBK-58291044','Transferencia Interbank confirmada'),
(21,21,'2026-10-01 12:35:00','TRANSFERENCIA',180.00,'BCP-67482910','Factura cancelada por transferencia BCP'),
(22,22,'2026-10-11 12:35:00','YAPE',55.00,'YAPE-9501827','Pago por Yape tras vacunación');
/*!40000 ALTER TABLE `tbl_pago` ENABLE KEYS */;
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
