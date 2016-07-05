/*
Some queries to verify successful migration.

-- Before migration:
select * from table_map where id in (1, 1000, 1502, 1865, 2115, 6214);
select count(*) from table_map;
select count(distinct mapuid) from table_map m where id in (select mapid from table_map_uploaders where userid in (select id from login));
select count(distinct mapuid) from table_map;
select count(*) from table_map_unranked;

-- After migration
select * from table_map where id in (1, 1000, 1502, 1865, 2115, 6214);
select count(*) from map_version; -- should be 2 less than before migration
select count(*) from map where author is not null;
select count(*) from map; -- should be 2 less than before migration
select count(*) from map_version where ranked = 0;

*/

-- Since canis3v3 has a mapuid of 0, we have to disable "0 means auto-value" during this import. This has no side
-- effects since we other never use 0 during this migration
SET sql_mode='NO_AUTO_VALUE_ON_ZERO';
SET AUTOCOMMIT=0;
START TRANSACTION;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

-- There are 2 maps which wrongly have mapuid = 0. Those need to be fixed
update table_map set mapuid = 1499 where name = 'OctoClops';
update table_map set mapuid = 1469 where name = 'Grand Crossing';

-- And these two maps point to the same file, which is not allowed after the migration
delete from table_map where id in (125, 954);


-- The tables are dropped first because transactions don't apply to DDL statements (maybe a previous migration rolled back)
drop table if exists `map_version`;
drop table if exists `map`;

-- Create two new tables, `map` and `map_version`. table_map will be split into these two
CREATE TABLE `map` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `display_name` varchar(40) NOT NULL UNIQUE,
  `map_type` varchar(15) NOT NULL,
  `battle_type` varchar(15) NOT NULL,
  `author` mediumint(8) unsigned,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was created.',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'When this entry was updated',
  PRIMARY KEY (`id`),
  CONSTRAINT `author` FOREIGN KEY (`author`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `map_version` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `description` longtext,
  `max_players` decimal(2,0) NOT NULL,
  `width` decimal(4,0) NOT NULL,
  `height` decimal(4,0) NOT NULL,
  `version` decimal(4,0) NOT NULL,
  `filename` varchar(200) NOT NULL UNIQUE,
  `ranked` tinyint(1) NOT NULL DEFAULT 1,
  `hidden` tinyint(1) NOT NULL DEFAULT 0,
  `map_id` mediumint(8) unsigned NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When this entry was created.',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'When this entry was updated',
  UNIQUE KEY `map_id_version` (`map_id`, `version`),
  PRIMARY KEY (`id`),
  CONSTRAINT `map` FOREIGN KEY (`map_id`) REFERENCES `map` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Fill map with data from table_map; use default values for columns which are now NOT NULL but are NULL
-- Uses data from the newest version of mapuid
insert into map (id, display_name, map_type, battle_type)
    select mapuid, COALESCE(name, CONCAT('Map ', id)), COALESCE(map_type, 'FFA'), COALESCE(battle_type, 'skirmish')
    from table_map m1 where m1.id = (select MAX(id) from table_map m2 where m2.mapuid = m1.mapuid);

-- Fill map_version with data from table_map; use default values for columns which are now NOT NULL but are NULL
insert into map_version (id, description, max_players, width, height, version, filename, hidden, map_id)
    select id, COALESCE(description, 'None'), COALESCE(max_players, 0), COALESCE(map_sizeX, 0), COALESCE(map_sizeY, 0), COALESCE(version, 1), filename, hidden, mapuid
    from table_map;

-- Merge `table_map_unranked` into `map_version.ranked`, drop the old table
update map_version mv set ranked = 0 where exists (select id from table_map_unranked tmu where tmu.id = mv.id);
drop table table_map_unranked;

-- Merge `table_map_uploaders` into `map.author`, drop the old table
update map m set author = (select userid from table_map_uploaders up where up.mapid = (select max(id) from map_version where map_id = m.id));
drop table table_map_uploaders;


-- Drop the old table_map, create a view instead
SET FOREIGN_KEY_CHECKS=0;

drop table table_map;
CREATE VIEW table_map AS (select
        v.id,
        m.display_name as name,
        v.description,
        v.max_players,
        m.map_type,
        m.battle_type,
        v.width as map_sizeX,
        v.height as map_sizeY,
        v.version,
        v.filename,
        v.hidden,
        m.id as mapuid
    from map m
    join map_version v on m.id = v.map_id);

SET FOREIGN_KEY_CHECKS=1;

/*!40101 SET character_set_client = @saved_cs_client */;
COMMIT;
SET autocommit=1;