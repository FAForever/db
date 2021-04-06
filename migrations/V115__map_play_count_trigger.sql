DROP TRIGGER IF EXISTS map_play_count;

DELIMITER $$
$$
CREATE DEFINER=root@localhost TRIGGER map_play_count AFTER INSERT ON game_stats FOR EACH ROW
BEGIN
    INSERT INTO table_map_features(map_id,voters,times_played)
    VALUES (NEW.mapId, '', 1)
    ON DUPLICATE KEY UPDATE times_played = (times_played +1);
END;$$