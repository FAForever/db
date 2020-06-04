ALTER TABLE avatars_list ADD COLUMN `filename` VARCHAR(255);

UPDATE avatars_list SET filename=REPLACE(url, 'https://content.faforever.com/faf/avatars/', '');

ALTER TABLE avatars_list MODIFY `filename` VARCHAR(255) NOT NULL;

ALTER TABLE avatars_list DROP COLUMN `url`;

ALTER TABLE `avatars_list` ADD COLUMN `url` VARCHAR(255) GENERATED ALWAYS AS (CONCAT('https://content.faforever.com/faf/avatars/', filename)) STORED;