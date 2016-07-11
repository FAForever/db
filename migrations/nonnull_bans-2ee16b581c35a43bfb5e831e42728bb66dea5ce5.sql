-- These are garbage
DELETE FROM lobby_ban WHERE idUser IS NULL;

-- Represent infinite bans with large numbers, not NULL.
UPDATE lobby_ban SET expires_at = '2222-07-21' WHERE expires_at IS NULL;

ALTER TABLE lobby_ban 
    MODIFY expires_at datetime NOT NULL DEFAULT '2222-07-21',
    MODIFY idUser mediumint(8) unsigned NOT NULL;
