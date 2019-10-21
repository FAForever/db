-- PUBLIC GROUPS --
INSERT INTO user_group (technical_name, name_key, public) VALUES ('faf_organisation', 'user_group.faf.organisation', 1);

SET @root_id = (SELECT id from user_group WHERE technical_name = 'faf_organisation');

-- The council

INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_councilor_administration', 'user_group.faf.councilor.administration', 1, @root_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_councilor_balance', 'user_group.faf.councilor.balance', 1, @root_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_councilor_devops', 'user_group.faf.councilor.devops', 1, @root_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_councilor_game', 'user_group.faf.councilor.game', 1, @root_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_councilor_maps_mods', 'user_group.faf.councilor.maps_mods', 1, @root_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_councilor_moderation', 'user_group.faf.councilor.moderation', 1, @root_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_councilor_player', 'user_group.faf.councilor.player', 1, @root_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_councilor_promotion', 'user_group.faf.councilor.promotion', 1, @root_id);

-- Balance councilor subgroups
SET @balance_id = (SELECT id from user_group WHERE technical_name = 'faf_councilor_balance');
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_balance_team', 'user_group.faf.balance_team', 1, @balance_id);

-- DevOps councilor subgroups
SET @devops_id = (SELECT id from user_group WHERE technical_name = 'faf_councilor_devops');
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_server_administrators', 'user_group.faf.server_administrators', 1, @devops_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_java_client', 'user_group.devs.java_client', 1, @devops_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_java_api', 'user_group.faf.devs.java_api', 1, @devops_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_java_lobby_server', 'user_group.faf.devs.java_server', 1, @devops_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_java_ice_adapter', 'user_group.faf.devs.java.ice_adapter', 1, @devops_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_python_client', 'user_group.faf.devs.python_client', 1, @devops_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_python_lobby_server', 'user_group.faf.devs.python_lobby_server', 1, @devops_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_python_replay_server', 'user_group.faf.devs.python_replay_server', 1, @devops_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_website', 'user_group.faf.devs.website', 1, @devops_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_unitdb', 'user_group.faf.devs.unitdb', 1, @devops_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_galactic_war', 'user_group.faf.devs.galactic_war', 1, @devops_id);

-- Game councilor subgroups
SET @game_id = (SELECT id from user_group WHERE technical_name = 'faf_councilor_game');
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_game_lua', 'user_group.faf.devs.game_lua', 1, @game_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_game_exe', 'user_group.faf.devs.game_exe', 1, @game_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_devs_game_coop', 'user_group.faf.devs.game_coop', 1, @game_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_testers_game_exe', 'user_group.faf.testers.game_exe', 1, @game_id);

-- Maps & Mods councilor subgroups
SET @mm_id = (SELECT id from user_group WHERE technical_name = 'faf_councilor_maps_mods');
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_mapper', 'user_group.faf.mapper', 1, @mm_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_modder', 'user_group.faf.modder', 1, @mm_id);

-- Moderation councilor subgroups
SET @mod_id = (SELECT id from user_group WHERE technical_name = 'faf_councilor_moderation');
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_moderators_global', 'user_group.faf.moderators.global', 1, @mod_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_moderators_discord', 'user_group.faf.moderators.discord', 1, @mod_id);

-- Player councilor subgroups
SET @pc_id = (SELECT id from user_group WHERE technical_name = 'faf_councilor_player');
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_tournament_directors', 'user_group.faf.tournament_directors', 1, @pc_id);

-- Promotion councilor subgroups
SET @promo_id = (SELECT id from user_group WHERE technical_name = 'faf_councilor_promotion');
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_casters', 'user_group.faf.casters', 1, @promo_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_streamer', 'user_group.faf.streamers', 1, @promo_id);
INSERT INTO user_group (technical_name, name_key, public, parent_group_id) VALUES ('faf_wiki_editors', 'user_group.faf.wiki_editors', 1, @promo_id);


-- ROLES --
INSERT INTO group_permission (technical_name, name_key) VALUES('READ_AUDIT_LOG', 'permission_group.read_audit_log');
INSERT INTO group_permission (technical_name, name_key) VALUES('READ_TEAMKILL_REPORT', 'permission_group.read_teamkill_report');
INSERT INTO group_permission (technical_name, name_key) VALUES('READ_ACCOUNT_PRIVATE_DETAILS', 'permission_group.read_account_private_details');
INSERT INTO group_permission (technical_name, name_key) VALUES('ADMIN_ACCOUNT_NOTE', 'permission_group.admin_account_note');
INSERT INTO group_permission (technical_name, name_key) VALUES('ADMIN_MODERATION_REPORT', 'permission_group.admin_moderation_report');
INSERT INTO group_permission (technical_name, name_key) VALUES('ADMIN_ACCOUNT_BAN', 'permission_group.admin_account_ban');
INSERT INTO group_permission (technical_name, name_key) VALUES('ADMIN_CLAN', 'permission_group.admin_clan');
INSERT INTO group_permission (technical_name, name_key) VALUES('WRITE_COOP_MISSION', 'permission_group.write_coop_mission');
INSERT INTO group_permission (technical_name, name_key) VALUES('WRITE_AVATAR', 'permission_group.write_avatar');
INSERT INTO group_permission (technical_name, name_key) VALUES('WRITE_MATCHMAKER_POOL', 'permission_group.write_matchmaker_pool');
INSERT INTO group_permission (technical_name, name_key) VALUES('WRITE_MATCHMAKER_MAP', 'permission_group.write_matchmaker_map');
INSERT INTO group_permission (technical_name, name_key) VALUES('WRITE_EMAIL_DOMAIN_BAN', 'permission_group.write_email_domain_ban');
INSERT INTO group_permission (technical_name, name_key) VALUES('ADMIN_VOTE', 'permission_group.admin_vote');
INSERT INTO group_permission (technical_name, name_key) VALUES('WRITE_USER_GROUP', 'permission_group.write_user_group');
INSERT INTO group_permission (technical_name, name_key) VALUES('READ_USER_GROUP', 'permission_group.read_user_group');
INSERT INTO group_permission (technical_name, name_key) VALUES('WRITE_TUTORIAL', 'permission_group.write_tutorial');
INSERT INTO group_permission (technical_name, name_key) VALUES('WRITE_NEWS_POST', 'permission_group.write_news_post');
INSERT INTO group_permission (technical_name, name_key) VALUES('WRITE_OAUTH_CLIENT', 'permission_group.write_oauth_client');
INSERT INTO group_permission (technical_name, name_key) VALUES('ADMIN_MAP', 'permission_group.admin_map');
INSERT INTO group_permission (technical_name, name_key) VALUES('ADMIN_MOD', 'permission_group.admin_mod');
INSERT INTO group_permission (technical_name, name_key) VALUES('WRITE_MESSAGE', 'permission_group.write_message');


-- ROLE ASSIGNMENTS --

-- Councilor common permissions
INSERT INTO group_permission_assignment (group_id, permission_id)
    SELECT user_group.id, group_permission.id FROM user_group, group_permission
    WHERE user_group.parent_group_id = @root_id
    AND group_permission.technical_name IN ('READ_AUDIT_LOG', 'WRITE_AVATAR', 'READ_USER_GROUP', 'WRITE_USER_GROUP', 'ADMIN_VOTE', 'WRITE_NEWS_POST', 'WRITE_MESSAGE');
    
-- Player councilor only
INSERT INTO group_permission_assignment (group_id, permission_id)
    SELECT @pc_id, group_permission.id FROM group_permission
    WHERE group_permission.technical_name IN ('WRITE_MATCHMAKER_MAP', 'WRITE_TUTORIAL', 'ADMIN_CLAN');

-- M&M councilor only
INSERT INTO group_permission_assignment (group_id, permission_id)
    SELECT @mm_id, group_permission.id FROM group_permission
    WHERE group_permission.technical_name IN ('ADMIN_MAP', 'ADMIN_MOD', 'WRITE_COOP_MISSION');

-- Moderation councilor + global moderators
INSERT INTO group_permission_assignment (group_id, permission_id)
    SELECT user_group.id, group_permission.id FROM user_group, group_permission
    WHERE (user_group.id = @mod_id or user_group.technical_name = 'faf_moderators_global')
    AND group_permission.technical_name IN ('READ_TEAMKILL_REPORT', 'READ_ACCOUNT_PRIVATE_DETAILS', 'ADMIN_ACCOUNT_NOTE', 'ADMIN_MODERATION_REPORT', 'ADMIN_ACCOUNT_BAN', 'WRITE_EMAIL_DOMAIN_BAN');

-- Server admins
INSERT INTO group_permission_assignment (group_id, permission_id)
    SELECT user_group.id, group_permission.id FROM user_group, group_permission
    WHERE user_group.technical_name = 'faf_server_administrators'
    AND group_permission.technical_name IN ('READ_AUDIT_LOG', 'READ_USER_GROUP', 'WRITE_USER_GROUP', 'WRITE_NEWS_POST', 'WRITE_MESSAGE');

-- Tournament directors
INSERT INTO group_permission_assignment (group_id, permission_id)
    SELECT user_group.id, group_permission.id FROM user_group, group_permission
    WHERE user_group.technical_name = 'faf_server_administrators'
    AND group_permission.technical_name IN ( 'WRITE_NEWS_POST', 'WRITE_AVATAR');
