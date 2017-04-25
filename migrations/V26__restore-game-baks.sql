# Estimated script run time: 8min

# -- Remove all games that have no host (host is non-null)
DELETE FROM game_stats_bak
WHERE host IS NULL;

-- Remove orphan player stats
DELETE FROM game_player_stats_bak
WHERE gameId NOT IN (SELECT id
                     FROM game_stats_bak);

-- Some games have gameMod == null, which is non-nullable, *probably* they played FAF.
update game_stats_bak set gameMod = (select id from game_featuredMods WHERE game_featuredMods.gamemod = 'faf');

-- Only a handful of entries have this
update game_stats_bak set gameType = '0' where gameType = '';

-- Restore all game stats from the "backup" table
INSERT INTO game_stats SELECT *
                       FROM game_stats_bak;

INSERT INTO game_player_stats SELECT *
                              FROM game_player_stats_bak;

drop table game_player_stats_bak;
drop table game_stats_bak;
