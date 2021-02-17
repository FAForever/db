CREATE VIEW map_version_statistics AS
  SELECT
    table_map_features.map_id       AS map_version_id,
    table_map_features.downloads    AS downloads,
    table_map_features.times_played AS plays,
    table_map_features.num_draws    AS draws
  FROM table_map_features;


CREATE VIEW map_statistics AS
  SELECT
    map_version.map_id                   AS map_id,
    SUM(table_map_features.downloads)    AS downloads,
    SUM(table_map_features.times_played) AS plays,
    SUM(table_map_features.num_draws)    AS draws
  FROM table_map_features
    JOIN map_version ON map_version.id = table_map_features.map_id
  GROUP BY map_version.map_id;
