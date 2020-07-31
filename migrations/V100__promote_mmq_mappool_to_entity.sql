ALTER TABLE matchmaker_queue_map_pool
    DROP FOREIGN KEY matchmaker_queue_map_pool_ibfk_1;

ALTER TABLE matchmaker_queue_map_pool
    DROP FOREIGN KEY matchmaker_queue_map_pool_ibfk_2;


ALTER TABLE matchmaker_queue_map_pool DROP PRIMARY KEY;

ALTER TABLE matchmaker_queue_map_pool
    ADD id INTEGER UNSIGNED AUTO_INCREMENT FIRST,
    ADD create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ADD update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    ADD CONSTRAINT matchmaker_queue_map_pool_pk
        PRIMARY KEY (id),
    ADD CONSTRAINT matchmaker_queue_map_pool_map_pool_id_fk
        FOREIGN KEY (map_pool_id) REFERENCES map_pool (id),
    ADD CONSTRAINT matchmaker_queue_map_pool_matchmaker_queue_id_fk
        FOREIGN KEY (matchmaker_queue_id) REFERENCES matchmaker_queue (id),
    COLLATE 'utf8_general_ci',
    COMMENT 'Map sub pool of a rating range for a matchmaker queue';
