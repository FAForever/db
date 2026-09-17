-- Log which players reported a desync in which game.
--
-- The game keeps sending the GPGNet `Desync` message for as long as it stays
-- desynced, so a single row per game and player is enough: the primary key
-- makes the repeated reports idempotent and `reported_at` records the first
-- one. The message itself carries no arguments, so `game_time` is derived by
-- the server from the time the game was launched.

CREATE TABLE game_desync (
  game_id     INT UNSIGNED       NOT NULL COMMENT 'game in which the desync was reported',
  player_id   MEDIUMINT UNSIGNED NOT NULL COMMENT 'player whose client reported the desync',
  reported_at DATETIME(3)        NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT 'time of the first report of this player',
  game_time   INT UNSIGNED       NULL COMMENT 'seconds since game launch, derived by the server',
  PRIMARY KEY (game_id, player_id),
  CONSTRAINT game_desync_game_stats_id_fk FOREIGN KEY (game_id) REFERENCES game_stats (id),
  CONSTRAINT game_desync_login_id_fk FOREIGN KEY (player_id) REFERENCES login (id)
);

CREATE INDEX idx_game_desync_player_reported_at ON game_desync (player_id, reported_at);
