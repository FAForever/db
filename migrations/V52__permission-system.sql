CREATE TABLE `user_group` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL COMMENT 'e.g. Admin, Mod, Council of Setons',
  `parent_group_id` MEDIUMINT(8) UNSIGNED,
  `public` TINYINT(1)  NOT NULL COMMENT 'Public groups are visible for everyone, the rest only for internal permissions',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) )
COMMENT = 'List of all user groups. Some of them are only informative  (i.e. council of setons on website), others for permissions system.';


CREATE TABLE `user_group_assignment` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `group_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `login`(`id`),
  FOREIGN KEY (`group_id`) REFERENCES `user_group`(`id`))
COMMENT = 'Assign users (login) to a role (a bunch of permissions)';


CREATE TABLE `group_permission` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL COMMENT 'e.g. gameban.create or gameban.delete',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) )
COMMENT = 'List of all permissions, assigned over group assignments (group_permission_assignments)';


CREATE TABLE `group_permission_assignment` (
  `id` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `permission_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`group_id`) REFERENCES `user_group`(`id`),
  FOREIGN KEY (`permission_id`) REFERENCES `group_permission`(`id`))
COMMENT = 'Connects groups (user_group) and permissions (group_permission)';
