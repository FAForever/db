ALTER TABLE game_stats
  CHANGE `gameType` `gameType` enum(
    'DEMORALIZATION',
    'DOMINATION',
    'ERADICATION',
    'SANDBOX',
    'DECAPITATION'
  ) NOT NULL;
