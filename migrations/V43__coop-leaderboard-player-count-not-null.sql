DELETE FROM coop_leaderboard WHERE player_count IS NULL;
ALTER TABLE coop_leaderboard MODIFY player_count TINYINT(2) NOT NULL;
