ALTER TABLE game_stats
    MODIFY replay_available TINYINT(1) DEFAULT 0 NOT NULL
        COMMENT 'If false, no replay is available for download. The replay server needs to set this field to true once replay is written to disk.';
