DROP TABLE IF EXISTS `updates_faf_git_commits`;

CREATE TABLE `updates_faf_git_commits` (
                                 `version` int(11) unsigned NOT NULL AUTO_INCREMENT,
                                 `commit_hash` char(40) NOT NULL,
                                 PRIMARY KEY (`version`),
                                 UNIQUE KEY `unique_commit_hash` (`commit_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='table representing the commit hash of the git repository for a given version';

DROP TABLE IF EXISTS `updates_faf_beta_git_commits`;

CREATE TABLE `updates_faf_beta_git_commits` (
                                           `version` int(11) unsigned NOT NULL AUTO_INCREMENT,
                                           `commit_hash` char(40) NOT NULL,
                                           PRIMARY KEY (`version`),
                                           UNIQUE KEY `unique_commit_hash` (`commit_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='table representing the commit hash of the git repository for a given version';

DROP TABLE IF EXISTS `updates_faf_develop_git_commits`;

CREATE TABLE `updates_faf_develop_git_commits` (
                                                `version` int(11) unsigned NOT NULL AUTO_INCREMENT,
                                                `commit_hash` char(40) NOT NULL,
                                                PRIMARY KEY (`version`),
                                                UNIQUE KEY `unique_commit_hash` (`commit_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='table representing the commit hash of the git repository for a given version';