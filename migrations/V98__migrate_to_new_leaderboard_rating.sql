INSERT IGNORE INTO leaderboard_rating
(login_id, mean, deviation, total_games, won_games, leaderboard_id)
SELECT id, mean, deviation, numGames, 0, 1 -- global
FROM global_rating;

INSERT IGNORE INTO leaderboard_rating
(login_id, mean, deviation, total_games, won_games, leaderboard_id)
SELECT id, mean, deviation, numGames, winGames, 2 -- ladder
FROM ladder1v1_rating;
