CREATE TABLE map_pool
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(255) NOT NULL,
    create_time   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT="A collection of maps, used by a matchmaker for map selection";

CREATE TABLE map_pool_maps
(
    map_pool_id   INT REFERENCES map_pool (id),
    map_id        INT REFERENCES map_version (id),
    PRIMARY KEY (map_pool_id, map_id)
) COMMENT="Map pool many-to-many table";

ALTER TABLE matchmaker_pool
    ADD COLUMN active_map_pool_id  INT REFERENCES map_pool (id);
