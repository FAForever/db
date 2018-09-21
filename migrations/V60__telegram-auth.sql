CREATE TABLE IF NOT EXISTS steam_user_id_hashes (
  `id`                      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `hashed_telegram_user_id` varchar(64)                         NOT NULL UNIQUE,
  `create_time`             TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  `update_time`             TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
  COMMENT 'SHA 256 hashed user id from steam'
);

CREATE TABLE IF NOT EXISTS telegram_user_id_hashes (
  `id`                      INT UNSIGNED                        NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `hashed_telegram_user_id` VARCHAR(64)                         NOT NULL UNIQUE,
  `create_time`             TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  `update_time`             TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
  COMMENT 'SHA 256 hashed user id from telegram'
);

CREATE TABLE IF NOT EXISTS account_authorization (
  `id`                 INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `player_id`          MEDIUMINT UNSIGNED                  NOT NULL,
  `authorization_type` ENUM ('STEAM', 'TELEGRAM')          NOT NULL,
  `create_time`        TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  `update_time`        TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT `player_for_authorization` FOREIGN KEY (`player_id`) REFERENCES `login` (`id`),
  CONSTRAINT `authorization_only_once` UNIQUE (player_id, authorization_type)
);

INSERT INTO telegram_user_id_hashes (hashed_telegram_user_id)
  SELECT SHA2(steamid, 256)
  FROM login
  WHERE steamid IS NOT NULL;

INSERT INTO account_authorization (player_id, authorization_type)
  SELECT
    id,
    'steam'
  FROM login
  WHERE login.steamid IS NOT NULL;

ALTER TABLE login
  DROP COLUMN steamid;