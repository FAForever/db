alter table game_reviews_summary add (
    average_score float as (case when reviews = 0 then null
                                 else (score / reviews) end) virtual
);
create index game_rev_sum_avg_score_ix on game_reviews_summary(average_score);

alter table map_reviews_summary add (
    average_score float as (case when reviews = 0 then null
                                 else (score / reviews) end) virtual
);
create index map_rev_sum_avg_score_ix on map_reviews_summary(average_score);

alter table map_version_reviews_summary add (
    average_score float as (case when reviews = 0 then null
                                 else (score / reviews) end) virtual
);
create index map_version_rev_sum_avg_score_ix on map_version_reviews_summary(average_score);

alter table mod_reviews_summary add (
    average_score float as (case when reviews = 0 then null
                                 else (score / reviews) end) virtual
);
create index mod_rev_sum_avg_score_ix on mod_reviews_summary(average_score);

alter table mod_version_reviews_summary add (
    average_score float as (case when reviews = 0 then null
                                 else (score / reviews) end) virtual
);
create index mod_version_rev_sum_avg_score_ix on mod_version_reviews_summary(average_score);

