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
-- Table structure for table `tbl_historia_clinica`
--

DROP TABLE IF EXISTS `tbl_historia_clinica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_historia_clinica` (
  `id_historia` bigint NOT NULL AUTO_INCREMENT,
  `id_mascota` bigint NOT NULL,
  `id_atencion` bigint DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `anamnesis` text COLLATE utf8mb4_unicode_ci,
  `signos_clinicos` text COLLATE utf8mb4_unicode_ci,
  `diagnostico` text COLLATE utf8mb4_unicode_ci,
  `tratamiento` text COLLATE utf8mb4_unicode_ci,
  `indicaciones` text COLLATE utf8mb4_unicode_ci,
  `proximo_control` date DEFAULT NULL,
  PRIMARY KEY (`id_historia`),
  UNIQUE KEY `id_atencion` (`id_atencion`),
  KEY `fk_historia_mascota` (`id_mascota`),
  CONSTRAINT `fk_historia_atencion` FOREIGN KEY (`id_atencion`) REFERENCES `tbl_atencion` (`id_atencion`),
  CONSTRAINT `fk_historia_mascota` FOREIGN KEY (`id_mascota`) REFERENCES `tbl_mascota` (`id_mascota`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_historia_clinica`
--

LOCK TABLES `tbl_historia_clinica` WRITE;
/*!40000 ALTER TABLE `tbl_historia_clinica` DISABLE KEYS */;
INSERT INTO `tbl_historia_clinica` VALUES
(1,1,1,'2026-10-01 10:20:00','Propietario refiere prurito leve cuando come alimento con pollo. Viene para baño hipoalergénico y revisión de piel.','T° 38.4°C, FC 110 lpm, piel ligeramente seca en dorso sin lesiones activas.','Dermatitis alérgica alimentaria controlada','Baño con shampoo de avena y ácidos grasos esenciales.','Mantener alimento a base de cordero o salmón, no dar sobras de mesa.','2026-11-01'),
(2,2,2,'2026-10-01 11:50:00','Ingresa para higiene mensual y revisión general. Vive únicamente dentro de departamento.','T° 38.5°C, peso 3.60 kg, mucosas rosadas, dentadura limpia.','Paciente clínicamente sano','Higiene general, corte de puntas de uñas y limpieza de pabellones auriculares.','Cepillado 2 veces por semana en casa.','2026-11-05'),
(3,3,3,'2026-10-02 10:15:00','Viene a baño mensual; dueño nota que sacude un poco la cabeza después de nadar.','T° 38.6°C, peso 28.50 kg, leve secreción ceruminosa en conducto auditivo derecho.','Ceruminosis ótica leve en oído derecho','Limpieza con solución ceruminolítica Otiflex C.','Secar bien las orejas tras el baño y aplicar limpiador ótico 1 vez por semana.','2026-10-16'),
(4,4,4,'2026-10-02 11:45:00','Lagrimeo constante que mancha el pelaje debajo de los ojos.','T° 38.5°C, epífora bilateral por pelos largos en canto medial ocular, córnea intacta.','Epífora mecánica por roce de pelaje periocular','Despeje de pelo periocular e higiene con solución oftálmica estéril.','Limpiar contorno de ojos a diario con gasa húmeda.','2026-11-02'),
(5,5,5,'2026-10-03 10:05:00','Consulta de control general; ocasionalmente tose como queriendo expulsar pelos.','T° 38.3°C, peso 4.40 kg, auscultación cardiopulmonar normal, abdomen blando.','Tricobezoares (bolas de pelo) leves','Pasta de malta felina 2 cm vía oral 3 veces por semana.','Aumentar cepillado y asegurar agua fresca disponible.','2026-11-15'),
(6,6,6,'2026-10-03 12:30:00','Enrojecimiento y humedad en los pliegues de la cara desde hace 4 días.','T° 38.6°C, eritema moderado en pliegue nasal e interdigital.','Intertrigo (dermatitis de pliegues cutáneos)','Baño medicado con clorhexidina al 4% y crema tópica antibacteriana por 5 días.','Limpiar y secar bien los pliegues faciales todos los días.','2026-10-17'),
(7,7,7,'2026-10-04 10:20:00','Traída para baño y corte; nudos pequeños detrás de las orejas.','T° 38.4°C, peso 4.80 kg, piel sin ectoparásitos.','Paciente clínicamente sano','Grooming completo y aplicación de acondicionador.','Peinar con carda suave interdiario.','2026-11-04'),
(8,8,8,'2026-10-04 11:20:00','Estornudos ocasionales por las mañanas desde hace 2 días; come y juega normal.','T° 38.6°C, secreción nasal serosa transparente escasa, pulmones limpios.','Rinitis catarral leve por cambio de temperatura','Limpieza nasal con suero fisiológico tibio y lisina oral por 7 días.','Evitar corrientes de aire frío; acudir si aparece secreción espesa.','2026-10-18'),
(9,9,9,'2026-10-05 10:15:00','Rasca mucho la oreja izquierda y llora al tocarle la base de la oreja.','T° 38.8°C, conducto auditivo eritematoso con exudado marrón y olor característico.','Otitis externa por Malassezia','Lavado ótico en consultorio y gotas Posatex cada 24h por 7 días.','Colocar collar isabelino si intenta rascarse y regresar a control.','2026-10-15'),
(10,10,10,'2026-10-05 13:10:00','Muda abundante de pelo por cambio de estación.','T° 38.5°C, peso 24.00 kg, pelaje denso sin zonas alopécicas.','Muda estacional fisiológica','Deslanado profundo y suplemento de Omega 3 y 6.','Continuar con cepillado semanal.','2026-11-10'),
(11,11,11,'2026-10-06 10:30:00','Viene para baño especializado felino y control de peso.','T° 38.4°C, peso 3.90 kg, condición corporal óptima.','Paciente clínicamente sano','Baño felino y limpieza de lagrimales.','Mantener cepillado diario del manto persa.','2026-11-06'),
(12,12,12,'2026-10-06 12:00:00','Control dermatológico rutinario y baño medicado.','T° 38.5°C, peso 8.30 kg, respiración típica de raza sin disnea.','Pioderma superficial controlada','Baño con shampoo de peróxido de benzoilo y limpieza de arrugas.','Evitar paseos en horas de mucho sol.','2026-11-06'),
(13,13,13,'2026-10-07 10:05:00','Se le encontraron pulgas tras jugar con otros perros en el parque.','T° 38.6°C, presencia moderada de Ctenocephalides canis en región lumbosacra.','Pulicosis (infestación por pulgas)','Baño antipulgas y aplicación de tableta masticable Simparica.','Aspirar camas y mantas en casa.','2026-11-07'),
(14,14,14,'2026-10-07 11:30:00','Molestia al sentarse y arrastrar la cadera en el piso.','T° 38.5°C, sacos anales distendidos con contenido espeso.','Impactación leve de glándulas perianales','Vaciado manual de glándulas anales durante el baño.','Agregar fibra moderada a la dieta.','2026-11-07'),
(15,15,15,'2026-10-08 10:10:00','Vomitó una bola de pelo ayer por la mañana; ánimo y apetito conservados.','T° 38.4°C, peso 4.50 kg, mucosa oral rosada, hidratación normal.','Gastritis leve por tricobezoares','Protector gástrico por 3 días y malta felina.','Fraccionar la ración diaria de alimento.','2026-10-22'),
(16,16,16,'2026-10-08 12:45:00','Control de peso y baño mensual.','T° 38.3°C, peso 31.20 kg, condición corporal 4/5 (ligero sobrepeso).','Sobrepeso leve','Baño de mantenimiento y ajuste de ración calórica diaria.','Caminatas de 30 minutos dos veces al día.','2026-11-08'),
(17,17,17,'2026-10-09 10:00:00','Higiene mensual y corte de uñas porque resbala en el piso.','T° 38.7°C, peso 6.70 kg, uñas largas sin lesión en pulpejos.','Crecimiento excesivo de uñas','Corte de uñas, limado y baño básico.','Pasear en superficie de cemento para desgaste natural.','2026-11-09'),
(18,18,18,'2026-10-09 11:00:00','Toca desparasitación trimestral preventiva.','T° 38.5°C, peso 3.80 kg, abdomen blando y depresible.','Control antiparasitario preventivo','Administración de Drontal Gatos según peso.','Repetir desparasitación cada 3 meses.','2027-01-09'),
(19,19,19,'2026-10-10 10:15:00','Eritema y picazón en el vientre después de cambiar de marca de croquetas.','T° 38.6°C, máculas eritematosas en abdomen ventral sin pústulas.','Dermatitis alérgica por contacto / alimentaria','Prednisolona dosis antiinflamatoria por 5 días y retorno a dieta hipoalergénica.','No introducir nuevos premios o galletas durante el tratamiento.','2026-10-20'),
(20,20,20,'2026-10-10 12:40:00','Baño sanitario y revisión de codos por callos de apoyo.','T° 38.4°C, peso 33.50 kg, hiperqueratosis leve en ambos codos.','Callos de decúbito en codos','Baño completo y aplicación de crema hidratante con urea en codos.','Proporcionar colchoneta acolchada para dormir.','2026-11-10');
/*!40000 ALTER TABLE `tbl_historia_clinica` ENABLE KEYS */;
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
