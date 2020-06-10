ALTER TABLE avatars_list ADD COLUMN `filename` VARCHAR(212);

UPDATE avatars_list SET filename=REPLACE(url, 'https://content.faforever.com/faf/avatars/', '');

ALTER TABLE avatars_list MODIFY `filename` VARCHAR(212) NOT NULL;

ALTER TABLE avatars_list DROP INDEX `url`;

ALTER TABLE avatars_list DROP COLUMN `url`;

ALTER TABLE `avatars_list` ADD COLUMN `url` VARCHAR(255) GENERATED ALWAYS AS (CONCAT('https://content.faforever.com/faf/avatars/', filename)) VIRTUAL;

ALTER TABLE `avatars_list` ADD CONSTRAINT `filename` UNIQUE (`filename`, `tooltip`);