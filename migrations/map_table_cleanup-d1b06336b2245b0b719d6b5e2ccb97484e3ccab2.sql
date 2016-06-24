START TRANSACTION;

-- Merge `table_map_unranked` into `table_map.ranked`, drop the old table
alter table table_map add `ranked` tinyint(1) NOT NULL DEFAULT 1;
update table_map m set ranked = 0 where exists (select id from table_map_unranked tmu where tmu.id = m.id);
drop table table_map_unranked;

-- Merge `table_map_uploaders` into `table_map.uploader`, drop the old table
alter table table_map add `uploader` mediumint(8) unsigned;
update table_map m set uploader = (select id from table_map_uploaders up where up.mapid = m.id);
drop table table_map_uploaders;

-- split it into `map` and `map_version`, create a view for backwards compatibility
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_version` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `description` longtext,
  `max_players` decimal(2,0) NOT NULL,
  `size_x` decimal(4,0) NOT NULL,
  `size_y` decimal(4,0) NOT NULL,
  `version` decimal(4,0) NOT NULL,
  `filename` varchar(200) NOT NULL UNIQUE,
  `hidden` tinyint(1) NOT NULL DEFAULT 0,
  `map_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `map_id_version` (`map_id`, `version`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

rename table table_map TO map;
update map set name = CONCAT('Name',id) where name IS NULL;
update map set map_type = 'FFA' where map_type IS NULL;
update map set battle_type = 'skirmish' where battle_type IS NULL;

insert into map_version (id, description, max_players, size_x, size_y, version, filename, hidden, map_id)
    select id, COALESCE(description, 'None'), COALESCE(max_players, 0), COALESCE(map_sizeX, 0), COALESCE(map_sizeY, 0), COALESCE(version, 1), filename, hidden, id
    from map;

update map_version set map_id = (select id from map where name = (select name from map where id = map_id) order by version desc limit 1);

delete m1 from `map` m1, `map` m2 where m1.version < m2.version and m1.name = m2.name;
alter table map change name display_name varchar(40) NOT NULL UNIQUE;
alter table map MODIFY map_type varchar(15) NOT NULL;
alter table map MODIFY battle_type varchar(15) NOT NULL;
alter table map drop mapuid;
alter table map drop description;
alter table map drop max_players;
alter table map drop map_sizeX;
alter table map drop map_sizeY;
alter table map drop version;
alter table map drop filename;
alter table map drop hidden;

CREATE VIEW table_map AS (select
        m.id,
        m.display_name as name,
        m.map_type,
        m.battle_type,
        v.description,
        v.version,
        v.filename,
        v.hidden,
        v.max_players,
        v.size_x as map_sizeX,
        v.size_y as map_sizeY
    from map m
    join map_version v on m.id = v.map_id);

COMMIT;