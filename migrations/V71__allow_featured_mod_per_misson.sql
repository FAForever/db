CREATE TABLE coop_map_type(
    `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(256) not null ,
    `description` text,
    `main_featured_id` tinyint(3) unsigned NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `featured_mod_for_coop_map_type` FOREIGN KEY (`main_featured_id`) REFERENCES `game_featuredMods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE coop_map_type_to_needed_featured_mods(
    `coop_map_type_id` mediumint(8) unsigned NOT NULL,
    `needed_featured_id` tinyint(3) unsigned NOT NULL,
    CONSTRAINT `coop_map_type_id_for_needed_featured_mods` FOREIGN KEY (`coop_map_type_id`) REFERENCES `coop_map_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `featured_mod_id_for_needed_featured_mods` FOREIGN KEY (`needed_featured_id`) REFERENCES `game_featuredMods` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE `coop_map` CHANGE `type` `coop_map_type_id` mediumint(8) NOT NULL;

-- TODO: Add a constraint to coop-map table after data was added in production
