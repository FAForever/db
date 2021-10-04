DROP EVENT IF EXISTS `achievement_statistics_loader`;


DELIMITER $$

CREATE EVENT IF NOT EXISTS `achievement_statistics_loader`
ON SCHEDULE EVERY 15 MINUTE
COMMENT 'Recompute the achievement_statistics table every hour'
DO
    BEGIN
        INSERT INTO achievement_statistics
        SELECT
            `ach`.`id` AS `achievement_id`,
            coalesce(`unlock_stats`.`COUNT`, 0) AS `unlockers_count`,
            coalesce(round((100 * (`unlock_stats`.`COUNT` / `achievers_count`.`COUNT`)), 2), 0) AS `unlockers_percent`,
            `unlock_stats`.`min_time` AS `unlockers_min_duration`,
            `unlock_stats`.`avg_time` AS `unlockers_avg_duration`,
            `unlock_stats`.`max_time` AS `unlockers_max_duration`
        FROM (
            (
                `achievement_definitions` AS `ach`
                LEFT JOIN
                (
                    SELECT
                        `pa`.`achievement_id` AS `achievement_id`,
                        count(0) AS `COUNT`,
                        round(min(timestampdiff(SECOND, greatest(`ach`.`create_time`, `login`.`create_time`), `pa`.`update_time`)), 0) AS `min_time`,
                        round(avg(timestampdiff(SECOND, greatest(`ach` .`create_time`, `login`.`create_time`), `pa`.`update_time`)), 0) AS `avg_time`,
                        round(max(timestampdiff(SECOND, greatest(`ach`.`create_time`, `login`.`create_time`), `pa`.`update_time`)), 0) AS `max_time`
                    FROM (
                        `achievement_definitions` `ach`
                        LEFT JOIN `player_achievements` `pa` ON `pa`.`achievement_id` = `ach`.`id`
                        LEFT JOIN `login` ON `login`.`id` = `pa`.`player_id`
                    )
                    WHERE `pa`.`state` = 'UNLOCKED'
                    GROUP BY `pa`.`achievement_id`
                ) `unlock_stats` ON `unlock_stats`.`achievement_id` = `ach`.`id`
            )
            JOIN
            (
                SELECT count(DISTINCT `login`.`id`) AS `COUNT`
                FROM `login`
                INNER JOIN `player_achievements` ON
                    `login`.`id` = `player_achievements`.`player_id`
            ) `achievers_count`
        )
        ON DUPLICATE KEY UPDATE
            `achievement_statistics`.`unlockers_count` = VALUES(unlockers_count),
            `achievement_statistics`.`unlockers_percent` = VALUES(unlockers_percent),
            `achievement_statistics`.`unlockers_min_duration` = VALUES(unlockers_min_duration),
            `achievement_statistics`.`unlockers_avg_duration` = VALUES(unlockers_avg_duration),
            `achievement_statistics`.`unlockers_max_duration` = VALUES(unlockers_max_duration)
        ;
    END $$

DELIMITER ;
