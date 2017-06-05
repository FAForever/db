CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `clan_tags` AS
    SELECT 
        `m`.`player_id` AS `player_id`, `c`.`tag` AS `clan_tag`
    FROM
        (`clan_membership` `m`
        LEFT JOIN `clan` `c` ON ((`m`.`clan_id` = `c`.`id`)))
