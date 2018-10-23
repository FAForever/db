-- DUMMY DATA ONLY, FOR USE IN UNIT TESTS

DELETE FROM reported_user;
DELETE FROM moderation_report;
DELETE FROM teamkills;
DELETE FROM unique_id_users;
DELETE FROM uniqueid;
DELETE FROM global_rating;
DELETE FROM ladder1v1_rating;
DELETE FROM uniqueid_exempt;
DELETE FROM version_lobby;
DELETE FROM friends_and_foes;
DELETE FROM ladder_map;
DELETE FROM tutorial;
DELETE FROM map_version_review;
DELETE FROM map_version_reviews_summary;
DELETE FROM map_version;
DELETE FROM `map`;
DELETE FROM mod_version_review;
DELETE FROM mod_version_reviews_summary;
DELETE FROM mod_version;
DELETE FROM `mod`;
DELETE FROM mod_stats;
DELETE FROM oauth_clients;
DELETE FROM updates_faf;
DELETE FROM updates_faf_files;
DELETE FROM avatars;
DELETE FROM avatars_list;
DELETE FROM ban_revoke;
DELETE FROM ban;
DELETE FROM clan_membership;
DELETE FROM clan;
DELETE FROM game_player_stats;
DELETE FROM game_review;
DELETE FROM game_reviews_summary;
DELETE FROM game_stats;
DELETE FROM game_featuredMods;
DELETE FROM ladder_division_score;
DELETE FROM ladder_division;
DELETE FROM lobby_admin;
DELETE FROM name_history;
DELETE FROM group_permission_assignment;
DELETE FROM group_permission;
DELETE FROM user_group_assignment;
DELETE FROM user_group;
DELETE FROM login;
DELETE FROM email_domain_blacklist;

-- Login table
-- Most accounts get a creation time in the past so that they pass account
-- age check.
insert into login (id, login, email, password, create_time) values (1, 'test', 'test@example.com', SHA2('test_password', 256), '2000-01-01 00:00:00');
insert into login (id, login, email, password, create_time) values (2, 'Dostya', 'dostya@cybran.example.com', SHA2('vodka', 256), '2000-01-01 00:00:00');
insert into login (id, login, email, password, create_time) values (3, 'Rhiza', 'rhiza@aeon.example.com', SHA2('puff_the_magic_dragon', 256), '2000-01-01 00:00:00');
insert into login (id, login, email, password, create_time) values (4, 'No_UID', 'uid@uef.example.com', SHA2('his_pw', 256), '2000-01-01 00:00:00');
insert into login (id, login, email, password, create_time) values (5, 'postman', 'postman@postman.com', SHA2('postman', 256), '2000-01-01 00:00:00');
-- New accounts for testing account age check
insert into login (id, login, email, password) values (6, 'newbie', 'noob@example.com', SHA2('password', 256));
insert into login (id, login, email, password, steamid) values (7, 'steambie', 'steambie@example.com', SHA2('password', 256), 111111);
-- Test IPv6
insert into login (id, login, email, password, ip) values (8, 'ipv6', 'ipv6@example.com', SHA2('ipv6', 256), '0000:0000:0000:0000:0000:0000:127.127.127.127');

-- Name history
insert into name_history (id, change_time, user_id, previous_name) values
  (1, date_sub(now(), interval 12 month), 1, "test_maniac"),
  (2, date_sub(now(), interval 1 month), 2, "YoungDostya");

-- Permissions
insert into lobby_admin (user_id, `group`) values (1,2);

-- global rating
insert into global_rating (id, mean, deviation, numGames, is_active)
values
(1, 2000, 125, 5, 1),
(2, 1500, 75, 2, 1),
(3, 1650, 62.52, 2, 1);

-- ladder rating
insert into ladder1v1_rating (id, mean, deviation, numGames, is_active)
values
  (1, 2000, 125, 5, 1),
  (2, 1500, 75, 2, 1),
  (3, 1650, 62.52, 2, 1);

-- UniqueID_exempt
insert into uniqueid_exempt (user_id, reason) values (1, 'Because test');

-- UID Samples
INSERT INTO `uniqueid` (`hash`, `uuid`, `mem_SerialNumber`, `deviceID`, `manufacturer`, `name`, `processorId`, `SMBIOSBIOSVersion`, `serialNumber`, `volumeSerialNumber`)
VALUES ('some_id', '-', '-', '-', '-', '-', '-', '-', '-', '-'),
       ('another_id', '-', '-', '-', '-', '-', '-', '-', '-', '-');

-- Banned UIDs
insert into unique_id_users (user_id, uniqueid_hash) values (1, 'some_id');
insert into unique_id_users (user_id, uniqueid_hash) values (2, 'another_id');
insert into unique_id_users (user_id, uniqueid_hash) values (3, 'some_id');

-- Lobby version table
insert into version_lobby (id, `file`, version) values (1, 'some-installer.msi', '0.10.125');

-- Sample maps
insert into map (id, display_name, map_type, battle_type, author)
values
(1, 'SCMP_001', 'FFA', 'skirmish', 1),
(2, 'SCMP_002', 'FFA', 'skirmish', 1),
(3, 'SCMP_003', 'FFA', 'skirmish', 1),
(4, 'SCMP_004', 'FFA', 'skirmish', 1),
(5, 'SCMP_005', 'FFA', 'skirmish', 1),
(6, 'SCMP_006', 'FFA', 'skirmish', 2),
(7, 'SCMP_007', 'FFA', 'skirmish', 2),
(8, 'SCMP_008', 'FFA', 'skirmish', 2),
(9, 'SCMP_009', 'FFA', 'skirmish', 2),
(10, 'SCMP_010', 'FFA', 'skirmish', 3),
(11, 'SCMP_011', 'FFA', 'skirmish', 3),
(12, 'SCMP_012', 'FFA', 'skirmish', 3),
(13, 'SCMP_013', 'FFA', 'skirmish', 3),
(14, 'SCMP_014', 'FFA', 'skirmish', 3),
(15, 'SCMP_015', 'FFA', 'skirmish', 3);

insert into map_version (id, description, max_players, width, height, version, filename, hidden, map_id)
values
(1, 'SCMP 001', 8, 1024, 1024, 1, 'maps/scmp_001.zip', 0, 1),
(2, 'SCMP 002', 8, 1024, 1024, 1, 'maps/scmp_002.zip', 0, 2),
(3, 'SCMP 003', 8, 1024, 1024, 1, 'maps/scmp_003.zip', 0, 3),
(4, 'SCMP 004', 8, 1024, 1024, 1, 'maps/scmp_004.zip', 0, 4),
(5, 'SCMP 005', 8, 2048, 2048, 1, 'maps/scmp_005.zip', 0, 5),
(6, 'SCMP 006', 8, 1024, 1024, 1, 'maps/scmp_006.zip', 0, 6),
(7, 'SCMP 007', 8, 512, 512, 1, 'maps/scmp_007.zip', 0, 7),
(8, 'SCMP 008', 8, 1024, 1024, 1, 'maps/scmp_008.zip', 0, 8),
(9, 'SCMP 009', 8, 1024, 1024, 1, 'maps/scmp_009.zip', 0, 9),
(10, 'SCMP 010', 8, 1024, 1024, 1, 'maps/scmp_010.zip', 0, 10),
(11, 'SCMP 011', 8, 2048, 2048, 1, 'maps/scmp_011.zip', 0, 11),
(12, 'SCMP 012', 8, 256, 256, 1, 'maps/scmp_012.zip', 0, 12),
(13, 'SCMP 013', 8, 256, 256, 1, 'maps/scmp_013.zip', 0, 13),
(14, 'SCMP 014', 8, 1024, 1024, 1, 'maps/scmp_014.zip', 0, 14),
(15, 'SCMP 015', 8, 512, 512, 1, 'maps/scmp_015.zip', 0, 15),
(16, 'SCMP 015', 8, 512, 512, 2, 'maps/scmp_015.v0002.zip', 0, 15),
(17, 'SCMP 015', 8, 512, 512, 3, 'maps/scmp_015.v0003.zip', 0, 15);

insert into ladder_map (id, idmap) values
(1,1),
(2,2);

insert into game_featuredMods (id, gamemod, name, description, publish, git_url, git_branch, file_extension, allow_override)
values (1, 'faf', 'FAF', 'Forged Alliance Forever', 1, 'https://github.com/FAForever/fa.git', 'deploy/faf', 'nx2', FALSE),
       (6, 'ladder1v1', 'FAF', 'Ladder games', 1, 'https://github.com/FAForever/fa.git', 'deploy/faf', 'nx2', TRUE),
       (25, 'coop', 'Coop', 'Multiplayer campaign games', 1, 'https://github.com/FAForever/fa-coop.git', 'master', 'cop', TRUE);

insert into game_stats (id, startTime, gameName, gameType, gameMod, `host`, mapId, validity)
values (1, NOW(), 'Test game', '0', 6, 1, 1, 0);

insert into friends_and_foes (user_id, subject_id, `status`)
values(42, 56, 'FRIEND'),
      (42, 57, 'FOE');

insert into `mod` (id, display_name, author)
VALUES (1, 'test-mod', 'baz'),
       (2, 'test-mod2', 'baz'),
       (3, 'test-mod3', 'baz');

insert into mod_version (id, mod_id, uid, version, description, type, filename, icon) VALUES
        (1, 1, 'foo', 1, '', 'UI', 'foobar.zip', 'foobar.png'),
        (2, 1, 'bar', 2, '', 'SIM', 'foobar2.zip', 'foobar.png'),
        (3, 2, 'baz', 1, '', 'UI', 'foobar3.zip', 'foobar3.png'),
        (4, 3, 'EA040F8E-857A-4566-9879-0D37420A5B9D', 1, '', 'SIM', 'foobar4.zip', 'foobar4.png');

insert into mod_stats (mod_id, times_played, likers) VALUES
        (1, 0, ''),
        (2, 0, ''),
        (3, 1, '');

-- sample avatars
insert into avatars_list (id, url, tooltip) values
  (1, 'http://content.faforever.com/faf/avatars/qai2.png', 'QAI'),
  (2, 'http://content.faforever.com/faf/avatars/UEF.png', 'UEF');

insert into avatars (idUser, idAvatar, selected) values (2, 1, 0), (2, 2, 1);
insert into avatars (idUser, idAvatar, selected, expires_at) values (3, 1, 0, NOW());

-- sample bans
insert into ban(id, player_id, author_id, reason, level) values
  (1, 2, 1, 'Test permanent ban', 'GLOBAL'),
  (2, 3, 1, 'This test ban should be revoked', 'CHAT');
insert into ban(player_id, author_id, reason, level, expires_at) values
  (4, 1, 'This test ban should be expired', 'CHAT', NOW());
insert into ban_revoke (ban_id, reason, author_id) values
  (2, 'I want to show that you can revoke the ban, but keep the data', 1);

-- sample clans
insert into clan (id, name, tag, founder_id, leader_id, description) values
  (1, 'Alpha Clan', '123', 1, 1, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr'),
  (2, 'Beta Clan', '345', 4, 4, 'Sed diam nonumy eirmod tempor invidunt ut labore'),
  (3, 'Charlie Clan', '678', 2, 1, 'At vero eos et accusam et justo duo dolores et ea rebum');
insert into clan_membership (clan_id, player_id) values
  (1, 2),
  (1, 3),
  (2, 4),
  (3, 1);

-- sample oauth_client for Postman
insert into oauth_clients (id, name, client_secret, redirect_uris, default_redirect_uri, default_scope) VALUES
  ('3bc8282c-7730-11e5-8bcf-feff819cdc9f ', 'Downlord''s FAF Client', '{noop}6035bd78-7730-11e5-8bcf-feff819cdc9f', '', '', 'read_events read_achievements upload_map'),
  ('faf-website', 'faf-website', '{noop}banana', 'http://localhost:8020', 'http://localhost:8020', 'public_profile write_account_data create_user'),
  ('postman', 'postman', '{noop}postman', 'http://localhost https://www.getpostman.com/oauth2/callback', 'https://www.getpostman.com/oauth2/callback', 'read_events read_achievements upload_map upload_mod write_account_data');

insert into updates_faf (id, filename, path) values
    (1, 'ForgedAlliance.exe', 'bin'),
    (11, 'effects.nx2', 'gamedata'),
    (12, 'env.nx2', 'gamedata');

insert into updates_faf_files (id, fileId, version, name, md5, obselete) values
    (711, 1, 3658, 'ForgedAlliance.3658.exe', '2cd7784fb131ea4955e992cfee8ca9b8', 0),
    (745, 1, 3659, 'ForgedAlliance.3659.exe', 'ee2df6c3cb80dc8258428e8fa092bce1', 0),
    (723, 11, 3658, 'effects_0.3658.nxt', '3758baad77531dd5323c766433412e91', 0),
    (734, 11, 3659, 'effects_0.3659.nxt', '3758baad77531dd5323c766433412e91', 0),
    (680, 12, 3656, 'env_0.3656.nxt', '32a50729cb5155ec679771f38a151d29', 0);

insert into teamkills (teamkiller, victim, game_id, gametime) VALUE (1, 2, 1, 3600);

insert into game_review (id, text, user_id, score, game_id) VALUES (1, 'Awesome', 1, 5, 1);
insert into game_review (id, text, user_id, score, game_id) VALUES (2, 'Nice', 2, 3, 1);
insert into game_review (id, text, user_id, score, game_id) VALUES (3, 'Meh', 3, 2, 1);

insert into map_version_review (id, text, user_id, score, map_version_id) VALUES (1, 'Fine', 1, 3, 1);
insert into map_version_review (id, text, user_id, score, map_version_id) VALUES (2, 'Horrible', 2, 1, 1);
insert into map_version_review (id, text, user_id, score, map_version_id) VALUES (3, 'Boah!', 3, 5, 1);

insert into mod_version_review (id, text, user_id, score, mod_version_id) VALUES (1, 'Great!', 1, 5, 1);
insert into mod_version_review (id, text, user_id, score, mod_version_id) VALUES (2, 'Like it', 2, 4, 1);
insert into mod_version_review (id, text, user_id, score, mod_version_id) VALUES (3, 'Funny', 3, 4, 1);

INSERT INTO ladder_division VALUES
(1, 'League 1 - Division A', 1, 10.0),
(2, 'League 1 - Division B', 1, 30.0),
(3, 'League 1 - Division C', 1, 50.0),
(4, 'League 2 - Division D', 2, 20.0),
(5, 'League 2 - Division E', 2, 60.0),
(6, 'League 2 - Division F', 2, 100.0),
(7, 'League 3 - Division D', 3, 100.0),
(8, 'League 3 - Division E', 3, 200.0),
(9, 'League 3 - Division F', 3, 9999.0);

INSERT INTO ladder_division_score (season, user_id, league, score, games) VALUES
  (1, 1, 1, 9.5, 4),
(1, 2, 1, 49.5, 70),
(1, 3, 2, 0.0, 39),
(1, 4, 3, 10.0, 121);

INSERT INTO email_domain_blacklist VALUES ('spam.org');
