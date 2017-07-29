-- Reorganize reviews to not share a `reviews` table since it makes things pretty complex especially with triggers.
ALTER TABLE map_version_review
  DROP FOREIGN KEY map_version_review.review_to_map_version,
  DROP FOREIGN KEY map_version_review.map_version_to_review,
  DROP PRIMARY KEY,
  ADD `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  ADD `user_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  ADD `score` TINYINT NOT NULL,
  ADD `text` TEXT NULL,
  MODIFY COLUMN map_version_id MEDIUMINT(8) UNSIGNED NOT NULL
  AFTER id,
  ADD COLUMN `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
UPDATE map_version_review
  JOIN review ON review.id = map_version_review.review_id
SET map_version_review.text      = review.text,
  map_version_review.score       = review.score,
  map_version_review.user_id     = review.user_id,
  map_version_review.create_time = review.create_time,
  map_version_review.update_time = review.update_time;
ALTER TABLE map_version_review
  ADD FOREIGN KEY user_id_to_login (user_id) REFERENCES login (id),
  ADD FOREIGN KEY map_version_review_to_map_version (map_version_id) REFERENCES map_version (id),
  DROP `review_id`;

ALTER TABLE mod_version_review
  DROP FOREIGN KEY mod_version_review.review_to_mod_version,
  DROP FOREIGN KEY mod_version_review.mod_version_to_review,
  DROP PRIMARY KEY,
  ADD `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  ADD `user_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  ADD `score` TINYINT NOT NULL,
  ADD `text` TEXT NULL,
  MODIFY COLUMN mod_version_id MEDIUMINT(8) UNSIGNED NOT NULL
  AFTER id,
  ADD COLUMN `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
UPDATE mod_version_review
  JOIN review ON review.id = mod_version_review.review_id
SET mod_version_review.text      = review.text,
  mod_version_review.score       = review.score,
  mod_version_review.user_id     = review.user_id,
  mod_version_review.create_time = review.create_time,
  mod_version_review.update_time = review.update_time;
ALTER TABLE mod_version_review
  ADD FOREIGN KEY user_id_to_login (user_id) REFERENCES login (id),
  ADD FOREIGN KEY mod_version_review_to_map_version (mod_version_id) REFERENCES mod_version (id),
  DROP `review_id`;

ALTER TABLE game_review
  DROP FOREIGN KEY game_review.review_to_game;
ALTER TABLE game_review
  DROP FOREIGN KEY game_review.game_to_review;

ALTER TABLE game_review
  DROP PRIMARY KEY;
ALTER TABLE game_review
  ADD `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  ADD `user_id` MEDIUMINT(8) UNSIGNED NOT NULL,
  ADD `score` TINYINT NOT NULL,
  ADD `text` TEXT NULL,
  MODIFY COLUMN game_id INT(10) UNSIGNED NOT NULL
  AFTER id,
  ADD COLUMN `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

UPDATE game_review
  JOIN review ON review.id = game_review.review_id
SET game_review.text      = review.text,
  game_review.score       = review.score,
  game_review.user_id     = review.user_id,
  game_review.create_time = review.create_time,
  game_review.update_time = review.update_time;
ALTER TABLE game_review
  ADD FOREIGN KEY user_id_to_login (user_id) REFERENCES login (id),
  ADD FOREIGN KEY game_review_to_game_stats (game_id) REFERENCES game_stats (id),
  DROP `review_id`;

DROP TABLE review;

-- Add columns `average_review_score` and `reviews` to `map`
ALTER TABLE map
  ADD average_review_score DOUBLE DEFAULT 0 NOT NULL;
CREATE INDEX map_average_review_score_index
  ON map (average_review_score DESC);
ALTER TABLE map
  ADD reviews INT DEFAULT 0 NOT NULL;
ALTER TABLE map
  MODIFY COLUMN update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT 'When this entry was updated'
  AFTER reviews,
  MODIFY COLUMN create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT 'When this entry was created.'
  AFTER reviews;

-- Add columns `average_review_score` and `reviews` to `map_version`
ALTER TABLE map_version
  ADD average_review_score DOUBLE DEFAULT 0 NOT NULL;
CREATE INDEX map_version_average_review_score_index
  ON map_version (average_review_score DESC);
ALTER TABLE map_version
  ADD reviews INT DEFAULT 0 NOT NULL;
ALTER TABLE map_version
  MODIFY COLUMN update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT 'When this entry was updated'
  AFTER reviews,
  MODIFY COLUMN create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT 'When this entry was created.'
  AFTER reviews;

-- Define a procedure that recalculates review summaries (average score, number of reviews) for `map_version` and `map`.
DROP PROCEDURE IF EXISTS update_map_review_summary;

DELIMITER //
CREATE PROCEDURE update_map_review_summary(IN map_version_id INT)
READS SQL DATA
  BEGIN
    -- Update average review score and number of reviews in table `map_version`
    SELECT
      COALESCE(AVG(score), 0),
      COALESCE(count(*), 0)
    INTO @averageScore, @reviews
    FROM map_version_review
    WHERE map_version_review.map_version_id = map_version_id;

    UPDATE map_version
    SET map_version.average_review_score = @averageScore,
      map_version.reviews                = @reviews
    WHERE id = map_version_id;

    -- Update average review score and number of reviews of all other map versions belonging to the same map
    SELECT
      COALESCE(AVG(score), 0),
      COALESCE(count(*), 0)
    INTO @averageScore, @reviews
    FROM map_version_review
      JOIN map_version ON map_version_review.map_version_id = map_version.id
    WHERE map_version.map_id =
          (SELECT new_version.map_id
           FROM map_version new_version
           WHERE new_version.id = map_version_id);

    UPDATE map
      JOIN map_version ON map.id = map_version.map_id
    SET map.average_review_score = @averageScore,
      map.reviews                = @reviews
    WHERE map_version.id = map_version_id;
  END//

-- Create triggers to call the procedure above whenever a map version review is added, updated or deleted.
DROP TRIGGER IF EXISTS update_average_map_review_scores_on_insert//
CREATE TRIGGER update_average_map_review_scores_on_insert
AFTER INSERT ON map_version_review
FOR EACH ROW
  BEGIN
    CALL update_map_review_summary(NEW.map_version_id);
  END//
DROP TRIGGER IF EXISTS update_average_map_review_scores_on_update//
CREATE TRIGGER update_average_map_review_scores_on_update
AFTER UPDATE ON map_version_review
FOR EACH ROW
  BEGIN
    CALL update_map_review_summary(NEW.map_version_id);
  END//
DROP TRIGGER IF EXISTS update_average_map_review_scores_on_delete//
CREATE TRIGGER update_average_map_review_scores_on_delete
AFTER DELETE ON map_version_review
FOR EACH ROW
  BEGIN
    CALL update_map_review_summary(OLD.map_version_id);
  END//
DELIMITER ;

-- --------------------------------------
-- --------------------------------------
-- --------------------------------------

-- Add columns `average_review_score` and `reviews` to `mod`
ALTER TABLE `mod`
  ADD average_review_score DOUBLE DEFAULT 0 NOT NULL;
CREATE INDEX mod_average_review_score_index
  ON `mod` (average_review_score DESC);
ALTER TABLE `mod`
  ADD reviews INT DEFAULT 0 NOT NULL;
ALTER TABLE `mod`
  MODIFY COLUMN update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT 'When this entry was updated'
  AFTER reviews,
  MODIFY COLUMN create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT 'When this entry was created.'
  AFTER reviews;

-- Add columns `average_review_score` and `reviews` to `mod_version`
ALTER TABLE mod_version
  ADD average_review_score DOUBLE DEFAULT 0 NOT NULL;
CREATE INDEX mod_version_average_review_score_index
  ON mod_version (average_review_score DESC);
ALTER TABLE mod_version
  ADD reviews INT DEFAULT 0 NOT NULL;
ALTER TABLE mod_version
  MODIFY COLUMN update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT 'When this entry was updated'
  AFTER reviews,
  MODIFY COLUMN create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT 'When this entry was created.'
  AFTER reviews;

-- Define a procedure that recalculates review summaries (average score, number of reviews) for `mod_version` and `mod`.
DROP PROCEDURE IF EXISTS update_mod_review_summary;

DELIMITER //
CREATE PROCEDURE update_mod_review_summary(IN mod_version_id INT)
READS SQL DATA
  BEGIN
    -- Update average review score and number of reviews in table `mod_version`
    SELECT
      COALESCE(AVG(score), 0),
      COALESCE(count(*), 0)
    INTO @averageScore, @reviews
    FROM mod_version_review
    WHERE mod_version_review.mod_version_id = mod_version_id;

    UPDATE mod_version
    SET mod_version.average_review_score = @averageScore,
      mod_version.reviews                = @reviews
    WHERE id = mod_version_id;

    -- Update average review score and number of reviews of all other mod versions belonging to the same mod
    SELECT
      COALESCE(AVG(score), 0),
      COALESCE(count(*), 0)
    INTO @averageScore, @reviews
    FROM mod_version_review
      JOIN mod_version ON mod_version_review.mod_version_id = mod_version.id
    WHERE mod_version.mod_id =
          (SELECT new_version.mod_id
           FROM mod_version new_version
           WHERE new_version.id = mod_version_id);

    UPDATE `mod`
      JOIN mod_version ON `mod`.id = mod_version.mod_id
    SET `mod`.average_review_score = @averageScore,
      `mod`.reviews                = @reviews
    WHERE mod_version.id = mod_version_id;
  END//

-- Create triggers to call the procedure above whenever a mod version review is added, updated or deleted.
DROP TRIGGER IF EXISTS update_average_mod_review_scores_on_insert//
CREATE TRIGGER update_average_mod_review_scores_on_insert
AFTER INSERT ON mod_version_review
FOR EACH ROW
  BEGIN
    CALL update_mod_review_summary(NEW.mod_version_id);
  END//
DROP TRIGGER IF EXISTS update_average_map_review_scores_on_update//
CREATE TRIGGER update_average_mod_review_scores_on_update
AFTER UPDATE ON mod_version_review
FOR EACH ROW
  BEGIN
    CALL update_mod_review_summary(NEW.mod_version_id);
  END//
DROP TRIGGER IF EXISTS update_average_map_review_scores_on_delete//
CREATE TRIGGER update_average_mod_review_scores_on_delete
AFTER DELETE ON mod_version_review
FOR EACH ROW
  BEGIN
    CALL update_mod_review_summary(OLD.mod_version_id);
  END//
DELIMITER ;

-- --------------------------------------
-- --------------------------------------
-- --------------------------------------

-- Add columns `average_review_score` and `reviews` to `game_stats`
ALTER TABLE `game_stats`
  ADD average_review_score DOUBLE DEFAULT 0 NOT NULL;
CREATE INDEX game_stats_average_review_score_index
  ON `game_stats` (average_review_score DESC);
ALTER TABLE `game_stats`
  ADD reviews INT DEFAULT 0 NOT NULL;

-- Define a procedure that recalculates review summaries (average score, number of reviews) for `game_stats`.
DROP PROCEDURE IF EXISTS update_game_review_summary;

DELIMITER //
CREATE PROCEDURE update_game_review_summary(IN game_id INT)
READS SQL DATA
  BEGIN
    -- Update average review score and number of reviews in table `game_stats`
    SELECT
      COALESCE(AVG(score), 0),
      COALESCE(count(*), 0)
    INTO @averageScore, @reviews
    FROM game_review
    WHERE game_review.game_id = game_id;

    UPDATE game_stats
    SET game_stats.average_review_score = @averageScore,
      game_stats.reviews                = @reviews
    WHERE id = game_id;
  END//

-- Create triggers to call the procedure above whenever a game review is added, updated or deleted.
DROP TRIGGER IF EXISTS update_average_game_review_scores_on_insert//
CREATE TRIGGER update_average_game_review_scores_on_insert
AFTER INSERT ON game_review
FOR EACH ROW
  BEGIN
    CALL update_game_review_summary(NEW.game_id);
  END//
DROP TRIGGER IF EXISTS update_average_map_review_scores_on_update//
CREATE TRIGGER update_average_game_review_scores_on_update
AFTER UPDATE ON game_review
FOR EACH ROW
  BEGIN
    CALL update_game_review_summary(NEW.game_id);
  END//
DROP TRIGGER IF EXISTS update_average_map_review_scores_on_delete//
CREATE TRIGGER update_average_game_review_scores_on_delete
AFTER DELETE ON game_review
FOR EACH ROW
  BEGIN
    CALL update_game_review_summary(OLD.game_id);
  END//
DELIMITER ;
