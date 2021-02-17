DELETE FROM game_player_stats where gameId not in (select id from game_stats);

SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE game_player_stats
  MODIFY gameId INT(10) unsigned NOT NULL,
  ADD CONSTRAINT game_id_fk FOREIGN KEY (gameId) REFERENCES game_stats (id);

SET FOREIGN_KEY_CHECKS=1;

