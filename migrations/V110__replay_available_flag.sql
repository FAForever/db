alter table game_stats
    add replay_available boolean default true not null comment 'If false, no replay is available for download.

There is no support from replay server yet. Workaround: Default value is set to true assuming all future replays get written properly. Once the replay server manages this flag properly, set it to false.';
