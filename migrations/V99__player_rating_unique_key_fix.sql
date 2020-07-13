-- Due to Travis issues, the statements below are only run on production.
-- (They are not required on Travis anyway as the inconsistency only occurred in combination with a running lobby server)

-- CREATE TEMPORARY TABLE duplicates
-- (
--     id INT,
--     PRIMARY KEY (id)
-- ) ENGINE = MEMORY AS
-- SELECT r1.id
-- FROM leaderboard_rating AS r1
--          INNER JOIN leaderboard_rating AS r2 ON
--         r1.id != r2.id AND
--         r1.login_id = r2.login_id AND
--         r1.leaderboard_id = r2.leaderboard_id AND
--         r1.create_time > r2.create_time;
--
-- DELETE lr
-- FROM leaderboard_rating lr
-- INNER JOIN duplicates d ON lr.id = d.id;
--
-- DROP TEMPORARY TABLE duplicates;

ALTER TABLE leaderboard_rating ADD UNIQUE (login_id, leaderboard_id);
