CREATE TABLE IF NOT EXISTS `bugreport_targets` (
  `id` VARCHAR(255) NOT NULL COMMENT 'Unique reference to the target, e.g. FAForever/client/tree/(hash)',
  `name` VARCHAR(255) NOT NULL COMMENT 'Name of the target, a github repository name',
  `ref` VARCHAR(255) NOT NULL COMMENT 'Reference of the target',
  `url` VARCHAR(255) NOT NULL COMMENT 'Url to the target',
  `create_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
);

CREATE TABLE IF NOT EXISTS `bugreports` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `target` VARCHAR(255) NOT NULL,
  `automatic` BOOL NOT NULL COMMENT 'Whether the report was automated or not',
  `description` TEXT COMMENT 'A (potentially markdown-formatted) description of the bug',
  `log` TEXT COMMENT 'Log associated with the report',
  `traceback` TEXT COMMENT 'Traceback associated with the report',
  `create_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `bugreport_target` FOREIGN KEY (`target`) REFERENCES bugreport_targets (`id`)
);

CREATE TABLE IF NOT EXISTS `bugreport_status` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `bugreport` INT(11) NOT NULL,
  `status_code` ENUM('unfiled', 'filed', 'dismissed') NOT NULL,
  `url` VARCHAR(255) COMMENT 'If status is filed, then this should be a reference to a github issue',
  `create_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `bugreport` FOREIGN KEY (`bugreport`) REFERENCES bugreports (`id`)
);
