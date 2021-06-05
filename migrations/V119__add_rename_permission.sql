INSERT INTO group_permission (technical_name, name_key) VALUES('ROLE_ADMIN_ACCOUNT_NAME_CHANGE', 'permission_group.admin_name_change');

-- Moderation councilor + global moderators
INSERT INTO group_permission_assignment (group_id, permission_id)
SELECT user_group.id, group_permission.id FROM user_group, group_permission
WHERE (user_group.technical_name = 'faf_moderators_global')
  AND group_permission.technical_name IN ('ROLE_ADMIN_ACCOUNT_NAME_CHANGE');

-- Server admins
INSERT INTO group_permission_assignment (group_id, permission_id)
SELECT user_group.id, group_permission.id FROM user_group, group_permission
WHERE user_group.technical_name = 'faf_server_administrators'
  AND group_permission.technical_name IN ('ROLE_ADMIN_ACCOUNT_NAME_CHANGE');