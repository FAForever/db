CREATE VIEW global_ranking AS
  SELECT
    global_rating.id,
    @s := @s + 1 rank
  FROM global_rating, (SELECT @s := 0) AS s
  WHERE is_active = 1
  ORDER BY round(mean - 3 * deviation) DESC;

CREATE VIEW ladder1v1_ranking AS
  SELECT
    ladder1v1_rating.id,
    @s := @s + 1 rank
  FROM ladder1v1_rating, (SELECT @s := 0) AS s
  WHERE is_active = 1
  ORDER BY round(mean - 3 * deviation) DESC;
