DROP VIEW `map_reviews_summary`;

CREATE TABLE IF NOT EXISTS `map_reviews_summary` (
    id MEDIUMINT UNSIGNED PRIMARY KEY,
    map_id MEDIUMINT UNSIGNED UNIQUE REFERENCES `map_version` (`map_id`),
    positive DOUBLE,
    negative DOUBLE,
    score DOUBLE,
    reviews DECIMAL(32,0),
    lower_bound DOUBLE
) ENGINE=InnoDB;


INSERT INTO map_reviews_summary
SELECT `map_version`.`map_id` AS `id`,
       `map_version`.`map_id` AS `map_id`,
       sum(`summary`.`positive`) AS `positive`,
       sum(`summary`.`negative`) AS `negative`,
       sum(`summary`.`score`) AS `score`,
       sum(`summary`.`reviews`) AS `reviews`,
       (sum(`summary`.`weighted_bound`) / sum(`summary`.`reviews`)) AS `lower_bound`
FROM (
  (
    SELECT `map_version_reviews_summary`.`id` AS `id`,
           `map_version_reviews_summary`.`map_version_id` AS `map_version_id`,
           `map_version_reviews_summary`.`positive` AS `positive`,
           `map_version_reviews_summary`.`negative` AS `negative`,
           `map_version_reviews_summary`.`score` AS `score`,
           `map_version_reviews_summary`.`reviews` AS `reviews`,
           `map_version_reviews_summary`.`lower_bound` AS `lower_bound`,
           `map_version_reviews_summary`.`reviews` * `map_version_reviews_summary`.`lower_bound` AS `weighted_bound`
    FROM `map_version_reviews_summary`
  ) `summary`
  JOIN `map_version` on `map_version`.`id` = `summary`.`map_version_id`
)
GROUP BY `map_version`.`map_id`;


DELIMITER $$

CREATE EVENT IF NOT EXISTS `map_reviews_summary`
ON SCHEDULE EVERY 10 MINUTE
COMMENT 'Recompute the map_reviews_summary table every 10 minutes'
DO
    BEGIN
      INSERT INTO map_reviews_summary
        SELECT `map_version`.`map_id` AS `id`,
               `map_version`.`map_id` AS `map_id`,
               sum(`summary`.`positive`) AS `positive`,
               sum(`summary`.`negative`) AS `negative`,
               sum(`summary`.`score`) AS `score`,
               sum(`summary`.`reviews`) AS `reviews`,
               (sum(`summary`.`weighted_bound`) / sum(`summary`.`reviews`)) AS `lower_bound`
        FROM (
          (
            SELECT `map_version_reviews_summary`.`id` AS `id`,
                   `map_version_reviews_summary`.`map_version_id` AS `map_version_id`,
                   `map_version_reviews_summary`.`positive` AS `positive`,
                   `map_version_reviews_summary`.`negative` AS `negative`,
                   `map_version_reviews_summary`.`score` AS `score`,
                   `map_version_reviews_summary`.`reviews` AS `reviews`,
                   `map_version_reviews_summary`.`lower_bound` AS `lower_bound`,
                   `map_version_reviews_summary`.`reviews` * `map_version_reviews_summary`.`lower_bound` AS `weighted_bound`
            FROM `map_version_reviews_summary`
          ) `summary`
          JOIN `map_version` on `map_version`.`id` = `summary`.`map_version_id`
        )
        GROUP BY `map_version`.`map_id`
        ON DUPLICATE KEY UPDATE
            `map_reviews_summary`.`positive` = VALUES(`positive`),
            `map_reviews_summary`.`negative` = VALUES(`negative`),
            `map_reviews_summary`.`score` = VALUES(`score`),
            `map_reviews_summary`.`reviews` = VALUES(`reviews`),
            `map_reviews_summary`.`lower_bound` = VALUES(`lower_bound`)
        ;
    END $$

DELIMITER ;
