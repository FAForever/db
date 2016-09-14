ALTER TABLE `login` ADD COLUMN `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When the user signed up';
ALTER TABLE `login` ADD COLUMN `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'When the user last updated their information';

# Update the times for existing users based on their first game
UPDATE `login`
SET `create_time` = (SELECT game_player_stats.scoreTime
                     FROM game_player_stats
                     WHERE game_player_stats.playerId = `login`.id);

DROP TRIGGER IF EXISTS `login_BEFORE_INSERT`;
DROP TRIGGER IF EXISTS `login_BEFORE_UPDATE`;
DELIMITER $$
CREATE TRIGGER `login_BEFORE_INSERT` BEFORE INSERT ON `login` FOR EACH ROW
BEGIN
        SET NEW.create_time = NOW();
        SET NEW.update_time = NOW();
END
$$
CREATE TRIGGER `login_BEFORE_UPDATE` BEFORE UPDATE ON `login` FOR EACH ROW
BEGIN
        SET NEW.update_time = NOW();
END
$$
DELIMITER ;
