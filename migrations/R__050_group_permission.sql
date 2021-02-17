-- Repeatable migration: Flyway will replay this SQL every time this file (checksum) has changed!
-- You can not delete items by removing them from this file! Also make sure never to edit or reuse existing ids!

-- If you want to edit an existing or add a new permission, just append it to the SQL command and run flyway migrate.
-- The technical names of permissions are hardcoded in different places. Make sure the other systems are ready to use them.

INSERT INTO `group_permission` (id, technical_name, name_key) VALUES
(1,'READ_AUDIT_LOG','permission_group.read_audit_log'),
(2,'READ_TEAMKILL_REPORT','permission_group.read_teamkill_report'),
(3,'READ_ACCOUNT_PRIVATE_DETAILS','permission_group.read_account_private_details'),
(4,'ADMIN_ACCOUNT_NOTE','permission_group.admin_account_note'),
(5,'ADMIN_MODERATION_REPORT','permission_group.admin_moderation_report'),
(6,'ADMIN_ACCOUNT_BAN','permission_group.admin_account_ban'),
(7,'ADMIN_CLAN','permission_group.admin_clan'),
(8,'WRITE_COOP_MISSION','permission_group.write_coop_mission'),
(9,'WRITE_AVATAR','permission_group.write_avatar'),
(10,'WRITE_MATCHMAKER_POOL','permission_group.write_matchmaker_pool'),
(11,'WRITE_MATCHMAKER_MAP','permission_group.write_matchmaker_map'),
(12,'WRITE_EMAIL_DOMAIN_BAN','permission_group.write_email_domain_ban'),
(13,'ADMIN_VOTE','permission_group.admin_vote'),
(14,'WRITE_USER_GROUP','permission_group.write_user_group'),
(15,'READ_USER_GROUP','permission_group.read_user_group'),
(16,'WRITE_TUTORIAL','permission_group.write_tutorial'),
(17,'WRITE_NEWS_POST','permission_group.write_news_post'),
(18,'WRITE_OAUTH_CLIENT','permission_group.write_oauth_client'),
(19,'ADMIN_MAP','permission_group.admin_map'),
(20,'ADMIN_MOD','permission_group.admin_mod'),
(21,'WRITE_MESSAGE','permission_group.write_message'),
(22,'ADMIN_KICK_SERVER','permission_group.admin_kick_server'),
(23,'ADMIN_BROADCAST_MESSAGE','permission_group.admin_broadcast_message'),
(24,'ADMIN_JOIN_CHANNEL','permission_group.admin_join_channel')
-- add new row above this comment (don't forget to append the comma to the previous one)
ON DUPLICATE KEY UPDATE
    technical_name=VALUES(technical_name),
    name_key=VALUES(name_key);
