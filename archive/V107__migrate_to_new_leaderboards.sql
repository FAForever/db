-- IGNORE because there are already records in the new tables we don't want to overwrite.

INSERT IGNORE INTO leaderboard_rating(login_id, mean, deviation, total_games, won_games, leaderboard_id)
SELECT id, mean, deviation, numGames, 0, 1 FROM global_rating;

INSERT IGNORE INTO leaderboard_rating(login_id, mean, deviation, total_games, won_games, leaderboard_id)
SELECT id, mean, deviation, numGames, winGames, 2 FROM ladder1v1_rating;


INSERT IGNORE INTO leaderboard_rating_journal(game_player_stats_id, leaderboard_id, rating_mean_before,
                                              rating_deviation_before, rating_mean_after, rating_deviation_after)
SELECT gps.id,
       CASE
           WHEN gs.gameMod = 0 THEN 1
           WHEN gs.gameMod = 6 THEN 2
           END,
       mean,
       deviation,
       after_mean,
       after_deviation
FROM game_player_stats gps
         INNER JOIN game_stats gs ON gps.gameId = gs.id
WHERE gs.gameMod IN (0, 6)
  AND after_mean IS NOT NULL
  AND after_deviation IS NOT NULL;
