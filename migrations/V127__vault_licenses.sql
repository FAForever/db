create table license
(
    id              int          not null,
    name            varchar(255) not null,
    short_name      varchar(20)  not null,
    url             varchar(255) null,
    license_text    text         not null comment 'The full license text formatted in Markdown',
    active          boolean      not null comment 'Can this license be selected for new uploads?',
    revocable       boolean      not null comment 'Can the author revoke this license?',
    redistributable boolean      not null comment 'Are other users (apart from FAF) allowed to redistribute this asset?',
    modifiable      boolean      not null comment 'Are other users allowed to publish assets remixed, transformed, or built upon the material from this asset?',
    constraint license_pk
        primary key (id)
)
    comment 'Copyright licenses to be picked for uploaded content';

INSERT INTO `license` (id, name, short_name, url, license_text, active, revocable, redistributable, modifiable)
VALUES (1, 'Undefined', 'Undefined', null, 'Undefined', false, true, false, false);

alter table map
    add license int default 1,
    add constraint map_license_id_fk
        foreign key (license) references license (id);

-- Remove default value
alter table map
    modify license int not null;


alter table `mod`
    add license int default 1,
    add constraint mod_license_id_fk
        foreign key (license) references license (id);

-- Remove default value
alter table `mod`
    modify license int not null;
