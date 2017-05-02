CREATE TABLE `auth_permission` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL COMMENT 'e.g. gameban.create or gameban.delete',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) )
COMMENT = 'List of all permissions, assigned over role assignments (auth_role_permission_assignments)';

CREATE TABLE `auth_role` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL COMMENT 'e.g. Admin,Mod',
  `level` MEDIUMINT(4) UNSIGNED COMMENt 'level of this role for greater less comparison in server',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) )
COMMENT = 'List of all roles. A bunch of permission forms a role (see auth_role_permission_assignments) and are assigned over auth_user_role_assignment to a user';

CREATE TABLE `auth_role_permission_assignments` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `permission_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`role_id`) REFERENCES `auth_role`(`id`),
  FOREIGN KEY (`permission_id`) REFERENCES `auth_permission`(`id`))
COMMENT = 'Connect roles (auth_role) and permissions (auth_role_permission_assignments)';

CREATE TABLE `auth_user_role_assignment` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `role_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `login`(`id`),
  FOREIGN KEY (`role_id`) REFERENCES `auth_role`(`id`))
COMMENT = 'Assign users (login) to a role (a bunch of permissions)';

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `auth_user` AS
    SELECT 
        `auth_user_role_assignment`.`user_id` AS `user_id`,
        `auth_user_role_assignment`.`role_id` AS `role_id`,
        `auth_role`.`name` AS `role_name`,
        `auth_role`.`level` AS `role_level`
    FROM
        (`auth_user_role_assignment`
        LEFT JOIN `auth_role` ON ((`auth_user_role_assignment`.`role_id` = `auth_role`.`id`)))

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `auth_login` AS
    SELECT 
        `login`.`id` AS `login_id`,
        (SELECT 
                `auth_user`.`role_level`
            FROM
                `auth_user`
            WHERE
                (`auth_user`.`user_id` = `login`.`id`)
            ORDER BY `auth_user`.`role_level` DESC
            LIMIT 1) AS `auth_level`
    FROM
        `login`
