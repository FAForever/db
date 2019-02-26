ALTER TABLE `game_stats`
ADD INDEX `validity_gameMod_endTime` (`validity`, `gameMod`, `endTime`);

