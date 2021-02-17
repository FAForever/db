-- Disable auto_increment ids for flyway-managed tables
-- Otherwise instead of updating a row when hitting a duplicate key constraint it creates a new row.

SET FOREIGN_KEY_CHECKS = 0;

alter table game_featuredMods modify id tinyint unsigned not null comment 'This table is managed by Flyway. Do not manually edit records.';
alter table group_permission modify id mediumint unsigned not null comment 'This table is managed by Flyway. Do not manually edit records.';
alter table leaderboard modify id smallint unsigned not null comment 'This table is managed by Flyway. Do not manually edit records.';
alter table matchmaker_queue modify id int unsigned not null comment 'This table is managed by Flyway. Do not manually edit records.';

SET FOREIGN_KEY_CHECKS = 1;
