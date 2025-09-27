alter table unique_id_users
    add id int auto_increment first,
    drop primary key,
    add constraint unique_id_users_pk
        primary key (id);
