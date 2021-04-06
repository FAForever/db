-- Add times_played to map_version
ALTER TABLE map_version
    ADD COLUMN times_played int unsigned NOT NULL DEFAULT 0 COMMENT 'Number of times a map version has been played. Should be updated each time a row is inserted with the map_version.id in game_stats. Values start at 0' AFTER reviews;

-- Add times_played to map_version
ALTER TABLE map
    ADD COLUMN times_played int unsigned NOT NULL DEFAULT 0 COMMENT 'Number of times a map version has been played. Should be updated each time a row is inserted with a map_version.map.id in game_stats Values start at 0' AFTER reviews;

-- one time update of table_map_features to get times_played to the right play_count
UPDATE table_map_features,
    (SELECT mapId, COUNT(DISTINCT id) AS map_play_count
    FROM game_stats
    GROUP BY mapId) as map_plays
SET table_map_features.times_played = map_plays.map_play_count
WHERE table_map_features.map_id = map_plays.mapId;

INSERT IGNORE INTO table_map_features(map_id,voters,times_played)
SELECT mapId, '', COUNT(DISTINCT id) AS map_play_count FROM game_stats WHERE mapId IS NOT NULL GROUP BY mapId;

-- one time update of map_version to get times_played to the right play_count
UPDATE map_version,
    (SELECT mapId, COUNT(DISTINCT id) AS map_play_count
    FROM game_stats
    GROUP BY mapId) as map_plays
SET map_version.times_played = map_plays.map_play_count
WHERE map_version.id = map_plays.mapId;

-- one time update of map_version to get times_played to the right play_count
UPDATE map,
    (SELECT map_version.map_id, COUNT(DISTINCT game_stats.id) AS map_play_count
    FROM game_stats
    INNER JOIN map_version on game_stats.mapId = map_version.id
    GROUP BY map_version.map_id) as map_plays
SET map.times_played = map_plays.map_play_count
WHERE map.id = map_plays.map_id;

-- Add trigger to increment map play count on table_map_features
DROP TRIGGER IF EXISTS depreciated_map_play_count;

DELIMITER $$
$$
CREATE DEFINER=root@localhost TRIGGER depreciated_map_play_count AFTER INSERT ON game_stats FOR EACH ROW
BEGIN
    -- 'Increment times_played in table_map_features on new insertion to game_stats Should be removed as soon as clients migrate off using mapStatistics and it is dropped from the api';
    IF NEW.mapId IS NOT NULL THEN
        INSERT INTO table_map_features(map_id,voters,times_played)
        VALUES (NEW.mapId, '', 1)
        ON DUPLICATE KEY UPDATE times_played = (times_played +1);
    END IF;
END;$$

-- Add trigger to increment map play count
DELIMITER ;
DROP TRIGGER IF EXISTS map_play_count;

DELIMITER $$
$$
CREATE DEFINER=root@localhost TRIGGER map_play_count AFTER INSERT ON game_stats FOR EACH ROW
BEGIN
    -- 'Increment times_played in map_version on new insertion to game_stats';
    UPDATE map_version
    SET times_played = (times_played + 1)
    WHERE map_version.id = NEW.mapId;

    -- 'Increment times_played in map for the appropriate parent map on new insertion to game_stats';
    UPDATE map, (SELECT map_id from map_version where map_version.id = NEW.mapId) as map_played
    SET map.times_played = (map.times_played + 1)
    WHERE map.id = map_played.map_id;
END;$$