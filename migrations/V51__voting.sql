CREATE TABLE voting_subject (
  `id`                 INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `subject_key`        VARCHAR(255) NOT NULL
  COMMENT 'With this key the ''subject'' can be loaded from the messages table',
  `begin_of_vote_time` DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_of_vote_time`   DATETIME     NOT NULL,
  `min_games_to_vote`  INT UNSIGNED NOT NULL DEFAULT 0
  COMMENT 'The number of games a player must have to in order to vote',
  `description_key`    VARCHAR(255)
  COMMENT 'The ''description-key'' of the voting subject with it additional information (HTML) can be loaded from the messages table',
  `topic_url`          TEXT
  COMMENT 'An URL to a page with additional information, e.g. a forum post.',
  `create_time`        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE voting_question (
  `id`                 INT UNSIGNED     NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `max_answers`        INT UNSIGNED     NOT NULL DEFAULT 1,
  `question_key`       VARCHAR(255)     NOT NULL
  COMMENT 'With this key the ''question'' can be loaded from the messages table',
  `voting_subject_id`  INT UNSIGNED     NOT NULL,
  CONSTRAINT voting_subject_of_voting_question FOREIGN KEY (`voting_subject_id`) REFERENCES voting_subject (id),
  `description_key`    VARCHAR(255)
  COMMENT 'The ''description-key'' of the voting question, with it additional information (HTML) can be loaded from the messages table',
  `ordinal`            INT UNSIGNED     NOT NULL DEFAULT 0
  COMMENT 'The ''ordinal'' of the voting question, in the client questions are shown according to their ordinal value',
  `alternative_voting` TINYINT UNSIGNED NOT NULL DEFAULT 0
  COMMENT 'Defines whether alternative voting applies to this question',
  `create_time`        TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`        TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE voting_choice (
  `id`                 INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `choice_text_key`    VARCHAR(255) NOT NULL
  COMMENT 'With this key the ''choice_text'' can be loaded from the messages table',
  `voting_question_id` INT UNSIGNED NOT NULL,
  CONSTRAINT voting_question_of_voting_choice FOREIGN KEY (`voting_question_id`) REFERENCES voting_question (id),
  `description_key`    VARCHAR(255) NOT NULL
  COMMENT 'The ''description-key'' of the voting choice, with it additional information (HTML) can be loaded from the messages table',
  `ordinal`            INT UNSIGNED NOT NULL DEFAULT 0
  COMMENT 'The ''ordinal'' of the voting choice, in the client choices are shown according to their ordinal value',
  `create_time`        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE vote (
  `id`                INT UNSIGNED       NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `player_id`         MEDIUMINT UNSIGNED NOT NULL,
  CONSTRAINT player_of_vote FOREIGN KEY (`player_id`) REFERENCES login (id),
  `voting_subject_id` INT UNSIGNED       NOT NULL,
  CONSTRAINT voting_subject_of_vote FOREIGN KEY (`voting_subject_id`) REFERENCES voting_subject (id),
  `create_time`       TIMESTAMP          NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`       TIMESTAMP          NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `one_vote_only` (`player_id`, `voting_subject_id`)
);

CREATE TABLE voting_answer (
  `id`                  INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `vote_id`             INT UNSIGNED NOT NULL,
  CONSTRAINT vote_of_voting_answer FOREIGN KEY (`vote_id`) REFERENCES vote (id),
  `voting_choice_id`    INT UNSIGNED NOT NULL,
  CONSTRAINT voting_choice_of_voting_answer FOREIGN KEY (`voting_choice_id`) REFERENCES voting_choice (id),
  `alternative_ordinal` TINYINT UNSIGNED
  COMMENT 'Defines what preference for alternative voting this answer is',
  `create_time`         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `one_answer_only` (`vote_id`, `voting_choice_id`)
);
