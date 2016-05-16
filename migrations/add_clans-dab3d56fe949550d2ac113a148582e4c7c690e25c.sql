CREATE TABLE `clan_list` (
  `clan_id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(1) NOT NULL DEFAULT '0',
  `clan_name` varchar(40) NOT NULL,
  `clan_tag` varchar(3) DEFAULT NULL,
  `clan_founder_id` mediumint(8) DEFAULT NULL,
  `clan_leader_id` mediumint(8) DEFAULT NULL,
  `clan_desc` text,
  PRIMARY KEY (`clan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;


CREATE TABLE `clan_members` (
  `clan_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `join_clan_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`clan_id`,`player_id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `clans` AS
    SELECT 
        `clan_id` AS `clan_id`,
        `status` AS `status`,
        `clan_name` AS `clan_name`,
        `clan_tag` AS `clan_tag`,
        `clan_leader_id` AS `clan_leader_id`,
        `clan_founder_id` AS `clan_founder_id`,
        `clan_desc` AS `clan_desc`,
        `create_date` AS `create_date`,
        `leader`.`login` AS `leader_name`,
        `founder`.`login` AS `founder_name`,
        (SELECT 
                COUNT(0)
            FROM
                `clan_members`
            WHERE
                (`clan_members`.`clan_id` = `clan_list`.`clan_id`)) AS `member_count`
    FROM
        `clan_list`
        LEFT JOIN `login` `leader` ON (`clan_leader_id` = `leader`.`id`)
        LEFT JOIN `login` `founder` ON (`clan_founder_id` = `founder`.`id`);
