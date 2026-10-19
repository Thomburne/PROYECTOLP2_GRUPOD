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
-- Table structure for table `tbl_cita`
--

DROP TABLE IF EXISTS `tbl_cita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_cita` (
  `id_cita` bigint NOT NULL AUTO_INCREMENT,
  `id_mascota` bigint NOT NULL,
  `id_servicio` bigint NOT NULL,
  `id_usuario` bigint DEFAULT NULL,
  `fecha_hora` datetime NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDIENTE',
  `motivo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `servicio` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CONSULTA',
  PRIMARY KEY (`id_cita`),
  KEY `fk_cita_mascota` (`id_mascota`),
  KEY `fk_cita_servicio` (`id_servicio`),
  KEY `fk_cita_usuario` (`id_usuario`),
  KEY `idx_cita_fecha` (`fecha_hora`),
  KEY `idx_cita_estado` (`estado`),
  CONSTRAINT `fk_cita_mascota` FOREIGN KEY (`id_mascota`) REFERENCES `tbl_mascota` (`id_mascota`),
  CONSTRAINT `fk_cita_servicio` FOREIGN KEY (`id_servicio`) REFERENCES `tbl_servicio` (`id_servicio`),
  CONSTRAINT `fk_cita_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_cita`
--

LOCK TABLES `tbl_cita` WRITE;
/*!40000 ALTER TABLE `tbl_cita` DISABLE KEYS */;
INSERT INTO `tbl_cita` VALUES
(1,1,6,2,'2026-10-01 09:30:00','ATENDIDA','Baño y corte estilo schnauzer','Usar shampoo hipoalergénico, cliente recoge a las 12:00','2026-09-29 10:15:00','2026-09-29 10:15:00','BANIO'),
(2,2,8,3,'2026-10-01 11:00:00','ATENDIDA','Baño higiénico y corte de puntas de uñas','Se portó tranquila durante el secado','2026-09-29 11:20:00','2026-09-29 11:20:00','BANIO'),
(3,3,4,4,'2026-10-02 09:00:00','ATENDIDA','Baño mensual y limpieza de oídos','Se encontró leve cerumen en oído derecho','2026-09-30 09:40:00','2026-09-30 09:40:00','BANIO'),
(4,4,6,5,'2026-10-02 10:30:00','ATENDIDA','Baño y recorte de pelo alrededor de los ojos','Lavar con espuma suave en el rostro','2026-09-30 14:10:00','2026-09-30 14:10:00','BANIO'),
(5,5,20,6,'2026-10-03 09:30:00','ATENDIDA','Chequeo general y control de peso','Buen estado corporal, se recomendó pasta para bolas de pelo','2026-10-01 10:00:00','2026-10-01 10:00:00','CONSULTA'),
(6,6,5,7,'2026-10-03 11:30:00','ATENDIDA','Baño medicado por enrojecimiento en pliegues','Dejar actuar clorhexidina por 10 minutos antes de enjuagar','2026-10-01 15:30:00','2026-10-01 15:30:00','BANIO'),
(7,7,6,8,'2026-10-04 09:00:00','ATENDIDA','Baño y corte estilo cachorro','Tenía algunos nudos detrás de las orejas','2026-10-02 09:15:00','2026-10-02 09:15:00','BANIO'),
(8,8,20,9,'2026-10-04 10:45:00','ATENDIDA','Consulta por estornudos frecuentes','Temperatura normal, cambio brusco de clima','2026-10-02 12:00:00','2026-10-02 12:00:00','CONSULTA'),
(9,9,21,10,'2026-10-05 09:30:00','ATENDIDA','Revisión por sacudida de cabeza y picazón en oreja','Se realizó limpieza ótica profunda en consultorio','2026-10-03 11:05:00','2026-10-03 11:05:00','CONSULTA'),
(10,10,9,11,'2026-10-05 11:30:00','ATENDIDA','Deslanado completo por cambio de pelaje','Salió bastante subpelo, quedó bien cepillado','2026-10-03 16:40:00','2026-10-03 16:40:00','BANIO'),
(11,11,8,12,'2026-10-06 09:30:00','ATENDIDA','Baño y desenredado de manto largo','Se recomendó cepillado diario en casa','2026-10-04 10:25:00','2026-10-04 10:25:00','BANIO'),
(12,12,5,13,'2026-10-06 11:00:00','ATENDIDA','Baño medicado y limpieza de arrugas faciales','Secado con aire tibio a baja velocidad','2026-10-04 14:50:00','2026-10-04 14:50:00','BANIO'),
(13,13,7,14,'2026-10-07 09:00:00','ATENDIDA','Baño antipulgas después de paseo en parque','Se aplicó además pipeta externa','2026-10-05 09:30:00','2026-10-05 09:30:00','BANIO'),
(14,14,1,15,'2026-10-07 10:30:00','ATENDIDA','Baño básico y limpieza de glándulas','Se colocó lazo rosado a pedido de la dueña','2026-10-05 15:10:00','2026-10-05 15:10:00','BANIO'),
(15,15,20,2,'2026-10-08 09:30:00','ATENDIDA','Evaluación por vómito de bolas de pelo','Se recetó malta felina 3 veces por semana','2026-10-06 10:00:00','2026-10-06 10:00:00','CONSULTA'),
(16,16,4,3,'2026-10-08 11:30:00','ATENDIDA','Baño de mantenimiento y recorte higiénico','Perro muy colaborador en la bañera','2026-10-06 16:20:00','2026-10-06 16:20:00','BANIO'),
(17,17,1,4,'2026-10-09 09:00:00','ATENDIDA','Baño básico y corte de uñas','Un poco inquieto al momento de secar las patas','2026-10-07 09:45:00','2026-10-07 09:45:00','BANIO'),
(18,18,23,5,'2026-10-09 10:30:00','ATENDIDA','Desparasitación interna trimestral','Tomó la tableta sin problemas con comida húmeda','2026-10-07 14:30:00','2026-10-07 14:30:00','OTRO'),
(19,19,21,6,'2026-10-10 09:30:00','ATENDIDA','Consulta por alergia en abdomen y patas','Se indicó cambio a alimento hipoalergénico','2026-10-08 11:15:00','2026-10-08 11:15:00','CONSULTA'),
(20,20,4,7,'2026-10-10 11:30:00','ATENDIDA','Baño sanitario y cepillado de manto','Ingresó con su propietario hasta el área de recepción','2026-10-08 17:00:00','2026-10-08 17:00:00','BANIO'),
(21,1,2,2,'2026-10-11 09:00:00','ATENDIDA','Refuerzo anual de vacuna séxtuple','Signos vitales normales previo a la aplicación','2026-10-09 09:20:00','2026-10-09 09:20:00','VACUNACION'),
(22,2,13,3,'2026-10-11 10:00:00','ATENDIDA','Refuerzo anual de vacuna triple felina','Se selló carnet de vacunación','2026-10-09 10:40:00','2026-10-09 10:40:00','VACUNACION'),
(23,3,11,4,'2026-10-11 11:00:00','ATENDIDA','Vacunación antirrábica anual','Se entregó certificado de vacunación vigente','2026-10-09 12:10:00','2026-10-09 12:10:00','VACUNACION'),
(24,4,12,5,'2026-10-11 12:00:00','ATENDIDA','Aplicación de vacuna KC contra tos de las perreras','Aplicación intranasal sin molestias','2026-10-09 15:00:00','2026-10-09 15:00:00','VACUNACION'),
(25,5,13,6,'2026-10-12 09:00:00','ATENDIDA','Vacuna triple felina anual','Afebril, peso 4.40 kg','2026-10-10 09:30:00','2026-10-10 09:30:00','VACUNACION'),
(26,6,2,7,'2026-10-12 10:00:00','ATENDIDA','Vacuna séxtuple anual','Propietario informado sobre posible somnolencia leve','2026-10-10 11:15:00','2026-10-10 11:15:00','VACUNACION'),
(27,7,11,8,'2026-10-12 11:00:00','ATENDIDA','Vacuna antirrábica de control anual','Sin reacciones adversas','2026-10-10 14:20:00','2026-10-10 14:20:00','VACUNACION'),
(28,8,14,9,'2026-10-12 12:00:00','ATENDIDA','Dosis anual contra leucemia felina','Test rápido previo negativo','2026-10-10 16:05:00','2026-10-10 16:05:00','VACUNACION'),
(29,9,10,10,'2026-10-13 09:00:00','ATENDIDA','Refuerzo de vacuna quíntuple canina','Paciente en óptimas condiciones','2026-10-11 09:10:00','2026-10-11 09:10:00','VACUNACION'),
(30,10,11,11,'2026-10-13 10:00:00','ATENDIDA','Vacuna antirrábica anual','Aplicada en región escapular derecha','2026-10-11 10:45:00','2026-10-11 10:45:00','VACUNACION'),
(31,11,13,12,'2026-10-13 11:00:00','ATENDIDA','Refuerzo triple felina','Se recomendó no bañar por 7 días','2026-10-11 12:30:00','2026-10-11 12:30:00','VACUNACION'),
(32,12,2,13,'2026-10-13 12:00:00','ATENDIDA','Vacuna séxtuple anual','Temperatura 38.4°C, apto para inmunización','2026-10-11 15:15:00','2026-10-11 15:15:00','VACUNACION'),
(33,13,2,14,'2026-10-14 09:00:00','ATENDIDA','Vacunación séxtuple y control general','Se actualizó libreta sanitaria','2026-10-12 09:00:00','2026-10-12 09:00:00','VACUNACION'),
(34,14,12,15,'2026-10-14 10:00:00','ATENDIDA','Vacuna contra tos de las perreras (KC)','Requerida antes de ingresar a hospedaje canino','2026-10-12 10:30:00','2026-10-12 10:30:00','VACUNACION'),
(35,15,11,2,'2026-10-14 11:00:00','ATENDIDA','Vacuna antirrábica felina','Gato tranquilo durante la consulta','2026-10-12 11:45:00','2026-10-12 11:45:00','VACUNACION'),
(36,16,2,3,'2026-10-14 12:00:00','ATENDIDA','Refuerzo anual séxtuple','Sin novedades clínicas','2026-10-12 14:10:00','2026-10-12 14:10:00','VACUNACION'),
(37,17,10,4,'2026-10-15 09:00:00','ATENDIDA','Vacuna quíntuple anual','Se aplicó sin inconvenientes','2026-10-13 09:25:00','2026-10-13 09:25:00','VACUNACION'),
(38,18,13,5,'2026-10-15 10:00:00','ATENDIDA','Primera vacuna triple felina anual','Próximo refuerzo programado en un año','2026-10-13 11:00:00','2026-10-13 11:00:00','VACUNACION'),
(39,19,11,6,'2026-10-15 11:00:00','ATENDIDA','Vacunación antirrábica anual','Todo conforme en la evaluación previa','2026-10-13 15:40:00','2026-10-13 15:40:00','VACUNACION'),
(40,20,2,7,'2026-10-15 12:00:00','ATENDIDA','Refuerzo séxtuple canina','Control anual completado','2026-10-13 17:10:00','2026-10-13 17:10:00','VACUNACION'),
(41,1,19,2,'2026-09-10 08:30:00','ATENDIDA','Cirugía de castración programada','Ingresó con 10 horas de ayuno y exámenes prequirúrgicos','2026-09-05 10:00:00','2026-09-05 10:00:00','ESTERILIZACION'),
(42,2,16,3,'2026-09-11 08:30:00','ATENDIDA','Esterilización felina programada','Consentimiento informado firmado por la propietaria','2026-09-06 11:00:00','2026-09-06 11:00:00','ESTERILIZACION'),
(43,3,19,4,'2026-09-12 08:30:00','ATENDIDA','Castración canina','Alta médica en la tarde con collar isabelino','2026-09-07 09:30:00','2026-09-07 09:30:00','ESTERILIZACION'),
(44,4,3,5,'2026-09-14 08:30:00','ATENDIDA','Esterilización canina raza pequeña','Recuperación anestésica favorable','2026-09-09 14:20:00','2026-09-09 14:20:00','ESTERILIZACION'),
(45,5,17,6,'2026-09-15 08:30:00','ATENDIDA','Castración de gato macho','Procedimiento rápido sin complicaciones','2026-09-10 10:15:00','2026-09-10 10:15:00','ESTERILIZACION'),
(46,6,19,7,'2026-09-16 08:30:00','ATENDIDA','Castración preventiva','Monitoreo respiratorio continuo por ser braquicéfalo','2026-09-11 11:40:00','2026-09-11 11:40:00','ESTERILIZACION'),
(47,7,3,8,'2026-09-17 08:30:00','ATENDIDA','Cirugía de esterilización canina','Se envió receta de analgésicos por 4 días','2026-09-12 16:00:00','2026-09-12 16:00:00','ESTERILIZACION'),
(48,8,17,9,'2026-09-18 08:30:00','ATENDIDA','Castración felina','Despertó tranquilo de la sedación','2026-09-13 09:50:00','2026-09-13 09:50:00','ESTERILIZACION'),
(49,9,18,10,'2026-09-19 08:30:00','ATENDIDA','Esterilización canina mediana','Hemograma previo dentro de valores normales','2026-09-14 12:10:00','2026-09-14 12:10:00','ESTERILIZACION'),
(50,10,19,11,'2026-09-21 08:30:00','ATENDIDA','Castración canina programada','Control de puntos en 7 días','2026-09-16 15:30:00','2026-09-16 15:30:00','ESTERILIZACION'),
(51,11,16,12,'2026-09-22 08:30:00','ATENDIDA','Esterilización de gata persa','Se colocó faja postoperatoria','2026-09-17 10:20:00','2026-09-17 10:20:00','ESTERILIZACION'),
(52,12,19,13,'2026-09-23 08:30:00','ATENDIDA','Castración con anestesia inhalatoria','Excelente recuperación postquirúrgica','2026-09-18 11:00:00','2026-09-18 11:00:00','ESTERILIZACION'),
(53,13,19,14,'2026-09-24 08:30:00','ATENDIDA','Castración de perro adoptado','Propietaria firmó autorización en recepción','2026-09-19 14:45:00','2026-09-19 14:45:00','ESTERILIZACION'),
(54,14,3,15,'2026-09-25 08:30:00','ATENDIDA','Esterilización canina laparoscópica/mínima incisión','Incisión pequeña de 2 cm, mínimo dolor','2026-09-20 09:15:00','2026-09-20 09:15:00','ESTERILIZACION'),
(55,15,17,2,'2026-09-26 08:30:00','ATENDIDA','Castración felina ambulatoria','Entregado a las 14:00 completamente despierto','2026-09-21 16:30:00','2026-09-21 16:30:00','ESTERILIZACION'),
(56,16,19,3,'2026-09-27 08:30:00','ATENDIDA','Castración de perro adulto','Perfil bioquímico preoperatorio conforme','2026-09-22 10:50:00','2026-09-22 10:50:00','ESTERILIZACION'),
(57,17,19,4,'2026-09-28 08:30:00','ATENDIDA','Castración por marcaje de territorio','Se indicó reposo relativo por 5 días','2026-09-23 11:25:00','2026-09-23 11:25:00','ESTERILIZACION'),
(58,18,17,5,'2026-09-29 08:30:00','ATENDIDA','Castración felina joven','Sin sangrado, no requiere retiro de puntos','2026-09-24 15:00:00','2026-09-24 15:00:00','ESTERILIZACION'),
(59,19,18,6,'2026-09-30 08:30:00','ATENDIDA','Esterilización canina programada','Cirugía limpia, se entregó hoja de cuidados','2026-09-25 09:40:00','2026-09-25 09:40:00','ESTERILIZACION'),
(60,21,3,7,'2026-10-01 08:30:00','ATENDIDA','Esterilización campaña albergue','Tarifa social aplicada, evolución favorable','2026-09-28 12:00:00','2026-09-28 12:00:00','ESTERILIZACION'),
(61,22,13,8,'2026-10-20 10:00:00','CONFIRMADA','Refuerzo anual de vacuna triple felina','Cliente confirmó asistencia por WhatsApp','2026-10-14 11:20:00','2026-10-14 11:20:00','VACUNACION'),
(62,23,20,9,'2026-10-22 16:00:00','PENDIENTE','Revisión de bulto pequeño en pata delantera','Traer resultados de hemograma anterior','2026-10-15 09:45:00','2026-10-15 09:45:00','CONSULTA'),
(63,25,6,10,'2026-10-24 11:00:00','CONFIRMADA','Baño con agua tibia y recorte de pelo','Cuidado especial por antecedente de soplo leve','2026-10-15 17:10:00','2026-10-15 17:10:00','BANIO');
/*!40000 ALTER TABLE `tbl_cita` ENABLE KEYS */;
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
