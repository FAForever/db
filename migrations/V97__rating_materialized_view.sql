CREATE TABLE IF NOT EXISTS ladder1v1_rating_rank_view
(
    id        mediumint unsigned             not null,
    ranking   int,
    mean      float                          null,
    deviation float                          null,
    numGames  smallint(4) unsigned default 0 not null,
    winGames  smallint(4) unsigned default 0 not null,
    is_active tinyint(1)           default 0 not null,
    rating    float
);

CREATE TABLE IF NOT EXISTS global_rating_rank_view
(
    id        mediumint unsigned             not null,
    ranking   int,
    mean      float                          null,
    deviation float                          null,
    numGames  smallint(4) unsigned default 0 not null,
    winGames  smallint(4) unsigned default 0 not null,
    is_active tinyint(1)           default 0 not null,
    rating    float
);

DELIMITER $$

CREATE EVENT IF NOT EXISTS `ladder1v1_calculate_ranks_view`
    ON SCHEDULE EVERY 5 MINUTE STARTS CURRENT_TIMESTAMP
    COMMENT 'Fill the materialized view including ranks for ladder'
    DO
    BEGIN
        START TRANSACTION;
        SET @rankLadder = 0;
        DELETE FROM ladder1v1_rating_rank_view;
        INSERT INTO ladder1v1_rating_rank_view(id, ranking, mean, deviation, numGames, winGames, is_active, rating)
        SELECT id,
               @rankLadder := (@rankLadder + 1),
               mean,
               deviation,
               numGames,
               winGames,
               is_active,
               rating
        FROM ladder1v1_rating
        ORDER BY rating DESC;
        COMMIT;
    END $$

DELIMITER ;

DELIMITER $$

CREATE EVENT IF NOT EXISTS `global_calculate_ranks_view`
    ON SCHEDULE EVERY 5 MINUTE STARTS CURRENT_TIMESTAMP
    COMMENT 'Fill the materialized view including ranks for global'
    DO
    BEGIN
        START TRANSACTION;
        SET @rankGlobal = 0;
        DELETE FROM global_rating_rank_view;
        INSERT INTO global_rating_rank_view(id, ranking, mean, deviation, numGames, winGames, is_active, rating)
        SELECT id,
               @rankGlobal := (@rankGlobal + 1),
               mean,
               deviation,
               numGames,
               winGames,
               is_active,
               rating
        FROM ladder1v1_rating
        ORDER BY rating DESC;
        COMMIT;
    END $$

DELIMITER ;