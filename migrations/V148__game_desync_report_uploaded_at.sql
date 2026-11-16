-- Records when the desync report (the dump uploaded by the client through the API) of a player arrived in the object
-- storage, so reports can be filtered by their presence. NULL means no report has been uploaded.

ALTER TABLE game_desync
  ADD COLUMN report_uploaded_at DATETIME(3) NULL COMMENT 'time the player uploaded the desync report file, NULL if there is none';
