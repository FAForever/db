-- Contains only records from 2012/2013 and was superseded by Challonge
DROP TABLE swiss_tournaments_players;
DROP TABLE swiss_tournaments;

-- Matchmaker less than 30 games, might as well mark them as regular FAF
UPDATE game_stats SET gameMod = 0 WHERE gameMod = 26;
-- Now we can drop it as well
DELETE FROM game_featuredMods WHERE id = 26;

-- Cleanup featured mod updater tables that are long gone
DROP TABLE updates_supremeDestruction_files;
DROP TABLE updates_supremeDestruction;
DROP TABLE updates_engyredesign_files;
DROP TABLE updates_engyredesign;
DROP TABLE updates_wyvern_files;
DROP TABLE updates_wyvern;
DROP TABLE updates_matchmaker_files;
DROP TABLE updates_matchmaker;
