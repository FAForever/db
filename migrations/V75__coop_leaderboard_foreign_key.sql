-- Delete bad values
DELETE c FROM coop_leaderboard c
  LEFT JOIN game_stats g ON g.id = c.gameuid
      WHERE g.id IS NULL;

ALTER TABLE coop_leaderboard MODIFY gameuid INT UNSIGNED;
ALTER TABLE coop_leaderboard
  ADD FOREIGN KEY (gameuid) REFERENCES game_stats(id);
