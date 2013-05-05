-- MySQL dump 10.13  Distrib 5.1.45, for Win32 (ia32)
--
-- Host: localhost    Database: branchout
-- ------------------------------------------------------
-- Server version	5.1.45-community

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
-- Table structure for table `academic_assignassignment`
--

DROP TABLE IF EXISTS `academic_assignassignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_assignassignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `selectassignment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_assignassignment_2159e53` (`selectassignment_id`),
  KEY `academic_assignassignment_403f60f` (`user_id`),
  CONSTRAINT `selectassignment_id_refs_id_6787dbd2` FOREIGN KEY (`selectassignment_id`) REFERENCES `academic_assignment` (`id`),
  CONSTRAINT `user_id_refs_id_1a4023bd` FOREIGN KEY (`user_id`) REFERENCES `academic_assignmentuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_assignassignment`
--

LOCK TABLES `academic_assignassignment` WRITE;
/*!40000 ALTER TABLE `academic_assignassignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_assignassignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_assignment`
--

DROP TABLE IF EXISTS `academic_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_dt` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `title` varchar(50) NOT NULL,
  `descp` longtext NOT NULL,
  `points` int(11) NOT NULL,
  `apply_due_date` date NOT NULL,
  `allow_late` tinyint(1) NOT NULL,
  `disable_submission` tinyint(1) NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_assignment_638462f1` (`subject_id`),
  CONSTRAINT `subject_id_refs_id_167a4263` FOREIGN KEY (`subject_id`) REFERENCES `academic_institutesubjects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_assignment`
--

LOCK TABLES `academic_assignment` WRITE;
/*!40000 ALTER TABLE `academic_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_assignmentuser`
--

DROP TABLE IF EXISTS `academic_assignmentuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_assignmentuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assignment_id` int(11) NOT NULL,
  `enrollment_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_assignmentuser_482b57ab` (`assignment_id`),
  KEY `academic_assignmentuser_ab10102` (`enrollment_id`),
  KEY `academic_assignmentuser_403f60f` (`user_id`),
  CONSTRAINT `assignment_id_refs_id_620e292e` FOREIGN KEY (`assignment_id`) REFERENCES `academic_assignment` (`id`),
  CONSTRAINT `enrollment_id_refs_id_4d2cfbf1` FOREIGN KEY (`enrollment_id`) REFERENCES `academic_enrollment` (`id`),
  CONSTRAINT `user_id_refs_id_78355315` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_assignmentuser`
--

LOCK TABLES `academic_assignmentuser` WRITE;
/*!40000 ALTER TABLE `academic_assignmentuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_assignmentuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_batch`
--

DROP TABLE IF EXISTS `academic_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_batch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_dt` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `title` varchar(20) NOT NULL,
  `start_dt` date NOT NULL,
  `end_dt` date NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_batch`
--

LOCK TABLES `academic_batch` WRITE;
/*!40000 ALTER TABLE `academic_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_enrollment`
--

DROP TABLE IF EXISTS `academic_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_enrollment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_dt` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `iclass_id` int(11) DEFAULT NULL,
  `access_mode` int(11) NOT NULL,
  `batch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_enrollment_403f60f` (`user_id`),
  KEY `academic_enrollment_1aa4824d` (`iclass_id`),
  KEY `academic_enrollment_58f424c5` (`batch_id`),
  CONSTRAINT `batch_id_refs_id_21ccd46a` FOREIGN KEY (`batch_id`) REFERENCES `academic_batch` (`id`),
  CONSTRAINT `iclass_id_refs_id_1f6c8488` FOREIGN KEY (`iclass_id`) REFERENCES `academic_instituteclass` (`id`),
  CONSTRAINT `user_id_refs_id_f562949` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_enrollment`
--

LOCK TABLES `academic_enrollment` WRITE;
/*!40000 ALTER TABLE `academic_enrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_institute`
--

DROP TABLE IF EXISTS `academic_institute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_institute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_dt` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL,
  `inst_user_id` int(11) DEFAULT NULL,
  `address` varchar(50) NOT NULL,
  `descp` longtext NOT NULL,
  `modifiedon` datetime NOT NULL,
  `modifiedby` varchar(30) NOT NULL,
  `emblem` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_institute_662a98f1` (`inst_user_id`),
  CONSTRAINT `inst_user_id_refs_id_305ed787` FOREIGN KEY (`inst_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_institute`
--

LOCK TABLES `academic_institute` WRITE;
/*!40000 ALTER TABLE `academic_institute` DISABLE KEYS */;
INSERT INTO `academic_institute` VALUES (1,'2013-02-05 00:00:00','','hi-tech',NULL,'gzb','engg. college','2013-02-05 10:32:46','','');
/*!40000 ALTER TABLE `academic_institute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_instituteclass`
--

DROP TABLE IF EXISTS `academic_instituteclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_instituteclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_dt` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL,
  `icourse_id` int(11) NOT NULL,
  `section` varchar(2) NOT NULL,
  `details` longtext NOT NULL,
  `class_teacher_id` int(11) DEFAULT NULL,
  `modified_dt` datetime NOT NULL,
  `modified_by` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_instituteclass_74ca5473` (`icourse_id`),
  KEY `academic_instituteclass_346843ca` (`class_teacher_id`),
  CONSTRAINT `class_teacher_id_refs_id_1e426787` FOREIGN KEY (`class_teacher_id`) REFERENCES `academic_instituteteacher` (`id`),
  CONSTRAINT `icourse_id_refs_id_443c98cd` FOREIGN KEY (`icourse_id`) REFERENCES `academic_institutecourse` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_instituteclass`
--

LOCK TABLES `academic_instituteclass` WRITE;
/*!40000 ALTER TABLE `academic_instituteclass` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_instituteclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_institutecourse`
--

DROP TABLE IF EXISTS `academic_institutecourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_institutecourse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_dt` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `duration` int(11) NOT NULL,
  `institute_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_institutecourse_25a0dd70` (`institute_id`),
  CONSTRAINT `institute_id_refs_id_2ad6ab94` FOREIGN KEY (`institute_id`) REFERENCES `academic_institute` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_institutecourse`
--

LOCK TABLES `academic_institutecourse` WRITE;
/*!40000 ALTER TABLE `academic_institutecourse` DISABLE KEYS */;
INSERT INTO `academic_institutecourse` VALUES (1,'2013-02-05 00:00:00','','computer science','asdnbkjasdfb',1,1);
/*!40000 ALTER TABLE `academic_institutecourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_institutesubjectmaster`
--

DROP TABLE IF EXISTS `academic_institutesubjectmaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_institutesubjectmaster` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_dt` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `name` varchar(20) NOT NULL,
  `institute_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_institutesubjectmaster_25a0dd70` (`institute_id`),
  CONSTRAINT `institute_id_refs_id_79e9e93c` FOREIGN KEY (`institute_id`) REFERENCES `academic_institute` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_institutesubjectmaster`
--

LOCK TABLES `academic_institutesubjectmaster` WRITE;
/*!40000 ALTER TABLE `academic_institutesubjectmaster` DISABLE KEYS */;
INSERT INTO `academic_institutesubjectmaster` VALUES (1,'2013-02-05 00:00:00','','physics',1);
/*!40000 ALTER TABLE `academic_institutesubjectmaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_institutesubjects`
--

DROP TABLE IF EXISTS `academic_institutesubjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_institutesubjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_dt` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `syllabus` longtext NOT NULL,
  `institute_course_id` int(11) NOT NULL,
  `subject_name_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_institutesubjects_76f24e13` (`institute_course_id`),
  KEY `academic_institutesubjects_680a6a6` (`subject_name_id`),
  CONSTRAINT `institute_course_id_refs_id_72f389e5` FOREIGN KEY (`institute_course_id`) REFERENCES `academic_institutecourse` (`id`),
  CONSTRAINT `subject_name_id_refs_id_14c41975` FOREIGN KEY (`subject_name_id`) REFERENCES `academic_institutesubjectmaster` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_institutesubjects`
--

LOCK TABLES `academic_institutesubjects` WRITE;
/*!40000 ALTER TABLE `academic_institutesubjects` DISABLE KEYS */;
INSERT INTO `academic_institutesubjects` VALUES (1,'2013-02-05 00:00:00','','physics','sdcsfsdf','thermodyanamic',1,1);
/*!40000 ALTER TABLE `academic_institutesubjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_instituteteacher`
--

DROP TABLE IF EXISTS `academic_instituteteacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_instituteteacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_dt` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_instituteteacher_403f60f` (`user_id`),
  CONSTRAINT `user_id_refs_id_34574ec0` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_instituteteacher`
--

LOCK TABLES `academic_instituteteacher` WRITE;
/*!40000 ALTER TABLE `academic_instituteteacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_instituteteacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_resources`
--

DROP TABLE IF EXISTS `academic_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_dt` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `title` varchar(50) NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  `descp` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_resources`
--

LOCK TABLES `academic_resources` WRITE;
/*!40000 ALTER TABLE `academic_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_submission`
--

DROP TABLE IF EXISTS `academic_submission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_submission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_dt` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `assignmentuser_id` int(11) NOT NULL,
  `submit_dt` date NOT NULL,
  `on_time` tinyint(1) NOT NULL,
  `points_earned` int(11) NOT NULL,
  `descp` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_submission_403f60f` (`user_id`),
  KEY `academic_submission_765fd49c` (`assignmentuser_id`),
  CONSTRAINT `assignmentuser_id_refs_id_6973608b` FOREIGN KEY (`assignmentuser_id`) REFERENCES `academic_assignmentuser` (`id`),
  CONSTRAINT `user_id_refs_id_63bfc033` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_submission`
--

LOCK TABLES `academic_submission` WRITE;
/*!40000 ALTER TABLE `academic_submission` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_submission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_teachersubjectclass`
--

DROP TABLE IF EXISTS `academic_teachersubjectclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_teachersubjectclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iteacher_id` int(11) NOT NULL,
  `isubject_id` int(11) NOT NULL,
  `iclass_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_teachersubjectclass_6fb79629` (`iteacher_id`),
  KEY `academic_teachersubjectclass_21921c1d` (`isubject_id`),
  KEY `academic_teachersubjectclass_1aa4824d` (`iclass_id`),
  CONSTRAINT `iclass_id_refs_id_295401b1` FOREIGN KEY (`iclass_id`) REFERENCES `academic_instituteclass` (`id`),
  CONSTRAINT `isubject_id_refs_id_12623417` FOREIGN KEY (`isubject_id`) REFERENCES `academic_institutesubjects` (`id`),
  CONSTRAINT `iteacher_id_refs_id_3cf0edeb` FOREIGN KEY (`iteacher_id`) REFERENCES `academic_instituteteacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_teachersubjectclass`
--

LOCK TABLES `academic_teachersubjectclass` WRITE;
/*!40000 ALTER TABLE `academic_teachersubjectclass` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_teachersubjectclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_425ae3c4` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_5886d21f` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_message`
--

DROP TABLE IF EXISTS `auth_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_message_403f60f` (`user_id`),
  CONSTRAINT `user_id_refs_id_650f49a6` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_message`
--

LOCK TABLES `auth_message` WRITE;
/*!40000 ALTER TABLE `auth_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_1bb8f392` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add site',1,'add_site'),(2,'Can change site',1,'change_site'),(3,'Can delete site',1,'delete_site'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add message',5,'add_message'),(14,'Can change message',5,'change_message'),(15,'Can delete message',5,'delete_message'),(16,'Can add content type',6,'add_contenttype'),(17,'Can change content type',6,'change_contenttype'),(18,'Can delete content type',6,'delete_contenttype'),(19,'Can add session',7,'add_session'),(20,'Can change session',7,'change_session'),(21,'Can delete session',7,'delete_session'),(22,'Can add log entry',8,'add_logentry'),(23,'Can change log entry',8,'change_logentry'),(24,'Can delete log entry',8,'delete_logentry'),(25,'Can add subject',9,'add_subject'),(26,'Can change subject',9,'change_subject'),(27,'Can delete subject',9,'delete_subject'),(28,'Can add questionnaire',10,'add_questionnaire'),(29,'Can change questionnaire',10,'change_questionnaire'),(30,'Can delete questionnaire',10,'delete_questionnaire'),(31,'Can export questionnaire answers',10,'export'),(32,'Management Tools',10,'management'),(33,'Can add question set',11,'add_questionset'),(34,'Can change question set',11,'change_questionset'),(35,'Can delete question set',11,'delete_questionset'),(36,'Can add run info',12,'add_runinfo'),(37,'Can change run info',12,'change_runinfo'),(38,'Can delete run info',12,'delete_runinfo'),(39,'Can add run info history',13,'add_runinfohistory'),(40,'Can change run info history',13,'change_runinfohistory'),(41,'Can delete run info history',13,'delete_runinfohistory'),(42,'Can add question',14,'add_question'),(43,'Can change question',14,'change_question'),(44,'Can delete question',14,'delete_question'),(45,'Can add choice',15,'add_choice'),(46,'Can change choice',15,'change_choice'),(47,'Can delete choice',15,'delete_choice'),(48,'Can add answer',16,'add_answer'),(49,'Can change answer',16,'change_answer'),(50,'Can delete answer',16,'delete_answer'),(51,'Can add page',17,'add_page'),(52,'Can change page',17,'change_page'),(53,'Can delete page',17,'delete_page'),(54,'Can add assign questionnair',18,'add_assignquestionnair'),(55,'Can change assign questionnair',18,'change_assignquestionnair'),(56,'Can delete assign questionnair',18,'delete_assignquestionnair'),(57,'Can add institute',19,'add_institute'),(58,'Can change institute',19,'change_institute'),(59,'Can delete institute',19,'delete_institute'),(60,'Can add institute course',20,'add_institutecourse'),(61,'Can change institute course',20,'change_institutecourse'),(62,'Can delete institute course',20,'delete_institutecourse'),(63,'Can add institute subject master',21,'add_institutesubjectmaster'),(64,'Can change institute subject master',21,'change_institutesubjectmaster'),(65,'Can delete institute subject master',21,'delete_institutesubjectmaster'),(66,'Can add institute subjects',22,'add_institutesubjects'),(67,'Can change institute subjects',22,'change_institutesubjects'),(68,'Can delete institute subjects',22,'delete_institutesubjects'),(69,'Can add institute teacher',23,'add_instituteteacher'),(70,'Can change institute teacher',23,'change_instituteteacher'),(71,'Can delete institute teacher',23,'delete_instituteteacher'),(72,'Can add institute class',24,'add_instituteclass'),(73,'Can change institute class',24,'change_instituteclass'),(74,'Can delete institute class',24,'delete_instituteclass'),(75,'Can add teacher subject class',25,'add_teachersubjectclass'),(76,'Can change teacher subject class',25,'change_teachersubjectclass'),(77,'Can delete teacher subject class',25,'delete_teachersubjectclass'),(78,'Can add resources',26,'add_resources'),(79,'Can change resources',26,'change_resources'),(80,'Can delete resources',26,'delete_resources'),(81,'Can add batch',27,'add_batch'),(82,'Can change batch',27,'change_batch'),(83,'Can delete batch',27,'delete_batch'),(84,'Can add enrollment',28,'add_enrollment'),(85,'Can change enrollment',28,'change_enrollment'),(86,'Can delete enrollment',28,'delete_enrollment'),(87,'Can add assignment',29,'add_assignment'),(88,'Can change assignment',29,'change_assignment'),(89,'Can delete assignment',29,'delete_assignment'),(90,'Can add assignment user',30,'add_assignmentuser'),(91,'Can change assignment user',30,'change_assignmentuser'),(92,'Can delete assignment user',30,'delete_assignmentuser'),(93,'Can add submission',31,'add_submission'),(94,'Can change submission',31,'change_submission'),(95,'Can delete submission',31,'delete_submission'),(96,'Can add registration profile',32,'add_registrationprofile'),(97,'Can change registration profile',32,'change_registrationprofile'),(98,'Can delete registration profile',32,'delete_registrationprofile'),(99,'Can add assign assignment',33,'add_assignassignment'),(100,'Can change assign assignment',33,'change_assignassignment'),(101,'Can delete assign assignment',33,'delete_assignassignment');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'root','','','root@example.com','sha1$b0518$d000bbc7a63acd337e02c49612dd3d4bf45cbecc',1,1,1,'2013-02-22 11:43:34','2012-12-26 17:41:04'),(2,'aditya','','','aditya.singh81027@gmail.com','sha1$320e7$417a2cc11f7a58a1ebd9adda3e647659a0dc0904',0,1,0,'2013-02-20 12:09:30','2012-12-26 17:46:14'),(4,'anurag','','','aditya.singh81027@gmail.com','sha1$7a674$66e82c949dae9d23b2b2000effe32535996fd91c',0,1,0,'2013-01-10 19:57:14','2013-01-10 19:54:14'),(5,'harish','','','aditya.singh81027@gmail.com','sha1$7a4ab$d8e1fbe5186fbc7e78c7c7bbc2882f5cdf3c03e6',0,1,0,'2013-01-10 20:02:46','2013-01-10 19:59:07');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_403f60f` (`user_id`),
  KEY `auth_user_groups_425ae3c4` (`group_id`),
  CONSTRAINT `group_id_refs_id_f116770` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_7ceef80f` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_403f60f` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_dfbab7d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_403f60f` (`user_id`),
  KEY `django_admin_log_1bb8f392` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_288599e6` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c8665aa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2012-12-26 17:54:59',1,17,'index','Page[index]',1,''),(2,'2012-12-26 17:56:01',1,10,'1','Physics Questionnaire Chap 2',1,''),(3,'2012-12-26 17:57:17',1,11,'1','Physics Questionnaire Chap 2: related to energy',1,''),(4,'2012-12-26 17:57:50',1,11,'2','Physics Questionnaire Chap 2: related to light',1,''),(5,'2012-12-26 18:04:06',1,14,'1','{Physics Questionnaire Chap 2: related to energy} (1) None',1,''),(6,'2012-12-26 20:41:24',1,10,'3','example1',2,'Changed redirect_url.'),(7,'2012-12-26 20:43:15',1,18,'1','example1',1,''),(8,'2012-12-26 20:46:29',1,17,'index','Page[index]',2,'Changed body_en.'),(9,'2012-12-27 22:29:03',1,17,'index','Page[index]',2,'Changed body_en.'),(10,'2012-12-28 13:41:02',1,17,'index','Page[index]',2,'No fields changed.'),(11,'2013-01-01 10:16:54',1,18,'2','example1',1,''),(12,'2013-01-01 10:17:11',1,18,'1','example1',3,''),(13,'2013-01-05 20:06:26',1,10,'4','chemistry',1,''),(14,'2013-01-05 20:57:13',1,18,'3','example1',1,''),(15,'2013-01-08 08:30:24',1,18,'3','example1',3,''),(16,'2013-01-08 11:05:46',1,18,'4','example1',1,''),(17,'2013-01-08 11:50:22',1,18,'5','example1',1,''),(18,'2013-01-08 11:54:45',1,18,'5','example1',3,''),(19,'2013-01-08 11:54:45',1,18,'4','example1',3,''),(20,'2013-01-08 11:55:11',1,18,'6','example1',1,''),(21,'2013-01-10 12:58:14',1,11,'4','Physics Questionnaire Chap 2: page1',1,''),(22,'2013-01-10 12:58:19',1,11,'4','Physics Questionnaire Chap 2: page1',2,'No fields changed.'),(23,'2013-01-10 12:59:15',1,11,'5','Physics Questionnaire Chap 2: page2',1,''),(24,'2013-01-10 12:59:36',1,11,'4','Physics Questionnaire Chap 2: page1',2,'Changed text_en.'),(25,'2013-01-10 13:00:21',1,11,'6','Physics Questionnaire Chap 2: thank you',1,''),(26,'2013-01-10 13:08:14',1,14,'7','{Physics Questionnaire Chap 2: page1} (1) Can we convert heat to any other energy form?',1,''),(27,'2013-01-10 13:16:32',1,14,'8','{Physics Questionnaire Chap 2: page1} (2) Heat is a form of..',1,''),(28,'2013-01-10 15:39:56',1,14,'9','{Physics Questionnaire Chap 2: page1} (3) which  surface absorb maximum heat?\r\n',1,''),(29,'2013-01-10 15:41:33',1,14,'10','{Physics Questionnaire Chap 2: page2} (1) can we convert light energy to heat energy',1,''),(30,'2013-01-10 15:45:26',1,14,'11','{Physics Questionnaire Chap 2: page2} (2) light is a combination of ____',1,''),(31,'2013-01-10 15:50:02',1,17,'index2','Page[index2]',1,''),(32,'2013-01-10 15:50:14',1,17,'index','Page[index]',2,'No fields changed.'),(33,'2013-01-10 19:03:33',1,18,'7','Physics Questionnaire Chap 2',1,''),(34,'2013-01-10 20:02:28',1,18,'8','Physics Questionnaire Chap 2',1,''),(35,'2013-02-05 10:32:46',1,19,'1','hi-tech',1,''),(36,'2013-02-05 10:33:16',1,20,'1','computer science',1,''),(37,'2013-02-05 10:34:03',1,21,'1','physics',1,''),(38,'2013-02-05 10:34:09',1,22,'1','physics',1,''),(39,'2013-02-05 10:34:14',1,29,'1','physics',1,''),(40,'2013-02-07 11:38:03',1,10,'5','chemistry',1,''),(41,'2013-02-07 12:14:18',1,18,'9','example1',1,'');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'site','sites','site'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'message','auth','message'),(6,'content type','contenttypes','contenttype'),(7,'session','sessions','session'),(8,'log entry','admin','logentry'),(9,'subject','questionnaire','subject'),(10,'questionnaire','questionnaire','questionnaire'),(11,'question set','questionnaire','questionset'),(12,'run info','questionnaire','runinfo'),(13,'run info history','questionnaire','runinfohistory'),(14,'question','questionnaire','question'),(15,'choice','questionnaire','choice'),(16,'answer','questionnaire','answer'),(17,'page','page','page'),(18,'assign questionnair','questn','assignquestionnair'),(19,'institute','academic','institute'),(20,'institute course','academic','institutecourse'),(21,'institute subject master','academic','institutesubjectmaster'),(22,'institute subjects','academic','institutesubjects'),(23,'institute teacher','academic','instituteteacher'),(24,'institute class','academic','instituteclass'),(25,'teacher subject class','academic','teachersubjectclass'),(26,'resources','academic','resources'),(27,'batch','academic','batch'),(28,'enrollment','academic','enrollment'),(29,'assignment','academic','assignment'),(30,'assignment user','academic','assignmentuser'),(31,'submission','academic','submission'),(32,'registration profile','registration','registrationprofile'),(33,'assign assignment','academic','assignassignment');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_3da3d3d8` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('bee79cfcc2108211ee414766c06f04a4','M2E5ZGMyNzY4NGMxMGQyODFmMzQ0Y2VmYzMyZjFjMzU3M2IwNTcxODqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQV1Lg==\n','2013-01-24 20:02:46'),('cbbd8fbf994446d30e1cc8489a59a500','Yjk2YWRkY2U3YzY0NmZlNGIxZTA0M2ZmMjMyOTViYzAxZDI4MjAzOTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2013-03-08 11:43:34');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_page`
--

DROP TABLE IF EXISTS `page_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_page` (
  `slug` varchar(50) NOT NULL,
  `title_en` varchar(256) DEFAULT NULL,
  `body_en` longtext,
  `public` tinyint(1) NOT NULL,
  PRIMARY KEY (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_page`
--

LOCK TABLES `page_page` WRITE;
/*!40000 ALTER TABLE `page_page` DISABLE KEYS */;
INSERT INTO `page_page` VALUES ('index','Welcome','Welcome to questionnaire...\r\n\"aditya\":/take/3',1),('index2','Welcome','welcome...\r\n\"go for it\":/take/6',1);
/*!40000 ALTER TABLE `page_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_answer`
--

DROP TABLE IF EXISTS `questionnaire_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionnaire_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `runid` varchar(32) NOT NULL,
  `answer` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questionnaire_answer_638462f1` (`subject_id`),
  KEY `questionnaire_answer_1f92e550` (`question_id`),
  CONSTRAINT `question_id_refs_id_54056725` FOREIGN KEY (`question_id`) REFERENCES `questionnaire_question` (`id`),
  CONSTRAINT `subject_id_refs_id_76332fb2` FOREIGN KEY (`subject_id`) REFERENCES `questionnaire_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_answer`
--

LOCK TABLES `questionnaire_answer` WRITE;
/*!40000 ALTER TABLE `questionnaire_answer` DISABLE KEYS */;
INSERT INTO `questionnaire_answer` VALUES (1,1,1,'759a1f13a4dec16bb4c62620cbfb9654','[\"yes\"]'),(2,1,2,'759a1f13a4dec16bb4c62620cbfb9654','[\"2\"]'),(3,1,3,'759a1f13a4dec16bb4c62620cbfb9654','[\"no\"]'),(4,1,4,'759a1f13a4dec16bb4c62620cbfb9654','[\"2\"]'),(5,1,5,'759a1f13a4dec16bb4c62620cbfb9654','[\"2\"]'),(6,1,1,'57e715313b7d0929d028e24104790d71','[\"no\"]'),(7,1,2,'57e715313b7d0929d028e24104790d71','[\"2\"]'),(8,1,3,'57e715313b7d0929d028e24104790d71','[\"no\"]'),(9,1,4,'57e715313b7d0929d028e24104790d71','[\"2\"]'),(10,1,5,'57e715313b7d0929d028e24104790d71','[\"2\"]'),(11,1,1,'365740991959ad8e393ce2f9e5634631','[\"no\"]'),(12,1,2,'365740991959ad8e393ce2f9e5634631','[\"3\"]'),(13,1,3,'365740991959ad8e393ce2f9e5634631','[\"no\"]'),(14,1,4,'365740991959ad8e393ce2f9e5634631','[\"2\"]'),(15,1,5,'365740991959ad8e393ce2f9e5634631','[\"1\"]'),(16,1,1,'7ffd92ab48cf837c3b71585c7d5c41d3','[\"yes\"]'),(17,1,2,'7ffd92ab48cf837c3b71585c7d5c41d3','[\"2\"]'),(18,1,3,'7ffd92ab48cf837c3b71585c7d5c41d3','[\"yes\"]'),(19,1,4,'7ffd92ab48cf837c3b71585c7d5c41d3','[\"2\"]'),(20,1,5,'7ffd92ab48cf837c3b71585c7d5c41d3','[\"1\"]'),(21,1,1,'b6f432477ca16866923b8a5652ea1109','[\"no\"]'),(22,1,2,'b6f432477ca16866923b8a5652ea1109','[\"2\"]'),(23,1,3,'b6f432477ca16866923b8a5652ea1109','[\"no\"]'),(24,1,4,'b6f432477ca16866923b8a5652ea1109','[\"2\"]'),(25,1,5,'b6f432477ca16866923b8a5652ea1109','[\"2\"]');
/*!40000 ALTER TABLE `questionnaire_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_choice`
--

DROP TABLE IF EXISTS `questionnaire_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionnaire_choice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `sortid` int(11) NOT NULL,
  `value` varchar(64) NOT NULL,
  `text_en` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `questionnaire_choice_1f92e550` (`question_id`),
  CONSTRAINT `question_id_refs_id_3845345c` FOREIGN KEY (`question_id`) REFERENCES `questionnaire_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_choice`
--

LOCK TABLES `questionnaire_choice` WRITE;
/*!40000 ALTER TABLE `questionnaire_choice` DISABLE KEYS */;
INSERT INTO `questionnaire_choice` VALUES (1,1,1,'1',''),(2,2,1,'1','Sachin Tendulkar'),(3,2,2,'2','Rahul Dravid'),(4,2,3,'3','Saurav Ganguly'),(5,2,4,'4','Virat Kohali'),(6,4,1,'1','Django'),(7,4,2,'2','Pylons'),(8,4,3,'3','Turbogears'),(9,4,4,'4','CherryPy'),(10,5,1,'1','Django'),(11,5,2,'2','Pylons'),(12,5,3,'3','Turbogears'),(13,5,4,'4','CherryPy'),(14,6,1,'1','Django'),(15,6,2,'2','Pylons'),(16,6,3,'3','Turbogears'),(17,6,4,'4','CherryPy'),(18,8,1,'Elasticity','Elasticity'),(19,8,2,'Energy','Energy'),(20,8,3,'Solid','Solid'),(21,8,4,'Air','Air'),(22,9,1,'black','black'),(23,9,2,'yellow','yellow'),(24,9,3,'white','white'),(25,9,4,'blue','blue'),(26,11,1,'1','4'),(27,11,2,'2','7'),(28,11,3,'3','3'),(29,11,4,'4','11');
/*!40000 ALTER TABLE `questionnaire_choice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_question`
--

DROP TABLE IF EXISTS `questionnaire_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionnaire_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questionset_id` int(11) NOT NULL,
  `number` varchar(8) NOT NULL,
  `text_en` longtext,
  `type` varchar(32) NOT NULL,
  `extra_en` varchar(128) DEFAULT NULL,
  `checks` varchar(128) DEFAULT NULL,
  `footer_en` longtext,
  PRIMARY KEY (`id`),
  KEY `questionnaire_question_a1f9fe7` (`questionset_id`),
  CONSTRAINT `questionset_id_refs_id_15745b66` FOREIGN KEY (`questionset_id`) REFERENCES `questionnaire_questionset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_question`
--

LOCK TABLES `questionnaire_question` WRITE;
/*!40000 ALTER TABLE `questionnaire_question` DISABLE KEYS */;
INSERT INTO `questionnaire_question` VALUES (1,1,'1','are you intrested in sport?','choice-yesnodontknow','','',''),(2,1,'2','which Indian batsman u like most?','choice-freeform','','',''),(3,1,'3','Do you want to make future in sport ','choice-yesnodontknow','','',''),(4,2,'4','Which Python Web Frameworks have you tried?','choice-freeform','','',''),(5,2,'5','Which do you like the most?','choice-freeform','','',''),(6,2,'5','Which do you like the most?','choice-freeform','','',''),(7,4,'1','Can we convert heat to any other energy form?','choice-yesnodontknow','','',''),(8,4,'2','Heat is a form of..','choice-freeform','','',''),(9,4,'3','which  surface absorb maximum heat?\r\n','choice-freeform','','',''),(10,5,'1','can we convert light energy to heat energy','choice-yesno','','',''),(11,5,'2','light is a combination of ____','choice-freeform','','','');
/*!40000 ALTER TABLE `questionnaire_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_questionnaire`
--

DROP TABLE IF EXISTS `questionnaire_questionnaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionnaire_questionnaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `redirect_url` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_questionnaire`
--

LOCK TABLES `questionnaire_questionnaire` WRITE;
/*!40000 ALTER TABLE `questionnaire_questionnaire` DISABLE KEYS */;
INSERT INTO `questionnaire_questionnaire` VALUES (1,'Physics Questionnaire Chap 2','/completeq/'),(3,'example1','/completeq/'),(4,'chemistry','/static/complete.html'),(5,'chemistry','/static/complete.html');
/*!40000 ALTER TABLE `questionnaire_questionnaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_questionset`
--

DROP TABLE IF EXISTS `questionnaire_questionset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionnaire_questionset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questionnaire_id` int(11) NOT NULL,
  `sortid` int(11) NOT NULL,
  `heading` varchar(64) NOT NULL,
  `checks` varchar(128) NOT NULL,
  `text_en` longtext,
  PRIMARY KEY (`id`),
  KEY `questionnaire_questionset_57172026` (`questionnaire_id`),
  CONSTRAINT `questionnaire_id_refs_id_494207e` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire_questionnaire` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_questionset`
--

LOCK TABLES `questionnaire_questionset` WRITE;
/*!40000 ALTER TABLE `questionnaire_questionset` DISABLE KEYS */;
INSERT INTO `questionnaire_questionset` VALUES (1,3,1,'page1','','related to sport'),(2,3,2,'page2','','python prefrences'),(3,3,99,'thank you','','you have succesfully completed your questionnaire...\r\nwait for marks...'),(4,1,1,'page1','','related to heat'),(5,1,2,'page2','','related to light'),(6,1,99,'thank you','','');
/*!40000 ALTER TABLE `questionnaire_questionset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_runinfo`
--

DROP TABLE IF EXISTS `questionnaire_runinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionnaire_runinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_id` int(11) NOT NULL,
  `random` varchar(32) NOT NULL,
  `runid` varchar(32) NOT NULL,
  `questionset_id` int(11) DEFAULT NULL,
  `emailcount` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `emailsent` datetime DEFAULT NULL,
  `lastemailerror` varchar(64) DEFAULT NULL,
  `state` varchar(16) DEFAULT NULL,
  `cookies` longtext,
  `tags` longtext NOT NULL,
  `skipped` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questionnaire_runinfo_638462f1` (`subject_id`),
  KEY `questionnaire_runinfo_a1f9fe7` (`questionset_id`),
  CONSTRAINT `questionset_id_refs_id_723e031e` FOREIGN KEY (`questionset_id`) REFERENCES `questionnaire_questionset` (`id`),
  CONSTRAINT `subject_id_refs_id_c40b69a` FOREIGN KEY (`subject_id`) REFERENCES `questionnaire_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_runinfo`
--

LOCK TABLES `questionnaire_runinfo` WRITE;
/*!40000 ALTER TABLE `questionnaire_runinfo` DISABLE KEYS */;
INSERT INTO `questionnaire_runinfo` VALUES (1,1,'314c6ac1bf36d98a2001dcf7da337b9d','314c6ac1bf36d98a2001dcf7da337b9d',1,0,'2012-12-27 22:01:41',NULL,NULL,NULL,NULL,'',''),(2,1,'c40a8c242c33a02976300f4c3d7096be','c40a8c242c33a02976300f4c3d7096be',1,0,'2012-12-27 22:30:06',NULL,NULL,NULL,NULL,'',''),(3,1,'033593a3c323873aaf057360ccdb8f03','033593a3c323873aaf057360ccdb8f03',1,0,'2013-01-31 10:53:43',NULL,NULL,NULL,NULL,'',''),(4,1,'75f800cb56e66dedd72ea02c29d5cd09','75f800cb56e66dedd72ea02c29d5cd09',1,0,'2013-01-31 10:55:33',NULL,NULL,NULL,NULL,'',''),(5,1,'2fa99549d445394b684b240ec19fffe0','2fa99549d445394b684b240ec19fffe0',1,0,'2013-01-31 15:38:37',NULL,NULL,NULL,NULL,'',''),(6,1,'9b60752fd948a90c2d02487f3ad402d9','9b60752fd948a90c2d02487f3ad402d9',1,0,'2013-02-01 12:08:19',NULL,NULL,NULL,NULL,'',''),(7,1,'04ac67028875bacd27f69559ee55727c','04ac67028875bacd27f69559ee55727c',1,0,'2013-02-01 12:09:24',NULL,NULL,NULL,NULL,'',''),(8,2,'6acd7c2732f4b7965d47bb11dcb6fe37','6acd7c2732f4b7965d47bb11dcb6fe37',1,0,'2013-02-07 11:20:29',NULL,NULL,NULL,NULL,'',''),(9,2,'ad792434ba342ec06afa7e13e5d364df','ad792434ba342ec06afa7e13e5d364df',1,0,'2013-02-07 11:24:09',NULL,NULL,NULL,NULL,'',''),(10,2,'1943ed27bc7c6b129695cf261cb1709a','1943ed27bc7c6b129695cf261cb1709a',1,0,'2013-02-07 11:29:31',NULL,NULL,NULL,NULL,'',''),(11,1,'f2478eb071fdb534840f753ddb7cf250','f2478eb071fdb534840f753ddb7cf250',1,0,'2013-02-07 11:33:20',NULL,NULL,NULL,NULL,'',''),(13,1,'531999b4ce54a70bf7b1c90079e14034','531999b4ce54a70bf7b1c90079e14034',1,0,'2013-02-08 10:55:15',NULL,NULL,NULL,NULL,'','');
/*!40000 ALTER TABLE `questionnaire_runinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_runinfohistory`
--

DROP TABLE IF EXISTS `questionnaire_runinfohistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionnaire_runinfohistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_id` int(11) NOT NULL,
  `runid` varchar(32) NOT NULL,
  `completed` date NOT NULL,
  `tags` longtext NOT NULL,
  `skipped` longtext NOT NULL,
  `questionnaire_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questionnaire_runinfohistory_638462f1` (`subject_id`),
  KEY `questionnaire_runinfohistory_57172026` (`questionnaire_id`),
  CONSTRAINT `questionnaire_id_refs_id_18740846` FOREIGN KEY (`questionnaire_id`) REFERENCES `questionnaire_questionnaire` (`id`),
  CONSTRAINT `subject_id_refs_id_4751c49b` FOREIGN KEY (`subject_id`) REFERENCES `questionnaire_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_runinfohistory`
--

LOCK TABLES `questionnaire_runinfohistory` WRITE;
/*!40000 ALTER TABLE `questionnaire_runinfohistory` DISABLE KEYS */;
INSERT INTO `questionnaire_runinfohistory` VALUES (1,1,'759a1f13a4dec16bb4c62620cbfb9654','2012-12-26','','',3),(2,1,'57e715313b7d0929d028e24104790d71','2013-01-01','','',3),(3,1,'365740991959ad8e393ce2f9e5634631','2013-01-05','','',3),(4,1,'7ffd92ab48cf837c3b71585c7d5c41d3','2013-01-29','','',3),(5,1,'b6f432477ca16866923b8a5652ea1109','2013-02-07','','',3);
/*!40000 ALTER TABLE `questionnaire_runinfohistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_subject`
--

DROP TABLE IF EXISTS `questionnaire_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questionnaire_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(16) NOT NULL,
  `surname` varchar(64) DEFAULT NULL,
  `givenname` varchar(64) DEFAULT NULL,
  `email` varchar(75) DEFAULT NULL,
  `gender` varchar(8) NOT NULL,
  `nextrun` date DEFAULT NULL,
  `formtype` varchar(16) NOT NULL,
  `language` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_subject`
--

LOCK TABLES `questionnaire_subject` WRITE;
/*!40000 ALTER TABLE `questionnaire_subject` DISABLE KEYS */;
INSERT INTO `questionnaire_subject` VALUES (1,'inactive','aditya','aditya',NULL,'unset',NULL,'email','en'),(2,'inactive','root','root',NULL,'unset',NULL,'email','en');
/*!40000 ALTER TABLE `questionnaire_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questn_assignquestionnair`
--

DROP TABLE IF EXISTS `questn_assignquestionnair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questn_assignquestionnair` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `selectquestionnaire_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questn_assignquestionnair_7b8d2b60` (`selectquestionnaire_id`),
  KEY `questn_assignquestionnair_403f60f` (`user_id`),
  CONSTRAINT `selectquestionnaire_id_refs_id_138d3106` FOREIGN KEY (`selectquestionnaire_id`) REFERENCES `questionnaire_questionnaire` (`id`),
  CONSTRAINT `user_id_refs_id_68175561` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questn_assignquestionnair`
--

LOCK TABLES `questn_assignquestionnair` WRITE;
/*!40000 ALTER TABLE `questn_assignquestionnair` DISABLE KEYS */;
INSERT INTO `questn_assignquestionnair` VALUES (6,3,2,'2013-01-08 11:55:11'),(7,1,2,'2013-01-10 19:03:33'),(8,1,5,'2013-01-10 20:02:28'),(9,3,2,'2013-02-07 12:14:18');
/*!40000 ALTER TABLE `questn_assignquestionnair` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_registrationprofile`
--

DROP TABLE IF EXISTS `registration_registrationprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration_registrationprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `activation_key` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_id_refs_id_313280c4` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_registrationprofile`
--

LOCK TABLES `registration_registrationprofile` WRITE;
/*!40000 ALTER TABLE `registration_registrationprofile` DISABLE KEYS */;
INSERT INTO `registration_registrationprofile` VALUES (1,2,'ALREADY_ACTIVATED'),(3,4,'ALREADY_ACTIVATED'),(4,5,'ALREADY_ACTIVATED');
/*!40000 ALTER TABLE `registration_registrationprofile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-03-03 10:38:10
