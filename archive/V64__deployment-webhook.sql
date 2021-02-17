alter table game_featuredMods
	add deployment_webhook text null comment 'A webhook to be called after successfull deployment';
