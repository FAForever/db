-- Repeatable migration: Flyway will replay this SQL every time this file (checksum) has changed!
-- You can not delete items by removing them from this file! Also make sure never to edit or reuse existing ids!

-- If you want to edit an existing or add a new validity state, just append it to the SQL command and run flyway migrate.
-- Matching validities and their logic need to be hardcoded into the lobby server.
-- A list of all validity states is held here: https://github.com/FAForever/server/blob/develop/server/games/typedefs.py#L66

INSERT INTO `game_validity` (id, message) VALUES
(0,'Valid'),
(1,'Too many desyncs'),
(2,'Only assassination mode is ranked'),
(3,'Fog of war was disabled'),
(4,'Cheats were enabled'),
(5,'Prebuilt units were enabled'),
(6,'No rush was enabled'),
(7,'Unacceptable unit restrictions were enabled'),
(8,'An unacceptable map was used'),
(9,'Game was too short (probably had a technical fault early on)'),
(10,'An unacceptable mod was used'),
(11,'Coop is not ranked'),
(12,'The players mutually agreed to a draw'),
(13,'The game was single player'),
(14,'The game was FFA'),
(15,'The game had unbalanced teams'),
(16,'No results were reported by peers'),
(17,'Team were unlocked'),
(18,'More than two teams. XvXvX+ games cannot possibly be ranked, for the same reason that FFA cannot'),
(19,'The game has at least one AI'),
(20,'Civilians were revealed'),
(21,'Difficulty was wrong'),
(22,'Expansion was disabled'),
(23,'Team spawn was not fixed'),
(24,'Unranked for another reason'),
(25,'Unranked by host')

-- add new row above this comment (don't forget to append the comma to the previous one)
ON DUPLICATE KEY UPDATE
                     message=VALUES(message);
