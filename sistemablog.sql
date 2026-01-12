CREATE DATABASE  IF NOT EXISTS `sistemablog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sistemablog`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: sistemablog
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `autores`
--

DROP TABLE IF EXISTS `autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autores` (
  `ID_Autor` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Email` varchar(150) NOT NULL,
  `Bio` text,
  PRIMARY KEY (`ID_Autor`),
  UNIQUE KEY `uk_autor_email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autores`
--

LOCK TABLES `autores` WRITE;
/*!40000 ALTER TABLE `autores` DISABLE KEYS */;
INSERT INTO `autores` VALUES (1,'Maria Eloisa','mariaeloisaaxr@gmail.com','Autora do blog Notas da MPB');
/*!40000 ALTER TABLE `autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `ID_Categoria` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  `Descricao` text,
  PRIMARY KEY (`ID_Categoria`),
  UNIQUE KEY `Nome` (`Nome`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Análises','Análises de letras e músicas'),(2,'História','História da música popular brasileira'),(3,'Artistas','Perfis e trajetórias de artistas da MPB');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `letras`
--

DROP TABLE IF EXISTS `letras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `letras` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `artista` varchar(100) NOT NULL,
  `letra` longtext NOT NULL,
  `data_criacao` datetime DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `visualizacoes` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `letras`
--

LOCK TABLES `letras` WRITE;
/*!40000 ALTER TABLE `letras` DISABLE KEYS */;
INSERT INTO `letras` VALUES (1,'Cálice','Gilberto Gil e Chico Buarque','Pai, afasta de mim esse cálice\nPai, afasta de mim esse cálice\nPai, afasta de mim esse cálice\nDe vinho tinto de sangue\n\nComo beber dessa bebida amarga\nTragar a dor, engolir a labuta\nMesmo calada a boca, reste a vontade\nDe custe a custa expiar a culpa\n\nQue seja maldito, que seja bendito\nO fruto dessa terra do suor\nDe muito sangue, de manhã cevada\nE muito, muito suor\n\nVai se embora, vai se embora\nMeu cálice, meu cálice\nVai se embora de mim','2026-01-12 00:28:38','2026-01-12 00:28:38',7),(2,'Águas de Março','Tom Jobim e Chico Buarque','É um dom que a gente pede\nPor pedir, e porque sim\nÁguas de março fechando o verão\nÉ a promessa de vida no teu coração\n\nÉ a água da chuva, cai chacoalha\nÉ a inércia da lástima na caixa de fósforo\nÉ o resto de meu toco de cigarro\nÉ a mulher que rabisca e escreve nos higiênicos\n\nÉ a vontade de chuva nos meus olhos\nÁgua que o rio não perdoa nem deixa passar\nÉ a vontade de dizer que a vida é vã\nÉ a vontade de beber água do pântano\n\nÉ a saudade da vida, é a vontade\nPor querer bem e acabar assim, plebeu\nÉ amor, é dor, é luta renhida e é corpo fechado','2026-01-12 00:28:38','2026-01-12 00:28:38',5),(3,'Que País é Este','Legião Urbana','Que país é este\nEm que se usa a gravata com o robe\nEm que se bate palmas em favor da impunidade\n\nQue país é este\nEm que um homem de bem vale mais que uma mulher de bem\nE em que o seu direito acaba onde começa o do outro\n\nQue país é este\nEm que um pobre anda preso\nE um rico está sempre livre\nE em que a polícia não existe pra nos defender\n\nQue país é este\nEm que se mata de forma lenta\nOs que buscam a verdade e a certeza\nEnquanto vivem livres aqueles que as ocultam\n\nQue país é este','2026-01-12 00:28:38','2026-01-12 00:28:38',3);
/*!40000 ALTER TABLE `letras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `ID_Post` int NOT NULL AUTO_INCREMENT,
  `Titulo` varchar(200) NOT NULL,
  `Slug` varchar(200) NOT NULL,
  `Conteudo` text NOT NULL,
  `ID_Categoria` int NOT NULL,
  `ID_Autor` int NOT NULL,
  `Data_Publicacao` datetime DEFAULT CURRENT_TIMESTAMP,
  `Visualizacoes` int DEFAULT '0',
  `Status` varchar(20) DEFAULT 'Publicado',
  PRIMARY KEY (`ID_Post`),
  UNIQUE KEY `Slug` (`Slug`),
  KEY `ID_Categoria` (`ID_Categoria`),
  KEY `ID_Autor` (`ID_Autor`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`ID_Categoria`) REFERENCES `categorias` (`ID_Categoria`),
  CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`ID_Autor`) REFERENCES `autores` (`ID_Autor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'sistemablog'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-12  0:37:15
