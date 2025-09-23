alter table game_join_log
    add ip varchar(45) null after game_id;

create index game_join_log_game_id_player_id_index
    on game_join_log (game_id, player_id);

create index game_join_log_ip_player_id_index
    on game_join_log (ip, player_id);

create index game_join_log_player_id_ip_index
    on game_join_log (player_id, ip);

