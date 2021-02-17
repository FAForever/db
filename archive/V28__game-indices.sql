# Estimated script run time: 4min

CREATE INDEX game_stats_endTime_index ON game_stats (endTime DESC);
CREATE INDEX game_stats_gameMod_index ON game_stats (gameMod);
CREATE INDEX game_stats_gameName_index ON game_stats (gameName);
CREATE INDEX game_stats_gameType_index ON game_stats (gameType);
CREATE INDEX game_stats_mapId_index ON game_stats (mapId);
CREATE INDEX game_stats_validity_index ON game_stats (validity);

CREATE INDEX game_player_stats_AI_index ON game_player_stats (AI);
CREATE INDEX game_player_stats_faction_index ON game_player_stats (faction);
CREATE INDEX game_player_stats_scoreTime_index ON game_player_stats (scoreTime);
