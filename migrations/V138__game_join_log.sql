create table game_join_log
(
    id          BIGINT auto_increment
        primary key,
    player_id   mediumint unsigned     not null,
    game_id     int unsigned           not null,
    create_time datetime default now() not null,
    constraint game_join_log_login_id_fk
        foreign key (player_id) references login (id)
);
