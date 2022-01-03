DROP TABLE IF EXISTS `service_links`;

CREATE TABLE `service_links` (
                         `uuid` uuid unsigned NOT NULL,
                         `user_id` mediumint(8) unsigned COMMENT "To be set to null if account is deleted",
                         `type` enum('STEAM', 'GOG', 'DISCORD', 'PATREON') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The service that this service id links to.',
                         `service_id` varchar(100) COMMENT "To be set to null if account is deleted",
                         `service_hash_id` char(64) NOT NULL
                         `public` boolean,
                         `ownership` boolean,
                         PRIMARY KEY (uuid),
                         UNIQUE KEY `unique_service_id` (`type`, `service_id`),
                         UNIQUE KEY `unique_hashed_id` (`type`, `hashed_id`),
                         CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `login` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='table representing the links to various services';

# MIGRATION SCRIPT
#
# INSERT into `service_links` (`user_id`, `type`, `service_id`, `ownership`, `public`)
# SELECT `id`, "STEAM", `steamid`, true, false
# FROM `login` WHERE `steamid` IS NOT NULL
# ON DUPLICATE KEY UPDATE `user_id`=`user_id`;
#
# INSERT into `service_links` (`user_id`, `type`, `service_id`, `ownership`, `public`)
# SELECT `id`, "GOG", `gog_id`, false, false
# FROM `login` WHERE `gog_id` IS NOT NULL
# ON DUPLICATE KEY UPDATE `user_id`=`user_id`;
