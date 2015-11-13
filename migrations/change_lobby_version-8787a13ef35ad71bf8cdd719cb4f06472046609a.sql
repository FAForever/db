ALTER TABLE `version_lobby` DROP COLUMN `version`;
ALTER TABLE `version_lobby` ADD COLUMN `version` VARCHAR(100) NOT NULL COMMENT 'Current version of the official client';
