-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: topic
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `advertise`
--

DROP TABLE IF EXISTS `advertise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertise` (
  `advertiseid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `location` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `createtime` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `url` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `img` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`advertiseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='廣告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertise`
--

LOCK TABLES `advertise` WRITE;
/*!40000 ALTER TABLE `advertise` DISABLE KEYS */;
INSERT INTO `advertise` VALUES ('0f8e03b729c44d219b13bdaea6e97e58','中','2022-06-28','Join System','https://www.jetec.com.tw/chinese/2020/11/product3-1_JoinSystem.html','be2cae4a915045f3b1c82de1aba94b2e.png','2022-06-28 17:11:11'),('120304ffafa2485594accd10341e39e2','中','2022-06-30','TTM-210','https://www.jetec.com.tw/chinese/product2-1_TTM210.html','52157992cf97483c9bc92c7c2177cb87.png','2022-06-30 10:35:16'),('53d779362eee4b018a2712767e161732','右','2022-06-28','bbb1','bbb1','4261dddadb6c40a3bac90013435bd31a.gif','2022-06-27 17:43:42'),('7df8d27862db4d27ab4da60e1d5401cc','右','2022-06-28','王小虎','https://www.jetec.com.tw/','638958e9bd3d4ca6b6a6ca0e4f18bf87.gif','2022-06-27 17:19:05'),('888cc1870a424ce6b40347504f0f86e9','中','2022-06-28','多功能大型顯示看板','https://www.jetec.com.tw/chinese/product1-1_JTCX40A.html','0a3b673fc4c94962a9c67c1253be718a.png','2022-06-28 17:16:22'),('90995082c066470a8f25b4101271702c','右','2022-06-28','aaa','https://www.jetec.com.tw/Project-touch','a9ce4c17bfcc4335ae7c2353c64d6fca.png','2022-06-27 17:19:15');
/*!40000 ALTER TABLE `advertise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article` (
  `articleid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'id',
  `memberid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '發表人id',
  `state` char(3) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '狀態',
  `createtime` char(16) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '創造時間',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '主題',
  `replytime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '最後回覆時間',
  `articlegroup` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '文章群組',
  `membername` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '發表人名稱',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`articleid`),
  KEY `article_articlegroup_state_createtime_IDX` (`articlegroup`,`state`,`createtime` DESC) USING BTREE,
  KEY `article_memberid_createtime_IDX` (`memberid`,`createtime` DESC) USING BTREE,
  KEY `article_memberid_state_IDX` (`memberid`,`state`) USING BTREE,
  KEY `article_state_createtime_IDX` (`state`,`createtime` DESC) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='文章';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES ('4a8f2b40cf4c4a6a875036d0192fcac3','609eb996f31c4442b586a3c3430ba53f','未驗證','2022-07-15 17:33','網管測試','2022-07-15 17:33','sensor','AAA','2022-07-15 17:33:21','2022-07-15 17:33:21'),('546e75413eb249eea899b135b404578c','609eb996f31c4442b586a3c3430ba53f','允許','2022-07-15 16:09','登高','2022-07-15 16:09','apparatus','AAA','2022-07-15 16:09:53','2022-07-15 16:09:45'),('89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','允許','2022-07-15 15:48','TTTTT','2022-07-15 15:48','sensor','AAA','2022-07-15 15:49:02','2022-07-15 15:48:41');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_content`
--

DROP TABLE IF EXISTS `article_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article_content` (
  `articleid` char(32) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`articleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_content`
--

LOCK TABLES `article_content` WRITE;
/*!40000 ALTER TABLE `article_content` DISABLE KEYS */;
INSERT INTO `article_content` VALUES ('4a8f2b40cf4c4a6a875036d0192fcac3','XXXXXX'),('546e75413eb249eea899b135b404578c','<div class=\"section2\" style=\"padding: 0px; margin: 10px 0px 0px; color: #0f0f0f; clear: both; overflow: auto; font-size: 14px; line-height: 28px; font-family: &Euml;&Icirc;&Igrave;&aring;, Arial, Helvetica;\">\r\n<p class=\"sub\" style=\"padding: 0px; margin: 3px; line-height: 21px;\"><span style=\"line-height: 16px; color: #606060;\">朝代：</span><span style=\"line-height: 16px; color: #606060;\">唐代</span></p>\r\n<p class=\"sub\" style=\"padding: 0px; margin: 3px; line-height: 21px;\"><span style=\"line-height: 16px; color: #606060;\">作者：</span><span style=\"line-height: 16px; color: #606060;\"><a style=\"color: #762a00; text-decoration-line: none; line-height: 16px;\" title=\"杜甫簡介\" href=\"https://fanti.dugushici.com/ancient_authors/474\">杜甫</a></span></p>\r\n<p class=\"sub\" style=\"padding: 0px; margin: 3px; line-height: 21px;\"><span style=\"line-height: 16px; color: #606060;\">原文：</span></p>\r\n<div class=\"content\" style=\"padding: 0px; margin: 0px;\">風急天高猿嘯哀，渚清沙白鳥飛回。<br />無邊落木蕭蕭下，不盡長江滾滾來。<br />萬里悲秋常作客，百年多病獨登臺。<br />艱難苦恨繁霜鬢，潦倒新停濁酒杯。</div>\r\n</div>\r\n<div class=\"shangxi\" style=\"padding: 5px 10px 5px 0px; margin: 30px 0px 0px; color: #0f0f0f; font-size: 14px; border: 0px solid floralwhite; border-radius: 3px; background-image: url(\'../../assets/rightbg2.gif\'); background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; overflow: hidden; font-family: &Euml;&Icirc;&Igrave;&aring;, Arial, Helvetica;\">\r\n<h3 style=\"padding: 0px; margin: 10px 0px 15px; font-size: 16px; border-bottom: 1px solid #8d061f;\">譯文及註釋</h3>\r\n<span class=\"more\" style=\"line-height: 16px;\"><a style=\"color: #762a00; text-decoration-line: none; line-height: 16px; margin: -35px 0px 10px; float: right;\" title=\"登高_譯文及註釋\" href=\"https://fanti.dugushici.com/ancient_proses/10878/prose_translations/1012\">更多</a></span>\r\n<div style=\"padding: 0px; margin: 0px; clear: both;\">作者：佚名<br /><strong>譯文</strong><br />風急天高猿猴啼叫顯得十分悲哀，水清沙白的河洲上有鳥兒在盤旋。<br />無邊無際的樹木蕭蕭地飄下落葉，望不到頭的長江水滾滾奔騰而來。<br />悲對秋景感慨萬里漂泊常年爲客，一生當中疾病纏身今日獨上高臺。<br />歷盡了艱難苦恨白髮長滿了雙鬢，衰頹滿心偏又暫停了澆愁的酒杯</div>\r\n</div>'),('89c9a705b2bf42e8b8e0b0ece50ec8b6','<p>TTTTT</p>\r\n<p>AAAAA</p>\r\n<p>BBBBB</p>\r\n<p>SSSSS</p>');
/*!40000 ALTER TABLE `article_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_reply`
--

DROP TABLE IF EXISTS `article_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article_reply` (
  `replyid` char(32) NOT NULL COMMENT 'id',
  `articleid` char(32) NOT NULL COMMENT '文章id',
  `memberid` char(32) CHARACTER SET utf8mb4  DEFAULT NULL COMMENT '回復人id',
  `membername` varchar(100) DEFAULT NULL COMMENT '回復人名',
  `content` mediumtext NOT NULL COMMENT '內容',
  `createtime` varchar(20) DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `floor` int unsigned DEFAULT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`replyid`),
  KEY `articleid_memberid_IDX` (`articleid`,`memberid`) USING BTREE,
  KEY `articleid_createtime_IDX` (`articleid`,`createtime`) USING BTREE,
  KEY `article_reply_memberid_IDX` (`memberid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4  COMMENT='文章回復';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_reply`
--

LOCK TABLES `article_reply` WRITE;
/*!40000 ALTER TABLE `article_reply` DISABLE KEYS */;
INSERT INTO `article_reply` VALUES ('11af17fc4be144e9a7904406feed8479','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>11111111111</p>','2022-07-15 16:46','未讀',2,'2022-07-15 16:46:44','2022-07-15 16:46:44'),('1ad784c3eeb0441885af814aaf01c0aa','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>13</p>','2022-07-18 09:49','未讀',13,'2022-07-18 09:49:33','2022-07-18 09:49:33'),('23056eb6007a425cae359c46f5876132','11af17fc4be144e9a7904406feed8479','609eb996f31c4442b586a3c3430ba53f','AAA','BBB','2022-07-18 10:53',NULL,NULL,'2022-07-18 10:53:45','2022-07-18 10:53:45'),('2d178ac74a054997ba1e234ae95fb59c','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>5555555555</p>','2022-07-15 17:07','未讀',6,'2022-07-15 17:07:35','2022-07-15 17:07:35'),('3877e8541795457fb525da39484f84cd','6c4a154ce59741929d72b9ecbe83e94a','609eb996f31c4442b586a3c3430ba53f','AAA','SAA','2022-07-18 10:59',NULL,NULL,'2022-07-18 10:59:37','2022-07-18 10:59:37'),('395fbedbd62e403b818316820cb08c97','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>AAAAA</p>','2022-07-15 17:10','未讀',11,'2022-07-15 17:10:32','2022-07-15 17:10:32'),('3c628e5a2206443aad2fd20c6920b4a0','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>15</p>','2022-07-18 09:49','未讀',15,'2022-07-18 09:49:49','2022-07-18 09:49:49'),('534e9ff95ec843faa33b18af1bdfad1a','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>4444444</p>','2022-07-15 16:47','未讀',5,'2022-07-15 16:47:55','2022-07-15 16:47:55'),('5c4fc30475ee4d91ad20a8eb41f47e3e','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>999999999999</p>','2022-07-15 17:10','未讀',10,'2022-07-15 17:10:06','2022-07-15 17:10:06'),('69e5418831774025bc5d030c80295d98','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>14</p>','2022-07-18 09:49','未讀',14,'2022-07-18 09:49:42','2022-07-18 09:49:42'),('6c4a154ce59741929d72b9ecbe83e94a','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>21</p>','2022-07-18 09:51','未讀',21,'2022-07-18 09:51:05','2022-07-18 09:51:05'),('6ece24705b3b449e9f893f48d943afc2','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>333333333</p>','2022-07-15 16:47','未讀',4,'2022-07-15 16:47:32','2022-07-15 16:47:32'),('714dc13ecaba4662bff89aed46765550','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>88888888888</p>','2022-07-15 17:09','未讀',9,'2022-07-15 17:09:45','2022-07-15 17:09:45'),('7e0e9a02868343c4a82bf2d5cd522c43','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>7777777777777</p>','2022-07-15 17:08','未讀',8,'2022-07-15 17:08:32','2022-07-15 17:08:32'),('ac912401c5d54bc486fa28d149d9156c','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>16</p>','2022-07-18 09:50','未讀',16,'2022-07-18 09:50:08','2022-07-18 09:50:08'),('bd86eac1262842c88c117dd4ba8fdf23','11af17fc4be144e9a7904406feed8479','609eb996f31c4442b586a3c3430ba53f','AAA','CCC','2022-07-18 10:54',NULL,NULL,'2022-07-18 10:54:14','2022-07-18 10:54:14'),('c4f55de9ace84401b3036f648b5ccff4','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>20</p>','2022-07-18 09:50','未讀',20,'2022-07-18 09:50:50','2022-07-18 09:50:50'),('d20303e3047b4e8d8b07f6fe1199b8e5','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>17</p>','2022-07-18 09:50','未讀',17,'2022-07-18 09:50:16','2022-07-18 09:50:16'),('d5ce50b10cd7447dbfb1cceca31cb4e8','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>22222222222</p>','2022-07-15 16:46','未讀',3,'2022-07-15 16:46:54','2022-07-15 16:46:54'),('d619c64a4a19457ea2c3f5602ceaf171','11af17fc4be144e9a7904406feed8479','609eb996f31c4442b586a3c3430ba53f','AAA','AAA','2022-07-18 10:53',NULL,NULL,'2022-07-18 10:53:16','2022-07-18 10:53:16'),('dbc8ad6234974a70907f659d2106eff9','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>6666666666666</p>','2022-07-15 17:08','未讀',7,'2022-07-15 17:08:11','2022-07-15 17:08:11'),('e0f7371c75b24e68a829eaafc660db72','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>12</p>','2022-07-18 09:49','未讀',12,'2022-07-18 09:49:27','2022-07-18 09:49:27'),('f5d42a5961f9413c8c51749f8255685c','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>19</p>','2022-07-18 09:50','未讀',19,'2022-07-18 09:50:40','2022-07-18 09:50:40'),('ff3b2612f6034e26a0ce1432daef23bb','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','AAA','<p>18</p>','2022-07-18 09:50','未讀',18,'2022-07-18 09:50:29','2022-07-18 09:50:29');
/*!40000 ALTER TABLE `article_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_return`
--

DROP TABLE IF EXISTS `article_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article_return` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `articleid` char(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `replyid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `memberid` char(32) COLLATE utf8mb4_bin NOT NULL,
  `returntype` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '類型',
  `state` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '狀態',
  `membername` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '內容',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_return`
--

LOCK TABLES `article_return` WRITE;
/*!40000 ALTER TABLE `article_return` DISABLE KEYS */;
/*!40000 ALTER TABLE `article_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_thumbsup`
--

DROP TABLE IF EXISTS `article_thumbsup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article_thumbsup` (
  `thumbsupid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `articleid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `memberid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`thumbsupid`),
  KEY `article_thumbsup_articleid_IDX` (`articleid`) USING BTREE,
  KEY `article_thumbsup_memberid_IDX` (`memberid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='點讚表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_thumbsup`
--

LOCK TABLES `article_thumbsup` WRITE;
/*!40000 ALTER TABLE `article_thumbsup` DISABLE KEYS */;
INSERT INTO `article_thumbsup` VALUES ('0f561d2c4a094d4bad5c22366486ebfa','11af17fc4be144e9a7904406feed8479','609eb996f31c4442b586a3c3430ba53f','2022-07-18 10:51:21'),('93b463ed9cc8494f8f5655939be7024b','89c9a705b2bf42e8b8e0b0ece50ec8b6','609eb996f31c4442b586a3c3430ba53f','2022-07-18 10:51:20');
/*!40000 ALTER TABLE `article_thumbsup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorize`
--

DROP TABLE IF EXISTS `authorize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorize` (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `memberid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='會員註冊 認證用\r\n忘記密碼 認證用';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorize`
--

LOCK TABLES `authorize` WRITE;
/*!40000 ALTER TABLE `authorize` DISABLE KEYS */;
INSERT INTO `authorize` VALUES ('d903cbf77a8b493f91fb8bacaf81b876','d8e5b2c7fa7247738f8c0cff43f21027','2022-07-15 17:29:52','2022-07-15 17:29:52');
/*!40000 ALTER TABLE `authorize` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file` (
  `fileid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `memberid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `createtime` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fileid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='紀錄檔案';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `memberid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '會員id',
  `integral` int DEFAULT NULL COMMENT '積分',
  `email` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `company` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '公司',
  `phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '地址',
  `birthday` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '生日',
  `createtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '創建日',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`memberid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='會員';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('354039949d93459ca4f5e3794b3a446b',100,'jetecmarketing03@gmail.com','Amber','$2a$10$l/SW9d5LHR7SICT5Yi6wweM2cMEbGULKPTGNJnppGReCZswT/cfgu','','',NULL,NULL,'2022-05-31 10:04','2022-06-24 10:52:44','2022-06-20 09:05:32'),('609eb996f31c4442b586a3c3430ba53f',230,'AAA@AAA.com','AAA','$2a$10$Ed6xccxj7rD6WKglN0ribekKcA1Tiv4cpjVqd5PREzxtK2pd.lUJG','AAA','AAA','BBB','2022 年 06 月 16 日','2022-05-19 16:57','2022-07-18 10:51:20',NULL),('d8e5b2c7fa7247738f8c0cff43f21027',1,'jeter.tony56@gmail.com','灰灰','$2a$10$v7P.oyGKHAqZ6xdjGogcjOQi7QXF0noXmyD8oTaRc9jggyBC8Vk3u','ffffffffffff','+886421111111','','','2022-06-30 09:17','2022-07-13 13:20:41',NULL),('e9c17dfd095c45df99ef3034168fe06c',0,'BBB@AAA.com','BBB','$2a$10$7/E8tT3M1gXr4dV6hjGXauAN.4j3cRoHs.I8l2fnjq.QN.mKFekZ.','AAA','AAA',NULL,NULL,'2022-05-19 17:13','2022-06-20 08:58:18','2022-06-20 09:05:32');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permit`
--

DROP TABLE IF EXISTS `permit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permit` (
  `permitid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '權限id',
  `memberid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '外鍵',
  `level` tinyint unsigned NOT NULL COMMENT '權限',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`permitid`),
  KEY `permit_FK` (`memberid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='權限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permit`
--

LOCK TABLES `permit` WRITE;
/*!40000 ALTER TABLE `permit` DISABLE KEYS */;
INSERT INTO `permit` VALUES ('083cd6331ca647d2ac2c9dc4f072af8b','609eb996f31c4442b586a3c3430ba53f',8,'2022-06-27 15:00:17','2022-06-27 15:00:17'),('327fc2cd87b7453d86a7bc27659e17fc','d8e5b2c7fa7247738f8c0cff43f21027',1,'2022-07-05 11:37:06','2022-07-05 11:37:06'),('609eb996f31c4442b586a3c3430ba53f','609eb996f31c4442b586a3c3430ba53f',1,'2022-06-27 14:09:25','2022-06-27 13:12:28'),('6dfc6ca89ad946568c23bf618e5bbe6c','d8e5b2c7fa7247738f8c0cff43f21027',0,'2022-06-30 09:17:42','2022-06-30 09:17:42'),('a239044ef68c41ed8ede0ee8261818b8','609eb996f31c4442b586a3c3430ba53f',2,'2022-06-27 11:09:00','2022-06-27 11:09:00'),('af614b3153424761ac5047be9ec6492c','609eb996f31c4442b586a3c3430ba53f',0,'2022-06-23 15:53:10','2022-06-23 14:11:09'),('dff461c21bac4c4fb13b4e5908820f63','609eb996f31c4442b586a3c3430ba53f',9,'2022-06-27 15:00:18','2022-06-27 15:00:18');
/*!40000 ALTER TABLE `permit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persistent_logins`
--

DROP TABLE IF EXISTS `persistent_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persistent_logins` (
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `series` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `token` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `last_used` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`series`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persistent_logins`
--

LOCK TABLES `persistent_logins` WRITE;
/*!40000 ALTER TABLE `persistent_logins` DISABLE KEYS */;
INSERT INTO `persistent_logins` VALUES ('AAA@AAA.com','mLb+kcaqcLP7IdYBFK44Fw==','UEmkzgco7drzJtQxK/9AtQ==','2022-07-18 08:08:32');
/*!40000 ALTER TABLE `persistent_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watch`
--

DROP TABLE IF EXISTS `watch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `watch` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `memberid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `articleid` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `watchtime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watch`
--

LOCK TABLES `watch` WRITE;
/*!40000 ALTER TABLE `watch` DISABLE KEYS */;
INSERT INTO `watch` VALUES (20,'609eb996f31c4442b586a3c3430ba53f','4b8c9a713d054c128b35511c641ddb37','2022-07-15 15:46:41'),(21,'system','89c9a705b2bf42e8b8e0b0ece50ec8b6','2022-07-15 15:49:05'),(22,'609eb996f31c4442b586a3c3430ba53f','89c9a705b2bf42e8b8e0b0ece50ec8b6','2022-07-18 11:10:57'),(23,'system','546e75413eb249eea899b135b404578c','2022-07-15 16:09:52'),(24,'609eb996f31c4442b586a3c3430ba53f','546e75413eb249eea899b135b404578c','2022-07-18 10:06:03'),(25,'609eb996f31c4442b586a3c3430ba53f','4a8f2b40cf4c4a6a875036d0192fcac3','2022-07-18 09:55:48');
/*!40000 ALTER TABLE `watch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'topic'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-18 16:26:06
