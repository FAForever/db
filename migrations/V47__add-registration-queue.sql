CREATE TABLE `registration_queue` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(20) NOT NULL,
    `email` VARCHAR(254) NOT NULL,
    `status` VARCHAR(10) NOT NULL DEFAULT 'PENDING',
    `reject_reason` VARCHAR(254) NULL,
    `reviewer` MEDIUMINT UNSIGNED NULL,
    `created_user` MEDIUMINT UNSIGNED NULL,
    `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_registration_queue_reviewer` FOREIGN KEY (`reviewer`) REFERENCES `login` (`id`),
    CONSTRAINT `fk_registration_queue_created_user` FOREIGN KEY (`created_user`) REFERENCES `login` (`id`)
)
COMMENT='If activated, all user registration activations will end up in this queue and waiting for approval by a moderator.'
ENGINE=InnoDB;
