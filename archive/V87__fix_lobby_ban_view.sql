DROP VIEW `lobby_ban`;

CREATE VIEW `lobby_ban` AS
SELECT `ban`.`player_id`                                                             AS `idUser`,
       `ban`.`reason`                                                                AS `reason`,
       coalesce(`ban`.`revoke_time`, `ban`.`expires_at`, cast('2999-12-31' as date)) AS `expires_at`
FROM `ban`
WHERE (`ban`.`level` = 'GLOBAL');
