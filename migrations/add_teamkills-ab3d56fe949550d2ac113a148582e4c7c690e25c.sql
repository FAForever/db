CREATE TABLE IF NOT EXISTS `teamkills` (
  `teamkiller` mediumint(8) unsigned NOT NULL COMMENT 'login of the player who performed the teamkill',
  `victim` mediumint(8) unsigned NOT NULL COMMENT 'login of the player who got teamkilled and reported the tk',
  `game_id` int(10) unsigned NOT NULL COMMENT 'game-id where teamkill was performed',
  `gametime` mediumint(8) unsigned NOT NULL COMMENT 'time of game in seconds when tk was performed',
  `reported_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX (game_id));
