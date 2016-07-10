/*

* Splits table_map into map and map_version
* Merges table_map_unranked into map_version.ranked
* Merges table_map_uploaders into map.author
* Fixes a few invalid entries we know of

Some queries to verify successful migration.

*/

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
SET sql_mode='NO_AUTO_VALUE_ON_ZERO';


DELIMITER //

DROP PROCEDURE IF EXISTS fail_or_finish //
CREATE PROCEDURE fail_or_finish ()
BEGIN
    IF tap.num_failed() > 0 THEN
        ROLLBACK;
        SELECT `Tests failed`;
    ELSE
        CALL tap.finish();
        ROLLBACK TO after_migration;
        COMMIT;
    END IF;
END //
DELIMITER ;

-- Create two new tables, `map` and `map_version`. table_map will be split into these two
-- The tables are dropped first because transactions don't apply to DDL statements (maybe a previous migration rolled back)
drop table if exists `map`;
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

drop table if exists `map_version`;
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

RENAME TABLE table_map TO table_map_old;
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

START TRANSACTION;

-- There are 2 maps which wrongly have mapuid = 0. Those need to be fixed
update table_map_old set mapuid = 1499 where name = 'OctoClops';
update table_map_old set mapuid = 1469 where name = 'Grand Crossing';
update table_map_old set mapuid = 4338 where name = 'Anchor';

-- And these two maps point to the same file, which is not allowed after the migration
delete from table_map_old where id in (125, 954, 6218);

-- Store some values for later assertions
select @table_map_count_before := count(*) from table_map_old;
select @maps_with_uploaders_before := count(distinct mapuid) from table_map_old m where id in (select mapid from table_map_uploaders where userid in (select id from login));
select @distinct_maps_before := count(distinct mapuid) from table_map_old;
select @unranked_maps_before := count(*) from table_map_unranked;

-- Fill map with data from table_map_old; use default values for columns which are now NOT NULL but are NULL
-- Uses data from the newest version of mapuid
insert into map (id, display_name, map_type, battle_type)
    select mapuid, COALESCE(name, CONCAT('Map ', id)), COALESCE(map_type, 'FFA'), COALESCE(battle_type, 'skirmish')
    from table_map_old m1 where m1.id = (select MAX(id) from table_map_old m2 where m2.mapuid = m1.mapuid);

-- Fill map_version with data from table_map_old; use default values for columns which are now NOT NULL but are NULL
insert into map_version (id, description, max_players, width, height, version, filename, hidden, map_id)
    select id, COALESCE(description, 'None'), COALESCE(max_players, 0), COALESCE(map_sizeX, 0), COALESCE(map_sizeY, 0), COALESCE(version, 1), filename, hidden, mapuid
    from table_map_old;

-- Merge `table_map_unranked` into `map_version.ranked`
update map_version mv set ranked = 0 where exists (select id from table_map_unranked tmu where tmu.mapid = mv.id);

-- Merge `table_map_uploaders` into `map.author`
update map m set author = (select userid from table_map_uploaders up where up.mapid = (select max(id) from map_version where map_id = m.id));



SAVEPOINT after_migration;
SELECT tap.plan( 5 ); -- the number of tests to be executed

    select @table_map_count_after := count(*) from table_map_old;
    select @map_versions_after := count(*) from map_version;
    select @maps_with_uploaders_after := count(*) from map where author is not null;
    select @distinct_maps_after := count(*) from map;
    select @unranked_maps_after := count(*) from map_version where ranked = 0;

    select tap.eq(@table_map_count_after, @table_map_count_before, 'View table_map_old returns the same count');
    select tap.eq(@map_versions_after, @table_map_count_before, 'Map versions count equals table_map_old count');
    select tap.eq(@maps_with_uploaders_after, @maps_with_uploaders_before, 'Same number of maps with known authors');
    select tap.eq(@distinct_maps_after, @distinct_maps_before, 'Same number of distinct maps');
    select tap.eq(@unranked_maps_after, @unranked_maps_before, 'Same number of unranked maps');

CALL fail_or_finish();
/*!40101 SET character_set_client = @saved_cs_client */;

alter table table_map_broken drop foreign key table_map_broken_ibfk_1;
alter table table_map_broken add CONSTRAINT `table_map_broken_ibfk_1` FOREIGN KEY (`map_id`) REFERENCES `map_version` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

alter table table_map_comments drop foreign key table_map_comments_ibfk_1;
alter table table_map_comments add CONSTRAINT `table_map_comments_ibfk_1` FOREIGN KEY (`map_id`) REFERENCES `map_version` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

alter table table_map_features drop foreign key table_map_features_ibfk_1;
alter table table_map_features add CONSTRAINT `table_map_features_ibfk_1` FOREIGN KEY (`map_id`) REFERENCES `map_version` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

alter table ladder_map drop foreign key ladder_map_ibfk_1;
alter table ladder_map add CONSTRAINT `ladder_map_ibfk_1` FOREIGN KEY (`idmap`) REFERENCES `map_version` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

drop table table_map_unranked;
drop table table_map_uploaders;
drop table table_map_old;


