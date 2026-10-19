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
-- Table structure for table `tbl_usuario`
--

DROP TABLE IF EXISTS `tbl_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_usuario` (
  `id_usuario` bigint NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidos` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nro_colegiatura` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clave_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rol` enum('ADMIN','VETERINARIO','RECEPCION') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'RECEPCION',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_usuario`
--

LOCK TABLES `tbl_usuario` WRITE;
/*!40000 ALTER TABLE `tbl_usuario` DISABLE KEYS */;
INSERT INTO `tbl_usuario` VALUES
(1,'Ricardo Martín','Vargas Alarcón',NULL,'rvargas@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','ADMIN',1),
(2,'Claudia Marcela','Ramírez Ugarte','CMVP 8412','cramirez@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(3,'Gonzalo Alonso','Herrera Seminario','CMVP 9105','gherrera@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(4,'Paola Andrea','Carranza Luján','CMVP 10248','pcarranza@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(5,'Sergio Daniel','Bustamante Ponce','CMVP 7894','sbustamante@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(6,'Verónica Sofía','Linares Tapia','CMVP 11032','vlinares@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(7,'Renzo Fabricio','Ochoa Miranda','CMVP 9651','rochoa@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(8,'Natalia Beatriz','Pizarro Gallegos','CMVP 10874','npizarro@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(9,'Héctor Manuel','Zevallos Cornejo','CMVP 8219','hzevallos@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(10,'Daniela Ximena','Castañeda Ruiz','CMVP 11490','dcastaneda@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(11,'Óscar Eduardo','Saldarriaga Meza','CMVP 8930','osaldarriaga@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(12,'Mariana Belén','Aguilar Tello','CMVP 10511','maguilar@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(13,'Christian David','Reátegui Solís','CMVP 9380','creategui@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(14,'Fabiola Karina','Valdivia Olórtegui','CMVP 11205','fvaldivia@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(15,'Arturo Sebastián','Céspedes León','CMVP 8745','acespedes@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','VETERINARIO',1),
(16,'Brenda Nicole','Huamaní Peralta',NULL,'bhuamani@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','RECEPCION',1),
(17,'Kevin Alexander','Chumpitaz Yáñez',NULL,'kchumpitaz@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','RECEPCION',1),
(18,'Lesly Carolina','Garay Palomino',NULL,'lgaray@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','RECEPCION',1),
(19,'Giancarlo','Bazán Quiroz',NULL,'gbazan@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','RECEPCION',1),
(20,'Silvana Rocío','Arellano Campos',NULL,'sarellano@vetcontrol.pe','$2a$10$7EqJtq98hPqEX7fNZaFWoOHi8rN8s2X1y0pQ9vL3mK4nB6cV8xZ2a','ADMIN',1);
/*!40000 ALTER TABLE `tbl_usuario` ENABLE KEYS */;
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
