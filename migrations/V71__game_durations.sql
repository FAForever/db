ALTER TABLE game_stats
  ADD replay_ticks INT UNSIGNED DEFAULT NULL
  COMMENT "The total number of ticks present in the replay. The SCFA tick rate is 10 ticks/second"
    AFTER endTime;
