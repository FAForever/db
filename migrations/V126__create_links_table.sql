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
# drop table if exists temp_id_holder;
#
# create temporary table temp_id_holder as
# select * from login order by RAND()
# WHERE `steamid` IS NOT NULL or `gog_id` IS NOT NULL;
#
# INSERT into `service_links` (`id`, `user_id`, `type`, `service_id`, `ownership`, `public`)
# SELECT UUID(), `id`, "STEAM", `steamid`, true, false
# FROM `temp_id_holder` WHERE `steamid` IS NOT NULL and `login` not LIKE "anonymized_%" and `email` not LIKE "anonymized_%" and password != "anonymized"
# ON DUPLICATE KEY UPDATE `user_id`=`user_id`;
#
# INSERT into `service_links` (`id`, `type`, `service_id`, `ownership`, `public`)
# SELECT UUID(), "STEAM", `steamid`, true, false
# FROM `temp_id_holder` WHERE `steamid` IS NOT NULL and (`login` LIKE "anonymized_%" or `email` LIKE "anonymized_%" or password = "anonymized")
# ON DUPLICATE KEY UPDATE `user_id`=`user_id`;
#
# INSERT into `service_links` (`id`, `user_id`, `type`, `service_id`, `ownership`, `public`)
# SELECT UUID(), `id`, "GOG", `gog_id`, true, false
# FROM `temp_id_holder` WHERE `gog_id` IS NOT NULL and `login` not LIKE "anonymized_%" and `email` not LIKE "anonymized_%" and password != "anonymized"
# ON DUPLICATE KEY UPDATE `user_id`=`user_id`;
#
# INSERT into `service_links` (`id`, `type`, `service_id`, `ownership`, `public`)
# SELECT UUID(), "GOG", `gog_id`, true, false
# FROM `temp_id_holder` WHERE `gog_id` IS NOT NULL and (`login` LIKE "anonymized_%" or `email` LIKE "anonymized_%" or password = "anonymized")
# ON DUPLICATE KEY UPDATE `user_id`=`user_id`;
#
# drop table if exists temp_id_holder;
