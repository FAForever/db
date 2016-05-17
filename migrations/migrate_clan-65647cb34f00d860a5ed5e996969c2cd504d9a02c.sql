INSERT INTO clan_list (clan_id, create_date, status, clan_name, clan_tag, clan_founder_id, clan_leader_id, clan_desc)
SELECT clan_id, create_date, status, clan_name, clan_tag, clan_founder_id, (SELECT player_id FROM fafclans.clan_leader l WHERE l.clan_id = a.clan_id LIMIT 1) clan_leader_id, clan_desc 
FROM fafclans.clans_list a;

INSERT INTO clan_members (clan_id, player_id, join_clan_date)
SELECT clan_id, player_id, join_clan_date 
FROM fafclans.clan_members;

UPDATE clan_list a SET clan_founder_id = (SELECT faf_id FROM fafclans.players_list WHERE players_list.player_id = a.clan_founder_id LIMIT 1);

UPDATE clan_list a SET clan_leader_id = (SELECT faf_id FROM fafclans.players_list WHERE players_list.player_id = a.clan_leader_id LIMIT 1);
