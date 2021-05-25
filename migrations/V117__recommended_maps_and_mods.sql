-- Add recommended column to map
ALTER TABLE `map`
    ADD COLUMN `recommended` boolean NOT NULL DEFAULT false COMMENT 'Boolean to indicate if a map is a high quality FAF Map' AFTER `games_played`;

-- Add recommended column to mod
ALTER TABLE `mod`
    ADD COLUMN `recommended` boolean NOT NULL DEFAULT false COMMENT 'Boolean to indicate if a mod is a high quality FAF Mod' AFTER `reviews`;