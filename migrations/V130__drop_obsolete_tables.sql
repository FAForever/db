SET foreign_key_checks = 0;

# Replaced by TMM related (rating) tables
DROP TABLE IF EXISTS ladder1v1_rating;
DROP TABLE IF EXISTS ladder1v1_rating_distribution; # TODO: where do we do that for leaderboards?
DROP TABLE IF EXISTS ladder1v1_rating_rank_view;
DROP TABLE IF EXISTS ladder_map;
DROP TABLE IF EXISTS global_rating;
DROP TABLE IF EXISTS global_rating_distribution; # TODO: where do we do that for leaderboards?
DROP TABLE IF EXISTS global_rating_rank_view;
# Replaced by league system
DROP TABLE IF EXISTS ladder_division;
DROP TABLE IF EXISTS ladder_division_score;
# Replaced by Ory Hydra / User service
DROP TABLE IF EXISTS oauth_clients;
DROP TABLE IF EXISTS oauth_tokens;
DROP TABLE IF EXISTS jwt_users;
# Replaced by user permission system
DROP TABLE IF EXISTS lobby_admin;

SET foreign_key_checks = 1