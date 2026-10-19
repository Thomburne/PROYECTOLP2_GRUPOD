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
-- Table structure for table `tbl_esterilizacion`
--

DROP TABLE IF EXISTS `tbl_esterilizacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_esterilizacion` (
  `id_esterilizacion` bigint NOT NULL AUTO_INCREMENT,
  `id_atencion` bigint NOT NULL,
  `fecha_procedimiento` date NOT NULL,
  `evaluacion_preoperatoria` text COLLATE utf8mb4_unicode_ci,
  `consentimiento_registrado` tinyint(1) NOT NULL DEFAULT '0',
  `descripcion_procedimiento` text COLLATE utf8mb4_unicode_ci,
  `indicaciones_postoperatorias` text COLLATE utf8mb4_unicode_ci,
  `fecha_control` date DEFAULT NULL,
  `estado` enum('PROGRAMADA','REALIZADA','CANCELADA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PROGRAMADA',
  PRIMARY KEY (`id_esterilizacion`),
  UNIQUE KEY `id_atencion` (`id_atencion`),
  CONSTRAINT `fk_esterilizacion_atencion` FOREIGN KEY (`id_atencion`) REFERENCES `tbl_atencion` (`id_atencion`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_esterilizacion`
--

LOCK TABLES `tbl_esterilizacion` WRITE;
/*!40000 ALTER TABLE `tbl_esterilizacion` DISABLE KEYS */;
INSERT INTO `tbl_esterilizacion` VALUES
(1,41,'2026-09-10','Hemograma y creatinina normales. Ayuno de 10 horas confirmado, ASA I.',1,'Orquiectomía preescrotal cerrada, ligadura con ácido poliglicólico 3-0 y sutura intradérmica.','Meloxicam cada 24h por 3 días, limpieza con clorhexidina y collar isabelino permanente.','2026-09-17','REALIZADA'),
(2,42,'2026-09-11','Examen clínico y perfil básico dentro de rangos. Mucosas rosadas, T° 38.4°C.',1,'Ovariohisterectomía felina por línea media ventral con incisión de 2 cm y triple ligadura.','Faja postoperatoria por 7 días, analgésico oral por 3 días y reposo en ambiente cerrado.','2026-09-18','REALIZADA'),
(3,43,'2026-09-12','Perfil prequirúrgico sin alteraciones. Hidratación normal, peso 28.50 kg.',1,'Orquiectomía canina bajo anestesia general inhalatoria, hemostasia controlada.','Amoxicilina con ácido clavulánico cada 12h por 5 días y uso de collar isabelino.','2026-09-19','REALIZADA'),
(4,44,'2026-09-14','Evaluación preanestésica favorable, tiempos de coagulación normales.',1,'Ovariohisterectomía canina sin complicaciones, cierre por planos con sutura absorbible.','Curación diaria con gasa estéril, meloxicam por 4 días y retiro de puntos en 7 días.','2026-09-21','REALIZADA'),
(5,45,'2026-09-15','Ayuno de 8 horas verificado, auscultación cardiopulmonar limpia.',1,'Orquiectomía felina bilateral con nudo biológico, sin puntos externos.','Usar arena sanitaria de papel o pellets por 4 días para evitar contaminación.','2026-09-22','REALIZADA'),
(6,46,'2026-09-16','Evaluación preoperatoria especial para raza braquicéfala; preoxigenación 10 min.',1,'Orquiectomía cerrada con intubación endotraqueal y monitoreo multiparámetro continuo.','Mantener en ambiente fresco, collar isabelino blando y control en una semana.','2026-09-23','REALIZADA'),
(7,47,'2026-09-17','Hemograma completo normal (Hto 44%, plaquetas normales). Ayuno cumplido.',1,'Ovariohisterectomía convencional, sangrado mínimo y recuperación rápida.','Faja quirúrgica limpia, antibiótico oral por 5 días y evitar subir escaleras.','2026-09-24','REALIZADA'),
(8,48,'2026-09-18','Constantes fisiológicas dentro de parámetros normales. ASA I.',1,'Orquiectomía felina bajo sedación disociativa y analgesia multimodal.','Observación en casa, dieta blanda hoy por la noche y control en 7 días.','2026-09-25','REALIZADA'),
(9,49,'2026-09-19','Perfil renal y hepático normales. Paciente tranquila en preanestesia.',1,'Ovariohisterectomía canina mediana, ligadura de pedículos ováricos con PGA 2-0.','Collar isabelino obligatorio, curación diaria de herida y analgésicos por 4 días.','2026-09-26','REALIZADA'),
(10,50,'2026-09-21','Exámenes sanguíneos preoperatorios conformes. Peso 24.00 kg.',1,'Orquiectomía preescrotal canina, cierre subcutáneo y puntos simples en piel.','Paseos cortos solo con correa, no correr ni saltar hasta el retiro de puntos.','2026-09-28','REALIZADA'),
(11,51,'2026-09-22','Evaluación física y hemograma sin observaciones. Ayuno de 10 horas.',1,'Ovariohisterectomía felina con tricotomía amplia y sutura intradérmica.','Mantener faja postoperatoria seca y limpia; administrar analgésico en gotas.','2026-09-29','REALIZADA'),
(12,52,'2026-09-23','Protocolo preanestésico para braquicéfalo, vías aéreas despejadas.',1,'Orquiectomía canina con isoflurano, extubación tardía sin incidentes.','Vigilancia en casa las primeras 12 horas, collar protector y medicación oral.','2026-09-30','REALIZADA'),
(13,53,'2026-09-24','Hemograma normal, negativo a hemoparásitos (test 4Dx negativo).',1,'Orquiectomía canina estándar, excelente hemostasia.','Limpiar herida 2 veces al día con clorhexidina en spray y usar collar isabelino.','2026-10-01','REALIZADA'),
(14,54,'2026-09-25','Paciente de 2.90 kg, glucemia y hematocrito normales.',1,'Ovariohisterectomía de mínima incisión con soporte térmico intraoperatorio.','Abrigar bien hoy, ofrecer agua y comida blanda en pequeñas porciones.','2026-10-02','REALIZADA'),
(15,55,'2026-09-26','Examen prequirúrgico normal, mucosas rosadas, T° 38.5°C.',1,'Orquiectomía felina ambulatoria sin complicaciones.','Reposo en casa por 3 días y evitar que se lama la zona escrotal.','2026-10-03','REALIZADA'),
(16,56,'2026-09-27','Perfil preoperatorio de adulto conforme, función renal normal.',1,'Orquiectomía canina con ligadura transfixiante y cierre en tres planos.','Antibiótico y antiinflamatorio según receta; acudir para retiro de puntos.','2026-10-04','REALIZADA'),
(17,57,'2026-09-28','Constantes vitales normales, ayuno de sólidos y líquidos cumplido.',1,'Orquiectomía canina cerrada sin eventualidades.','Reposo relativo en casa y uso estricto del collar isabelino.','2026-10-05','REALIZADA'),
(18,58,'2026-09-29','Gato joven de 8 meses, examen físico y hemograma normales.',1,'Orquiectomía felina bilateral rápida bajo sedación y bloqueo local.','No requiere retiro de puntos; vigilar apetito y micción normal.','2026-10-06','REALIZADA'),
(19,59,'2026-09-30','Hemograma y bioquímica normales, peso 10.80 kg.',1,'Ovariohisterectomía canina por línea media, sin sangrado residual.','Faja postquirúrgica y curación diaria con antiséptico tópico.','2026-10-07','REALIZADA'),
(20,60,'2026-10-01','Evaluación clínica preoperatoria apta para campaña de esterilización.',1,'Ovariohisterectomía canina con sutura absorbible y tatuaje pequeño de control.','Cuidados en el albergue con jaula limpia, analgésico por 3 días y control en 7 días.','2026-10-08','REALIZADA');
/*!40000 ALTER TABLE `tbl_esterilizacion` ENABLE KEYS */;
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
