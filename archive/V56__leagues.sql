CREATE TABLE IF NOT EXISTS league (
  `id`                          INT UNSIGNED                    NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name`                        TINYTEXT                        NOT NULL,
  `description`                 TEXT                            NOT NULL,
  `director_id`                 MEDIUMINT UNSIGNED              NOT NULL
  COMMENT "Login ID of the user who created this league",
  
  CONSTRAINT director_id_of_league FOREIGN KEY (`director_id`) REFERENCES login (id),
  
  `create_time`              TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`              TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS league_schedule (
  `id`                       INT UNSIGNED           NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `timeframe_from`           TIMESTAMP              NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `timeframe_to`             TIMESTAMP              NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT "From when to when will the season take place",
  
  `director_id`              MEDIUMINT UNSIGNED      NOT NULL
  COMMENT "Login ID of the user who's organizing this season",
  
  `description`              TEXT                     NOT NULL,
  `league_id`                INT UNSIGNED             NOT NULL,
  
  CONSTRAINT director_id_of_league_schedule FOREIGN KEY (`director_id`) REFERENCES login (id),
  CONSTRAINT league_of_league_schedule FOREIGN KEY (`league_id`) REFERENCES league (id),
  
  `create_time`              TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`              TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS league_rating_range (
  `id`                     INT UNSIGNED             NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `rating_from`            SMALLINT                 DEFAULT NULL,
  `rating_to`              SMALLINT                 DEFAULT NULL,
  `schedule_id`            INT UNSIGNED             NOT NULL,
  
  CONSTRAINT rating_schedule_of_league_rating_range FOREIGN KEY (`schedule_id`) REFERENCES league_schedule (id),
  
  `create_time`            TIMESTAMP                NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`            TIMESTAMP                NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP
);