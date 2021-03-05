ALTER TABLE matchmaker_queue
  ADD COLUMN teams TINYINT UNSIGNED NOT NULL DEFAULT 2
    COMMENT 'Number of teams. 0 = FFA, 1 = Coop/Survival, 2 = Normal game. Some values might not be implemented.'
;


CREATE TABLE matchmaker_queue_mod_version
(
  matchmaker_queue_id INT(10) UNSIGNED NOT NULL,
  mod_version_id      MEDIUMINT(8) UNSIGNED NOT NULL,
  FOREIGN KEY (matchmaker_queue_id) REFERENCES matchmaker_queue (id),
  FOREIGN KEY (mod_version_id) REFERENCES mod_version (id),
  PRIMARY KEY (mod_version_id, matchmaker_queue_id)
);
