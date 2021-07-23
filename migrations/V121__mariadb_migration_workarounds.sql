-- MariaDB imports trip over generated columns, therefore we temporarily remove them
alter table avatars_list drop column url;
alter table global_rating drop column rating;
alter table ladder1v1_rating drop column rating;
alter table leaderboard_rating drop column rating;
