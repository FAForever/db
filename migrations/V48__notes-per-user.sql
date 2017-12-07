CREATE TABLE user_notes
(
    id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id MEDIUMINT(9) unsigned NOT NULL,
    author MEDIUMINT(9) unsigned NOT NULL,
    watched TINYINT(4) DEFAULT '0' NOT NULL COMMENT 'boolean that marks notes that should be reviewed at a later time (i.e. gather facts before applying a ban)',
    note TEXT NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT user_notes_user_login_id_fk FOREIGN KEY (user_id) REFERENCES login (id),
    CONSTRAINT user_notes_author_login_id_fk FOREIGN KEY (author) REFERENCES login (id)
);
CREATE INDEX user_notes_user_login_id_fk ON user_notes (user_id);
CREATE INDEX user_notes_author_login_id_fk ON user_notes (author);
CREATE INDEX user_notes_watched_index ON user_notes (watched);
ALTER TABLE user_notes COMMENT = 'Notes taken by moderators';
