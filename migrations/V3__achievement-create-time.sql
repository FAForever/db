ALTER TABLE achievement_definitions ADD create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE achievement_definitions ADD update_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Set to the date when achievements started working
update achievement_definitions set create_time = '2016-08-08T06:00', update_time = '2016-08-08T06:00';
