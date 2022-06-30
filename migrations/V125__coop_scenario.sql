create table coop_scenario
(
    id          mediumint(8) unsigned                                not null auto_increment,
    `order`     mediumint(8) unsigned                                not null,
    name        varchar(255)                                         not null,
    description text                                                 null,
    type        enum ('SC', 'SCFA', 'CUSTOM') default 'CUSTOM'       not null comment 'SC=vanilla Supreme Commander campaign, SCFA=Forged Alliance campaign, CUSTOM=community campaign',
    faction     enum ('UEF', 'CYBRAN', 'AEON', 'SERAPHIM', 'CUSTOM') not null comment 'Describes the faction to be played in the scenario. Custom means the user can select a faction.',
    PRIMARY KEY(id),
    UNIQUE KEY `unique_name` (`name`)
)
    comment 'A scenario is the parent of one or multiple related missions.';

alter table coop_map
    modify type tinyint unsigned not null comment 'deprecated, lookup parent scenario instead',
    add `order` mediumint(8) unsigned null,
    add scenario_id mediumint(8) unsigned null comment 'TODO: Make not null after migration',
    add constraint coop_map_coop_scenario_id_fk
        foreign key (scenario_id) references coop_scenario (id);
