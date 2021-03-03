-- Drop foreign key
ALTER TABLE `faf`.`map_pool_map_version`
DROP FOREIGN KEY `map_pool_map_version_ibfk_1`;

-- Add map weight and params to table
ALTER TABLE `faf`.`map_pool_map_version`
-- remove primary key
DROP PRIMARY KEY,

    ADD COLUMN `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT FIRST,
    ADD COLUMN `weight` INT(10) NOT NULL DEFAULT 1 COMMENT 'Integer relative weight to select the map. If all values equal there will be a uniform chance. Values default to 1'  AFTER `map_version_id`,

    -- map params shall contain a json string which defines the type of map
    ADD COLUMN `map_params` TEXT NULL COMMENT 'json string which defines the type of map as well as the parameters for the map in the case of generated maps this would be the version, the generator type (e.g. neroxis), the size in pixels (e.g. 512) and the spawns' AFTER `weight`,

    -- make map_version_id able to be null this will signify that the map is defined by the map_params
    -- notably this is important for maps not defined in the maps table such as generated maps or coop maps
    CHANGE COLUMN `map_version_id` `map_version_id` MEDIUMINT(8) UNSIGNED NULL COMMENT 'When null the map_params will be used to generate the map';

-- Add foreign key
ALTER TABLE `faf`.`map_pool_map_version`
    ADD CONSTRAINT `map_pool_map_version_ibfk_1`
        FOREIGN KEY (`map_version_id`)
            REFERENCES `faf`.`map_version` (`id`);