DROP VIEW IF EXISTS map_version_statistics;
CREATE VIEW map_version_statistics AS
  SELECT
    map_version.id                               AS map_version_id,
    COALESCE(table_map_features.downloads, 0)    AS downloads,
    COALESCE(table_map_features.times_played, 0) AS plays,
    COALESCE(table_map_features.num_draws, 0)    AS draws
  FROM map_version
    LEFT JOIN table_map_features ON table_map_features.map_id = map_version.id;

DROP VIEW IF EXISTS map_statistics;
CREATE VIEW map_statistics AS
  SELECT
    map_version.map_id                                AS map_id,
    COALESCE(SUM(table_map_features.downloads), 0)    AS downloads,
    COALESCE(SUM(table_map_features.times_played), 0) AS plays,
    COALESCE(SUM(table_map_features.num_draws), 0)    AS draws
  FROM map_version
    LEFT JOIN table_map_features ON map_version.id = table_map_features.map_id
  GROUP BY map_version.map_id;
