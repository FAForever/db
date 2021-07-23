-- MariaDB imports trip over generated columns, therefore we temporarily remove them
alter table avatars_list add url varchar(255) as (concat('https://content.faforever.com/faf/avatars/',`filename`));;
alter table global_rating add rating float as ((`mean` - (3 * `deviation`))) stored;
alter table ladder1v1_rating add rating float as ((`mean` - (3 * `deviation`))) stored;
alter table leaderboard_rating add rating float as ((`mean` - (3 * `deviation`))) stored;
