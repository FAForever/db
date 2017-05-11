ALTER TABLE ban
  MODIFY expires_at DATETIME COMMENT 'If null, the ban is permanent';

CREATE OR REPLACE VIEW `lobby_ban` AS
  SELECT
    ban.player_id                                                        AS idUser,
    ban.reason                                                           AS reason,
    COALESCE(ban_revoke.create_time, ban.expires_at, DATE('2999-12-31')) AS expires_at
  FROM ban
    LEFT JOIN ban_revoke ON ban.id = ban_revoke.ban_id
  WHERE level != 'CHAT';
