ALTER TABLE leaderboard MODIFY id SMALLINT(5) UNSIGNED AUTO_INCREMENT;

ALTER TABLE leaderboard_rating MODIFY leaderboard_id SMALLINT(5) UNSIGNED NOT NULL;
ALTER TABLE leaderboard_rating MODIFY login_id MEDIUMINT(8) UNSIGNED NOT NULL;

ALTER TABLE leaderboard_rating_journal MODIFY leaderboard_id SMALLINT(5) UNSIGNED NOT NULL;
ALTER TABLE leaderboard_rating_journal MODIFY game_player_stats_id BIGINT(20) UNSIGNED NOT NULL;

ALTER TABLE matchmaker_queue MODIFY featured_mod_id tinyint(3) UNSIGNED NOT NULL;
ALTER TABLE matchmaker_queue MODIFY leaderboard_id smallint(5) UNSIGNED NOT NULL;

ALTER TABLE matchmaker_queue_map_pool MODIFY matchmaker_queue_id INT(10) UNSIGNED NOT NULL;
ALTER TABLE matchmaker_queue_map_pool MODIFY map_pool_id INT(10) UNSIGNED NOT NULL;

ALTER TABLE map_pool_map_version MODIFY map_pool_id INT(10) UNSIGNED NOT NULL;
ALTER TABLE map_pool_map_version MODIFY map_version_id MEDIUMINT(8) UNSIGNED NOT NULL;


ALTER TABLE leaderboard_rating
    ADD FOREIGN KEY (login_id) references login (id),
    ADD FOREIGN KEY (leaderboard_id) references leaderboard (id);

ALTER TABLE leaderboard_rating_journal
    ADD FOREIGN KEY (game_player_stats_id) references game_player_stats (id),
    ADD FOREIGN KEY (leaderboard_id) references leaderboard (id);

ALTER TABLE matchmaker_queue
    ADD FOREIGN KEY (featured_mod_id) references game_featuredMods (id),
    ADD FOREIGN KEY (leaderboard_id) references leaderboard (id);

ALTER TABLE map_pool_map_version
    ADD FOREIGN KEY (map_pool_id) references map_pool (id),
    ADD FOREIGN KEY (map_version_id) references map_version (id);

ALTER TABLE matchmaker_queue_map_pool
    ADD FOREIGN KEY (matchmaker_queue_id) references matchmaker_queue (id),
    ADD FOREIGN KEY (map_pool_id) references map_pool (id);

ALTER TABLE map_reviews_summary
    ADD FOREIGN KEY (map_id) references map (id);

ALTER TABLE mod_reviews_summary
    ADD FOREIGN KEY (mod_id) references `mod` (id);
