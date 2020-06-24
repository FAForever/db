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
    ALTER TABLE ladder1v1_rating_rank_view AUTO_INCREMENT = 1, ALGORITHM=INPLACE;
    START TRANSACTION;
    DELETE FROM ladder1v1_rating_rank_view;
    INSERT INTO ladder1v1_rating_rank_view(`id`, `mean`, `deviation`, `num_games`, `win_games`, `rating`)
    SELECT id,
           mean,
           deviation,
           numGames,
           winGames,
           rating
    FROM ladder1v1_rating
    WHERE is_active = 1
    ORDER BY rating DESC;
    COMMIT;
END $$

CREATE EVENT IF NOT EXISTS `global_calculate_ranks_view`
ON SCHEDULE EVERY 1 HOUR STARTS CURRENT_TIMESTAMP
COMMENT 'Fill the materialized view including ranks for global'
DO
BEGIN
    ALTER TABLE global_rating_rank_view AUTO_INCREMENT = 1, ALGORITHM=INPLACE;
    START TRANSACTION;
    DELETE FROM global_rating_rank_view;
    INSERT INTO global_rating_rank_view(`id`, `mean`, `deviation`, `num_games`, `rating`)
    SELECT id,
           mean,
           deviation,
           numGames,
           rating
    FROM global_rating
    WHERE is_active = 1
    ORDER BY rating DESC;
    COMMIT;
END $$

DELIMITER ;
