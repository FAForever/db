CREATE TABLE leaderboard
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    technical_name  VARCHAR(255) NOT NULL UNIQUE,
    name_key        VARCHAR(255) NOT NULL,
    description_key VARCHAR(255) NOT NULL COMMENT "The leaderboard's i18n description key",
    create_time   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE leaderboard_rating
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    login_id       INT       NOT NULL REFERENCES login (id),
    mean           FLOAT     NOT NULL,
    deviation      FLOAT     NOT NULL,
    rating         FLOAT     GENERATED ALWAYS AS (mean - 3 * deviation), -- TODO: is this column even necessary?
    total_games    INT       NOT NULL,
    won_games      INT       NOT NULL,
    leaderboard_id INT       NOT NULL REFERENCES leaderboard (id),
    create_time  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE leaderboard_rating_journal
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    game_player_stats_id    INT REFERENCES game_player_stats (id),
    leaderboard_id          INT REFERENCES leaderboard (id),
    rating_mean_before      FLOAT      NOT NULL,
    rating_deviation_before FLOAT      NOT NULL,
    rating_mean_after       FLOAT      NOT NULL,
    rating_deviation_after  FLOAT      NOT NULL,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE matchmaker_pool
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    technical_name  VARCHAR(255) NOT NULL UNIQUE,
    featured_mod_id INT          NOT NULL REFERENCES game_featuredMods (id),
    leaderboard_id  INT          NOT NULL REFERENCES leaderboard (id),
    name_key        VARCHAR(255) NOT NULL,
    create_time   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT="When using the matchmaker, players will be added to a specific matchmaker pool (e.g. 'ladder1v1', 'ladder2v2'). Players within the same pool can be matched. The pool specifies which featured mod will be played and which leaderboard will be used to look up and update a player''s rating.";
