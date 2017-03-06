CREATE TABLE `login_permission` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL COMMENT 'e.g. gameban.create or gameban.delete',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) )
COMMENT = 'List of all permissions, assigned over role assignments (login_role_permission)';

CREATE TABLE `login_role` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL COMMENT 'e.g. Admin,Mod',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) )
COMMENT = 'List of all roles. A bunch of permission forms a role (see login_role_permission) and are assigned over login_user_role_assignment to a user';

CREATE TABLE `login_role_permission` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `permission_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`role_id`) REFERENCES `login_role`(`id`),
  FOREIGN KEY (`permission_id`) REFERENCES `login_permission`(`id`))
COMMENT = 'Connect roles (login_role) and permissions (login_permission)';

CREATE TABLE `login_user_role_assignment` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `role_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `login`(`id`),
  FOREIGN KEY (`role_id`) REFERENCES `login_role`(`id`))
COMMENT = 'Assign users (login) to a role (a bunch of permissions)';
