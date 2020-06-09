UPDATE
  faf.game_stats
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
    SELECT count(*) FROM faf.game_player_stats
    WHERE gameId = faf.game_stats.id
  ) = 2
AND
  (
    SELECT count(*) FROM faf.game_player_stats
    WHERE gameId = faf.game_stats.id AND
      AI = false AND
      color IN (1, 2) AND
      score in (-1, 0, 1)
  ) = 2
;


DROP TEMPORARY TABLE IF EXISTS faf.game_player_count;

CREATE TEMPORARY TABLE faf.game_player_count
    SELECT
      faf.game_stats.id AS id,
      count(faf.game_player_stats.id) AS gps_row_count,
      count(DISTINCT faf.game_player_stats.playerId) AS distinct_player_count
    FROM 
      faf.game_stats
    INNER JOIN 
      faf.game_player_stats ON (faf.game_player_stats.gameId = faf.game_stats.id)
    WHERE
      faf.game_stats.id BETWEEN 4393127 AND 4424727
    GROUP BY
      faf.game_stats.id
;

UPDATE
  faf.game_stats
INNER JOIN
  faf.game_player_count ON (faf.game_stats.id = faf.game_player_count.id)
SET
  validity = 24  # "Unranked for another reason"
WHERE
  validity = 0
AND
  gps_row_count != distinct_player_count
;
