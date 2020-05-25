CREATE TABLE IF NOT EXISTS `login_log` (
    `id` MEDIUMINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT COMMENT 'ID for API/Elide compatibility',
    `login_id` MEDIUMINT UNSIGNED NOT NULL,
    `ip` VARCHAR(45) NOT NULL,
    `attempts` MEDIUMINT UNSIGNED NOT NULL DEFAULT 1,
    `success` BOOLEAN NOT NULL,
    `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`success`,`ip`,`login_id`),
    CONSTRAINT FOREIGN KEY (`login_id`) REFERENCES `login` (`id`)
) ENGINE=InnoDB COMMENT='Log of logins to discover login attack attempts. Has to be cleaned up by the services.';
