ALTER TABLE game_featuredMods
  ADD file_extension VARCHAR(3) NULL,
  ADD allow_override BOOLEAN NULL COMMENT 'Whether overriding an existing version is allowed (1) or not (0).';
