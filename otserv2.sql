-- phpMyAdmin SQL Dump
-- version 4.0.10deb1ubuntu0.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tempo de Geração: 18/04/2021 às 04:06
-- Versão do servidor: 5.5.62-0ubuntu0.14.04.1
-- Versão do PHP: 5.5.9-1ubuntu4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de dados: `otserv2`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL,
  `salt` varchar(40) NOT NULL DEFAULT '',
  `premdays` int(11) NOT NULL DEFAULT '0',
  `vip` tinyint(4) NOT NULL DEFAULT '0',
  `vip_days` int(11) NOT NULL DEFAULT '0',
  `vip_time` int(11) NOT NULL DEFAULT '0',
  `lastday` int(10) unsigned NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '',
  `key` varchar(128) NOT NULL DEFAULT '',
  `blocked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'internal usage',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '1',
  `page_access` int(11) DEFAULT NULL,
  `page_lastday` int(11) DEFAULT NULL,
  `email_new` varchar(255) DEFAULT NULL,
  `email_new_time` int(15) DEFAULT NULL,
  `rlname` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `created` int(16) DEFAULT NULL,
  `email_code` varchar(255) DEFAULT NULL,
  `next_email` int(11) DEFAULT NULL,
  `premium_points` int(11) DEFAULT NULL,
  `nickname` char(48) DEFAULT NULL,
  `avatar` char(48) DEFAULT NULL,
  `about_me` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1208 ;

--
-- Fazendo dump de dados para tabela `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `password`, `salt`, `premdays`, `vip`, `vip_days`, `vip_time`, `lastday`, `email`, `key`, `blocked`, `warnings`, `group_id`, `page_access`, `page_lastday`, `email_new`, `email_new_time`, `rlname`, `location`, `created`, `email_code`, `next_email`, `premium_points`, `nickname`, `avatar`, `about_me`) VALUES
(1, '1', 'b395159edb28dbda92f46b38372847d7b1e22e36', '', 0, 0, 0, 0, 0, '', '', 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Gatilhos `accounts`
--
DROP TRIGGER IF EXISTS `ondelete_accounts`;
DELIMITER //
CREATE TRIGGER `ondelete_accounts` BEFORE DELETE ON `accounts`
 FOR EACH ROW BEGIN
	DELETE FROM `bans` WHERE `type` IN (3, 4) AND `value` = OLD.`id`;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_viplist`
--

CREATE TABLE IF NOT EXISTS `account_viplist` (
  `account_id` int(11) NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  UNIQUE KEY `account_id_2` (`account_id`,`player_id`),
  KEY `account_id` (`account_id`),
  KEY `player_id` (`player_id`),
  KEY `world_id` (`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `bans`
--

CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '1 - ip banishment, 2 - namelock, 3 - account banishment, 4 - notation, 5 - deletion',
  `value` int(10) unsigned NOT NULL COMMENT 'ip address (integer), player guid or account number',
  `param` int(10) unsigned NOT NULL DEFAULT '4294967295' COMMENT 'used only for ip banishment mask (integer)',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `expires` int(11) NOT NULL,
  `added` int(10) unsigned NOT NULL,
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `reason` int(10) unsigned NOT NULL DEFAULT '0',
  `action` int(10) unsigned NOT NULL DEFAULT '0',
  `statement` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `type` (`type`,`value`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `bugtracker`
--

CREATE TABLE IF NOT EXISTS `bugtracker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` int(3) NOT NULL,
  `time` int(11) DEFAULT NULL,
  `author` int(11) NOT NULL,
  `text` text,
  `title` varchar(120) DEFAULT NULL,
  `done` tinyint(3) DEFAULT NULL,
  `priority` tinyint(3) DEFAULT NULL,
  `closed` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `author` (`author`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) DEFAULT NULL,
  `body` text,
  `time` int(11) DEFAULT '0',
  `author` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `news_id` (`news_id`),
  KEY `author` (`author`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `environment_killers`
--

CREATE TABLE IF NOT EXISTS `environment_killers` (
  `kill_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  KEY `kill_id` (`kill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `forums`
--

CREATE TABLE IF NOT EXISTS `forums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(120) DEFAULT NULL,
  `description` tinytext,
  `access` smallint(5) DEFAULT '1' COMMENT 'Min. access to see the board',
  `closed` tinyint(1) DEFAULT NULL,
  `moderators` tinytext,
  `order` int(6) DEFAULT NULL,
  `requireLogin` tinyint(1) DEFAULT NULL,
  `guild` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

--
-- Fazendo dump de dados para tabela `forums`
--

INSERT INTO `forums` (`id`, `name`, `description`, `access`, `closed`, `moderators`, `order`, `requireLogin`, `guild`) VALUES
(1, 'Guildboard for The One', 'Guildboard for The One', 0, 0, 'Simba', 9999, 1, 2),
(3, 'Guildboard for ToDo MeU TiMe DiZ QuE Eu SoU CaPaZ', 'Guildboard for ToDo MeU TiMe DiZ QuE Eu SoU CaPaZ', 0, 0, 'Caninos Brancos', 9999, 1, 5),
(5, 'Guildboard for Os Viloes', 'Guildboard for Os Viloes', 0, 0, 'Eobard Thawne', 9999, 1, 7),
(6, 'Guildboard for Pipipitchu', 'Guildboard for Pipipitchu', 0, 0, 'Divine Sasuke', 9999, 1, 12),
(7, 'Guildboard for Old School', 'Guildboard for Old School', 0, 0, 'snTT', 9999, 1, 13),
(8, 'Guildboard for War', 'Guildboard for War', 0, 0, 'Chupa Saco', 9999, 1, 14),
(10, 'Guildboard for Akatsuki', 'Guildboard for Akatsuki', 0, 0, 'Shika Louco', 9999, 1, 16),
(13, 'Guildboard for Cosa Nostra', 'Guildboard for Cosa Nostra', 0, 0, 'Sir Crocodile', 9999, 1, 19),
(14, 'Guildboard for Baroque Works', 'Guildboard for Baroque Works', 0, 0, 'Pablo Escobar', 9999, 1, 20),
(15, 'Guildboard for Vaticano ', 'Guildboard for Vaticano ', 0, 0, 'Papa Francisco', 9999, 1, 21),
(16, 'Guildboard for Cosa Nostra', 'Guildboard for Cosa Nostra', 0, 0, 'Michael Corleone', 9999, 1, 22),
(17, 'Guildboard for Keep Out', 'Guildboard for Keep Out', 0, 0, 'Stinker', 9999, 1, 23),
(18, 'Guildboard for Royal System', 'Guildboard for Royal System', 0, 0, 'Mirai verdinho', 9999, 1, 24),
(19, 'Guildboard for Royal Knight', 'Guildboard for Royal Knight', 0, 0, 'Aluc Green Rainbolt', 9999, 1, 25),
(21, 'Guildboard for Cosa Nostra', 'Guildboard for Cosa Nostra', 0, 0, 'King Gustav', 9999, 1, 27),
(22, 'Guildboard for Bolha', 'Guildboard for Bolha', 0, 0, 'Szukam Zabici', 9999, 1, 28),
(23, 'Guildboard for WSystem', 'Guildboard for WSystem', 0, 0, 'Curo Kocu', 9999, 1, 29),
(26, 'Guildboard for Administracao', 'Guildboard for Administracao', 0, 0, '[ADM]Knepper', 9999, 1, 32),
(27, 'Guildboard for Cosa Nostra System', 'Guildboard for Cosa Nostra System', 0, 0, 'Mike Tyson', 9999, 1, 33),
(28, 'Guildboard for Angel of Death', 'Guildboard for Angel of Death', 0, 0, 'Joao frango', 9999, 1, 34),
(29, 'Guildboard for Foetr', 'Guildboard for Foetr', 0, 0, 'Roletada', 9999, 1, 35),
(30, 'Guildboard for AKATSUKI', 'Guildboard for AKATSUKI', 0, 0, 'Charllote', 9999, 1, 36),
(31, 'Guildboard for Royal Knight', 'Guildboard for Royal Knight', 0, 0, 'Aluc Cadeirante', 9999, 1, 37),
(32, 'Guildboard for Royal system', 'Guildboard for Royal system', 0, 0, 'Mirai verdinho', 9999, 1, 38),
(33, 'Guildboard for The Order', 'Guildboard for The Order', 0, 0, 'Play stompdmg', 9999, 1, 39),
(35, 'Guildboard for Jambo', 'Guildboard for Jambo', 0, 0, 'Koutuka Teu Kou', 9999, 1, 42),
(36, 'Guildboard for The Old Guardian', 'Guildboard for The Old Guardian', 0, 0, 'Athenas', 9999, 1, 45),
(37, 'Guildboard for Naruto Fun', 'Guildboard for Naruto Fun', 0, 0, 'Sasukeeeeee', 9999, 1, 46),
(38, 'Guildboard for Hokage', 'Guildboard for Hokage', 0, 0, 'Teste Four', 9999, 1, 47),
(39, 'Guildboard for Hope', 'Guildboard for Hope', 0, 0, 'Buff Lee Please', 9999, 1, 48),
(41, 'Guildboard for UP Club ', 'Guildboard for UP Club ', 0, 0, 'Balmain', 9999, 1, 50),
(42, 'Guildboard for Angel of Death', 'Guildboard for Angel of Death', 0, 0, 'Joao frango', 9999, 1, 51),
(43, 'Guildboard for Peace', 'Guildboard for Peace', 0, 0, 'Hokage Tsu', 9999, 1, 52);

-- --------------------------------------------------------

--
-- Estrutura para tabela `friends`
--

CREATE TABLE IF NOT EXISTS `friends` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `with` int(11) DEFAULT NULL,
  `friend` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `with` (`with`),
  KEY `friend` (`friend`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `global_storage`
--

CREATE TABLE IF NOT EXISTS `global_storage` (
  `key` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '0',
  UNIQUE KEY `key` (`key`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guilds`
--

CREATE TABLE IF NOT EXISTS `guilds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL,
  `checkdata` int(11) NOT NULL,
  `motd` varchar(255) NOT NULL,
  `balance` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`world_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=53 ;

--
-- Gatilhos `guilds`
--
DROP TRIGGER IF EXISTS `oncreate_guilds`;
DELIMITER //
CREATE TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds`
 FOR EACH ROW BEGIN
	INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Leader', 3, NEW.`id`);
	INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Vice-Leader', 2, NEW.`id`);
	INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('Member', 1, NEW.`id`);
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `ondelete_guilds`;
DELIMITER //
CREATE TRIGGER `ondelete_guilds` BEFORE DELETE ON `guilds`
 FOR EACH ROW BEGIN
	UPDATE `players` SET `guildnick` = '', `rank_id` = 0 WHERE `rank_id` IN (SELECT `id` FROM `guild_ranks` WHERE `guild_id` = OLD.`id`);
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_invites`
--

CREATE TABLE IF NOT EXISTS `guild_invites` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `guild_id` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `player_id` (`player_id`,`guild_id`),
  KEY `guild_id` (`guild_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_kills`
--

CREATE TABLE IF NOT EXISTS `guild_kills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) NOT NULL,
  `war_id` int(11) NOT NULL,
  `death_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `guild_kills_ibfk_1` (`war_id`),
  KEY `guild_kills_ibfk_2` (`death_id`),
  KEY `guild_kills_ibfk_3` (`guild_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_ranks`
--

CREATE TABLE IF NOT EXISTS `guild_ranks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `level` int(11) NOT NULL COMMENT '1 - leader, 2 - vice leader, 3 - member',
  PRIMARY KEY (`id`),
  KEY `guild_id` (`guild_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=148 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_wars`
--

CREATE TABLE IF NOT EXISTS `guild_wars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) NOT NULL,
  `enemy_id` int(11) NOT NULL,
  `begin` bigint(20) NOT NULL DEFAULT '0',
  `end` bigint(20) NOT NULL DEFAULT '0',
  `frags` int(10) unsigned NOT NULL DEFAULT '0',
  `payment` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guild_kills` int(10) unsigned NOT NULL DEFAULT '0',
  `enemy_kills` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `guild_id` (`guild_id`),
  KEY `enemy_id` (`enemy_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `houses`
--

CREATE TABLE IF NOT EXISTS `houses` (
  `id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL,
  `paid` int(10) unsigned NOT NULL DEFAULT '0',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `lastwarning` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `town` int(10) unsigned NOT NULL DEFAULT '0',
  `size` int(10) unsigned NOT NULL DEFAULT '0',
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  `rent` int(10) unsigned NOT NULL DEFAULT '0',
  `doors` int(10) unsigned NOT NULL DEFAULT '0',
  `beds` int(10) unsigned NOT NULL DEFAULT '0',
  `tiles` int(10) unsigned NOT NULL DEFAULT '0',
  `guild` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `clear` tinyint(1) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `id` (`id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `houses`
--

INSERT INTO `houses` (`id`, `world_id`, `owner`, `paid`, `warnings`, `lastwarning`, `name`, `town`, `size`, `price`, `rent`, `doors`, `beds`, `tiles`, `guild`, `clear`) VALUES
(494, 0, 0, 0, 0, 0, 'Unnamed House #494', 5, 24, 24000, 0, 1, 0, 25, 0, 0),
(496, 0, 0, 0, 0, 0, 'Unnamed House #496', 1, 27, 27000, 0, 1, 0, 42, 0, 0),
(497, 0, 0, 0, 0, 0, 'Unnamed House #497', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(500, 0, 0, 0, 0, 0, 'Unnamed House #500', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(501, 0, 0, 0, 0, 0, 'Unnamed House #501', 1, 76, 77000, 0, 1, 1, 94, 0, 0),
(502, 0, 0, 0, 0, 0, 'Unnamed House #502', 1, 78, 78000, 0, 1, 0, 106, 0, 0),
(503, 0, 0, 0, 0, 0, 'Unnamed House #503', 1, 78, 78000, 0, 1, 0, 99, 0, 0),
(504, 0, 0, 0, 0, 0, 'Unnamed House #504', 1, 76, 77000, 0, 1, 1, 102, 0, 0),
(505, 0, 0, 0, 0, 0, 'Unnamed House #505', 1, 27, 27000, 0, 1, 0, 47, 0, 0),
(506, 0, 0, 0, 0, 0, 'Unnamed House #506', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(507, 0, 0, 0, 0, 0, 'Unnamed House #507', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(508, 0, 0, 0, 0, 0, 'Unnamed House #508', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(509, 0, 0, 0, 0, 0, 'Unnamed House #509', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(510, 0, 0, 0, 0, 0, 'Unnamed House #510', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(511, 0, 0, 0, 0, 0, 'Unnamed House #511', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(512, 0, 0, 0, 0, 0, 'Unnamed House #512', 1, 76, 77000, 0, 1, 1, 95, 0, 0),
(513, 0, 0, 0, 0, 0, 'Unnamed House #513', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(514, 0, 0, 0, 0, 0, 'Unnamed House #514', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(515, 0, 0, 0, 0, 0, 'Unnamed House #515', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(516, 0, 0, 0, 0, 0, 'Unnamed House #516', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(517, 0, 0, 0, 0, 0, 'Unnamed House #517', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(518, 0, 0, 0, 0, 0, 'Unnamed House #518', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(519, 0, 0, 0, 0, 0, 'Unnamed House #519', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(520, 0, 0, 0, 0, 0, 'Unnamed House #520', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(521, 0, 0, 0, 0, 0, 'Unnamed House #521', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(522, 0, 0, 0, 0, 0, 'Unnamed House #522', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(523, 0, 0, 0, 0, 0, 'Unnamed House #523', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(524, 0, 0, 0, 0, 0, 'Unnamed House #524', 1, 27, 27000, 0, 1, 0, 48, 0, 0),
(525, 0, 0, 0, 0, 0, 'Unnamed House #525', 1, 12, 12000, 0, 1, 0, 23, 0, 0),
(526, 0, 0, 0, 0, 0, 'Unnamed House #526', 1, 12, 12000, 0, 1, 0, 24, 0, 0),
(527, 0, 0, 0, 0, 0, 'Unnamed House #527', 1, 12, 12000, 0, 1, 0, 24, 0, 0),
(528, 0, 0, 0, 0, 0, 'Unnamed House #528', 1, 12, 12000, 0, 1, 0, 24, 0, 0),
(529, 0, 0, 0, 0, 0, 'Unnamed House #529', 1, 12, 12000, 0, 1, 0, 24, 0, 0),
(530, 0, 0, 0, 0, 0, 'Unnamed House #530', 1, 14, 15000, 0, 1, 1, 25, 0, 0),
(531, 0, 0, 0, 0, 0, 'Unnamed House #531', 1, 12, 12000, 0, 1, 0, 20, 0, 0),
(532, 0, 0, 0, 0, 0, 'Unnamed House #532', 1, 12, 12000, 0, 1, 0, 20, 0, 0),
(533, 0, 0, 0, 0, 0, 'Unnamed House #533', 1, 12, 12000, 0, 1, 0, 20, 0, 0),
(534, 0, 0, 0, 0, 0, 'Unnamed House #534', 1, 10, 11000, 0, 1, 1, 20, 0, 0),
(535, 0, 0, 0, 0, 0, 'Unnamed House #535', 1, 12, 12000, 0, 1, 0, 20, 0, 0),
(536, 0, 0, 0, 0, 0, 'Unnamed House #536', 1, 12, 12000, 0, 1, 0, 20, 0, 0),
(537, 0, 0, 0, 0, 0, 'Unnamed House #537', 1, 12, 12000, 0, 1, 0, 20, 0, 0),
(538, 0, 0, 0, 0, 0, 'Unnamed House #538', 1, 12, 12000, 0, 1, 0, 20, 0, 0),
(539, 0, 0, 0, 0, 0, 'Unnamed House #539', 1, 12, 12000, 0, 1, 0, 20, 0, 0),
(541, 0, 0, 0, 0, 0, 'Unnamed House #541', 1, 12, 12000, 0, 1, 0, 23, 0, 0),
(542, 0, 0, 0, 0, 0, 'Unnamed House #542', 1, 12, 12000, 0, 1, 0, 24, 0, 0),
(543, 0, 0, 0, 0, 0, 'Unnamed House #543', 1, 12, 12000, 0, 1, 0, 24, 0, 0),
(544, 0, 0, 0, 0, 0, 'Unnamed House #544', 1, 12, 12000, 0, 1, 0, 24, 0, 0),
(545, 0, 0, 0, 0, 0, 'Unnamed House #545', 1, 18, 18000, 0, 1, 0, 29, 0, 0),
(546, 0, 5817, 0, 0, 1616124132, 'Unnamed House #546', 1, 88, 88000, 0, 1, 0, 120, 0, 0),
(547, 0, 0, 0, 0, 0, 'Unnamed House #547', 1, 88, 88000, 0, 1, 0, 125, 0, 0),
(548, 0, 5868, 0, 0, 1614915335, 'Unnamed House #548', 1, 92, 94000, 0, 1, 2, 138, 0, 0),
(549, 0, 0, 0, 0, 0, 'Unnamed House #549', 1, 6, 6000, 0, 1, 0, 18, 0, 0),
(550, 0, 0, 0, 0, 0, 'Unnamed House #550', 1, 6, 6000, 0, 1, 0, 18, 0, 0),
(551, 0, 0, 0, 0, 0, 'Unnamed House #551', 1, 6, 6000, 0, 1, 0, 20, 0, 0),
(552, 0, 0, 0, 0, 0, 'Unnamed House #552', 1, 6, 6000, 0, 1, 0, 19, 0, 0),
(553, 0, 0, 0, 0, 0, 'Unnamed House #553', 1, 46, 47000, 0, 1, 1, 98, 0, 0),
(554, 0, 0, 0, 0, 0, 'Unnamed House #554', 1, 48, 48000, 0, 1, 0, 98, 0, 0),
(555, 0, 0, 0, 0, 0, 'Unnamed House #555', 1, 46, 47000, 0, 1, 1, 98, 0, 0),
(624, 0, 0, 0, 0, 0, 'Unnamed House #624', 1, 16, 17000, 0, 1, 1, 39, 0, 0),
(625, 0, 0, 0, 0, 0, 'Unnamed House #625', 1, 18, 18000, 0, 1, 0, 38, 0, 0),
(626, 0, 0, 0, 0, 0, 'Unnamed House #626', 1, 10, 10000, 0, 1, 0, 32, 0, 0),
(627, 0, 0, 0, 0, 0, 'Unnamed House #627', 1, 10, 10000, 0, 1, 0, 32, 0, 0),
(628, 0, 0, 0, 0, 0, 'Unnamed House #628', 1, 18, 18000, 0, 1, 0, 39, 0, 0),
(629, 0, 0, 0, 0, 0, 'Unnamed House #629', 1, 80, 80000, 0, 1, 0, 133, 0, 0),
(630, 0, 0, 0, 0, 0, 'Unnamed House #630', 1, 20, 20000, 0, 1, 0, 47, 0, 0),
(631, 0, 0, 0, 0, 0, 'Unnamed House #631', 1, 18, 18000, 0, 1, 0, 42, 0, 0),
(632, 0, 0, 0, 0, 0, 'Unnamed House #632', 1, 34, 35000, 0, 1, 1, 74, 0, 0),
(633, 0, 0, 0, 0, 0, 'Unnamed House #633', 1, 42, 42000, 0, 1, 0, 90, 0, 0),
(634, 0, 0, 0, 0, 0, 'Unnamed House #634', 1, 9, 9000, 0, 1, 0, 25, 0, 0),
(635, 0, 0, 0, 0, 0, 'Unnamed House #635', 1, 19, 20000, 0, 1, 1, 45, 0, 0),
(636, 0, 0, 0, 0, 0, 'Unnamed House #636', 1, 27, 27000, 0, 1, 0, 55, 0, 0),
(637, 0, 0, 0, 0, 0, 'Unnamed House #637', 1, 15, 15000, 0, 1, 0, 35, 0, 0),
(638, 0, 0, 0, 0, 0, 'Unnamed House #638', 1, 15, 15000, 0, 1, 0, 35, 0, 0),
(639, 0, 0, 0, 0, 0, 'Unnamed House #639', 1, 6, 6000, 0, 1, 0, 20, 0, 0),
(640, 0, 5890, 0, 0, 1615512073, 'Unnamed House #640', 1, 12, 12000, 0, 1, 0, 30, 0, 0),
(641, 0, 5829, 0, 0, 1614799730, 'Unnamed House #641', 1, 32, 32000, 0, 1, 0, 72, 0, 0),
(644, 0, 0, 0, 0, 0, 'Unnamed House #644', 1, 47, 48000, 0, 1, 1, 81, 0, 0),
(645, 0, 0, 0, 0, 0, 'Unnamed House #645', 1, 34, 34000, 0, 1, 0, 72, 0, 0),
(646, 0, 0, 0, 0, 0, 'Unnamed House #646', 1, 13, 14000, 0, 1, 1, 35, 0, 0),
(647, 0, 0, 0, 0, 0, 'Unnamed House #647', 1, 15, 15000, 0, 1, 0, 35, 0, 0),
(648, 0, 0, 0, 0, 0, 'Unnamed House #648', 1, 15, 15000, 0, 1, 0, 35, 0, 0),
(649, 0, 5777, 0, 0, 1614896021, 'Unnamed House #649', 1, 15, 15000, 0, 1, 0, 35, 0, 0),
(650, 0, 5846, 0, 0, 1615361138, 'Unnamed House #650', 1, 15, 15000, 0, 1, 0, 35, 0, 0),
(651, 0, 0, 0, 0, 0, 'Unnamed House #651', 1, 9, 9000, 0, 1, 0, 25, 0, 0),
(652, 0, 0, 0, 0, 0, 'Unnamed House #652', 1, 9, 9000, 0, 1, 0, 25, 0, 0),
(653, 0, 0, 0, 0, 0, 'Unnamed House #653', 1, 9, 9000, 0, 1, 0, 25, 0, 0),
(654, 0, 0, 0, 0, 0, 'Unnamed House #654', 1, 9, 9000, 0, 1, 0, 25, 0, 0),
(655, 0, 0, 0, 0, 0, 'Unnamed House #655', 1, 40, 40000, 0, 1, 0, 70, 0, 0),
(656, 0, 5961, 0, 0, 1615074283, 'Unnamed House #656', 1, 32, 32000, 0, 1, 0, 80, 0, 0),
(657, 0, 0, 0, 0, 0, 'Unnamed House #657', 1, 75, 76000, 0, 1, 1, 152, 0, 0),
(658, 0, 0, 0, 0, 0, 'Unnamed House #658', 1, 114, 114000, 0, 1, 0, 215, 0, 0),
(659, 0, 0, 0, 0, 0, 'Unnamed House #659', 1, 16, 16000, 0, 1, 0, 36, 0, 0),
(660, 0, 0, 0, 0, 0, 'Unnamed House #660', 1, 9, 9000, 0, 1, 0, 29, 0, 0),
(661, 0, 0, 0, 0, 0, 'Unnamed House #661', 1, 30, 30000, 0, 1, 0, 56, 0, 0),
(662, 0, 0, 0, 0, 0, 'Unnamed House #662', 1, 22, 23000, 0, 1, 1, 47, 0, 0),
(663, 0, 0, 0, 0, 0, 'Unnamed House #663', 1, 27, 27000, 0, 1, 0, 75, 0, 0),
(664, 0, 5865, 0, 0, 1614829485, 'Unnamed House #664', 1, 88, 89000, 0, 1, 1, 144, 0, 0),
(665, 0, 0, 0, 0, 0, 'Unnamed House #665', 1, 36, 36000, 0, 1, 0, 64, 0, 0),
(667, 0, 0, 0, 0, 0, 'Unnamed House #667', 1, 84, 84000, 0, 1, 0, 144, 0, 0),
(668, 0, 5840, 0, 0, 1615186098, 'Unnamed House #668', 1, 76, 76000, 0, 1, 0, 128, 0, 0),
(669, 0, 0, 0, 0, 0, 'Unnamed House #669', 1, 36, 36000, 0, 1, 0, 66, 0, 0),
(670, 0, 0, 0, 0, 0, 'Unnamed House #670', 1, 52, 53000, 0, 1, 1, 106, 0, 0),
(671, 0, 0, 0, 0, 0, 'Unnamed House #671', 1, 24, 24000, 0, 1, 0, 48, 0, 0),
(672, 0, 5852, 0, 0, 1614825587, 'Unnamed House #672', 1, 7, 8000, 0, 1, 1, 16, 0, 0),
(673, 0, 0, 0, 0, 0, 'Unnamed House #673', 1, 9, 9000, 0, 1, 0, 25, 0, 0),
(674, 0, 0, 0, 0, 0, 'Unnamed House #674', 1, 18, 18000, 0, 1, 0, 50, 0, 0),
(675, 0, 0, 0, 0, 0, 'Unnamed House #675', 1, 460, 460000, 0, 3, 0, 648, 0, 0),
(678, 0, 0, 0, 0, 0, 'Unnamed House #678', 6, 72, 72000, 0, 1, 0, 112, 0, 0),
(679, 0, 0, 0, 0, 0, 'Unnamed House #679', 6, 14, 14000, 0, 1, 0, 36, 0, 0),
(680, 0, 0, 0, 0, 0, 'Unnamed House #680', 6, 14, 14000, 0, 1, 0, 36, 0, 0),
(681, 0, 0, 0, 0, 0, 'Unnamed House #681', 6, 72, 72000, 0, 1, 0, 112, 0, 0),
(682, 0, 0, 0, 0, 0, 'Unnamed House #682', 6, 36, 36000, 0, 1, 0, 70, 0, 0),
(683, 0, 0, 0, 0, 0, 'Unnamed House #683', 6, 166, 167000, 0, 1, 1, 252, 0, 0),
(684, 0, 0, 0, 0, 0, 'Unnamed House #684', 6, 46, 47000, 0, 1, 1, 84, 0, 0),
(685, 0, 0, 0, 0, 0, 'Unnamed House #685', 6, 96, 97000, 0, 1, 1, 161, 0, 0),
(686, 0, 0, 0, 0, 0, 'Unnamed House #686', 6, 15, 15000, 0, 1, 0, 35, 0, 0),
(687, 0, 0, 0, 0, 0, 'Unnamed House #687', 6, 13, 14000, 0, 1, 1, 35, 0, 0),
(688, 0, 0, 0, 0, 0, 'Unnamed House #688', 6, 13, 14000, 0, 1, 1, 35, 0, 0),
(689, 0, 0, 0, 0, 0, 'Unnamed House #689', 6, 9, 9000, 0, 1, 0, 25, 0, 0),
(690, 0, 0, 0, 0, 0, 'Unnamed House #690', 6, 9, 9000, 0, 1, 0, 25, 0, 0),
(691, 0, 0, 0, 0, 0, 'Unnamed House #691', 6, 9, 9000, 0, 1, 0, 25, 0, 0),
(692, 0, 0, 0, 0, 0, 'Unnamed House #692', 6, 24, 24000, 0, 1, 0, 48, 0, 0),
(693, 0, 0, 0, 0, 0, 'Unnamed House #693', 6, 14, 15000, 0, 1, 1, 36, 0, 0),
(694, 0, 0, 0, 0, 0, 'Unnamed House #694', 6, 10, 10000, 0, 1, 0, 28, 0, 0),
(695, 0, 0, 0, 0, 0, 'Unnamed House #695', 6, 20, 20000, 0, 1, 0, 42, 0, 0),
(696, 0, 0, 0, 0, 0, 'Unnamed House #696', 6, 86, 88000, 0, 1, 2, 136, 0, 0),
(697, 0, 0, 0, 0, 0, 'Unnamed House #697', 6, 28, 29000, 0, 1, 1, 56, 0, 0),
(698, 0, 0, 0, 0, 0, 'Unnamed House #698', 5, 64, 66000, 0, 1, 2, 132, 0, 0),
(699, 0, 0, 0, 0, 0, 'Unnamed House #699', 5, 25, 26000, 0, 1, 1, 55, 0, 0),
(700, 0, 0, 0, 0, 0, 'Unnamed House #700', 5, 27, 27000, 0, 1, 0, 55, 0, 0),
(701, 0, 0, 0, 0, 0, 'Unnamed House #701', 5, 68, 70000, 0, 1, 2, 110, 0, 0),
(702, 0, 0, 0, 0, 0, 'Unnamed House #702', 5, 12, 12000, 0, 1, 0, 30, 0, 0),
(703, 0, 0, 0, 0, 0, 'Unnamed House #703', 5, 7, 8000, 0, 1, 1, 20, 0, 0),
(704, 0, 0, 0, 0, 0, 'Unnamed House #704', 5, 10, 11000, 0, 1, 1, 24, 0, 0),
(705, 0, 0, 0, 0, 0, 'Unnamed House #705', 5, 10, 11000, 0, 1, 1, 18, 0, 0),
(706, 0, 0, 0, 0, 0, 'Unnamed House #706', 5, 12, 12000, 0, 1, 0, 15, 0, 0),
(707, 0, 0, 0, 0, 0, 'Unnamed House #707', 5, 14, 15000, 0, 1, 1, 30, 0, 0),
(708, 0, 0, 0, 0, 0, 'Unnamed House #708', 5, 9, 9000, 0, 1, 0, 12, 0, 0),
(709, 0, 0, 0, 0, 0, 'Unnamed House #709', 5, 9, 9000, 0, 1, 0, 16, 0, 0),
(710, 0, 0, 0, 0, 0, 'Unnamed House #710', 5, 7, 8000, 0, 1, 1, 12, 0, 0),
(711, 0, 0, 0, 0, 0, 'Unnamed House #711', 5, 12, 12000, 0, 1, 0, 20, 0, 0),
(712, 0, 0, 0, 0, 0, 'Unnamed House #712', 5, 8, 9000, 0, 1, 1, 18, 0, 0),
(713, 0, 0, 0, 0, 0, 'Unnamed House #713', 5, 10, 10000, 0, 1, 0, 18, 0, 0),
(714, 0, 0, 0, 0, 0, 'Unnamed House #714', 5, 12, 13000, 0, 1, 1, 24, 0, 0),
(715, 0, 0, 0, 0, 0, 'Unnamed House #715', 5, 12, 12000, 0, 1, 0, 21, 0, 0),
(716, 0, 0, 0, 0, 0, 'Unnamed House #716', 5, 18, 18000, 0, 1, 0, 34, 0, 0),
(717, 0, 0, 0, 0, 0, 'Unnamed House #717', 5, 21, 21000, 0, 1, 0, 40, 0, 0),
(718, 0, 0, 0, 0, 0, 'Unnamed House #718', 5, 13, 14000, 0, 1, 1, 30, 0, 0),
(719, 0, 0, 0, 0, 0, 'Unnamed House #719', 5, 15, 15000, 0, 1, 0, 35, 0, 0),
(720, 0, 0, 0, 0, 0, 'Unnamed House #720', 5, 106, 107000, 0, 1, 1, 168, 0, 0),
(721, 0, 0, 0, 0, 0, 'Unnamed House #721', 5, 104, 106000, 0, 1, 2, 176, 0, 0),
(722, 0, 0, 0, 0, 0, 'Unnamed House #722', 5, 106, 107000, 0, 1, 1, 176, 0, 0),
(723, 0, 0, 0, 0, 0, 'Unnamed House #723', 5, 24, 24000, 0, 1, 0, 50, 0, 0),
(724, 0, 0, 0, 0, 0, 'Unnamed House #724', 5, 88, 89000, 0, 1, 1, 166, 0, 0),
(725, 0, 0, 0, 0, 0, 'Unnamed House #725', 5, 68, 69000, 0, 1, 1, 126, 0, 0),
(726, 0, 0, 0, 0, 0, 'Unnamed House #726', 5, 32, 32000, 0, 1, 0, 66, 0, 0),
(727, 0, 0, 0, 0, 0, 'Unnamed House #727', 5, 78, 79000, 0, 1, 1, 140, 0, 0),
(728, 0, 0, 0, 0, 0, 'Unnamed House #728', 5, 32, 32000, 0, 1, 0, 80, 0, 0),
(729, 0, 0, 0, 0, 0, 'Unnamed House #729', 5, 19, 20000, 0, 1, 1, 45, 0, 0),
(730, 0, 0, 0, 0, 0, 'Unnamed House #730', 5, 40, 41000, 0, 1, 1, 90, 0, 0),
(731, 0, 0, 0, 0, 0, 'Unnamed House #731', 5, 14, 16000, 0, 1, 2, 29, 0, 0),
(732, 0, 0, 0, 0, 0, 'Unnamed House #732', 5, 78, 79000, 0, 1, 1, 164, 0, 0),
(733, 0, 0, 0, 0, 0, 'Unnamed House #733', 5, 22, 22000, 0, 1, 0, 42, 0, 0),
(734, 0, 0, 0, 0, 0, 'Unnamed House #734', 7, 20, 20000, 0, 0, 0, 42, 0, 0),
(735, 0, 0, 0, 0, 0, 'Unnamed House #735', 7, 25, 25000, 0, 0, 0, 49, 0, 0),
(736, 0, 0, 0, 0, 0, 'Unnamed House #736', 7, 28, 28000, 0, 0, 0, 54, 0, 0),
(737, 0, 0, 0, 0, 0, 'Unnamed House #737', 7, 27, 27000, 0, 0, 0, 55, 0, 0),
(738, 0, 0, 0, 0, 0, 'Unnamed House #738', 7, 36, 36000, 0, 0, 0, 66, 0, 0),
(739, 0, 0, 0, 0, 0, 'Unnamed House #739', 7, 15, 15000, 0, 0, 0, 35, 0, 0),
(740, 0, 0, 0, 0, 0, 'Unnamed House #740', 7, 10, 10000, 0, 0, 0, 28, 0, 0),
(741, 0, 0, 0, 0, 0, 'Unnamed House #741', 7, 12, 12000, 0, 0, 0, 30, 0, 0),
(742, 0, 0, 0, 0, 0, 'Unnamed House #742', 7, 45, 45000, 0, 0, 0, 77, 0, 0),
(743, 0, 0, 0, 0, 0, 'Unnamed House #743', 7, 24, 24000, 0, 0, 0, 50, 0, 0),
(744, 0, 0, 0, 0, 0, 'Unnamed House #744', 7, 14, 14000, 0, 0, 0, 36, 0, 0),
(745, 0, 0, 0, 0, 0, 'Unnamed House #745', 7, 12, 12000, 0, 0, 0, 32, 0, 0),
(746, 0, 0, 0, 0, 0, 'Unnamed House #746', 2, 19, 20000, 0, 1, 1, 28, 0, 0),
(747, 0, 0, 0, 0, 0, 'Unnamed House #747', 2, 19, 20000, 0, 1, 1, 29, 0, 0),
(748, 0, 0, 0, 0, 0, 'Unnamed House #748', 2, 21, 21000, 0, 1, 0, 29, 0, 0),
(749, 0, 0, 0, 0, 0, 'Unnamed House #749', 2, 21, 21000, 0, 1, 0, 29, 0, 0),
(750, 0, 0, 0, 0, 0, 'Unnamed House #750', 2, 47, 48000, 0, 1, 1, 81, 0, 0),
(751, 0, 0, 0, 0, 0, 'Unnamed House #751', 2, 47, 48000, 0, 1, 1, 81, 0, 0),
(752, 0, 0, 0, 0, 0, 'Unnamed House #752', 2, 21, 21000, 0, 1, 0, 30, 0, 0),
(753, 0, 0, 0, 0, 0, 'Unnamed House #753', 2, 21, 21000, 0, 1, 0, 34, 0, 0),
(754, 0, 0, 0, 0, 0, 'Unnamed House #754', 2, 21, 21000, 0, 1, 0, 29, 0, 0),
(755, 0, 0, 0, 0, 0, 'Unnamed House #755', 2, 19, 20000, 0, 1, 1, 30, 0, 0),
(756, 0, 0, 0, 0, 0, 'Unnamed House #756', 2, 19, 20000, 0, 1, 1, 28, 0, 0),
(757, 0, 0, 0, 0, 0, 'Unnamed House #757', 2, 21, 21000, 0, 1, 0, 28, 0, 0),
(758, 0, 0, 0, 0, 0, 'Unnamed House #758', 2, 36, 38000, 0, 1, 2, 70, 0, 0),
(759, 0, 0, 0, 0, 0, 'Unnamed House #759', 2, 36, 38000, 0, 1, 2, 70, 0, 0),
(760, 0, 0, 0, 0, 0, 'Unnamed House #760', 2, 16, 16000, 0, 1, 0, 36, 0, 0),
(761, 0, 0, 0, 0, 0, 'Unnamed House #761', 2, 13, 13000, 0, 0, 0, 34, 0, 0),
(762, 0, 0, 0, 0, 0, 'Unnamed House #762', 2, 40, 40000, 0, 1, 0, 84, 0, 0),
(763, 0, 0, 0, 0, 0, 'Unnamed House #763', 2, 68, 70000, 0, 1, 2, 110, 0, 0),
(764, 0, 0, 0, 0, 0, 'Unnamed House #764', 2, 28, 28000, 0, 1, 0, 54, 0, 0),
(765, 0, 0, 0, 0, 0, 'Unnamed House #765', 2, 21, 21000, 0, 1, 0, 34, 0, 0),
(766, 0, 0, 0, 0, 0, 'Unnamed House #766', 2, 21, 21000, 0, 1, 0, 35, 0, 0),
(767, 0, 0, 0, 0, 0, 'Unnamed House #767', 2, 19, 20000, 0, 1, 1, 29, 0, 0),
(768, 0, 0, 0, 0, 0, 'Unnamed House #768', 2, 21, 21000, 0, 1, 0, 33, 0, 0),
(769, 0, 0, 0, 0, 0, 'Unnamed House #769', 2, 63, 63000, 0, 0, 0, 105, 0, 0),
(770, 0, 0, 0, 0, 0, 'Unnamed House #770', 2, 63, 63000, 0, 1, 0, 109, 0, 0),
(771, 0, 0, 0, 0, 0, 'Unnamed House #771', 2, 63, 63000, 0, 1, 0, 112, 0, 0),
(772, 0, 0, 0, 0, 0, 'Unnamed House #772', 2, 61, 62000, 0, 1, 1, 113, 0, 0),
(773, 0, 0, 0, 0, 0, 'Unnamed House #773', 2, 63, 63000, 0, 1, 0, 117, 0, 0),
(774, 0, 0, 0, 0, 0, 'Unnamed House #774', 2, 63, 63000, 0, 1, 0, 123, 0, 0),
(775, 0, 0, 0, 0, 0, 'Unnamed House #775', 2, 19, 20000, 0, 1, 1, 35, 0, 0),
(776, 0, 0, 0, 0, 0, 'Unnamed House #776', 8, 36, 36000, 0, 0, 0, 72, 0, 0),
(777, 0, 0, 0, 0, 0, 'Unnamed House #777', 8, 36, 36000, 0, 0, 0, 80, 0, 0),
(778, 0, 0, 0, 0, 0, 'Unnamed House #778', 8, 15, 15000, 0, 0, 0, 35, 0, 0),
(779, 0, 0, 0, 0, 0, 'Unnamed House #779', 8, 9, 9000, 0, 0, 0, 25, 0, 0),
(780, 0, 0, 0, 0, 0, 'Unnamed House #780', 8, 50, 50000, 0, 0, 0, 93, 0, 0),
(781, 0, 0, 0, 0, 0, 'Unnamed House #781', 8, 50, 50000, 0, 0, 0, 95, 0, 0),
(782, 0, 0, 0, 0, 0, 'Unnamed House #782', 8, 54, 54000, 0, 0, 0, 105, 0, 0),
(783, 0, 0, 0, 0, 0, 'Unnamed House #783', 8, 25, 25000, 0, 0, 0, 49, 0, 0),
(784, 0, 0, 0, 0, 0, 'Unnamed House #784', 8, 54, 54000, 0, 0, 0, 102, 0, 0),
(785, 0, 0, 0, 0, 0, 'Unnamed House #785', 8, 24, 24000, 0, 0, 0, 50, 0, 0),
(786, 0, 0, 0, 0, 0, 'Unnamed House #786', 8, 12, 12000, 0, 0, 0, 30, 0, 0),
(787, 0, 0, 0, 0, 0, 'Unnamed House #787', 8, 12, 12000, 0, 0, 0, 30, 0, 0),
(788, 0, 0, 0, 0, 0, 'Unnamed House #788', 8, 50, 50000, 0, 0, 0, 88, 0, 0),
(789, 0, 0, 0, 0, 0, 'Unnamed House #789', 8, 25, 25000, 0, 0, 0, 49, 0, 0),
(790, 0, 0, 0, 0, 0, 'Unnamed House #790', 8, 50, 50000, 0, 0, 0, 87, 0, 0),
(791, 0, 0, 0, 0, 0, 'Unnamed House #791', 8, 60, 60000, 0, 0, 0, 119, 0, 0),
(792, 0, 0, 0, 0, 0, 'Unnamed House #792', 8, 12, 12000, 0, 0, 0, 30, 0, 0),
(793, 0, 0, 0, 0, 0, 'Unnamed House #793', 8, 36, 36000, 0, 0, 0, 77, 0, 0),
(794, 0, 0, 0, 0, 0, 'Unnamed House #794', 8, 25, 25000, 0, 0, 0, 49, 0, 0),
(797, 0, 5775, 0, 0, 1614543435, 'GHII #797', 1, 678, 681000, 0, 1, 3, 1370, 0, 0),
(798, 0, 0, 0, 0, 0, 'GHI #798', 2, 1191, 1197000, 0, 14, 6, 1956, 0, 0),
(799, 0, 5800, 0, 0, 1614651725, 'GHI #799', 5, 655, 659000, 0, 7, 4, 1275, 0, 0),
(803, 0, 0, 0, 0, 0, 'Unnamed House #803', 9, 9, 9000, 0, 1, 0, 25, 0, 0),
(804, 0, 0, 0, 0, 0, 'Unnamed House #804', 9, 9, 9000, 0, 1, 0, 25, 0, 0),
(805, 0, 0, 0, 0, 0, 'Unnamed House #805', 9, 9, 9000, 0, 1, 0, 25, 0, 0),
(806, 0, 0, 0, 0, 0, 'Unnamed House #806', 9, 9, 9000, 0, 1, 0, 25, 0, 0),
(807, 0, 0, 0, 0, 0, 'Unnamed House #807', 9, 9, 9000, 0, 1, 0, 25, 0, 0),
(808, 0, 0, 0, 0, 0, 'Unnamed House #808', 9, 9, 9000, 0, 1, 0, 25, 0, 0),
(809, 0, 0, 0, 0, 0, 'Unnamed House #809', 9, 9, 9000, 0, 1, 0, 25, 0, 0),
(810, 0, 0, 0, 0, 0, 'Unnamed House #810', 9, 9, 9000, 0, 1, 0, 25, 0, 0),
(811, 0, 0, 0, 0, 0, 'Unnamed House #811', 9, 9, 9000, 0, 1, 0, 25, 0, 0),
(812, 0, 0, 0, 0, 0, 'Unnamed House #812', 9, 9, 9000, 0, 1, 0, 25, 0, 0),
(813, 0, 0, 0, 0, 0, 'Unnamed House #813', 10, 9, 9000, 0, 1, 0, 12, 0, 0),
(814, 0, 0, 0, 0, 0, 'Unnamed House #814', 10, 9, 9000, 0, 2, 0, 16, 0, 0),
(815, 0, 0, 0, 0, 0, 'Unnamed House #815', 10, 9, 9000, 0, 2, 0, 16, 0, 0),
(816, 0, 5781, 0, 0, 1614598604, 'GHI #816', 1, 1107, 1119000, 0, 82, 12, 2710, 0, 0),
(817, 0, 0, 0, 0, 0, 'Unnamed House #817', 11, 30, 30000, 0, 5, 0, 70, 0, 0),
(818, 0, 0, 0, 0, 0, 'Unnamed House #818', 11, 60, 60000, 0, 7, 0, 112, 0, 0),
(819, 0, 0, 0, 0, 0, 'Unnamed House #819', 11, 70, 70000, 0, 13, 0, 126, 0, 0),
(820, 0, 0, 0, 0, 0, 'Unnamed House #820', 11, 64, 64000, 0, 7, 0, 120, 0, 0),
(821, 0, 0, 0, 0, 0, 'Unnamed House #821', 11, 64, 64000, 0, 7, 0, 120, 0, 0),
(822, 0, 0, 0, 0, 0, 'Unnamed House #822', 11, 96, 96000, 0, 7, 0, 168, 0, 0),
(823, 0, 0, 0, 0, 0, 'Unnamed House #823', 11, 9, 9000, 0, 4, 0, 25, 0, 0),
(824, 0, 0, 0, 0, 0, 'Unnamed House #824', 11, 9, 9000, 0, 4, 0, 25, 0, 0),
(825, 0, 0, 0, 0, 0, 'Unnamed House #825', 11, 9, 9000, 0, 5, 0, 25, 0, 0),
(826, 0, 0, 0, 0, 0, 'Unnamed House #826', 11, 9, 9000, 0, 5, 0, 25, 0, 0),
(827, 0, 0, 0, 0, 0, 'Unnamed House #827', 11, 9, 9000, 0, 5, 0, 25, 0, 0),
(828, 0, 0, 0, 0, 0, 'Unnamed House #828', 11, 9, 9000, 0, 5, 0, 25, 0, 0),
(829, 0, 0, 0, 0, 0, 'Unnamed House #829', 11, 9, 9000, 0, 4, 0, 25, 0, 0),
(830, 0, 0, 0, 0, 0, 'Unnamed House #830', 11, 9, 9000, 0, 4, 0, 25, 0, 0),
(831, 0, 0, 0, 0, 0, 'Unnamed House #831', 11, 9, 9000, 0, 5, 0, 25, 0, 0),
(832, 0, 0, 0, 0, 0, 'Unnamed House #832', 11, 9, 9000, 0, 3, 0, 25, 0, 0),
(833, 0, 0, 0, 0, 0, 'Unnamed House #833', 12, 9, 9000, 0, 1, 0, 25, 0, 0),
(834, 0, 0, 0, 0, 0, 'Unnamed House #834', 12, 9, 9000, 0, 1, 0, 25, 0, 0),
(835, 0, 0, 0, 0, 0, 'Unnamed House #835', 12, 9, 9000, 0, 1, 0, 25, 0, 0),
(836, 0, 0, 0, 0, 0, 'Unnamed House #836', 12, 9, 9000, 0, 1, 0, 25, 0, 0),
(837, 0, 0, 0, 0, 0, 'Unnamed House #837', 12, 33, 33000, 0, 1, 0, 65, 0, 0),
(838, 0, 0, 0, 0, 0, 'Unnamed House #838', 12, 36, 36000, 0, 1, 0, 70, 0, 0),
(839, 0, 0, 0, 0, 0, 'Unnamed House #839', 12, 9, 9000, 0, 1, 0, 25, 0, 0),
(840, 0, 0, 0, 0, 0, 'Unnamed House #840', 12, 9, 9000, 0, 1, 0, 25, 0, 0),
(841, 0, 0, 0, 0, 0, 'Unnamed House #841', 12, 9, 9000, 0, 1, 0, 25, 0, 0),
(842, 0, 0, 0, 0, 0, 'Unnamed House #842', 12, 9, 9000, 0, 1, 0, 25, 0, 0),
(843, 0, 0, 0, 0, 0, 'Unnamed House #843', 12, 9, 9000, 0, 1, 0, 25, 0, 0),
(844, 0, 0, 0, 0, 0, 'Unnamed House #844', 12, 9, 9000, 0, 1, 0, 25, 0, 0),
(845, 0, 0, 0, 0, 0, 'Unnamed House #845', 12, 9, 9000, 0, 1, 0, 25, 0, 0),
(846, 0, 0, 0, 0, 0, 'Unnamed House #846', 12, 9, 9000, 0, 1, 0, 25, 0, 0),
(847, 0, 0, 0, 0, 0, 'Unnamed House #847', 12, 36, 36000, 0, 1, 0, 66, 0, 0),
(848, 0, 0, 0, 0, 0, 'Unnamed House #848', 12, 36, 36000, 0, 1, 0, 66, 0, 0),
(849, 0, 5757, 0, 0, 1614527940, 'Unnamed House #849', 1, 305, 305000, 0, 0, 0, 432, 0, 0),
(850, 0, 0, 0, 0, 0, 'Unnamed House #850', 1, 15, 15000, 0, 2, 0, 32, 0, 0),
(851, 0, 0, 0, 0, 0, 'Unnamed House #851', 1, 15, 15000, 0, 3, 0, 29, 0, 0),
(852, 0, 0, 0, 0, 0, 'Unnamed House #852', 1, 9, 9000, 0, 4, 0, 24, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `house_auctions`
--

CREATE TABLE IF NOT EXISTS `house_auctions` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL,
  `bid` int(10) unsigned NOT NULL DEFAULT '0',
  `limit` int(10) unsigned NOT NULL DEFAULT '0',
  `endtime` bigint(20) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `house_id` (`house_id`,`world_id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `house_data`
--

CREATE TABLE IF NOT EXISTS `house_data` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `data` longblob NOT NULL,
  UNIQUE KEY `house_id` (`house_id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `house_lists`
--

CREATE TABLE IF NOT EXISTS `house_lists` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `listid` int(11) NOT NULL,
  `list` text NOT NULL,
  UNIQUE KEY `house_id` (`house_id`,`world_id`,`listid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `killers`
--

CREATE TABLE IF NOT EXISTS `killers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `death_id` int(11) NOT NULL,
  `final_hit` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `unjustified` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `war` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `death_id` (`death_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13602 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` int(11) DEFAULT NULL,
  `to` int(11) DEFAULT NULL,
  `title` varchar(120) DEFAULT NULL,
  `text` tinytext,
  `time` int(11) DEFAULT NULL,
  `delete_from` tinyint(1) DEFAULT NULL,
  `delete_to` tinyint(1) DEFAULT NULL,
  `unread` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `from` (`from`),
  KEY `to` (`to`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `news`
--

CREATE TABLE IF NOT EXISTS `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) DEFAULT '',
  `body` text,
  `time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Fazendo dump de dados para tabela `news`
--

INSERT INTO `news` (`id`, `title`, `body`, `time`) VALUES
(2, 'Lançamento 23/08/2020', '<p><img src="https://i.imgur.com/NRY0IlV.png"></p>', 1598113486),
(3, 'Promoção Inauguração', '<p><img src="https://i.imgur.com/2MGMlfF.png"></p>', 1598191919),
(4, 'Update 29/08/20', '<p><img src="https://i.imgur.com/8GpYQir.png"></p>', 1598738363),
(5, 'Update 07/09/20', '<p><img src="https://i.imgur.com/Imkkk0L.png"><br />Informa&ccedil;&otilde;es no Facebook / Discord.</p>', 1599503173),
(6, 'Sorteio', '<p><img src="https://i.imgur.com/aRp8nXh.png"><br />Acesse j&aacute; o nosso facebook para participar do nosso sorteio.</p>', 1599791842),
(7, 'Update 19/09/20', '<p><img src="https://i.imgur.com/0IAO3Jc.png" alt="" /></p>\n<p><strong>Para mais informa&ccedil;&otilde;es consulte o facebook ou discord!</strong></p>', 1600554973),
(8, 'Update 01/10/20', '<p><img src="https://i.imgur.com/L5wDXPI.png"><br />Mais informa&ccedil;&otilde;es no Discord e no Facebook.</p>', 1601576496),
(9, 'Update 19/10/20', '<p><img src="https://i.imgur.com/myQWcnD.png"><br />Mais informa&ccedil;&otilde;es no Facebook e Discord.</p>', 1603137917),
(10, 'Promoção Halloween!', '<p><img src="https://i.imgur.com/V0PUA9s.png"><br /><br /></p>', 1603417096),
(11, 'Update 08/11/20', '<p><img src="https://i.imgur.com/eod8z5J.png"><br />Mais informa&ccedil;&otilde;es no Facebook, Instagram ou Discord!</p>', 1604842602),
(12, 'Lançamento 06.02.2021', '<p><img src="https://i.imgur.com/LKtkIaG.png"><br />Mais informa&ccedil;&otilde;es nas nossas redes sociais.</p>', 1612100385),
(13, 'Passe de Batalha', '<p><img src="https://i.imgur.com/umKEmBn.jpg"><br />Para mais informa&ccedil;&otilde;es sobre o Passe de Batalha, acesse a p&aacute;gina '' Passe de Batalha '' ao lado esquerdo do site.</p>', 1612489939),
(14, 'Obtenha o Passe', '<p><img src="https://i.imgur.com/usxyPXM.png"><br />Para mais informa&ccedil;&otilde;es acesse o Shop.</p>', 1612490029),
(15, 'Abertura!! 06.02', '<p><img src="https://i.imgur.com/Gn6xomm.png"><br />Mais informa&ccedil;&otilde;es no Discord ou Facebook.</p>', 1612612224),
(16, 'Update 28/02/21', '<p><img src="https://i.imgur.com/IZFvXmX.png"><br />Para mais informa&ccedil;&otilde;es acesse nosso Discord ou Facebook!</p>', 1614525125);

-- --------------------------------------------------------

--
-- Estrutura para tabela `newsticker`
--

CREATE TABLE IF NOT EXISTS `newsticker` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date` int(11) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagsegurotransacoes`
--

CREATE TABLE IF NOT EXISTS `pagsegurotransacoes` (
  `TransacaoID` varchar(36) NOT NULL,
  `VendedorEmail` varchar(200) NOT NULL,
  `Referencia` varchar(200) DEFAULT NULL,
  `TipoFrete` char(2) DEFAULT NULL,
  `ValorFrete` decimal(10,2) DEFAULT NULL,
  `Extras` decimal(10,2) DEFAULT NULL,
  `Anotacao` text,
  `TipoPagamento` varchar(50) NOT NULL,
  `StatusTransacao` varchar(50) NOT NULL,
  `CliNome` varchar(200) NOT NULL,
  `CliEmail` varchar(200) NOT NULL,
  `CliEndereco` varchar(200) NOT NULL,
  `CliNumero` varchar(10) DEFAULT NULL,
  `CliComplemento` varchar(100) DEFAULT NULL,
  `CliBairro` varchar(100) NOT NULL,
  `CliCidade` varchar(100) NOT NULL,
  `CliEstado` char(2) NOT NULL,
  `CliCEP` varchar(9) NOT NULL,
  `CliTelefone` varchar(14) DEFAULT NULL,
  `NumItens` int(11) NOT NULL,
  `Data` datetime NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `TransacaoID` (`TransacaoID`,`StatusTransacao`),
  KEY `Referencia` (`Referencia`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `players`
--

CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '1',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `vocation` int(11) NOT NULL DEFAULT '0',
  `health` int(11) NOT NULL DEFAULT '150',
  `healthmax` int(11) NOT NULL DEFAULT '150',
  `experience` bigint(20) NOT NULL DEFAULT '0',
  `lookbody` int(11) NOT NULL DEFAULT '0',
  `lookfeet` int(11) NOT NULL DEFAULT '0',
  `lookhead` int(11) NOT NULL DEFAULT '0',
  `looklegs` int(11) NOT NULL DEFAULT '0',
  `looktype` int(11) NOT NULL DEFAULT '136',
  `lookaddons` int(11) NOT NULL DEFAULT '0',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `mana` int(11) NOT NULL DEFAULT '0',
  `manamax` int(11) NOT NULL DEFAULT '0',
  `manaspent` int(11) NOT NULL DEFAULT '0',
  `soul` int(10) unsigned NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `reset_temple` tinyint(4) NOT NULL DEFAULT '0',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `conditions` blob NOT NULL,
  `cap` int(11) NOT NULL DEFAULT '0',
  `sex` int(11) NOT NULL DEFAULT '0',
  `lastlogin` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lastip` int(10) unsigned NOT NULL DEFAULT '0',
  `save` tinyint(1) NOT NULL DEFAULT '1',
  `skull` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `skulltime` int(11) NOT NULL DEFAULT '0',
  `rank_id` int(11) NOT NULL DEFAULT '0',
  `guildnick` varchar(255) NOT NULL DEFAULT '',
  `lastlogout` bigint(20) unsigned NOT NULL DEFAULT '0',
  `blessings` tinyint(2) NOT NULL DEFAULT '0',
  `pvp_blessing` tinyint(1) NOT NULL DEFAULT '0',
  `balance` bigint(20) NOT NULL DEFAULT '0',
  `stamina` bigint(20) NOT NULL DEFAULT '151200000' COMMENT 'stored in miliseconds',
  `direction` int(11) NOT NULL DEFAULT '2',
  `loss_experience` int(11) NOT NULL DEFAULT '100',
  `loss_mana` int(11) NOT NULL DEFAULT '100',
  `loss_skills` int(11) NOT NULL DEFAULT '100',
  `loss_containers` int(11) NOT NULL DEFAULT '100',
  `loss_items` int(11) NOT NULL DEFAULT '100',
  `premend` int(11) NOT NULL DEFAULT '0' COMMENT 'NOT IN USE BY THE SERVER',
  `online` tinyint(1) NOT NULL DEFAULT '0',
  `marriage` int(10) unsigned NOT NULL DEFAULT '0',
  `promotion` int(11) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '',
  `old_name` varchar(255) DEFAULT NULL,
  `hide_char` int(11) DEFAULT NULL,
  `worldtransfer` int(11) DEFAULT NULL,
  `created` int(16) DEFAULT NULL,
  `nick_verify` int(11) DEFAULT NULL,
  `comment` text,
  `offlinetraining_time` smallint(5) unsigned NOT NULL DEFAULT '43200',
  `offlinetraining_skill` int(11) NOT NULL DEFAULT '-1',
  `broadcasting` tinyint(4) NOT NULL DEFAULT '0',
  `viewers` int(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`deleted`),
  KEY `account_id` (`account_id`),
  KEY `group_id` (`group_id`),
  KEY `online` (`online`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6140 ;

--
-- Fazendo dump de dados para tabela `players`
--

INSERT INTO `players` (`id`, `name`, `world_id`, `group_id`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `reset_temple`, `posx`, `posy`, `posz`, `conditions`, `cap`, `sex`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `rank_id`, `guildnick`, `lastlogout`, `blessings`, `pvp_blessing`, `balance`, `stamina`, `direction`, `loss_experience`, `loss_mana`, `loss_skills`, `loss_containers`, `loss_items`, `premend`, `online`, `marriage`, `promotion`, `deleted`, `description`, `old_name`, `hide_char`, `worldtransfer`, `created`, `nick_verify`, `comment`, `offlinetraining_time`, `offlinetraining_skill`, `broadcasting`, `viewers`) VALUES
(1, 'Account Manager', 0, 1, 1, 1, 0, 10, 10, 0, 0, 0, 0, 0, 110, 0, 0, 10, 10, 0, 0, 0, 0, 1028, 848, 5, '', 400, 0, 1507568709, 49671576, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, 0, NULL, NULL, NULL, NULL, 43200, -1, 0, 0),
(2, 'Rook Sample', 0, 1, 1, 1, 0, 10, 10, 0, 0, 0, 0, 0, 110, 0, 0, 10, 10, 0, 0, 0, 0, 1028, 848, 5, '', 400, 0, 1614440878, 943613059, 0, 0, 0, 0, '', 0, 0, 0, 0, 201660000, 0, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 'This player has no comment at this moment.', 43200, -1, 0, 0),
(9, 'Kakashi Sample', 0, 1, 1, 1, 7, 10, 10, 0, 0, 0, 0, 0, 9, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440976, 943613059, 1, 4, 0, 0, '', 1614440977, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1423872404, NULL, NULL, 43200, -1, 0, 0),
(10, 'Kankuro Sample', 0, 1, 1, 1, 8, 10, 10, 0, 0, 0, 0, 0, 309, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440973, 943613059, 1, 4, 0, 0, '', 1614440975, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1423872660, NULL, NULL, 43200, -1, 0, 0),
(11, 'Gaara Sample', 0, 1, 1, 1, 9, 10, 10, 0, 0, 0, 0, 0, 52, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440990, 943613059, 1, 4, 0, 0, '', 1614440991, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1423875330, NULL, NULL, 43200, -1, 0, 0),
(12, 'Shikamaru Sample', 0, 1, 1, 1, 5, 10, 10, 0, 0, 0, 0, 0, 340, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440930, 943613059, 1, 4, 0, 0, '', 1614440932, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1423876062, NULL, NULL, 43200, -1, 0, 0),
(13, 'Shino Sample', 0, 1, 1, 1, 14, 10, 10, 0, 0, 0, 0, 0, 209, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440926, 943613059, 1, 4, 0, 0, '', 1614440928, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1423876567, NULL, NULL, 43200, -1, 0, 0),
(16, 'Temari Sample', 0, 1, 1, 1, 40, 10, 10, 0, 0, 0, 0, 0, 378, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440922, 943613059, 1, 4, 0, 0, '', 1614440925, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1423877830, NULL, NULL, 43200, -1, 0, 0),
(19, 'Tenten Sample', 0, 1, 1, 1, 15, 10, 10, 0, 0, 0, 0, 0, 383, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440917, 943613059, 1, 4, 0, 0, '', 1614440920, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1423878637, NULL, NULL, 43200, -1, 0, 0),
(20, 'Chouji Sample', 0, 1, 1, 1, 18, 10, 10, 0, 0, 0, 0, 0, 214, 0, 0, 10, 10, 0, 0, 1, 0, 1022, 859, 7, '', 400, 1, 1614440996, 943613059, 1, 4, 0, 0, '', 1614440998, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1423879073, NULL, NULL, 43200, -1, 0, 0),
(87, 'Hinata Sample', 0, 1, 1, 1, 22, 10, 10, 0, 0, 0, 0, 0, 295, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440986, 943613059, 1, 4, 0, 0, '', 1614440986, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1423934928, NULL, NULL, 43200, -1, 0, 0),
(127, 'Jiraya Sample', 0, 1, 1, 1, 20, 10, 10, 0, 0, 0, 0, 0, 237, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440978, 943613059, 1, 4, 0, 0, '', 1614440980, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1423953783, NULL, NULL, 43200, -1, 0, 0),
(669, 'Kisame Sample', 0, 1, 1, 1, 16, 10, 10, 0, 0, 0, 0, 0, 201, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440967, 943613059, 1, 4, 0, 0, '', 1614440969, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1425133240, NULL, NULL, 43200, -1, 0, 0),
(670, 'Itachi Sample', 0, 1, 1, 1, 6, 10, 10, 0, 0, 0, 0, 0, 96, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440981, 943613059, 1, 4, 0, 0, '', 1614440982, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1425133431, NULL, NULL, 43200, -1, 0, 0),
(672, 'Killer Bee Sample', 0, 1, 1, 1, 12, 10, 10, 0, 0, 0, 0, 0, 372, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440970, 943613059, 1, 4, 0, 0, '', 1614440972, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1425133508, NULL, NULL, 43200, -1, 0, 0),
(676, 'Hashirama Sample', 0, 1, 1, 1, 19, 10, 10, 0, 0, 0, 0, 0, 278, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440987, 943613059, 1, 4, 0, 0, '', 1614440989, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1425134603, NULL, NULL, 43200, -1, 0, 0),
(677, 'Konan Sample', 0, 1, 1, 1, 23, 10, 10, 0, 0, 0, 0, 0, 21, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614524932, 943613059, 1, 4, 0, 0, '', 1614524937, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1425135270, NULL, NULL, 43200, -1, 0, 0),
(1131, 'Anbu Sample', 0, 1, 1, 1, 17, 10, 10, 0, 0, 0, 0, 0, 259, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440999, 943613059, 1, 4, 0, 0, '', 1614441001, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1425835503, NULL, NULL, 43200, -1, 0, 0),
(1132, 'Nagato Sample', 0, 1, 1, 1, 21, 10, 10, 0, 0, 0, 0, 0, 160, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440955, 943613059, 1, 4, 0, 0, '', 1614440957, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1425835517, NULL, NULL, 43200, -1, 0, 0),
(1194, 'Madara Sample', 0, 1, 1, 1, 24, 10, 10, 0, 0, 0, 0, 0, 39, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440961, 943613059, 1, 4, 0, 0, '', 1614440963, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1425936336, NULL, NULL, 43200, -1, 0, 0),
(1316, 'Sai Sample', 0, 1, 1, 1, 25, 10, 10, 0, 0, 0, 0, 0, 36, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440939, 943613059, 1, 4, 0, 0, '', 1614440941, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1506806987, NULL, NULL, 43200, -1, 0, 0),
(1317, 'Obito Sample', 0, 1, 1, 1, 27, 10, 10, 0, 0, 0, 0, 0, 128, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440945, 943613059, 1, 4, 0, 0, '', 1614440947, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1506806996, NULL, NULL, 43200, -1, 0, 0),
(1319, 'Minato Sample', 0, 1, 1, 1, 26, 10, 10, 0, 0, 0, 0, 0, 82, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440958, 943613059, 1, 4, 0, 0, '', 1614440960, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1506807014, NULL, NULL, 43200, -1, 0, 0),
(1320, 'Deidara Sample', 0, 1, 1, 1, 28, 10, 10, 0, 0, 0, 0, 0, 152, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440993, 943613059, 1, 4, 0, 0, '', 1614440994, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1506807052, NULL, NULL, 43200, -1, 0, 0),
(1322, 'Naruto Sample', 0, 1, 1, 1, 1, 10, 10, 0, 0, 0, 0, 0, 71, 0, 0, 10, 10, 0, 0, 1, 0, 1018, 841, 7, 0x010010000002ffffffff032c0100001a000000001b07000000fe, 400, 1, 1614524058, 943613059, 1, 4, 0, 0, '', 1614524061, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1506809680, NULL, NULL, 43200, -1, 0, 0),
(1323, 'Sakura Sample', 0, 1, 1, 1, 4, 10, 10, 0, 0, 0, 0, 0, 169, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440937, 943613059, 1, 4, 0, 0, '', 1614440938, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1506809689, NULL, NULL, 43200, -1, 0, 0),
(1324, 'Rock Lee Sample', 0, 1, 1, 1, 3, 10, 10, 0, 0, 0, 0, 0, 80, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440942, 943613059, 1, 4, 0, 0, '', 1614440944, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1506809698, NULL, NULL, 43200, -1, 0, 0),
(1325, 'Sasuke Sample', 0, 1, 1, 1, 2, 10, 10, 0, 0, 0, 0, 0, 2, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440934, 943613059, 1, 4, 0, 0, '', 1614440935, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1506809706, NULL, NULL, 43200, -1, 0, 0),
(3728, 'Orochimaru Sample', 0, 1, 1, 1, 31, 10, 10, 0, 0, 0, 0, 0, 420, 0, 0, 10, 10, 0, 0, 0, 0, 1028, 848, 5, '', 400, 1, 1614440869, 943613059, 1, 4, 0, 0, '', 1614440871, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', '', 0, NULL, 0, 0, '', 43200, -1, 0, 0),
(4695, 'Neji Sample', 0, 1, 1, 1, 33, 10, 10, 0, 0, 0, 0, 0, 315, 0, 0, 10, 10, 0, 0, 1, 0, 1028, 848, 5, '', 400, 1, 1614440952, 943613059, 1, 4, 0, 0, '', 1614440954, 0, 0, 0, 151200000, 0, 169, 100, 100, 100, 100, 0, 0, 0, 0, 0, '', NULL, NULL, NULL, 1423876062, NULL, NULL, 43200, -1, 0, 0);

--
-- Gatilhos `players`
--
DROP TRIGGER IF EXISTS `oncreate_players`;
DELIMITER //
CREATE TRIGGER `oncreate_players` AFTER INSERT ON `players`
 FOR EACH ROW BEGIN
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 0, 10);
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 1, 10);
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 2, 10);
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 3, 10);
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 4, 10);
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 5, 10);
	INSERT INTO `player_skills` (`player_id`, `skillid`, `value`) VALUES (NEW.`id`, 6, 10);
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `ondelete_players`;
DELIMITER //
CREATE TRIGGER `ondelete_players` BEFORE DELETE ON `players`
 FOR EACH ROW BEGIN
	DELETE FROM `bans` WHERE `type` IN (2, 5) AND `value` = OLD.`id`;
	UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_deaths`
--

CREATE TABLE IF NOT EXISTS `player_deaths` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `date` bigint(20) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10153 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_depotitems`
--

CREATE TABLE IF NOT EXISTS `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range, eg. 0-100 is reserved for depot lockers and all above 100 will be normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_items`
--

CREATE TABLE IF NOT EXISTS `player_items` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `pid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`sid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `player_items`
--

INSERT INTO `player_items` (`player_id`, `pid`, `sid`, `itemtype`, `count`, `attributes`) VALUES
(9, 1, 101, 2657, 1, ''),
(9, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(9, 3, 103, 1999, 1, ''),
(9, 4, 104, 2665, 1, ''),
(9, 6, 105, 2545, 100, 0x0f64),
(9, 7, 106, 2478, 1, ''),
(9, 8, 107, 2643, 1, ''),
(9, 103, 108, 2321, 1, ''),
(9, 103, 109, 2145, 5, 0x0f05),
(9, 103, 110, 2379, 1, ''),
(10, 1, 101, 2657, 1, ''),
(10, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(10, 3, 103, 1999, 1, ''),
(10, 4, 104, 2665, 1, ''),
(10, 6, 105, 2545, 100, 0x0f64),
(10, 7, 106, 2478, 1, ''),
(10, 8, 107, 2643, 1, ''),
(10, 103, 108, 2321, 1, ''),
(10, 103, 109, 2145, 5, 0x0f05),
(10, 103, 110, 2379, 1, ''),
(11, 1, 101, 2657, 1, ''),
(11, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(11, 3, 103, 1999, 1, ''),
(11, 4, 104, 2665, 1, ''),
(11, 6, 105, 2545, 100, 0x0f64),
(11, 7, 106, 2478, 1, ''),
(11, 8, 107, 2643, 1, ''),
(11, 103, 108, 2321, 1, ''),
(11, 103, 109, 2379, 1, ''),
(11, 103, 110, 2145, 5, 0x0f05),
(12, 1, 101, 2657, 1, ''),
(12, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(12, 3, 103, 1999, 1, ''),
(12, 4, 104, 2665, 1, ''),
(12, 6, 105, 2545, 100, 0x0f64),
(12, 7, 106, 2478, 1, ''),
(12, 8, 107, 2643, 1, ''),
(12, 103, 108, 2321, 1, ''),
(12, 103, 109, 2379, 1, ''),
(12, 103, 110, 2145, 5, 0x0f05),
(13, 1, 101, 2657, 1, ''),
(13, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(13, 3, 103, 1999, 1, ''),
(13, 4, 104, 2665, 1, ''),
(13, 6, 105, 2545, 100, 0x0f64),
(13, 7, 106, 2478, 1, ''),
(13, 8, 107, 2643, 1, ''),
(13, 103, 108, 2321, 1, ''),
(13, 103, 109, 2145, 5, 0x0f05),
(13, 103, 110, 2379, 1, ''),
(16, 1, 101, 2657, 1, ''),
(16, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(16, 3, 103, 1999, 1, ''),
(16, 4, 104, 2665, 1, ''),
(16, 6, 105, 2545, 100, 0x0f64),
(16, 7, 106, 2478, 1, ''),
(16, 8, 107, 2643, 1, ''),
(16, 103, 108, 2321, 1, ''),
(16, 103, 109, 2379, 1, ''),
(16, 103, 110, 2145, 5, 0x0f05),
(19, 1, 101, 2657, 1, ''),
(19, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(19, 3, 103, 1999, 1, ''),
(19, 4, 104, 2665, 1, ''),
(19, 6, 105, 2545, 100, 0x0f64),
(19, 7, 106, 2478, 1, ''),
(19, 8, 107, 2643, 1, ''),
(19, 103, 108, 2321, 1, ''),
(19, 103, 109, 2379, 1, ''),
(19, 103, 110, 2145, 5, 0x0f05),
(20, 1, 101, 2657, 1, ''),
(20, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(20, 3, 103, 1999, 1, ''),
(20, 4, 104, 2665, 1, ''),
(20, 6, 105, 2321, 1, ''),
(20, 7, 106, 2478, 1, ''),
(20, 8, 107, 2643, 1, ''),
(20, 103, 108, 2545, 100, 0x0f64),
(20, 103, 109, 2379, 1, ''),
(20, 103, 110, 2145, 5, 0x0f05),
(87, 1, 101, 2657, 1, ''),
(87, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(87, 3, 103, 1999, 1, ''),
(87, 4, 104, 2665, 1, ''),
(87, 6, 105, 2321, 1, ''),
(87, 7, 106, 2478, 1, ''),
(87, 8, 107, 2643, 1, ''),
(87, 103, 108, 2145, 5, 0x0f05),
(87, 103, 109, 2379, 1, ''),
(87, 103, 110, 2545, 100, 0x0f64),
(127, 1, 101, 2657, 1, ''),
(127, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(127, 3, 103, 1999, 1, ''),
(127, 4, 104, 2665, 1, ''),
(127, 6, 105, 2321, 1, ''),
(127, 7, 106, 2478, 1, ''),
(127, 8, 107, 2643, 1, ''),
(127, 103, 108, 2145, 5, 0x0f05),
(127, 103, 109, 2379, 1, ''),
(127, 103, 110, 2545, 100, 0x0f64),
(669, 1, 101, 2657, 1, ''),
(669, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(669, 3, 103, 1999, 1, ''),
(669, 4, 104, 2665, 1, ''),
(669, 6, 105, 2379, 1, ''),
(669, 7, 106, 2478, 1, ''),
(669, 8, 107, 2643, 1, ''),
(669, 103, 108, 2321, 1, ''),
(669, 103, 109, 2145, 5, 0x0f05),
(669, 103, 110, 2545, 100, 0x0f64),
(670, 1, 101, 2657, 1, ''),
(670, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(670, 3, 103, 1999, 1, ''),
(670, 4, 104, 2665, 1, ''),
(670, 6, 105, 2379, 1, ''),
(670, 7, 106, 2478, 1, ''),
(670, 8, 107, 2643, 1, ''),
(670, 103, 108, 2321, 1, ''),
(670, 103, 109, 2545, 100, 0x0f64),
(670, 103, 110, 2145, 5, 0x0f05),
(672, 1, 101, 2657, 1, ''),
(672, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(672, 3, 103, 1999, 1, ''),
(672, 4, 104, 2665, 1, ''),
(672, 6, 105, 2379, 1, ''),
(672, 7, 106, 2478, 1, ''),
(672, 8, 107, 2643, 1, ''),
(672, 103, 108, 2321, 1, ''),
(672, 103, 109, 2545, 100, 0x0f64),
(672, 103, 110, 2145, 5, 0x0f05),
(676, 1, 101, 2657, 1, ''),
(676, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(676, 3, 103, 1999, 1, ''),
(676, 4, 104, 2665, 1, ''),
(676, 6, 105, 2545, 100, 0x0f64),
(676, 7, 106, 2478, 1, ''),
(676, 8, 107, 2643, 1, ''),
(676, 103, 108, 2321, 1, ''),
(676, 103, 109, 2379, 1, ''),
(676, 103, 110, 2145, 5, 0x0f05),
(677, 1, 101, 2657, 1, ''),
(677, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(677, 3, 103, 1999, 1, ''),
(677, 4, 104, 2665, 1, ''),
(677, 6, 105, 2545, 100, 0x0f64),
(677, 7, 106, 2478, 1, ''),
(677, 8, 107, 2643, 1, ''),
(677, 103, 108, 2321, 1, ''),
(677, 103, 109, 2379, 1, ''),
(677, 103, 110, 2145, 5, 0x0f05),
(1131, 1, 101, 2657, 1, ''),
(1131, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(1131, 3, 103, 1999, 1, ''),
(1131, 4, 104, 2665, 1, ''),
(1131, 6, 105, 2545, 100, 0x0f64),
(1131, 7, 106, 2478, 1, ''),
(1131, 8, 107, 2643, 1, ''),
(1131, 103, 108, 2321, 1, ''),
(1131, 103, 109, 2379, 1, ''),
(1131, 103, 110, 2145, 5, 0x0f05),
(1132, 1, 101, 2657, 1, ''),
(1132, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(1132, 3, 103, 1999, 1, ''),
(1132, 4, 104, 2665, 1, ''),
(1132, 6, 105, 2545, 100, 0x0f64),
(1132, 7, 106, 2478, 1, ''),
(1132, 8, 107, 2643, 1, ''),
(1132, 103, 108, 2321, 1, ''),
(1132, 103, 109, 2379, 1, ''),
(1132, 103, 110, 2145, 5, 0x0f05),
(1194, 1, 101, 2657, 1, ''),
(1194, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(1194, 3, 103, 1999, 1, ''),
(1194, 4, 104, 2665, 1, ''),
(1194, 6, 105, 2379, 1, ''),
(1194, 7, 106, 2478, 1, ''),
(1194, 8, 107, 2643, 1, ''),
(1194, 103, 108, 2321, 1, ''),
(1194, 103, 109, 2145, 5, 0x0f05),
(1194, 103, 110, 2545, 100, 0x0f64),
(1316, 1, 101, 2657, 1, ''),
(1316, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(1316, 3, 103, 1999, 1, ''),
(1316, 4, 104, 2665, 1, ''),
(1316, 6, 105, 2545, 100, 0x0f64),
(1316, 7, 106, 2478, 1, ''),
(1316, 8, 107, 2643, 1, ''),
(1316, 103, 108, 2321, 1, ''),
(1316, 103, 109, 2145, 5, 0x0f05),
(1316, 103, 110, 2379, 1, ''),
(1317, 1, 101, 2657, 1, ''),
(1317, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(1317, 3, 103, 1999, 1, ''),
(1317, 4, 104, 2665, 1, ''),
(1317, 6, 105, 2379, 1, ''),
(1317, 7, 106, 2478, 1, ''),
(1317, 8, 107, 2643, 1, ''),
(1317, 103, 108, 2321, 1, ''),
(1317, 103, 109, 2545, 100, 0x0f64),
(1317, 103, 110, 2145, 5, 0x0f05),
(1319, 1, 101, 2657, 1, ''),
(1319, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(1319, 3, 103, 1999, 1, ''),
(1319, 4, 104, 2665, 1, ''),
(1319, 6, 105, 2379, 1, ''),
(1319, 7, 106, 2478, 1, ''),
(1319, 8, 107, 2643, 1, ''),
(1319, 103, 108, 2321, 1, ''),
(1319, 103, 109, 2545, 100, 0x0f64),
(1319, 103, 110, 2145, 5, 0x0f05),
(1320, 1, 101, 2657, 1, ''),
(1320, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(1320, 3, 103, 1999, 1, ''),
(1320, 4, 104, 2665, 1, ''),
(1320, 6, 105, 2545, 100, 0x0f64),
(1320, 7, 106, 2478, 1, ''),
(1320, 8, 107, 2643, 1, ''),
(1320, 103, 108, 2321, 1, ''),
(1320, 103, 109, 2379, 1, ''),
(1320, 103, 110, 2145, 5, 0x0f05),
(1322, 1, 101, 2657, 1, ''),
(1322, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(1322, 3, 103, 1999, 1, ''),
(1322, 4, 104, 2665, 1, ''),
(1322, 6, 105, 2321, 1, ''),
(1322, 7, 106, 2478, 1, ''),
(1322, 8, 107, 2643, 1, ''),
(1322, 103, 108, 2379, 1, ''),
(1322, 103, 109, 2545, 100, 0x0f64),
(1322, 103, 110, 2145, 5, 0x0f05),
(1323, 1, 101, 2657, 1, ''),
(1323, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(1323, 3, 103, 1999, 1, ''),
(1323, 4, 104, 2665, 1, ''),
(1323, 6, 105, 2321, 1, ''),
(1323, 7, 106, 2478, 1, ''),
(1323, 8, 107, 2643, 1, ''),
(1323, 103, 108, 2379, 1, ''),
(1323, 103, 109, 2545, 100, 0x0f64),
(1323, 103, 110, 2145, 5, 0x0f05),
(1324, 1, 101, 2657, 1, ''),
(1324, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(1324, 3, 103, 1999, 1, ''),
(1324, 4, 104, 2665, 1, ''),
(1324, 6, 105, 2321, 1, ''),
(1324, 7, 106, 2478, 1, ''),
(1324, 8, 107, 2643, 1, ''),
(1324, 103, 108, 2545, 100, 0x0f64),
(1324, 103, 109, 2379, 1, ''),
(1324, 103, 110, 2145, 5, 0x0f05),
(1325, 1, 101, 2657, 1, ''),
(1325, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(1325, 3, 103, 1999, 1, ''),
(1325, 4, 104, 2665, 1, ''),
(1325, 6, 105, 2379, 1, ''),
(1325, 7, 106, 2478, 1, ''),
(1325, 8, 107, 2643, 1, ''),
(1325, 103, 108, 2321, 1, ''),
(1325, 103, 109, 2545, 100, 0x0f64),
(1325, 103, 110, 2145, 5, 0x0f05),
(3728, 1, 101, 2657, 1, ''),
(3728, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(3728, 3, 103, 1999, 1, ''),
(3728, 4, 104, 2665, 1, ''),
(3728, 6, 105, 2545, 100, 0x0f64),
(3728, 7, 106, 2478, 1, ''),
(3728, 8, 107, 2643, 1, ''),
(3728, 103, 108, 2321, 1, ''),
(3728, 103, 109, 2145, 5, 0x0f05),
(3728, 103, 110, 2379, 1, ''),
(4695, 1, 101, 2657, 1, ''),
(4695, 2, 102, 2138, 1, 0x8001000700636861726765730201000000),
(4695, 3, 103, 1999, 1, ''),
(4695, 4, 104, 2665, 1, ''),
(4695, 6, 105, 2321, 1, ''),
(4695, 7, 106, 2478, 1, ''),
(4695, 8, 107, 2643, 1, ''),
(4695, 103, 108, 2379, 1, ''),
(4695, 103, 109, 2545, 100, 0x0f64),
(4695, 103, 110, 2145, 5, 0x0f05);

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_killers`
--

CREATE TABLE IF NOT EXISTS `player_killers` (
  `kill_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  KEY `kill_id` (`kill_id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_namelocks`
--

CREATE TABLE IF NOT EXISTS `player_namelocks` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `new_name` varchar(255) NOT NULL,
  `date` bigint(20) NOT NULL DEFAULT '0',
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_skills`
--

CREATE TABLE IF NOT EXISTS `player_skills` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `skillid` tinyint(2) NOT NULL DEFAULT '0',
  `value` int(10) unsigned NOT NULL DEFAULT '0',
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `player_id_2` (`player_id`,`skillid`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `player_skills`
--

INSERT INTO `player_skills` (`player_id`, `skillid`, `value`, `count`) VALUES
(2, 0, 10, 0),
(2, 1, 10, 0),
(2, 2, 10, 0),
(2, 3, 10, 0),
(2, 4, 10, 0),
(2, 5, 10, 0),
(2, 6, 10, 0),
(9, 0, 10, 0),
(9, 1, 10, 0),
(9, 2, 10, 0),
(9, 3, 10, 0),
(9, 4, 10, 0),
(9, 5, 10, 0),
(9, 6, 10, 0),
(10, 0, 10, 0),
(10, 1, 10, 0),
(10, 2, 10, 0),
(10, 3, 10, 0),
(10, 4, 10, 0),
(10, 5, 10, 0),
(10, 6, 10, 0),
(11, 0, 10, 0),
(11, 1, 10, 0),
(11, 2, 10, 0),
(11, 3, 10, 0),
(11, 4, 10, 0),
(11, 5, 10, 0),
(11, 6, 10, 0),
(12, 0, 10, 0),
(12, 1, 10, 0),
(12, 2, 10, 0),
(12, 3, 10, 0),
(12, 4, 10, 0),
(12, 5, 10, 0),
(12, 6, 10, 0),
(13, 0, 10, 0),
(13, 1, 10, 0),
(13, 2, 10, 0),
(13, 3, 10, 0),
(13, 4, 10, 0),
(13, 5, 10, 0),
(13, 6, 10, 0),
(16, 0, 10, 0),
(16, 1, 10, 0),
(16, 2, 10, 0),
(16, 3, 10, 0),
(16, 4, 10, 0),
(16, 5, 10, 0),
(16, 6, 10, 0),
(19, 0, 10, 0),
(19, 1, 10, 0),
(19, 2, 10, 0),
(19, 3, 10, 0),
(19, 4, 10, 0),
(19, 5, 10, 0),
(19, 6, 10, 0),
(20, 0, 10, 0),
(20, 1, 10, 0),
(20, 2, 10, 0),
(20, 3, 10, 0),
(20, 4, 10, 0),
(20, 5, 10, 0),
(20, 6, 10, 0),
(87, 0, 10, 0),
(87, 1, 10, 0),
(87, 2, 10, 0),
(87, 3, 10, 0),
(87, 4, 10, 0),
(87, 5, 10, 0),
(87, 6, 10, 0),
(127, 0, 10, 0),
(127, 1, 10, 0),
(127, 2, 10, 0),
(127, 3, 10, 0),
(127, 4, 10, 0),
(127, 5, 10, 0),
(127, 6, 10, 0),
(669, 0, 10, 0),
(669, 1, 10, 0),
(669, 2, 10, 0),
(669, 3, 10, 0),
(669, 4, 10, 0),
(669, 5, 10, 0),
(669, 6, 10, 0),
(670, 0, 10, 0),
(670, 1, 10, 0),
(670, 2, 10, 0),
(670, 3, 10, 0),
(670, 4, 10, 0),
(670, 5, 10, 0),
(670, 6, 10, 0),
(672, 0, 10, 0),
(672, 1, 10, 0),
(672, 2, 10, 0),
(672, 3, 10, 0),
(672, 4, 10, 0),
(672, 5, 10, 0),
(672, 6, 10, 0),
(676, 0, 10, 0),
(676, 1, 10, 0),
(676, 2, 10, 0),
(676, 3, 10, 0),
(676, 4, 10, 0),
(676, 5, 10, 0),
(676, 6, 10, 0),
(677, 0, 10, 0),
(677, 1, 10, 0),
(677, 2, 10, 0),
(677, 3, 10, 0),
(677, 4, 10, 0),
(677, 5, 10, 0),
(677, 6, 10, 0),
(1131, 0, 10, 0),
(1131, 1, 10, 0),
(1131, 2, 10, 0),
(1131, 3, 10, 0),
(1131, 4, 10, 0),
(1131, 5, 10, 0),
(1131, 6, 10, 0),
(1132, 0, 10, 0),
(1132, 1, 10, 0),
(1132, 2, 10, 0),
(1132, 3, 10, 0),
(1132, 4, 10, 0),
(1132, 5, 10, 0),
(1132, 6, 10, 0),
(1194, 0, 10, 0),
(1194, 1, 10, 0),
(1194, 2, 10, 0),
(1194, 3, 10, 0),
(1194, 4, 10, 0),
(1194, 5, 10, 0),
(1194, 6, 10, 0),
(1316, 0, 10, 0),
(1316, 1, 10, 0),
(1316, 2, 10, 0),
(1316, 3, 10, 0),
(1316, 4, 10, 0),
(1316, 5, 10, 0),
(1316, 6, 10, 0),
(1317, 0, 10, 0),
(1317, 1, 10, 0),
(1317, 2, 10, 0),
(1317, 3, 10, 0),
(1317, 4, 10, 0),
(1317, 5, 10, 0),
(1317, 6, 10, 0),
(1319, 0, 10, 0),
(1319, 1, 10, 0),
(1319, 2, 10, 0),
(1319, 3, 10, 0),
(1319, 4, 10, 0),
(1319, 5, 10, 0),
(1319, 6, 10, 0),
(1320, 0, 10, 0),
(1320, 1, 10, 0),
(1320, 2, 10, 0),
(1320, 3, 10, 0),
(1320, 4, 10, 0),
(1320, 5, 10, 0),
(1320, 6, 10, 0),
(1322, 0, 10, 0),
(1322, 1, 10, 0),
(1322, 2, 10, 0),
(1322, 3, 10, 0),
(1322, 4, 10, 0),
(1322, 5, 10, 0),
(1322, 6, 10, 0),
(1323, 0, 10, 0),
(1323, 1, 10, 0),
(1323, 2, 10, 0),
(1323, 3, 10, 0),
(1323, 4, 10, 0),
(1323, 5, 10, 0),
(1323, 6, 10, 0),
(1324, 0, 10, 0),
(1324, 1, 10, 0),
(1324, 2, 10, 0),
(1324, 3, 10, 0),
(1324, 4, 10, 0),
(1324, 5, 10, 0),
(1324, 6, 10, 0),
(1325, 0, 10, 0),
(1325, 1, 10, 0),
(1325, 2, 10, 0),
(1325, 3, 10, 0),
(1325, 4, 10, 0),
(1325, 5, 10, 0),
(1325, 6, 10, 0),
(3728, 0, 10, 0),
(3728, 1, 10, 0),
(3728, 2, 10, 0),
(3728, 3, 10, 0),
(3728, 4, 10, 0),
(3728, 5, 10, 0),
(3728, 6, 10, 0),
(4695, 0, 10, 0),
(4695, 1, 10, 0),
(4695, 2, 10, 0),
(4695, 3, 10, 0),
(4695, 4, 10, 0),
(4695, 5, 10, 0),
(4695, 6, 10, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_spells`
--

CREATE TABLE IF NOT EXISTS `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`name`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_statements`
--

CREATE TABLE IF NOT EXISTS `player_statements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL DEFAULT '0',
  `text` varchar(255) NOT NULL,
  `date` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `channel_id` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_storage`
--

CREATE TABLE IF NOT EXISTS `player_storage` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `key` int(10) unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '0',
  UNIQUE KEY `player_id_2` (`player_id`,`key`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_viplist`
--

CREATE TABLE IF NOT EXISTS `player_viplist` (
  `player_id` int(11) NOT NULL,
  `vip_id` int(11) NOT NULL,
  UNIQUE KEY `player_id_2` (`player_id`,`vip_id`),
  KEY `player_id` (`player_id`),
  KEY `vip_id` (`vip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `poll`
--

CREATE TABLE IF NOT EXISTS `poll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(150) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `question` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `poll_answer`
--

CREATE TABLE IF NOT EXISTS `poll_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `poll_id` int(11) NOT NULL,
  `answer` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `poll_id` (`poll_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `poll_votes`
--

CREATE TABLE IF NOT EXISTS `poll_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer_id` int(11) DEFAULT NULL,
  `poll_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_id` (`answer_id`),
  KEY `poll_id` (`poll_id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(120) DEFAULT NULL,
  `text` text,
  `time` int(11) DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL,
  `board_id` int(11) DEFAULT NULL,
  `thread_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `board_id` (`board_id`),
  KEY `thread_id` (`thread_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `server_config`
--

CREATE TABLE IF NOT EXISTS `server_config` (
  `config` varchar(35) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `config` (`config`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `server_config`
--

INSERT INTO `server_config` (`config`, `value`) VALUES
('db_version', '36'),
('encryption', '2'),
('vahash_key', '9O5T-32V9-65EG-6K26'),
('vip_sys', '1');

-- --------------------------------------------------------

--
-- Estrutura para tabela `server_motd`
--

CREATE TABLE IF NOT EXISTS `server_motd` (
  `id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  UNIQUE KEY `id` (`id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `server_motd`
--

INSERT INTO `server_motd` (`id`, `world_id`, `text`) VALUES
(1, 0, 'Welcome to The Forgotten Server!'),
(2, 0, 'Bem Vindo ao NTO AbsoluT'),
(3, 0, 'Bem Vindo ao Naruto Absolut!'),
(4, 0, 'Bem Vindo ao NTO AbsoluT'),
(5, 0, 'Bem Vindo ao Naruto Absolut!'),
(6, 0, 'Bem-vindo ao NTO Hard Online !'),
(7, 0, 'Bem Vindo ao Naruto Absolut!'),
(8, 0, 'Naruto Atom Online! Bom Jogo!'),
(9, 0, 'Bem-vindo ao NTO Hard Online !'),
(10, 0, 'Bem Vindo ao Naruto Absolut!'),
(11, 0, 'Bem Vindo ao Naruto Fun!'),
(12, 0, 'Bem-Vindo ao NTOFUN!');

-- --------------------------------------------------------

--
-- Estrutura para tabela `server_record`
--

CREATE TABLE IF NOT EXISTS `server_record` (
  `record` int(11) NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `timestamp` bigint(20) NOT NULL,
  UNIQUE KEY `record` (`record`,`world_id`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `server_record`
--

INSERT INTO `server_record` (`record`, `world_id`, `timestamp`) VALUES
(1, 0, 1615259284),
(2, 0, 1615259285),
(3, 0, 1615259285),
(4, 0, 1615259285),
(5, 0, 1615259285),
(6, 0, 1615259285),
(7, 0, 1615259285),
(8, 0, 1615259285),
(9, 0, 1615259285),
(10, 0, 1615259285),
(11, 0, 1615259285),
(12, 0, 1615259285),
(13, 0, 1615259285),
(14, 0, 1615259285),
(15, 0, 1615259285),
(16, 0, 1615259285),
(17, 0, 1615259285),
(18, 0, 1615259285),
(19, 0, 1615259285),
(20, 0, 1615259285),
(21, 0, 1615259286),
(22, 0, 1615259286),
(23, 0, 1615259286),
(24, 0, 1615259286),
(25, 0, 1615259286),
(26, 0, 1615259286),
(27, 0, 1615259287),
(28, 0, 1615259287),
(29, 0, 1615259288),
(30, 0, 1615259288),
(31, 0, 1615259289),
(32, 0, 1615259289),
(33, 0, 1615259290),
(34, 0, 1615259290),
(35, 0, 1615259458),
(36, 0, 1615259465),
(37, 0, 1615259467),
(38, 0, 1615259475),
(39, 0, 1615259478),
(40, 0, 1615259508),
(41, 0, 1615259564),
(42, 0, 1615259568),
(43, 0, 1615259640),
(44, 0, 1615259841),
(45, 0, 1615260209),
(46, 0, 1615260213),
(47, 0, 1615260271),
(48, 0, 1615260335),
(49, 0, 1615260370),
(50, 0, 1615260519),
(51, 0, 1615260582),
(52, 0, 1615260589),
(53, 0, 1615261002),
(54, 0, 1615261244),
(55, 0, 1615261473),
(56, 0, 1615261544),
(57, 0, 1615261641),
(58, 0, 1615261688),
(59, 0, 1615261799),
(60, 0, 1615261874),
(61, 0, 1615263346),
(62, 0, 1615297160),
(63, 0, 1615298524),
(64, 0, 1615299135);

-- --------------------------------------------------------

--
-- Estrutura para tabela `server_reports`
--

CREATE TABLE IF NOT EXISTS `server_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL DEFAULT '1',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `timestamp` bigint(20) NOT NULL DEFAULT '0',
  `report` text NOT NULL,
  `reads` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `world_id` (`world_id`),
  KEY `reads` (`reads`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `shop_donation_history`
--

CREATE TABLE IF NOT EXISTS `shop_donation_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `method` varchar(256) NOT NULL,
  `receiver` varchar(256) NOT NULL,
  `buyer` varchar(256) NOT NULL,
  `account` varchar(256) NOT NULL,
  `points` int(11) NOT NULL,
  `date` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `shop_history`
--

CREATE TABLE IF NOT EXISTS `shop_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product` int(11) NOT NULL,
  `session` varchar(256) NOT NULL,
  `player` varchar(256) NOT NULL,
  `date` int(10) NOT NULL,
  `processed` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=203 ;

--
-- Fazendo dump de dados para tabela `shop_history`
--

INSERT INTO `shop_history` (`id`, `product`, `session`, `player`, `date`, `processed`) VALUES
(1, 53, 'kotito', 'Kottyh', 1614537729, 1),
(2, 131, 'zikavailas', 'Play stompdmg', 1614540555, 1),
(3, 141, 'zikavailas', 'Play stompdmg', 1614540608, 1),
(4, 147, 'zikavailas', 'Play stompdmg', 1614540692, 1),
(5, 47, 'zikavailas', 'Play stompdmg', 1614540727, 1),
(6, 169, 'eliseu', 'Tsunade Senju', 1614557940, 1),
(7, 151, 'eliseu', 'Tsunade Senju', 1614558046, 1),
(8, 147, 'eliseu', 'Tsunade Senju', 1614558088, 1),
(9, 141, 'eliseu', 'Tsunade Senju', 1614558117, 1),
(10, 153, 'eliseu', 'Tsunade Senju', 1614558141, 1),
(11, 139, 'eliseu', 'Tsunade Senju', 1614558186, 1),
(12, 141, 'oficekkk', 'Koutuka Teu Kou', 1614559291, 1),
(13, 100, 'oficekkk', 'Koutuka Teu Kou', 1614559566, 1),
(14, 169, '19283746', 'Descanso', 1614559680, 1),
(15, 100, 'dnv159753', 'Koutukey Teu Kou', 1614562699, 1),
(16, 141, 'dnv159753', 'Koutukey Teu Kou', 1614562982, 1),
(17, 167, '45600722', 'Backache', 1614563297, 1),
(18, 59, '45600722', 'Rock Lee', 1614563311, 1),
(19, 159, '45600722', 'Backache', 1614563342, 1),
(20, 59, '45600722', 'Backache', 1614563354, 1),
(21, 100, '45600722', 'Backache', 1614563390, 1),
(22, 100, '45600722', 'Backache', 1614563390, 1),
(23, 105, 'dnv159753', 'Koutukey Teu Kou', 1614563433, 1),
(24, 47, '45600722', 'Backache', 1614563493, 1),
(25, 169, '45600722', 'Tsunade', 1614563507, 1),
(26, 115, '45600722', 'Backache', 1614563549, 1),
(27, 115, '45600722', 'Backache', 1614563549, 1),
(28, 100, '45600722', 'Rock Lee', 1614563603, 1),
(29, 142, '45600722', 'Backache', 1614563640, 1),
(30, 142, '45600722', 'Backache', 1614563640, 1),
(31, 142, '45600722', 'Rock Lee', 1614563658, 1),
(32, 115, '45600722', 'Rock Lee', 1614563699, 1),
(33, 168, '45600722', 'Backache', 1614563773, 1),
(34, 168, '45600722', 'Rock Lee', 1614564007, 1),
(35, 59, '45600722', 'Tsunade', 1614564044, 1),
(36, 138, '45600722', 'Tsunade', 1614564085, 1),
(37, 138, '45600722', 'Tsunade', 1614564158, 1),
(38, 138, '45600722', 'Tsunade', 1614564159, 1),
(39, 138, '45600722', 'Tsunade', 1614564159, 1),
(40, 138, '45600722', 'Tsunade', 1614564159, 1),
(41, 138, '45600722', 'Tsunade', 1614564159, 1),
(42, 138, '45600722', 'Tsunade', 1614564159, 1),
(43, 138, '45600722', 'Tsunade', 1614564159, 1),
(44, 138, '45600722', 'Tsunade', 1614564160, 1),
(45, 138, '45600722', 'Tsunade', 1614564185, 1),
(46, 140, 'eliseu', 'Tsunade Senju', 1614567303, 1),
(47, 47, 'mgtow', 'Trembolona', 1614568967, 1),
(48, 47, 'mgtow', 'Gaarazingod', 1614569124, 1),
(49, 165, 'mgtow', 'Trembolona', 1614570025, 1),
(50, 162, 'mgtow', 'Gaarazingod', 1614571544, 1),
(51, 169, 'pokemon125', 'Mirai Godaime', 1614575028, 1),
(52, 131, 'pokemon125', 'Mirai Nightmare', 1614575092, 1),
(53, 167, 'pokemon125', 'Mirai Nightmare', 1614575552, 1),
(54, 163, 'crummyfun', 'Bugadasso', 1614576294, 1),
(55, 153, 'crummyfun', 'Bugadasso', 1614576706, 1),
(56, 141, 'crummyfun', 'Bugadasso', 1614576718, 1),
(57, 147, 'crummyfun', 'Bugadasso', 1614576735, 1),
(58, 151, 'crummyfun', 'Bugadasso', 1614576746, 1),
(59, 164, 'pokemon125', 'Mirai Nightmare', 1614576814, 1),
(60, 61, 'kotito', 'Kottyh', 1614594931, 1),
(61, 114, 'kotito', 'Kottyh', 1614595001, 1),
(62, 91, 'kotito', 'Kottyh', 1614595093, 1),
(63, 53, 'kotito', 'Fearless Damage', 1614595161, 1),
(64, 61, 'kotito', 'Fearless Damage', 1614595191, 1),
(65, 114, 'kotito', 'Fearless Damage', 1614595203, 1),
(66, 91, 'kotito', 'Fearless Damage', 1614595230, 1),
(67, 131, 'kotito', 'Fearless Damage', 1614595340, 1),
(68, 169, 'amdr55', 'Psycho', 1614600231, 1),
(69, 46, 'amdr55', 'Psycho', 1614600240, 1),
(70, 159, 'mgtow', 'Zeus', 1614603169, 1),
(71, 53, 'mgtow', 'Tuff', 1614610280, 1),
(72, 53, 'mgtow', 'Tuff', 1614610286, 1),
(73, 131, 'ashgk', 'Kozuki', 1614619104, 1),
(74, 159, 'ashgk', 'Tral', 1614619136, 1),
(75, 154, 'gustavolbme', 'Klaus', 1614631911, 1),
(76, 53, 'gustavolbme', 'Klaus', 1614631930, 1),
(77, 114, 'gustavolbme', 'Klaus', 1614631966, 1),
(78, 47, 'gustavolbme', 'Klaus', 1614631977, 1),
(79, 144, 'gustavolbme', 'Klaus', 1614632009, 1),
(80, 159, 'bragatere', 'Ximbica', 1614641705, 1),
(81, 169, 'bragatere', 'Ximbinha', 1614641734, 1),
(82, 161, 'crummyfun', 'Bugadassa', 1614641821, 1),
(83, 47, 'crummyfun', 'Bugadassa', 1614641959, 1),
(84, 142, 'crummyfun', 'Bugadassa', 1614641978, 1),
(85, 147, 'crummyfun', 'Bugadassa', 1614641995, 1),
(86, 151, 'crummyfun', 'Bugadassa', 1614642119, 1),
(87, 152, 'crummyfun', 'Bugadassa', 1614642181, 1),
(88, 168, 'crummyfun', 'Bugadassa', 1614642261, 1),
(89, 141, 'joao1234', 'Jaeger', 1614643160, 1),
(90, 54, 'joao1234', 'Jaeger', 1614643201, 1),
(91, 151, 'zikavailas', 'Play stompdmg', 1614643278, 1),
(92, 153, 'zikavailas', 'Play stompdmg', 1614643299, 1),
(93, 166, 'ryanm154', 'Poseidon', 1614647357, 1),
(94, 163, 'amdr55', 'Sicko Mode', 1614647398, 1),
(95, 167, 'ryanm154', 'Poseidon', 1614647405, 1),
(96, 139, 'amdr55', 'Psycho', 1614647422, 1),
(97, 139, 'amdr55', 'Psycho', 1614647503, 1),
(98, 151, 'mgtow', 'Trembolona', 1614647744, 1),
(99, 147, 'mgtow', 'Trembolona', 1614647780, 1),
(100, 141, 'mgtow', 'Trembolona', 1614647812, 1),
(101, 153, 'mgtow', 'Trembolona', 1614647848, 1),
(102, 78, 'bragatere', 'Ximbica', 1614647933, 1),
(103, 168, 'mgtow', 'Trembolona', 1614647997, 1),
(104, 141, 'mgtow', 'Tuff', 1614648433, 1),
(105, 147, 'mgtow', 'Tuff', 1614648462, 1),
(106, 167, '495315', 'aluc cadeirante', 1614652193, 1),
(107, 159, '495315', 'aluc the legends', 1614653235, 1),
(108, 169, '495315', 'aluc power hand', 1614653722, 1),
(109, 151, 'ryanm154', 'Poseidon', 1614690493, 1),
(110, 46, 'mgtow', 'Hades', 1614701071, 1),
(111, 168, 'gmdr', 'Its Him', 1614717043, 1),
(112, 164, 'gustavolbme', 'Klaus', 1614735928, 1),
(113, 149, 'gustavolbme', 'Klaus', 1614736371, 1),
(114, 168, 'zikavailas', 'Trembolona', 1614741674, 1),
(115, 162, 'hooshi27', 'Gabigol', 1614747718, 1),
(116, 165, 'hooshi27', 'Daiki Aomine', 1614749362, 1),
(117, 53, 'amdr55', 'Sicko Mode', 1614777488, 1),
(118, 47, 'amdr55', 'Psycho', 1614777654, 1),
(119, 139, 'amdr55', 'Psycho', 1614777704, 1),
(120, 139, 'amdr55', 'Psycho', 1614777719, 1),
(121, 140, '495315', 'aluc the legends', 1614777729, 1),
(122, 139, '495315', 'aluc power hand', 1614777856, 1),
(123, 53, 'gmdr', 'Its Him', 1614802760, 1),
(124, 107, 'oficekkk', 'Koutuka Teu Kou', 1614807180, 1),
(125, 162, '45600722', 'Namikaze Minato', 1614809032, 1),
(126, 165, '45600722', 'Uchiha Madara', 1614809049, 1),
(127, 138, '45600722', 'Backache', 1614809332, 1),
(128, 138, '45600722', 'Backache', 1614809332, 1),
(129, 138, '45600722', 'Backache', 1614809333, 1),
(130, 140, '45600722', 'Backache', 1614809351, 1),
(131, 140, '45600722', 'Backache', 1614809351, 1),
(132, 140, '45600722', 'Backache', 1614809352, 1),
(133, 140, '45600722', 'Backache', 1614809352, 1),
(134, 159, 'oficekkk', 'Nhack Nhack', 1614809551, 1),
(135, 147, 'oficekkk', 'Koutuka Teu Kou', 1614809691, 1),
(136, 47, 'taylorfilth', 'Mirai Nightmare', 1614831733, 1),
(137, 47, 'taylorfilth', 'Taylor The One', 1614831814, 1),
(138, 162, '495315', 'aluc the namikaze', 1614833020, 1),
(139, 138, '495315', 'aluc the namikaze', 1614833113, 1),
(140, 139, '495315', 'aluc cadeirante', 1614833172, 1),
(141, 161, '495315', 'mirai power abuse', 1614833875, 1),
(142, 169, 'hooshi27', 'Nico Robin', 1614838775, 1),
(143, 54, 'hooshi27', 'Gabigol', 1614839281, 1),
(144, 151, 'oficekkk', 'Koutuka Teu Kou', 1614840607, 1),
(145, 138, 'crummyfun', 'Bugadasso', 1614870367, 1),
(146, 138, 'crummyfun', 'Bugadasso', 1614870378, 1),
(147, 138, 'crummyfun', 'Bugadasso', 1614870389, 1),
(148, 166, 'escada', 'Misame', 1614875195, 1),
(149, 138, 'escada', 'Misame', 1614875260, 1),
(150, 54, 'ashgk', 'Kozuki', 1614900096, 1),
(151, 47, 'ashgk', 'Kozuki', 1614900110, 1),
(152, 131, 'mgtow', 'Testosterona', 1614903127, 1),
(153, 138, '495315', 'aluc the namikaze', 1614908314, 1),
(154, 139, '495315', 'aluc power hand', 1614908335, 1),
(155, 140, '495315', 'aluc the legends', 1614908348, 1),
(156, 140, '495315', 'aluc the legends', 1614918920, 1),
(157, 139, 'guiknp', 'Tsunade Senju', 1615065430, 1),
(158, 59, 'eliseu', 'Adolf Hitler', 1615087907, 1),
(159, 109, 'eliseu', 'Adolf Hitler', 1615087975, 1),
(160, 115, 'eliseu', 'Adolf Hitler', 1615088002, 1),
(161, 86, 'eliseu', 'Adolf Hitler', 1615088032, 1),
(162, 159, 'mgtow', 'Play Anbu', 1615092849, 1),
(163, 159, 'mgtow', 'Play Anbu', 1615092860, 1),
(164, 100, 'mgtow', 'Trembolona', 1615093230, 1),
(165, 100, 'mgtow', 'Play Anbu', 1615093272, 1),
(166, 141, 'kotito', 'Fearless Damage', 1615135722, 1),
(167, 147, 'kotito', 'Fearless Damage', 1615135737, 1),
(168, 151, 'kotito', 'Fearless Damage', 1615135756, 1),
(169, 153, 'kotito', 'Fearless Damage', 1615135769, 1),
(170, 140, 'taylorfilth', 'Mirai Verdinho', 1615161286, 1),
(171, 140, 'taylorfilth', 'Taylor The One', 1615161430, 1),
(172, 64, '45600722', 'Tsunade', 1615167150, 1),
(173, 139, '45600722', 'Tsunade', 1615167168, 1),
(174, 67, 'taylorfilth', 'Taylor The One', 1615176177, 1),
(175, 162, 'taylorfilth', 'Taylor', 1615226501, 1),
(176, 168, 'hooshi27', 'Gabigol', 1615238599, 1),
(177, 48, 'kotito', 'Fearless Damage', 1615240029, 1),
(178, 131, 'demon', 'Demon Chuta Random', 1615298585, 1),
(179, 164, 'demon', 'Nkaszin', 1615299187, 1),
(180, 169, 'mahziika', 'Hokage Tsu', 1615340809, 1),
(181, 161, 'guh799', 'Balmain', 1615382632, 1),
(182, 145, 'guh799', 'Balmain', 1615382784, 1),
(183, 150, 'guh799', 'Balmain', 1615382809, 1),
(184, 142, 'guh799', 'Balmain', 1615382823, 1),
(185, 152, 'guh799', 'Balmain', 1615382850, 1),
(186, 51, 'guh799', 'Guga lee', 1615458540, 1),
(187, 166, 'guh799', 'PAQUITAO', 1615499589, 1),
(188, 47, 'guh799', 'PAQUITAO', 1615501031, 1),
(189, 142, 'guh799', 'PAQUITAO', 1615501076, 1),
(190, 145, 'guh799', 'PAQUITAO', 1615501095, 1),
(191, 150, 'guh799', 'PAQUITAO', 1615501117, 1),
(192, 152, 'guh799', 'PAQUITAO', 1615501142, 1),
(193, 154, 'guh799', 'Balmain', 1615501317, 1),
(194, 64, 'guh799', 'Balmain', 1615501342, 1),
(195, 47, 'guh799', 'PAQUITAO', 1615501420, 1),
(196, 139, 'guh799', 'PAQUITAO', 1615544406, 1),
(197, 162, 'foxzinho', 'Karol Com Fusca', 1615559623, 1),
(198, 46, 'gmdr', 'Its Him', 1615607426, 1),
(199, 168, 'kotito', 'Fearless Damage', 1615665779, 1),
(200, 46, 'oficekkk', 'Karol com Onix', 1615671721, 1),
(201, 46, 'taylorfilth', 'Salveta Mata Tudo', 1615742872, 1),
(202, 46, 'mahziika', 'Hokage Tsu', 1616281700, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `shop_offer`
--

CREATE TABLE IF NOT EXISTS `shop_offer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `points` int(11) NOT NULL DEFAULT '0',
  `category` int(11) NOT NULL DEFAULT '1',
  `type` int(11) NOT NULL DEFAULT '1',
  `item` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `name` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=170 ;

--
-- Fazendo dump de dados para tabela `shop_offer`
--

INSERT INTO `shop_offer` (`id`, `points`, `category`, `type`, `item`, `count`, `description`, `name`) VALUES
(50, 30, 1, 2, 0, 0, 'Remove skull do personagem.', 'Removedor de Skull'),
(54, 15, 2, 5, 2132, 1, 'Madara boots (Arm:70, magic level + 2, faster regeneration). chakra/life +2000.', 'Madara Boots'),
(56, 25, 2, 5, 2430, 1, 'Madara Legs (Arm:100, magic level + 3, faster regeneration). chakra +2000.', 'Madara Legs'),
(53, 25, 2, 5, 2523, 1, 'Hashirama armor (Arm:50, protection all +5%, faster regeneration). Chakra/Life 5000/s.', 'Hashirama Armor'),
(59, 15, 2, 5, 2122, 1, 'Obito Boots (Arm:70, fist fighting +5, sword fighting +5, axe fighting +5, distance fighting +5, faster regeneration), Chakra 2000/s.', 'Obito Boots'),
(61, 20, 2, 5, 2123, 1, 'Hashirama Boots (Arm:70, protection all +1%, faster regeneration), Chakra +2000/s.', 'Hashirama Boots'),
(114, 25, 2, 5, 2432, 1, '(Arm:100, protection all +2%, faster regeneration),\nchakra +2000.', 'Hashirama Legs'),
(55, 25, 2, 5, 8854, 1, 'Madara Armor (Arm:30, magic level + 5, faster regeneration). chakra/life +5000.', 'Madara Armor'),
(64, 20, 2, 5, 7895, 1, '(Atk:32, Def:30).\nIt can only be wielded properly by players of level 350 or higher.', 'Madara Gloves'),
(65, 20, 2, 5, 7857, 1, '(Atk:32, Def:30).\nIt can only be wielded properly by players of level 350 or higher.', 'Sealed Sword'),
(48, 20, 1, 1, 0, 60, '60 dias Premmy account.', 'Premium Account 60 Dias'),
(49, 30, 1, 1, 0, 90, '90 dias Premmy account.', 'Premium Account 90 Dias'),
(47, 10, 1, 1, 0, 30, '30 dias Premmy account.', 'Premium Account 30 Dias'),
(46, 5, 1, 1, 0, 15, '15 dias Premmy account.', 'Premium Account 15 Dias'),
(51, 5, 1, 4, 0, 0, 'Mude o nome do personagem.', 'Mudar Nome'),
(52, 65, 1, 3, 0, 0, 'Remove del. da conta, e zera seus warnings', 'Removedor Del. da Conta'),
(66, 20, 2, 5, 7866, 1, '(Atk:31, Def:20).\nIt can only be wielded properly by  of level 400 or higher.', 'Wafer Extreme'),
(67, 60, 2, 5, 11429, 1, '(Atk:36, Def:12).\nIt can only be wielded properly by players of level 400 or higher.', 'Cetro Rikkudou'),
(98, 50, 2, 5, 7865, 1, '(Atk:34, Def:34). It can only be wielded properly by players of level 400 or higher.', 'Kage Kunai'),
(70, 1, 2, 5, 7898, 1, '(Atk:7, Def:7).', 'Sharp Glove'),
(71, 1, 2, 5, 2382, 1, '(Atk:5, Def:8).', 'Katana'),
(74, 10, 2, 5, 2516, 1, '(Atk:30, Def:20). It can only be wielded properly by players of level 250 or higher.', 'Raikage Glove'),
(73, 5, 2, 5, 2433, 1, '(Atk:24, Def:20 +1).\nIt can only be wielded properly by players of level 225 or higher.', 'Chakra Eletric Katana'),
(75, 15, 2, 5, 2648, 1, '(Atk:31, Def:28).\nIt can only be wielded properly by players of level 300 or higher.', 'Itachi Gloves'),
(76, 1, 2, 5, 2397, 1, '(Arm:17, faster regeneration),\nChakra 1000/s.', 'Chakra Armor'),
(77, 5, 2, 5, 2463, 1, 'Orochimaru Tunic (Arm:30, faster regeneration),\nChakra/Life 2000/s.', 'Orochimaru Tunic'),
(78, 10, 2, 5, 8865, 1, '(Arm:6, faster regeneration),\nChakra/Life +2k500.', 'Gaara Coat'),
(79, 15, 2, 5, 2127, 1, '(Arm:20, faster regeneration),\nchakra +5000.', 'Kazekage Coat'),
(80, 15, 2, 5, 2128, 1, '(Arm:20, faster regeneration),\nLife +5000.', 'Hokage Coat'),
(81, 25, 2, 5, 2129, 1, '(Arm:100, speed +100, faster regeneration).\nchakra/life +5000.', 'Yondaime Coat'),
(82, 1, 2, 5, 2405, 1, '(Atk:5, Def:5).', 'TaiJutsu Glove'),
(83, 5, 2, 5, 7902, 1, '(Atk:12, Def:12).', 'Ultimate Glove'),
(84, 10, 2, 5, 2373, 1, '(Atk:26, Def:24).\nIt can only be wielded properly by players of level 200 or higher.', 'Absorved Chakra Taijutsu'),
(85, 15, 2, 5, 2390, 1, '(Atk:27, Def:24).\nIt can only be wielded properly by players of level 250 or higher.', 'Shark Absorb Sword'),
(86, 20, 2, 5, 2135, 1, '(Arm:30, fist fighting +5, sword fighting +5, axe fighting +5, distance fighting +5, faster regeneration),\nlife/chakra +2000.', 'Hiruzen Helmet'),
(87, 5, 2, 5, 7437, 1, '(Arm:10, faster regeneration),\nLife/Chakra 1000/s.', 'Nidaime Protector'),
(88, 20, 2, 5, 7416, 1, '(Arm:30, faster regeneration),\nLife/Chakra 4500/s.', 'Tsunade Coat'),
(89, 5, 2, 5, 2480, 1, '(Arm:15, sword fighting +10, axe fighting +10, distance fighting +10).', 'Tobi Mask'),
(90, 20, 2, 5, 3982, 1, '(Arm:30, faster regeneration),\nChakra/Life 4000.', 'Akatsuki Robe'),
(91, 25, 2, 5, 7877, 1, '(Arm:50, magic level +5, faster regeneration),\nChakra/Life 2000/s.', 'Rinnegan Mask'),
(92, 10, 2, 5, 2652, 1, '(Arm:10, faster regeneration),\nChakra +1k.', 'Akatsuki Hat'),
(93, 15, 2, 5, 8851, 1, '(Arm:15, sword fighting +3, axe fighting +3, distance fighting +3, faster regeneration).\nChakra +1k.', 'Akatsuki Legs'),
(94, 10, 2, 5, 2646, 1, '(Arm:4, faster regeneration).\nIt can only be wielded properly by players of level 150 or higher.\nchakra 2000/s.', 'Sennin Boots'),
(95, 1, 2, 5, 7375, 1, '(Atk:16, Def:10).\nIt can only be wielded properly by  of level 100 or higher.', 'Wafer Low'),
(96, 5, 2, 5, 7376, 1, '(Atk:26, Def:16).\nIt can only be wielded properly by  of level 200 or higher.', 'Wafer Mid'),
(97, 15, 2, 5, 7377, 1, '(Atk:28, Def:18).\nIt can only be wielded properly by  of level 300 or higher.', 'Wafer High'),
(99, 20, 2, 5, 2436, 1, '(Arm:30, faster regeneration),\nlife/chakra +2000.', 'Shinigami Mask'),
(100, 35, 2, 5, 2424, 1, '(Arm:50, fist fighting +6, sword fighting +6, axe fighting +6, distance fighting +6, magic level +3, faster regeneration),\nChakra/Life 2000/s.', 'White Demon Mask'),
(168, 45, 2, 5, 7855, 1, 'You see a Gunbai (Attack:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Gunbai'),
(102, 50, 2, 5, 2387, 1, '(Atk:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Kage Gloves'),
(103, 50, 2, 5, 2440, 1, '(Atk:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Kage Gloves Doton'),
(104, 50, 2, 5, 2435, 1, '(Atk:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Kage Gloves Suiton'),
(105, 50, 2, 5, 3962, 1, '(Atk:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Kage Gloves Fuuton'),
(106, 50, 2, 5, 2434, 1, '(Atk:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Kage Gloves Chakra'),
(107, 50, 2, 5, 3964, 1, '(Atk:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Kage Gloves Katon'),
(108, 50, 2, 5, 5875, 1, '(Atk:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Kage Gloves Raiton'),
(109, 25, 2, 5, 8874, 1, '(Arm:50, fist fighting +5, sword fighting +5, axe fighting +5, distance fighting +5, faster regeneration),\nChakra/Life 5000/s.', 'Obito Tunic'),
(110, 25, 2, 5, 11494, 1, '(Arm:35, axe fighting +5, faster regeneration),\nChakra/Life 5000/s.', 'Naruto Armor'),
(142, 35, 2, 5, 11458, 1, '(Arm:35, sword fighting +10, axe fighting +10, distance fighting +10, faster regeneration),\nChakra/Life 5800/s.', 'Enchanted Armor'),
(141, 40, 2, 5, 11487, 1, '(Arm:35, faster regeneration).\nChakra/Life 6000/s.', 'Otsutsuki Unic Armor'),
(115, 25, 2, 5, 8873, 1, '(Arm:50, fist fighting +5, sword fighting +5, axe fighting +5, distance fighting +5, faster regeneration),\nChakra/Life 2000/s.', 'Obito Legs'),
(116, 25, 2, 5, 2431, 1, '(Arm:100, speed +50, faster regeneration).\nchakra +2000.', 'Minato Legs'),
(117, 25, 2, 5, 11461, 1, '(Arm:35, axe fighting +5, faster regeneration),\nChakra 2000/s.', 'Naruto Short'),
(147, 40, 2, 5, 11488, 1, '(Arm:35, faster regeneration),\nChakra/Life 3000/s.', 'Otsutsuki Unic Leg'),
(148, 30, 2, 5, 11455, 1, '(Arm:35, sword fighting +5, axe fighting +5, distance fighting +5, faster regeneration),\nChakra/Life 2500/s.', 'Uchiha Legs'),
(145, 35, 2, 5, 11456, 1, '(Arm:35, sword fighting +7, axe fighting +7, distance fighting +7, faster regeneration),\nChakra 2800/s.', 'Enchanted Legs'),
(146, 35, 2, 5, 11496, 1, 'Lendary Uchiha Legs (Arm:35, magic level +7, faster regeneration),\nChakra 2700/s.', 'Lendary Uchiha Legs'),
(123, 15, 2, 5, 11463, 1, '(Arm:35, axe fighting +5, faster regeneration),\nChakra/Life 2000/s.', 'Naruto Boots'),
(149, 30, 2, 5, 11452, 1, '(Arm:35, sword fighting +5, axe fighting +5, distance fighting +5, faster regeneration),\nChakra 2500/s.', 'Uchiha Boots'),
(150, 35, 2, 5, 11459, 1, '(Arm:35, sword fighting +7, axe fighting +7, distance fighting +7, faster regeneration),\nChakra 2800/s.', 'Enchanted Boots'),
(151, 40, 2, 5, 11489, 1, '(Arm:35, faster regeneration),\nChakra/Life 3000/s.', 'Otsutsuki Unic Boots'),
(127, 15, 2, 5, 11462, 1, '(Arm:35, axe fighting +5, faster regeneration),\nChakra/Life 2000/s.', 'Naruto Helmet'),
(152, 35, 2, 5, 11457, 1, '(Arm:35, sword fighting +7, axe fighting +7, distance fighting +7, faster regeneration),\nChakra/Life 2800/s.', 'Enchanted Helmet'),
(153, 40, 2, 5, 11486, 1, '(Arm:35, faster regeneration),\nChakra/Life 3000/s.', 'Otsutsuki Unic Helmet'),
(131, 35, 4, 8, 2193, 1, 'VocaÃ§Ã£o Itachi.', 'VocaÃ§Ã£o Itachi'),
(138, 5, 2, 5, 11417, 1, 'Sword Box - Contem varias Swords! (1% de chance de vir Kage Kunai).', 'Sword Box'),
(139, 5, 2, 5, 11418, 1, 'Gloves Box - Contem varias Gloves! (1% de chance de vir Kage Gloves).', 'Gloves Box'),
(140, 5, 2, 5, 11416, 1, 'Distance Box - Contem varios itens Distance! (1% de chance de vir Cetro Rikkudou).', 'Distance Box'),
(143, 30, 2, 5, 11453, 1, '(Arm:35, sword fighting +8, axe fighting +8, distance fighting +8, faster regeneration),\nChakra/Life 5500/s.', 'Uchiha Coat'),
(144, 30, 2, 5, 11454, 1, '(Arm:35, sword fighting +5, axe fighting +5, distance fighting +5, faster regeneration),\nChakra/Life 2500/s.', 'Uchiha Helmet'),
(154, 50, 2, 5, 7858, 1, '(Atk:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Kage Kunai Raiton'),
(155, 50, 2, 5, 7856, 1, '(Atk:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Kage Kunai Suiton'),
(156, 50, 2, 5, 7864, 1, '(Atk:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Kage Kunai Fuuton'),
(157, 50, 2, 5, 7860, 1, '(Atk:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Kage Kunai Doton'),
(158, 50, 2, 5, 7863, 1, '(Atk:34, Def:34).\nIt can only be wielded properly by players of level 400 or higher.', 'Kage Kunai Katon'),
(159, 35, 4, 8, 2196, 1, 'VocaÃ§Ã£o Anbu', 'VocaÃ§Ã£o Anbu'),
(161, 35, 4, 8, 2192, 1, 'VocaÃ§Ã£o Killer Bee.', 'VocaÃ§Ã£o Killer Bee'),
(162, 35, 4, 8, 2201, 1, 'VocaÃ§Ã£o Minato.', 'VocaÃ§Ã£o Minato'),
(163, 35, 4, 8, 2218, 1, 'VocaÃ§Ã£o Hidan.', 'VocaÃ§Ã£o Hidan'),
(164, 35, 4, 8, 2197, 1, 'VocaÃ§Ã£o Hashirama.', 'VocaÃ§Ã£o Hashirama'),
(165, 35, 4, 8, 2200, 1, 'VocaÃ§Ã£o Madara.', 'VocaÃ§Ã£o Madara'),
(166, 35, 4, 8, 2198, 1, 'VocaÃ§Ã£o Kisame.', 'VocaÃ§Ã£o Kisame'),
(167, 40, 2, 5, 11501, 1, 'Item lendario: Temporada 1', 'Passe de Batalha'),
(169, 35, 4, 8, 2219, 1, 'Vocation Tsunade.', 'Vocation Tsunade');

-- --------------------------------------------------------

--
-- Estrutura para tabela `threads`
--

CREATE TABLE IF NOT EXISTS `threads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(120) DEFAULT NULL,
  `sticked` tinyint(1) DEFAULT NULL,
  `closed` tinyint(1) DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `board_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `board_id` (`board_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tiles`
--

CREATE TABLE IF NOT EXISTS `tiles` (
  `id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `house_id` int(10) unsigned NOT NULL,
  `x` int(5) unsigned NOT NULL,
  `y` int(5) unsigned NOT NULL,
  `z` tinyint(2) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`,`world_id`),
  KEY `x` (`x`,`y`,`z`),
  KEY `house_id` (`house_id`,`world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tile_items`
--

CREATE TABLE IF NOT EXISTS `tile_items` (
  `tile_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL,
  UNIQUE KEY `tile_id` (`tile_id`,`world_id`,`sid`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tile_store`
--

CREATE TABLE IF NOT EXISTS `tile_store` (
  `house_id` int(10) unsigned NOT NULL,
  `world_id` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `data` longblob NOT NULL,
  KEY `house_id` (`house_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `tile_store`
--

INSERT INTO `tile_store` (`house_id`, `world_id`, `data`) VALUES
(494, 0, 0x2a01b3010601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023343934272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323430303020676f6c6420636f696e732e00),
(496, 0, 0x0f0447030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023343936272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(497, 0, 0x140447030701000000281900),
(497, 0, 0x150447030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023343937272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(497, 0, 0x170445030701000000291900),
(500, 0, 0x1a0447030701000000281900),
(500, 0, 0x1b0447030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353030272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(500, 0, 0x1d0445030701000000291900),
(501, 0, 0x3f047a030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353031272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373730303020676f6c6420636f696e732e00),
(501, 0, 0x46047d030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(501, 0, 0x46047e030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(502, 0, 0x3b047c030701000000291900),
(502, 0, 0x360480030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353032272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373830303020676f6c6420636f696e732e00),
(503, 0, 0x30048b030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353033272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373830303020676f6c6420636f696e732e00),
(504, 0, 0x390485030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353034272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373730303020676f6c6420636f696e732e00),
(504, 0, 0x400488030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(504, 0, 0x400489030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(505, 0, 0x390491030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353035272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(506, 0, 0x440487030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(507, 0, 0x300478030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353037272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(508, 0, 0x30047f030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353038272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(509, 0, 0x290480030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353039272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(510, 0, 0x290487030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353130272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(511, 0, 0x29048e030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353131272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(512, 0, 0x2c0490030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353132272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373730303020676f6c6420636f696e732e00),
(512, 0, 0x330493030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(512, 0, 0x330494030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(513, 0, 0x31049a030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353133272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(514, 0, 0x3104a0030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353134272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(515, 0, 0x2b04a0030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353135272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(516, 0, 0x130488030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353136272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(516, 0, 0x150488030701000000281900),
(517, 0, 0x0d0488030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353137272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(517, 0, 0x0f0488030701000000281900),
(518, 0, 0x070488030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353138272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(518, 0, 0x090488030701000000281900),
(519, 0, 0x130482030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(519, 0, 0x150482030701000000281900),
(520, 0, 0x0d0482030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353230272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(521, 0, 0x070482030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353231272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(521, 0, 0x090482030701000000281900),
(522, 0, 0x13047c030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353232272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(522, 0, 0x15047c030701000000281900),
(523, 0, 0x0d047c030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353233272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(523, 0, 0x0f047c030701000000281900),
(524, 0, 0x07047c030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353234272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(524, 0, 0x09047c030701000000281900),
(525, 0, 0xfa039a030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353235272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(525, 0, 0xfc039d030701000000291900),
(526, 0, 0xf6039a030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353236272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(527, 0, 0xf2039a030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353237272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(528, 0, 0xee039a030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353238272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(529, 0, 0xea039a030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353239272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(530, 0, 0xfc0392030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(530, 0, 0xfc0393030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(530, 0, 0xfd0393030701000000291900),
(530, 0, 0xfb0396030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353330272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(531, 0, 0xf60396030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353331272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(533, 0, 0xee0396030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353333272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(534, 0, 0xe90392030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(534, 0, 0xe90393030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(534, 0, 0xea0396030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353334272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313130303020676f6c6420636f696e732e00),
(535, 0, 0xfa039f030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353335272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(535, 0, 0xfc039d030601000000291900),
(536, 0, 0xf6039f030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353336272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(537, 0, 0xf2039f030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353337272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(538, 0, 0xee039f030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353338272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(539, 0, 0xea039f030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353339272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(541, 0, 0xfa0391030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353431272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(541, 0, 0xfc0394030601000000291900),
(542, 0, 0xf60391030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353432272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(543, 0, 0xf20391030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353433272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(544, 0, 0xee0391030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353434272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(545, 0, 0xeb038f030601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353435272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313830303020676f6c6420636f696e732e00),
(545, 0, 0xeb0390030601000000291900),
(546, 0, 0xdf039b030601000000b61e8001000b0061747461636b7370656564020e02000000),
(546, 0, 0xd9039e030601000000e92c0f0100),
(546, 0, 0xda039e030601000000ec2c0f0300),
(546, 0, 0xd9039c030701000000e71c1701000000d007170400000003090f6410ffffffff0003090f6410ffffffff0003090f6410ffffffff00d007170100000003090f5410ffffffff00000000),
(546, 0, 0xd9039d030701000000d2071701000000c42c0f2110ffffffff0000),
(546, 0, 0xd9039e030701000000ee2c00),
(546, 0, 0xdc039f030601000000281900),
(546, 0, 0xdf039c030601000000b61e00),
(546, 0, 0xdc039f030701000000281900),
(546, 0, 0xe0039b0306010000007b0f8001000b0061747461636b7370656564021302000000),
(546, 0, 0xe2039b030604000000c51e00c51e00c51e00c51e00),
(546, 0, 0xe1039b0307010000004f0800),
(546, 0, 0xe2039b030701000000b82c00),
(546, 0, 0xe3039b0307010000004d0800),
(546, 0, 0xe4039b0307010000005c0a00),
(546, 0, 0xe0039f030601000000281900),
(546, 0, 0xe2039c030605000000db0900db0900db0900db0900db0900),
(546, 0, 0xe2039d030603000000800900800900800900),
(546, 0, 0xe2039e0306050000004b08004b08004b08004b08004b0800),
(546, 0, 0xe3039d030601000000291900),
(546, 0, 0xe0039f030701000000281900),
(546, 0, 0xe5039d030701000000bb048001000b006465736372697074696f6e014a00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353436272e204d69726169204e696768746d617265206f776e73207468697320686f7573652e00),
(547, 0, 0xd80394030601000000291900),
(547, 0, 0xdc0396030601000000281900),
(547, 0, 0xdc0396030701000000281900),
(547, 0, 0xe00396030601000000281900),
(547, 0, 0xe30394030601000000291900),
(547, 0, 0xe00396030701000000281900),
(547, 0, 0xe50394030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353437272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383830303020676f6c6420636f696e732e00),
(547, 0, 0xe50395030701000000291900),
(548, 0, 0xbf0386030701000000291900),
(548, 0, 0xc20380030701000000281900),
(548, 0, 0xc603830307010000004f0800),
(548, 0, 0xc7038103070100000003090f3b00),
(548, 0, 0xc8038203070400000003090f6410ffffffff0003090f6410ffffffff0003090f6410ffffffff0003090f6410ffffffff00),
(548, 0, 0xc80383030701000000b92c00),
(548, 0, 0xc90380030701000000281900),
(548, 0, 0xc9038103070100000070080f4000),
(548, 0, 0xc90382030701000000eb2c0f5500),
(548, 0, 0xca038303070100000045098001000b0061747461636b7370656564027802000000),
(548, 0, 0xcc0383030701000000bb048001000b006465736372697074696f6e014300000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353438272e20506f736569646f6e206f776e73207468697320686f7573652e00),
(548, 0, 0xc00386030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(548, 0, 0xc00387030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(548, 0, 0xc10386030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(548, 0, 0xc10387030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(548, 0, 0xc40384030701000000c42c0f2010ffffffff00),
(548, 0, 0xc5038403070400000052098001000b0061747461636b7370656564020802000000520900520900520900),
(548, 0, 0xc603860307010000005c0a00),
(548, 0, 0xc70384030701000000211d00),
(548, 0, 0xc703860307010000005c0900),
(548, 0, 0xc80385030701000000b80900),
(548, 0, 0xc80386030701000000a22200),
(548, 0, 0xc80387030701000000b92c00),
(548, 0, 0xc90385030701000000800f00),
(548, 0, 0xca038403070100000045098001000b0061747461636b7370656564022b02000000),
(548, 0, 0xca03860307010000005a08800100070063686172676573020100000000),
(548, 0, 0xca0387030701000000a52200),
(548, 0, 0xcc0386030701000000291900),
(548, 0, 0xc20389030701000000281900),
(548, 0, 0xc30388030701000000f32c00),
(548, 0, 0xc40388030701000000e42c0f0210ffffffff00),
(548, 0, 0xc503880307020000005f090f6410ffffffff005f090f3200),
(548, 0, 0xc60388030701000000be0900),
(548, 0, 0xc90388030701000000b92c00),
(548, 0, 0xc90389030701000000281900),
(549, 0, 0xc90386030601000000bc048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353439272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203630303020676f6c6420636f696e732e00),
(549, 0, 0xc80388030601000000291900),
(549, 0, 0xcc0388030601000000291900),
(550, 0, 0xbf0388030601000000291900),
(550, 0, 0xc00386030601000000bc048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353530272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203630303020676f6c6420636f696e732e00),
(550, 0, 0xc30388030601000000291900),
(551, 0, 0xbf0382030601000000291900),
(551, 0, 0xc00383030601000000bc048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203630303020676f6c6420636f696e732e00),
(551, 0, 0xc30382030601000000291900),
(552, 0, 0xc80382030601000000291900),
(552, 0, 0xc90383030601000000bc048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353532272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203630303020676f6c6420636f696e732e00),
(552, 0, 0xcc0382030601000000291900),
(553, 0, 0xbe037c030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(553, 0, 0xbe037d030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(553, 0, 0xc2037a030701000000281900),
(553, 0, 0xc6037b030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353533272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343730303020676f6c6420636f696e732e00),
(553, 0, 0xc2037e030701000000281900),
(554, 0, 0xbd0377030701000000291900),
(554, 0, 0xc20374030701000000281900),
(554, 0, 0xc60375030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353534272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343830303020676f6c6420636f696e732e00),
(554, 0, 0xc60377030701000000291900),
(554, 0, 0xc20378030701000000281900),
(555, 0, 0xbd0371030701000000291900),
(555, 0, 0xbe0370030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(555, 0, 0xbe0371030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(555, 0, 0xc2036e030701000000281900),
(555, 0, 0xc6036f030701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023353535272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343730303020676f6c6420636f696e732e00),
(555, 0, 0xc20372030701000000281900),
(555, 0, 0xc60371030701000000291900),
(624, 0, 0xcf036b030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(624, 0, 0xce036c030701000000291900),
(624, 0, 0xcf036c030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(624, 0, 0xd3036a030701000000281900),
(624, 0, 0xd2036e030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363234272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313730303020676f6c6420636f696e732e00),
(624, 0, 0xd3036e030701000000281900),
(624, 0, 0xd5036c030701000000291900),
(626, 0, 0xd1036a030601000000281900),
(626, 0, 0xd0036c030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363236272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313030303020676f6c6420636f696e732e00),
(626, 0, 0xd1036c030601000000281900),
(626, 0, 0xd3036e030601000000281900),
(626, 0, 0xd5036c030601000000291900),
(627, 0, 0xda036a030601000000281900),
(627, 0, 0xd9036c030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363237272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313030303020676f6c6420636f696e732e00),
(627, 0, 0xda036c030601000000281900),
(627, 0, 0xdc036e030601000000281900),
(627, 0, 0xde036c030601000000291900),
(628, 0, 0xcc0365030701000000291900),
(628, 0, 0xcf0366030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363238272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313830303020676f6c6420636f696e732e00),
(629, 0, 0xbd0368030701000000291900),
(629, 0, 0xc0036b030701000000281900),
(629, 0, 0xc4036b030701000000281900),
(629, 0, 0xc60368030701000000291900),
(629, 0, 0xc60369030701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363239272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383030303020676f6c6420636f696e732e00),
(630, 0, 0xd40365030701000000291900),
(630, 0, 0xd70366030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363330272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e00),
(630, 0, 0xd90365030701000000291900),
(631, 0, 0xdc0365030701000000291900),
(631, 0, 0xdf0366030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363331272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313830303020676f6c6420636f696e732e00),
(631, 0, 0xe10365030701000000291900),
(632, 0, 0xe2036a030701000000281900),
(632, 0, 0xe4036a030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363332272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333530303020676f6c6420636f696e732e00),
(632, 0, 0xe5036a030701000000281900),
(632, 0, 0xe0036d030701000000291900),
(632, 0, 0xe1036c030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(632, 0, 0xe1036d030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(632, 0, 0xe2036e030701000000281900),
(632, 0, 0xe5036e030701000000281900),
(632, 0, 0xe7036d030701000000291900),
(635, 0, 0xed0373030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(635, 0, 0xee0372030701000000281900),
(635, 0, 0xec0374030701000000291900),
(635, 0, 0xed0374030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(635, 0, 0xee0376030701000000281900),
(635, 0, 0xf20372030701000000281900),
(635, 0, 0xf00376030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363335272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e00),
(635, 0, 0xf20376030701000000281900),
(635, 0, 0xf40374030701000000291900),
(636, 0, 0xe50372030701000000281900),
(636, 0, 0xe70372030701000000281900),
(636, 0, 0xe00374030701000000291900),
(636, 0, 0xe50376030701000000281900),
(636, 0, 0xe60376030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363336272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(636, 0, 0xe70376030701000000281900),
(636, 0, 0xea0374030701000000291900),
(637, 0, 0xdc0372030701000000281900),
(637, 0, 0xd80374030701000000291900),
(637, 0, 0xdb0376030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363337272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(637, 0, 0xdc0376030701000000281900),
(637, 0, 0xde0374030701000000291900),
(638, 0, 0xf90372030701000000281900),
(638, 0, 0xf60374030701000000291900),
(638, 0, 0xf90376030701000000281900),
(638, 0, 0xfc0374030701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363338272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(639, 0, 0xfb036a030701000000281900),
(639, 0, 0xfb036e030701000000281900),
(639, 0, 0xfc036c030701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363339272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203630303020676f6c6420636f696e732e00),
(639, 0, 0xfc036d030701000000291900),
(640, 0, 0xf90363030701000000281900),
(640, 0, 0xf80364030702000000a22200810900),
(640, 0, 0xf80365030701000000ea1c00),
(640, 0, 0xf80366030701000000a52200),
(640, 0, 0xf90364030702000000a22200a22200),
(640, 0, 0xf903650307010000009f0900),
(640, 0, 0xf90367030701000000281900),
(640, 0, 0xfa0364030701000000a12200),
(640, 0, 0xfa0365030701000000560900),
(640, 0, 0xfa03660307010000005e0900),
(640, 0, 0xfb0364030701000000800f00),
(640, 0, 0xfb0365030701000000500800),
(640, 0, 0xfc0365030701000000ba048001000b006465736372697074696f6e014200000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363430272e204974732048696d206f776e73207468697320686f7573652e00),
(640, 0, 0xfc0366030701000000291900),
(641, 0, 0xf9035b030701000000281900),
(641, 0, 0xf8035c03060200000003090f010062080f0100),
(641, 0, 0xf8035d03060200000003090f010062080f0100),
(641, 0, 0xf8035e03060200000003090f010062080f0100),
(641, 0, 0xf8035f03060200000003090f010062080f0100),
(641, 0, 0xf9035c03060200000003090f010062080f0100),
(641, 0, 0xf9035d03060200000003090f010062080f0100),
(641, 0, 0xf9035e03060200000003090f010062080f0100),
(641, 0, 0xf9035f03060200000003090f010062080f0100),
(641, 0, 0xfa035c03060200000003090f010062080f0100),
(641, 0, 0xfa035d03060200000003090f010062080f0100),
(641, 0, 0xfa035f03060200000003090f010062080f0100),
(641, 0, 0xfb035c03060200000003090f010062080f0100),
(641, 0, 0xfb035d03060200000003090f010062080f0110ffffffff00),
(641, 0, 0xfb035e03060200000003090f010062080f0100),
(641, 0, 0xfb035f03060200000003090f010062080f0100),
(641, 0, 0xf8035c030701000000252d00),
(641, 0, 0xf8035d030701000000222d00),
(641, 0, 0xf8035e030702000000f82c00f2090f6400),
(641, 0, 0xf8035f03070100000044098001000b0061747461636b737065656402b602000000),
(641, 0, 0xf9035c0307020000001d2d00650a00),
(641, 0, 0xf9035d030701000000650900),
(641, 0, 0xf9035e030703000000d01e00b92c00a42200),
(641, 0, 0xf9035f030701000000d4098001000b0061747461636b7370656564025302000000),
(641, 0, 0xfa035c030701000000da1e00),
(641, 0, 0xfa035d030702000000520a00202d00),
(641, 0, 0xfa035e030701000000a42200),
(641, 0, 0xfa035f030701000000cf07171100000003090f640003090f640003090f6410ffffffff0003090f640003090f6410ffffffff0003090f640003090f6410ffffffff0003090f6410ffffffff0003090f640003090f6410ffffffff0003090f6410ffffffff0003090f6410ffffffff0003090f640003090f640003090f6410ffffffff0003090f6410ffffffff0003090f090000),
(641, 0, 0xfb035c030702000000520900af0900),
(641, 0, 0xfb035d030701000000d60900),
(641, 0, 0xfb035e030701000000b90900),
(641, 0, 0xfb035f030701000000b80900),
(641, 0, 0xfc035d030701000000291900),
(641, 0, 0xfc035e030701000000ba048001000b006465736372697074696f6e014a00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363431272e204b6f7574756b6120546575204b6f75206f776e73207468697320686f7573652e00),
(641, 0, 0xf90360030701000000281900),
(644, 0, 0xd0038e030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363434272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343830303020676f6c6420636f696e732e00),
(644, 0, 0xd2038e030701000000281900),
(644, 0, 0xcc0392030701000000291900),
(644, 0, 0xd40392030701000000291900),
(644, 0, 0xd20396030701000000281900),
(644, 0, 0xd30394030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(644, 0, 0xd30395030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(645, 0, 0xcc0394030601000000291900),
(645, 0, 0xcf0395030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363435272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333430303020676f6c6420636f696e732e00),
(645, 0, 0xd20395030601000000281900),
(645, 0, 0xd40394030601000000291900),
(646, 0, 0x060472030701000000281900),
(646, 0, 0x080473030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(646, 0, 0x030474030701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363436272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313430303020676f6c6420636f696e732e00),
(646, 0, 0x030475030701000000291900),
(646, 0, 0x060476030701000000281900),
(646, 0, 0x080474030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(646, 0, 0x090475030701000000291900),
(647, 0, 0x03046e030701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363437272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(647, 0, 0x06046c030701000000281900),
(647, 0, 0x060470030701000000281900),
(648, 0, 0x060466030701000000281900),
(648, 0, 0x030468030701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363438272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(648, 0, 0x030469030701000000291900),
(648, 0, 0x06046a030701000000281900),
(648, 0, 0x090469030701000000291900),
(649, 0, 0x030462030701000000ba048001000b006465736372697074696f6e014200000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363439272e2058696d62696361206f776e73207468697320686f7573652e00),
(649, 0, 0x0404610307010000009d0600),
(649, 0, 0x0404620307010000009d0600),
(649, 0, 0x0404630307010000009d0600),
(649, 0, 0x0504610307010000009d0600),
(649, 0, 0x0504630307010000009d0600),
(649, 0, 0x060460030701000000281900),
(649, 0, 0x0604610307010000009d0600),
(649, 0, 0x060462030701000000520900),
(649, 0, 0x0604630307010000009d0600),
(649, 0, 0x0704610307010000009d0600),
(649, 0, 0x070462030701000000c42c0f1800),
(649, 0, 0x0704630307010000009d0600),
(649, 0, 0x0804610307010000009d0600),
(649, 0, 0x0804620307010000009d0600),
(649, 0, 0x0804630307010000009d0600),
(649, 0, 0x060464030701000000281900),
(650, 0, 0x04045b03070200000070080f6400db0900),
(650, 0, 0x05045b03070200000070080f6400c51e00),
(650, 0, 0x06045a030701000000281900),
(650, 0, 0x06045b03070200000070080f64005d0800),
(650, 0, 0x07045b03070200000070080f6400c51e00),
(650, 0, 0x08045b03070200000070080f6400db0900),
(650, 0, 0x03045c030701000000ba048001000b006465736372697074696f6e014000000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363530272e204861646573206f776e73207468697320686f7573652e00),
(650, 0, 0x04045c03070200000070080f6400800900),
(650, 0, 0x04045d03070200000070080f64004b0800),
(650, 0, 0x05045c03070200000070080f6400c42c0f0a00),
(650, 0, 0x05045d03070400000070080f6400f32c00f32c00e42c0f0100),
(650, 0, 0x06045c03070300000070080f640081098001000b0061747461636b7370656564029a02000000c51e00),
(650, 0, 0x06045d03070200000070080f6400db0900),
(650, 0, 0x06045e030701000000281900),
(650, 0, 0x07045c03070200000070080f6400c42c0f0a00),
(650, 0, 0x07045d03070500000070080f6400f32c00f32c00f32c00e42c0f0100),
(650, 0, 0x08045c03070200000070080f6400800900),
(650, 0, 0x08045d03070200000070080f64004b0800),
(650, 0, 0x09045c030701000000291900),
(651, 0, 0x06045a030601000000281900),
(651, 0, 0x03045c030601000000291900),
(651, 0, 0x06045e030601000000281900),
(651, 0, 0x07045c030601000000291900),
(651, 0, 0x07045d030601000000b9048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(652, 0, 0x030462030601000000291900),
(652, 0, 0x060460030601000000281900),
(652, 0, 0x070462030601000000291900),
(652, 0, 0x070463030601000000b9048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363532272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(652, 0, 0x060464030601000000281900),
(653, 0, 0x060466030601000000281900),
(653, 0, 0x030468030601000000291900),
(653, 0, 0x06046a030601000000281900),
(653, 0, 0x070468030601000000291900),
(653, 0, 0x070469030601000000b9048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363533272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(654, 0, 0x03046e030601000000291900),
(654, 0, 0x06046c030601000000281900),
(654, 0, 0x07046e030601000000291900),
(654, 0, 0x07046f030601000000b9048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363534272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(654, 0, 0x060470030601000000281900),
(655, 0, 0x0e0470030701000000281900),
(655, 0, 0x0b0475030701000000291900),
(655, 0, 0x0e0476030701000000281900),
(655, 0, 0x100470030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363535272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e00),
(655, 0, 0x120470030701000000281900),
(655, 0, 0x120476030701000000281900),
(655, 0, 0x140475030701000000291900),
(656, 0, 0x0c046b030601000000b92c00),
(656, 0, 0x0d046b030601000000b92c00),
(656, 0, 0x0e046b030601000000b92c00),
(656, 0, 0x0f046b030601000000b92c00),
(656, 0, 0x0c046b0307020000004509004f0800),
(656, 0, 0x0d046b0307020000005609004f0800),
(656, 0, 0x0e046b03070300000081090056098001000b0061747461636b73706565640269020000004f0800),
(656, 0, 0x0b046c030701000000291900),
(656, 0, 0x0c046c0307010000009f0900),
(656, 0, 0x0d046c0307010000009f0900),
(656, 0, 0x0e046c030701000000271d00),
(656, 0, 0x0e046d030701000000281900),
(656, 0, 0x0f046c030701000000a12200),
(656, 0, 0x10046b030601000000b92c00),
(656, 0, 0x10046a030701000000be048001000b006465736372697074696f6e013f00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363536272e20536f756c206f776e73207468697320686f7573652e00),
(656, 0, 0x11046b030701000000a22200),
(656, 0, 0x12046b030701000000a22200),
(656, 0, 0x13046b030701000000a22200),
(656, 0, 0x10046c030701000000a12200),
(656, 0, 0x11046c030701000000ea1c00),
(656, 0, 0x12046c030701000000ea1c00),
(656, 0, 0x12046d030701000000281900),
(656, 0, 0x13046c030701000000ea1c00),
(656, 0, 0x14046c030701000000291900),
(657, 0, 0x1e046a030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363537272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373630303020676f6c6420636f696e732e00),
(657, 0, 0x1f046a030701000000281900),
(657, 0, 0x19046c030701000000291900),
(657, 0, 0x24046b030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(657, 0, 0x24046c030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(657, 0, 0x25046c030701000000291900),
(658, 0, 0x2f0469030601000000281900),
(658, 0, 0x2f0469030701000000281900),
(658, 0, 0x2a046c030601000000291900),
(658, 0, 0x2a046c030701000000291900),
(658, 0, 0x2f046d030601000000281900),
(658, 0, 0x2f046d030701000000281900),
(658, 0, 0x300469030701000000bc048001000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363538272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031313430303020676f6c6420636f696e732e00),
(658, 0, 0x340469030601000000281900),
(658, 0, 0x340469030701000000281900),
(658, 0, 0x34046e030601000000281900),
(658, 0, 0x36046c030601000000291900),
(658, 0, 0x34046e030701000000281900),
(658, 0, 0x36046c030701000000291900),
(659, 0, 0x3b0469030701000000281900),
(659, 0, 0x38046c030701000000291900),
(659, 0, 0x3b046e030701000000281900),
(659, 0, 0x3d046c030701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363539272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313630303020676f6c6420636f696e732e00),
(660, 0, 0x44046b030701000000291900),
(660, 0, 0x460469030701000000281900),
(660, 0, 0x48046b030701000000291900),
(660, 0, 0x44046d030701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363630272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(662, 0, 0x47045b030701000000281900),
(662, 0, 0x43045f030701000000291900),
(662, 0, 0x48045c030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(662, 0, 0x48045d030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(662, 0, 0x49045f030701000000291900),
(662, 0, 0x450461030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363632272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323330303020676f6c6420636f696e732e00),
(662, 0, 0x470461030701000000281900),
(663, 0, 0xe7034a030601000000291900),
(663, 0, 0xe7034a030701000000291900),
(663, 0, 0xeb034a030601000000291900),
(663, 0, 0xeb034a030701000000291900),
(663, 0, 0xe8034c030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363633272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(664, 0, 0x0b048f030701000000281900),
(664, 0, 0x070493030701000000291900),
(664, 0, 0x08049003070100000003090f6400),
(664, 0, 0x090490030701000000cf071714000000b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c00b92c0000),
(664, 0, 0x090491030701000000cf07170200000003090f0c10ffffffff00b61e8001000b0061747461636b737065656402910200000000),
(664, 0, 0x0e0493030701000000291900),
(664, 0, 0x070494030701000000ba048001000b006465736372697074696f6e014200000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363634272e2054656e2054656e206f776e73207468697320686f7573652e00),
(664, 0, 0x070497030701000000291900),
(664, 0, 0x0d0497030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(664, 0, 0x0e0497030701000000291900),
(664, 0, 0x0b0499030701000000281900),
(664, 0, 0x0d0498030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(665, 0, 0x07049f030701000000291900),
(665, 0, 0x0b049c030701000000281900),
(665, 0, 0x0e049f030701000000291900),
(665, 0, 0x0704a0030701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363635272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333630303020676f6c6420636f696e732e00),
(665, 0, 0x0b04a3030701000000281900),
(667, 0, 0x07049a030601000000291900),
(667, 0, 0x0e049a030601000000291900),
(667, 0, 0x0a049e030601000000281900),
(667, 0, 0x0b049e030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363637272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383430303020676f6c6420636f696e732e00),
(668, 0, 0x14049e0306010000009d0600),
(668, 0, 0x14049f0306020000009d0600810900),
(668, 0, 0x15049d0306020000009d06005e0900),
(668, 0, 0x16049d0306020000009d06005f090f0100),
(668, 0, 0x16049f030601000000c42c0f3e10ffffffff00),
(668, 0, 0x17049d0306010000009d0600),
(668, 0, 0x14049e030701000000a22200),
(668, 0, 0x14049f030701000000a22200),
(668, 0, 0x15049d030701000000a22200),
(668, 0, 0x15049e030701000000a12200),
(668, 0, 0x15049f030701000000500800),
(668, 0, 0x17049c030701000000be048001000b006465736372697074696f6e014900000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363638272e205461796c6f7220546865204f6e65206f776e73207468697320686f7573652e00),
(668, 0, 0x18049d0306010000009d0600),
(668, 0, 0x19049d0306020000009d0600580a00),
(668, 0, 0x1a049e0306020000009d06004b0900),
(668, 0, 0x1a049f0306010000009d0600),
(668, 0, 0x18049c030701000000281900),
(668, 0, 0x1a049e0307010000004e0800),
(668, 0, 0x1a049f030701000000ea1c00),
(668, 0, 0x1b049f030701000000291900),
(668, 0, 0x1404a00306020000009d060081098001000b0061747461636b7370656564027802000000),
(668, 0, 0x1404a10306010000009d0600),
(668, 0, 0x1504a20306020000009d06005e0900),
(668, 0, 0x1604a1030601000000e92c0f0100),
(668, 0, 0x1604a20306020000009d0600f2090f0100),
(668, 0, 0x1704a20306010000009d0600),
(668, 0, 0x1404a0030701000000a22200),
(668, 0, 0x1404a1030701000000a22200),
(668, 0, 0x1504a0030701000000a12200),
(668, 0, 0x1504a1030701000000500800),
(668, 0, 0x1504a2030701000000a22200),
(668, 0, 0x1804a1030601000000ec2c0f0100),
(668, 0, 0x1804a20306020000009d0600da1e00),
(668, 0, 0x1904a20306020000009d0600520900),
(668, 0, 0x1a04a00306020000009d060081098001000b0061747461636b7370656564029a02000000),
(668, 0, 0x1a04a10306020000009d060065098001000b0061747461636b7370656564024c06000000),
(668, 0, 0x1804a3030701000000281900),
(668, 0, 0x1a04a00307010000004e0800),
(668, 0, 0x1a04a1030701000000ea1c00),
(670, 0, 0x1b0492030601000000281900),
(670, 0, 0x190493030701000000291900),
(670, 0, 0x1a0490030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(670, 0, 0x1a0491030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(670, 0, 0x1e0493030701000000291900),
(670, 0, 0x190497030601000000291900),
(670, 0, 0x190497030701000000291900),
(670, 0, 0x1e0497030601000000291900),
(670, 0, 0x1e0497030701000000291900),
(670, 0, 0x1b0499030601000000281900),
(670, 0, 0x1b0499030701000000281900),
(670, 0, 0x1c0499030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363730272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320353330303020676f6c6420636f696e732e00),
(672, 0, 0x200444030701000000de0610ffffffff8001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(672, 0, 0x200445030701000000df0610ffffffff8001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(672, 0, 0x200447030701000000281900),
(672, 0, 0x210447030701000000be048001000b006465736372697074696f6e014900000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363732272e204b616b617368692053656e706169206f776e73207468697320686f7573652e00),
(672, 0, 0x230445030701000000291900),
(674, 0, 0x1f0453030701000000291900),
(674, 0, 0x200451030701000000281900),
(674, 0, 0x210451030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363734272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313830303020676f6c6420636f696e732e00),
(674, 0, 0x230453030701000000291900),
(674, 0, 0x200455030701000000281900),
(678, 0, 0x8f0359040701000000291900),
(678, 0, 0x8f035f040701000000291900),
(678, 0, 0x910354040701000000281900),
(678, 0, 0x930354040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363738272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373230303020676f6c6420636f696e732e00),
(678, 0, 0x950354040701000000281900),
(678, 0, 0x960359040701000000291900),
(678, 0, 0x96035f040701000000291900),
(678, 0, 0x910361040701000000281900),
(678, 0, 0x950361040701000000281900),
(679, 0, 0x92034f040701000000291900),
(679, 0, 0x9a034f040701000000291900),
(679, 0, 0x940350040701000000281900),
(679, 0, 0x970350040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363739272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313430303020676f6c6420636f696e732e00),
(679, 0, 0x990350040701000000281900),
(680, 0, 0x87034f040701000000291900),
(680, 0, 0x8f034f040701000000291900),
(680, 0, 0x890350040701000000281900),
(680, 0, 0x8c0350040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363830272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313430303020676f6c6420636f696e732e00),
(680, 0, 0x8e0350040701000000281900),
(681, 0, 0x9c0354040701000000281900),
(681, 0, 0x9e0354040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363831272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373230303020676f6c6420636f696e732e00),
(681, 0, 0x9a0359040701000000291900),
(681, 0, 0x9a035e040701000000291900),
(681, 0, 0xa00354040701000000281900),
(681, 0, 0xa10359040701000000291900),
(681, 0, 0xa1035e040701000000291900),
(681, 0, 0x9c0361040701000000281900),
(681, 0, 0x9f0361040701000000281900),
(682, 0, 0xa50356040701000000291900),
(682, 0, 0xa80354040701000000281900),
(682, 0, 0xa90356040701000000291900),
(682, 0, 0xa5035a040701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363832272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333630303020676f6c6420636f696e732e00),
(682, 0, 0xa5035e040701000000291900),
(682, 0, 0xa9035e040701000000291900),
(682, 0, 0xa80361040701000000281900),
(683, 0, 0x860365040601000000281900),
(683, 0, 0x850365040701000000281900),
(683, 0, 0x870365040701000000bc048001000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363833272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031363730303020676f6c6420636f696e732e00),
(683, 0, 0x890365040601000000281900),
(683, 0, 0x890365040701000000281900),
(683, 0, 0x830369040601000000291900),
(683, 0, 0x830369040701000000291900),
(683, 0, 0x8b0369040601000000291900),
(683, 0, 0x8b0369040701000000291900),
(683, 0, 0x83036f040601000000291900),
(683, 0, 0x83036f040701000000291900),
(683, 0, 0x8b036f040601000000291900),
(683, 0, 0x8b036f040701000000291900),
(683, 0, 0x850372040601000000281900),
(683, 0, 0x850372040701000000281900),
(683, 0, 0x890372040601000000281900),
(683, 0, 0x890372040701000000281900),
(683, 0, 0x8a0370040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(683, 0, 0x8a0371040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(684, 0, 0x7e0365040701000000281900),
(684, 0, 0x7f0365040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363834272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343730303020676f6c6420636f696e732e00),
(684, 0, 0x7c0369040701000000291900),
(684, 0, 0x7c036f040701000000291900),
(684, 0, 0x7e0372040701000000281900),
(684, 0, 0x800365040701000000281900),
(684, 0, 0x810369040701000000291900),
(684, 0, 0x81036f040701000000291900);
INSERT INTO `tile_store` (`house_id`, `world_id`, `data`) VALUES
(684, 0, 0x800370040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(684, 0, 0x800371040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(684, 0, 0x800372040701000000281900),
(685, 0, 0x740365040701000000281900),
(685, 0, 0x760365040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363835272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393730303020676f6c6420636f696e732e00),
(685, 0, 0x780365040701000000281900),
(685, 0, 0x720369040701000000291900),
(685, 0, 0x78036b040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(685, 0, 0x7a0369040701000000291900),
(685, 0, 0x74036d040701000000281900),
(685, 0, 0x78036c040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(685, 0, 0x78036d040701000000281900),
(686, 0, 0x6f033e040701000000291900),
(686, 0, 0x72033b040701000000281900),
(686, 0, 0x73033e040701000000291900),
(686, 0, 0x710341040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363836272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(686, 0, 0x720341040701000000281900),
(687, 0, 0x78033b040701000000281900),
(687, 0, 0x75033e040701000000291900),
(687, 0, 0x76033c040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(687, 0, 0x76033d040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(687, 0, 0x79033e040701000000291900),
(687, 0, 0x770341040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363837272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313430303020676f6c6420636f696e732e00),
(687, 0, 0x780341040701000000281900),
(688, 0, 0x7e033b040701000000281900),
(688, 0, 0x7b033e040701000000291900),
(688, 0, 0x7c033c040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(688, 0, 0x7c033d040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(688, 0, 0x7f033e040701000000291900),
(688, 0, 0x7d0341040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363838272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313430303020676f6c6420636f696e732e00),
(688, 0, 0x7e0341040701000000281900),
(689, 0, 0x6f0347040701000000291900),
(689, 0, 0x720345040701000000281900),
(689, 0, 0x730347040701000000291900),
(689, 0, 0x710349040701000000bc048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363839272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(689, 0, 0x720349040701000000281900),
(690, 0, 0x750347040701000000291900),
(690, 0, 0x780345040701000000281900),
(690, 0, 0x790347040701000000291900),
(690, 0, 0x770349040701000000bc048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363930272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(690, 0, 0x780349040701000000281900),
(691, 0, 0x7b0347040701000000291900),
(691, 0, 0x7e0345040701000000281900),
(691, 0, 0x7f0347040701000000291900),
(691, 0, 0x7d0349040701000000bc048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363931272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(691, 0, 0x7e0349040701000000281900),
(692, 0, 0x850345040701000000281900),
(692, 0, 0x880345040701000000281900),
(692, 0, 0x830348040701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363932272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323430303020676f6c6420636f696e732e00),
(692, 0, 0x85034a040701000000281900),
(692, 0, 0x88034a040701000000281900),
(692, 0, 0x8a0348040701000000291900),
(693, 0, 0x8e0345040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363933272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(693, 0, 0x8f0345040701000000281900),
(693, 0, 0x8c0348040701000000291900),
(693, 0, 0x8f034a040701000000281900),
(693, 0, 0x900348040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(693, 0, 0x900349040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(693, 0, 0x910348040701000000291900),
(694, 0, 0x8c033b040701000000281900),
(694, 0, 0x8a033e040701000000291900),
(694, 0, 0x8d033e040701000000291900),
(694, 0, 0x8c0341040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363934272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313030303020676f6c6420636f696e732e00),
(695, 0, 0x87033b040701000000281900),
(695, 0, 0x83033e040701000000291900),
(695, 0, 0x88033e040701000000291900),
(695, 0, 0x860341040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363935272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e00),
(695, 0, 0x870341040701000000281900),
(696, 0, 0x6f0333040701000000291900),
(696, 0, 0x6f0335040701000000291900),
(696, 0, 0x700331040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(696, 0, 0x700332040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(696, 0, 0x750330040701000000281900),
(696, 0, 0x7b0330040701000000281900),
(696, 0, 0x7e0331040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(696, 0, 0x7e0332040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(696, 0, 0x7f0333040701000000291900),
(696, 0, 0x750337040701000000281900),
(696, 0, 0x780337040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363936272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383830303020676f6c6420636f696e732e00),
(696, 0, 0x7b0337040701000000281900),
(696, 0, 0x7f0335040701000000291900),
(697, 0, 0x850330040701000000281900),
(697, 0, 0x880330040701000000281900),
(697, 0, 0x880331040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(697, 0, 0x880332040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(697, 0, 0x890333040701000000291900),
(697, 0, 0x830334040701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363937272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323930303020676f6c6420636f696e732e00),
(697, 0, 0x850337040701000000281900),
(697, 0, 0x880337040701000000281900),
(697, 0, 0x890335040701000000291900),
(698, 0, 0x4d041803022e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x4d0419030201000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(698, 0, 0x4d041a030201000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(698, 0, 0x4e041803022e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x4e0419030201000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(698, 0, 0x4e041a030201000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(698, 0, 0x4f0418030201000000281900),
(698, 0, 0x4d041803032e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x4e041803032e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x4f0418030301000000281900),
(698, 0, 0x4e041c030301000000281900),
(698, 0, 0x50041803022e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x51041803022e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x52041803022e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x530418030201000000281900),
(698, 0, 0x50041803032e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x51041803032e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x52041803032e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x530418030301000000281900),
(698, 0, 0x54041803022e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x55041803022e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x56041803022e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x54041803032e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x55041803032e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x560418030301000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363630303020676f6c6420636f696e732e00),
(698, 0, 0x56041b030301000000281900),
(698, 0, 0x57041803032e000000560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700560700),
(698, 0, 0x50041e030201000000281900),
(698, 0, 0x50041e030301000000281900),
(698, 0, 0x53041c030301000000281900),
(699, 0, 0x9d041a030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(699, 0, 0x9d041b030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(699, 0, 0x9f0419030601000000281900),
(699, 0, 0x9c041c030601000000291900),
(699, 0, 0x9f041d030601000000281900),
(699, 0, 0xa6041b030601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023363939272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323630303020676f6c6420636f696e732e00),
(699, 0, 0xa6041c030601000000291900),
(700, 0, 0x9c0422030601000000291900),
(700, 0, 0x9f0423030601000000281900),
(700, 0, 0xa60421030601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373030272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323730303020676f6c6420636f696e732e00),
(700, 0, 0xa60422030601000000291900),
(701, 0, 0x9f0427030601000000281900),
(701, 0, 0x9c042a030601000000291900),
(701, 0, 0x9c042e030601000000291900),
(701, 0, 0x9d042e030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(701, 0, 0x9d042f030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(701, 0, 0xa6042a030601000000291900),
(701, 0, 0xa5042e030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(701, 0, 0xa5042f030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(701, 0, 0xa6042c030601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373031272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(701, 0, 0xa6042e030601000000291900),
(701, 0, 0x9f0430030601000000281900),
(702, 0, 0xad0433030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373032272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(702, 0, 0xae0433030601000000281900),
(702, 0, 0xab0437030601000000291900),
(703, 0, 0xab043b030601000000291900),
(703, 0, 0xac0439030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(703, 0, 0xac043a030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(703, 0, 0xad043c030601000000bc048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373033272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203830303020676f6c6420636f696e732e00),
(703, 0, 0xae043c030601000000281900),
(704, 0, 0xb10433030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373034272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313130303020676f6c6420636f696e732e00),
(704, 0, 0xb20433030601000000281900),
(704, 0, 0xb00436030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(704, 0, 0xb00437030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(705, 0, 0xb50433030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373035272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313130303020676f6c6420636f696e732e00),
(705, 0, 0xb60433030601000000281900),
(705, 0, 0xb40436030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(705, 0, 0xb40437030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(706, 0, 0xb90433030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(706, 0, 0xba0433030601000000281900),
(707, 0, 0xbd0433030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373037272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(707, 0, 0xbf0433030601000000281900),
(707, 0, 0xbf0436030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(707, 0, 0xbf0437030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(707, 0, 0xc00437030601000000291900),
(708, 0, 0xb1043c030601000000bc048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373038272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(708, 0, 0xb2043c030601000000281900),
(709, 0, 0xb5043c030601000000bc048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373039272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(709, 0, 0xb6043c030601000000281900),
(710, 0, 0xb80439030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(710, 0, 0xb8043a030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(710, 0, 0xb9043c030601000000bc048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373130272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203830303020676f6c6420636f696e732e00),
(710, 0, 0xba043c030601000000281900),
(711, 0, 0xbd043c030601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373131272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(711, 0, 0xbf043c030601000000281900),
(711, 0, 0xc0043b030601000000291900),
(712, 0, 0xbf0415030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(712, 0, 0xbf0416030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(712, 0, 0xc10416030601000000291900),
(712, 0, 0xc10418030601000000b9048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373132272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(713, 0, 0xc1041c030601000000291900),
(713, 0, 0xc1041e030601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373133272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313030303020676f6c6420636f696e732e00),
(714, 0, 0xbf0421030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(714, 0, 0xbf0422030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(714, 0, 0xc10423030601000000291900),
(714, 0, 0xc10424030601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373134272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313330303020676f6c6420636f696e732e00),
(715, 0, 0xc1042a030601000000291900),
(715, 0, 0xc0042f030601000000281900),
(715, 0, 0xc1042d030601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373135272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313230303020676f6c6420636f696e732e00),
(715, 0, 0xc1042e030601000000291900),
(716, 0, 0xb8042a030601000000291900),
(716, 0, 0xbc042a030601000000291900),
(716, 0, 0xb8042d030601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373136272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313830303020676f6c6420636f696e732e00),
(716, 0, 0xb8042e030601000000291900),
(716, 0, 0xba042f030601000000281900),
(716, 0, 0xbc042e030601000000291900),
(717, 0, 0xb80423030601000000291900),
(717, 0, 0xbc0423030601000000291900),
(717, 0, 0xb80424030601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373137272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323130303020676f6c6420636f696e732e00),
(718, 0, 0xb8041c030601000000291900),
(718, 0, 0xb8041d030601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373138272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313430303020676f6c6420636f696e732e00),
(718, 0, 0xbb041e030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(718, 0, 0xbb041f030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(718, 0, 0xbc041c030601000000291900),
(719, 0, 0xb80416030601000000291900),
(719, 0, 0xb80417030601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(719, 0, 0xba0414030601000000281900),
(719, 0, 0xbc0416030601000000291900),
(720, 0, 0xaa042a030601000000291900),
(720, 0, 0xad0428030601000000281900),
(720, 0, 0xaa042c030601000000b9048001000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373230272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e00),
(720, 0, 0xaa042e030601000000291900),
(720, 0, 0xad042f030601000000281900),
(720, 0, 0xb30429030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(720, 0, 0xb3042a030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(720, 0, 0xb4042a030601000000291900),
(720, 0, 0xb4042e030601000000291900),
(721, 0, 0xad041f030601000000281900),
(721, 0, 0xaa0422030601000000b9048001000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373231272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303630303020676f6c6420636f696e732e00),
(721, 0, 0xaa0423030601000000291900),
(721, 0, 0xab0424030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(721, 0, 0xab0425030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(721, 0, 0xad0426030601000000281900),
(721, 0, 0xb40423030601000000291900),
(721, 0, 0xb30424030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(721, 0, 0xb30425030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(722, 0, 0xad0416030601000000281900),
(722, 0, 0xaa041a030601000000b9048001000b006465736372697074696f6e015d00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373232272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f7374732031303730303020676f6c6420636f696e732e00),
(722, 0, 0xaa041c030601000000291900),
(722, 0, 0xad041d030601000000281900),
(722, 0, 0xb30417030601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(722, 0, 0xb30418030601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(722, 0, 0xb4041c030601000000291900),
(723, 0, 0x8604f2020601000000291900),
(723, 0, 0x8904f0020601000000281900),
(723, 0, 0x8d04f0020601000000281900),
(723, 0, 0x8f04f2020601000000291900),
(723, 0, 0x8904f4020601000000281900),
(723, 0, 0x8b04f4020601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373233272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323430303020676f6c6420636f696e732e00),
(723, 0, 0x8d04f4020601000000281900),
(724, 0, 0x9204fb020501000000291900),
(724, 0, 0x9204fb020601000000291900),
(724, 0, 0x9604f9020601000000281900),
(724, 0, 0x9904f9020601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373234272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320383930303020676f6c6420636f696e732e00),
(724, 0, 0x9c04f9020601000000281900),
(724, 0, 0x9f04fa020601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(724, 0, 0x9f04fb020601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(724, 0, 0x9604fd020501000000281900),
(724, 0, 0x9604fd020601000000281900),
(724, 0, 0x9c04fd020501000000281900),
(724, 0, 0x9c04fd020601000000281900),
(724, 0, 0xa004fb020501000000291900),
(724, 0, 0xa004fb020601000000291900),
(725, 0, 0x8904e6020501000000281900),
(725, 0, 0x8904e6020601000000281900),
(725, 0, 0x8604e8020501000000291900),
(725, 0, 0x8604e8020601000000291900),
(725, 0, 0x8604ea020601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373235272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363930303020676f6c6420636f696e732e00),
(725, 0, 0x8c04e8020501000000291900),
(725, 0, 0x8c04e8020601000000291900),
(725, 0, 0x8604ed020501000000291900),
(725, 0, 0x8604ed020601000000291900),
(725, 0, 0x8904ee020501000000281900),
(725, 0, 0x8904ee020601000000281900),
(725, 0, 0x8b04ec020601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(725, 0, 0x8b04ed020601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(725, 0, 0x8c04ed020501000000291900),
(725, 0, 0x8c04ed020601000000291900),
(726, 0, 0x9d04e3020501000000281900),
(726, 0, 0x9b04e8020501000000291900),
(726, 0, 0x9b04e8020601000000291900),
(726, 0, 0x9e04e9020501000000281900),
(726, 0, 0x9e04e9020601000000281900),
(726, 0, 0xa004e7020601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373236272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333230303020676f6c6420636f696e732e00),
(726, 0, 0xa004e8020501000000291900),
(726, 0, 0xa004e8020601000000291900),
(727, 0, 0x9d04eb020501000000281900),
(727, 0, 0x9e04eb020601000000281900),
(727, 0, 0x9b04ee020501000000291900),
(727, 0, 0x9b04ee020601000000291900),
(727, 0, 0x9c04ec020601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(727, 0, 0x9c04ed020601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(727, 0, 0xa104ee020501000000291900),
(727, 0, 0xa104ee020601000000291900),
(727, 0, 0x9b04f3020501000000291900),
(727, 0, 0x9b04f3020601000000291900),
(727, 0, 0x9e04f4020501000000281900),
(727, 0, 0x9e04f4020601000000281900),
(727, 0, 0xa104f3020501000000291900),
(727, 0, 0xa104f0020601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373237272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373930303020676f6c6420636f696e732e00),
(727, 0, 0xa104f3020601000000291900),
(728, 0, 0xa704eb020501000000281900),
(728, 0, 0xa704eb020601000000281900),
(728, 0, 0xa504ee020501000000291900),
(728, 0, 0xa504ee020601000000291900),
(728, 0, 0xa804ee020501000000291900),
(728, 0, 0xa804ee020601000000291900),
(728, 0, 0xa504f2020501000000291900),
(728, 0, 0xa504f0020601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373238272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333230303020676f6c6420636f696e732e00),
(728, 0, 0xa504f2020601000000291900),
(728, 0, 0xa804f2020501000000291900),
(728, 0, 0xa804f2020601000000291900),
(728, 0, 0xa704f4020501000000281900),
(728, 0, 0xa704f4020601000000281900),
(729, 0, 0x7b04ed020601000000281900),
(729, 0, 0x7d04ed020601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373239272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e00),
(729, 0, 0x7f04ed020601000000281900),
(729, 0, 0x7f04ee020601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(729, 0, 0x7f04ef020601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(729, 0, 0x7804f0020601000000291900),
(729, 0, 0x7b04f1020601000000281900),
(729, 0, 0x7f04f1020601000000281900),
(729, 0, 0x8004f0020601000000291900),
(730, 0, 0x7b04e5020501000000281900),
(730, 0, 0x7904e7020601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(730, 0, 0x7b04e5020601000000281900),
(730, 0, 0x7f04e5020501000000281900),
(730, 0, 0x7f04e5020601000000281900),
(730, 0, 0x7804e8020501000000291900),
(730, 0, 0x7b04e9020501000000281900),
(730, 0, 0x7804e8020601000000291900),
(730, 0, 0x7904e8020601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(730, 0, 0x7b04e9020601000000281910ffffffff00),
(730, 0, 0x7f04e9020501000000281900),
(730, 0, 0x7d04e9020601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373330272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343130303020676f6c6420636f696e732e00),
(730, 0, 0x7f04e9020601000000281900),
(730, 0, 0x8004e8020501000000291900),
(730, 0, 0x8004e8020601000000291900),
(731, 0, 0x7f04de020601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(731, 0, 0x7f04df020601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(731, 0, 0x8004de020601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(731, 0, 0x8004df020601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(731, 0, 0x8104e0020601000000291900),
(731, 0, 0x8104e1020601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373331272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313630303020676f6c6420636f696e732e00),
(731, 0, 0x8104e2020601000000291900),
(732, 0, 0x8904df020601000000281900),
(732, 0, 0x8f04df020601000000281900),
(732, 0, 0x8604e2020601000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373332272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373930303020676f6c6420636f696e732e00),
(732, 0, 0x8b04e2020601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(732, 0, 0x8b04e3020601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(732, 0, 0x8f04e2020601000000281900),
(732, 0, 0x8904e4020601000000281900),
(732, 0, 0x9604e1020601000000291900),
(733, 0, 0x8904d7020601000000281900),
(733, 0, 0x8f04d7020601000000281900),
(733, 0, 0x8904da020601000000281900),
(733, 0, 0x8d04da020601000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373333272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323230303020676f6c6420636f696e732e00),
(733, 0, 0x8f04da020601000000281900),
(734, 0, 0x8905d8030701000000cd2300),
(735, 0, 0x8c05cd030701000000d02300),
(736, 0, 0x9605cd030701000000d02300),
(737, 0, 0x8505d2030701000000cd2300),
(738, 0, 0x8505c4030701000000cd2300),
(739, 0, 0x7b05c8030701000000d02300),
(740, 0, 0x7c05bf030701000000d02300),
(741, 0, 0x8305b8030701000000d02300),
(742, 0, 0x8c05b1030701000000cd2300),
(743, 0, 0x8805b1030701000000cd2300),
(744, 0, 0x8705ac030701000000cd2300),
(745, 0, 0x8b05ab030701000000cd2300),
(746, 0, 0x00024a040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(746, 0, 0x00024b040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(746, 0, 0x05024b040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373436272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e00),
(747, 0, 0x09024b040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373437272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e00),
(747, 0, 0x0e024a040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(747, 0, 0x0e024b040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(748, 0, 0x090253040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373438272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323130303020676f6c6420636f696e732e00),
(749, 0, 0x050253040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373439272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323130303020676f6c6420636f696e732e00),
(750, 0, 0x0a0259040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(750, 0, 0x0a025a040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(750, 0, 0x0d0260040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373530272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343830303020676f6c6420636f696e732e00),
(751, 0, 0x040259040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(751, 0, 0x04025a040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(751, 0, 0x010260040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343830303020676f6c6420636f696e732e00),
(752, 0, 0x16025e040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373532272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323130303020676f6c6420636f696e732e00),
(753, 0, 0x1f025c040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373533272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323130303020676f6c6420636f696e732e00),
(754, 0, 0x180252040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373534272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323130303020676f6c6420636f696e732e00),
(755, 0, 0x2c024f040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(755, 0, 0x2a0253040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373535272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e00),
(755, 0, 0x2c0250040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(756, 0, 0x1e024c040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373536272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e00),
(756, 0, 0x23024a040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(756, 0, 0x23024b040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(757, 0, 0x2f0248040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373537272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323130303020676f6c6420636f696e732e00),
(758, 0, 0x160237040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(758, 0, 0x170237040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(758, 0, 0x160238040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(758, 0, 0x170238040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(758, 0, 0x1a023c040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373538272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333830303020676f6c6420636f696e732e00),
(759, 0, 0x210237040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(759, 0, 0x220237040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(759, 0, 0x210238040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(759, 0, 0x220238040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(759, 0, 0x25023c040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373539272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333830303020676f6c6420636f696e732e00),
(760, 0, 0x2e023c040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373630272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313630303020676f6c6420636f696e732e00),
(762, 0, 0x090231040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373632272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320343030303020676f6c6420636f696e732e00),
(763, 0, 0x090226040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373633272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(763, 0, 0x100228040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(763, 0, 0x100229040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(763, 0, 0x110228040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(763, 0, 0x110229040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(764, 0, 0x1b0226040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373634272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323830303020676f6c6420636f696e732e00),
(765, 0, 0xf60154040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373635272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323130303020676f6c6420636f696e732e00),
(766, 0, 0xec0156040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373636272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323130303020676f6c6420636f696e732e00),
(767, 0, 0xf0014a040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(767, 0, 0xf0014b040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(767, 0, 0xf5014b040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373637272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e00),
(768, 0, 0xe7014b040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373638272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323130303020676f6c6420636f696e732e00),
(770, 0, 0xf10140040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373730272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e00),
(771, 0, 0xe90140040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373731272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e00),
(772, 0, 0xe60138040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(772, 0, 0xe60139040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(772, 0, 0xe8013c040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373732272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363230303020676f6c6420636f696e732e00),
(773, 0, 0xf0013c040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373733272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e00),
(774, 0, 0xf8013c040701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373734272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363330303020676f6c6420636f696e732e00),
(775, 0, 0xeb012f040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(775, 0, 0xeb0130040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(775, 0, 0xf00130040701000000b9048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023373735272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320323030303020676f6c6420636f696e732e00),
(776, 0, 0x690261020701000000602100),
(777, 0, 0x690266020701000000602100),
(778, 0, 0x720266020701000000602100),
(779, 0, 0x700261020701000000602100),
(780, 0, 0x7602620207010000005d2100),
(781, 0, 0x76025a0207010000005d2100),
(782, 0, 0x7202550207010000005d2100),
(783, 0, 0x7602520207010000005d2100),
(784, 0, 0x6b024c020701000000602100),
(785, 0, 0x60024c020701000000602100),
(786, 0, 0x55024c020701000000602100),
(787, 0, 0x4e024c020701000000602100),
(788, 0, 0x4a02500207010000005d2100),
(789, 0, 0x4a02580207010000005d2100),
(790, 0, 0x4a02610207010000005d2100),
(791, 0, 0x530261020701000000602100),
(792, 0, 0x4e0266020701000000602100),
(793, 0, 0x560266020701000000602100),
(794, 0, 0x4e02570207010000005d2100),
(797, 0, 0xff032b040701000000af0900),
(797, 0, 0xfe032c040701000000d01e8001000b0061747461636b737065656402350c000000),
(797, 0, 0xfe032d040701000000f62c00),
(797, 0, 0xfe032e040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(797, 0, 0xfe032f040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(797, 0, 0xff032c040701000000da1e00),
(797, 0, 0xff032e040701000000202d00),
(797, 0, 0xfe0334040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(797, 0, 0xfe0335040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(797, 0, 0xfe033a040701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(797, 0, 0xfe033b040701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(797, 0, 0x00042a040601000000bd0400),
(797, 0, 0x00042b040701000000212d00),
(797, 0, 0x01042b040701000000ba0400),
(797, 0, 0x070429040701000000be048001000b006465736372697074696f6e013b00000049742062656c6f6e677320746f20686f7573652027474849492023373937272e20436861726c6c6f7465206f776e73207468697320686f7573652e00),
(797, 0, 0x00042c04070200000065090065098001000b0061747461636b737065656402f30d000000),
(797, 0, 0x010431040701000000ba0400),
(797, 0, 0x010437040701000000ba0400),
(798, 0, 0xa5019d030701000000b9048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xb9019d030701000000b9048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xa201a2030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(798, 0, 0xa201a3030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(798, 0, 0xa501a3030701000000b9048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xa501ab030701000000b9048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xaa01ab0307010000001e0a170000000000),
(798, 0, 0xaa01ad0307010000001e0a170000000000),
(798, 0, 0xaa01af0307010000001e0a170000000000),
(798, 0, 0xbc01a2030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(798, 0, 0xbc01a3030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(798, 0, 0xbb01a5030701000000bc048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xbf01a7030701000000b9048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xb401ab030701000000200a170000000000);
INSERT INTO `tile_store` (`house_id`, `world_id`, `data`) VALUES
(798, 0, 0xbb01a9030701000000bc048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xbf01a8030701000000b9048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xb401ad030701000000200a170000000000),
(798, 0, 0xb401af030701000000200a170000000000),
(798, 0, 0xa201b0030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(798, 0, 0xa201b1030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(798, 0, 0xa501b1030701000000b9048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xa501b7030701000000b9048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xaa01b6030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(798, 0, 0xaa01b7030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(798, 0, 0xab01b5030701000000bc048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xb901b1030701000000b9048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xbc01b0030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(798, 0, 0xbc01b1030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(798, 0, 0xb201b6030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(798, 0, 0xb201b7030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(798, 0, 0xb301b5030701000000bc048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(798, 0, 0xb901b7030701000000b9048001000b006465736372697074696f6e015400000049742062656c6f6e677320746f20686f75736520274748492023373938272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203131393730303020676f6c6420636f696e732e00),
(799, 0, 0x4b04dd020601000000291900),
(799, 0, 0x4f04de020501000000291900),
(799, 0, 0x4f04de020601000000291900),
(799, 0, 0x5004de0206010000001e0a170000000000),
(799, 0, 0x5004df020601000000580a00),
(799, 0, 0x5104df020601000000580a00),
(799, 0, 0x5204dc020601000000281900),
(799, 0, 0x5204df020601000000580a00),
(799, 0, 0x5304dd020603000000a22200a22200a22200),
(799, 0, 0x5304de020603000000a12200a12200a12200),
(799, 0, 0x5304df020602000000500800500800),
(799, 0, 0x5404dd020604000000a22200a22200a22200a22200),
(799, 0, 0x5404de020601000000a12200),
(799, 0, 0x5404df020602000000500800500800),
(799, 0, 0x5504dd020604000000a22200a22200a22200a22200),
(799, 0, 0x5504de020601000000a12200),
(799, 0, 0x5504df020602000000500800500800),
(799, 0, 0x5604dd020602000000a22200a22200),
(799, 0, 0x5604de020602000000a12200a12200),
(799, 0, 0x5604df020601000000500800),
(799, 0, 0x5704dd020606000000a22200a22200a22200a22200a22200a22200),
(799, 0, 0x5704de020602000000a12200a12200),
(799, 0, 0x5704df020602000000500800500800),
(799, 0, 0x5b04de020501000000291900),
(799, 0, 0x5804df020601000000580a00),
(799, 0, 0x5904dc020601000000281900),
(799, 0, 0x5904df020601000000580a00),
(799, 0, 0x5a04de020601000000200a170000000000),
(799, 0, 0x5a04df020601000000580a00),
(799, 0, 0x5b04de020601000000291900),
(799, 0, 0x5f04de020501000000291900),
(799, 0, 0x6204de020501000000291900),
(799, 0, 0x4b04e3020601000000291900),
(799, 0, 0x4f04e3020501000000291900),
(799, 0, 0x4f04e3020601000000291900),
(799, 0, 0x4f04e7020501000000291900),
(799, 0, 0x4f04e7020601000000291900),
(799, 0, 0x4f04ea020501000000281900),
(799, 0, 0x4e04eb020601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(799, 0, 0x4f04ea020601000000281900),
(799, 0, 0x4b04ed020601000000291900),
(799, 0, 0x4d04ed020501000000291900),
(799, 0, 0x4f04ee020501000000281900),
(799, 0, 0x4d04ed020601000000291900),
(799, 0, 0x4e04ec020601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(799, 0, 0x4f04ee020601000000281900),
(799, 0, 0x5004e1020501000000b61e00),
(799, 0, 0x5004e30205010000005c0a00),
(799, 0, 0x5204e202050100000081098001000b0061747461636b7370656564025a02000000),
(799, 0, 0x5304e2020501000000810900),
(799, 0, 0x5004e00206010000001e0a170000000000),
(799, 0, 0x5004e10206010000005e0900),
(799, 0, 0x5004e20206010000001e0a170000000000),
(799, 0, 0x5004e3020601000000560900),
(799, 0, 0x5104e10206010000005e0900),
(799, 0, 0x5104e3020602000000560900560900),
(799, 0, 0x5204e10206010000005e0900),
(799, 0, 0x5204e3020601000000560900),
(799, 0, 0x5304e10206030000004e08004e08004e0800),
(799, 0, 0x5304e2020601000000ea1c00),
(799, 0, 0x5304e3020601000000b92c00),
(799, 0, 0x5404e2020501000000810900),
(799, 0, 0x5504e2020501000000810900),
(799, 0, 0x5604e202050100000081098001000b0061747461636b7370656564020302000000),
(799, 0, 0x5604e30205010000005a08800100070063686172676573020100000000),
(799, 0, 0x5704e2020501000000810900),
(799, 0, 0x5404e10206010000004e0800),
(799, 0, 0x5404e2020603000000ea1c00ea1c00ea1c00),
(799, 0, 0x5404e3020601000000b92c00),
(799, 0, 0x5504e10206010000004e0800),
(799, 0, 0x5504e2020602000000ea1c00ea1c00),
(799, 0, 0x5504e3020601000000b92c00),
(799, 0, 0x5604e10206020000004e08004e0800),
(799, 0, 0x5604e2020602000000ea1c00ea1c00),
(799, 0, 0x5604e3020601000000b92c00),
(799, 0, 0x5704e10206020000004e08004e0800),
(799, 0, 0x5704e2020603000000ea1c00ea1c00ea1c00),
(799, 0, 0x5704e3020601000000b92c00),
(799, 0, 0x5804e202050100000081098001000b0061747461636b7370656564024502000000),
(799, 0, 0x5904e2020501000000810900),
(799, 0, 0x5b04e3020501000000291900),
(799, 0, 0x5804e10206010000005e0900),
(799, 0, 0x5804e3020602000000560900560900),
(799, 0, 0x5904e10206040000005e09005e09005e09005e0900),
(799, 0, 0x5904e3020602000000560900560900),
(799, 0, 0x5a04e0020601000000200a170000000000),
(799, 0, 0x5a04e10206010000005e0900),
(799, 0, 0x5a04e2020601000000200a170000000000),
(799, 0, 0x5a04e3020601000000560900),
(799, 0, 0x5b04e3020601000000291900),
(799, 0, 0x5004e4020502000000a22200a22200),
(799, 0, 0x5004e50205010000004d0800),
(799, 0, 0x5004e6020501000000b92c00),
(799, 0, 0x5004e7020501000000af0900),
(799, 0, 0x5104e4020505000000a22200a22200a22200a22200a22200),
(799, 0, 0x5104e7020501000000af0900),
(799, 0, 0x5204e4020504000000a22200a22200a22200a22200),
(799, 0, 0x5304e4020505000000a22200a22200a22200a22200a22200),
(799, 0, 0x5004e40206010000001e0a170000000000),
(799, 0, 0x5004e502060100000081098001000b0061747461636b7370656564023e02000000),
(799, 0, 0x5004e60206010000001e0a170000000000),
(799, 0, 0x5104e5020601000000810900),
(799, 0, 0x5204e5020602000000810900810900),
(799, 0, 0x5404e4020501000000a22200),
(799, 0, 0x5504e4020501000000ee2c00),
(799, 0, 0x5504e5020501000000cd07170000000000),
(799, 0, 0x5804e4020501000000e62c00),
(799, 0, 0x5804e6020501000000c72c00),
(799, 0, 0x5904e4020501000000e62c00),
(799, 0, 0x5904e6020501000000c72c00),
(799, 0, 0x5a04e4020501000000e62c00),
(799, 0, 0x5a04e6020501000000c72c00),
(799, 0, 0x5b04e7020501000000291900),
(799, 0, 0x5804e5020601000000810900),
(799, 0, 0x5904e5020601000000810900),
(799, 0, 0x5a04e4020601000000200a170000000000),
(799, 0, 0x5a04e5020601000000810900),
(799, 0, 0x5a04e6020601000000200a170000000000),
(799, 0, 0x5b04e7020601000000291900),
(799, 0, 0x5f04e7020501000000291910ffffffff00),
(799, 0, 0x5004eb020601000000af0900),
(799, 0, 0x5204e8020601000000281900),
(799, 0, 0x5a04eb020501000000e92c0f0100),
(799, 0, 0x5b04ea020501000000281900),
(799, 0, 0x5904e8020601000000281900),
(799, 0, 0x5a04eb020601000000eb2c0f0100),
(799, 0, 0x5b04ea020601000000281900),
(799, 0, 0x5c04eb020601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(799, 0, 0x5104ed020501000000291900),
(799, 0, 0x5004ec020601000000ea1c00),
(799, 0, 0x5004ed02060100000061080f6400),
(799, 0, 0x5104ec020601000000bb048001000b006465736372697074696f6e014000000049742062656c6f6e677320746f20686f75736520274748492023373939272e20416c756320436164656972616e7465206f776e73207468697320686f7573652e00),
(799, 0, 0x5104ed020601000000291900),
(799, 0, 0x5904ed020501000000291900),
(799, 0, 0x5b04ee020501000000281900),
(799, 0, 0x5904ec020601000000bb048001000b006465736372697074696f6e014000000049742062656c6f6e677320746f20686f75736520274748492023373939272e20416c756320436164656972616e7465206f776e73207468697320686f7573652e00),
(799, 0, 0x5904ed020601000000291900),
(799, 0, 0x5b04ee020601000000281900),
(799, 0, 0x5c04ec020501000000ec2c0f0100),
(799, 0, 0x5d04ed020501000000291900),
(799, 0, 0x5f04ec020501000000291900),
(799, 0, 0x5c04ec020601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(799, 0, 0x5d04ed020601000000291900),
(799, 0, 0x6204e7020501000000291900),
(799, 0, 0x6204eb020601000000291900),
(799, 0, 0x6504ec020601000000291900),
(799, 0, 0x6504ee020601000000bb048001000b006465736372697074696f6e014000000049742062656c6f6e677320746f20686f75736520274748492023373939272e20416c756320436164656972616e7465206f776e73207468697320686f7573652e00),
(799, 0, 0x4d04f3020501000000291900),
(799, 0, 0x4f04f0020501000000281900),
(799, 0, 0x4d04f3020601000000291900),
(799, 0, 0x4e04f1020601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(799, 0, 0x4e04f2020601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(799, 0, 0x4f04f0020601000000281900),
(799, 0, 0x4d04f7020501000000291900),
(799, 0, 0x4f04f4020501000000281900),
(799, 0, 0x4f04f6020501000000281900),
(799, 0, 0x4d04f7020601000000291900),
(799, 0, 0x4f04f4020601000000281900),
(799, 0, 0x4f04f6020601000000281900),
(799, 0, 0x4f04f9020501000000281900),
(799, 0, 0x5104f3020501000000291900),
(799, 0, 0x5104f2020601000000b9048001000b006465736372697074696f6e014000000049742062656c6f6e677320746f20686f75736520274748492023373939272e20416c756320436164656972616e7465206f776e73207468697320686f7573652e00),
(799, 0, 0x5104f3020601000000291900),
(799, 0, 0x5904f3020501000000291900),
(799, 0, 0x5b04f0020501000000281900),
(799, 0, 0x5904f2020601000000b9048001000b006465736372697074696f6e014000000049742062656c6f6e677320746f20686f75736520274748492023373939272e20416c756320436164656972616e7465206f776e73207468697320686f7573652e00),
(799, 0, 0x5904f3020601000000291900),
(799, 0, 0x5b04f0020601000000281900),
(799, 0, 0x5d04f3020501000000291900),
(799, 0, 0x5f04f0020501000000291900),
(799, 0, 0x5c04f1020601000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(799, 0, 0x5c04f2020601000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(799, 0, 0x5d04f3020601000000291900),
(799, 0, 0x5104f7020501000000291900),
(799, 0, 0x5104f7020601000000291900),
(799, 0, 0x5904f7020501000000291900),
(799, 0, 0x5b04f4020501000000281900),
(799, 0, 0x5b04f6020501000000281900),
(799, 0, 0x5904f7020601000000291900),
(799, 0, 0x5b04f4020601000000281900),
(799, 0, 0x5b04f6020601000000281900),
(799, 0, 0x5d04f7020501000000291900),
(799, 0, 0x5d04f7020601000000291900),
(799, 0, 0x5104f8020601000000b9048001000b006465736372697074696f6e014000000049742062656c6f6e677320746f20686f75736520274748492023373939272e20416c756320436164656972616e7465206f776e73207468697320686f7573652e00),
(799, 0, 0x5904f8020601000000b9048001000b006465736372697074696f6e014000000049742062656c6f6e677320746f20686f75736520274748492023373939272e20416c756320436164656972616e7465206f776e73207468697320686f7573652e00),
(799, 0, 0x6104f2020501000000281900),
(799, 0, 0x6204f2020501000000281900),
(799, 0, 0x6204f1020601000000291900),
(803, 0, 0x9b01570507010000005e218001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383033272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(804, 0, 0x9b015d0507010000005e218001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383034272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(805, 0, 0x99016305070100000061218001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383035272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(806, 0, 0xa0016305070100000061218001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383036272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(807, 0, 0xb1015d0507010000005e218001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383037272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(808, 0, 0xb101570507010000005e218001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383038272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(809, 0, 0x8d016c05070100000061218001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383039272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(810, 0, 0x8c01720507010000005e218001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383130272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(811, 0, 0x9f01720507010000005e218001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383131272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(812, 0, 0xb5017105070100000061218001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383132272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(813, 0, 0x1e058704070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383133272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(813, 0, 0x1f0587040701000000bd0400),
(814, 0, 0x24058704070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383134272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(814, 0, 0x250587040701000000bd0400),
(814, 0, 0x26058504070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383134272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(815, 0, 0x2a058704070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383135272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(815, 0, 0x2b0587040701000000bd0400),
(815, 0, 0x2c058504070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383135272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(816, 0, 0x7904bb03070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7e04ba03070100000003090f0100),
(816, 0, 0x7e04bb03070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7f04ba03070100000003090f6400),
(816, 0, 0x7904bc030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7904bd030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7904be030703000000f0090f0a00eb2c0f010081098001000b0061747461636b737065656402e501000000),
(816, 0, 0x7904bf030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7a04bd0307020000009d0600eb2c0f0100),
(816, 0, 0x7a04be0307010000009d0600),
(816, 0, 0x7a04bf0307010000009d0600),
(816, 0, 0x7b04bc0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7b04bd0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7b04be0307030000005f090f0110ffffffff00f2090f0100eb2c0f0100),
(816, 0, 0x7b04bf0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7c04be03070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7c04bf03070100000061080f6400),
(816, 0, 0x7d04bc030701000000e60610ffffffff8002000a00736c656570737461727402346349600b006465736372697074696f6e011d0000005472656d626f6c6f6e6120697320736c656570696e672074686572652e149416000000),
(816, 0, 0x7d04bd030701000000e70610ffffffff8002000a00736c656570737461727402346349600b006465736372697074696f6e011d0000005472656d626f6c6f6e6120697320736c656570696e672074686572652e149416000000),
(816, 0, 0x7d04bf03070100000061080f6400),
(816, 0, 0x7e04be03070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7f04bd030701000000ba048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7f04bf03070100000068080f3400),
(816, 0, 0x8004ba03070100000003090f6400),
(816, 0, 0x8004bb0307040000005f090f0100f2090f0100eb2c0f010003090f6400),
(816, 0, 0x8104ba03070100000003090f6400),
(816, 0, 0x8104bb0307040000005f090f0100f2090f0100eb2c0f0100c3071703000000cf0717030000005a0880010007006368617267657302010000000003090f430003090f3310ffffffff000068080f470064080f120000),
(816, 0, 0x8204ba030701000000910900),
(816, 0, 0x8204bb0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8304ba03070100000003090f6400),
(816, 0, 0x8604bb03070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8a04bb03070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8004bc03070200000003090f640052098001000b0061747461636b737065656402ea01000000),
(816, 0, 0x8004be030701000000cf071703000000cf071701000000d1071702000000d1071701000000d1071701000000d1071701000000cf071702000000cf071701000000cf071701000000cf071701000000cf071701000000cf071700000000000000000061080f6300000000009d06000000eb2c0f2410ffffffff00d1071702000000cf07170000000000e92c0f01000000),
(816, 0, 0x8004bf030701000000de1e8001000b0061747461636b737065656402ca02000000),
(816, 0, 0x8104bc0307040000005f090f0100f2090f0100eb2c0f010003090f6400),
(816, 0, 0x8104bd0307050000005f090f0100f2090f0100eb2c0f010003090f640064080f0a00),
(816, 0, 0x8104be0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104bf0307040000005f090f0100f2090f0100eb2c0f0100a22200),
(816, 0, 0x8204be030701000000c307170600000091090061080f370060080f550003090f010068080f5c0064080f280000),
(816, 0, 0x8204bf030703000000650900de1e8001000b0061747461636b737065656402050d00000070080f1600),
(816, 0, 0x8304be030701000000291910ffffffff8001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8404bc030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8404bd030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8504be030705000000b92c00b92c00b92c00b92c00b92c00),
(816, 0, 0x8604bc0307010000009f0900),
(816, 0, 0x8604be030702000000b92c00202d00),
(816, 0, 0x8604bf030701000000281910ffffffff8001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8704be030701000000ea1c00),
(816, 0, 0x8804bc03070100000068080f1300),
(816, 0, 0x8804be030701000000ea1c00),
(816, 0, 0x8804bf030701000000bd048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8904bc030701000000a12200),
(816, 0, 0x8904be030701000000ea1c00),
(816, 0, 0x8a04be030701000000b92c00),
(816, 0, 0x8a04bf030701000000281910ffffffff8001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8b04be030702000000b92c00b92c00),
(816, 0, 0x8f04be030501000000291910ffffffff8001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8f04be03060100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8c04bc030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8c04bd030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8d04be03070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8f04be03070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x9104bc03050100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x9504bc03050100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0xae04bd03060100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0xae04bd03070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0xb004bb03050100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0xb004bb03060100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0xb004bb03070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0xb004bf03050100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0xb204bd030501000000291910ffffffff8001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0xb004bf03060100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0xb204bd03060100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0xb004bf03070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0xb204bd030701000000ba048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7904c0030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7904c1030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7904c2030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7a04c00307010000009d0600),
(816, 0, 0x7a04c10307010000009d0600),
(816, 0, 0x7a04c20307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7b04c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7b04c10307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7b04c20307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7c04c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7d04c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7d04c2030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x7d04c3030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x7e04c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7e04c103070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7e04c2030701000000530a00),
(816, 0, 0x7e04c3030701000000b92c00),
(816, 0, 0x7f04c00307040000005f090f0100f2090f0100eb2c0f0100cf07170600000011098001000b0061747461636b7370656564023e04000000a90900da1e8001000b0061747461636b737065656402230800000052098001000b0061747461636b737065656402010300000068080f5e0064080f460000),
(816, 0, 0x7f04c3030701000000ba048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7004c6030701000000291910ffffffff8001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7004c7030701000000ba048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7104c60307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7104c7030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7204c6030702000000f0090f0100eb2c0f0100),
(816, 0, 0x7204c70307030000005f090f0100f2090f0110ffffffff00eb2c0f0100),
(816, 0, 0x7304c60307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7304c7030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7404c6030702000000f0090f0100eb2c0f0100),
(816, 0, 0x7404c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7504c60307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7504c7030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7604c6030702000000f0090f0100eb2c0f0100),
(816, 0, 0x7604c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7704c60307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7704c7030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7804c6030702000000f0090f0100eb2c0f0100),
(816, 0, 0x7804c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7904c6030702000000f0090f0c00eb2c0f0100),
(816, 0, 0x7904c7030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7a04c60307020000005f090f0100f2090f0110ffffffff00),
(816, 0, 0x7a04c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7b04c5030701000000eb2c0f0100),
(816, 0, 0x7b04c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7c04c403070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7c04c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7d04c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7e04c503070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7e04c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7f04c403070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7f04c6030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7f04c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7004c8030701000000291910ffffffff8001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7104c80307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7204c8030702000000f0090f0100eb2c0f0100),
(816, 0, 0x7304c80307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7404c8030702000000f0090f0100eb2c0f0100),
(816, 0, 0x7504c80307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7604c8030702000000f0090f0100eb2c0f0100),
(816, 0, 0x7604cb030706000000f2090f6410ffffffff00f2090f6410ffffffff00f2090f6410ffffffff00f2090f64005f090f2b00f2090f0100),
(816, 0, 0x7704c80307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7704cb030708000000f2090f6410ffffffff00f2090f6410ffffffff00f2090f6410ffffffff00f2090f6410ffffffff00f2090f6410ffffffff00f2090f6410ffffffff005f090f0100f2090f0100),
(816, 0, 0x7804c8030702000000f0090f0100eb2c0f0100),
(816, 0, 0x7804cb0307020000005f090f0100f2090f0200),
(816, 0, 0x7904c8030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7904cb03070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7a04c80307020000005f090f0100f2090f0100),
(816, 0, 0x7b04c9030701000000eb2c0f0100),
(816, 0, 0x7d04ca030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x7d04cb030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x7e04c903070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7f04c8030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x7f04cb030701000000ba048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7204cc0307010000001e0a170000000000),
(816, 0, 0x7204ce0307010000001e0a170000000000),
(816, 0, 0x7504cc0307020000005f090f6300f2090f0100),
(816, 0, 0x7504ce0307020000005f090f6400f2090f0100),
(816, 0, 0x7804cc0307010000005f090f0100),
(816, 0, 0x7804cd0307020000005f090f0100f2090f0100),
(816, 0, 0x7804ce0307020000005f090f0100f2090f0100),
(816, 0, 0x7804cf0307020000005f090f0110ffffffff00f2090f0100),
(816, 0, 0x7904cc030703000000b92c00b92c00212d00),
(816, 0, 0x7904cd030703000000a90900d60900af0900),
(816, 0, 0x7904ce030701000000ac0900),
(816, 0, 0x7904cf030701000000232d00),
(816, 0, 0x7a04cc0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7a04ce030702000000f0090f0a10ffffffff00eb2c0f0100),
(816, 0, 0x7b04cc0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7b04cd0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7b04ce0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7b04cf0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7c04cc03070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7c04ce0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7d04ce0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7e04cd03070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7e04ce0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7e04cf03070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7f04cc03070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7f04ce0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7204d00307010000001e0a170000000000),
(816, 0, 0x7204d20307010000001e0a170000000000),
(816, 0, 0x7504d00307020000005f090f0b00f2090f1210ffffffff00),
(816, 0, 0x7504d20307020000005f090f0100f2090f0100),
(816, 0, 0x7604d30307020000005f090f0100f2090f0100),
(816, 0, 0x7704d30307020000005f090f0100f2090f0100),
(816, 0, 0x7804d00307020000005f090f0100f2090f0100),
(816, 0, 0x7804d10307020000005f090f0100f2090f0100),
(816, 0, 0x7804d20307020000005f090f0100f2090f0100),
(816, 0, 0x7904d0030701000000b92c00),
(816, 0, 0x7904d203070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7a04d00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7b04d00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x7c04d203070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7d04d0030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x7d04d1030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x7f04d1030701000000ba048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x7f04d203070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8004c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8004c1030701000000da1e00),
(816, 0, 0x8004c2030701000000cf071704000000d107170100000003090f640000d1071703000000d10717000000000061080f270003090f01000064080f270068080f1110ffffffff0000),
(816, 0, 0x8104c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104c10307040000005f090f0100f2090f0100eb2c0f0100b92c00),
(816, 0, 0x8104c20307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104c30307040000005f090f0100f2090f0100eb2c0f0100b92c00),
(816, 0, 0x8204c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8204c1030703000000da1e8001000b0061747461636b7370656564028813000000da1e00650900),
(816, 0, 0x8304c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8404c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8404c2030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8404c3030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8504c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8504c103070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8504c2030701000000b92c00),
(816, 0, 0x8504c3030701000000b92c00),
(816, 0, 0x8604c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8604c3030701000000ba048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8704c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8704c20307040000005f090f0100f2090f0100eb2c0f010052098001000b0061747461636b7370656564021902000000),
(816, 0, 0x8804c0030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x8804c10307040000005f090f0100f2090f0100eb2c0f0100520900),
(816, 0, 0x8804c20307040000005f090f0100f2090f0100eb2c0f0100d01e00),
(816, 0, 0x8804c30307030000005f090f0100f2090f0100eb2c0f0110ffffffff00),
(816, 0, 0x8904c00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8904c20307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8a04c00307020000005f090f0100f2090f0100),
(816, 0, 0x8a04c3030701000000ba048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8b04c00307020000005f090f0100f2090f0100),
(816, 0, 0x8b04c2030701000000b92c00),
(816, 0, 0x8b04c3030701000000b92c00),
(816, 0, 0x8c04c00307020000005f090f0100f2090f0100),
(816, 0, 0x8c04c103070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8c04c2030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8c04c3030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8d04c00307020000005f090f0100f2090f0100),
(816, 0, 0x8004c5030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x8004c60307030000009d0600910900af0900),
(816, 0, 0x8004c70307030000009d0600f2090f010062080f0100),
(816, 0, 0x8104c40307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104c50307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104c60307030000009d0600f62c005c0a00),
(816, 0, 0x8104c70307010000009d0600),
(816, 0, 0x8204c5030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x8204c60307020000009d0600252d00),
(816, 0, 0x8204c70307030000009d0600f2090f010062080f0100),
(816, 0, 0x8304c403070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8304c6030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x8304c70307040000005f090f0100f2090f0100eb2c0f01009f0900),
(816, 0, 0x8404c4030701000000b92c00),
(816, 0, 0x8404c6030704000000222d00222d001d2d001d2d00),
(816, 0, 0x8404c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8504c4030701000000b92c00),
(816, 0, 0x8504c503070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8504c6030704000000262d00252d00252d00252d00),
(816, 0, 0x8504c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8604c4030701000000291910ffffffff8001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8604c60307010000009f0900),
(816, 0, 0x8604c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8704c50307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8704c6030701000000800f00),
(816, 0, 0x8704c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8804c40307040000005f090f0100f2090f0100eb2c0f01005c098001000b0061747461636b737065656402e204000000),
(816, 0, 0x8804c50307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8804c60307030000009d0600910900af0900),
(816, 0, 0x8804c70307020000009d0600a12200),
(816, 0, 0x8904c50307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8904c60307010000009d0600),
(816, 0, 0x8904c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8a04c403070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8a04c6030703000000650a00650a00650a00),
(816, 0, 0x8a04c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8b04c4030701000000b92c00),
(816, 0, 0x8b04c6030701000000a12200),
(816, 0, 0x8b04c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8c04c4030701000000b92c00),
(816, 0, 0x8c04c503070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8c04c6030701000000ac0900),
(816, 0, 0x8c04c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8d04c403070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8d04c60307010000005d0a00),
(816, 0, 0x8d04c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8e04c50307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8e04c6030702000000be0900be0900),
(816, 0, 0x8e04c70307030000005f090f0100f2090f0110ffffffff00eb2c0f0100),
(816, 0, 0x8f04c50307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8f04c60307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8f04c70307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8004c8030701000000ec2c0f0100),
(816, 0, 0x8004c9030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x8104c80307010000009d0600),
(816, 0, 0x8104c90307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104ca0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104cb0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8204c8030701000000ec2c0f0100),
(816, 0, 0x8204c9030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x8304c8030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x8404c8030704000000242d00242d001f2d00202d00),
(816, 0, 0x8404ca030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8404cb030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8504c8030702000000272d00282d00),
(816, 0, 0x8504c903070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8604c8030701000000520a00),
(816, 0, 0x8604cb030701000000ba048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8704c8030701000000ea1c00),
(816, 0, 0x8704c90307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8804c80307030000009d0600b92c00b92c00),
(816, 0, 0x8804c90307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8804ca0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8804cb0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8904c8030701000000a52200),
(816, 0, 0x8904c90307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8a04c8030701000000dd0900),
(816, 0, 0x8a04cb030701000000ba048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8b04c80307020000001f2d00f92c00),
(816, 0, 0x8c04c903070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8c04ca030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8c04cb030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8e04c8030701000000211d00),
(816, 0, 0x8e04c90307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8f04c80307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8f04c90307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8004ce0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104cc0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104cd0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104ce0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104cf0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8304cc03070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8504cd03070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8504cf03070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8604cc03070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8804cc0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8804cd0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8804ce0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8804cf0307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8a04cc03070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8c04cd03070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8c04cf03070100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8d04cc03070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8f04cc0307020000005f090f0100f2090f0100),
(816, 0, 0x9104c003050100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x9104c003060100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x9004c10307020000005f090f0100f2090f0100),
(816, 0, 0x9004c20307020000005f090f0100f2090f0100),
(816, 0, 0x9104c1030701000000f0090f0a00),
(816, 0, 0x9104c20307020000005f090f0100f2090f0100),
(816, 0, 0x9204c1030701000000f0090f0a00),
(816, 0, 0x9204c20307020000005f090f0100f2090f0100),
(816, 0, 0x9204c30307020000005f090f0100f2090f0100),
(816, 0, 0x9304c1030701000000f0090f0a00),
(816, 0, 0x9304c20307020000005f090f0100f2090f0100),
(816, 0, 0x9504c003050100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x9504c003060100000028198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x9404c10307020000005f090f0100f2090f0100),
(816, 0, 0x9404c20307020000005f090f0100f2090f0100),
(816, 0, 0x9504c0030701000000281910ffffffff8001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x9004c70307020000005f090f0100f2090f0100),
(816, 0, 0x9104c70307020000005f090f0100f2090f0100),
(816, 0, 0x9204c40307020000005f090f0100f2090f0100),
(816, 0, 0x9204c50307020000005f090f0100f2090f0100),
(816, 0, 0x9204c60307020000005f090f0100f2090f0100),
(816, 0, 0x9204c70307020000005f090f0100f2090f0100),
(816, 0, 0x9304c70307010000001d2d00),
(816, 0, 0x9004c80307020000005f090f0100f2090f0100),
(816, 0, 0x9004c90307020000005f090f0100f2090f0100),
(816, 0, 0x9004ca0307020000005f090f0100f2090f0100),
(816, 0, 0x9004cb0307020000005f090f0100f2090f0100),
(816, 0, 0x9504c9030701000000281910ffffffff8001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x9004cc030701000000f0090f0a00),
(816, 0, 0x9104cc0307020000005f090f0100f2090f0100),
(816, 0, 0x8104d00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104d10307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8104d2030702000000f1090f0a00eb2c0f0100),
(816, 0, 0x8304d1030701000000ba048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00);
INSERT INTO `tile_store` (`house_id`, `world_id`, `data`) VALUES
(816, 0, 0x8304d203070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8404d0030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8404d1030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8604d203070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8804d00307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8804d10307030000005f090f0100f2090f0100eb2c0f0100),
(816, 0, 0x8804d2030702000000f0090f0a00eb2c0f0100),
(816, 0, 0x8a04d1030701000000ba048001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8a04d203070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8c04d0030701000000de068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8c04d1030701000000df068001000b006465736372697074696f6e01190000004e6f626f647920697320736c656570696e672074686572652e00),
(816, 0, 0x8d04d203070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(816, 0, 0x8f04d203070100000029198001000b006465736372697074696f6e013e00000049742062656c6f6e677320746f20686f75736520274748492023383136272e20506c61792073746f6d70646d67206f776e73207468697320686f7573652e00),
(817, 0, 0x3904ef04070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383137272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333030303020676f6c6420636f696e732e00),
(817, 0, 0x3604f204070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383137272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333030303020676f6c6420636f696e732e00),
(817, 0, 0x3904f304070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383137272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333030303020676f6c6420636f696e732e00),
(817, 0, 0x3c04f1040701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383137272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333030303020676f6c6420636f696e732e00),
(817, 0, 0x3c04f204070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383137272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333030303020676f6c6420636f696e732e00),
(818, 0, 0x3904f604070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383138272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363030303020676f6c6420636f696e732e00),
(818, 0, 0x3604f804070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383138272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363030303020676f6c6420636f696e732e00),
(818, 0, 0x3c04f804070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383138272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363030303020676f6c6420636f696e732e00),
(818, 0, 0x3c04fa040701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383138272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363030303020676f6c6420636f696e732e00),
(818, 0, 0x3604fc04070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383138272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363030303020676f6c6420636f696e732e00),
(818, 0, 0x3904fd04070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383138272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363030303020676f6c6420636f696e732e00),
(818, 0, 0x3c04fc04070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383138272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363030303020676f6c6420636f696e732e00),
(819, 0, 0x36040205060100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(819, 0, 0x36040205070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(819, 0, 0x39040005060100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(819, 0, 0x39040005070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(819, 0, 0x3c040205060100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(819, 0, 0x3c040205070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(819, 0, 0x36040705060100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(819, 0, 0x36040705070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(819, 0, 0x3c040705060100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(819, 0, 0x3c0404050701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(819, 0, 0x3c040705070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(819, 0, 0x39040805060100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(819, 0, 0x39040805070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383139272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320373030303020676f6c6420636f696e732e00),
(820, 0, 0x3a040d05070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383230272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(820, 0, 0x3d040d050701000000bd048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383230272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(820, 0, 0x38041005070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383230272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(820, 0, 0x3a041205070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383230272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(820, 0, 0x40040d05070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383230272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(820, 0, 0x40041205070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383230272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(820, 0, 0x41041005070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383230272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(821, 0, 0x46040d05070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383231272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(821, 0, 0x49040d050701000000bd048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383231272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(821, 0, 0x4c040d05070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383231272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(821, 0, 0x44041005070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383231272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(821, 0, 0x46041205070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383231272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(821, 0, 0x4c041205070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383231272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(821, 0, 0x4d041005070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383231272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320363430303020676f6c6420636f696e732e00),
(822, 0, 0x52040d05070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383232272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e00),
(822, 0, 0x57040d050701000000bd048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383232272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e00),
(822, 0, 0x5c040d05070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383232272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e00),
(822, 0, 0x50041005070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383232272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e00),
(822, 0, 0x52041205070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383232272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e00),
(822, 0, 0x5c041205070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383232272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e00),
(822, 0, 0x5d041005070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383232272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320393630303020676f6c6420636f696e732e00),
(823, 0, 0x640406050701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383233272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(823, 0, 0x66040405070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383233272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(823, 0, 0x68040605070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383233272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(823, 0, 0x66040805070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383233272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(824, 0, 0x6604fe04070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383234272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(824, 0, 0x640400050701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383234272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(824, 0, 0x66040205070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383234272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(824, 0, 0x68040005070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383234272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(825, 0, 0x6e04fe04070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383235272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(825, 0, 0x6b040005070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383235272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(825, 0, 0x6d0402050701000000bd048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383235272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(825, 0, 0x6e040205070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383235272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(825, 0, 0x6f040005070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383235272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(826, 0, 0x7404fe040701000000bd048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383236272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(826, 0, 0x7504fe04070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383236272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(826, 0, 0x72040005070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383236272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(826, 0, 0x75040205070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383236272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(826, 0, 0x76040005070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383236272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(827, 0, 0x7204fa04070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383237272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(827, 0, 0x7504f804070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383237272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(827, 0, 0x7604fa04070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383237272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(827, 0, 0x7404fc040701000000bd048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383237272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(827, 0, 0x7504fc04070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383237272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(828, 0, 0x6b04fa04070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383238272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(828, 0, 0x6e04f804070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383238272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(828, 0, 0x6f04fa04070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383238272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(828, 0, 0x6d04fc040701000000bd048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383238272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(828, 0, 0x6e04fc04070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383238272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(829, 0, 0x6404fa040701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383239272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(829, 0, 0x6604f804070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383239272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(829, 0, 0x6804fa04070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383239272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(829, 0, 0x6604fc04070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383239272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(830, 0, 0x6604f204070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383330272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(830, 0, 0x6404f4040701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383330272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(830, 0, 0x6604f604070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383330272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(830, 0, 0x6804f404070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383330272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(831, 0, 0x6e04f204070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383331272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(831, 0, 0x6b04f404070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383331272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(831, 0, 0x6d04f6040701000000bd048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383331272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(831, 0, 0x6e04f604070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383331272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(831, 0, 0x6f04f404070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383331272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(832, 0, 0x6404ee040701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383332272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(832, 0, 0x6804ee04070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383332272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(832, 0, 0x6604f004070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383332272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(833, 0, 0xaa02fa040701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383333272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(834, 0, 0xaa0200050701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383334272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(835, 0, 0xa202fe040701000000bd048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383335272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(836, 0, 0xa20204050701000000bd048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383336272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(837, 0, 0xac0204050701000000bd048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383337272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333330303020676f6c6420636f696e732e00),
(838, 0, 0xbc0204050701000000bd048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383338272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333630303020676f6c6420636f696e732e00),
(839, 0, 0xc60206050701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383339272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(840, 0, 0xce0206050701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383430272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(841, 0, 0xc60200050701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383431272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(842, 0, 0xc602fa040701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383432272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(843, 0, 0xc602f4040701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383433272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(844, 0, 0xce02f4040701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383434272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(845, 0, 0xce02fa040701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383435272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(846, 0, 0xce0200050701000000ba048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383436272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(847, 0, 0xd90203050701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383437272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333630303020676f6c6420636f696e732e00),
(848, 0, 0xd902f7040701000000ba048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383438272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320333630303020676f6c6420636f696e732e00),
(850, 0, 0x180451030701000000bc048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383530272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(850, 0, 0x1a0451030701000000281900),
(850, 0, 0x1b0453030701000000291900),
(850, 0, 0x18045503070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383530272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(851, 0, 0x18044903070100000028198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(851, 0, 0x1b044b03070100000029198001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(851, 0, 0x18044d030701000000be048001000b006465736372697074696f6e015c00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383531272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f73747320313530303020676f6c6420636f696e732e00),
(852, 0, 0xf5036a030701000000bc048001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383532272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(852, 0, 0xf3036d03070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383532272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(852, 0, 0xf5036e03070100000028198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383532272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00),
(852, 0, 0xf7036d03070100000029198001000b006465736372697074696f6e015b00000049742062656c6f6e677320746f20686f7573652027556e6e616d656420486f7573652023383532272e204e6f626f6479206f776e73207468697320686f7573652e20497420636f737473203930303020676f6c6420636f696e732e00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `videos`
--

CREATE TABLE IF NOT EXISTS `videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` int(11) DEFAULT NULL,
  `title` varchar(120) DEFAULT NULL,
  `description` tinytext,
  `youtube` varchar(45) DEFAULT NULL,
  `views` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author` (`author`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `video_comments`
--

CREATE TABLE IF NOT EXISTS `video_comments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `author` int(11) DEFAULT NULL,
  `video` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `text` tinytext,
  PRIMARY KEY (`id`),
  KEY `video` (`video`),
  KEY `author` (`author`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Restrições para dumps de tabelas
--

--
-- Restrições para tabelas `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `bugtracker`
--
ALTER TABLE `bugtracker`
  ADD CONSTRAINT `bugtracker_ibfk_1` FOREIGN KEY (`author`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`author`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `environment_killers`
--
ALTER TABLE `environment_killers`
  ADD CONSTRAINT `environment_killers_ibfk_1` FOREIGN KEY (`kill_id`) REFERENCES `killers` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `friends`
--
ALTER TABLE `friends`
  ADD CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`with`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`friend`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guild_kills`
--
ALTER TABLE `guild_kills`
  ADD CONSTRAINT `guild_kills_ibfk_1` FOREIGN KEY (`war_id`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_kills_ibfk_2` FOREIGN KEY (`death_id`) REFERENCES `player_deaths` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_kills_ibfk_3` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD CONSTRAINT `guild_wars_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_wars_ibfk_2` FOREIGN KEY (`enemy_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `house_auctions`
--
ALTER TABLE `house_auctions`
  ADD CONSTRAINT `house_auctions_ibfk_1` FOREIGN KEY (`house_id`, `world_id`) REFERENCES `houses` (`id`, `world_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `house_auctions_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `house_data`
--
ALTER TABLE `house_data`
  ADD CONSTRAINT `house_data_ibfk_1` FOREIGN KEY (`house_id`, `world_id`) REFERENCES `houses` (`id`, `world_id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `house_lists`
--
ALTER TABLE `house_lists`
  ADD CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`, `world_id`) REFERENCES `houses` (`id`, `world_id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `killers`
--
ALTER TABLE `killers`
  ADD CONSTRAINT `killers_ibfk_1` FOREIGN KEY (`death_id`) REFERENCES `player_deaths` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_killers`
--
ALTER TABLE `player_killers`
  ADD CONSTRAINT `player_killers_ibfk_1` FOREIGN KEY (`kill_id`) REFERENCES `killers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `player_killers_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_skills`
--
ALTER TABLE `player_skills`
  ADD CONSTRAINT `player_skills_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_spells`
--
ALTER TABLE `player_spells`
  ADD CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_statements`
--
ALTER TABLE `player_statements`
  ADD CONSTRAINT `player_statements_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_storage`
--
ALTER TABLE `player_storage`
  ADD CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_viplist`
--
ALTER TABLE `player_viplist`
  ADD CONSTRAINT `player_viplist_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `player_viplist_ibfk_2` FOREIGN KEY (`vip_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `poll_answer`
--
ALTER TABLE `poll_answer`
  ADD CONSTRAINT `poll_answer_ibfk_1` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `poll_votes`
--
ALTER TABLE `poll_votes`
  ADD CONSTRAINT `poll_votes_ibfk_1` FOREIGN KEY (`answer_id`) REFERENCES `poll_answer` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `poll_votes_ibfk_2` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `poll_votes_ibfk_3` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`board_id`) REFERENCES `forums` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`thread_id`) REFERENCES `threads` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `server_reports`
--
ALTER TABLE `server_reports`
  ADD CONSTRAINT `server_reports_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `threads`
--
ALTER TABLE `threads`
  ADD CONSTRAINT `threads_ibfk_1` FOREIGN KEY (`board_id`) REFERENCES `forums` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `tiles`
--
ALTER TABLE `tiles`
  ADD CONSTRAINT `tiles_ibfk_1` FOREIGN KEY (`house_id`, `world_id`) REFERENCES `houses` (`id`, `world_id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `tile_items`
--
ALTER TABLE `tile_items`
  ADD CONSTRAINT `tile_items_ibfk_1` FOREIGN KEY (`tile_id`) REFERENCES `tiles` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `tile_store`
--
ALTER TABLE `tile_store`
  ADD CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`author`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `video_comments`
--
ALTER TABLE `video_comments`
  ADD CONSTRAINT `video_comments_ibfk_1` FOREIGN KEY (`video`) REFERENCES `videos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `video_comments_ibfk_2` FOREIGN KEY (`author`) REFERENCES `players` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
