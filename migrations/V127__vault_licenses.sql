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

alter table map
    add license int null, -- nullability to be removed once all existing entries are migrated to undefined license
    add constraint map_license_id_fk
        foreign key (license) references license (id);

alter table `mod`
    add license int null, -- nullability to be removed once all existing entries are migrated to undefined license
    add constraint mod_license_id_fk
        foreign key (license) references license (id);
