ALTER table matchmaker_queue
-- Will be used for various queue config like game options and sim mods
ADD COLUMN `params` TEXT NULL COMMENT 'json string which defines additional parameters for the queue' AFTER team_size
;
