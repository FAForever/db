/* Updates the ladder1v1_rating table based on how many total games and how many
 * wins each player has in the game_player_stats table. The server inserts ladder
 * game scores as 1 for win and 0 for everything else. At some point it used to
 * insert -1 as well (probably for draws).
 */

UPDATE ladder1v1_rating
INNER JOIN (
    SELECT
        count(score) numGames,
        sum(case when score = 1 then 1 else 0 end) winGames,
        game_player_stats.playerId playerId,
        login.login login
    FROM game_stats
        INNER JOIN game_player_stats on game_stats.id = game_player_stats.gameId
        INNER JOIN game_featuredMods on game_featuredMods.id = game_stats.gameMod
        INNER JOIN login on login.id = game_player_stats.playerId
    WHERE game_featuredMods.gamemod = 'ladder1v1'
    GROUP BY game_player_stats.playerId
) game_records
ON ladder1v1_rating.id = game_records.playerId
SET
    ladder1v1_rating.numGames = game_records.numGames,
    ladder1v1_rating.winGames = game_records.winGames
;
