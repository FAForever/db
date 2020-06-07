INSERT INTO leaderboard_rating_journal (
  game_player_stats_id, 
  leaderboard_id, 
  rating_mean_before, 
  rating_deviation_before, 
  rating_mean_after, 
  rating_deviation_after
)
  SELECT
      game_player_stats.id,
      CASE
        WHEN game_stats.id < 1996398 THEN
          CASE
            WHEN 
              game_player_stats.score IN (-1, 0, 1) 
              AND
              game_stats.gameName LIKE _utf8 "% Vs %" COLLATE utf8_bin
              AND
              (
                SELECT COUNT(*)
                FROM game_player_stats
                WHERE game_player_stats.gameId = game_stats.id
              ) = 2
              AND
              (
                SELECT COUNT(*)
                FROM game_player_stats
                WHERE game_player_stats.gameId = game_stats.id
                AND game_player_stats.AI = FALSE
                AND game_player_stats.color IN (1, 2)
                AND game_player_stats.score IN (-1, 0, 1)
              ) = 2
              THEN (SELECT id from leaderboard where leaderboard.technical_name = "ladder_1v1")
            ELSE (SELECT id from leaderboard where leaderboard.technical_name = "global")
          END
        ELSE
          CASE
            WHEN game_featuredMods.gamemod = "ladder1v1" THEN (SELECT id from leaderboard where leaderboard.technical_name = "ladder_1v1")
            ELSE (SELECT id from leaderboard where leaderboard.technical_name = "global")
          END
      END AS leaderboard_id,
      game_player_stats.mean,
      game_player_stats.deviation,
      game_player_stats.after_mean,
      game_player_stats.after_deviation
    FROM
      game_stats
      JOIN
        game_player_stats ON (game_player_stats.gameId = game_stats.id)
      JOIN
        game_featuredMods ON (game_stats.gameMod = game_featuredMods.id)
      JOIN
        game_validity ON (game_stats.validity = game_validity.id)
    WHERE
      game_player_stats.after_mean IS NOT NULL
      AND
      game_player_stats.after_deviation IS NOT NULL
      AND
      game_validity.message = "Valid"
      AND
      game_featuredMods.gamemod IN ("faf", "ladder1v1")
    ORDER BY game_player_stats.id
;
