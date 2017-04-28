CREATE TABLE `acu_skin` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `faction` ENUM('UEF', 'CYBRAN', 'AEON', 'SERAPHIM') NOT NULL,
  `name` varchar(40) CHARACTER SET 'utf8' NOT NULL COMMENT 'display name, e.g. for modapp',
  `comment` text CHARACTER SET 'utf8' COMMENT 'optional comment about the skin, e.g. purpose',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `acu_skin_assignment` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `skin_id` mediumint(8) UNSIGNED NOT NULL,
  `player_id` mediumint(8) UNSIGNED NOT NULL,
  `comment` text CHARACTER SET 'utf8' COMMENT 'optional comment about the skin assignment, e.g. why the user received the skin',
  `expires_at` DATETIME NULL DEFAULT NULL COMMENT 'If null, the avatar is permanent',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`skin_id`) REFERENCES `acu_skin`(`id`),
  FOREIGN KEY (`player_id`) REFERENCES `login`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
