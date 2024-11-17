ALTER TABLE matchmaker_queue_map_pool
  ADD COLUMN veto_tokens_per_player TINYINT UNSIGNED DEFAULT 0 NOT NULL,
  ADD COLUMN max_tokens_per_map TINYINT UNSIGNED DEFAULT 0 NOT NULL,
  ADD COLUMN minimum_maps_after_veto FLOAT DEFAULT 1 NOT NULL CHECK (minimum_maps_after_veto > 0);