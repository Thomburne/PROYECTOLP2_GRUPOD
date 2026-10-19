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
-- Table structure for table `tbl_mascota`
--

DROP TABLE IF EXISTS `tbl_mascota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_mascota` (
  `id_mascota` bigint NOT NULL AUTO_INCREMENT,
  `id_cliente` bigint NOT NULL,
  `nombre` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `especie` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `raza` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sexo` enum('M','H') COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `color` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `peso_kg` decimal(6,2) DEFAULT NULL,
  `nro_microchip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_mascota`),
  UNIQUE KEY `nro_microchip` (`nro_microchip`),
  KEY `fk_mascota_cliente` (`id_cliente`),
  CONSTRAINT `fk_mascota_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `tbl_cliente` (`id_cliente`),
  CONSTRAINT `ck_mascota_peso` CHECK (((`peso_kg` is null) or (`peso_kg` > 0)))
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_mascota`
--

LOCK TABLES `tbl_mascota` WRITE;
/*!40000 ALTER TABLE `tbl_mascota` DISABLE KEYS */;
INSERT INTO `tbl_mascota` VALUES
(1,1,'Toby','Perro','Schnauzer','M','2022-04-15','Sal y pimienta',7.80,'900182001450101','Alérgico al pollo, usar shampoo hipoalergénico',1),
(2,2,'Luna','Gato','Mestizo','H','2023-02-10','Blanco con gris',3.60,'900182001450102','Gata casera, un poco nerviosa al corte de uñas',1),
(3,3,'Max','Perro','Labrador Retriever','M','2021-08-22','Dorado',28.50,'900182001450103','Muy dócil, propenso a otitis en verano',1),
(4,4,'Kiara','Perro','Shih Tzu','H','2023-06-05','Blanco con caramelo',5.20,'900182001450104','Lagrimeo constante, limpiar contorno de ojos',1),
(5,5,'Michi','Gato','Mestizo','M','2022-11-18','Atigrado naranja',4.40,NULL,'Rescatado de cachorro, tranquilo en consulta',1),
(6,6,'Rocky','Perro','Bulldog Francés','M','2022-01-30','Negro atigrado',11.90,'900182001450106','Cuidado con el calor durante el secado',1),
(7,7,'Pelusa','Perro','Poodle','H','2020-09-12','Blanco',4.80,'900182001450107','Piel sensible, corte estilo osito',1),
(8,8,'Simba','Gato','Siamés','M','2023-05-14','Crema con puntos marrones',4.10,'900182001450108','Maúlla bastante en el transportador',1),
(9,9,'Canela','Perro','Cocker Spaniel','H','2021-12-03','Canela dorado',12.40,'900182001450109','Revisar siempre conducto auditivo externo',1),
(10,10,'Balto','Perro','Husky Siberiano','M','2021-03-25','Gris con blanco',24.00,'900182001450110','Abundante muda de pelo, requiere deslanado',1),
(11,11,'Nala','Gato','Persa','H','2022-07-09','Gris humo',3.90,'900182001450111','Cepillado frecuente para evitar nudos',1),
(12,12,'Coco','Perro','Pug','M','2022-10-20','Cervato',8.30,'900182001450112','Limpiar pliegues faciales con clorhexidina',1),
(13,13,'Manchas','Perro','Mestizo','M','2023-01-15','Blanco con manchas negras',14.20,NULL,'Adoptado, muy activo y juguetón',1),
(14,14,'Princesa','Perro','Yorkshire Terrier','H','2023-08-01','Negro y fuego',2.90,'900182001450114','Vacunación y desparasitación al día',1),
(15,15,'Copito','Gato','Angora','M','2021-06-19','Blanco',4.50,'900182001450115','No tolera collares antipulgas, usar pipeta',1),
(16,16,'Bruno','Perro','Golden Retriever','M','2020-11-11','Dorado claro',31.20,'900182001450116','Paciente noble, ligero sobrepeso',1),
(17,17,'Chispas','Perro','Jack Russell Terrier','M','2023-04-02','Tricolor',6.70,'900182001450117','Bastante inquieto durante la revisión',1),
(18,18,'Milo','Gato','Mestizo','M','2024-01-12','Negro',3.80,NULL,'Castrado recientemente, buen apetito',1),
(19,19,'Lola','Perro','Beagle','H','2022-05-28','Tricolor',10.80,'900182001450119','Antecedente de alergia alimentaria',1),
(20,20,'Duque','Perro','Pastor Alemán','M','2020-02-14','Negro con fuego',33.50,'900182001450120','Ingresa con correa corta y bozal preventivo',1),
(21,21,'Motita','Perro','Mestizo','H','2024-03-10','Caramelo',8.90,NULL,'Rescatada por el albergue, en socialización',1),
(22,22,'Sasha','Gato','Mestizo','H','2023-09-05','Calicó (tricolor)',3.40,'900182001450122','Tranquila, controles al día',1),
(23,23,'Zeus','Perro','Bóxer','M','2021-07-17','Leonado',27.60,'900182001450123','Revisar encías en cada control',1),
(24,24,'Rambo','Perro','Rottweiler','M','2021-05-03','Negro con marrón',38.00,'900182001450124','Perro guardián de almacén, viene con su manejador',1),
(25,1,'Peluchín','Perro','Poodle','M','2019-10-10','Habano',5.50,'900182001450125','Segunda mascota del propietario, soplo cardíaco leve',1);
/*!40000 ALTER TABLE `tbl_mascota` ENABLE KEYS */;
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
