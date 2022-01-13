DROP TABLE IF EXISTS `service_links`;

CREATE TABLE `service_links` (
                         `id` CHAR(36) CHARACTER SET ascii NOT NULL,
                         `user_id` mediumint(8) unsigned COMMENT 'To be set to null if account is deleted',
                         `type` enum('STEAM', 'GOG', 'DISCORD', 'PATREON') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The service that this service id links to.',
                         `service_id` varchar(100) COMMENT 'To be set to null if account is deleted unless ownership is true',
                         `public` boolean,
                         `ownership` boolean COMMENT 'If true, this link confirms that the user owns FAForever. If true the link must never be deleted even if the linked account gets deleted. In this case we keep a dangling link so the id cannot be reused',
                         PRIMARY KEY (id),
                         UNIQUE KEY `unique_service_id` (`type`, `service_id`),
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
# SELECT `id`, "GOG", `gog_id`, true, false
# FROM `login` WHERE `gog_id` IS NOT NULL
# ON DUPLICATE KEY UPDATE `user_id`=`user_id`;
