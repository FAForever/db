-- The idea behind aggregating login logs was appealing to save some space.
-- However it causes trouble on counting failed attempts in window periods,
-- which would be an important metric to preemptively detect login attacks.
-- Another issue with the table was that the login_id was not null, which
-- does not detect brute force username guessing. Instead we now keep the
-- login string if no user id could be found.

drop table if exists login_log;

create table login_log
(
    id int unsigned auto_increment comment 'ID for API/Elide compatibility',
    login_id mediumint unsigned null,
    login_string varchar(100) default null comment 'In case of unknown login, the login name will be kept here',
    ip varchar(45) not null,
    success boolean not null,
    create_time timestamp default CURRENT_TIMESTAMP not null,
    constraint id primary key (id),
    constraint login_log_login_id_fk
        foreign key (login_id) references login (id) on update cascade on delete cascade
)
    comment 'Log of logins to discover login attack attempts. Has to be cleaned up by the services.';

create index login_log_ip_success_index on login_log (ip, success);
create index login_log_login_id_success_index on login_log (login_id, success);
