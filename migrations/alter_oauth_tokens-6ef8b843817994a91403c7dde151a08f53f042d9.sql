ALTER TABLE `oauth_tokens`
CHANGE COLUMN `refresh_token` `refresh_token` VARCHAR(36) NULL COMMENT 'A string token (UUID).' ;
