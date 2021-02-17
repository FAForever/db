-- Updates numGames and winGames on the ladder1v1_rating table based on
-- aggregated results from old ladder games.

-- NOTE: If running this manually, this query will increment the existing values,
-- it will not start from 0. Run V65__fix-ladder-win-ratio.sql first to
-- initialize the count correctly.
--
-- Old ladder games are ones that happened before the 'ladder1v1' game mode
-- was added. This means we need to identify them as best we can using other
-- properties:
--
--      Name: always 'Player1 Vs Player2'
--      Number of players: 2 (always human)
--      Color: red or blue (1 or 2)
--      Score: always 1 (win), 0 (loss), or -1 (draw or no result)
--      Start Time: Before the first 'ladder1v1' game
--
-- We perform the player count twice, once with additional filters and once
-- without in order to verify that there are exactly 2 players and they also
-- fullfill the additional requirements.

UPDATE ladder1v1_rating
INNER JOIN (
    SELECT
        count(score) numGames,
        sum(case when score = 1 then 1 else 0 end) winGames,
        game_player_stats.playerId playerId
    FROM game_stats
        INNER JOIN game_player_stats on game_stats.id = game_player_stats.gameId
    WHERE
        gameMod=0 AND
        startTime < '2014-03-22 12:59:25' AND
        gameName collate latin1_general_cs LIKE '% Vs %' AND
        (
            SELECT count(*) FROM game_player_stats
                WHERE gameId = game_stats.id
        ) = 2
        AND
        (
            SELECT count(*) FROM game_player_stats
                WHERE gameId = game_stats.id AND
                AI = 0 AND
                color IN (1, 2) AND
                score in (-1, 0, 1)
        ) = 2
    GROUP BY game_player_stats.playerId
) game_records
ON ladder1v1_rating.id = game_records.playerId
SET
    ladder1v1_rating.numGames = ladder1v1_rating.numGames + game_records.numGames,
    ladder1v1_rating.winGames = ladder1v1_rating.winGames + game_records.winGames
;
