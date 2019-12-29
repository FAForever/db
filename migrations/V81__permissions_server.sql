INSERT INTO group_permission (technical_name, name_key) VALUES('ADMIN_KICK_SERVER', 'permission_group.admin_kick_server');
INSERT INTO group_permission (technical_name, name_key) VALUES('ADMIN_BROADCAST_MESSAGE', 'permission_group.admin_broadcast_message');

-- Moderation councilor + global moderators
INSERT INTO group_permission_assignment (group_id, permission_id)
SELECT user_group.id, group_permission.id FROM user_group, group_permission
WHERE (user_group.technical_name = 'faf_moderators_global')
  AND group_permission.technical_name IN ('ADMIN_KICK_SERVER', 'ADMIN_BROADCAST_MESSAGE');

-- Server admins
INSERT INTO group_permission_assignment (group_id, permission_id)
SELECT user_group.id, group_permission.id FROM user_group, group_permission
WHERE user_group.technical_name = 'faf_server_administrators'
  AND group_permission.technical_name IN ('ADMIN_KICK_SERVER', 'ADMIN_BROADCAST_MESSAGE');

-- Correcting typo from V78
-- Tournament directors
INSERT INTO group_permission_assignment (group_id, permission_id)
SELECT user_group.id, group_permission.id FROM user_group, group_permission
WHERE user_group.technical_name = 'faf_tournament_directors'
  AND group_permission.technical_name IN ( 'WRITE_NEWS_POST');

DELETE from group_permission_assignment
    where group_id = (SELECT id from user_group where technical_name= 'faf_server_administrators')
    and permission_id = (SELECT id from group_permission where technical_name = 'WRITE_AVATAR');