CREATE TABLE tutorial_category (
  `id`           INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `category_key` VARCHAR(255) NOT NULL
);

CREATE TABLE tutorial (
  `id`              INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `map_version_id`  MEDIUMINT(8) UNSIGNED,
  CONSTRAINT tutorial_map_version FOREIGN KEY (`map_version_id`) REFERENCES map_version (id),
  `title_key`       VARCHAR(255) NOT NULL
  COMMENT 'The key for the title of the tutorial shown in client',
  `description_key` VARCHAR(255)
  COMMENT 'The key for the description of the tutorial, the text in the messages table must be in HTML',
  `category`        INT UNSIGNED NOT NULL,
  CONSTRAINT tutorial_category FOREIGN KEY (`category`) REFERENCES tutorial_category (id),
  `image`           VARCHAR(255)
  COMMENT 'The ''image''-path for to a preview image of the tutorial, relative to the base url defined in the api',
  `ordinal`         INT          NOT NULL
  COMMENT 'The ''ordinal'' which defines in which order the tutorials are shown in the client (within their category)',
  `launchable`      TINYINT(1)   NOT NULL
  COMMENT 'Boolean that defines whether or not the tutorial can be launched',
  `technical_name`  VARCHAR(255) NOT NULL
  COMMENT 'The ''technical_name'' of the tutorial given to the tutorial mod to decide what tutorial to start, when implemented',
  `create_time`     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);