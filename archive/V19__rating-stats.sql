CREATE VIEW `global_rating_distribution` AS
  SELECT
    FLOOR((mean - 3 * deviation) / 100) * 100 AS `rating`,
    count(*)                                  AS `count`
  FROM `global_rating`
  WHERE `is_active` = 1 AND numGames > 0
  GROUP BY `rating`
  ORDER BY CAST(`rating` AS SIGNED) ASC;

CREATE VIEW `ladder1v1_rating_distribution` AS
  SELECT
    FLOOR((mean - 3 * deviation) / 100) * 100 AS `rating`,
    count(*)                                  AS `count`
  FROM `ladder1v1_rating`
  WHERE `is_active` = 1 AND numGames > 0
  GROUP BY `rating`
  ORDER BY CAST(`rating` AS SIGNED) ASC;
