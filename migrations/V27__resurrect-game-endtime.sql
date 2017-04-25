# Estimated script run time: 6min

ALTER TABLE game_stats
  ADD endTime TIMESTAMP NULL AFTER startTime;

UPDATE game_stats
SET endTime = (SELECT max(scoreTime)
               FROM game_player_stats
               WHERE gameId = game_stats.id);
