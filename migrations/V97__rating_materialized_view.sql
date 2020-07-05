CREATE TABLE IF NOT EXISTS ladder1v1_rating_rank_view
(
    id MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'References to ladder1v1_rating.id',
    ranking INTEGER UNIQUE AUTO_INCREMENT,
    mean FLOAT NULL,
    deviation FLOAT NULL,
    num_games SMALLINT UNSIGNED DEFAULT 0,
    win_games SMALLINT UNSIGNED DEFAULT 0,
    rating FLOAT
) COMMENT='Materialized view including ranks (player position) for ladder1v1_rating';

CREATE TABLE IF NOT EXISTS global_rating_rank_view
(
    id MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'References to global_rating.id',
    ranking INTEGER UNIQUE AUTO_INCREMENT,
    mean FLOAT NULL,
    deviation FLOAT NULL,
    num_games SMALLINT UNSIGNED DEFAULT 0,
    rating FLOAT
) COMMENT='Materialized view including ranks (player position) for global_rating';

DELIMITER $$

CREATE EVENT IF NOT EXISTS `ladder1v1_calculate_ranks_view`
ON SCHEDULE EVERY 1 HOUR STARTS CURRENT_TIMESTAMP
COMMENT 'Fill the materialized view including ranks for ladder'
DO
BEGIN
    CREATE TEMPORARY TABLE active_ladder_players ENGINE=MEMORY AS
    (
        SELECT DISTINCT gps.playerId
        FROM game_player_stats gps
        INNER JOIN game_stats gs on gps.gameId = gs.id
        WHERE gs.endTime > now() - INTERVAL 1 YEAR
          AND gs.gameMod = 6 -- ladder
          AND gs.validity = 0
    );

    DELETE FROM active_ladder_players
    WHERE playerId IN (
        SELECT player_id from ban
        WHERE (expires_at is null or expires_at > NOW()) AND revoke_time IS NULL
    );

    ALTER TABLE ladder1v1_rating_rank_view AUTO_INCREMENT = 1;
    START TRANSACTION;
    TRUNCATE ladder1v1_rating_rank_view;
    INSERT INTO ladder1v1_rating_rank_view(`id`, `mean`, `deviation`, `num_games`, `win_games`, `rating`)
    SELECT ladder1v1_rating.id,
           mean,
           deviation,
           numGames,
           winGames,
           rating
    FROM ladder1v1_rating
    INNER JOIN active_ladder_players ON ladder1v1_rating.id = active_ladder_players.playerId
    ORDER BY rating DESC;

    DROP TABLE active_ladder_players;

    COMMIT;
END $$

CREATE EVENT IF NOT EXISTS `global_calculate_ranks_view`
ON SCHEDULE EVERY 1 HOUR STARTS CURRENT_TIMESTAMP
COMMENT 'Fill the materialized view including ranks for global'
DO
BEGIN
    CREATE TEMPORARY TABLE active_global_players ENGINE=MEMORY AS
    (
        SELECT DISTINCT gps.playerId
        FROM game_player_stats gps
        INNER JOIN game_stats gs on gps.gameId = gs.id
        WHERE gs.endTime > now() - INTERVAL 1 YEAR
          AND gs.gameMod = 0 -- global
          AND gs.validity = 0
    );

    DELETE FROM active_global_players
    WHERE playerId IN (
        SELECT player_id from ban
        WHERE (expires_at is null or expires_at > NOW()) AND revoke_time IS NULL
    );

    ALTER TABLE global_rating_rank_view AUTO_INCREMENT = 1;
    START TRANSACTION;
    TRUNCATE global_rating_rank_view;
    INSERT INTO global_rating_rank_view(`id`, `mean`, `deviation`, `num_games`, `rating`)
    SELECT global_rating.id,
           mean,
           deviation,
           numGames,
           rating
    FROM global_rating
    INNER JOIN active_global_players ON global_rating.id = active_global_players.playerId
    ORDER BY rating DESC;

    DROP TABLE active_global_players;

    COMMIT;
END $$

DELIMITER ;
