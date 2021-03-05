ALTER TABLE leaderboard
  ADD COLUMN initializer_id SMALLINT(5) UNSIGNED DEFAULT NULL
    COMMENT 'Initialize rating based on existing entries from another leaderboard.',
  ADD FOREIGN KEY (initializer_id) REFERENCES leaderboard (id)
;
