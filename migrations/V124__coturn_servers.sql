create table coturn_servers
(
    id            int(11) unsigned       not null auto_increment,
    region        varchar(20)            not null comment 'Region of the server for simple user-based selection if latency checks don''t work',
    host          varchar(255)           not null,
    port          mediumint default 3478 not null,
    preshared_key varchar(255)           not null comment 'Should be only accessible to clients with lobby scope.',
    contact_email varchar(255)           not null comment 'Email of the responsible server administrator',
    active        boolean default true   not null,
    PRIMARY KEY(id),
    UNIQUE KEY `unique_host_port` (`host`, `port`)
)
    comment 'List of coturn servers to be propagated to ICE adapters';
