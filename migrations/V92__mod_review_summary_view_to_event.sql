
DROP VIEW `mod_reviews_summary`;

CREATE TABLE IF NOT EXISTS `mod_reviews_summary` (
    id MEDIUMINT UNSIGNED PRIMARY KEY,
    mod_id MEDIUMINT UNSIGNED UNIQUE REFERENCES `mod` (`id`),
    positive DOUBLE,
    negative DOUBLE,
    score DOUBLE,
    reviews DECIMAL(32,0),
    lower_bound DOUBLE NULL
) ENGINE=InnoDB;


INSERT INTO mod_reviews_summary
SELECT `mod_version`.`mod_id` AS `id`,
       `mod_version`.`mod_id` AS `mod_id`,
       sum(`summary`.`positive`) AS `positive`,
       sum(`summary`.`negative`) AS `negative`,
       sum(`summary`.`score`) AS `score`,
       sum(`summary`.`reviews`) AS `reviews`,
       IF(sum(`summary`.`reviews`) = 0, NULL, sum(`summary`.`weighted_bound`) / sum(`summary`.`reviews`)) AS `lower_bound`
FROM (
       (SELECT `mod_version_reviews_summary`.`id` AS `id`,
               `mod_version_reviews_summary`.`mod_version_id` AS `mod_version_id`,
               `mod_version_reviews_summary`.`positive` AS `positive`,
               `mod_version_reviews_summary`.`negative` AS `negative`,
               `mod_version_reviews_summary`.`score` AS `score`,
               `mod_version_reviews_summary`.`reviews` AS `reviews`,
               `mod_version_reviews_summary`.`lower_bound` AS `lower_bound`,
               `mod_version_reviews_summary`.`reviews` * `mod_version_reviews_summary`.`lower_bound` AS `weighted_bound`
        FROM `mod_version_reviews_summary`
      ) `summary`
      JOIN `mod_version` ON `mod_version`.`id` = `summary`.`mod_version_id`
)
GROUP BY `mod_version`.`mod_id`;

DELIMITER $$

CREATE EVENT IF NOT EXISTS `mod_reviews_summary`
ON SCHEDULE EVERY 10 MINUTE
COMMENT 'Recompute the mod_reviews_summary table every 10 minutes'
DO
    BEGIN
      INSERT INTO mod_reviews_summary
      SELECT `mod_version`.`mod_id` AS `id`,
             `mod_version`.`mod_id` AS `mod_id`,
             sum(`summary`.`positive`) AS `positive`,
             sum(`summary`.`negative`) AS `negative`,
             sum(`summary`.`score`) AS `score`,
             sum(`summary`.`reviews`) AS `reviews`,
             IF(sum(`summary`.`reviews`) = 0, NULL, sum(`summary`.`weighted_bound`) / sum(`summary`.`reviews`)) AS `lower_bound`
      FROM (
             (SELECT `mod_version_reviews_summary`.`id` AS `id`,
                     `mod_version_reviews_summary`.`mod_version_id` AS `mod_version_id`,
                     `mod_version_reviews_summary`.`positive` AS `positive`,
                     `mod_version_reviews_summary`.`negative` AS `negative`,
                     `mod_version_reviews_summary`.`score` AS `score`,
                     `mod_version_reviews_summary`.`reviews` AS `reviews`,
                     `mod_version_reviews_summary`.`lower_bound` AS `lower_bound`,
                     `mod_version_reviews_summary`.`reviews` * `mod_version_reviews_summary`.`lower_bound` AS `weighted_bound`
              FROM `mod_version_reviews_summary`
            ) `summary`
            JOIN `mod_version` ON `mod_version`.`id` = `summary`.`mod_version_id`
      )
      GROUP BY `mod_version`.`mod_id`
      ON DUPLICATE KEY UPDATE
          `mod_reviews_summary`.`positive` = VALUES(`positive`),
          `mod_reviews_summary`.`negative` = VALUES(`negative`),
          `mod_reviews_summary`.`score` = VALUES(`score`),
          `mod_reviews_summary`.`reviews` = VALUES(`reviews`),
          `mod_reviews_summary`.`lower_bound` = VALUES(`lower_bound`)
      ;
    END $$

DELIMITER ;

