CREATE TABLE account_request (
  id VARCHAR(36) NOT NULL,
  user_id MEDIUMINT(8) UNSIGNED NULL,
  request_type VARCHAR(64) NOT NULL,
  expires_at DATETIME(6) NOT NULL,
  data JSON NOT NULL,
  create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT account_request_login_id_fk FOREIGN KEY (user_id) REFERENCES login (id) ON DELETE CASCADE
);

CREATE INDEX idx_account_request_user_id_request_type ON account_request (user_id, request_type);
CREATE INDEX idx_account_request_expires_at ON account_request (expires_at);
