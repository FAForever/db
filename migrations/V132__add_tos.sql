create table terms_of_service
(
    version    smallint auto_increment,
    valid_from timestamp not null comment 'The start date when this ToS version is applied. May point into the future to prepare ToS changes.',
    content    text      not null comment 'Markdown formatted text',
    constraint terms_of_service_pk
        primary key (version)
);

create index terms_of_service_valid_from_index
    on terms_of_service (valid_from);

alter table login
    add accepted_tos smallint null comment 'Point to the last ToS the user has explicitely accepted',
    add constraint login_terms_of_service_version_fk
        foreign key (accepted_tos) references terms_of_service (version);