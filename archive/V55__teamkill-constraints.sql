delete from teamkills where game_id not in (select id from game_stats);

ALTER TABLE teamkills
  ADD CONSTRAINT teamkills_game_stats_id_fk
FOREIGN KEY (game_id) REFERENCES game_stats (id);
