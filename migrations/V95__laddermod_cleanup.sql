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

UPDATE
  faf.game_stats
SET
  validity = 24  # "Unranked for another reason"
WHERE
  validity = 0
AND
  (
    SELECT count(*) FROM faf.game_player_stats
    WHERE gameId = faf.game_stats.id
  ) != (
    SELECT count(DISTINCT faf.game_player_stats.playerId) FROM faf.game_player_stats
    WHERE gameId = faf.game_stats.id
  )
AND
  faf.game_stats.id BETWEEN 4393127 AND 4424727
;
