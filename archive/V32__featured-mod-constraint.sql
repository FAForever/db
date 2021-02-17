# Estimated script run time: 25min

# As voted for by Sheeo, Brutus5000, and Yenon, we delete games we no longer have featured mods for.
# Alternatively, we'd have to create dummy featuredMod entries.
DELETE FROM game_player_stats
WHERE gameId IN (SELECT id
                 FROM game_stats
                 WHERE gameMod NOT IN (SELECT id
                                       FROM game_featuredMods));

DELETE FROM game_stats
WHERE gameMod NOT IN (SELECT id
                      FROM game_featuredMods);

ALTER TABLE game_stats
  ADD CONSTRAINT game_stats_game_featuredMods_id_fk FOREIGN KEY (gameMod) REFERENCES game_featuredMods (id);
