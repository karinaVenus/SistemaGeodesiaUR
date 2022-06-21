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
-- Table structure for table `almacen`
--

DROP TABLE IF EXISTS `almacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `almacen` (
  `cod_almacen` int(11) NOT NULL AUTO_INCREMENT,
  `des_almacen` varchar(45) DEFAULT NULL,
  `cod_estado_almacen` int(11) DEFAULT NULL,
  `ubic_almacen` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`cod_almacen`),
  KEY `fk_alm_estado_idx` (`cod_estado_almacen`),
  CONSTRAINT `fk_alm_estado` FOREIGN KEY (`cod_estado_almacen`) REFERENCES `estado_almacen` (`cod_estado_almacen`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `almacen`
--

LOCK TABLES `almacen` WRITE;
/*!40000 ALTER TABLE `almacen` DISABLE KEYS */;
INSERT INTO `almacen` VALUES (1,'Almacen Central-Lima',1,'Lima'),(2,'Almacen Puno',1,'Puno');
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
INSERT INTO `articulo` VALUES ('art-09','pintura',3,1,2,0,'https://www.google.com/search?q=pintura+azul&tbm=isch&ved=2a',1),('ART01','cinta de tela',2,1,1,43,'img.jpg',1),('ART02','cinta metrica',2,1,1,68,'img1.jpg',1),('ART03','sierra electrica',1,1,1,7,'img3.jpg',1),('ART04','cartulina de correspum',1,3,1,35,'img4.jpg',1),('ART05','acuarela de tiza',3,1,1,0,'img5.jpg',1),('ART06','silla',3,1,1,0,'img6.jpg',1),('ART07','laptop hp',2,1,1,0,'img7.jpg',1),('ART08','auriculares de sonido',2,3,2,0,'img8.jpg',1),('ART09','mesa de madera',2,1,1,0,'img9.jpg',1),('ART10','teclado gamer',3,3,1,0,'img10.jpg',1),('ART123','lapiz 2b',2,1,1,0,'https://images.utilex.pe/002137/450x450/lapiz-triangular-2b-amarillo-CYV3ACWJQUFTE.png',1);
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'cartulinas','Activo'),(2,'cintas de medir','Activo'),(3,'laminas',NULL);
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
INSERT INTO `inventario` VALUES (1,'ART01',18),(1,'ART02',20),(1,'ART03',7),(2,'ART01',25),(2,'ART02',48),(2,'ART04',35);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,1,'','Roberto','Gomez','Lujan',1,'12345678','Roberto@hotmail.com',2,'Jr.Unidos 1241'),(2,1,'','Rosa','Ramirez','Paucar',1,'12345679','Rosa@hotmail.com',3,'Jr.Izaquirre Mz 3 1241'),(3,2,'Asociacion Vendor','','','',2,'1012345678','vendor@hotmail.com',6,'Jr.Palmeras 1241'),(5,2,'Asociacion Venzo',NULL,NULL,NULL,2,'23432456','ascociacion@hotmail.com',3,'Av.jiron tobias meyer');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reg_ing_aux`
--

LOCK TABLES `reg_ing_aux` WRITE;
/*!40000 ALTER TABLE `reg_ing_aux` DISABLE KEYS */;
INSERT INTO `reg_ing_aux` VALUES (1,'2022-04-14 22:44:56',1,'ART02',30.00,2),(2,'2022-04-24 22:44:56',1,'ART01',60.00,7),(3,'2022-04-24 22:44:56',1,'ART02',50.00,8),(4,'2022-04-24 22:44:56',1,'ART03',45.00,7),(5,'2022-05-12 22:48:45',2,'ART01',40.00,10),(6,'2022-05-12 22:48:45',2,'ART02',35.00,30),(7,'2022-05-12 22:48:45',2,'ART04',20.00,15),(8,'2022-05-29 22:48:45',2,'ART01',40.00,16),(9,'2022-05-29 22:48:45',2,'ART02',39.00,18),(10,'2022-05-29 22:48:45',2,'ART04',20.00,20),(11,'2022-12-10 23:49:25',1,'ART01',25.00,10),(12,'2022-12-10 23:49:25',1,'ART02',30.00,10);
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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reg_ing_cab`
--

LOCK TABLES `reg_ing_cab` WRITE;
/*!40000 ALTER TABLE `reg_ing_cab` DISABLE KEYS */;
INSERT INTO `reg_ing_cab` VALUES (36,3,2,1,2,1,'23456','2022-04-12','2022-04-14 22:44:56',1,775.00),(37,3,1,1,2,2,'345','2022-04-20','2022-04-24 22:44:56',1,1315.00),(38,3,1,2,2,3,'34567','2022-05-09','2022-05-12 22:48:45',1,1750.00),(39,3,1,2,2,2,'8969','2022-05-24','2022-05-29 22:48:45',1,1742.00),(40,3,1,1,2,1,'86787','2022-12-08','2022-12-10 23:49:25',1,550.00);
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
INSERT INTO `reg_ing_det` VALUES (36,'ART01',25.00,10,250.00,'obs1'),(36,'ART02',30.00,10,300.00,'obs2'),(36,'ART03',45.00,5,225.00,'obs3'),(37,'ART01',60.00,10,600.00,'obs4'),(37,'ART02',50.00,8,400.00,'obs5'),(37,'ART03',45.00,7,315.00,'obs6'),(38,'ART01',40.00,10,400.00,'obs7'),(38,'ART02',35.00,30,1050.00,'obs8'),(38,'ART04',20.00,15,300.00,'obs9'),(39,'ART01',40.00,16,640.00,'obs10'),(39,'ART02',39.00,18,702.00,'obs11'),(39,'ART04',20.00,20,400.00,'obs12'),(40,'ART01',25.00,10,250.00,'obs13'),(40,'ART02',30.00,10,300.00,'obs14');
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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_añadir_aux` AFTER INSERT ON `reg_ing_det` FOR EACH ROW BEGIN

SELECT ric.cod_almacen into @codAlmRegIng from reg_ing_cab as ric where ric.cod_reg_in = new.cod_reg_ing;

    SELECT fec_ing into @fecha FROM reg_ing_cab as ric WHERE ric.cod_reg_in = new.cod_reg_ing;

  	INSERT INTO reg_ing_aux (fec_ing, cod_almacen, cod_art, prec_art, cant_art) VALUES (@fecha, @codAlmRegIng, new.cod_art, new.prec_unit, new.cant_art);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reg_sal_cab`
--

LOCK TABLES `reg_sal_cab` WRITE;
/*!40000 ALTER TABLE `reg_sal_cab` DISABLE KEYS */;
INSERT INTO `reg_sal_cab` VALUES (94,1,2,1,3,4,'11233245','2022-05-18','2022-05-26 23:08:19',1,NULL),(95,2,1,2,3,4,'45345346','2022-05-18','2022-05-31 01:28:30',1,NULL);
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
INSERT INTO `reg_sal_det` VALUES (94,'ART01',10,25.00,'ObsSal1'),(94,'ART01',2,60.00,'ObsSal1'),(94,'ART02',8,30.00,'ObsSal1'),(94,'ART03',5,45.00,'ObsSal1'),(95,'ART01',1,60.00,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefono`
--

LOCK TABLES `telefono` WRITE;
/*!40000 ALTER TABLE `telefono` DISABLE KEYS */;
INSERT INTO `telefono` VALUES (1,'12345',5),(2,'23456',5);
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
INSERT INTO `trabajador` VALUES (1,''),(2,'');
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
  `cod_trabajador` int(11) NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contraseña` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cod_estado_usu` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-11 16:23:58
