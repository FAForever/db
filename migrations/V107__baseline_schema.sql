-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: faf_lobby
-- ------------------------------------------------------
-- Server version	5.7.29-log

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
-- Table structure for table `achievement_definitions`
--

DROP TABLE IF EXISTS `achievement_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `achievement_definitions` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The ID of the achievement.',
  `order` int(10) unsigned NOT NULL COMMENT 'The order in which the achievement is displayed to the user.',
  `name_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The message key for the name of the achievement.',
  `description_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The message key for the description of the achievement.',
  `type` enum('STANDARD','INCREMENTAL') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The type of the achievement. \nPossible values are:\n"STANDARD" - Achievement is either locked or unlocked.\n"INCREMENTAL" - Achievement is incremental.',
  `total_steps` int(10) unsigned DEFAULT NULL COMMENT 'The total steps for an incremental achievement, NULL for standard achievements.',
  `revealed_icon_url` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The image URL for the revealed achievement icon.',
  `unlocked_icon_url` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The image URL for the unlocked achievement icon.',
  `initial_state` enum('HIDDEN','REVEALED') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The initial state of the achievement. \nPossible values are:\n"HIDDEN" - Achievement is hidden.\n"REVEALED" - Achievement is revealed.\n"UNLOCKED" - Achievement is unlocked.',
  `experience_points` int(10) unsigned NOT NULL COMMENT 'Experience points which will be earned when unlocking this achievement. Multiple of 5. Reference:\n5 - Easy to achieve\n20 - Medium\n50 - Hard to achieve',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_key_UNIQUE` (`name_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `achievement_statistics`
--

DROP TABLE IF EXISTS `achievement_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `achievement_statistics` (
  `achievement_id` varchar(36) NOT NULL,
  `unlockers_count` bigint(20) DEFAULT NULL,
  `unlockers_percent` decimal(26,2) DEFAULT NULL,
  `unlockers_min_duration` bigint(20) DEFAULT NULL,
  `unlockers_avg_duration` decimal(21,0) DEFAULT NULL,
  `unlockers_max_duration` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`achievement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `avatars`
--

DROP TABLE IF EXISTS `avatars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avatars` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idUser` mediumint(8) unsigned NOT NULL,
  `idAvatar` int(10) unsigned NOT NULL,
  `selected` tinyint(1) NOT NULL DEFAULT '0',
  `expires_at` timestamp NULL DEFAULT NULL COMMENT 'If null the avatar is permanent',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idUser` (`idUser`,`idAvatar`),
  KEY `friendCnst` (`idAvatar`),
  CONSTRAINT `avatars_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `login` (`id`),
  CONSTRAINT `avatars_ibfk_2` FOREIGN KEY (`idAvatar`) REFERENCES `avatars_list` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=397187 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Assign avatars (avatars_list) to users (login)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `avatars_list`
--

DROP TABLE IF EXISTS `avatars_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avatars_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tooltip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `filename` varchar(212) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci GENERATED ALWAYS AS (concat('https://content.faforever.com/faf/avatars/',`filename`)) VIRTUAL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`,`tooltip`)
) ENGINE=InnoDB AUTO_INCREMENT=363 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='List of all available avatars';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ban`
--

DROP TABLE IF EXISTS `ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ban` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` mediumint(8) unsigned NOT NULL,
  `author_id` mediumint(8) unsigned NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime DEFAULT NULL COMMENT 'If null, the ban is permanent',
  `level` enum('CHAT','GLOBAL','VAULT') COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `report_id` int(10) unsigned DEFAULT NULL COMMENT 'The report based on which the ban was issued, is NULL if ban was not issues due to a report',
  `revoke_reason` mediumtext COLLATE utf8mb4_unicode_ci,
  `revoke_author_id` mediumint(8) unsigned DEFAULT NULL,
  `revoke_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `report_id` (`report_id`),
  KEY `ban_revoke_author` (`author_id`),
  CONSTRAINT `ban_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `login` (`id`),
  CONSTRAINT `ban_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `login` (`id`),
  CONSTRAINT `ban_ibfk_3` FOREIGN KEY (`report_id`) REFERENCES `moderation_report` (`id`),
  CONSTRAINT `ban_revoke_author` FOREIGN KEY (`author_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ban can be revoked, see ban_revoke';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clan`
--

DROP TABLE IF EXISTS `clan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clan` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `founder_id` mediumint(8) unsigned DEFAULT NULL COMMENT 'The initial creator of the clan',
  `leader_id` mediumint(8) unsigned DEFAULT NULL COMMENT 'Current leader/admin of the clan',
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `tag_color` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'RGB color code for the clan''s tag in chat',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `requires_invitation` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `clan_tag_uindex` (`tag`),
  UNIQUE KEY `clan_name_uindex` (`name`),
  KEY `founder_id` (`founder_id`),
  KEY `leader_id` (`leader_id`),
  CONSTRAINT `clan_ibfk_1` FOREIGN KEY (`founder_id`) REFERENCES `login` (`id`),
  CONSTRAINT `clan_ibfk_2` FOREIGN KEY (`leader_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2354 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clan_membership`
--

DROP TABLE IF EXISTS `clan_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clan_membership` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `clan_id` mediumint(8) unsigned NOT NULL,
  `player_id` mediumint(8) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `player_id` (`player_id`),
  KEY `clan_id` (`clan_id`),
  CONSTRAINT `clan_membership_ibfk_1` FOREIGN KEY (`clan_id`) REFERENCES `clan` (`id`),
  CONSTRAINT `clan_membership_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15585 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coop_leaderboard`
--

DROP TABLE IF EXISTS `coop_leaderboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coop_leaderboard` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `mission` smallint(6) unsigned NOT NULL,
  `gameuid` int(10) unsigned DEFAULT NULL,
  `secondary` tinyint(3) unsigned NOT NULL,
  `time` time NOT NULL,
  `player_count` tinyint(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gameuid` (`gameuid`),
  CONSTRAINT `coop_leaderboard_ibfk_1` FOREIGN KEY (`gameuid`) REFERENCES `game_stats` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coop_map`
--

DROP TABLE IF EXISTS `coop_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coop_map` (
  `type` tinyint(3) unsigned NOT NULL,
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `version` decimal(4,0) DEFAULT NULL,
  `filename` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `filename` (`filename`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_domain_blacklist`
--

DROP TABLE IF EXISTS `email_domain_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_domain_blacklist` (
  `domain` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `domain_index` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_definitions`
--

DROP TABLE IF EXISTS `event_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_definitions` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The ID of the event.',
  `name_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The message key for the name of the event.',
  `image_url` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The base URL for the image that represents the event.',
  `type` enum('NUMERIC','TIME') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The type of the event.\nPossible values are:\n"NUMERIC" - Event is a plain number.\n"TIME" - Event is a measure of time.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_key_UNIQUE` (`name_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faction`
--

DROP TABLE IF EXISTS `faction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faction` (
  `id` tinyint(3) unsigned DEFAULT NULL,
  `name` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `featured_mods_owners`
--

DROP TABLE IF EXISTS `featured_mods_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `featured_mods_owners` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) unsigned NOT NULL,
  `moduid` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `moduid` (`moduid`),
  CONSTRAINT `featured_mods_owners_ibfk_1` FOREIGN KEY (`moduid`) REFERENCES `game_featuredMods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `featured_mods_owners_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flyway_schema_history`
--

DROP TABLE IF EXISTS `flyway_schema_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flyway_schema_history` (
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  KEY `flyway_schema_history_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `friends_and_foes`
--

DROP TABLE IF EXISTS `friends_and_foes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends_and_foes` (
  `user_id` mediumint(8) unsigned NOT NULL,
  `subject_id` mediumint(8) unsigned NOT NULL,
  `status` enum('FRIEND','FOE') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`,`subject_id`),
  KEY `friends_and_foes_subject_login_id_fk` (`subject_id`),
  CONSTRAINT `friends_and_foes_subject_login_id_fk` FOREIGN KEY (`subject_id`) REFERENCES `login` (`id`),
  CONSTRAINT `friends_and_foes_user_login_id_fk` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_featuredMods`
--

DROP TABLE IF EXISTS `game_featuredMods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_featuredMods` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `gamemod` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `publish` tinyint(1) NOT NULL DEFAULT '0',
  `order` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'Order in the featured mods list',
  `git_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The git repository URL to load this mod from',
  `git_branch` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The repository branch that contains the latest version',
  `file_extension` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_override` tinyint(1) DEFAULT NULL COMMENT 'Whether overriding an existing version is allowed (1) or not (0).',
  `deployment_webhook` mediumtext COLLATE utf8mb4_unicode_ci COMMENT 'A webhook to be called after successfull deployment',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_name_idx` (`gamemod`)
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_player_stats`
--

DROP TABLE IF EXISTS `game_player_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_player_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gameId` int(10) unsigned NOT NULL,
  `playerId` mediumint(8) unsigned NOT NULL,
  `AI` tinyint(1) NOT NULL,
  `faction` tinyint(3) unsigned NOT NULL,
  `color` tinyint(4) NOT NULL,
  `team` tinyint(3) NOT NULL,
  `place` tinyint(3) unsigned NOT NULL,
  `mean` float NOT NULL,
  `deviation` float unsigned NOT NULL,
  `after_mean` float DEFAULT NULL,
  `after_deviation` float unsigned DEFAULT NULL,
  `score` tinyint(3) DEFAULT NULL,
  `scoreTime` timestamp NULL DEFAULT NULL,
  `result` enum('VICTORY','DEFEAT','DRAW','MUTUAL_DRAW','UNKNOWN','CONFLICTING') COLLATE utf8mb4_unicode_ci DEFAULT 'UNKNOWN',
  PRIMARY KEY (`id`),
  KEY `playerId` (`playerId`),
  KEY `gameIdIdx` (`gameId`),
  KEY `game_player_stats_AI_index` (`AI`),
  KEY `game_player_stats_faction_index` (`faction`),
  KEY `game_player_stats_scoreTime_index` (`scoreTime`),
  CONSTRAINT `fk_game_player_stats_player` FOREIGN KEY (`playerId`) REFERENCES `login` (`id`),
  CONSTRAINT `game_id_fk` FOREIGN KEY (`gameId`) REFERENCES `game_stats` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26667793 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_review`
--

DROP TABLE IF EXISTS `game_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_review` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `game_id` int(10) unsigned NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL,
  `score` tinyint(4) NOT NULL,
  `text` mediumtext COLLATE utf8mb4_unicode_ci,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_game_user` (`game_id`,`user_id`),
  KEY `user_id_to_login` (`user_id`),
  CONSTRAINT `game_review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`),
  CONSTRAINT `game_review_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `game_stats` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER update_game_reviews_summary_after_insert
AFTER INSERT ON game_review
FOR EACH ROW
  BEGIN
    CALL update_game_reviews_summary(NEW.game_id);
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER update_game_reviews_summary_after_update
AFTER UPDATE ON game_review
FOR EACH ROW
  BEGIN
    CALL update_game_reviews_summary(NEW.game_id);
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER update_game_reviews_summary_after_delete
AFTER DELETE ON game_review
FOR EACH ROW
  BEGIN
    CALL update_game_reviews_summary(OLD.game_id);
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `game_reviews_summary`
--

DROP TABLE IF EXISTS `game_reviews_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_reviews_summary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `game_id` int(10) unsigned NOT NULL,
  `positive` float NOT NULL COMMENT 'The ''positive'' share of the rating',
  `negative` float NOT NULL COMMENT 'The ''negative'' share of the rating',
  `score` float NOT NULL COMMENT 'The sum of all scores',
  `reviews` int(11) NOT NULL COMMENT 'The sum of all ''negative'' and ''positive'' shares. Equals to the number of reviews.',
  `lower_bound` float NOT NULL COMMENT 'Lower bound of Wilson score confidence interval for a Bernoulli parameter',
  PRIMARY KEY (`id`),
  UNIQUE KEY `game_id` (`game_id`),
  CONSTRAINT `game_reviews_summary_game` FOREIGN KEY (`game_id`) REFERENCES `game_stats` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29320 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Summary of all game reviews. Entries are created and updated by triggers.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_stats`
--

DROP TABLE IF EXISTS `game_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_stats` (
  `id` int(10) unsigned NOT NULL,
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `endTime` timestamp NULL DEFAULT NULL,
  `replay_ticks` int(10) unsigned DEFAULT NULL COMMENT 'The total number of ticks present in the replay. The SCFA tick rate is 10 ticks/second',
  `gameType` enum('0','1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL,
  `gameMod` tinyint(3) unsigned NOT NULL,
  `host` mediumint(8) unsigned NOT NULL,
  `mapId` mediumint(8) unsigned DEFAULT NULL,
  `gameName` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `validity` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `startTime` (`startTime`),
  KEY `fk_game_stats_host` (`host`),
  KEY `game_stats_endTime_index` (`endTime`),
  KEY `game_stats_gameMod_index` (`gameMod`),
  KEY `game_stats_gameName_index` (`gameName`),
  KEY `game_stats_gameType_index` (`gameType`),
  KEY `game_stats_mapId_index` (`mapId`),
  KEY `game_stats_validity_index` (`validity`),
  KEY `game_stats_startTime_index` (`startTime`),
  KEY `validity_gameMod_endTime` (`validity`,`gameMod`,`endTime`),
  CONSTRAINT `fk_game_stats_host` FOREIGN KEY (`host`) REFERENCES `login` (`id`),
  CONSTRAINT `game_stats_game_featuredMods_id_fk` FOREIGN KEY (`gameMod`) REFERENCES `game_featuredMods` (`id`),
  CONSTRAINT `game_stats_game_validity_id_fk` FOREIGN KEY (`validity`) REFERENCES `game_validity` (`id`),
  CONSTRAINT `mapid_fkey` FOREIGN KEY (`mapId`) REFERENCES `map_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER map_play_count AFTER INSERT ON game_stats FOR EACH ROW UPDATE table_map_features set times_played = (times_played +1) WHERE map_id = NEW.mapId */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `game_validity`
--

DROP TABLE IF EXISTS `game_validity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_validity` (
  `id` tinyint(3) unsigned NOT NULL,
  `message` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_rating`
--

DROP TABLE IF EXISTS `global_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_rating` (
  `id` mediumint(8) unsigned NOT NULL,
  `mean` float DEFAULT NULL,
  `deviation` float DEFAULT NULL,
  `numGames` smallint(4) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `rating` float GENERATED ALWAYS AS ((`mean` - (3 * `deviation`))) STORED,
  PRIMARY KEY (`id`),
  KEY `rating` (`rating`),
  KEY `global_rating_idx_for_rating_distribution` (`is_active`,`numGames`,`mean`,`deviation`),
  CONSTRAINT `IdCnst` FOREIGN KEY (`id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_constraint` FOREIGN KEY (`id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_rating_distribution`
--

DROP TABLE IF EXISTS `global_rating_distribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_rating_distribution` (
  `rating` double NOT NULL,
  `count` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`rating`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_rating_rank_view`
--

DROP TABLE IF EXISTS `global_rating_rank_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_rating_rank_view` (
  `id` mediumint(8) unsigned NOT NULL COMMENT 'References to global_rating.id',
  `ranking` int(11) NOT NULL AUTO_INCREMENT,
  `mean` float DEFAULT NULL,
  `deviation` float DEFAULT NULL,
  `num_games` smallint(5) unsigned DEFAULT '0',
  `rating` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ranking` (`ranking`)
) ENGINE=InnoDB AUTO_INCREMENT=2048 DEFAULT CHARSET=latin1 COMMENT='Materialized view including ranks (player position) for global_rating';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_permission`
--

DROP TABLE IF EXISTS `group_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_permission` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `technical_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'hardcoded names to be used in code',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'name key of permission in translation table',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='List of all permissions, assigned over group assignments (group_permission_assignments)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `group_permission_assignment`
--

DROP TABLE IF EXISTS `group_permission_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_permission_assignment` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` mediumint(8) unsigned NOT NULL,
  `permission_id` mediumint(8) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `group_permission_assignment_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`),
  CONSTRAINT `group_permission_assignment_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `group_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Connects groups (user_group) and permissions (group_permission)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jwt_users`
--

DROP TABLE IF EXISTS `jwt_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jwt_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `public_key` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder1v1_rating`
--

DROP TABLE IF EXISTS `ladder1v1_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder1v1_rating` (
  `id` mediumint(8) unsigned NOT NULL,
  `mean` float DEFAULT NULL,
  `deviation` float DEFAULT NULL,
  `numGames` smallint(4) unsigned NOT NULL DEFAULT '0',
  `winGames` smallint(4) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `rating` float GENERATED ALWAYS AS ((`mean` - (3 * `deviation`))) STORED,
  PRIMARY KEY (`id`),
  KEY `rating` (`rating`),
  KEY `ladder1v1_rating_idx_for_rating_distribution` (`is_active`,`numGames`,`mean`,`deviation`),
  CONSTRAINT `ladder1v1_rating_ibfk_1` FOREIGN KEY (`id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder1v1_rating_distribution`
--

DROP TABLE IF EXISTS `ladder1v1_rating_distribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder1v1_rating_distribution` (
  `rating` double NOT NULL,
  `count` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`rating`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder1v1_rating_rank_view`
--

DROP TABLE IF EXISTS `ladder1v1_rating_rank_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder1v1_rating_rank_view` (
  `id` mediumint(8) unsigned NOT NULL COMMENT 'References to ladder1v1_rating.id',
  `ranking` int(11) NOT NULL AUTO_INCREMENT,
  `mean` float DEFAULT NULL,
  `deviation` float DEFAULT NULL,
  `num_games` smallint(5) unsigned DEFAULT '0',
  `win_games` smallint(5) unsigned DEFAULT '0',
  `rating` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ranking` (`ranking`)
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=latin1 COMMENT='Materialized view including ranks (player position) for ladder1v1_rating';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder_division`
--

DROP TABLE IF EXISTS `ladder_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder_division` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `league` tinyint(3) unsigned NOT NULL,
  `threshold` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder_division_score`
--

DROP TABLE IF EXISTS `ladder_division_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder_division_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `season` mediumint(8) unsigned NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL,
  `league` tinyint(1) unsigned NOT NULL,
  `score` float unsigned NOT NULL,
  `games` mediumint(8) unsigned DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_for_season` (`season`,`user_id`),
  KEY `league` (`league`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `ladder_division_score_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55564 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ladder_map`
--

DROP TABLE IF EXISTS `ladder_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ladder_map` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idmap` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idmap` (`idmap`)
) ENGINE=InnoDB AUTO_INCREMENT=1388 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `leaderboard`
--

DROP TABLE IF EXISTS `leaderboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leaderboard` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `technical_name` varchar(255) NOT NULL,
  `name_key` varchar(255) NOT NULL,
  `description_key` varchar(255) NOT NULL COMMENT 'The leaderboard''s i18n description key',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `technical_name` (`technical_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `leaderboard_rating`
--

DROP TABLE IF EXISTS `leaderboard_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leaderboard_rating` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login_id` mediumint(8) unsigned NOT NULL,
  `mean` float NOT NULL,
  `deviation` float unsigned NOT NULL,
  `rating` float GENERATED ALWAYS AS ((`mean` - (3 * `deviation`))) STORED,
  `total_games` int(11) NOT NULL DEFAULT '0',
  `won_games` int(11) NOT NULL DEFAULT '0',
  `leaderboard_id` smallint(5) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_id` (`login_id`,`leaderboard_id`),
  KEY `leaderboard_id` (`leaderboard_id`),
  CONSTRAINT `leaderboard_rating_ibfk_1` FOREIGN KEY (`login_id`) REFERENCES `login` (`id`),
  CONSTRAINT `leaderboard_rating_ibfk_2` FOREIGN KEY (`leaderboard_id`) REFERENCES `leaderboard` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=542648 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `leaderboard_rating_journal`
--

DROP TABLE IF EXISTS `leaderboard_rating_journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leaderboard_rating_journal` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `game_player_stats_id` bigint(20) unsigned NOT NULL,
  `leaderboard_id` smallint(5) unsigned NOT NULL,
  `rating_mean_before` float NOT NULL,
  `rating_deviation_before` float unsigned NOT NULL,
  `rating_mean_after` float NOT NULL,
  `rating_deviation_after` float unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `lookup_id` (`game_player_stats_id`,`leaderboard_id`),
  KEY `leaderboard_id` (`leaderboard_id`),
  CONSTRAINT `leaderboard_rating_journal_ibfk_1` FOREIGN KEY (`game_player_stats_id`) REFERENCES `game_player_stats` (`id`),
  CONSTRAINT `leaderboard_rating_journal_ibfk_2` FOREIGN KEY (`leaderboard_id`) REFERENCES `leaderboard` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1398123 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `league`
--

DROP TABLE IF EXISTS `league`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `league` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `director_id` mediumint(8) unsigned NOT NULL COMMENT 'Login ID of the user who created this league',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `director_id_of_league` (`director_id`),
  CONSTRAINT `director_id_of_league` FOREIGN KEY (`director_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `league_rating_range`
--

DROP TABLE IF EXISTS `league_rating_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `league_rating_range` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rating_from` smallint(6) DEFAULT NULL,
  `rating_to` smallint(6) DEFAULT NULL,
  `schedule_id` int(10) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `rating_schedule_of_league_rating_range` (`schedule_id`),
  CONSTRAINT `rating_schedule_of_league_rating_range` FOREIGN KEY (`schedule_id`) REFERENCES `league_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `league_schedule`
--

DROP TABLE IF EXISTS `league_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `league_schedule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timeframe_from` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `timeframe_to` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'From when to when will the season take place',
  `director_id` mediumint(8) unsigned NOT NULL COMMENT 'Login ID of the user who''s organizing this season',
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `league_id` int(10) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `director_id_of_league_schedule` (`director_id`),
  KEY `league_of_league_schedule` (`league_id`),
  CONSTRAINT `director_id_of_league_schedule` FOREIGN KEY (`director_id`) REFERENCES `login` (`id`),
  CONSTRAINT `league_of_league_schedule` FOREIGN KEY (`league_id`) REFERENCES `league` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lobby_admin`
--

DROP TABLE IF EXISTS `lobby_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lobby_admin` (
  `user_id` int(11) NOT NULL,
  `group` tinyint(4) NOT NULL COMMENT '0 - no privileges; 1 - moderator, can delete/edit comments and approve broken maps reports; 2 - admin, same as moderator plus can add global bans',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `lobby_ban`
--

DROP TABLE IF EXISTS `lobby_ban`;
/*!50001 DROP VIEW IF EXISTS `lobby_ban`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `lobby_ban` AS SELECT
 1 AS `idUser`,
 1 AS `reason`,
 1 AS `expires_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` char(77) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `steamid` bigint(20) unsigned DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_agent` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_login` (`login`),
  UNIQUE KEY `unique_email` (`email`),
  UNIQUE KEY `steamid` (`steamid`)
) ENGINE=InnoDB AUTO_INCREMENT=396834 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='login';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login_log`
--

DROP TABLE IF EXISTS `login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID for API/Elide compatibility',
  `login_id` mediumint(8) unsigned NOT NULL,
  `ip` varchar(45) NOT NULL,
  `attempts` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `success` tinyint(1) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`success`,`ip`,`login_id`),
  UNIQUE KEY `id` (`id`),
  KEY `login_id` (`login_id`),
  CONSTRAINT `login_log_ibfk_1` FOREIGN KEY (`login_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Log of logins to discover login attack attempts. Has to be cleaned up by the services.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map`
--

DROP TABLE IF EXISTS `map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `display_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `map_type` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `battle_type` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` mediumint(8) unsigned DEFAULT NULL,
  `average_review_score` double NOT NULL DEFAULT '0',
  `reviews` int(11) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was created.',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was updated',
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_name` (`display_name`),
  KEY `author` (`author`),
  KEY `map_average_review_score_index` (`average_review_score`),
  CONSTRAINT `author` FOREIGN KEY (`author`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9749 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map_pool`
--

DROP TABLE IF EXISTS `map_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_pool` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'Only to help admins with organization. Don''t show this to the user.',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COMMENT='A collection of maps, used by a matchmaker_pool for map selection';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map_pool_map_version`
--

DROP TABLE IF EXISTS `map_pool_map_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_pool_map_version` (
  `map_pool_id` int(10) unsigned NOT NULL,
  `map_version_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`map_pool_id`,`map_version_id`),
  KEY `map_version_id` (`map_version_id`,`map_pool_id`),
  CONSTRAINT `map_pool_map_version_ibfk_1` FOREIGN KEY (`map_pool_id`) REFERENCES `map_pool` (`id`),
  CONSTRAINT `map_pool_map_version_ibfk_2` FOREIGN KEY (`map_version_id`) REFERENCES `map_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map_reviews_summary`
--

DROP TABLE IF EXISTS `map_reviews_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_reviews_summary` (
  `id` mediumint(8) unsigned NOT NULL,
  `map_id` mediumint(8) unsigned DEFAULT NULL,
  `positive` double DEFAULT NULL,
  `negative` double DEFAULT NULL,
  `score` double DEFAULT NULL,
  `reviews` decimal(32,0) DEFAULT NULL,
  `lower_bound` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `map_id` (`map_id`),
  CONSTRAINT `map_reviews_summary_ibfk_1` FOREIGN KEY (`map_id`) REFERENCES `map` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `map_statistic`
--

DROP TABLE IF EXISTS `map_statistic`;
/*!50001 DROP VIEW IF EXISTS `map_statistic`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `map_statistic` AS SELECT
 1 AS `id`,
 1 AS `times_played`,
 1 AS `create_time`,
 1 AS `update_time`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `map_statistics`
--

DROP TABLE IF EXISTS `map_statistics`;
/*!50001 DROP VIEW IF EXISTS `map_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `map_statistics` AS SELECT
 1 AS `map_id`,
 1 AS `downloads`,
 1 AS `plays`,
 1 AS `draws`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `map_version`
--

DROP TABLE IF EXISTS `map_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_version` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `max_players` decimal(2,0) NOT NULL,
  `width` decimal(4,0) NOT NULL,
  `height` decimal(4,0) NOT NULL,
  `version` decimal(4,0) NOT NULL,
  `filename` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ranked` tinyint(1) NOT NULL DEFAULT '1',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `map_id` mediumint(8) unsigned NOT NULL,
  `average_review_score` double NOT NULL DEFAULT '0',
  `reviews` int(11) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was created.',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was updated',
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`),
  UNIQUE KEY `map_id_version` (`map_id`,`version`),
  KEY `map_version_average_review_score_index` (`average_review_score`),
  CONSTRAINT `map` FOREIGN KEY (`map_id`) REFERENCES `map` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map_version_review`
--

DROP TABLE IF EXISTS `map_version_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_version_review` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `map_version_id` mediumint(8) unsigned NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL,
  `score` tinyint(4) NOT NULL,
  `text` mediumtext COLLATE utf8mb4_unicode_ci,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_map_version_user` (`map_version_id`,`user_id`),
  KEY `user_id_to_login` (`user_id`),
  CONSTRAINT `map_version_review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`),
  CONSTRAINT `map_version_review_ibfk_2` FOREIGN KEY (`map_version_id`) REFERENCES `map_version` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2595 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER update_map_version_reviews_summary_after_insert
AFTER INSERT ON map_version_review
FOR EACH ROW
  BEGIN
    CALL update_map_version_reviews_summary(NEW.map_version_id);
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER update_map_version_reviews_summary_after_update
AFTER UPDATE ON map_version_review
FOR EACH ROW
  BEGIN
    CALL update_map_version_reviews_summary(NEW.map_version_id);
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER update_map_version_reviews_summary_after_delete
AFTER DELETE ON map_version_review
FOR EACH ROW
  BEGIN
    CALL update_map_version_reviews_summary(OLD.map_version_id);
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `map_version_reviews_summary`
--

DROP TABLE IF EXISTS `map_version_reviews_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_version_reviews_summary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `map_version_id` mediumint(8) unsigned NOT NULL,
  `positive` float NOT NULL COMMENT 'The ''positive'' share of the rating',
  `negative` float NOT NULL COMMENT 'The ''negative'' share of the rating',
  `score` float NOT NULL COMMENT 'The sum of all scores',
  `reviews` int(11) NOT NULL COMMENT 'The sum of all ''negative'' and ''positive'' shares. Equals to the number of reviews.',
  `lower_bound` float NOT NULL COMMENT 'Lower bound of Wilson score confidence interval for a Bernoulli parameter',
  PRIMARY KEY (`id`),
  UNIQUE KEY `map_version_id` (`map_version_id`),
  CONSTRAINT `map_version_reviews_summary_map_version` FOREIGN KEY (`map_version_id`) REFERENCES `map_version` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2712 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Summary of all map version reviews. Entries are created and updated by triggers.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `map_version_statistics`
--

DROP TABLE IF EXISTS `map_version_statistics`;
/*!50001 DROP VIEW IF EXISTS `map_version_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `map_version_statistics` AS SELECT
 1 AS `map_version_id`,
 1 AS `downloads`,
 1 AS `plays`,
 1 AS `draws`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `matchmaker_queue`
--

DROP TABLE IF EXISTS `matchmaker_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchmaker_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `technical_name` varchar(255) NOT NULL,
  `featured_mod_id` tinyint(3) unsigned NOT NULL,
  `leaderboard_id` smallint(5) unsigned NOT NULL,
  `name_key` varchar(255) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `team_size` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `technical_name` (`technical_name`),
  KEY `featured_mod_id` (`featured_mod_id`),
  KEY `leaderboard_id` (`leaderboard_id`),
  CONSTRAINT `matchmaker_queue_ibfk_1` FOREIGN KEY (`featured_mod_id`) REFERENCES `game_featuredMods` (`id`),
  CONSTRAINT `matchmaker_queue_ibfk_2` FOREIGN KEY (`leaderboard_id`) REFERENCES `leaderboard` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='A matchmaker queue specifying which featured mod will be played, which map pools will be drawn from, and which leaderboard will be used to look up and update a player''''s rating.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matchmaker_queue_game`
--

DROP TABLE IF EXISTS `matchmaker_queue_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchmaker_queue_game` (
  `matchmaker_queue_id` int(10) unsigned NOT NULL,
  `game_stats_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`game_stats_id`,`matchmaker_queue_id`),
  KEY `matchmaker_queue_id` (`matchmaker_queue_id`),
  CONSTRAINT `matchmaker_queue_game_ibfk_1` FOREIGN KEY (`matchmaker_queue_id`) REFERENCES `matchmaker_queue` (`id`),
  CONSTRAINT `matchmaker_queue_game_ibfk_2` FOREIGN KEY (`game_stats_id`) REFERENCES `game_stats` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matchmaker_queue_map_pool`
--

DROP TABLE IF EXISTS `matchmaker_queue_map_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchmaker_queue_map_pool` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matchmaker_queue_id` int(10) unsigned NOT NULL,
  `map_pool_id` int(10) unsigned NOT NULL,
  `min_rating` int(11) DEFAULT NULL,
  `max_rating` int(11) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `map_pool_id` (`map_pool_id`,`matchmaker_queue_id`),
  KEY `matchmaker_queue_map_pool_matchmaker_queue_id_fk` (`matchmaker_queue_id`),
  CONSTRAINT `matchmaker_queue_map_pool_map_pool_id_fk` FOREIGN KEY (`map_pool_id`) REFERENCES `map_pool` (`id`),
  CONSTRAINT `matchmaker_queue_map_pool_matchmaker_queue_id_fk` FOREIGN KEY (`matchmaker_queue_id`) REFERENCES `matchmaker_queue` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Map sub pool of a rating range for a matchmaker queue';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID of this entry.',
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The message resource key that identifies this entry along with language and region.',
  `language` char(2) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The language that identifies this entry along with key and region.',
  `region` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The region that identifies this entry along with key and language.',
  `value` mediumtext COLLATE utf8mb4_unicode_ci COMMENT 'The message value.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `key_language_region_UNIQUE` (`key`,`language`,`region`)
) ENGINE=InnoDB AUTO_INCREMENT=1073 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mod`
--

DROP TABLE IF EXISTS `mod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `display_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uploader` mediumint(8) unsigned DEFAULT NULL,
  `average_review_score` double NOT NULL DEFAULT '0',
  `reviews` int(11) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was created.',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was updated',
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_name` (`display_name`),
  KEY `uploader` (`uploader`),
  KEY `mod_average_review_score_index` (`average_review_score`),
  CONSTRAINT `mod_ibfk_1` FOREIGN KEY (`uploader`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6355 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mod_reviews_summary`
--

DROP TABLE IF EXISTS `mod_reviews_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_reviews_summary` (
  `id` mediumint(8) unsigned NOT NULL,
  `mod_id` mediumint(8) unsigned DEFAULT NULL,
  `positive` double DEFAULT NULL,
  `negative` double DEFAULT NULL,
  `score` double DEFAULT NULL,
  `reviews` decimal(32,0) DEFAULT NULL,
  `lower_bound` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_id` (`mod_id`),
  CONSTRAINT `mod_reviews_summary_ibfk_1` FOREIGN KEY (`mod_id`) REFERENCES `mod` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mod_stats`
--

DROP TABLE IF EXISTS `mod_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_stats` (
  `mod_id` mediumint(8) unsigned NOT NULL,
  `likes` float NOT NULL DEFAULT '0',
  `likers` longblob NOT NULL,
  `downloads` mediumint(8) NOT NULL DEFAULT '0',
  `times_played` mediumint(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mod_id`),
  CONSTRAINT `mod_stats_ibfk_1` FOREIGN KEY (`mod_id`) REFERENCES `mod` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mod_version`
--

DROP TABLE IF EXISTS `mod_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_version` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('UI','SIM') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'This field can be defined for every version because maybe the author finds a way to turn his SIM mod into an UI mod.',
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` smallint(5) NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ranked` tinyint(1) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `mod_id` mediumint(8) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was created.',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was updated',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  UNIQUE KEY `filename` (`filename`),
  UNIQUE KEY `mod_id_version` (`mod_id`,`version`),
  CONSTRAINT `mod_version_ibfk_1` FOREIGN KEY (`mod_id`) REFERENCES `mod` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10626 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mod_version_review`
--

DROP TABLE IF EXISTS `mod_version_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_version_review` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mod_version_id` mediumint(8) unsigned NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL,
  `score` tinyint(4) NOT NULL,
  `text` mediumtext COLLATE utf8mb4_unicode_ci,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_mod_version_user` (`mod_version_id`,`user_id`),
  KEY `user_id_to_login` (`user_id`),
  CONSTRAINT `mod_version_review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`),
  CONSTRAINT `mod_version_review_ibfk_2` FOREIGN KEY (`mod_version_id`) REFERENCES `mod_version` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2811 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER update_mod_version_reviews_summary_after_insert
AFTER INSERT ON mod_version_review
FOR EACH ROW
  BEGIN
    CALL update_mod_version_reviews_summary(NEW.mod_version_id);
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER update_mod_version_reviews_summary_after_update
AFTER UPDATE ON mod_version_review
FOR EACH ROW
  BEGIN
    CALL update_mod_version_reviews_summary(NEW.mod_version_id);
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER update_mod_version_reviews_summary_after_delete
AFTER DELETE ON mod_version_review
FOR EACH ROW
  BEGIN
    CALL update_mod_version_reviews_summary(OLD.mod_version_id);
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `mod_version_reviews_summary`
--

DROP TABLE IF EXISTS `mod_version_reviews_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mod_version_reviews_summary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mod_version_id` mediumint(8) unsigned NOT NULL,
  `positive` float NOT NULL COMMENT 'The ''positive'' share of the rating',
  `negative` float NOT NULL COMMENT 'The ''negative'' share of the rating',
  `score` float NOT NULL COMMENT 'The sum of all scores',
  `reviews` int(11) NOT NULL COMMENT 'The sum of all ''negative'' and ''positive'' shares. Equals to the number of reviews.',
  `lower_bound` float NOT NULL COMMENT 'Lower bound of Wilson score confidence interval for a Bernoulli parameter',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_version_id` (`mod_version_id`),
  CONSTRAINT `mod_version_reviews_summary_mod_version` FOREIGN KEY (`mod_version_id`) REFERENCES `mod_version` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2908 DEFAULT CHARSET=latin1 COMMENT='Summary of all mod version reviews. Entries are created and updated by triggers.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `moderation_report`
--

DROP TABLE IF EXISTS `moderation_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moderation_report` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reporter_id` mediumint(8) unsigned NOT NULL,
  `report_description` mediumtext COLLATE utf8mb4_unicode_ci,
  `game_id` int(10) unsigned DEFAULT NULL COMMENT 'If equal to NULL, the offense did not happen ingame',
  `report_status` enum('AWAITING','PROCESSING','COMPLETED','DISCARDED') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The current status of the report. This will be accessable by the concerned user.',
  `game_incident_timecode` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The timecode of the incident ingame, indicated by the user in their own terms',
  `moderator_notice` mediumtext COLLATE utf8mb4_unicode_ci COMMENT 'A public notice left by the moderator which will be addressed to the reporter once the report is marked as either COMPLETED or DISCARDED',
  `moderator_private_note` mediumtext COLLATE utf8mb4_unicode_ci COMMENT 'A private notice left by the moderator which any other moderator accessing the record will be able to see.',
  `last_moderator` mediumint(8) unsigned DEFAULT NULL COMMENT 'Last moderator to have updated the report',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `game_id_of_moderation_report` (`game_id`),
  KEY `reporter_id_of_moderation_report` (`reporter_id`),
  KEY `last_moderator` (`last_moderator`),
  CONSTRAINT `game_id_of_moderation_report` FOREIGN KEY (`game_id`) REFERENCES `game_stats` (`id`),
  CONSTRAINT `moderation_report_ibfk_1` FOREIGN KEY (`last_moderator`) REFERENCES `login` (`id`),
  CONSTRAINT `reporter_id_of_moderation_report` FOREIGN KEY (`reporter_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `name_history`
--

DROP TABLE IF EXISTS `name_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `name_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` mediumint(8) unsigned NOT NULL,
  `previous_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `name_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27015 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_clients` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'A string that identifies the client, preferably a UUID.',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Human readable client name.',
  `client_secret` varchar(55) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The client''s secret, a random string.',
  `client_type` enum('confidential','public') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public' COMMENT 'A string represents if the client is confidential or public.',
  `redirect_uris` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'A space delimited list of redirect URIs.',
  `default_redirect_uri` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'One of the redirect uris.',
  `default_scope` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'A space delimited list of default scopes of the client.',
  `icon_url` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'URL to a square image representing the client.',
  `auto_approve_scopes` mediumtext COLLATE utf8mb4_unicode_ci COMMENT 'A space delimited list of scopes that don''t need to be approved by the user.',
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `client_id_UNIQUE` (`id`),
  UNIQUE KEY `client_secret_UNIQUE` (`client_secret`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_tokens`
--

DROP TABLE IF EXISTS `oauth_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Auto incremented, technical ID.',
  `token_type` varchar(45) NOT NULL,
  `access_token` varchar(36) NOT NULL COMMENT 'A string token (UUID).',
  `refresh_token` varchar(36) DEFAULT NULL COMMENT 'A string token (UUID).',
  `client_id` varchar(36) NOT NULL COMMENT 'ID of the client (FK).',
  `scope` text NOT NULL COMMENT 'A space delimited list of scopes.',
  `expires` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT 'Expiration time of the token.',
  `user_id` int(10) unsigned NOT NULL COMMENT 'ID of the user (FK).',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patchs_table`
--

DROP TABLE IF EXISTS `patchs_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patchs_table` (
  `idpatchs_table` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fromMd5` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `toMd5` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `patchFile` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idpatchs_table`)
) ENGINE=InnoDB AUTO_INCREMENT=38697 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_achievements`
--

DROP TABLE IF EXISTS `player_achievements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_achievements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The ID of the player achievement.',
  `player_id` mediumint(8) unsigned NOT NULL,
  `achievement_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The ID of the referenced achievement (FK).',
  `current_steps` int(10) unsigned DEFAULT NULL COMMENT 'The current steps for an incremental achievement.',
  `state` enum('HIDDEN','REVEALED','UNLOCKED') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The state of the achievement. \nPossible values are:\n"HIDDEN" - Achievement is hidden.\n"REVEALED" - Achievement is revealed.\n"UNLOCKED" - Achievement is unlocked.',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `player_achievement_UNIQUE` (`player_id`,`achievement_id`),
  KEY `player_achievements_state_index` (`state`),
  KEY `fk_achievement` (`achievement_id`),
  CONSTRAINT `fk_achievement` FOREIGN KEY (`achievement_id`) REFERENCES `achievement_definitions` (`id`),
  CONSTRAINT `fk_login` FOREIGN KEY (`player_id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_events`
--

DROP TABLE IF EXISTS `player_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID of this entry.',
  `player_id` mediumint(8) unsigned NOT NULL COMMENT 'The ID of the player that triggered this event.',
  `event_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The ID of the event definition.',
  `count` int(10) unsigned NOT NULL COMMENT 'The current number of times this event has occurred.',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `event_player_UNIQUE` (`player_id`,`event_id`),
  CONSTRAINT `player_events_login_id_fk` FOREIGN KEY (`player_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20828934 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reported_user`
--

DROP TABLE IF EXISTS `reported_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reported_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` mediumint(8) unsigned NOT NULL,
  `report_id` int(10) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `player_id_of_reported_user` (`player_id`),
  KEY `report_id_of_reported_user` (`report_id`),
  CONSTRAINT `player_id_of_reported_user` FOREIGN KEY (`player_id`) REFERENCES `login` (`id`),
  CONSTRAINT `report_id_of_reported_user` FOREIGN KEY (`report_id`) REFERENCES `moderation_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `table_map`
--

DROP TABLE IF EXISTS `table_map`;
/*!50001 DROP VIEW IF EXISTS `table_map`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `table_map` AS SELECT
 1 AS `id`,
 1 AS `name`,
 1 AS `description`,
 1 AS `max_players`,
 1 AS `map_type`,
 1 AS `battle_type`,
 1 AS `map_sizeX`,
 1 AS `map_sizeY`,
 1 AS `version`,
 1 AS `filename`,
 1 AS `hidden`,
 1 AS `mapuid`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `table_map_comments`
--

DROP TABLE IF EXISTS `table_map_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_map_comments` (
  `comment_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `map_id` mediumint(8) unsigned NOT NULL,
  `user_id` mediumint(8) unsigned NOT NULL,
  `comment_text` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `map_id` (`map_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `table_map_comments_ibfk_1` FOREIGN KEY (`map_id`) REFERENCES `map_version` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `table_map_comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3594 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `table_map_features`
--

DROP TABLE IF EXISTS `table_map_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_map_features` (
  `map_id` mediumint(8) unsigned NOT NULL,
  `rating` float NOT NULL DEFAULT '0',
  `voters` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `downloads` int(11) NOT NULL DEFAULT '0',
  `times_played` int(11) NOT NULL DEFAULT '0',
  `num_draws` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`map_id`),
  CONSTRAINT `table_map_features_ibfk_1` FOREIGN KEY (`map_id`) REFERENCES `map_version` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `table_mod`
--

DROP TABLE IF EXISTS `table_mod`;
/*!50001 DROP VIEW IF EXISTS `table_mod`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `table_mod` AS SELECT
 1 AS `id`,
 1 AS `uid`,
 1 AS `name`,
 1 AS `version`,
 1 AS `author`,
 1 AS `ui`,
 1 AS `date`,
 1 AS `downloads`,
 1 AS `likes`,
 1 AS `played`,
 1 AS `description`,
 1 AS `likers`,
 1 AS `filename`,
 1 AS `icon`,
 1 AS `ranked`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `teamkills`
--

DROP TABLE IF EXISTS `teamkills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teamkills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `teamkiller` mediumint(8) unsigned NOT NULL COMMENT 'login of the player who performed the teamkill',
  `victim` mediumint(8) unsigned NOT NULL COMMENT 'login of the player who got teamkilled and reported the tk',
  `game_id` int(10) unsigned NOT NULL COMMENT 'game-id where teamkill was performed',
  `gametime` mediumint(8) unsigned NOT NULL COMMENT 'time of game in seconds when tk was performed',
  `reported_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `game_id` (`game_id`),
  KEY `teamkiller_fk` (`teamkiller`),
  KEY `victim_fk` (`victim`),
  CONSTRAINT `teamkiller_fk` FOREIGN KEY (`teamkiller`) REFERENCES `login` (`id`),
  CONSTRAINT `teamkills_game_stats_id_fk` FOREIGN KEY (`game_id`) REFERENCES `game_stats` (`id`),
  CONSTRAINT `victim_fk` FOREIGN KEY (`victim`) REFERENCES `login` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tutorial`
--

DROP TABLE IF EXISTS `tutorial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutorial` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `map_version_id` mediumint(8) unsigned DEFAULT NULL,
  `title_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The key for the title of the tutorial shown in client',
  `description_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The key for the description of the tutorial, the text in the messages table must be in HTML',
  `category` int(10) unsigned NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The ''image''-path for to a preview image of the tutorial, relative to the base url defined in the api',
  `ordinal` int(11) NOT NULL COMMENT 'The ''ordinal'' which defines in which order the tutorials are shown in the client (within their category)',
  `launchable` tinyint(1) NOT NULL COMMENT 'Boolean that defines whether or not the tutorial can be launched',
  `technical_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The ''technical_name'' of the tutorial given to the tutorial mod to decide what tutorial to start, when implemented',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tutorial_map_version` (`map_version_id`),
  KEY `tutorial_category` (`category`),
  CONSTRAINT `tutorial_category` FOREIGN KEY (`category`) REFERENCES `tutorial_category` (`id`),
  CONSTRAINT `tutorial_map_version` FOREIGN KEY (`map_version_id`) REFERENCES `map_version` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tutorial_category`
--

DROP TABLE IF EXISTS `tutorial_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutorial_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tutorial_sections`
--

DROP TABLE IF EXISTS `tutorial_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutorial_sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `section` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tutorials`
--

DROP TABLE IF EXISTS `tutorials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutorials` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `section` int(10) unsigned NOT NULL,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `map` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sectionIdx` (`section`),
  CONSTRAINT `tutorials_ibfk_1` FOREIGN KEY (`section`) REFERENCES `tutorial_sections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unique_id_users`
--

DROP TABLE IF EXISTS `unique_id_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unique_id_users` (
  `user_id` mediumint(8) unsigned NOT NULL,
  `uniqueid_hash` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`uniqueid_hash`),
  KEY `FK_user_hash_to_uid` (`uniqueid_hash`),
  CONSTRAINT `FK_unique_id_users_user_id_to_login` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`),
  CONSTRAINT `FK_user_hash_to_uid` FOREIGN KEY (`uniqueid_hash`) REFERENCES `uniqueid` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uniqueid`
--

DROP TABLE IF EXISTS `uniqueid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uniqueid` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `hash` char(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mem_SerialNumber` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deviceID` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `manufacturer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `processorId` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SMBIOSBIOSVersion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serialNumber` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `volumeSerialNumber` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_hash_index` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=428581 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uniqueid_exempt`
--

DROP TABLE IF EXISTS `uniqueid_exempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uniqueid_exempt` (
  `user_id` mediumint(8) unsigned DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `idUser` (`user_id`),
  CONSTRAINT `FK_uniqueid_exempt_user_id_to_login` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_balancetesting`
--

DROP TABLE IF EXISTS `updates_balancetesting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_balancetesting` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_balancetesting_files`
--

DROP TABLE IF EXISTS `updates_balancetesting_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_balancetesting_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=1128 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_blackops`
--

DROP TABLE IF EXISTS `updates_blackops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_blackops` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_blackops_files`
--

DROP TABLE IF EXISTS `updates_blackops_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_blackops_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_civilians`
--

DROP TABLE IF EXISTS `updates_civilians`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_civilians` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_civilians_files`
--

DROP TABLE IF EXISTS `updates_civilians_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_civilians_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_claustrophobia`
--

DROP TABLE IF EXISTS `updates_claustrophobia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_claustrophobia` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_claustrophobia_files`
--

DROP TABLE IF EXISTS `updates_claustrophobia_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_claustrophobia_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_coop`
--

DROP TABLE IF EXISTS `updates_coop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_coop` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_coop_files`
--

DROP TABLE IF EXISTS `updates_coop_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_coop_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_diamond`
--

DROP TABLE IF EXISTS `updates_diamond`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_diamond` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_diamond_files`
--

DROP TABLE IF EXISTS `updates_diamond_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_diamond_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_equilibrium`
--

DROP TABLE IF EXISTS `updates_equilibrium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_equilibrium` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_equilibrium_files`
--

DROP TABLE IF EXISTS `updates_equilibrium_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_equilibrium_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_faf`
--

DROP TABLE IF EXISTS `updates_faf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_faf` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_faf_files`
--

DROP TABLE IF EXISTS `updates_faf_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_faf_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=1453 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_fafbeta`
--

DROP TABLE IF EXISTS `updates_fafbeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_fafbeta` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_fafbeta_files`
--

DROP TABLE IF EXISTS `updates_fafbeta_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_fafbeta_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=2580 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_fafdevelop`
--

DROP TABLE IF EXISTS `updates_fafdevelop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_fafdevelop` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_fafdevelop_files`
--

DROP TABLE IF EXISTS `updates_fafdevelop_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_fafdevelop_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=5998 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_gw`
--

DROP TABLE IF EXISTS `updates_gw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_gw` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_gw_files`
--

DROP TABLE IF EXISTS `updates_gw_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_gw_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_koth`
--

DROP TABLE IF EXISTS `updates_koth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_koth` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_koth_files`
--

DROP TABLE IF EXISTS `updates_koth_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_koth_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_labwars`
--

DROP TABLE IF EXISTS `updates_labwars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_labwars` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_labwars_files`
--

DROP TABLE IF EXISTS `updates_labwars_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_labwars_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_murderparty`
--

DROP TABLE IF EXISTS `updates_murderparty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_murderparty` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_murderparty_files`
--

DROP TABLE IF EXISTS `updates_murderparty_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_murderparty_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_nomads`
--

DROP TABLE IF EXISTS `updates_nomads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_nomads` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_nomads_files`
--

DROP TABLE IF EXISTS `updates_nomads_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_nomads_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=498 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_phantomx`
--

DROP TABLE IF EXISTS `updates_phantomx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_phantomx` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_phantomx_files`
--

DROP TABLE IF EXISTS `updates_phantomx_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_phantomx_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_tutorials`
--

DROP TABLE IF EXISTS `updates_tutorials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_tutorials` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_tutorials_files`
--

DROP TABLE IF EXISTS `updates_tutorials_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_tutorials_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_vanilla`
--

DROP TABLE IF EXISTS `updates_vanilla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_vanilla` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_vanilla_files`
--

DROP TABLE IF EXISTS `updates_vanilla_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_vanilla_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_xtremewars`
--

DROP TABLE IF EXISTS `updates_xtremewars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_xtremewars` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) NOT NULL,
  `path` varchar(45) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `updates_xtremewars_files`
--

DROP TABLE IF EXISTS `updates_xtremewars_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates_xtremewars_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fileId` smallint(5) unsigned NOT NULL,
  `version` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `md5` varchar(45) NOT NULL,
  `obselete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fileId` (`fileId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `user_agent_stats`
--

DROP TABLE IF EXISTS `user_agent_stats`;
/*!50001 DROP VIEW IF EXISTS `user_agent_stats`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `user_agent_stats` AS SELECT
 1 AS `user_agent`,
 1 AS `total`,
 1 AS `percentage`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `technical_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'hardcoded names to be used in code',
  `parent_group_id` mediumint(8) unsigned DEFAULT NULL,
  `public` tinyint(1) NOT NULL COMMENT 'Public groups are visible for everyone, the rest only for internal permissions',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'name key of user group in translation table',
  PRIMARY KEY (`id`),
  KEY `parent_group_key` (`parent_group_id`),
  CONSTRAINT `user_group_ibfk_1` FOREIGN KEY (`parent_group_id`) REFERENCES `user_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='List of all user groups. Some of them are only informative  (i.e. council of setons on website), others for permissions system.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_group_assignment`
--

DROP TABLE IF EXISTS `user_group_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group_assignment` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `user_group_assignment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`),
  CONSTRAINT `user_group_assignment_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Assign users (login) to a role (a bunch of permissions)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_notes`
--

DROP TABLE IF EXISTS `user_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(9) unsigned NOT NULL,
  `author` mediumint(9) unsigned NOT NULL,
  `watched` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'boolean that marks notes that should be reviewed at a later time (i.e. gather facts before applying a ban)',
  `note` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_notes_user_login_id_fk` (`user_id`),
  KEY `user_notes_author_login_id_fk` (`author`),
  KEY `user_notes_watched_index` (`watched`),
  CONSTRAINT `user_notes_author_login_id_fk` FOREIGN KEY (`author`) REFERENCES `login` (`id`),
  CONSTRAINT `user_notes_user_login_id_fk` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Notes taken by moderators';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `version_lobby`
--

DROP TABLE IF EXISTS `version_lobby`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version_lobby` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file` varchar(100) DEFAULT NULL,
  `version` varchar(100) NOT NULL COMMENT 'Current version of the official client',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vm_exempt`
--

DROP TABLE IF EXISTS `vm_exempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vm_exempt` (
  `idUser` mediumint(8) unsigned DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `idUser` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vote`
--

DROP TABLE IF EXISTS `vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vote` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `player_id` mediumint(8) unsigned NOT NULL,
  `voting_subject_id` int(10) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `one_vote_only` (`player_id`,`voting_subject_id`),
  KEY `voting_subject_of_vote` (`voting_subject_id`),
  CONSTRAINT `player_of_vote` FOREIGN KEY (`player_id`) REFERENCES `login` (`id`),
  CONSTRAINT `voting_subject_of_vote` FOREIGN KEY (`voting_subject_id`) REFERENCES `voting_subject` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voting_answer`
--

DROP TABLE IF EXISTS `voting_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voting_answer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vote_id` int(10) unsigned NOT NULL,
  `voting_choice_id` int(10) unsigned NOT NULL,
  `alternative_ordinal` tinyint(3) unsigned DEFAULT NULL COMMENT 'Defines what preference for alternative voting this answer is',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `one_answer_only` (`vote_id`,`voting_choice_id`),
  KEY `voting_choice_of_voting_answer` (`voting_choice_id`),
  CONSTRAINT `vote_of_voting_answer` FOREIGN KEY (`vote_id`) REFERENCES `vote` (`id`),
  CONSTRAINT `voting_choice_of_voting_answer` FOREIGN KEY (`voting_choice_id`) REFERENCES `voting_choice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voting_choice`
--

DROP TABLE IF EXISTS `voting_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voting_choice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `choice_text_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'With this key the ''choice_text'' can be loaded from the messages table',
  `voting_question_id` int(10) unsigned NOT NULL,
  `description_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The ''description-key'' of the voting choice, with it additional information (HTML) can be loaded from the messages table',
  `ordinal` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ''ordinal'' of the voting choice, in the client choices are shown according to their ordinal value',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `voting_question_of_voting_choice` (`voting_question_id`),
  CONSTRAINT `voting_question_of_voting_choice` FOREIGN KEY (`voting_question_id`) REFERENCES `voting_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voting_question`
--

DROP TABLE IF EXISTS `voting_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voting_question` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `max_answers` int(10) unsigned NOT NULL DEFAULT '1',
  `question_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'With this key the ''question'' can be loaded from the messages table',
  `voting_subject_id` int(10) unsigned NOT NULL,
  `description_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The ''description-key'' of the voting question, with it additional information (HTML) can be loaded from the messages table',
  `ordinal` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ''ordinal'' of the voting question, in the client questions are shown according to their ordinal value',
  `alternative_voting` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines whether alternative voting applies to this question',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `voting_subject_of_voting_question` (`voting_subject_id`),
  CONSTRAINT `voting_subject_of_voting_question` FOREIGN KEY (`voting_subject_id`) REFERENCES `voting_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=429 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voting_subject`
--

DROP TABLE IF EXISTS `voting_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voting_subject` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subject_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'With this key the ''subject'' can be loaded from the messages table',
  `begin_of_vote_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_of_vote_time` datetime NOT NULL,
  `min_games_to_vote` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of games a player must have to in order to vote',
  `description_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The ''description-key'' of the voting subject with it additional information (HTML) can be loaded from the messages table',
  `topic_url` mediumtext COLLATE utf8mb4_unicode_ci COMMENT 'An URL to a page with additional information, e.g. a forum post.',
  `reveal_winner` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'When set to true after voting ended the winner is calculated and shown publicly',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `winner_for_voting_question`
--

DROP TABLE IF EXISTS `winner_for_voting_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `winner_for_voting_question` (
  `voting_question_id` int(10) unsigned NOT NULL,
  `voting_choice_id` int(10) unsigned NOT NULL,
  KEY `voting_question_of_winner` (`voting_question_id`),
  KEY `voting_choice_of_winner` (`voting_choice_id`),
  CONSTRAINT `voting_choice_of_winner` FOREIGN KEY (`voting_choice_id`) REFERENCES `voting_choice` (`id`),
  CONSTRAINT `voting_question_of_winner` FOREIGN KEY (`voting_question_id`) REFERENCES `voting_question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'faf_lobby'
--
/*!50003 DROP PROCEDURE IF EXISTS `doListLobbyAdmins` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `doListLobbyAdmins`()
BEGIN
select id, login from login inner join lobby_admin on login.id=lobby_admin.user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `doShowUniqueIDs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `doShowUniqueIDs`(IN username varchar(20))
begin
select * from uniqueid inner join (select id from login where lower(login)=lower(username)) as s on uniqueid.userid=s.id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `doShowUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `doShowUser`(IN name VARCHAR(20))
BEGIN
select * from login where lower(login)=lower(name);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fail_or_finish` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fail_or_finish`()
BEGIN
    IF tap.num_failed() > 0 THEN
        ROLLBACK;
        SELECT `Tests failed`;
    ELSE
        CALL tap.finish();
        ROLLBACK TO after_migration;
        COMMIT;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_game_reviews_summary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_game_reviews_summary`(p_game_id INT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
    SELECT
      IFNULL(sum((score - 1) * 0.25), 0),
      IFNULL(sum(1 - (score - 1) * 0.25), 0),
      IFNULL(sum(score), 0),
      IFNULL(count(*), 0)
    INTO @new_positive, @new_negative, @new_score, @new_reviews
    FROM game_review
    WHERE game_id = p_game_id;


    SET @new_lower_bound = IFNULL(
        ((@new_positive + 1.9208) / IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1) -
         1.96 * SQRT((@new_positive * @new_negative) / (@new_positive + @new_negative) + 0.9604) /
         IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1)) /
        (1 + 3.8416 / IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1)), 0);

    INSERT INTO game_reviews_summary (game_id, positive, negative, score, reviews, lower_bound)
    VALUES (p_game_id, @new_positive, @new_negative, @new_score, @new_reviews, @new_lower_bound)
    ON DUPLICATE KEY UPDATE
      positive    = @new_positive,
      negative    = @new_negative,
      score       = @new_score,
      reviews     = @new_reviews,
      lower_bound = @new_lower_bound;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_game_review_summary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_game_review_summary`(IN game_id INT)
    READS SQL DATA
BEGIN
    -- Update average review score and number of reviews in table `game_stats`
    SELECT
      COALESCE(AVG(score), 0),
      COALESCE(count(*), 0)
    INTO @averageScore, @reviews
    FROM game_review
    WHERE game_review.game_id = game_id;

    UPDATE game_stats
    SET game_stats.average_review_score = @averageScore,
      game_stats.reviews                = @reviews
    WHERE id = game_id;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_map_review_summary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_map_review_summary`(IN map_version_id INT)
    READS SQL DATA
BEGIN
    -- Update average review score and number of reviews in table `map_version`
    SELECT
      COALESCE(AVG(score), 0),
      COALESCE(count(*), 0)
    INTO @averageScore, @reviews
    FROM map_version_review
    WHERE map_version_review.map_version_id = map_version_id;

    UPDATE map_version
    SET map_version.average_review_score = @averageScore,
      map_version.reviews                = @reviews
    WHERE id = map_version_id;

    -- Update average review score and number of reviews of all other map versions belonging to the same map
    SELECT
      COALESCE(AVG(score), 0),
      COALESCE(count(*), 0)
    INTO @averageScore, @reviews
    FROM map_version_review
      JOIN map_version ON map_version_review.map_version_id = map_version.id
    WHERE map_version.map_id =
          (SELECT new_version.map_id
           FROM map_version new_version
           WHERE new_version.id = map_version_id);

    UPDATE map
      JOIN map_version ON map.id = map_version.map_id
    SET map.average_review_score = @averageScore,
      map.reviews                = @reviews
    WHERE map_version.id = map_version_id;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_map_version_reviews_summary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `update_map_version_reviews_summary`(p_map_version_id INT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
    SELECT
      IFNULL(sum((score - 1) * 0.25), 0),
      IFNULL(sum(1 - (score - 1) * 0.25), 0),
      IFNULL(sum(score), 0),
      IFNULL(count(*), 0)
    INTO @new_positive, @new_negative, @new_score, @new_reviews
    FROM map_version_review
    WHERE map_version_id = p_map_version_id;

    -- See https://onextrapixel.com/how-to-build-a-5-star-rating-system-with-wilson-interval-in-mysql/
    SET @new_lower_bound = IFNULL(
        ((@new_positive + 1.9208) / IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1) -
         1.96 * SQRT((@new_positive * @new_negative) / (@new_positive + @new_negative) + 0.9604) /
         IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1)) /
        (1 + 3.8416 / IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1)), 0);

    INSERT INTO map_version_reviews_summary (map_version_id, positive, negative, score, reviews, lower_bound)
    VALUES (p_map_version_id, @new_positive, @new_negative, @new_score, @new_reviews, @new_lower_bound)
    ON DUPLICATE KEY UPDATE
      positive    = @new_positive,
      negative    = @new_negative,
      score       = @new_score,
      reviews     = @new_reviews,
      lower_bound = @new_lower_bound;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_mod_review_summary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mod_review_summary`(IN mod_version_id INT)
    READS SQL DATA
BEGIN
    -- Update average review score and number of reviews in table `mod_version`
    SELECT
      COALESCE(AVG(score), 0),
      COALESCE(count(*), 0)
    INTO @averageScore, @reviews
    FROM mod_version_review
    WHERE mod_version_review.mod_version_id = mod_version_id;

    UPDATE mod_version
    SET mod_version.average_review_score = @averageScore,
      mod_version.reviews                = @reviews
    WHERE id = mod_version_id;

    -- Update average review score and number of reviews of all other mod versions belonging to the same mod
    SELECT
      COALESCE(AVG(score), 0),
      COALESCE(count(*), 0)
    INTO @averageScore, @reviews
    FROM mod_version_review
      JOIN mod_version ON mod_version_review.mod_version_id = mod_version.id
    WHERE mod_version.mod_id =
          (SELECT new_version.mod_id
           FROM mod_version new_version
           WHERE new_version.id = mod_version_id);

    UPDATE `mod`
      JOIN mod_version ON `mod`.id = mod_version.mod_id
    SET `mod`.average_review_score = @averageScore,
      `mod`.reviews                = @reviews
    WHERE mod_version.id = mod_version_id;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_mod_version_reviews_summary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `update_mod_version_reviews_summary`(p_mod_version_id INT UNSIGNED)
    MODIFIES SQL DATA
BEGIN
    SELECT
      IFNULL(sum((score - 1) * 0.25), 0),
      IFNULL(sum(1 - (score - 1) * 0.25), 0),
      IFNULL(sum(score), 0),
      IFNULL(count(*), 0)
    INTO @new_positive, @new_negative, @new_score, @new_reviews
    FROM mod_version_review
    WHERE mod_version_id = p_mod_version_id;

    -- See https://onextrapixel.com/how-to-build-a-5-star-rating-system-with-wilson-interval-in-mysql/
    SET @new_lower_bound = IFNULL(
        ((@new_positive + 1.9208) / IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1) -
         1.96 * SQRT((@new_positive * @new_negative) / (@new_positive + @new_negative) + 0.9604) /
         IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1)) /
        (1 + 3.8416 / IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1)), 0);

    INSERT INTO mod_version_reviews_summary (mod_version_id, positive, negative, score, reviews, lower_bound)
    VALUES (p_mod_version_id, @new_positive, @new_negative, @new_score, @new_reviews, @new_lower_bound)
    ON DUPLICATE KEY UPDATE
      positive    = @new_positive,
      negative    = @new_negative,
      score       = @new_score,
      reviews     = @new_reviews,
      lower_bound = @new_lower_bound;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `lobby_ban`
--

/*!50001 DROP VIEW IF EXISTS `lobby_ban`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `lobby_ban` AS select `ban`.`player_id` AS `idUser`,`ban`.`reason` AS `reason`,coalesce(`ban`.`revoke_time`,`ban`.`expires_at`,cast('2999-12-31' as date)) AS `expires_at` from `ban` where (`ban`.`level` = 'GLOBAL') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `map_statistic`
--

/*!50001 DROP VIEW IF EXISTS `map_statistic`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `map_statistic` AS select `mv`.`map_id` AS `id`,count(0) AS `times_played`,`m`.`create_time` AS `create_time`,now() AS `update_time` from ((`game_stats` join `map_version` `mv` on((`game_stats`.`mapId` = `mv`.`id`))) join `map` `m` on((`mv`.`map_id` = `m`.`id`))) group by `mv`.`map_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `map_statistics`
--

/*!50001 DROP VIEW IF EXISTS `map_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `map_statistics` AS select `map_version`.`map_id` AS `map_id`,coalesce(sum(`table_map_features`.`downloads`),0) AS `downloads`,coalesce(sum(`table_map_features`.`times_played`),0) AS `plays`,coalesce(sum(`table_map_features`.`num_draws`),0) AS `draws` from (`map_version` left join `table_map_features` on((`map_version`.`id` = `table_map_features`.`map_id`))) group by `map_version`.`map_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `map_version_statistics`
--

/*!50001 DROP VIEW IF EXISTS `map_version_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `map_version_statistics` AS select `map_version`.`id` AS `map_version_id`,coalesce(`table_map_features`.`downloads`,0) AS `downloads`,coalesce(`table_map_features`.`times_played`,0) AS `plays`,coalesce(`table_map_features`.`num_draws`,0) AS `draws` from (`map_version` left join `table_map_features` on((`table_map_features`.`map_id` = `map_version`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `table_map`
--

/*!50001 DROP VIEW IF EXISTS `table_map`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `table_map` AS (select `v`.`id` AS `id`,`m`.`display_name` AS `name`,`v`.`description` AS `description`,`v`.`max_players` AS `max_players`,`m`.`map_type` AS `map_type`,`m`.`battle_type` AS `battle_type`,`v`.`width` AS `map_sizeX`,`v`.`height` AS `map_sizeY`,`v`.`version` AS `version`,`v`.`filename` AS `filename`,`v`.`hidden` AS `hidden`,`m`.`id` AS `mapuid` from (`map` `m` join `map_version` `v` on((`m`.`id` = `v`.`map_id`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `table_mod`
--

/*!50001 DROP VIEW IF EXISTS `table_mod`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `table_mod` AS select `v`.`id` AS `id`,`v`.`uid` AS `uid`,`m`.`display_name` AS `name`,`v`.`version` AS `version`,`m`.`author` AS `author`,(case `v`.`type` when 'UI' then 1 when 'SIM' then 0 end) AS `ui`,`v`.`create_time` AS `date`,coalesce(`s`.`downloads`,0) AS `downloads`,coalesce(`s`.`likes`,0) AS `likes`,coalesce(`s`.`times_played`,0) AS `played`,`v`.`description` AS `description`,`s`.`likers` AS `likers`,`v`.`filename` AS `filename`,`v`.`icon` AS `icon`,`v`.`ranked` AS `ranked` from ((`mod` `m` join `mod_version` `v` on((`m`.`id` = `v`.`mod_id`))) left join `mod_stats` `s` on((`m`.`id` = `s`.`mod_id`))) where (`v`.`hidden` = 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_agent_stats`
--

/*!50001 DROP VIEW IF EXISTS `user_agent_stats`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `user_agent_stats` AS select `l`.`user_agent` AS `user_agent`,count(1) AS `total`,((count(1) / `t`.`cnt`) * 100) AS `percentage` from (`login` `l` join (select count(1) AS `cnt` from `login` where `login`.`id` in (select `game_player_stats`.`playerId` from `game_player_stats` where (`game_player_stats`.`scoreTime` between (now() - interval 30 day) and now()))) `t`) where `l`.`id` in (select `game_player_stats`.`playerId` from `game_player_stats` where (`game_player_stats`.`scoreTime` between (now() - interval 30 day) and now())) group by `l`.`user_agent` */;
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

-- Dump completed on 2021-02-18  0:04:29
