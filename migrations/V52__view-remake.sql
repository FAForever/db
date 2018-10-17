-- small indexes for achievement_definitions and login, no need to load more
ALTER TABLE `achievement_definitions`
ADD UNIQUE `id_create_time` (`id`, `create_time`);
ALTER TABLE `login`
ADD UNIQUE `id_create_time` (`id`, `create_time`);

-- combined index for fiter, join and gaining values
ALTER TABLE `player_achievements`
ADD INDEX `state_player_id_achievement_id_update_time` (`state`, `achievement_id`,  `player_id`, `update_time`);

CREATE OR REPLACE VIEW `achievement_statistics` AS
SELECT
	ANY_VALUE(`achievement_id`) AS `achievement_id`,
	SUM(`unlockers_count`) AS `unlockers_count`,
	SUM(`unlockers_percent`) AS `unlockers_percent`,
	SUM(`unlockers_min_duration`) AS `unlockers_min_duration`,
	SUM(`unlockers_avg_duration`) AS `unlockers_avg_duration`,
	SUM(`unlockers_max_duration`) AS `unlockers_max_duration`
FROM (
	/* split logic */
	/* 1. unlockers count and percentage */
	(
		SELECT
			ANY_VALUE(`player_achievements`.`achievement_id`) AS `achievement_id`,
			COALESCE(COUNT(*), 0) AS `unlockers_count`,
			COALESCE(ROUND(
				100 * (
					COUNT(*) / (
						SELECT COUNT(*) FROM (
	                        SELECT 1
							FROM `player_achievements` AS `achievement_count_subq`
							WHERE `achievement_count_subq`.`achievement_id`
							GROUP BY `player_id`
						) AS `players_that_have_achievement`
					)
				),
				2
			), 0) AS `unlockers_percent`,
			0 AS `unlockers_min_duration`,
			0 AS `unlockers_avg_duration`,
			0 AS `unlockers_max_duration`
		FROM `player_achievements`
		WHERE `player_achievements`.`state` = 'UNLOCKED'
		GROUP BY `player_achievements`.`achievement_id`
		ORDER BY NULL
	)

	UNION

	/* 2. timing trough 3 tables */
	(
		SELECT
			ANY_VALUE(`player_achievements`.`achievement_id`) AS `achievement_id`,
			0 AS `unlockers_count`,
			0 AS `unlockers_percent`,
			round(min(timestampdiff(SECOND,
				greatest(`achievement_definitions`.`create_time`, `login`.`create_time`),
				`player_achievements`.`update_time`)), 0) AS `unlockers_min_duration`,
			round(avg(timestampdiff(SECOND,
				greatest(`achievement_definitions`.`create_time`, `login`.`create_time`),
				`player_achievements`.`update_time`)), 0) AS `unlockers_avg_duration`,
			round(max(timestampdiff(SECOND,
				greatest(`achievement_definitions`.`create_time`, `login`.`create_time`),
				`player_achievements`.`update_time`)), 0) AS `unlockers_max_duration`
		FROM `player_achievements`
		INNER JOIN `achievement_definitions` USE INDEX(`id_create_time`) ON (
				`player_achievements`.`achievement_id` = `achievement_definitions`.`id` 
			AND `player_achievements`.`state` = 'UNLOCKED'
		)
		INNER JOIN `login` USE INDEX(`id_create_time`) ON (
				`login`.`id` = `player_achievements`.`player_id` 
			AND `player_achievements`.`state` = 'UNLOCKED' -- Duplicate condition allows mysql to join tables from player_achievements in any order
		)
		GROUP BY `player_achievements`.`achievement_id`
		ORDER BY NULL
	)
) AS `unioned`
GROUP BY `achievement_id`
ORDER BY NULL;
