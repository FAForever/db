INSERT IGNORE INTO `oauth_clients` (`id`, `name`, `client_secret`, `client_type`, `redirect_uris`, `default_redirect_uri`, `default_scope`) VALUES
  ('postman', 'Postman', 'postman', 'public', 'https://www.getpostman.com/oauth2/callback', 'https://www.getpostman.com/oauth2/callback', 'public_profile read_events read_achievements upload_map upload_mod');
INSERT IGNORE INTO `oauth_clients` (`id`, `name`, `client_secret`, `client_type`, `redirect_uris`, `default_redirect_uri`, `default_scope`) VALUES
  ('83891c0c-feab-42e1-9ca7-515f94f808ef', 'Clan App', '83891c0c-feab-42e1-9ca7-515f94f808ef', 'public', '', '', 'public_profile');
INSERT IGNORE INTO `oauth_clients` (`id`, `name`, `client_secret`, `client_type`, `redirect_uris`, `default_redirect_uri`, `default_scope`) VALUES
  ('b12b21c9-7f65-11e7-87b2-0242ac110004', 'FAF Client', 'b288f3f9-7f65-11e7-87b2-0242ac110004', 'public', 'http://localhost https://localhost', 'http://localhost', 'read_events read_achievements upload_map upload_mod write_account_data');
