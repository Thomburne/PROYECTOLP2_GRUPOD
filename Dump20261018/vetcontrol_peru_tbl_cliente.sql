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
-- Table structure for table `tbl_cliente`
--

DROP TABLE IF EXISTS `tbl_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_cliente` (
  `id_cliente` bigint NOT NULL AUTO_INCREMENT,
  `tipo_documento` enum('DNI','RUC','CE','PASAPORTE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nro_documento` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombres_razon_social` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidos` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `celular` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `uq_cliente_documento` (`tipo_documento`,`nro_documento`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_cliente`
--

LOCK TABLES `tbl_cliente` WRITE;
/*!40000 ALTER TABLE `tbl_cliente` DISABLE KEYS */;
INSERT INTO `tbl_cliente` VALUES
(1,'DNI','74395181','Pedro','Thomburne','971421629','pthomburne@gmail.com','Av. Sáenz Peña 450, Callao','2026-09-02 09:15:10',1),
(2,'DNI','45829104','Juan Carlos','Quispe Mamani','987412365','jcquispe88@gmail.com','Jr. Los Jazmines 234 Urb. San José, Bellavista','2026-09-03 10:22:40',1),
(3,'DNI','71204958','María Elena','Flores Huamán','945821039','maria.flores.h@hotmail.com','Calle Las Begonias 118, La Perla','2026-09-04 11:05:18',1),
(4,'DNI','42918374','Luis Alberto','Sánchez Rojas','991254780','luissanchez_r@gmail.com','Av. Elmer Faucett 1820, Carmen de la Legua','2026-09-05 15:40:00',1),
(5,'DNI','73849201','Rosa María','Chávez Mendoza','964785123','rosachavez19@outlook.com','Jr. Cochrane 310, Callao','2026-09-06 16:12:33',1),
(6,'DNI','40758291','Jorge Luis','Paredes Castro','958741203','jparedes.castro@gmail.com','Av. La Marina 890 Dpto. 302, San Miguel','2026-09-08 09:50:11',1),
(7,'DNI','75918234','Carmen Rosa','Gutiérrez Vargas','923654789','cgutierrez_v@gmail.com','Mz. D Lt. 14 Urb. Previ, Callao','2026-09-09 12:30:45',1),
(8,'DNI','46829173','Miguel Ángel','Torres Díaz','978451236','mangel.torres@hotmail.com','Av. Colonial 2410, Bellavista','2026-09-10 17:05:29',1),
(9,'DNI','72648190','Ana Lucía','Ramos Espinoza','984125630','analucia.ramos@gmail.com','Calle Los Pinos 405 Urb. Tarapacá, Callao','2026-09-11 10:18:50',1),
(10,'DNI','44192837','Carlos Eduardo','Huerta Salazar','996325874','chuerta.salazar@gmail.com','Av. Dos de Mayo 670, Callao','2026-09-12 14:25:00',1),
(11,'DNI','70482915','Patricia Milagros','Vega Córdova','935478120','paty.vega.c@outlook.com','Jr. Bolognesi 512, La Punta','2026-09-14 09:42:15',1),
(12,'DNI','48291036','José Antonio','Morales Cruz','947852369','jamoralescruz@gmail.com','Av. Bertello 380 Urb. El Álamo, Callao','2026-09-15 11:55:20',1),
(13,'DNI','76192845','Claudia Fernanda','Silva Aguinaga','981472583','claudiasilva.ag@gmail.com','Calle Los Rosales 190, San Miguel','2026-09-16 16:33:10',1),
(14,'DNI','41827364','Roberto Carlos','Mendoza Palacios','963258741','rmendoza_pal@hotmail.com','Av. Argentina 1540, Callao','2026-09-18 10:10:05',1),
(15,'DNI','74920183','Fiorella Jesús','Villanueva Soto','954123687','fiore.villanueva@gmail.com','Jr. Zepita 418, Callao','2026-09-19 13:20:40',1),
(16,'DNI','43758290','Fernando José','Castillo Ríos','998745612','fcastillo.rios@gmail.com','Mz. F Lt. 8 Urb.Vipol, Callao','2026-09-21 15:48:12',1),
(17,'DNI','73192840','Valeria Alejandra','Romero Pineda','921478523','valeria.romero.p@gmail.com','Av. Pacasmayo 920, Callao','2026-09-22 18:02:55',1),
(18,'DNI','47281930','César Augusto','Benites Lozano','974125896','cbenites.lozano@outlook.com','Jr. Vigil 275, Bellavista','2026-09-24 09:30:00',1),
(19,'DNI','71829304','Lucía del Pilar','Navarro Cáceres','986532147','lucianavarro.c@gmail.com','Calle Las Palmeras 322, La Perla','2026-09-25 11:14:22',1),
(20,'DNI','45102938','Diego Armando','Medina Farfán','941258963','dmedinaf@hotmail.com','Av. Guardia Chalaca 1120, Bellavista','2026-09-26 17:40:18',1),
(21,'RUC','20604829104','Albergue Huellitas del Puerto Asociación','','993451287','contacto@huellitasdelpuerto.org','Av. Canta Callao Mz. B Lt. 4, Callao','2026-09-28 10:00:00',1),
(22,'DNI','76849210','Gabriela Estefanía','Salas Orbegoso','952147863','gaby.salas.o@gmail.com','Jr. Colina 640, Bellavista','2026-09-30 12:15:30',1),
(23,'CE','004829153','Andrés Felipe','Montoya Restrepo','938521470','amontoya.r@gmail.com','Av. Costanera 1450 Dpto. 704, San Miguel','2026-10-02 15:20:10',1),
(24,'RUC','20548291731','Inversiones y Servicios San Roque S.A.C.','','987654120','administracion@sanroquesac.pe','Av. Néstor Gambetta 3420, Callao','2026-10-05 09:45:00',1),
(25,'DNI','08492017','Rosa Elvira','Delgado Viuda de Paz','990142536','rosadelgado.paz@gmail.com','Jr. Atahualpa 185, La Perla','2026-10-08 11:30:00',0),
(26,'DNI','43719284','Rodrigo Sebastián','Paredes Silva','986274135','rodrigo.paredes@gmail.com','Calle Las Magnolias 234, Miraflores','2026-10-10 10:12:00',1),
(27,'DNI','49281547','Andrea Lucía','Vargas Castillo','942718635','andrea.vargas.c@hotmail.com','Jr. Los Álamos 567, Los Olivos','2026-10-10 11:30:00',1),
(28,'DNI','78416392','Luis Fernando','Ramírez Soto','975318426','lramirez.soto@gmail.com','Av. Faucett 1450, Callao','2026-10-10 15:20:00',1),
(29,'DNI','43827415','Mariana Isabel','Cárdenas Vega','961842753','mariana.cardenas@outlook.com','Calle Los Pinos 420, San Borja','2026-10-11 09:40:00',1),
(30,'DNI','71592743','José Miguel','Navarro Ruiz','987153642','jmnavarro.ruiz@gmail.com','Av. Universitaria 2305, San Martín de Porres','2026-10-11 12:15:00',1),
(31,'DNI','47284619','Luciana Patricia','Gómez Herrera','953741862','luciana.gomez.h@gmail.com','Jr. Junín 875, Magdalena','2026-10-11 16:05:00',1),
(32,'DNI','44618273','Carlos Alberto','Espinoza León','968215347','cespinoza.leon@hotmail.com','Av. Brasil 1624, Pueblo Libre','2026-10-12 09:50:00',1),
(33,'DNI','72593841','Paola Milagros','Rojas Delgado','974628153','paola.rojas.d@gmail.com','Calle Los Cedros 347, La Molina','2026-10-12 11:25:00',1),
(34,'DNI','48427195','Miguel Ángel','Quispe Salinas','956813742','mquispe.salinas@gmail.com','Av. Próceres 2840, San Juan de Lurigancho','2026-10-12 14:40:00',1),
(35,'DNI','73951726','Daniela Sofía','Chávez Moreno','982536174','daniela.chavez.m@outlook.com','Jr. Tacna 625, Bellavista','2026-10-12 17:10:00',1),
(36,'DNI','49173842','Jorge Eduardo','Castro Molina','947261835','jcastro.molina@gmail.com','Av. Benavides 3610, Surco','2026-10-13 10:00:00',1),
(37,'DNI','76329481','Fiorella Alejandra','Reyes Ponce','965482731','fiorella.reyes.p@gmail.com','Calle Las Gardenias 181, San Isidro','2026-10-13 11:45:00',1),
(38,'DNI','42841759','Renato Gabriel','Flores Aguilar','938572614','rflores.aguilar@hotmail.com','Av. Colonial 2240, Callao','2026-10-13 15:30:00',1),
(39,'DNI','75719364','Gabriela Carolina','Peña Morales','976143825','gabriela.pena.m@gmail.com','Jr. Huancavelica 930, Breña','2026-10-14 09:20:00',1),
(40,'DNI','71462839','Héctor Manuel','Valdivia Campos','954786213','hvaldivia.campos@gmail.com','Av. Angamos 1250, Surquillo','2026-10-14 12:10:00',1),
(41,'DNI','46371825','Rosa Elena','Huamán Pérez','989315742','rosa.huaman.p@outlook.com','Calle Los Geranios 560, Comas','2026-10-14 16:00:00',1),
(42,'DNI','48294613','Fernando José','López Carrasco','961573824','flopez.carrasco@gmail.com','Av. Néstor Gambetta 1780, Ventanilla','2026-10-15 09:35:00',1),
(43,'DNI','73618249','Natalia Belén','Sánchez Romero','974185362','natalia.sanchez.r@gmail.com','Jr. Santa Rosa 425, La Perla','2026-10-15 11:15:00',1),
(44,'DNI','74926371','Óscar Antonio','Medina Cabrera','952638417','omedina.cabrera@hotmail.com','Av. Canadá 1458, La Victoria','2026-10-15 14:50:00',1),
(45,'DNI','41739528','Adriana Valentina','Palacios Núñez','986417253','adriana.palacios@gmail.com','Calle Los Robles 341, San Borja','2026-10-15 17:20:00',1),
(46,'DNI','42517463','Martín Alonso','Acuña Fernández','943782615','macuna.fernandez@gmail.com','Av. Tomás Valle 2150, Independencia','2026-10-16 09:10:00',1),
(47,'DNI','47182496','Karla Vanessa','Córdova Torres','975642813','karla.cordova.t@outlook.com','Jr. Los Sauces 718, Chorrillos','2026-10-16 10:40:00',1),
(48,'DNI','48493517','Eduardo Andrés','Zambrano Ortiz','957314862','ezambrano.ortiz@gmail.com','Av. Guardia Chalaca 840, Callao','2026-10-16 12:30:00',1),
(49,'DNI','79361842','Claudia Mercedes','Ramos Valdez','981462735','claudia.ramos.v@gmail.com','Calle Los Eucaliptos 256, San Isidro','2026-10-16 15:15:00',1),
(50,'DNI','72649315','Ricardo Javier','Bustamante Díaz','964718253','rbustamante.diaz@hotmail.com','Av. Javier Prado Este 2450, San Borja','2026-10-16 16:45:00',1),
(51,'DNI','43827164','Silvia Maribel','Campos Gutiérrez','937625184','silvia.campos.g@gmail.com','Jr. Las Orquídeas 390, Ate','2026-10-17 09:05:00',1),
(52,'DNI','71746382','Bruno Alexander','Vera Montenegro','985231746','bruno.vera.m@gmail.com','Av. Elmer Faucett 970, Carmen de la Legua','2026-10-17 10:20:00',1),
(53,'DNI','44819273','Patricia Rocío','Márquez Huerta','951827364','pmarquez.huerta@outlook.com','Av. Universitaria 3180, Los Olivos','2026-10-17 11:50:00',1),
(54,'DNI','78253649','Cristian David','Mejía Calderón','978351624','cmejia.calderon@gmail.com','Calle Las Palmeras 625, Miraflores','2026-10-17 14:15:00',1),
(55,'DNI','49384716','Melissa Gabriela','Silva Espinoza','962741853','melissa.silva.e@gmail.com','Jr. Ayacucho 512, Magdalena','2026-10-17 15:40:00',1),
(56,'DNI','76421735','Alonso Nicolás','Rivas Mendoza','946825371','alonso.rivas.m@hotmail.com','Av. Venezuela 1640, Breña','2026-10-17 16:55:00',1),
(57,'DNI','71938462','Jimena Antonella','León Benavides','983615427','jimena.leon.b@gmail.com','Calle Los Olivos 455, La Molina','2026-10-17 17:30:00',1),
(58,'DNI','42597184','Víctor Hugo','Soto Bustos','957826341','vsoto.bustos@gmail.com','Av. Perú 3250, San Martín de Porres','2026-10-18 09:15:00',1),
(59,'DNI','73816427','Eliana Rosario','Dávila Pineda','971438625','eliana.davila.p@outlook.com','Jr. Manco Cápac 860, La Victoria','2026-10-18 10:00:00',1),
(60,'DNI','48172693','Francisco Daniel','Valencia Guerra','965731824','fvalencia.guerra@gmail.com','Av. La Paz 920, San Miguel','2026-10-18 10:45:00',1),
(61,'DNI','74631982','Milagros Estefanía','Cruz Hidalgo','938416275','milagros.cruz.h@gmail.com','Calle Los Claveles 340, Lince','2026-10-18 11:20:00',1),
(62,'DNI','71257439','Álvaro Ignacio','Montoya Salas','987642135','amontoya.salas@hotmail.com','Av. Túpac Amaru 2740, Comas','2026-10-18 12:05:00',1),
(63,'DNI','43928175','Teresa del Pilar','García Villanueva','954273681','teresa.garcia.v@gmail.com','Jr. Sucre 540, Pueblo Libre','2026-10-18 13:10:00',1),
(64,'DNI','77519324','Santiago Rafael','Herrera Cueva','972645318','sherrera.cueva@gmail.com','Calle Las Acacias 230, Surco','2026-10-18 14:00:00',1),
(65,'DNI','46274831','Alejandra Nicole','Bautista Rojas','963817245','alejandra.bautista@outlook.com','Av. Los Alisos 1840, Los Olivos','2026-10-18 14:40:00',1),
(66,'DNI','79416285','Raúl Enrique','Delgado Poma','985472316','rdelgado.poma@gmail.com','Jr. Zepita 372, Callao','2026-10-18 15:20:00',1),
(67,'DNI','41834972','María Fernanda','Velásquez Prado','941635827','mvelasquez.prado@gmail.com','Av. Separadora Industrial 1420, La Molina','2026-10-18 16:00:00',1),
(68,'DNI','45271386','Julio César','Molina Arce','976825143','jmolina.arce@hotmail.com','Calle San Martín 415, Barranco','2026-10-18 16:35:00',1),
(69,'DNI','48392647','Lorena Beatriz','Pacheco Vidal','958371426','lorena.pacheco.v@gmail.com','Av. Alfredo Mendiola 3860, Independencia','2026-10-18 17:10:00',1),
(70,'DNI','72485931','Esteban Mauricio','Fuentes Alvarado','982147536','efuentes.alvarado@gmail.com','Jr. Los Jazmines 268, Bellavista','2026-10-18 17:45:00',1),
(71,'DNI','76153729','Vanessa Katherine','Ortega Espino','947538162','vanessa.ortega.e@outlook.com','Av. José Pardo 780, Miraflores','2026-10-18 18:15:00',1),
(72,'DNI','49728416','Sebastián Adrián','Núñez Salazar','971825463','snunez.salazar@gmail.com','Calle Las Begonias 385, San Isidro','2026-10-18 18:50:00',1);
/*!40000 ALTER TABLE `tbl_cliente` ENABLE KEYS */;
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
