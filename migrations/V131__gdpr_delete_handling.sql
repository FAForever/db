create table account_deletion_requests
(
    id           varchar(36)                                                   null comment 'random uuid (as it''s also used for lookup of state by user)',
    account_id   mediumint                                                     not null,
    state        enum ('NEW', 'IN_PROCESS', 'FINISHED', 'ERROR') default 'NEW' not null,
    full_delete  boolean                                                       not null comment 'full_delete=true means the whole account was deleted. This requires no games to be played.',
    processed_by mediumint                                                     null comment 'Refers to the admin manually processing. Should be null if automatically processed',
    comment      text                                                          null comment 'Allows manual comments for manual processing',
    created_at   timestamp                                                     null,
    updated_at   timestamp                                                     null,
    constraint account_deletion_requests_pk
        primary key (id),
    constraint account_deletion_requests_account_unique_key
        unique (account_id)
);
