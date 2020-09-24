-- Mean may be negative (signed) but deviation must be positive (unsigned)
ALTER TABLE leaderboard_rating MODIFY deviation FLOAT UNSIGNED NOT NULL;

ALTER TABLE leaderboard_rating_journal
  MODIFY rating_deviation_before FLOAT UNSIGNED NOT NULL,
  MODIFY rating_deviation_after FLOAT UNSIGNED NOT NULL;

ALTER TABLE game_player_stats
  MODIFY mean FLOAT NOT NULL,
  MODIFY after_deviation FLOAT UNSIGNED;
