DROP VIEW `ladder1v1_rating_distribution`;

CREATE TABLE IF NOT EXISTS `ladder1v1_rating_distribution` (
    rating DOUBLE PRIMARY KEY,
    count BIGINT
) ENGINE=InnoDB;

ALTER TABLE `ladder1v1_rating`
ADD INDEX `ladder1v1_rating_idx_for_rating_distribution` (`is_active`, `numGames`, `mean`, `deviation`);

INSERT INTO ladder1v1_rating_distribution
SELECT `subq`.`rating`, COUNT(*)
FROM (
  SELECT floor((`ladder1v1_rating`.`mean` - 3 * `ladder1v1_rating`.`deviation`) / 100) * 100 AS `rating`
  FROM `ladder1v1_rating`
  WHERE `ladder1v1_rating`.`is_active` = 1 AND `ladder1v1_rating`.`numGames` > 0
) AS `subq`
GROUP BY `subq`.`rating`
ORDER BY `subq`.`rating`;

DELIMITER $$

CREATE EVENT IF NOT EXISTS `ladder1v1_rating_distribution`
ON SCHEDULE EVERY 1 HOUR
COMMENT 'Recompute the ladder1v1_rating_distribution table every hour'
DO
    BEGIN
      START TRANSACTION;
      DELETE FROM ladder1v1_rating_distribution;

      INSERT INTO ladder1v1_rating_distribution
      SELECT `subq`.`rating`, COUNT(*)
      FROM (
        SELECT floor((`ladder1v1_rating`.`mean` - 3 * `ladder1v1_rating`.`deviation`) / 100) * 100 AS `rating`
        FROM `ladder1v1_rating`
        WHERE `ladder1v1_rating`.`is_active` = 1 AND `ladder1v1_rating`.`numGames` > 0
      ) AS `subq`
      GROUP BY `subq`.`rating`
      ORDER BY `subq`.`rating`;
      COMMIT;
    END $$

DELIMITER ;
