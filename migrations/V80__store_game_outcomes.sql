ALTER TABLE game_player_stats
  ADD COLUMN result ENUM(
    'VICTORY', 'DEFEAT', 'DRAW', 'MUTUAL_DRAW', 'UNKNOWN', 'CONFLICTING'
  ) default 'UNKNOWN';
