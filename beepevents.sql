-- MySQL dump 10.16  Distrib 10.1.19-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: localhost
-- ------------------------------------------------------
-- Server version	10.1.19-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `client_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `domain_name` varchar(32) DEFAULT NULL,
  `email` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `reg_date` datetime DEFAULT NULL,
  `secret_id` varchar(32) DEFAULT NULL,
  `passcode` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'UPITDC','www.upitdc.com','UPITDC@email.com','1234','2017-01-19 00:00:00','1234','1234'),(3,'Eman','EmanTicket.net','eman@gmail.com','1234','2017-01-23 00:00:00','b89b06437ed3e990d004','404ef4591e5bbe70f297'),(4,'TicketNet','Ticketworld.com','emanoy_mane@yahoo.com','1234','2017-01-22 00:00:00','bec556e8952721e4c5bb','b4885d3c5e0262182fda'),(5,'Beep Ticket','www.beepticket.com','haha@yahoo.com','1234','2017-01-23 00:00:00','608a3defac92db2cf5c6','60da21a33502a7dd4e81'),(9,'Super Admin','admin','admin@gmail.com','1234','2017-01-24 00:00:00','e327362ae1d7ff0e326f','43fb6c7b2151f63a068c'),(12,'Eman','','Twitter Account','twitter-2286035413','2017-01-25 00:00:00','c7883b8a12eef072090e','92ee899a91973fd8f691'),(15,'Eman Tangonan',NULL,'fb-1657502550943453','fb-1657502550943453','2017-01-25 15:47:09','53aba5f20b20e5269907','9b17438464cb09fd852a'),(16,'Eman Tangonan',NULL,'twitter-2286035413','twitter-2286035413','2017-01-25 16:48:08','45d71d45850ab68ef159','f51ff908e57d7b4e28e3');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `cs_id` varchar(32) NOT NULL,
  `client_id` int(11) NOT NULL,
  `title` varchar(32) NOT NULL,
  `img_url` varchar(256) DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `event_passcode` varchar(32) NOT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'1234sddfa124',1,'Brandi Show','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLQT3Ia6UP5xXbm6D9g4OBO0pxKaV5GC-C3e9ggVgedzWxcly6-A','2017-01-26 09:00:00','2017-01-26 12:00:00','e38e9c5ff7b7249088b1'),(8,'122asda244',1,'Nihongo Kabuki','http://cdn.tokyotimes.com/wp-content/uploads/2013/03/kabuki.jpg?w=240','2017-01-28 16:00:00','2017-01-28 20:00:00','a7cf4d36e443ad3b4d22'),(11,'dfasdgh132',1,'Presentation','http://img.freepik.com/free-vector/business-presentation_23-2147511785.jpg?size=338&ext=jpg','2017-01-30 13:00:00','2017-01-30 17:00:00','38d8f1a77b41e77824f5'),(12,'1235dfsd12',1,'Mocha Show','http://1.bp.blogspot.com/-RcyzXEjufFk/T3Vb3lQlA3I/AAAAAAAAADI/2jV6EbdB_cw/s1600/mocha-flag-tattoo.jpg','2017-02-01 20:00:00','2017-02-01 23:00:00','d73d0f7ba982807ca69f'),(13,'1235dfsd13',1,'Porn Show','https://i.ytimg.com/vi/0XYklTRj6zc/maxresdefault.jpg','2017-01-29 15:00:00','2017-01-29 19:00:00','d0983796a3051fbd31c1'),(14,'123asdsd32',1,'Gabo Show','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSP3uJkNa3fMU4yIl-Zsz-ODOl9WIphQ8zgZmpJpGgKSJzj-aR62Q','2017-01-30 08:00:00','2017-01-30 12:00:00','b19933bff29ee4f6bcc0'),(15,'1dsfsddfa124',1,'Allan Show','http://humanorigins.si.edu/sites/default/files/styles/full_width/public/images/square/erectus_JC_Recon_Head_CC_f_sq.jpg?itok=9Ppv5SG2q=tbn:ANd9GcTLQT3Ia6UP5xXbm6D9g4OBO0pxKaV5GC-C3e9ggVgedzWxcly6-A','2017-01-25 09:30:00','2017-01-25 12:11:24','6d07e3f68374db99a4ef'),(17,'1dsfsasdffa124',3,'Charles Show','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLQT3Ia6UP5xXbm6D9g4OBO0pxKaV5GC-C3e9ggVgedzWxcly6-A','2017-01-02 08:00:00','2017-01-02 12:00:00','76bf6dc04c14e3ba321e');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_event`
--

DROP TABLE IF EXISTS `user_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_event` (
  `ue_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `card_id` varchar(32) NOT NULL,
  `seat_number` varchar(8) DEFAULT NULL,
  `is_valid` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ue_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_event`
--

LOCK TABLES `user_event` WRITE;
/*!40000 ALTER TABLE `user_event` DISABLE KEYS */;
INSERT INTO `user_event` VALUES (1,1,'123','1A',0),(5,12,'049539C2463E80',NULL,0);
/*!40000 ALTER TABLE `user_event` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-25 19:57:29
