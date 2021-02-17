-- create a new multi-season table for division scores
CREATE TABLE `ladder_division_score` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`season` MEDIUMINT(8) UNSIGNED NOT NULL,
	`user_id` MEDIUMINT(8) UNSIGNED NOT NULL,
	`league` TINYINT(1) UNSIGNED NOT NULL,
	`score` FLOAT UNSIGNED NOT NULL,
	`games` MEDIUMINT(8) UNSIGNED,
	`create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	UNIQUE `user_for_season` (`season`, `user_id`),
	INDEX `league` (`league`),
	FOREIGN KEY (`user_id`) REFERENCES `login`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- cleanup obsolete entries from existing data
DELETE FROM ladder_season_1 WHERE idUser NOT IN (SELECT id FROM login);
DELETE FROM ladder_season_2 WHERE idUser NOT IN (SELECT id FROM login);
DELETE FROM ladder_season_3 WHERE idUser NOT IN (SELECT id FROM login);
DELETE FROM ladder_season_4 WHERE idUser NOT IN (SELECT id FROM login);
DELETE FROM ladder_season_5 WHERE idUser NOT IN (SELECT id FROM login);


-- merge old ladder season scores
INSERT INTO `ladder_division_score` (`season`, `user_id`, `league`, `score`)
SELECT 1 as season, idUser, league, GREATEST(0.0,score) as score FROM ladder_season_1 UNION -- season 1 allowed negative scores
SELECT 2 as season, idUser, league, GREATEST(0.0,score) as score FROM ladder_season_2 UNION -- season 2 allowed negative scores
SELECT 3 as season, idUser, league, score FROM ladder_season_3 UNION
SELECT 4 as season, idUser, league, score FROM ladder_season_4 UNION
SELECT 5 as season, idUser, league, score FROM ladder_season_5;


-- drop obsolete tables
DROP TABLE ladder_season_1;
DROP TABLE ladder_season_2;
DROP TABLE ladder_season_3;
DROP TABLE ladder_season_4;
DROP TABLE ladder_season_5;