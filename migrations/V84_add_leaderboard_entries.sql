INSERT INTO leaderboard (id, technical_name, name_key, description_key) VALUES
  (1, 'global', 'leaderboard.global.name', 'leaderboard.global.description'),
  (2, 'ladder_1v1', 'leaderboard.ladder_1v1.name', 'leaderboard.ladder_1v1.description'),
;

INSERT INTO messages (key, language, region, value) VALUES
  ('leaderboard.global.name', 'en', 'US', 'Global Rating'),
  ('leaderboard.global.description', 'en', 'US', 'Rating used for custom games'),
  ('leaderboard.ladder_1v1.name', 'en', 'US', 'Ladder 1v1 Rating'),
  ('leaderboard.ladder_1v1.description', 'en', 'US', 'Rating used for 1v1 matchmaker games')
;
