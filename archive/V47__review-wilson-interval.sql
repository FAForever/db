--
--
--
-- Game
--
--
--

DROP TRIGGER IF EXISTS update_average_game_review_scores_on_delete;
DROP TRIGGER IF EXISTS update_average_game_review_scores_on_insert;
DROP TRIGGER IF EXISTS update_average_game_review_scores_on_update;
DROP PROCEDURE IF EXISTS update_game_reviews_summary;
ALTER TABLE game_stats
  DROP COLUMN average_review_score,
  DROP COLUMN reviews;

DROP TABLE IF EXISTS game_reviews_summary;
CREATE TABLE game_reviews_summary (
  `id`          INT UNSIGNED          NOT NULL              AUTO_INCREMENT,
  `game_id`     INT UNSIGNED UNIQUE   NOT NULL,
  CONSTRAINT game_reviews_summary_game FOREIGN KEY (`game_id`) REFERENCES game_stats (id),
  `positive`    FLOAT                 NOT NULL
  COMMENT 'The ''positive'' share of the rating',
  `negative`    FLOAT                 NOT NULL
  COMMENT 'The ''negative'' share of the rating',
  `score`       FLOAT                 NOT NULL
  COMMENT 'The sum of all scores',
  `reviews`     INT                   NOT NULL
  COMMENT 'The sum of all ''negative'' and ''positive'' shares. Equals to the number of reviews.',
  `lower_bound` FLOAT                 NOT NULL
  COMMENT 'Lower bound of Wilson score confidence interval for a Bernoulli parameter',
  PRIMARY KEY (`id`)
)
  COMMENT 'Summary of all game reviews. Entries are created and updated by triggers.';

-- Move all data to a temporary table so it can later be re-inserted with new triggers
DROP TABLE IF EXISTS game_review_tmp;
CREATE TEMPORARY TABLE game_review_tmp AS
  SELECT *
  FROM game_review;

DROP TRIGGER IF EXISTS update_game_reviews_summary_after_update;
DROP TRIGGER IF EXISTS update_game_reviews_summary_after_delete;
DROP TRIGGER IF EXISTS update_game_reviews_summary_after_insert;
DELETE FROM game_review;

DELIMITER $$
DROP PROCEDURE IF EXISTS update_game_reviews_summary$$
CREATE PROCEDURE update_game_reviews_summary(p_game_id INT UNSIGNED)
MODIFIES SQL DATA
  BEGIN
    SELECT
      IFNULL(sum((score - 1) * 0.25), 0),
      IFNULL(sum(1 - (score - 1) * 0.25), 0),
      IFNULL(sum(score), 0),
      IFNULL(count(*), 0)
    INTO @new_positive, @new_negative, @new_score, @new_reviews
    FROM game_review
    WHERE game_id = p_game_id;

    -- See https://onextrapixel.com/how-to-build-a-5-star-rating-system-with-wilson-interval-in-mysql/
    SET @new_lower_bound = IFNULL(
        ((@new_positive + 1.9208) / IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1) -
         1.96 * SQRT((@new_positive * @new_negative) / (@new_positive + @new_negative) + 0.9604) /
         IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1)) /
        (1 + 3.8416 / IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1)), 0);

    INSERT INTO game_reviews_summary (game_id, positive, negative, score, reviews, lower_bound)
    VALUES (p_game_id, @new_positive, @new_negative, @new_score, @new_reviews, @new_lower_bound)
    ON DUPLICATE KEY UPDATE
      positive    = @new_positive,
      negative    = @new_negative,
      score       = @new_score,
      reviews     = @new_reviews,
      lower_bound = @new_lower_bound;
  END$$

-- Create triggers to call the procedure above whenever a game review is added, updated or deleted.
CREATE TRIGGER update_game_reviews_summary_after_insert
AFTER INSERT ON game_review
FOR EACH ROW
  BEGIN
    CALL update_game_reviews_summary(NEW.game_id);
  END$$

CREATE TRIGGER update_game_reviews_summary_after_update
AFTER UPDATE ON game_review
FOR EACH ROW
  BEGIN
    CALL update_game_reviews_summary(NEW.game_id);
  END$$

CREATE TRIGGER update_game_reviews_summary_after_delete
AFTER DELETE ON game_review
FOR EACH ROW
  BEGIN
    CALL update_game_reviews_summary(OLD.game_id);
  END$$
DELIMITER ;

ALTER TABLE game_review
  ADD CONSTRAINT unique_game_user UNIQUE (game_id, user_id);
INSERT game_review SELECT *
                   FROM game_review_tmp;
DROP TABLE game_review_tmp;

--
--
--
-- Map
--
--
--
DROP TRIGGER IF EXISTS update_average_map_review_scores_on_insert;

DROP PROCEDURE IF EXISTS update_map_reviews_summary;
ALTER TABLE map_version
  DROP COLUMN average_review_score,
  DROP COLUMN reviews;

DROP TABLE IF EXISTS map_version_reviews_summary;
CREATE TABLE map_version_reviews_summary (
  `id`             INT UNSIGNED                NOT NULL              AUTO_INCREMENT,
  `map_version_id` MEDIUMINT UNSIGNED UNIQUE   NOT NULL,
  CONSTRAINT map_version_reviews_summary_map_version FOREIGN KEY (`map_version_id`) REFERENCES map_version (id),
  `positive`       FLOAT                       NOT NULL
  COMMENT 'The ''positive'' share of the rating',
  `negative`       FLOAT                       NOT NULL
  COMMENT 'The ''negative'' share of the rating',
  `score`          FLOAT                       NOT NULL
  COMMENT 'The sum of all scores',
  `reviews`        INT                         NOT NULL
  COMMENT 'The sum of all ''negative'' and ''positive'' shares. Equals to the number of reviews.',
  `lower_bound`    FLOAT                       NOT NULL
  COMMENT 'Lower bound of Wilson score confidence interval for a Bernoulli parameter',
  PRIMARY KEY (`id`)
)
  COMMENT 'Summary of all map version reviews. Entries are created and updated by triggers.';

CREATE VIEW map_reviews_summary AS
  SELECT
    -- Keep an `id` field to easily allow us to switch to a table later 
    map_id                                             AS id,
    map_id                                             AS map_id,
    sum(positive)                                      AS positive,
    sum(negative)                                      AS negative,
    sum(score)                                         AS score,
    sum(reviews)                                       AS reviews,
    sum(summary.weighted_bound) / sum(summary.reviews) AS lower_bound
  FROM (SELECT
          *,
          reviews * lower_bound AS weighted_bound
        FROM map_version_reviews_summary) summary
    JOIN map_version ON map_version.id = summary.map_version_id
  GROUP BY map_id;

DROP TABLE IF EXISTS map_version_review_tmp;
CREATE TEMPORARY TABLE map_version_review_tmp AS
  SELECT *
  FROM map_version_review;

DROP TRIGGER IF EXISTS update_map_version_reviews_summary_after_update;
DROP TRIGGER IF EXISTS update_map_version_reviews_summary_after_delete;
DROP TRIGGER IF EXISTS update_map_version_reviews_summary_after_insert;
DELETE FROM map_version_review;

DELIMITER $$
DROP PROCEDURE IF EXISTS update_map_version_reviews_summary$$
CREATE PROCEDURE update_map_version_reviews_summary(p_map_version_id INT UNSIGNED)
MODIFIES SQL DATA
  BEGIN
    SELECT
      IFNULL(sum((score - 1) * 0.25), 0),
      IFNULL(sum(1 - (score - 1) * 0.25), 0),
      IFNULL(sum(score), 0),
      IFNULL(count(*), 0)
    INTO @new_positive, @new_negative, @new_score, @new_reviews
    FROM map_version_review
    WHERE map_version_id = p_map_version_id;

    -- See https://onextrapixel.com/how-to-build-a-5-star-rating-system-with-wilson-interval-in-mysql/
    SET @new_lower_bound = IFNULL(
        ((@new_positive + 1.9208) / IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1) -
         1.96 * SQRT((@new_positive * @new_negative) / (@new_positive + @new_negative) + 0.9604) /
         IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1)) /
        (1 + 3.8416 / IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1)), 0);

    INSERT INTO map_version_reviews_summary (map_version_id, positive, negative, score, reviews, lower_bound)
    VALUES (p_map_version_id, @new_positive, @new_negative, @new_score, @new_reviews, @new_lower_bound)
    ON DUPLICATE KEY UPDATE
      positive    = @new_positive,
      negative    = @new_negative,
      score       = @new_score,
      reviews     = @new_reviews,
      lower_bound = @new_lower_bound;
  END$$

-- Create triggers to call the procedure above whenever a map version review is added, updated or deleted.
CREATE TRIGGER update_map_version_reviews_summary_after_insert
AFTER INSERT ON map_version_review
FOR EACH ROW
  BEGIN
    CALL update_map_version_reviews_summary(NEW.map_version_id);
  END$$

CREATE TRIGGER update_map_version_reviews_summary_after_update
AFTER UPDATE ON map_version_review
FOR EACH ROW
  BEGIN
    CALL update_map_version_reviews_summary(NEW.map_version_id);
  END$$

CREATE TRIGGER update_map_version_reviews_summary_after_delete
AFTER DELETE ON map_version_review
FOR EACH ROW
  BEGIN
    CALL update_map_version_reviews_summary(OLD.map_version_id);
  END$$
DELIMITER ;

ALTER TABLE map_version_review
  ADD CONSTRAINT unique_map_version_user UNIQUE (map_version_id, user_id);
INSERT map_version_review SELECT *
                          FROM map_version_review_tmp;
DROP TABLE map_version_review_tmp;

--
--
--
-- Mod
--
--
--
DROP TRIGGER IF EXISTS update_average_mod_review_scores_on_insert;
DROP TRIGGER IF EXISTS update_average_mod_review_scores_on_update;
DROP TRIGGER IF EXISTS update_average_mod_review_scores_on_delete;

DROP PROCEDURE IF EXISTS update_mod_reviews_summary;
ALTER TABLE mod_version
  DROP COLUMN average_review_score,
  DROP COLUMN reviews;

DROP TABLE IF EXISTS mod_version_reviews_summary;
CREATE TABLE mod_version_reviews_summary (
  `id`             INT UNSIGNED                NOT NULL              AUTO_INCREMENT,
  `mod_version_id` MEDIUMINT UNSIGNED UNIQUE   NOT NULL,
  CONSTRAINT mod_version_reviews_summary_mod_version FOREIGN KEY (`mod_version_id`) REFERENCES mod_version (id),
  `positive`       FLOAT                       NOT NULL
  COMMENT 'The ''positive'' share of the rating',
  `negative`       FLOAT                       NOT NULL
  COMMENT 'The ''negative'' share of the rating',
  `score`          FLOAT                       NOT NULL
  COMMENT 'The sum of all scores',
  `reviews`        INT                         NOT NULL
  COMMENT 'The sum of all ''negative'' and ''positive'' shares. Equals to the number of reviews.',
  `lower_bound`    FLOAT                       NOT NULL
  COMMENT 'Lower bound of Wilson score confidence interval for a Bernoulli parameter',
  PRIMARY KEY (`id`)
)
  COMMENT 'Summary of all mod version reviews. Entries are created and updated by triggers.';

CREATE VIEW mod_reviews_summary AS
  SELECT
    -- Keep an `id` field to easily allow us to switch to a table later 
    mod_id                                             AS id,
    mod_id                                             AS mod_id,
    sum(positive)                                      AS positive,
    sum(negative)                                      AS negative,
    sum(score)                                         AS score,
    sum(reviews)                                       AS reviews,
    sum(summary.weighted_bound) / sum(summary.reviews) AS lower_bound
  FROM (SELECT
          *,
          reviews * lower_bound AS weighted_bound
        FROM mod_version_reviews_summary) summary
    JOIN mod_version ON mod_version.id = summary.mod_version_id
  GROUP BY mod_id;

DROP TABLE IF EXISTS mod_version_review_tmp;
CREATE TEMPORARY TABLE mod_version_review_tmp AS
  SELECT *
  FROM mod_version_review;

DROP TRIGGER IF EXISTS update_mod_version_reviews_summary_after_update;
DROP TRIGGER IF EXISTS update_mod_version_reviews_summary_after_delete;
DROP TRIGGER IF EXISTS update_mod_version_reviews_summary_after_insert;
DELETE FROM mod_version_review;

DELIMITER $$
DROP PROCEDURE IF EXISTS update_mod_version_reviews_summary$$
CREATE PROCEDURE update_mod_version_reviews_summary(p_mod_version_id INT UNSIGNED)
MODIFIES SQL DATA
  BEGIN
    SELECT
      IFNULL(sum((score - 1) * 0.25), 0),
      IFNULL(sum(1 - (score - 1) * 0.25), 0),
      IFNULL(sum(score), 0),
      IFNULL(count(*), 0)
    INTO @new_positive, @new_negative, @new_score, @new_reviews
    FROM mod_version_review
    WHERE mod_version_id = p_mod_version_id;

    -- See https://onextrapixel.com/how-to-build-a-5-star-rating-system-with-wilson-interval-in-mysql/
    SET @new_lower_bound = IFNULL(
        ((@new_positive + 1.9208) / IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1) -
         1.96 * SQRT((@new_positive * @new_negative) / (@new_positive + @new_negative) + 0.9604) /
         IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1)) /
        (1 + 3.8416 / IF(@new_positive + @new_negative != 0, @new_positive + @new_negative, 1)), 0);

    INSERT INTO mod_version_reviews_summary (mod_version_id, positive, negative, score, reviews, lower_bound)
    VALUES (p_mod_version_id, @new_positive, @new_negative, @new_score, @new_reviews, @new_lower_bound)
    ON DUPLICATE KEY UPDATE
      positive    = @new_positive,
      negative    = @new_negative,
      score       = @new_score,
      reviews     = @new_reviews,
      lower_bound = @new_lower_bound;
  END$$

-- Create triggers to call the procedure above whenever a mod version review is added, updated or deleted.
CREATE TRIGGER update_mod_version_reviews_summary_after_insert
AFTER INSERT ON mod_version_review
FOR EACH ROW
  BEGIN
    CALL update_mod_version_reviews_summary(NEW.mod_version_id);
  END$$

CREATE TRIGGER update_mod_version_reviews_summary_after_update
AFTER UPDATE ON mod_version_review
FOR EACH ROW
  BEGIN
    CALL update_mod_version_reviews_summary(NEW.mod_version_id);
  END$$

CREATE TRIGGER update_mod_version_reviews_summary_after_delete
AFTER DELETE ON mod_version_review
FOR EACH ROW
  BEGIN
    CALL update_mod_version_reviews_summary(OLD.mod_version_id);
  END$$
DELIMITER ;

ALTER TABLE mod_version_review
  ADD CONSTRAINT unique_mod_version_user UNIQUE (mod_version_id, user_id);
INSERT mod_version_review SELECT *
                          FROM mod_version_review_tmp;
DROP TABLE mod_version_review_tmp;


SHOW TRIGGERS;
