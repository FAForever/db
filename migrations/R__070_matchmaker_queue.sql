-- Repeatable migration: Flyway will replay this SQL every time this file (checksum) has changed!
-- You can not delete items by removing them from this file! Also make sure never to edit or reuse existing ids!

-- If you want to edit an existing or add a new matchmaker queue, just append it to the SQL command and run flyway migrate.
-- Matchmaker queues are handled dynamically. If they are enabled they will show up. (The map pool is managed by privileged users.)

INSERT INTO `matchmaker_queue` (id, technical_name, featured_mod_id, leaderboard_id, name_key, team_size, params, enabled) VALUES
(1,'ladder1v1',0,2,'matchmaker_queue.ladder1v1',1,NULL,1),
(2,'tmm2v2',0,3,'matchmaker_queue.tmm2v2.name',2,NULL,1),
(3,'tmm4v4_full_share',0,4,'matchmaker_queue.tmm4v4_full_share.name',4,NULL,1),
(4,'tmm4v4_share_until_death',0,5,'matchmaker_queue.tmm4v4_share_until_death.name',4,'{"GameOptions":{"Share":"ShareUntilDeath"}}',0)
(5,'tmm3v3',0,6,'matchmaker_queue.tmm3v3.name',3,NULL,0),
-- add new row above this comment (don't forget to append the comma to the previous one)
ON DUPLICATE KEY UPDATE
    technical_name=VALUES(technical_name),
    featured_mod_id=VALUES(featured_mod_id),
    leaderboard_id=VALUES(leaderboard_id),
    name_key=VALUES(name_key),
    team_size=VALUES(team_size),
    enabled=VALUES(enabled);
