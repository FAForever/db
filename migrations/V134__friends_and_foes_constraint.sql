DELETE FROM friends_and_foes WHERE user_id = subject_id;

ALTER TABLE friends_and_foes
ADD CONSTRAINT friends_and_foes_cannot_reference_self
CHECK (user_id <> subject_id);
