CREATE DATABASE  IF NOT EXISTS `petvida` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `petvida`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: petvida
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
-- Table structure for table `animais`
--

DROP TABLE IF EXISTS `animais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `animais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `especie` varchar(50) NOT NULL,
  `raca` varchar(80) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `tutor_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_animais_tutores` (`tutor_id`),
  CONSTRAINT `fk_animais_tutores` FOREIGN KEY (`tutor_id`) REFERENCES `tutores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animais`
--

LOCK TABLES `animais` WRITE;
/*!40000 ALTER TABLE `animais` DISABLE KEYS */;
INSERT INTO `animais` VALUES (1,'Thor','Cachorro','Labrador','2020-05-10',1),(2,'Mel','Gato','Siamês','2021-08-15',1),(3,'Bob','Cachorro','Poodle','2019-03-20',2),(4,'Luna','Gato','Persa','2022-01-05',3),(5,'Nina','Cachorro','Shih-tzu','2021-11-12',3),(6,'Tico','Pássaro','Calopsita','2023-02-18',4),(7,'Rex','Cachorro','Pastor Alemão','2018-09-30',5),(8,'Sol','Gato','SRD','2024-04-11',5),(9,'Thor','Cachorro','Vira-lata','2022-05-10',1);
/*!40000 ALTER TABLE `animais` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_after_insert_animal` AFTER INSERT ON `animais` FOR EACH ROW BEGIN
    INSERT INTO log_auditoria (
        tabela_afetada,
        acao,
        registro_id,
        detalhes
    )
    VALUES (
        'animais',
        'INSERT',
        NEW.id,
        'Animal cadastrado'
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `consultas`
--

DROP TABLE IF EXISTS `consultas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `animal_id` int NOT NULL,
  `veterinario_id` int NOT NULL,
  `data_hora` datetime NOT NULL,
  `diagnostico` text,
  `valor` decimal(10,2) NOT NULL,
  `status` varchar(30) DEFAULT 'agendada',
  PRIMARY KEY (`id`),
  KEY `fk_consultas_animais` (`animal_id`),
  KEY `fk_consultas_veterinarios` (`veterinario_id`),
  CONSTRAINT `fk_consultas_animais` FOREIGN KEY (`animal_id`) REFERENCES `animais` (`id`),
  CONSTRAINT `fk_consultas_veterinarios` FOREIGN KEY (`veterinario_id`) REFERENCES `veterinarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
INSERT INTO `consultas` VALUES (1,1,1,'2026-05-01 09:00:00','Animal saudável.',120.00,'cancelada'),(2,2,2,'2026-05-01 10:30:00','Coceira e irritação na pele.',150.00,'agendada'),(3,3,1,'2026-05-02 14:00:00','Vacinação anual realizada.',100.00,'agendada'),(4,4,3,'2026-05-03 08:30:00','Avaliação pré-cirúrgica.',200.00,'agendada'),(5,5,2,'2026-05-04 11:00:00','Alergia alimentar suspeita.',160.00,'agendada'),(6,6,1,'2026-05-05 15:00:00','Check-up de ave doméstica.',90.00,'agendada'),(7,7,3,'2026-05-06 16:30:00','Ferimento na pata tratado.',180.00,'agendada'),(8,1,2,'2026-05-07 09:45:00','Retorno dermatológico.',130.00,'agendada'),(9,3,3,'2026-05-08 13:20:00','Exame físico geral.',140.00,'agendada'),(11,2,1,'2026-05-15 14:30:00','Consulta agendada pela procedure.',125.00,'agendada'),(12,9,1,'2026-06-05 14:00:00',NULL,150.00,'agendada'),(13,1,1,'2026-06-15 19:18:07',NULL,100.00,'concluida');
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_after_insert_consulta` AFTER INSERT ON `consultas` FOR EACH ROW BEGIN
    INSERT INTO log_auditoria (
        tabela_afetada,
        acao,
        registro_id,
        detalhes
    )
    VALUES (
        'consultas',
        'INSERT',
        NEW.id,
        CONCAT('Consulta criada com status: ', NEW.status)
    );
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_after_update_consulta_status` AFTER UPDATE ON `consultas` FOR EACH ROW BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO log_auditoria (
            tabela_afetada,
            acao,
            registro_id,
            detalhes
        )
        VALUES (
            'consultas',
            'UPDATE',
            NEW.id,
            CONCAT('Status alterado de ', OLD.status, ' para ', NEW.status)
        );
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_delete_consulta` BEFORE DELETE ON `consultas` FOR EACH ROW BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Exclusao de consultas nao permitida';
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `log_auditoria`
--

DROP TABLE IF EXISTS `log_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_auditoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tabela_afetada` varchar(50) DEFAULT NULL,
  `acao` varchar(20) DEFAULT NULL,
  `registro_id` int DEFAULT NULL,
  `detalhes` text,
  `data_hora` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_auditoria`
--

LOCK TABLES `log_auditoria` WRITE;
/*!40000 ALTER TABLE `log_auditoria` DISABLE KEYS */;
INSERT INTO `log_auditoria` VALUES (1,'consultas','INSERT',13,'Consulta criada com status: agendada','2026-06-15 22:18:07'),(2,'consultas','UPDATE',13,'Status alterado de agendada para concluida','2026-06-15 22:24:17');
/*!40000 ALTER TABLE `log_auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamentos`
--

DROP TABLE IF EXISTS `pagamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `consulta_id` int NOT NULL,
  `forma_pagamento` varchar(50) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `data_pagamento` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `consulta_id` (`consulta_id`),
  CONSTRAINT `pagamentos_ibfk_1` FOREIGN KEY (`consulta_id`) REFERENCES `consultas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamentos`
--

LOCK TABLES `pagamentos` WRITE;
/*!40000 ALTER TABLE `pagamentos` DISABLE KEYS */;
INSERT INTO `pagamentos` VALUES (1,12,'pix','pago','2026-06-15');
/*!40000 ALTER TABLE `pagamentos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_update_pagamento` BEFORE UPDATE ON `pagamentos` FOR EACH ROW BEGIN
    IF OLD.status <> 'pago'
       AND NEW.status = 'pago' THEN
        SET NEW.data_pagamento = CURDATE();
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tutores`
--

DROP TABLE IF EXISTS `tutores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutores`
--

LOCK TABLES `tutores` WRITE;
/*!40000 ALTER TABLE `tutores` DISABLE KEYS */;
INSERT INTO `tutores` VALUES (1,'João Pereira','111.111.111-11','joao@email.com','(71) 97777-1111'),(2,'Maria Oliveira','222.222.222-22','maria@email.com','(71) 98888-2222'),(3,'Carlos Santos','333.333.333-33','carlos@email.com','(71) 98888-3333'),(4,'Fernanda Rocha','444.444.444-44','fernanda@email.com','(71) 98888-4444'),(5,'Lucas Almeida','555.555.555-55','lucas@email.com','(71) 98888-5555');
/*!40000 ALTER TABLE `tutores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veterinarios`
--

DROP TABLE IF EXISTS `veterinarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veterinarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `crmv` varchar(20) NOT NULL,
  `especialidade` varchar(80) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crmv` (`crmv`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinarios`
--

LOCK TABLES `veterinarios` WRITE;
/*!40000 ALTER TABLE `veterinarios` DISABLE KEYS */;
INSERT INTO `veterinarios` VALUES (1,'Dra. Ana Souza','CRMV-BA-1001','Clínica Geral','(71) 99999-1001'),(2,'Dr. Bruno Lima','CRMV-BA-1002','Dermatologia Veterinária','(71) 99999-1002'),(3,'Dra. Carla Mendes','CRMV-BA-1003','Cirurgia Veterinária','(71) 99999-1003');
/*!40000 ALTER TABLE `veterinarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_agenda_hoje`
--

DROP TABLE IF EXISTS `vw_agenda_hoje`;
/*!50001 DROP VIEW IF EXISTS `vw_agenda_hoje`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_agenda_hoje` AS SELECT 
 1 AS `data_hora`,
 1 AS `status`,
 1 AS `diagnostico`,
 1 AS `valor`,
 1 AS `animal`,
 1 AS `especie`,
 1 AS `tutor`,
 1 AS `telefone`,
 1 AS `veterinario`,
 1 AS `especialidade`,
 1 AS `forma_pagamento`,
 1 AS `status_pagamento`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_animais_detalhados`
--

DROP TABLE IF EXISTS `vw_animais_detalhados`;
/*!50001 DROP VIEW IF EXISTS `vw_animais_detalhados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_animais_detalhados` AS SELECT 
 1 AS `id`,
 1 AS `animal`,
 1 AS `especie`,
 1 AS `raca`,
 1 AS `data_nascimento`,
 1 AS `tutor`,
 1 AS `telefone`,
 1 AS `total_consultas`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_consultas_completas`
--

DROP TABLE IF EXISTS `vw_consultas_completas`;
/*!50001 DROP VIEW IF EXISTS `vw_consultas_completas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_consultas_completas` AS SELECT 
 1 AS `data_hora`,
 1 AS `status`,
 1 AS `diagnostico`,
 1 AS `valor`,
 1 AS `animal`,
 1 AS `especie`,
 1 AS `tutor`,
 1 AS `telefone`,
 1 AS `veterinario`,
 1 AS `especialidade`,
 1 AS `forma_pagamento`,
 1 AS `status_pagamento`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_faturamento_mensal`
--

DROP TABLE IF EXISTS `vw_faturamento_mensal`;
/*!50001 DROP VIEW IF EXISTS `vw_faturamento_mensal`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_faturamento_mensal` AS SELECT 
 1 AS `ano`,
 1 AS `mes`,
 1 AS `veterinario`,
 1 AS `total_consultas`,
 1 AS `faturamento_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_inadimplentes`
--

DROP TABLE IF EXISTS `vw_inadimplentes`;
/*!50001 DROP VIEW IF EXISTS `vw_inadimplentes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_inadimplentes` AS SELECT 
 1 AS `data_hora`,
 1 AS `status`,
 1 AS `diagnostico`,
 1 AS `valor`,
 1 AS `animal`,
 1 AS `especie`,
 1 AS `tutor`,
 1 AS `telefone`,
 1 AS `veterinario`,
 1 AS `especialidade`,
 1 AS `forma_pagamento`,
 1 AS `status_pagamento`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'petvida'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_classificar_valor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_classificar_valor`(p_valor DECIMAL(10,2)) RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN p_valor < 100 THEN 'Consulta Simples'
        WHEN p_valor BETWEEN 100 AND 300 THEN 'Consulta Padrão'
        ELSE 'Procedimento Especial'
    END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_idade_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_idade_animal`(data_nascimento DATE) RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE anos INT;
    DECLARE meses INT;

    SET anos = TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE());
    SET meses = TIMESTAMPDIFF(MONTH, data_nascimento, CURDATE()) MOD 12;

    RETURN CONCAT(anos, ' anos e ', meses, ' meses');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_qtd_consultas_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_qtd_consultas_animal`(p_animal_id INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE qtd INT;

    SELECT COUNT(*)
    INTO qtd
    FROM consultas
    WHERE animal_id = p_animal_id;

    RETURN qtd;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_status_emoji` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_status_emoji`(p_status VARCHAR(30)) RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN p_status = 'agendada' THEN '📅 Agendada'
        WHEN p_status = 'concluida' THEN '✅ Concluída'
        WHEN p_status = 'cancelada' THEN '❌ Cancelada'
        WHEN p_status = 'em_atendimento' THEN '🏥 Em Atendimento'
        ELSE 'Status desconhecido'
    END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_total_gasto_tutor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_total_gasto_tutor`(p_tutor_id INT) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT IFNULL(SUM(c.valor), 0)
    INTO total
    FROM consultas c
    INNER JOIN animais a ON c.animal_id = a.id
    WHERE a.tutor_id = p_tutor_id
      AND c.status <> 'cancelada';

    RETURN total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `total_consultas_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `total_consultas_animal`(p_animal_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM consultas
    WHERE animal_id = p_animal_id;

    RETURN total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `agendar_consulta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agendar_consulta`(
    IN p_animal_id INT,
    IN p_veterinario_id INT,
    IN p_data_hora DATETIME,
    IN p_valor DECIMAL(10,2)
)
BEGIN
    DECLARE v_existe_animal INT DEFAULT 0;
    DECLARE v_existe_veterinario INT DEFAULT 0;
    DECLARE v_novo_id INT;

    SELECT COUNT(*) INTO v_existe_animal
    FROM animais
    WHERE id = p_animal_id;

    SELECT COUNT(*) INTO v_existe_veterinario
    FROM veterinarios
    WHERE id = p_veterinario_id;

    IF v_existe_animal = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: animal não encontrado.';
    ELSEIF v_existe_veterinario = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: veterinário não encontrado.';
    ELSE
        INSERT INTO consultas (animal_id, veterinario_id, data_hora, diagnostico, valor)
        VALUES (p_animal_id, p_veterinario_id, p_data_hora, 'Consulta agendada pela procedure.', p_valor);

        SET v_novo_id = LAST_INSERT_ID();

        SELECT CONCAT('Consulta agendada com sucesso. ID gerado: ', v_novo_id) AS mensagem;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_agendar_consulta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_agendar_consulta`(
    IN p_animal_id INT,
    IN p_vet_id INT,
    IN p_data_hora DATETIME,
    IN p_valor DECIMAL(10,2)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM animais WHERE id = p_animal_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Animal nao encontrado';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM veterinarios WHERE id = p_vet_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Veterinario nao encontrado';
    END IF;

    IF EXISTS (
        SELECT 1 FROM consultas
        WHERE veterinario_id = p_vet_id
        AND data_hora = p_data_hora
        AND status <> 'cancelada'
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Horario indisponivel';
    END IF;

    START TRANSACTION;

    INSERT INTO consultas (animal_id, veterinario_id, data_hora, valor, status)
VALUES (p_animal_id, p_vet_id, p_data_hora, p_valor, 'agendada');

    INSERT INTO pagamentos (consulta_id, forma_pagamento, status)
    VALUES (LAST_INSERT_ID(), NULL, 'pendente');

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cadastrar_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cadastrar_animal`(
    IN p_nome VARCHAR(100),
    IN p_especie VARCHAR(50),
    IN p_raca VARCHAR(80),
    IN p_nascimento DATE,
    IN p_tutor_id INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM tutores WHERE id = p_tutor_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tutor nao encontrado';
    END IF;

    INSERT INTO animais (nome, especie, raca, data_nascimento, tutor_id)
    VALUES (p_nome, p_especie, p_raca, p_nascimento, p_tutor_id);

    SELECT LAST_INSERT_ID() AS animal_criado_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cancelar_consulta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cancelar_consulta`(
    IN p_consulta_id INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM consultas WHERE id = p_consulta_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Consulta nao encontrada';
    END IF;

    START TRANSACTION;

    UPDATE consultas
    SET status = 'cancelada'
    WHERE id = p_consulta_id;

    UPDATE pagamentos
    SET status = 'cancelado'
    WHERE consulta_id = p_consulta_id;

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_concluir_consulta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_concluir_consulta`(
    IN p_consulta_id INT,
    IN p_diagnostico TEXT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM consultas WHERE id = p_consulta_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Consulta nao encontrada';
    END IF;

    UPDATE consultas
    SET status = 'concluida',
        diagnostico = p_diagnostico
    WHERE id = p_consulta_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_pagamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_pagamento`(
    IN p_consulta_id INT,
    IN p_forma VARCHAR(50)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pagamentos WHERE consulta_id = p_consulta_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pagamento nao encontrado';
    END IF;

    IF EXISTS (
        SELECT 1 FROM pagamentos
        WHERE consulta_id = p_consulta_id
        AND status = 'pago'
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pagamento ja esta pago';
    END IF;

    UPDATE pagamentos
    SET status = 'pago',
        forma_pagamento = p_forma
    WHERE consulta_id = p_consulta_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_agenda_hoje`
--

/*!50001 DROP VIEW IF EXISTS `vw_agenda_hoje`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_agenda_hoje` AS select `vw_consultas_completas`.`data_hora` AS `data_hora`,`vw_consultas_completas`.`status` AS `status`,`vw_consultas_completas`.`diagnostico` AS `diagnostico`,`vw_consultas_completas`.`valor` AS `valor`,`vw_consultas_completas`.`animal` AS `animal`,`vw_consultas_completas`.`especie` AS `especie`,`vw_consultas_completas`.`tutor` AS `tutor`,`vw_consultas_completas`.`telefone` AS `telefone`,`vw_consultas_completas`.`veterinario` AS `veterinario`,`vw_consultas_completas`.`especialidade` AS `especialidade`,`vw_consultas_completas`.`forma_pagamento` AS `forma_pagamento`,`vw_consultas_completas`.`status_pagamento` AS `status_pagamento` from `vw_consultas_completas` where (cast(`vw_consultas_completas`.`data_hora` as date) = curdate()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_animais_detalhados`
--

/*!50001 DROP VIEW IF EXISTS `vw_animais_detalhados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_animais_detalhados` AS select `a`.`id` AS `id`,`a`.`nome` AS `animal`,`a`.`especie` AS `especie`,`a`.`raca` AS `raca`,`a`.`data_nascimento` AS `data_nascimento`,`t`.`nome` AS `tutor`,`t`.`telefone` AS `telefone`,count(`c`.`id`) AS `total_consultas` from ((`animais` `a` join `tutores` `t` on((`a`.`tutor_id` = `t`.`id`))) left join `consultas` `c` on((`c`.`animal_id` = `a`.`id`))) group by `a`.`id`,`a`.`nome`,`a`.`especie`,`a`.`raca`,`a`.`data_nascimento`,`t`.`nome`,`t`.`telefone` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_consultas_completas`
--

/*!50001 DROP VIEW IF EXISTS `vw_consultas_completas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_consultas_completas` AS select `c`.`data_hora` AS `data_hora`,'Concluída' AS `status`,`c`.`diagnostico` AS `diagnostico`,`c`.`valor` AS `valor`,`a`.`nome` AS `animal`,`a`.`especie` AS `especie`,`t`.`nome` AS `tutor`,`t`.`telefone` AS `telefone`,`v`.`nome` AS `veterinario`,`v`.`especialidade` AS `especialidade`,`p`.`forma_pagamento` AS `forma_pagamento`,`p`.`status` AS `status_pagamento` from ((((`consultas` `c` join `animais` `a` on((`c`.`animal_id` = `a`.`id`))) join `tutores` `t` on((`a`.`tutor_id` = `t`.`id`))) join `veterinarios` `v` on((`c`.`veterinario_id` = `v`.`id`))) left join `pagamentos` `p` on((`p`.`consulta_id` = `c`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_faturamento_mensal`
--

/*!50001 DROP VIEW IF EXISTS `vw_faturamento_mensal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_faturamento_mensal` AS select year(`vw_consultas_completas`.`data_hora`) AS `ano`,month(`vw_consultas_completas`.`data_hora`) AS `mes`,`vw_consultas_completas`.`veterinario` AS `veterinario`,count(0) AS `total_consultas`,sum(`vw_consultas_completas`.`valor`) AS `faturamento_total` from `vw_consultas_completas` group by year(`vw_consultas_completas`.`data_hora`),month(`vw_consultas_completas`.`data_hora`),`vw_consultas_completas`.`veterinario` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_inadimplentes`
--

/*!50001 DROP VIEW IF EXISTS `vw_inadimplentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_inadimplentes` AS select `vw_consultas_completas`.`data_hora` AS `data_hora`,`vw_consultas_completas`.`status` AS `status`,`vw_consultas_completas`.`diagnostico` AS `diagnostico`,`vw_consultas_completas`.`valor` AS `valor`,`vw_consultas_completas`.`animal` AS `animal`,`vw_consultas_completas`.`especie` AS `especie`,`vw_consultas_completas`.`tutor` AS `tutor`,`vw_consultas_completas`.`telefone` AS `telefone`,`vw_consultas_completas`.`veterinario` AS `veterinario`,`vw_consultas_completas`.`especialidade` AS `especialidade`,`vw_consultas_completas`.`forma_pagamento` AS `forma_pagamento`,`vw_consultas_completas`.`status_pagamento` AS `status_pagamento` from `vw_consultas_completas` where ((`vw_consultas_completas`.`status_pagamento` is null) or (`vw_consultas_completas`.`status_pagamento` = 'Pendente')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-15 20:28:30
