CREATE TABLE surveys (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(256) NOT NULL,
  author_id MEDIUMINT(8) unsigned NOT NULL,
  start_dtm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  end_dtm TIMESTAMP NOT NULL DEFAULT '2038-01-18 03:14:07',
  update_dtm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT end_dtm_gt_start_dtm CHECK (start_dtm <= end_dtm),
  PRIMARY KEY(id),
  FOREIGN KEY (author_id) REFERENCES login (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE survey_questions (
  id INTEGER NOT NULL AUTO_INCREMENT,
  survey_id INTEGER NOT NULL,
  question TEXT CHARACTER SET utf8 NOT NULL,
  multi_answer TINYINT NOT NULL DEFAULT FALSE COMMENT 'If user can select multiple options',
  display_order SMALLINT NULL COMMENT 'Relative to all questions found under one survey_id',
  PRIMARY KEY (id),
  FOREIGN KEY (survey_id) REFERENCES surveys (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE survey_question_options (
  id INTEGER NOT NULL AUTO_INCREMENT,
  question_id INTEGER NOT NULL,
  `option` TEXT CHARACTER SET utf8 NOT NULL,
  open_response TINYINT NOT NULL DEFAULT FALSE COMMENT 'If the answer allows for custom user input, user reponse should be put in corresponding survey_ansers.response column',
  display_order SMALLINT NULL COMMENT 'Relative to all questions found under one qustion_id',
  PRIMARY KEY (id),
  FOREIGN KEY (question_id) REFERENCES survey_questions (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE survey_answers (
  id INTEGER NOT NULL AUTO_INCREMENT,
  user_id MEDIUMINT(8) unsigned NOT NULL,
  option_id INTEGER NOT NULL,
  response TEXT CHARACTER SET utf8 NULL COMMENT 'Should be populated only if corresponding survey_question_option.open_response column is true',
  answer_dtm TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  valid TINYINT NOT NULL DEFAULT TRUE,
  ip VARCHAR(15) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (option_id) REFERENCES survey_question_options (id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (user_id) REFERENCES login (id) ON DELETE CASCADE ON UPDATE CASCADE
);
