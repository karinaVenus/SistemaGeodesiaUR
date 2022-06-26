-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acceso`
--

DROP TABLE IF EXISTS `acceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acceso` (
  `id` bigint(20) unsigned NOT NULL,
  `id_almacen` int(11) NOT NULL,
  `estado` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `id_almacen` (`id_almacen`),
  CONSTRAINT `acceso_ibfk_1` FOREIGN KEY (`id`) REFERENCES `permissions` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `acceso_ibfk_2` FOREIGN KEY (`id_almacen`) REFERENCES `almacen` (`cod_almacen`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acceso`
--

LOCK TABLES `acceso` WRITE;
/*!40000 ALTER TABLE `acceso` DISABLE KEYS */;
INSERT INTO `acceso` VALUES (51,1,''),(52,2,''),(63,19,'');
/*!40000 ALTER TABLE `acceso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `almacen`
--
DROP TABLE IF EXISTS `almacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `almacen` (
  `cod_almacen` int(11) NOT NULL AUTO_INCREMENT,
  `des_almacen` varchar(45) DEFAULT NULL,
  `cod_estado_almacen` int(11) DEFAULT 1,
  `ubic_almacen` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`cod_almacen`),
  KEY `fk_alm_estado_idx` (`cod_estado_almacen`),
  CONSTRAINT `fk_alm_estado` FOREIGN KEY (`cod_estado_almacen`) REFERENCES `estado_almacen` (`cod_estado_almacen`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `almacen`
--

LOCK TABLES `almacen` WRITE;
/*!40000 ALTER TABLE `almacen` DISABLE KEYS */;
INSERT INTO `almacen` VALUES (1,'Almacen Central-Lima',1,'Lima'),(2,'Puno Puno',1,'Puno urld direccion.com'),(19,'Loreto',1,'Loreto.com');
/*!40000 ALTER TABLE `almacen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articulo`
--

DROP TABLE IF EXISTS `articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articulo` (
  `cod_art` varchar(12) NOT NULL,
  `des_art` varchar(50) DEFAULT NULL,
  `cod_cat` int(11) DEFAULT NULL,
  `cod_pres` int(11) DEFAULT NULL,
  `cod_unid_med` int(11) DEFAULT NULL,
  `stock_art` int(11) DEFAULT 0,
  `imagen_art` varchar(200) DEFAULT NULL,
  `cod_estado_art` int(11) DEFAULT 1,
  PRIMARY KEY (`cod_art`),
  KEY `fk_art_pres_idx` (`cod_pres`),
  KEY `fk_art_unid_med_idx` (`cod_unid_med`),
  KEY `fk_art_cat_idx` (`cod_cat`),
  KEY `fk_art_est_idx` (`cod_estado_art`),
  CONSTRAINT `fk_art_cat` FOREIGN KEY (`cod_cat`) REFERENCES `categoria` (`cod_cat`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_art_est` FOREIGN KEY (`cod_estado_art`) REFERENCES `estado_articulo` (`cod_estado_art`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_art_pres` FOREIGN KEY (`cod_pres`) REFERENCES `presentacion` (`cod_pres`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_art_unid_med` FOREIGN KEY (`cod_unid_med`) REFERENCES `unid_med` (`cod_unid_med`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulo`
--

LOCK TABLES `articulo` WRITE;
/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
INSERT INTO `articulo` VALUES ('art-09','pintura',3,1,2,0,'https://www.google.com/search?q=pintura+azul&tbm=isch&ved=2a',1),('ART01','cinta de tela',2,1,1,201,'img.jpg',1),('ART02','cinta metrica',2,1,1,193,'img1.jpg',1),('ART03','sierra electrica',1,1,1,149,'img3.jpg',1),('ART04','cartulina de correspum',1,3,1,35,'img4.jpg',1),('ART05','acuarela de tiza',3,1,1,0,'img5.jpg',1),('ART06','silla',3,1,1,0,'img6.jpg',1),('ART07','laptop hp',2,1,1,0,'img7.jpg',1),('ART08','auriculares de sonido',2,3,2,0,'img8.jpg',1),('ART09','mesa de madera',2,1,1,0,'img9.jpg',1),('ART10','teclado gamer',3,3,1,0,'img10.jpg',1),('ART123','lapiz 2b',2,1,1,0,'https://images.utilex.pe/002137/450x450/lapiz-triangular-2b-amarillo-CYV3ACWJQUFTE.png',1);
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autorizar`
--

DROP TABLE IF EXISTS `autorizar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autorizar` (
  `id` bigint(20) unsigned DEFAULT NULL,
  KEY `autorizacion` (`id`),
  CONSTRAINT `autorizar_ibfk_1` FOREIGN KEY (`id`) REFERENCES `roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autorizar`
--

LOCK TABLES `autorizar` WRITE;
/*!40000 ALTER TABLE `autorizar` DISABLE KEYS */;
/*!40000 ALTER TABLE `autorizar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `cod_cat` int(11) NOT NULL AUTO_INCREMENT,
  `des_cat` varchar(45) DEFAULT NULL,
  `estado_cat` varchar(10) DEFAULT 'Activo',
  PRIMARY KEY (`cod_cat`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'cartulinas','Activo'),(2,'cintas de medir','Activo'),(3,'laminas',NULL),(4,'categoriaa12','Activo');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamento`
--

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departamento` (
  `cod_dpt` int(11) NOT NULL AUTO_INCREMENT,
  `des_dpt` varchar(15) DEFAULT NULL,
  `cod_postal` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`cod_dpt`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
INSERT INTO `departamento` VALUES (1,'Amazonas','01'),(2,'Ancash','02'),(3,'Apurimac','03'),(4,'Arequipa','04'),(5,'Ayacucho','05'),(6,'Cajamarca','06'),(7,'Cusco','08'),(8,'Huancavelica','09'),(9,'Huanuco','10'),(10,'Ica','11'),(11,'Junin','12'),(12,'La Libertad','13'),(13,'Lambayeque','14'),(14,'Lima','15'),(15,'Loreto','16'),(16,'Madre de Dios','17'),(17,'Moquegua','18'),(18,'Pasco','19'),(19,'Piura','20'),(20,'Puno','21'),(21,'San Martin','22'),(22,'Tacna','23'),(23,'Tumbes','24'),(24,'Ucayali','25');
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distrito`
--

DROP TABLE IF EXISTS `distrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distrito` (
  `cod_dist` int(11) NOT NULL AUTO_INCREMENT,
  `des_distrito` varchar(35) DEFAULT NULL,
  `cod_postal` varchar(5) DEFAULT NULL,
  `cod_provi` int(11) DEFAULT NULL,
  PRIMARY KEY (`cod_dist`),
  KEY `fk_dist_provi_idx` (`cod_provi`),
  CONSTRAINT `fk_dist_provi` FOREIGN KEY (`cod_provi`) REFERENCES `provincia` (`cod_provi`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distrito`
--

LOCK TABLES `distrito` WRITE;
/*!40000 ALTER TABLE `distrito` DISABLE KEYS */;
INSERT INTO `distrito` VALUES (1,'Ancon','02',9),(2,'Ate','03',9),(3,'Barranco','04',9),(4,'Breña','05',9),(5,'Carabayllo','06',9),(6,'Cercado de Lima','01',9),(7,'Chaclacayo','07',9),(8,'Chorrillos','08',9),(9,'Cieneguilla','09',9),(10,'Comas','10',9),(11,'El Agustino','11',9),(12,'Independencia','12',9),(13,'Jesus Maria','13',9),(14,'La Molina','14',9),(15,'La Victoria','15',9),(16,'Lince','16',9);
/*!40000 ALTER TABLE `distrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresa` (
  `cod_emp` int(11) NOT NULL,
  `logo` varchar(300) DEFAULT NULL,
  `estado_emp` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cod_emp`),
  CONSTRAINT `fk_emp_per` FOREIGN KEY (`cod_emp`) REFERENCES `persona` (`cod_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_almacen`
--

DROP TABLE IF EXISTS `estado_almacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado_almacen` (
  `cod_estado_almacen` int(11) NOT NULL AUTO_INCREMENT,
  `des_estado_almacen` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cod_estado_almacen`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_almacen`
--

LOCK TABLES `estado_almacen` WRITE;
/*!40000 ALTER TABLE `estado_almacen` DISABLE KEYS */;
INSERT INTO `estado_almacen` VALUES (1,'Activo'),(2,'Inactivo');
/*!40000 ALTER TABLE `estado_almacen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_articulo`
--

DROP TABLE IF EXISTS `estado_articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado_articulo` (
  `cod_estado_art` int(11) NOT NULL AUTO_INCREMENT,
  `des_estado_art` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cod_estado_art`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_articulo`
--

LOCK TABLES `estado_articulo` WRITE;
/*!40000 ALTER TABLE `estado_articulo` DISABLE KEYS */;
INSERT INTO `estado_articulo` VALUES (1,'Activo'),(2,'Inactivo');
/*!40000 ALTER TABLE `estado_articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_inventario`
--

DROP TABLE IF EXISTS `estado_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado_inventario` (
  `cod_estado_inv` int(11) NOT NULL AUTO_INCREMENT,
  `des_estado_inv` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cod_estado_inv`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_inventario`
--

LOCK TABLES `estado_inventario` WRITE;
/*!40000 ALTER TABLE `estado_inventario` DISABLE KEYS */;
INSERT INTO `estado_inventario` VALUES (1,'Activo'),(2,'Inactivo');
/*!40000 ALTER TABLE `estado_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_registro`
--

DROP TABLE IF EXISTS `estado_registro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado_registro` (
  `cod_estado_reg` int(11) NOT NULL AUTO_INCREMENT,
  `des_estado_reg` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cod_estado_reg`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_registro`
--

LOCK TABLES `estado_registro` WRITE;
/*!40000 ALTER TABLE `estado_registro` DISABLE KEYS */;
INSERT INTO `estado_registro` VALUES (1,'Activo'),(2,'Inactivo');
/*!40000 ALTER TABLE `estado_registro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_usuario`
--

DROP TABLE IF EXISTS `estado_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado_usuario` (
  `cod_estado_usu` int(11) NOT NULL AUTO_INCREMENT,
  `des_estado` varchar(20) NOT NULL,
  PRIMARY KEY (`cod_estado_usu`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_usuario`
--

LOCK TABLES `estado_usuario` WRITE;
/*!40000 ALTER TABLE `estado_usuario` DISABLE KEYS */;
INSERT INTO `estado_usuario` VALUES (1,'Activo'),(2,'Inactivo');
/*!40000 ALTER TABLE `estado_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario` (
  `cod_almacen` int(11) NOT NULL,
  `cod_art` varchar(12) NOT NULL,
  `stock_almacen` int(11) NOT NULL,
  KEY `fk_almacen_inventario` (`cod_almacen`),
  KEY `fk_articulo_inventario` (`cod_art`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`cod_almacen`) REFERENCES `almacen` (`cod_almacen`) ON UPDATE NO ACTION,
  CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`cod_art`) REFERENCES `articulo` (`cod_art`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (1,'ART01',152),(1,'ART02',129),(1,'ART03',131),(2,'ART01',25),(2,'ART02',48),(2,'ART04',35);
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_cab`
--

DROP TABLE IF EXISTS `inventario_cab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario_cab` (
  `cod_inv` int(11) NOT NULL AUTO_INCREMENT,
  `cod_trabajador` int(11) DEFAULT NULL,
  `cod_almacen` int(11) DEFAULT NULL,
  `des_inv` varchar(45) DEFAULT NULL,
  `cod_t_doc` int(11) DEFAULT NULL,
  `fec_inv` datetime DEFAULT NULL,
  `cod_estado_inv` int(11) DEFAULT NULL,
  `tot_inv` decimal(7,2) DEFAULT NULL,
  PRIMARY KEY (`cod_inv`),
  KEY `fk_inv_alm_idx` (`cod_almacen`),
  KEY `fk_inv_trab_idx` (`cod_trabajador`),
  KEY `fk_inv_est_idx` (`cod_estado_inv`),
  KEY `fk_inv_t_doc_idx` (`cod_t_doc`),
  CONSTRAINT `fk_inv_alm` FOREIGN KEY (`cod_almacen`) REFERENCES `almacen` (`cod_almacen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_inv_est` FOREIGN KEY (`cod_estado_inv`) REFERENCES `estado_inventario` (`cod_estado_inv`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_inv_t_doc` FOREIGN KEY (`cod_t_doc`) REFERENCES `tipo_doc_inv` (`cod_t_doc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_inv_trab` FOREIGN KEY (`cod_trabajador`) REFERENCES `trabajador` (`cod_trabajador`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_cab`
--

LOCK TABLES `inventario_cab` WRITE;
/*!40000 ALTER TABLE `inventario_cab` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario_cab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_det`
--

DROP TABLE IF EXISTS `inventario_det`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario_det` (
  `cod_inv` int(11) NOT NULL,
  `cod_art` varchar(12) NOT NULL,
  `cant_art` int(11) DEFAULT NULL,
  `obs_inv` varchar(350) DEFAULT NULL,
  PRIMARY KEY (`cod_inv`,`cod_art`),
  KEY `fk_det_art_idx` (`cod_art`),
  CONSTRAINT `fk_det_art` FOREIGN KEY (`cod_art`) REFERENCES `articulo` (`cod_art`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_det_inv` FOREIGN KEY (`cod_inv`) REFERENCES `inventario_cab` (`cod_inv`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_det`
--

LOCK TABLES `inventario_det` WRITE;
/*!40000 ALTER TABLE `inventario_det` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario_det` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1),(5,'2022_06_11_212616_create_permission_tables',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_ibfk_1` FOREIGN KEY (`model_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
INSERT INTO `model_has_permissions` VALUES (51,'App\\Models\\User',1),(51,'App\\Models\\User',2),(51,'App\\Models\\User',3),(52,'App\\Models\\User',1),(52,'App\\Models\\User',2),(52,'App\\Models\\User',3);
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_ibfk_1` FOREIGN KEY (`model_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1),(2,'App\\Models\\User',2),(6,'App\\Models\\User',3);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'ver-articulos','web','2022-06-13 05:16:50','2022-06-13 05:16:50'),(2,'ver-ingresos de insumo','web','2022-06-13 05:16:50','2022-06-13 05:16:50'),(3,'ver-salidas de insumo','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(4,'ver-proveedores','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(5,'ver-trabajadores','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(6,'ver-roles','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(7,'ver-almacenes','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(8,'ver-categorias','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(9,'ver-presentaciones','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(10,'ver-unidades de medida','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(11,'ver-tipos de documento','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(12,'ver-tipos de transferencias','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(13,'registrar-articulos','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(14,'registrar-ingresos de insumo','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(15,'registrar-salidas de insumo','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(16,'registrar-proveedores','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(17,'registrar-trabajadores','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(18,'registrar-roles','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(19,'registrar-almacenes','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(20,'registrar-categorias','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(21,'registrar-presentaciones','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(22,'registrar-unidades de medida','web','2022-06-13 05:16:51','2022-06-13 05:16:51'),(23,'registrar-tipos de documento','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(24,'registrar-tipos de transferencias','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(25,'editar-articulos','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(26,'editar-ingresos de insumo','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(27,'editar-salidas de insumo','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(28,'editar-proveedores','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(29,'editar-trabajadores','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(30,'editar-roles','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(31,'editar-almacenes','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(32,'editar-categorias','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(33,'editar-presentaciones','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(34,'editar-unidades de medida','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(35,'editar-tipos de documento','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(36,'editar-tipos de transferencias','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(37,'eliminar-articulos','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(38,'eliminar-ingresos de insumo','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(39,'eliminar-salidas de insumo','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(40,'eliminar-proveedores','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(41,'eliminar-trabajadores','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(42,'eliminar-roles','web','2022-06-13 05:16:52','2022-06-13 05:16:52'),(43,'eliminar-almacenes','web','2022-06-13 05:16:53','2022-06-13 05:16:53'),(44,'eliminar-categorias','web','2022-06-13 05:16:53','2022-06-13 05:16:53'),(45,'eliminar-presentaciones','web','2022-06-13 05:16:53','2022-06-13 05:16:53'),(46,'eliminar-unidades de medida','web','2022-06-13 05:16:53','2022-06-13 05:16:53'),(47,'eliminar-tipos de documento','web','2022-06-13 05:16:53','2022-06-13 05:16:53'),(48,'eliminar-tipos de transferencias','web','2022-06-13 05:16:53','2022-06-13 05:16:53'),(49,'generar-kardex','web','2022-06-13 05:16:53','2022-06-13 05:16:53'),(50,'generar-inventario','web','2022-06-13 05:16:53','2022-06-13 05:16:53'),(51,'Almacen Central-Lima','web','2022-06-13 00:46:23','2022-06-13 00:46:23'),(52,'Puno Puno','web','2022-06-13 00:46:23','2022-06-13 00:46:23'),(63,'Loreto','web','2022-06-14 14:32:25','2022-06-14 14:32:25');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
  `cod_persona` int(11) NOT NULL AUTO_INCREMENT,
  `cod_t_per` int(11) DEFAULT NULL,
  `razon_social` varchar(45) DEFAULT NULL,
  `nom_per` varchar(45) DEFAULT NULL,
  `ape_pat_per` varchar(45) DEFAULT NULL,
  `ape_mat_per` varchar(45) DEFAULT NULL,
  `cod_t_doc` int(11) DEFAULT NULL,
  `nro_doc` varchar(15) DEFAULT NULL,
  `correo_per` varchar(45) DEFAULT NULL,
  `cod_dist` int(11) DEFAULT NULL,
  `dir_per` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`cod_persona`),
  KEY `fk_per_t_docide_idx` (`cod_t_doc`),
  KEY `fk_per_dist_idx` (`cod_dist`),
  KEY `fk_per_tipo_idx` (`cod_t_per`),
  CONSTRAINT `fk_per_dist` FOREIGN KEY (`cod_dist`) REFERENCES `distrito` (`cod_dist`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_per_t_docide` FOREIGN KEY (`cod_t_doc`) REFERENCES `tdoc_ide` (`cod_t_doc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_per_tipo` FOREIGN KEY (`cod_t_per`) REFERENCES `tipo_persona` (`cod_t_per`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,1,'','Roberto','Gomez','Lujan',1,'12345678','Roberto@hotmail.com',2,'Jr.Unidos 1241'),(2,1,'','Rosa','Ramirez','Paucar',1,'12345679','Rosa@hotmail.com',3,'Jr.Izaquirre Mz 3 1241'),(3,2,'Asociacion Vendor','','','',2,'1012345678','vendor@hotmail.com',6,'Jr.Palmeras 1241'),(5,2,'Asociacion Venzo',NULL,NULL,NULL,2,'23432456','ascociacion@hotmail.com',3,'Av.jiron tobias meyer'),(14,1,NULL,'Karina','Pino','Rojas',1,'18522278','karina@gmail.com',10,'Los olivos 123'),(15,1,NULL,'Alexander','Portocarrero','Jacay',1,'11111111','alexander@gmail.com',10,'Los olivos 321');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (38,'App\\Models\\User',2,'auth_token','90936865c0b4eb7d43a0fe8b0ff008783426c89de13c2978f1f573d2b837bb26','[\"*\"]','2022-06-15 06:40:02','2022-06-15 04:41:43','2022-06-15 06:40:02'),(39,'App\\Models\\User',2,'auth_token','246dba14e0b1cc2c6eb64ce4852cfb03d6f47f3df80b04786cec04e8cc3e9a0d','[\"*\"]','2022-06-19 04:16:05','2022-06-16 23:26:00','2022-06-19 04:16:05'),(44,'App\\Models\\User',2,'auth_token','62abd6fbd9d1e1d2edf2390c7b3a22baa6f99ea9e41792a49a2ce492b5e0d567','[\"*\"]','2022-06-21 06:12:15','2022-06-19 09:51:10','2022-06-21 06:12:15'),(45,'App\\Models\\User',2,'auth_token','ec44077e8e9aaa903b1869501cd12caaaca4dab76e012e6125bbb85894e51b80','[\"*\"]',NULL,'2022-06-21 04:56:59','2022-06-21 04:56:59'),(46,'App\\Models\\User',2,'auth_token','fc8c36f203a6bd2dfdf64d50ab2c50c006dc1396fc9404b23ec63b72c5e358f3','[\"*\"]',NULL,'2022-06-21 04:57:14','2022-06-21 04:57:14');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presentacion`
--

DROP TABLE IF EXISTS `presentacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presentacion` (
  `cod_pres` int(11) NOT NULL AUTO_INCREMENT,
  `des_pres` varchar(45) DEFAULT NULL,
  `estado_pres` varchar(10) DEFAULT 'Activo',
  PRIMARY KEY (`cod_pres`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presentacion`
--

LOCK TABLES `presentacion` WRITE;
/*!40000 ALTER TABLE `presentacion` DISABLE KEYS */;
INSERT INTO `presentacion` VALUES (1,'Caja','Activo'),(2,'Bolsa','Activo'),(3,'saco','Activo'),(4,'electrodomésticos','Activo');
/*!40000 ALTER TABLE `presentacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `cod_prov` int(11) NOT NULL,
  `estado_prov` bit(1) DEFAULT b'1',
  PRIMARY KEY (`cod_prov`),
  CONSTRAINT `fk_prov_per` FOREIGN KEY (`cod_prov`) REFERENCES `persona` (`cod_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (3,''),(5,'');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provincia`
--

DROP TABLE IF EXISTS `provincia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provincia` (
  `cod_provi` int(11) NOT NULL AUTO_INCREMENT,
  `des_provi` varchar(35) DEFAULT NULL,
  `cod_postal` varchar(5) DEFAULT NULL,
  `cod_dep` int(11) DEFAULT NULL,
  PRIMARY KEY (`cod_provi`),
  KEY `fk_provi_dpt_idx` (`cod_dep`),
  CONSTRAINT `fk_provi_dpt` FOREIGN KEY (`cod_dep`) REFERENCES `departamento` (`cod_dpt`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provincia`
--

LOCK TABLES `provincia` WRITE;
/*!40000 ALTER TABLE `provincia` DISABLE KEYS */;
INSERT INTO `provincia` VALUES (1,'Barranca','02',14),(2,'Cajatambo','03',14),(3,'Callao','01',14),(4,'Cañete','05',14),(5,'Canta','04',14),(6,'Huaral','06',14),(7,'Huarochiri','07',14),(8,'Huaura','08',14),(9,'Lima','01',14),(10,'Oyon','09',14),(11,'Yauyos','10',14);
/*!40000 ALTER TABLE `provincia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reg_ing_aux`
--

DROP TABLE IF EXISTS `reg_ing_aux`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reg_ing_aux` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_reg_ing` int(11) NOT NULL,
  `fec_ing` datetime NOT NULL,
  `cod_almacen` int(11) NOT NULL,
  `cod_art` varchar(12) NOT NULL,
  `prec_art` decimal(7,2) NOT NULL,
  `cant_art` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cod_almacen` (`cod_almacen`),
  KEY `cod_art` (`cod_art`),
  CONSTRAINT `reg_ing_aux_ibfk_1` FOREIGN KEY (`cod_art`) REFERENCES `articulo` (`cod_art`) ON UPDATE CASCADE,
  CONSTRAINT `reg_ing_aux_ibfk_2` FOREIGN KEY (`cod_almacen`) REFERENCES `almacen` (`cod_almacen`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reg_ing_aux`
--

LOCK TABLES `reg_ing_aux` WRITE;
/*!40000 ALTER TABLE `reg_ing_aux` DISABLE KEYS */;
INSERT INTO `reg_ing_aux` VALUES (2,37,'2022-04-24 22:44:56',1,'ART01',60.00,1),(4,37,'2022-04-24 22:44:56',1,'ART03',45.00,1),(5,38,'2022-05-12 22:48:45',2,'ART01',40.00,10),(6,38,'2022-05-12 22:48:45',2,'ART02',35.00,30),(7,38,'2022-05-12 22:48:45',2,'ART04',20.00,15),(8,39,'2022-05-29 22:48:45',2,'ART01',40.00,16),(9,39,'2022-05-29 22:48:45',2,'ART02',39.00,18),(10,39,'2022-05-29 22:48:45',2,'ART04',20.00,20),(11,40,'2022-12-10 23:49:25',1,'ART01',25.00,10),(12,40,'2022-12-10 23:49:25',1,'ART02',30.00,9),(19,46,'2022-06-20 16:53:40',1,'ART01',50.00,150),(20,46,'2022-06-20 16:53:40',1,'ART02',85.00,120),(21,46,'2022-06-20 16:53:40',1,'ART03',35.00,130);
/*!40000 ALTER TABLE `reg_ing_aux` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reg_ing_cab`
--

DROP TABLE IF EXISTS `reg_ing_cab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reg_ing_cab` (
  `cod_reg_in` int(11) NOT NULL AUTO_INCREMENT,
  `cod_prov` int(11) DEFAULT NULL,
  `cod_trabajador` int(11) DEFAULT NULL,
  `cod_almacen` int(11) DEFAULT NULL,
  `cod_t_transf` int(11) DEFAULT NULL,
  `cod_t_doc` int(11) DEFAULT NULL,
  `nro_doc` varchar(15) DEFAULT NULL,
  `fec_doc` date DEFAULT NULL,
  `fec_ing` datetime DEFAULT current_timestamp(),
  `cod_estado_reg` int(11) DEFAULT NULL,
  `tot_pagar` decimal(7,2) DEFAULT NULL,
  PRIMARY KEY (`cod_reg_in`),
  KEY `fk_ing_trans_idx` (`cod_t_transf`),
  KEY `fk_ing_alm_idx` (`cod_almacen`),
  KEY `fk_ing_est_idx` (`cod_estado_reg`),
  KEY `fk_ing_prov_idx` (`cod_prov`),
  KEY `fk_ing_trab_idx` (`cod_trabajador`),
  KEY `fk_ing_tdoc_idx` (`cod_t_doc`),
  CONSTRAINT `fk_ing_alm` FOREIGN KEY (`cod_almacen`) REFERENCES `almacen` (`cod_almacen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ing_est` FOREIGN KEY (`cod_estado_reg`) REFERENCES `estado_registro` (`cod_estado_reg`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ing_prov` FOREIGN KEY (`cod_prov`) REFERENCES `proveedor` (`cod_prov`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ing_tdoc` FOREIGN KEY (`cod_t_doc`) REFERENCES `tipo_doc_reg` (`cod_t_doc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ing_trab` FOREIGN KEY (`cod_trabajador`) REFERENCES `trabajador` (`cod_trabajador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ing_trans` FOREIGN KEY (`cod_t_transf`) REFERENCES `tipo_transf` (`cod_t_transf`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reg_ing_cab`
--

LOCK TABLES `reg_ing_cab` WRITE;
/*!40000 ALTER TABLE `reg_ing_cab` DISABLE KEYS */;
INSERT INTO `reg_ing_cab` VALUES (36,3,2,1,2,1,'23456','2022-04-12','2022-04-14 22:44:56',1,775.00),(37,3,1,1,2,2,'345','2022-04-20','2022-04-24 22:44:56',1,1315.00),(38,3,1,2,2,3,'34567','2022-05-09','2022-05-12 22:48:45',1,1750.00),(39,3,1,2,2,2,'8969','2022-05-24','2022-05-29 22:48:45',1,1742.00),(40,3,1,1,2,1,'86787','2022-12-08','2022-12-10 23:49:25',1,550.00),(46,3,2,1,2,1,'2020202020','2022-10-25','2022-06-20 16:53:40',1,534.00);
/*!40000 ALTER TABLE `reg_ing_cab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reg_ing_det`
--

DROP TABLE IF EXISTS `reg_ing_det`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reg_ing_det` (
  `cod_reg_ing` int(11) NOT NULL,
  `cod_art` varchar(12) NOT NULL,
  `prec_unit` decimal(7,2) DEFAULT NULL,
  `cant_art` int(11) DEFAULT NULL,
  `prec_compr` decimal(7,2) DEFAULT NULL,
  `obs_ing` varchar(350) DEFAULT NULL,
  PRIMARY KEY (`cod_reg_ing`,`cod_art`),
  KEY `fk_ing_det_art_idx` (`cod_art`),
  KEY `fk_ing_det_cab_idx` (`cod_reg_ing`),
  CONSTRAINT `fk_ing_det_art` FOREIGN KEY (`cod_art`) REFERENCES `articulo` (`cod_art`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ing_det_cab` FOREIGN KEY (`cod_reg_ing`) REFERENCES `reg_ing_cab` (`cod_reg_in`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reg_ing_det`
--

LOCK TABLES `reg_ing_det` WRITE;
/*!40000 ALTER TABLE `reg_ing_det` DISABLE KEYS */;
INSERT INTO `reg_ing_det` VALUES (36,'ART01',25.00,10,250.00,'obs1'),(36,'ART02',30.00,10,300.00,'obs2'),(36,'ART03',45.00,5,225.00,'obs3'),(37,'ART02',50.00,8,400.00,'obs5'),(37,'ART03',45.00,7,315.00,'obs6'),(38,'ART01',40.00,10,400.00,'obs7'),(38,'ART02',35.00,30,1050.00,'obs8'),(38,'ART04',20.00,15,300.00,'obs9'),(39,'ART01',40.00,16,640.00,'obs10'),(39,'ART02',39.00,18,702.00,'obs11'),(39,'ART04',20.00,20,400.00,'obs12'),(40,'ART01',25.00,10,250.00,'obs13'),(40,'ART02',30.00,10,300.00,'obs14'),(46,'ART01',50.00,150,210.00,'jgjj'),(46,'ART02',85.00,120,675.00,'hgfhf'),(46,'ART03',35.00,130,225.00,'asqwe');
/*!40000 ALTER TABLE `reg_ing_det` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_agregar_stock` AFTER INSERT ON `reg_ing_det` FOR EACH ROW BEGIN

  UPDATE articulo

  SET articulo.stock_art = articulo.stock_art + new.cant_art

  WHERE articulo.cod_art = new.cod_art;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_agregar_stock_almacen` AFTER INSERT ON `reg_ing_det` FOR EACH ROW BEGIN

DECLARE codigoAlmacenVal integer;

DECLARE codArticuloVal varchar(12);



DECLARE codAlmRegIng integer;



SELECT ric.cod_almacen into codAlmRegIng from reg_ing_cab as ric where ric.cod_reg_in = new.cod_reg_ing;



select cod_art into codArticuloVal from inventario where cod_almacen = codAlmRegIng and cod_art = new.cod_art;



select cod_almacen into codigoAlmacenVal from inventario where cod_almacen = codAlmRegIng and cod_art = new.cod_art;



if codigoAlmacenVal <=> null AND codArticuloVal <=> null THEN

  insert into inventario (cod_almacen,cod_art,stock_almacen) VALUES (codAlmRegIng,new.cod_art,new.cant_art);

else

  update inventario 

    set inventario.stock_almacen = inventario.stock_almacen + new.cant_art

    where inventario.cod_almacen = codAlmRegIng and inventario.cod_art = new.cod_art;

end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_añadir_aux` AFTER INSERT ON `reg_ing_det` FOR EACH ROW BEGIN



SELECT ric.cod_almacen into @codAlmRegIng from reg_ing_cab as ric where ric.cod_reg_in = new.cod_reg_ing;



    SELECT fec_ing into @fecha FROM reg_ing_cab as ric WHERE ric.cod_reg_in = new.cod_reg_ing;



  	INSERT INTO reg_ing_aux (id_reg_ing,fec_ing, cod_almacen, cod_art, prec_art, cant_art) VALUES (new.cod_reg_ing,@fecha, @codAlmRegIng, new.cod_art, new.prec_unit, new.cant_art);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_restar_stock_almacen` AFTER DELETE ON `reg_ing_det` FOR EACH ROW BEGIN

DECLARE codigoAlmacenVal integer;

DECLARE codArticuloVal varchar(12);



DECLARE codAlmRegIng integer;



SELECT ric.cod_almacen into codAlmRegIng from reg_ing_cab as ric where ric.cod_reg_in = old.cod_reg_ing;



select cod_art into codArticuloVal from inventario where cod_almacen = codAlmRegIng and cod_art = old.cod_art;



select cod_almacen into codigoAlmacenVal from inventario where cod_almacen = codAlmRegIng and cod_art = old.cod_art;



/*if codigoAlmacenVal <=> null AND codArticuloVal <=> null THEN

  insert into inventario (cod_almacen,cod_art,stock_almacen) VALUES (codAlmRegIng,old.cod_art,old.cant_art);

else*/

  update inventario 

    set inventario.stock_almacen = inventario.stock_almacen - old.cant_art

    where inventario.cod_almacen = codAlmRegIng and inventario.cod_art = old.cod_art;

/*end if;*/

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reg_sal_aux`
--

DROP TABLE IF EXISTS `reg_sal_aux`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reg_sal_aux` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_reg_sal` int(11) NOT NULL,
  `id_reg_ing` int(11) NOT NULL,
  `fec_ing` datetime NOT NULL,
  `cod_almacen` int(11) NOT NULL,
  `cod_art` varchar(12) NOT NULL,
  `prec_art` decimal(7,2) NOT NULL,
  `cant_art` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cod_almacen` (`cod_almacen`),
  KEY `cod_art` (`cod_art`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reg_sal_aux`
--

LOCK TABLES `reg_sal_aux` WRITE;
/*!40000 ALTER TABLE `reg_sal_aux` DISABLE KEYS */;
INSERT INTO `reg_sal_aux` VALUES (4,106,37,'2022-04-24 22:44:56',1,'ART01',60.00,1),(5,107,37,'2022-04-24 22:44:56',1,'ART02',50.00,1),(6,107,40,'2022-12-10 23:49:25',1,'ART02',30.00,1);
/*!40000 ALTER TABLE `reg_sal_aux` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reg_sal_cab`
--

DROP TABLE IF EXISTS `reg_sal_cab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reg_sal_cab` (
  `cod_reg_sal` int(11) NOT NULL AUTO_INCREMENT,
  `cod_solicitador` int(11) DEFAULT NULL,
  `cod_autorizador` int(11) DEFAULT NULL,
  `cod_almacen` int(11) DEFAULT NULL,
  `cod_t_transf` int(11) DEFAULT NULL,
  `cod_t_doc` int(11) DEFAULT NULL,
  `nro_doc` varchar(15) DEFAULT NULL,
  `fec_doc` date DEFAULT NULL,
  `fec_sal` datetime DEFAULT current_timestamp(),
  `cod_estado_reg` int(11) DEFAULT NULL,
  `tot_pagar` decimal(7,2) DEFAULT NULL,
  PRIMARY KEY (`cod_reg_sal`),
  KEY `fk_sal_transf_idx` (`cod_t_transf`),
  KEY `fk_sal_est_idx` (`cod_estado_reg`),
  KEY `fk_sal_t_doc_idx` (`cod_t_doc`),
  KEY `fk_sal_alm_idx` (`cod_almacen`),
  KEY `fk_sal_trab_soli_idx` (`cod_solicitador`) USING BTREE,
  KEY `fk_sal_trab_auto_idx` (`cod_autorizador`),
  CONSTRAINT `fk_sal_alm` FOREIGN KEY (`cod_almacen`) REFERENCES `almacen` (`cod_almacen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sal_est` FOREIGN KEY (`cod_estado_reg`) REFERENCES `estado_registro` (`cod_estado_reg`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sal_t_doc` FOREIGN KEY (`cod_t_doc`) REFERENCES `tipo_doc_reg` (`cod_t_doc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sal_trab` FOREIGN KEY (`cod_solicitador`) REFERENCES `trabajador` (`cod_trabajador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sal_transf` FOREIGN KEY (`cod_t_transf`) REFERENCES `tipo_transf` (`cod_t_transf`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reg_sal_cab`
--

LOCK TABLES `reg_sal_cab` WRITE;
/*!40000 ALTER TABLE `reg_sal_cab` DISABLE KEYS */;
INSERT INTO `reg_sal_cab` VALUES (94,1,2,1,3,4,'11233245','2022-05-18','2022-05-26 23:08:19',1,NULL),(95,2,1,2,3,4,'45345346','2022-05-18','2022-05-31 01:28:30',1,NULL),(96,1,2,1,3,4,'11444245','2022-06-18','2022-06-19 21:52:27',1,NULL),(103,1,2,1,3,4,'1142235','2022-06-18','2022-06-20 01:38:52',1,NULL),(105,1,2,1,3,4,'11142235','2022-06-18','2022-06-20 02:03:48',1,NULL),(106,1,2,1,3,4,'1122235','2022-06-18','2022-06-20 02:05:01',1,NULL),(107,1,2,1,3,4,'11335','2022-06-18','2022-06-20 02:06:39',1,NULL);
/*!40000 ALTER TABLE `reg_sal_cab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reg_sal_det`
--

DROP TABLE IF EXISTS `reg_sal_det`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reg_sal_det` (
  `cod_reg_sal` int(11) NOT NULL,
  `cod_art` varchar(12) NOT NULL,
  `cant_art` int(11) DEFAULT NULL,
  `prec_sal` decimal(7,2) DEFAULT NULL,
  `obs_sal` varchar(350) DEFAULT NULL,
  UNIQUE KEY `uq_salida_detalle` (`cod_reg_sal`,`cod_art`,`prec_sal`) USING BTREE,
  KEY `fk_sal_det_art_idx` (`cod_art`),
  CONSTRAINT `fk_sal_det_art` FOREIGN KEY (`cod_art`) REFERENCES `articulo` (`cod_art`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `reg_sal_det_ibfk_1` FOREIGN KEY (`cod_reg_sal`) REFERENCES `reg_sal_cab` (`cod_reg_sal`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reg_sal_det`
--

LOCK TABLES `reg_sal_det` WRITE;
/*!40000 ALTER TABLE `reg_sal_det` DISABLE KEYS */;
INSERT INTO `reg_sal_det` VALUES (94,'ART01',10,25.00,'ObsSal1'),(94,'ART01',2,60.00,'ObsSal1'),(94,'ART02',8,30.00,'ObsSal1'),(94,'ART03',5,45.00,'ObsSal1'),(95,'ART01',1,60.00,NULL),(96,'ART02',2,30.00,'ObsSal1'),(96,'ART02',7,50.00,'ObsSal1'),(96,'ART01',5,60.00,'ObsSal1'),(103,'ART03',5,45.00,'ObsSal1'),(105,'ART03',1,45.00,'ObsSal1'),(106,'ART01',1,60.00,'ObsSal1'),(107,'ART02',1,50.00,'ObsSal1'),(107,'ART02',1,30.00,'ObsSal1');
/*!40000 ALTER TABLE `reg_sal_det` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_quitar_stock` BEFORE INSERT ON `reg_sal_det` FOR EACH ROW BEGIN

  DECLARE cant_art_actual integer;

  select stock_art into cant_art_actual FROM articulo WHERE articulo.cod_art = new.cod_art;

  IF cant_art_actual > new.cant_art THEN

   update articulo

   set articulo.stock_art = articulo.stock_art - new.cant_art

   WHERE articulo.cod_art = new.cod_art; 

  ELSE

    delete from reg_sal_cab WHERE reg_sal_cab.cod_reg_sal = new.cod_reg_sal;

  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_quitar_stock_almacen` AFTER INSERT ON `reg_sal_det` FOR EACH ROW BEGIN



DECLARE codAlmRegSal integer;



SELECT rsc.cod_almacen INTO codAlmRegSal FROM reg_sal_cab as rsc WHERE rsc.cod_reg_sal = new.cod_reg_sal;



update inventario 

    set inventario.stock_almacen = inventario.stock_almacen - new.cant_art

    where inventario.cod_almacen = codAlmRegSal and inventario.cod_art = new.cod_art;



END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_sumar_stock_almacen` AFTER DELETE ON `reg_sal_det` FOR EACH ROW BEGIN



DECLARE codAlmRegSal integer;



SELECT rsc.cod_almacen INTO codAlmRegSal FROM reg_sal_cab as rsc WHERE rsc.cod_reg_sal = old.cod_reg_sal;



update inventario 

    set inventario.stock_almacen = inventario.stock_almacen - old.cant_art

    where inventario.cod_almacen = codAlmRegSal and inventario.cod_art = old.cod_art;



END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES (1,1),(1,2),(2,1),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),(10,2),(11,2),(12,2),(13,2),(14,2),(14,6),(15,2),(16,2),(17,2),(18,2),(19,2),(20,2),(21,2),(22,2),(23,2),(24,2),(25,2),(26,2),(27,2),(28,2),(29,2),(30,2),(31,2),(32,2),(33,2),(34,2),(35,2),(36,2),(37,2),(38,2),(39,2),(40,2),(41,2),(42,2),(43,2),(44,2),(45,2),(46,2),(47,2),(48,2),(49,2),(50,2);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Ver','web','2022-06-13 05:33:08','2022-06-18 04:19:11'),(2,'ADMINISTRADOR','web','2022-06-15 04:33:58','2022-06-15 04:33:58'),(3,'PRUEBA','web','2022-06-16 23:26:16','2022-06-16 23:26:16'),(4,'PRUEBA1','web','2022-06-16 23:26:52','2022-06-16 23:26:52'),(5,'PRUEBA2','web','2022-06-16 23:27:01','2022-06-16 23:27:01'),(6,'CREAR','web','2022-06-19 09:54:32','2022-06-19 09:54:32');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tdoc_ide`
--

DROP TABLE IF EXISTS `tdoc_ide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tdoc_ide` (
  `cod_t_doc` int(11) NOT NULL AUTO_INCREMENT,
  `dest_doc` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`cod_t_doc`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tdoc_ide`
--

LOCK TABLES `tdoc_ide` WRITE;
/*!40000 ALTER TABLE `tdoc_ide` DISABLE KEYS */;
INSERT INTO `tdoc_ide` VALUES (1,'DNI'),(2,'RUC');
/*!40000 ALTER TABLE `tdoc_ide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefono`
--

DROP TABLE IF EXISTS `telefono`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telefono` (
  `cod_telf` int(11) NOT NULL AUTO_INCREMENT,
  `nro_telf` varchar(11) DEFAULT NULL,
  `cod_persona` int(11) DEFAULT NULL,
  PRIMARY KEY (`cod_telf`),
  KEY `fk_telf_per_idx` (`cod_persona`),
  CONSTRAINT `fk_telf_per` FOREIGN KEY (`cod_persona`) REFERENCES `persona` (`cod_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefono`
--

LOCK TABLES `telefono` WRITE;
/*!40000 ALTER TABLE `telefono` DISABLE KEYS */;
INSERT INTO `telefono` VALUES (1,'12345',5),(2,'23456',5),(15,'123456789',14),(16,'987654321',14),(17,'654987321',15),(18,'159753465',15);
/*!40000 ALTER TABLE `telefono` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_doc_inv`
--

DROP TABLE IF EXISTS `tipo_doc_inv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_doc_inv` (
  `cod_t_doc` int(11) NOT NULL AUTO_INCREMENT,
  `des_t_doc` varchar(45) DEFAULT NULL,
  `estado_t_doc` varchar(10) DEFAULT 'Activo',
  PRIMARY KEY (`cod_t_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_doc_inv`
--

LOCK TABLES `tipo_doc_inv` WRITE;
/*!40000 ALTER TABLE `tipo_doc_inv` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_doc_inv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_doc_reg`
--

DROP TABLE IF EXISTS `tipo_doc_reg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_doc_reg` (
  `cod_t_doc` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_reg_doc` varchar(10) DEFAULT NULL,
  `des_t_doc` varchar(45) DEFAULT NULL,
  `estado_t_doc` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`cod_t_doc`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_doc_reg`
--

LOCK TABLES `tipo_doc_reg` WRITE;
/*!40000 ALTER TABLE `tipo_doc_reg` DISABLE KEYS */;
INSERT INTO `tipo_doc_reg` VALUES (1,'Ingreso','Guia de Remisión',1),(2,'Ingreso','Cotización',1),(3,'Ingreso','Factura',1),(4,'Salida','Orden de Requerimiento',1);
/*!40000 ALTER TABLE `tipo_doc_reg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_persona`
--

DROP TABLE IF EXISTS `tipo_persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_persona` (
  `cod_t_per` int(11) NOT NULL AUTO_INCREMENT,
  `des_t_per` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`cod_t_per`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_persona`
--

LOCK TABLES `tipo_persona` WRITE;
/*!40000 ALTER TABLE `tipo_persona` DISABLE KEYS */;
INSERT INTO `tipo_persona` VALUES (1,'Natural'),(2,'Jurídica');
/*!40000 ALTER TABLE `tipo_persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_transf`
--

DROP TABLE IF EXISTS `tipo_transf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_transf` (
  `cod_t_transf` int(11) NOT NULL AUTO_INCREMENT,
  `des_transf` varchar(45) DEFAULT NULL,
  `estado_transf` varchar(10) DEFAULT 'Activo',
  PRIMARY KEY (`cod_t_transf`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_transf`
--

LOCK TABLES `tipo_transf` WRITE;
/*!40000 ALTER TABLE `tipo_transf` DISABLE KEYS */;
INSERT INTO `tipo_transf` VALUES (1,'Ingreso por donacion','Activo'),(2,'Ingreso por compra','Activo'),(3,'Salida por utilidad','Activo');
/*!40000 ALTER TABLE `tipo_transf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trabajador`
--

DROP TABLE IF EXISTS `trabajador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trabajador` (
  `cod_trabajador` int(11) NOT NULL,
  `estado_trab` bit(1) DEFAULT b'1',
  PRIMARY KEY (`cod_trabajador`),
  CONSTRAINT `fk_trab_per_` FOREIGN KEY (`cod_trabajador`) REFERENCES `persona` (`cod_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trabajador`
--

LOCK TABLES `trabajador` WRITE;
/*!40000 ALTER TABLE `trabajador` DISABLE KEYS */;
INSERT INTO `trabajador` VALUES (1,''),(2,''),(14,''),(15,'');
/*!40000 ALTER TABLE `trabajador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unid_med`
--

DROP TABLE IF EXISTS `unid_med`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unid_med` (
  `cod_unid_med` int(11) NOT NULL AUTO_INCREMENT,
  `des_unid_med` varchar(45) DEFAULT NULL,
  `prefijo_unid_med` varchar(10) DEFAULT NULL,
  `estado_unid_med` varchar(10) DEFAULT 'Activo',
  PRIMARY KEY (`cod_unid_med`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unid_med`
--

LOCK TABLES `unid_med` WRITE;
/*!40000 ALTER TABLE `unid_med` DISABLE KEYS */;
INSERT INTO `unid_med` VALUES (1,'unidad','und','Activo'),(2,'Kilogramos','kg','Activo');
/*!40000 ALTER TABLE `unid_med` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cod_trabajador` int(11) DEFAULT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contraseña` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cod_estado_usu` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `cod_estado_usu` (`cod_estado_usu`),
  KEY `cod_trabajador` (`cod_trabajador`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`cod_trabajador`) REFERENCES `trabajador` (`cod_trabajador`) ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`cod_estado_usu`) REFERENCES `estado_usuario` (`cod_estado_usu`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,14,'KPR18522278','$2y$10$IChXsYMIlfXPZXWR4YtB8e/Vh5wGLlPzKYcLzI4kcXoRmH2wykRTa',1),(2,NULL,'administrador','$2y$10$JsPAD7ye9ln7A0AegIi0IuojOUQFNR1jSD5Ocum9K8QkpnsGS3ie.',1),(3,15,'APJ11111111','$2y$10$Up/Dvcr4k8D6yivPDypPnuJI8xZX9QKUQwoJt39/E8ahTEDxV.3bC',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP PROCEDURE IF EXISTS `inventario_actual` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `inventario_actual`(IN `cod_alm` INT(11))
select art.cod_art, 

art.des_art, 

um.des_unid_med, 

inv.stock_almacen, 

(select sum(reg_ing_aux.cant_art*reg_ing_aux.prec_art) from reg_ing_aux where reg_ing_aux.cod_art = art.cod_art && reg_ing_aux.cod_almacen = cod_alm GROUP BY cod_art) as valor_total 

FROM articulo as art

INNER JOIN inventario as inv on inv.cod_art = art.cod_art

INNER JOIN unid_med as um on um.cod_unid_med = art.cod_unid_med

where inv.stock_almacen > 0 && 

inv.cod_almacen = cod_alm ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `kardex_articulo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `kardex_articulo`(IN `articulo` VARCHAR(12), IN `fec_ini` DATE, IN `fec_fin` DATE, IN `cod_alm` INT(11))
select art.cod_art, 'INGRESO' as movimiento,

    Date_format(ri.fec_ing,'%Y/%m/%d') as FECHA,

    #ri.fec_ing as FECHA,

    rid.cant_art as CANT_ING,

    rid.prec_unit as PREC_ING,

    rid.prec_unit*rid.cant_art as VAL_ING,

    '' as CANT_SAL, '' as PREC_SAL, '' as VAL_SAL

    from articulo as art

    right join reg_ing_det as rid on rid.cod_art = art.cod_art

    inner join reg_ing_cab as ri on ri.cod_reg_in = rid.cod_reg_ing 

    where art.cod_art = articulo && 

    ri.cod_almacen = cod_alm &&

    ri.fec_ing BETWEEN CONCAT(fec_ini," 00:00:00") and CONCAT(fec_fin," 23:59:59")

union

SELECT art.cod_art, 'SALIDA' as movimiento,

    Date_format(rs.fec_sal,'%Y/%m/%d') as FECHA,

    #rs.fec_sal as FECHA,

    '' as CANT_ING, '' as PREC_ING,'' as VAL_ING,

    rsd.cant_art as CANT_SAL,

    rsd.prec_sal as PREC_SAL,

    rsd.prec_sal*rsd.cant_art as VAL_SAL

    from articulo as art

    left join reg_sal_det as rsd on rsd.cod_art = art.cod_art

    inner join reg_sal_cab as rs on rs.cod_reg_sal = rsd.cod_reg_sal

    where art.cod_art = articulo  && 

    rs.cod_almacen = cod_alm &&

    rs.fec_sal BETWEEN CONCAT(fec_ini," 00:00:00") and CONCAT(fec_fin," 23:59:59")

    order by FECHA asc ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `total_cant_lapso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `total_cant_lapso`(IN `articulo` VARCHAR(12), IN `fec_ini` DATE, IN `cod_alm` INT(11))
select(

(SELECT stock_almacen FROM inventario WHERE cod_art = articulo && cod_almacen = cod_alm)

-

(select IFNULL(sum(rid.cant_art),0) as CANT 

from articulo as art

right join reg_ing_det as rid on rid.cod_art = art.cod_art

inner join reg_ing_cab as ri on ri.cod_reg_in = rid.cod_reg_ing 

where art.cod_art = articulo && 

 ri.cod_almacen = cod_alm &&

 ri.fec_ing BETWEEN CONCAT(fec_ini," 00:00:00") and NOW())

+

(select IFNULL(sum(rsd.cant_art),0) as CANT 

from articulo as art

left join reg_sal_det as rsd on rsd.cod_art = art.cod_art

inner join reg_sal_cab as rs on rs.cod_reg_sal = rsd.cod_reg_sal

where art.cod_art = articulo  &&

 rs.cod_almacen = cod_alm &&

 rs.fec_sal BETWEEN CONCAT(fec_ini," 00:00:00") and NOW() )

) as cant_ini ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `total_valor_lapso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `total_valor_lapso`(IN `articulo` VARCHAR(12), IN `fec_ini` DATE, IN `cod_alm` INT(11))
begin

select(

(SELECT 

sum(prec_art*cant_art) as TOTAL FROM reg_ing_aux WHERE cod_art = articulo && cod_almacen = cod_alm)

 -

(select IFNULL(sum(rid.prec_unit*rid.cant_art),0) as TOTAL

from articulo as art

right join reg_ing_det as rid on rid.cod_art = art.cod_art

inner join reg_ing_cab as ri on ri.cod_reg_in = rid.cod_reg_ing 

where art.cod_art = articulo && 

 ri.cod_almacen = cod_alm &&

 ri.fec_ing BETWEEN CONCAT(fec_ini," 00:00:00") and "2022-12-30 23:00:00")

+

(select IFNULL(sum(rsd.prec_sal*rsd.cant_art),0) as TOTAL

from articulo as art

left join reg_sal_det as rsd on rsd.cod_art = art.cod_art

inner join reg_sal_cab as rs on rs.cod_reg_sal = rsd.cod_reg_sal

where art.cod_art = articulo && 

 rs.cod_almacen = cod_alm &&

 rs.fec_sal BETWEEN CONCAT(fec_ini," 00:00:00") and "2022-12-30 23:00:00" )

) as total;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-20 20:40:02
