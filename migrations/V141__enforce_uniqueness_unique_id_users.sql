-- Dropping the primary key in V140 unintentionally also removed the unique constraint on user_id and uniqueid_hash

alter table unique_id_users
    add constraint unique_id_users_pk
        unique (user_id, uniqueid_hash);