-- From a db perspective the table map_pool_map_version doesn't need an id column.
-- However accessing it via JSONAPI/Elide we can't use a composite primary key.

CREATE TEMPORARY TABLE map_pool_map_version_archive
SELECT * FROM map_pool_map_version;

DROP TABLE map_pool_map_version;

CREATE TABLE map_pool_map_version
(
    id INT UNSIGNED AUTO_INCREMENT,
    map_pool_id INT UNSIGNED NOT NULL,
    map_version_id MEDIUMINT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (map_pool_id) references map_pool (id),
    FOREIGN KEY (map_version_id) references map_version (id),
    INDEX (map_version_id, map_pool_id)
);

INSERT INTO map_pool_map_version(map_pool_id, map_version_id)
SELECT map_pool_id, map_version_id FROM map_pool_map_version;
