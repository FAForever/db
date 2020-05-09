DROP VIEW `global_rating_distribution`;

CREATE TABLE IF NOT EXISTS `global_rating_distribution` (
    rating DOUBLE PRIMARY KEY,
    count BIGINT
) ENGINE=InnoDB;

ALTER TABLE `global_rating`
ADD INDEX `global_rating_idx_for_rating_distribution` (`is_active`, `numGames`, `mean`, `deviation`);

DELIMITER $$

CREATE EVENT IF NOT EXISTS `global_rating_distribution`
ON SCHEDULE EVERY 1 HOUR STARTS CURRENT_TIMESTAMP
COMMENT 'Recompute the global_rating_distribution table every hour'
DO
    BEGIN
      START TRANSACTION;
      DELETE FROM global_rating_distribution;

      INSERT INTO global_rating_distribution
      SELECT `subq`.`rating`, COUNT(*)
      FROM (
        SELECT floor((`global_rating`.`mean` - 3 * `global_rating`.`deviation`) / 100) * 100 AS `rating`
        FROM `global_rating`
        WHERE `global_rating`.`is_active` = 1 AND `global_rating`.`numGames` > 0
      ) AS `subq`
      GROUP BY `subq`.`rating`
      ORDER BY `subq`.`rating`;
      COMMIT;
    END $$

DELIMITER ;
