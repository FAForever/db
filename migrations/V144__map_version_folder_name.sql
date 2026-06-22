-- Make the map folder name a real, indexable column.
--
-- Previously only `filename` (e.g. `maps/scmp_001.v0001.zip`) was stored, and the
-- API derived the folder name from it in-memory in a @PostLoad enricher. That made
-- `versions.folderName == X` filters impossible to push down to SQL, forcing a full
-- table scan + in-memory enrichment on every map lookup (~5s per request).
--
-- `folder_name` (e.g. `scmp_001.v0001`) becomes the source of truth. `filename` is
-- kept as a VIRTUAL generated column so external readers (faf-server, replay server)
-- and existing API clients continue to see the identical `maps/<folder>.zip` value.

-- 1. add the new source-of-truth column
ALTER TABLE map_version ADD COLUMN folder_name varchar(200) NULL AFTER filename;

-- 2. backfill, prefix/suffix-agnostic (mirrors the old Java extraction:
--    part after the last '/', up to '.zip')
UPDATE map_version
SET folder_name = SUBSTRING_INDEX(SUBSTRING_INDEX(filename, '/', -1), '.zip', 1);

-- 3. enforce constraints on the new column
ALTER TABLE map_version
  MODIFY folder_name varchar(200) NOT NULL,
  ADD UNIQUE KEY folder_name (folder_name);

-- 4. drop the old real filename column (drops its now-redundant UNIQUE key) and
--    re-add it as a VIRTUAL generated column (no storage, no index needed). Its
--    uniqueness is implied by the UNIQUE folder_name it is derived from.
ALTER TABLE map_version DROP COLUMN filename;
ALTER TABLE map_version
  ADD COLUMN filename varchar(200) AS (CONCAT('maps/', folder_name, '.zip')) VIRTUAL;
