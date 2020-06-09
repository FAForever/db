ALTER TABLE leaderboard_rating
  ADD FOREIGN KEY (login_id) references login (id)
  ADD FOREIGN KEY (leaderboard_id) references leaderboard_id (id);

ALTER TABLE leaderboard_rating_journal
  ADD FOREIGN KEY (game_player_stats_id) references game_player_stats (id)
  ADD FOREIGN KEY (leaderboard_id) references leaderboard (id);

ALTER TABLE matchmaker_queue
  ADD FOREIGN KEY (featured_mod_id) references game_featuredMods (id)
  ADD FOREIGN KEY (leaderboard_id) references leaderboard (id);

ALTER TABLE map_pool_map_version
  ADD FOREIGN KEY (map_pool_id) references map_pool (id)
  ADD FOREIGN KEY (map_version_id) references map_version (id);

ALTER TABLE matchmaker_queue_map_pool
  ADD FOREIGN KEY (matchmaker_queue_id) references matchmaker_queue (id)
  ADD FOREIGN KEY (map_pool_id) references map_pool (id);

ALTER TABLE map_reviews_summary
  ADD FOREIGN KEY (map_id) references map (id);

ALTER TABLE mod_reviews_summary
  ADD FOREIGN KEY (mod_id) references `mod` (id);
