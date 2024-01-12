ALTER TABLE game_stats
  MODIFY `gameType` enum(
    '0',
    '1',
    '2',
    '3',
    'DEMORALIZATION',
    'DOMINATION',
    'ERADICATION',
    'SANDBOX',
    'DECAPITATION'
  ) NOT NULL;

UPDATE game_stats set `gameType` = 'DEMORALIZATION' where `gameType` = '0';
UPDATE game_stats set `gameType` = 'DOMINATION' where `gameType` = '1';
UPDATE game_stats set `gameType` = 'ERADICATION' where `gameType` = '2';
UPDATE game_stats set `gameType` = 'SANDBOX' where `gameType` = '3';

ALTER TABLE game_stats
  MODIFY `gameType` enum(
    'DEMORALIZATION',
    'DOMINATION',
    'ERADICATION',
    'SANDBOX',
    'DECAPITATION'
  ) NOT NULL;
