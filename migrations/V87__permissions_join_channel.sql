INSERT INTO group_permission (technical_name, name_key) VALUES('ADMIN_JOIN_CHANNEL', 'permission_group.admin_join_channel');

INSERT INTO group_permission_assignment (group_id, permission_id)
  SELECT user_group.id, group_permission.id 
  FROM user_group, group_permission
    WHERE 
      user_group.technical_name in (
        'faf_moderators_global', 
        'faf_server_administrators',
        'faf_tournament_directors'
      )
      AND group_permission.technical_name = 'ADMIN_JOIN_CHANNEL';

