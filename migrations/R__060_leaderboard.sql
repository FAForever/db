-- Repeatable migration: Flyway will replay this SQL every time this file (checksum) has changed!
-- You can not delete items by removing them from this file! Also make sure never to edit or reuse existing ids!

-- If you want to edit an existing or add a new leaderboard, just append it to the SQL command and run flyway migrate.
-- Leaderboards are handled dynamically. You can add leaderboards and reference them from the matchmaker.

INSERT INTO `leaderboard` (id, initializer_id, technical_name, name_key, description_key) VALUES
(1,NULL,'global','leaderboard.global.name','leaderboard.global.description'),
(2,NULL,'ladder_1v1','leaderboard.ladder_1v1.name','leaderboard.ladder_1v1.description'),
(3,1,'tmm_2v2','leaderboard.tmm_2v2.name','leaderboard.tmm_2v2.description'),
(4,1,'tmm_4v4_full_share','leaderboard.tmm_4v4_full_share.name','leaderboard.tmm_4v4_full_share.description'),
(5,1,'tmm_4v4_share_until_death','leaderboard.tmm_4v4_share_until_death.name','leaderboard.tmm_4v4_share_until_death.description'),
(6,4,'tmm_3v3','leaderboard.tmm_3v3.name','leaderboard.tmm_3v3.description')
-- add new row above this comment (don't forget to append the comma to the previous one)
ON DUPLICATE KEY UPDATE
    initializer_id=VALUES(initializer_id),
    technical_name=VALUES(technical_name),
    name_key=VALUES(name_key),
    description_key=VALUES(description_key);
