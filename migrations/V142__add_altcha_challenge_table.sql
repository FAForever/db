CREATE TABLE altcha_challenge (
  challenge VARCHAR(64) NOT NULL,
  expires_at DATETIME NOT NULL,
  PRIMARY KEY (challenge)
);

CREATE INDEX idx_altcha_challenge_expires_at ON altcha_challenge (expires_at);