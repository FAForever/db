-- Cleanup records with player_events referencing non-existing accounts
DELETE player_events
FROM player_events
LEFT JOIN login on login.id = player_events.player_id
WHERE login.id IS NULL;


-- Add foreign key constraint for player_events -> login
ALTER TABLE player_events MODIFY player_id MEDIUMINT UNSIGNED NOT NULL COMMENT 'The ID of the player that triggered this event.';

ALTER TABLE player_events
	ADD CONSTRAINT player_events_login_id_fk
		FOREIGN KEY (player_id) REFERENCES login (id);



-- Cleanup records with friends_and_foes referencing non-existing accounts
DELETE friends_and_foes
FROM friends_and_foes
         LEFT JOIN login ON login.id = friends_and_foes.user_id
WHERE login.id IS NULL;

DELETE friends_and_foes
FROM friends_and_foes
         LEFT JOIN login ON login.id = friends_and_foes.subject_id
WHERE login.id IS NULL;

-- Add foreign key constraint for friends_and_foes -> login
ALTER TABLE friends_and_foes
    ADD CONSTRAINT friends_and_foes_user_login_id_fk
        FOREIGN KEY (user_id) REFERENCES login (id);

ALTER TABLE friends_and_foes
    ADD CONSTRAINT friends_and_foes_subject_login_id_fk
        FOREIGN KEY (subject_id) REFERENCES login (id);

