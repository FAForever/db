UPDATE
  game_stats
SET
  gamemod = 6
WHERE
  gamemod = 0
AND
  startTime < "2014-03-22 12:59:25"
AND
  gameName LIKE "% Vs %"
AND
  (
    SELECT count(*) FROM game_player_stats
    WHERE gameId = game_stats.id
  ) = 2
AND
  (
    SELECT count(*) FROM game_player_stats
    WHERE gameId = game_stats.id AND
      AI = false AND
      color IN (1, 2) AND
      score in (-1, 0, 1)
  ) = 2
;


DROP TEMPORARY TABLE IF EXISTS game_player_count;

CREATE TEMPORARY TABLE game_player_count
    SELECT
      game_stats.id AS id,
      count(game_player_stats.id) AS gps_row_count,
      count(DISTINCT game_player_stats.playerId) AS distinct_player_count
    FROM 
      game_stats
    INNER JOIN 
      game_player_stats ON (game_player_stats.gameId = game_stats.id)
    WHERE
      game_stats.id BETWEEN 4393127 AND 4424727
    GROUP BY
      game_stats.id
    HAVING
      gps_row_count != distinct_player_count
;

UPDATE
  game_stats
INNER JOIN
  game_player_count ON (game_stats.id = game_player_count.id)
SET
  game_stats.validity = 24  # "Unranked for another reason"
WHERE
  game_stats.validity = 0
;

DROP TEMPORARY TABLE game_player_count;
