-- Give game_desync a surrogate key so it can be exposed through the API (Elide needs a single-column id).
--
-- The (game_id, player_id) pair stays unique: the lobby server relies on that to make repeated reports idempotent.
-- The unique key is added in the same statement as the primary key is dropped, so the foreign key on game_id always has
-- an index to use.

ALTER TABLE game_desync
  DROP PRIMARY KEY,
  ADD COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
  ADD PRIMARY KEY (id),
  ADD CONSTRAINT uq_game_desync_game_player UNIQUE (game_id, player_id);
