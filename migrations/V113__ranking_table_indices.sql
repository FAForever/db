alter table global_rating_rank_view
	add constraint global_rating_rank_view_login_id_fk
		foreign key (id) references login (id);

alter table ladder1v1_rating_rank_view
	add constraint ladder1v1_rating_rank_view_login_id_fk
		foreign key (id) references login (id);
