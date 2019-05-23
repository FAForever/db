-- Drop foreign keys on varchar/uuid columns, otherwise the conversion to UTF8 fails
ALTER TABLE player_achievements
    DROP FOREIGN KEY fk_achievement;

ALTER TABLE unique_id_users
    DROP FOREIGN KEY FK_user_hash_to_uid;

ALTER TABLE achievement_definitions CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE avatars CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE avatars_list CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ban CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE clan CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE clan_membership CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE coop_leaderboard CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE coop_map CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE email_domain_blacklist CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE event_definitions CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE faction CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE featured_mods_owners CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE friends_and_foes CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE game_featuredMods CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE game_player_stats CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE game_review CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE game_reviews_summary CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE game_stats CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE game_validity CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE global_rating CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE group_permission CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE group_permission_assignment CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE game_review CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE jwt_users CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ladder1v1_rating CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ladder_division CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ladder_division_score CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE ladder_map CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE league CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE league_rating_range CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE league_schedule CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE lobby_admin CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE login CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE map CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE map_version CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE map_version_review CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE map_version_reviews_summary CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE messages CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `mod` CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE mod_stats CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE mod_version CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE mod_version_review CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE map_version_reviews_summary CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE moderation_report CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE name_history CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE oauth_clients CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE patchs_table CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE player_achievements CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE player_events CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE reported_user CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE swiss_tournaments CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE swiss_tournaments_players CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE table_map_comments CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE table_map_features CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE teamkills CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE tutorial CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE tutorial_category CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE tutorial_sections CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE tutorials CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE unique_id_users CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE uniqueid CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE uniqueid_exempt CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE user_group CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE user_group_assignment CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE user_notes CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE vm_exempt CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE vote CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE voting_answer CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE voting_choice CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE voting_question CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE voting_subject CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE winner_for_voting_question CONVERT TO character set utf8mb4 COLLATE utf8mb4_unicode_ci;

ALTER TABLE player_achievements
    ADD CONSTRAINT fk_achievement
        FOREIGN KEY (achievement_id) REFERENCES achievement_definitions (id);

ALTER TABLE unique_id_users
    ADD CONSTRAINT FK_user_hash_to_uid
        FOREIGN KEY (uniqueid_hash) REFERENCES uniqueid (hash);

