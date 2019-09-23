alter table group_permission
    change name technical_name varchar(100) not null comment 'hardcoded names to be used in code';
alter table group_permission
    add name_key varchar(100) not null comment 'name key of permission in translation table';

alter table user_group
    change name technical_name varchar(100) not null comment 'hardcoded names to be used in code';
alter table user_group
    add name_key varchar(100) not null comment 'name key of user group in translation table';