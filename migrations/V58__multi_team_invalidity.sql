TRUNCATE TABLE invalid_game_reasons;

ALTER TABLE invalid_game_reasons RENAME TO game_validity;
ALTER TABLE game_validity MODIFY id TINYINT(3) UNSIGNED NOT NULL;

INSERT INTO game_validity (id, message) VALUES
  (0, 'Valid'),
  (1, 'Too many desyncs'),
  (2, 'Only assassination mode is ranked'),
  (3, 'Fog of war was disabled'),
  (4, 'Cheats were enabled'),
  (5, 'Prebuilt units were enabled'),
  (6, 'No rush was enabled'),
  (7, 'Unacceptable unit restrictions were enabled'),
  (8, 'An unacceptable map was used'),
  (9, 'Game was too short (probably had a technical fault early on)'),
  (10, 'An unacceptable mod was used'),
  (11, 'Coop is not ranked'),
  (12, 'The players mutually agreed to a draw'),
  (13, 'The game was single player'),
  (14, 'The game was FFA'),
  (15, 'The game had unbalanced teams'),
  (16, 'No results were reported by peers'),
  (17, 'Team were unlocked'),
  (18, 'More than two teams. XvXvX+ games cannot possibly be ranked, for the same reason that FFA cannot');

ALTER TABLE game_stats
  ADD CONSTRAINT game_stats_game_validity_id_fk
FOREIGN KEY (validity) REFERENCES game_validity (id);