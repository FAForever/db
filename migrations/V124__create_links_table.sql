DROP TABLE IF EXISTS `service_links`;

CREATE TABLE `service_links` (
                         `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
                         `user_id` mediumint(8) unsigned NOT NULL,
                         `type` enum('STEAM', 'GOG', 'DISCORD', 'PATREON') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The service that this service id links to.',
                         `service_id` varchar(100),
                         `hashed_id` char(256) NOT NULL,
                         `hash_salt` char(100) NOT NULL,
                         `public` boolean,
                         `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was created.',
                         `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'When this entry was updated',
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `unique_service_id` (`type`, `service_id`),
                         UNIQUE KEY `unique_hashed_id` (`type`, `hashed_id`),
                         CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='table representing the links to various services';

# MIGRATION SCRIPT
# SET @SECRET = "{SECRET}";
#
# INSERT into `service_links` (`user_id`, `type`, `service_id`, `hashed_id`, `hash_salt`, `public`)
# SELECT `id`, "STEAM", `steamid`, SHA2(CONCAT(`steamid`, @SECRET), 256) as `hashed_id`, @SECRET, false
# FROM `login` WHERE `steamid` IS NOT NULL
# ON DUPLICATE KEY UPDATE `user_id`=`user_id`;
#
# INSERT into `service_links` (`user_id`, `type`, `service_id`, `hashed_id`, `hash_salt`, `public`)
# SELECT `id`, "GOG", `gog_id`, SHA2(CONCAT(`gog_id`, @SECRET), 256) as `hashed_id`, @SECRET, false
# FROM `login` WHERE `gog_id` IS NOT NULL
# ON DUPLICATE KEY UPDATE `user_id`=`user_id`;
