ALTER TABLE `ladder1v1_rating` ADD COLUMN `rating` FLOAT GENERATED ALWAYS AS (mean - 3 * deviation) STORED;
ALTER TABLE `ladder1v1_rating` ADD INDEX `rating` (`rating`);
ALTER TABLE `global_rating` ADD COLUMN `rating` FLOAT GENERATED ALWAYS AS (mean - 3 * deviation) STORED;
ALTER TABLE `global_rating` ADD INDEX `rating` (`rating`);