DELETE FROM leaderboard_rating
WHERE leaderboard_rating.id IN (
    SELECT subq.id FROM (
        SELECT r1.id
        FROM leaderboard_rating AS r1
        INNER JOIN leaderboard_rating AS r2 ON
            r1.id != r2.id AND
            r1.login_id = r2.login_id AND
            r1.leaderboard_id = r2.leaderboard_id AND
            r1.create_time > r2.create_time
    ) as subq
);

ALTER TABLE leaderboard_rating ADD UNIQUE (login_id, leaderboard_id);
