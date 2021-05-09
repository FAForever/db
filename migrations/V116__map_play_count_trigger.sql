-- Add games_played to map_version
ALTER TABLE map_version
    ADD COLUMN games_played int unsigned NOT NULL DEFAULT 0 COMMENT 'Number of times a map version has been played. Should be updated each time a row is inserted with the map_version.id in game_stats. Values start at 0' AFTER reviews;

-- Add games_played to map_version
ALTER TABLE map
    ADD COLUMN games_played int unsigned NOT NULL DEFAULT 0 COMMENT 'Number of times a map version has been played. Should be updated each time games_played is updated in map_version Values start at 0' AFTER reviews;

DROP TABLE IF EXISTS table_map_features;

-- Update view for backwards compatibility with api
DROP VIEW IF EXISTS map_statistics;

CREATE DEFINER=root@localhost VIEW map_statistics AS
SELECT id as map_id, 0 AS downloads, games_played AS plays, 0 AS draws FROM map;

-- Update view for backwards compatibility with api
DROP VIEW IF EXISTS map_version_statistics;

CREATE DEFINER=root@localhost VIEW map_version_statistics AS
SELECT id as map_version_id, 0 AS downloads, games_played AS plays, 0 AS draws FROM map_version;

-- Add trigger to increment map_version play count
DELIMITER ;
DROP TRIGGER IF EXISTS map_version_play_count;

DELIMITER $$
$$
CREATE DEFINER=root@localhost TRIGGER map_version_play_count AFTER INSERT ON game_stats FOR EACH ROW
BEGIN
    -- "Increment games_played in map_version on new insertion to game_stats';
    UPDATE map_version
    SET games_played = (games_played + 1)
    WHERE map_version.id = NEW.mapId;
END;$$

-- Add trigger to increment map play count
DELIMITER ;
DROP TRIGGER IF EXISTS map_play_count;

DELIMITER $$
$$
CREATE DEFINER=root@localhost TRIGGER map_play_count AFTER UPDATE ON map_version FOR EACH ROW
BEGIN
    -- "Increment games_played in map on updated games_played in map_version';
    IF NEW.games_played != OLD.games_played
    THEN
        UPDATE map
        SET games_played = (games_played + (NEW.games_played - OLD.games_played))
        WHERE map.id = NEW.map_id;
    END IF;
END;$$

DELIMITER ;

-- one time update of map_version to get games_played to the right play_count
DROP TABLE IF EXISTS map_version_play_count;

CREATE TEMPORARY TABLE map_version_play_count AS
    SELECT mapId, COUNT(DISTINCT id) AS games_played
    FROM game_stats
    GROUP BY mapId;

UPDATE map_version, map_version_play_count
SET map_version.games_played = map_version_play_count.games_played
WHERE map_version.id = map_version_play_count.mapId;

DROP TABLE IF EXISTS map_version_play_count;
