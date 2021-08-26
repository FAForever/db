alter table login
    add gog_id varchar(100) null comment 'Username on gog.com';

create unique index login_gog_id_uindex
    on login (gog_id);
