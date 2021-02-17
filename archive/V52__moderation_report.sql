CREATE TABLE IF NOT EXISTS moderation_report (
  `id`                      INT UNSIGNED            NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `reporter_id`             MEDIUMINT UNSIGNED      NOT NULL,
  `report_description`      TEXT,
 
  `game_id`                 INT UNSIGNED            DEFAULT NULL
  COMMENT 'If equal to NULL, the offense did not happen ingame',

  `report_status`           ENUM('AWAITING', 'PROCESSING', 'COMPLETED', 'DISCARDED')   NOT NULL
  COMMENT 'The current status of the report. This will be accessable by the concerned user.',
  
  `game_incident_timecode`  VARCHAR(100)
  COMMENT 'The timecode of the incident ingame, indicated by the user in their own terms',
  
  `moderator_notice`        TEXT
  COMMENT 'A public notice left by the moderator which will be addressed to the reporter once the report is marked as either COMPLETED or DISCARDED',
  `moderator_private_note`  TEXT
  COMMENT 'A private notice left by the moderator which any other moderator accessing the record will be able to see.',
  `last_moderator`          MEDIUMINT UNSIGNED      DEFAULT NULL
  COMMENT 'Last moderator to have updated the report',
  
  `create_time`             TIMESTAMP              NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`             TIMESTAMP              NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT game_id_of_moderation_report FOREIGN KEY (`game_id`) REFERENCES game_stats (id),
  CONSTRAINT reporter_id_of_moderation_report FOREIGN KEY (`reporter_id`) REFERENCES login (id),
  FOREIGN KEY (`last_moderator`) REFERENCES login (id)
);

CREATE TABLE IF NOT EXISTS reported_user (
  `id`                     INT UNSIGNED             NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `player_id`              MEDIUMINT UNSIGNED        NOT NULL,
  `report_id`              INT UNSIGNED             NOT NULL,
  
  `create_time`            TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`            TIMESTAMP               NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT player_id_of_reported_user FOREIGN KEY (`player_id`) REFERENCES login (id),
  CONSTRAINT report_id_of_reported_user FOREIGN KEY (`report_id`) REFERENCES moderation_report (id)
);

ALTER TABLE ban ADD COLUMN (
    report_id INT UNSIGNED
    COMMENT 'The report based on which the ban was issued, is NULL if ban was not issues due to a report'
);
ALTER TABLE ban ADD CONSTRAINT FOREIGN KEY (report_id) references moderation_report(id);