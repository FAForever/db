-- Add times_played to map_version
ALTER TABLE map_version
    ADD COLUMN times_played int unsigned NOT NULL DEFAULT 0 COMMENT 'Number of times a map version has been played. Should be updated each time a row is inserted with the map_version.id in game_stats. Values start at 0' AFTER reviews;

-- Add times_played to map_version
ALTER TABLE map
    ADD COLUMN times_played int unsigned NOT NULL DEFAULT 0 COMMENT 'Number of times a map version has been played. Should be updated each time times_played is updated in map_version Values start at 0' AFTER reviews;

DROP TABLE IF EXISTS table_map_features;

-- Update view for backwards compatibility with api
DROP VIEW IF EXISTS map_statistics;

CREATE DEFINER=root@localhost VIEW map_statistics AS
    SELECT id, 0 AS downloads, times_played, 0 AS num_draws FROM map;

-- Update view for backwards compatibility with api
DROP VIEW IF EXISTS map_version_statistics;

CREATE DEFINER=root@localhost VIEW map_version_statistics AS
    SELECT id, 0 AS downloads, times_played, 0 AS num_draws FROM map_version;

-- one time update of map_version to get times_played to the right play_count
DROP TABLE IF EXISTS map_version_play_count;

CREATE TEMPORARY TABLE map_version_play_count AS
    SELECT mapId, COUNT(DISTINCT id) AS times_played
    FROM game_stats
    GROUP BY mapId;

UPDATE map_version, map_version_play_count
SET map_version.times_played = map_version_play_count.times_played
WHERE map_version.id = map_version_play_count.mapId;

DROP TABLE IF EXISTS map_version_play_count;

-- one time update of map to get times_played to the right play_count
DROP TABLE IF EXISTS map_play_count;

CREATE TEMPORARY TABLE map_play_count AS
SELECT map_version.map_id, SUM(map_version.times_played) AS times_played
FROM map_version
GROUP BY map_version.map_id;

UPDATE map, map_play_count
SET map.times_played = map_play_count.times_played
WHERE map.id = map_play_count.map_id;

DROP TABLE IF EXISTS map_play_count;

-- Add trigger to increment map_version play count
DELIMITER ;
DROP TRIGGER IF EXISTS map_version_play_count;

DELIMITER $$
$$
CREATE DEFINER=root@localhost TRIGGER map_version_play_count AFTER INSERT ON game_stats FOR EACH ROW
BEGIN
    -- "Increment times_played in map_version on new insertion to game_stats';
    UPDATE map_version
    SET times_played = (times_played + 1)
    WHERE map_version.id = NEW.mapId;
END;$$

-- Add trigger to increment map play count
DELIMITER ;
DROP TRIGGER IF EXISTS map_play_count;

DELIMITER $$
$$
CREATE DEFINER=root@localhost TRIGGER map_play_count AFTER UPDATE ON map_version FOR EACH ROW
BEGIN
    -- "Increment times_played in map on updated times_played in map_version';
    IF NEW.times_played != OLD.times_played
    THEN
        UPDATE map
        SET times_played = (times_played + (NEW.times_played - OLD.times_played))
        WHERE map.id = NEW.map_id;
    END IF;
END;$$